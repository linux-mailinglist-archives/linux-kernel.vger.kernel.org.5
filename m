Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD67758808
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjGRWCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjGRWBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:40 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4FF1BF3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:25 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7659c6cae2cso421817485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717684; x=1692309684;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IGKUUeN2n3dLjiGz+5O+JqepftZ1VAcXJq+8NvA1EVE=;
        b=RbnJ+IOHqbT2TKTtSBpBMW4C0ByTCzV1VRxozZEvAF108KeOgc556eXV4TwKq2DYzf
         UbBygsD0+0WVPEnnMdoHq3nn1j/Q3B8JWIcMJWZY4YSH1hJ92aRHTEZMhdwx85KBvnJr
         +A3oLeLTQBJMSVvtp8/s7pg90W8xZZKtos6AF1qRG4MwiihX1lx+qbu5/IVmWuosya7j
         sZToCvuYx+NsakyogzHDaJzMtnyOAwSI7KrgAgC0IeayAlCkMUGFC1wS2IEh+gdEwYtM
         PBuWcCJ2HdythI6WxD+4ca5SnwwN1rHrjKz00Am/qrKhvwAnoKBVyMLl9vnuyzd0vSBy
         VaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717684; x=1692309684;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGKUUeN2n3dLjiGz+5O+JqepftZ1VAcXJq+8NvA1EVE=;
        b=UVr3vu/85fyyLTSIwlMajvfWynN7mUm+IYzr1aqTRakgssZUqIOg6eLUyn0aNkyQd8
         HVaValjCZWcq0eGkoqPlJTpBag5DWYtfFbeLMk02j/CAJfpCSsCJuVnrFa2XqBryJ3YO
         MP9bgLO4cRsqQ8wBsDqcfMrHCJVMlwHRqJSx3P8B1kWZF9VxOwhSUCSu4oO3gKqePc8u
         hYdjYXr1pd13OH+G8ouNZGHUUprAtdhBBC+JS837+jr6TrChvcEpMQvZTA8vw71ELLSJ
         HdNM+dkLZoJWsolZIVz/Q4q6jh/ROC77blwAjqrDt9LP6iJyrarjXjQYuv8AwFufWqtx
         UQSA==
X-Gm-Message-State: ABy/qLaVOymNk/HWb17Xazkhro5QKXALlgW177ycJmFJYI1zv9S9DiIF
        vMxZeSKuvoPevl45C6Dk48K7
X-Google-Smtp-Source: APBJJlGjV50daVlpT3yTfxIAcW4s0P80KMTU0/gPNhojY4VuQk2MuZSJVt9IVzRSm9ZIL+hBbsktLA==
X-Received: by 2002:a0c:f201:0:b0:62f:eb99:edc with SMTP id h1-20020a0cf201000000b0062feb990edcmr776824qvk.6.1689717684321;
        Tue, 18 Jul 2023 15:01:24 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id q10-20020a0ce20a000000b0062b35b691cdsm121280qvl.93.2023.07.18.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:24 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:23 -0400
Message-ID: <7301f8baddb16f3e9e06a27172d6cecd.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 13/20] selinux: selinuxfs: avoid implicit conversions
References: <20230706132337.15924-13-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-13-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use umode_t as parameter type for sel_make_inode(), which assigns the
> value to the member i_mode of struct inode.
> 
> Use identical type for loop iterator.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/selinuxfs.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

No declaration of iterators inside loops please.

--
paul-moore.com
