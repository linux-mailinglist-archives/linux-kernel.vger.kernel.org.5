Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A01277A5BF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 11:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjHMJHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 05:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHMJHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 05:07:46 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D1810FA
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 02:07:49 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6873a30d02eso2253745b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 02:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691917668; x=1692522468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d65Zp1fO+sS6zDFevVKDTGRQcdP0qjzf6vC/p9wFTJ0=;
        b=Tcdw5N24g1tDgXxkcTSs+LuUVcsDw3C3LQ42Yk2p3GgvThHRRMo5cCP8R8zdjIYutI
         9KtTETA7cd4GLu9/uNTdNesxbMW5xr4y6pzA0NEtygFu2y3PosFsX5iDienOUKNK5qwA
         /Is1FdGyCDN0Qe9PMo7LThVNrGpTQ448mle1PcHSvCS9SL6IzIYT9p8MbXW2m0F5IYmc
         1iz9SAmjDF61R1UIVIGmNSvAKTT9WoN0gJqJS2IgmsUphR7wKTPDBETtfJBalqMWtxHQ
         sxQ4cAdGa/DlnBtcKDm2n7nAsjmT4B8wdGC3/+1NInxpGL1BLznIYddAmZYO+/rLioig
         Q5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691917668; x=1692522468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d65Zp1fO+sS6zDFevVKDTGRQcdP0qjzf6vC/p9wFTJ0=;
        b=Q+b0hWPt1Wa/ccxCrcsd5xGvaDPtptgYkT7iF0KcoOmLqvCyS3yw5Lgfq2LbjTU6OI
         lJ7zetIyb+9mmZ6jcHYNSDjNADUSDC2vyEKbsT8/ZzoMGBCGxowT2oVz1XG3iKPfG6pg
         il43jCyeveC/+e9knE3VLFwqqkvXMpwSSOz0J3ldgUeUpipYcJvZGG0cPl3mWW/EdcKl
         reAzDxRei2PV2GL0x8PJaq/PdRbmX7lYfHY1bYkOMj/NQpQLzWJYaHajJWfZgNv+WQBs
         cIoqiRRDj7c4mxPV5WjeHAVq0PZf2xwV0OmJOLtcP0ifKvVPXlfN4PawZUYnloe/t4bV
         OGBQ==
X-Gm-Message-State: AOJu0YxMaGxJBYG9jE1Y5kmdweoM7g2c8F/pS7/N2e+JbITXPrPWkxwf
        xe3GHLFnfQnLwn2fIgk5oyE=
X-Google-Smtp-Source: AGHT+IEdoPp4YeKukTzQaCY70yQb4+FyIgZPF/rmxhek0pwTMyjg/kP4WQ4vTc5Y8LqpY6lS/UKlLA==
X-Received: by 2002:a05:6a20:3d29:b0:140:6979:2952 with SMTP id y41-20020a056a203d2900b0014069792952mr6997664pzi.47.1691917668338;
        Sun, 13 Aug 2023 02:07:48 -0700 (PDT)
Received: from [10.0.2.15] ([103.37.201.173])
        by smtp.gmail.com with ESMTPSA id n12-20020aa7904c000000b00688214cff65sm2390014pfo.44.2023.08.13.02.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 02:07:47 -0700 (PDT)
Message-ID: <88c258bd-3d0c-de79-b411-6552841eb8d0@gmail.com>
Date:   Sun, 13 Aug 2023 14:37:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND] fs/befs: fix shift-out-of-bounds in befs_check_sb
To:     salah.triki@gmail.com, luisbg@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com
References: <20230801155823.206985-1-ghandatmanas@gmail.com>
Content-Language: en-US
From:   Manas Ghandat <ghandatmanas@gmail.com>
In-Reply-To: <20230801155823.206985-1-ghandatmanas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a friendly ping :)

On 01/08/23 21:28, Manas Ghandat wrote:
> The consistency check for the block_size by using the block_shift caused
> integer overflow. Thus a max limit to the block_shift was defined named
> BEFS_MAX_BLOCK_SHIFT in befs.h. Also check for the block_shift was added
> so that overflow does not occur.
>
> Reported-by: syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com
>
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> ---
>   fs/befs/befs.h  |  2 +-
>   fs/befs/super.c | 11 +++++++++++
>   2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/fs/befs/befs.h b/fs/befs/befs.h
> index 7cd47245694d..5490024adb33 100644
> --- a/fs/befs/befs.h
> +++ b/fs/befs/befs.h
> @@ -13,7 +13,7 @@
>   
>   /* used in debug.c */
>   #define BEFS_VERSION "0.9.3"
> -
> +#define BEFS_MAX_BLOCK_SHIFT 31
>   
>   typedef u64 befs_blocknr_t;
>   /*
> diff --git a/fs/befs/super.c b/fs/befs/super.c
> index 7c50025c99d8..f2aeb2ed6e77 100644
> --- a/fs/befs/super.c
> +++ b/fs/befs/super.c
> @@ -88,6 +88,17 @@ befs_check_sb(struct super_block *sb)
>   		return BEFS_ERR;
>   	}
>   
> +	/*
> +	 * block_shift check added so that overflow does not
> +	 * occur during the block_size check
> +	 */
> +
> +	if (befs_sb->block_shift > BEFS_MAX_BLOCK_SHIFT) {
> +		befs_error(sb, "block_size too large. "
> +			   "Corruption likely.");
> +		return BEFS_ERR;
> +	}
> +
>   	/*
>   	 * block_shift and block_size encode the same information
>   	 * in different ways as a consistency check.
