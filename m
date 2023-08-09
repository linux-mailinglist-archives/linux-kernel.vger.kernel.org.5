Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA754776CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjHIXH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjHIXHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:07:47 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71CC10DE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 16:07:46 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-56ce936f7c0so280046eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 16:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691622466; x=1692227266;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mtPLJiP6DMr4DwSGpK6Vu8RbB7GcE1b1Ftked7NInf0=;
        b=DrkqdXs/Uv/gQ3VfuLbrkNdbdP92xP0LEtzSB2kVmBCoYs1wwFUClgyutMR0kt8A9C
         gnqP/aXlxKE01srqM8JTvAmZw0QgAGs9flr6yhNJjiZu8K02Lr/8K1tZ4lKmi/sNFBFd
         M1Zg5j/q3hp2y59gQHMyZosBfkNOqT7U2Sgz2rsmK5qUDWRbYVEw46AltsTXq0z05jdf
         A2HkznWyKE8wIFIHzmPBYn9a1Eud69E3u2s/m1nhq/Nw3I0GliC+MWPkUQhp6MKYBedo
         qFZR+9ysVvaBbaUgZpmn7StWJwcPes35MrdKu9z+r5OVcoMCRnJvZN1tcgXtqP3DBiMZ
         LXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691622466; x=1692227266;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtPLJiP6DMr4DwSGpK6Vu8RbB7GcE1b1Ftked7NInf0=;
        b=SJxHhH/JAub/vK6FdT/iF5t6vSpPIb/Xbym3ZCERDqVoZAbUkqZR3612WtIq5n1F6m
         k6tNMXobVBfRVKxR//ca0/+er3rrek1vWu9gQsHshdWJRsGy2MPObWDED35YLRK/Etpl
         ZnIMA/6cVpeg8uUww8tzGoKK5SoDahysIwMgjIqyQNK7zPrqTbokrqaX9FY5j1an4emN
         1GILz5IXiyWKjmUD604pW+fyvKgm1xdaH9DigdNkqXOyLyEWumW7e4f6awpZIMqvyCmr
         o532pWBPyVkquGJVwvQ4sR89qPqiyWXwdk+EwxpdEL0MI1UC4RvsLMB8p1MuntAaPrsd
         obhA==
X-Gm-Message-State: AOJu0YynqUKeaj9ovgTH2imH0yJ2zfGISNLPqQL7HGOn5a54ypu9VNXD
        K+Ws3qyAuIN0zVHbbmgqZDip
X-Google-Smtp-Source: AGHT+IF1tVZiSqduk0d0b1BAiKtmBZ/Ch6dNtvCVA9CJP4c05rqTaEoZeCFwosThdcTmtkKgA8KX9w==
X-Received: by 2002:a05:6808:ab2:b0:3a1:eccc:26da with SMTP id r18-20020a0568080ab200b003a1eccc26damr795386oij.25.1691622466135;
        Wed, 09 Aug 2023 16:07:46 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id i8-20020a0c9c88000000b0063d7740b5d2sm26183qvf.46.2023.08.09.16.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:07:45 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:07:45 -0400
Message-ID: <ce4baf8a868a0e8d508eb7c9499a5328.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] selinux: avoid implicit conversions in policydb  code
References: <20230807171143.208481-5-cgzones@googlemail.com>
In-Reply-To: <20230807171143.208481-5-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug  7, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use the identical type for local variables, e.g. loop counters.
> 
> Declare members of struct policydb_compat_info unsigned to consistently
> use unsigned iterators.  They hold read-only non-negative numbers in the
> global variable policydb_compat.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v3:
>   - use unsigned int instead of u32 for iterators where the loop bound
>     is known at compile time and small (<100)
>     /@Paul: keep u32 iterator in policydb_destroy() due to
>     /  for (i = 0; i < p->p_types.nprim; i++)
>     /
>   - drop not mentioned protocol and port checks regarding out of range
>     values; there are a couple more of them and those changes are
>     suitable for a different patchset
> v2:
>   - avoid declarations in init-clauses of for loops
>   - declare members of struct policydb_compat_info unsigned
> ---
>  security/selinux/ss/policydb.c | 69 ++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 32 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
