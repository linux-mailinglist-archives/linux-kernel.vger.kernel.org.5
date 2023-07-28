Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE3F767430
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjG1SES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjG1SEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:04:16 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C763C21
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:04:15 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4039a42467fso15931591cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690567454; x=1691172254;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hsd4ZqBI4xP964JP2IzxDEKVHRiOs6KK7KEA7coO+NA=;
        b=FCnfKzOBu2qoAXdB9XtZdunKOn0MXAkA8dVhWdgztvF8+bk55rb2XWixkZkU7PdcsJ
         OmCSkxh7GUyEPw7WUm+vNQ+8nsh9v14HoBFlflB+9ENNAfruHQBlSr/Ls43dm0lMCnwY
         gMhGlZkWucdeUpkjPpyctbNMKMnZ0Rre+DuSCvGVmnwu19kPzpj6mduy6wjgGr7sA+Am
         zpXqqwyctg9X/l0u9SV1jmIpIpyV19Lm83rFgTwlW1gsZTVaUxPbLqvYU7lnfhtZTCT6
         ckK8pL9KWL9qh2ztqGl8c1+KAOlLert0kr++PQ/qo6LLGfdrfmjBPvZ8RanIIeeX++Yq
         Hh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690567454; x=1691172254;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsd4ZqBI4xP964JP2IzxDEKVHRiOs6KK7KEA7coO+NA=;
        b=jNFfNPr4Pf1e1RtcVS0ZvfEEcKxapGyRA3FzQWwbaI/0nn4VIdfeWWO3tJXrme5+Ak
         zWoWvzPzVba3RSbxxYNEIjnuqwIA5+gSLzC86URnpOJiIuEkHd0DHxUKVbdHIUxpJFjX
         tFIcTxxjkwNVIZUBGjIRfFOTHmFTbqTdmq025ul3paZsDf1Y0O1RatXX+/0ixiMQvwVM
         wg8UZou4t+WJOgHfUvU3fWE+1igzU2epir5ywVWTz8Zkgaz5HxxHEpdXQeUHt5E0FfFJ
         5cY6mMR87FopQjqvsIf0B4pfrekKJ2gHnIWrS7y3Pze2vQB63jCbqf5r34bGAJEGCzqc
         UVNQ==
X-Gm-Message-State: ABy/qLZ789uR7pmFhjHCY1qiIKAfcQZbAdemeuK9ENRjk7uRx01TmCJC
        Ne/AwwL2NpuSzRIi7rYFGmPK
X-Google-Smtp-Source: APBJJlEfucS+oqyxym3lpoCo7YMNUtBvCVTqxi1ndAHarmCd/6cnSqEprEaHC4ysRCYLKccaEeO2VQ==
X-Received: by 2002:ac8:7f56:0:b0:403:fcd9:963 with SMTP id g22-20020ac87f56000000b00403fcd90963mr4002198qtk.67.1690567454121;
        Fri, 28 Jul 2023 11:04:14 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id i16-20020ac84890000000b0040554ed322dsm1303332qtq.62.2023.07.28.11.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 11:04:13 -0700 (PDT)
Date:   Fri, 28 Jul 2023 14:04:12 -0400
Message-ID: <375a357fce825c3d6b6d32e7a6396c62.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selinux: log about VM being executable by default
References: <20230728150150.16224-1-cgzones@googlemail.com>
In-Reply-To: <20230728150150.16224-1-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> In case virtual memory is being marked as executable by default, SELinux
> checks regarding explicit potential dangerous use are disabled.
> 
> Inform the user about it.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2:
>    shorten message as suggested by Paul
> ---
>  security/selinux/hooks.c | 2 ++
>  1 file changed, 2 insertions(+)

Merged into selinux/next, thanks.

--
paul-moore.com
