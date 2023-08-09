Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D40776C97
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjHIXHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHIXHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:07:43 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84324E72
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 16:07:42 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40849e69eb5so1627301cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 16:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691622461; x=1692227261;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ftckZL31GeKECcX0U6jMawLvlmm2ONkMUEDYz+ycfxA=;
        b=Cwnb7SxfXEHNI8OHrEMZHuifuhEFHRSr+NFN9uS6HJda3ZvcH6QSP4Ri3ytH91wych
         X0sU/uVjx46iWmdlqX9zOkrLQc02UpLw15UZdKMnMq06V/ASDu8eFCoYLe8dndKHsLWm
         AnxI6svOOnfeDaK3fCYjFygbBf+caGhTzepbg905VPZJuBYLb/MCbaHOfbgIOd8QJK7p
         qsqPYHNnwYMM67gOYxg+Vp6uCP00BqSdnEnRhURJv45n0/qHHZ/oadzcko4nlT0AErZ8
         eUzwsfyWxOk2eQ+Ipyvm+A7WNBwhuWt7aiWvW4Ze6InoG7GKXKdiHql74mtH96fdQn+R
         4rLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691622461; x=1692227261;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftckZL31GeKECcX0U6jMawLvlmm2ONkMUEDYz+ycfxA=;
        b=fMIjY20ezwdb93KJQ8VX9WqWTcRdCXBiioG35qJmPIVyyGjHIPS50qgFaYO+qLDDDv
         4lBXQgm4sn1AUeZd769SSHEuSXcTY3tailbdeaqAKxT+PHZfF1DzWbZrRF7GtONZIjx2
         JXEVNOpJPPY+0Bwr3d4Nq2vTgXXWsdoicLLs9HDW3J5jBiN/RcM88KKzxj9iEtJu+kJH
         4qgWnwcF0uyrC65b7avhF4XSdAYtopEZ0cRQPDRyBRxjbsVfMNxK/Sd9tl1mTc+22+d7
         +g1wDFCDxMaA1BjEzS9nr80S5PMs3LHOtSKf63SUuoxJOCt+oKag/P9s/rF4nIUw9uKU
         OxnA==
X-Gm-Message-State: AOJu0YxtYs7up29YneC+Mk4gMYZL6PQCb14taNANg0tN9caKhiZZ+VU4
        ZYu50rub5Q+eNpSY6mNqeNXJ
X-Google-Smtp-Source: AGHT+IFQGQI0zvmK54Wk9FNpHspX8SYcUm9mLvtc9S9BqAL0j2OhVljJ1pF0HGZckJweLqa9r5d4Fw==
X-Received: by 2002:ac8:5b0d:0:b0:3f9:a6ad:e734 with SMTP id m13-20020ac85b0d000000b003f9a6ade734mr1127980qtw.3.1691622461689;
        Wed, 09 Aug 2023 16:07:41 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id jj6-20020a05622a740600b0040c72cae9f9sm64964qtb.93.2023.08.09.16.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:07:41 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:07:40 -0400
Message-ID: <685c8157bd45fa7dbdadd8583d882489.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] selinux: avoid implicit conversions in avtab code
References: <20230807171143.208481-7-cgzones@googlemail.com>
In-Reply-To: <20230807171143.208481-7-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug  7, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Return u32 from avtab_hash() instead of int, since the hashing is done
> on u32 and the result is used as an index on the hash array.
> 
> Use the type of the limit in for loops.
> 
> Avoid signed to unsigned conversion of multiplication result in
> avtab_hash_eval() and perform multiplication in destination type.
> 
> Use unsigned loop iterator for index operations, to avoid sign
> extension.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v3:
>   - use fixed sized counters in avtab_hash_eval()
>   - perform multiplication in avtab_hash_eval() in destination type
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/ss/avtab.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
