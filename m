Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0641758804
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjGRWCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjGRWBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:01:39 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63E31BDB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:23 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-403a1d7d60fso47819021cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717682; x=1692309682;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HJdB/tckdsw1C9JSuGoRZk4dEKtmzYTAAI0Lzw0ckzw=;
        b=BwN2cFWCHh2NX1g8x4fq1pPqcjxWBBGRoPqK8sSu9fYwpACAinG65Ua/ErMWA401Kx
         WpjubZJDAwaquKSQZTzL9tIiY9IuUo1IjXXIphx/GiANa+eok9rRcmj02RhnDnVf37AW
         zC1ggW//kuR2T/ZlnqBZwTHmzgS3jGf4MjQbfyBZ800/DsmHzd2Hizc7hluHBDWpY96g
         w6ALZbOvjmoa/YuqGXB/RdTXYYTA6orF8dodgD8F7o7YFVxo24rj1GVQK/XqBmAMQlGO
         Tb1T8Xjk0dBI9OT6d4JteJeD4pxU8SNqWUpqj8wrdiAP9rfPsJ3l2Yq+8IvKKQBl1u7e
         iBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717682; x=1692309682;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJdB/tckdsw1C9JSuGoRZk4dEKtmzYTAAI0Lzw0ckzw=;
        b=LTJV28KTU+dRDLiiPwLmRou+pvxMCO0hdY0AAZI8MTqlaWBlRV28JlenLnPZRqaeoe
         WL9l8oOEtWu5L5KKicldvp8WTCyfklTJZ6UzCNnI01xOoFr8Cjm3BmhTWDUFEh9ub8lW
         8dQijbNNJt9FcpIxSIofZvcm+kB4QG44RJV1bPfQHQQcyyco0L/HfkU+t/rNd+GQElpX
         jAIuwasjL682prWGmyhkoHu6jk8MDOHGzihbKlGG9xxzd3QZbRwVAd5xB2fut2W16lhh
         ad2rxuC/HFps43mHRYKs0uog7NoUFenvevpEXPEt2Tk7XBc4Oju3euDrYxlWVY8cyU6k
         Cd/Q==
X-Gm-Message-State: ABy/qLbSdNJpGqt4ML4gfrkLofX6iM1hjcL3kpTWcIJB6Y0nOiI3Xv6C
        UJe43MPrPxrvy0vEeEsh2E8v
X-Google-Smtp-Source: APBJJlFZKd3MZ4X8+GBML5T1tSXA9fr1iOheaptzr1M5TlZfDED6hMg9lSFU1+s15annHM/c95amNg==
X-Received: by 2002:ac8:5f83:0:b0:404:e64:f5ad with SMTP id j3-20020ac85f83000000b004040e64f5admr1247007qta.47.1689717682607;
        Tue, 18 Jul 2023 15:01:22 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ew13-20020a05622a514d00b00403b1fb1f48sm925936qtb.17.2023.07.18.15.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:22 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:21 -0400
Message-ID: <3232876554476c0f52c3da75d9e21555.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 11/20] selinux: avc: avoid implicit conversions
References: <20230706132337.15924-11-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-11-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use a consistent type of u32 for sequence numbers.
> 
> Use a non-negative and input parameter matching type for the hash
> result.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/avc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

...

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 1074db66e5ff..cd55479cce25 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -654,9 +654,9 @@ static void avc_audit_pre_callback(struct audit_buffer *ab, void *a)
>  {
>  	struct common_audit_data *ad = a;
>  	struct selinux_audit_data *sad = ad->selinux_audit_data;
> -	u32 av = sad->audited;
> +	u32 av = sad->audited, perm;
>  	const char *const *perms;
> -	int i, perm;
> +	u32 i;

Technically the perm type change doesn't fit with the description, but
it's minor enough that it shouldn't be an issue.

Merged into selinux/next.

>  	audit_log_format(ab, "avc:  %s ", sad->denied ? "denied" : "granted");
>  
> @@ -833,7 +833,8 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 xperm, u32 ssid,
>  			   struct extended_perms_decision *xpd,
>  			   u32 flags)
>  {
> -	int hvalue, rc = 0;
> +	u32 hvalue;
> +	int rc = 0;
>  	unsigned long flag;
>  	struct avc_node *pos, *node, *orig = NULL;
>  	struct hlist_head *head;
> -- 
> 2.40.1

--
paul-moore.com
