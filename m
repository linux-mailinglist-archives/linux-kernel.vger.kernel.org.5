Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0F77D5F13
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 02:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344743AbjJYAaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 20:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344718AbjJYAaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 20:30:15 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC45410E0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:30:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso260315b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 17:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698193812; x=1698798612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yiGBchuBAWV4UdaNqAqp/OW8eIkIliqczAGndCUHeX4=;
        b=hK2ejIUogxY6Q2SKGHpszonmJ4/xeAL1NuLO7rDGYGawrCu+xGkvb/XkpUwhQb4Y64
         cSzHmWVH05RXdgySQLdvSTvNTIIKkc5F9MVx0iTYCPnn9WftWULHEo7RBJmGXijXfhRR
         qeswt4Jy3pI+eR2oG9avHJcyhfCRCSmYuQF6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698193812; x=1698798612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiGBchuBAWV4UdaNqAqp/OW8eIkIliqczAGndCUHeX4=;
        b=DA5r7IA7iNP+20wOPn0SPL0554OnqGvqpfrVZTECuxfPblndaN9xODM/3Li28DgeBJ
         sLlB/CCFI+Sf1YWoXCxKKWsv3QRcPW6feqEoS8G/WqAu0Kj2wnLy0Iq/VJzNytyGDInk
         oKZ8J9aE7HRHQrLp4rfKzongIm4mUrnCuO/6GCYEopLiDG1SUGEucXTQfiKYJx/IxAQe
         ViuOBKUCfD+nFDYa0JNUtNrdtxsP/WzWADu5Jsj5CzB/LFZ063MPx+Jr9vek304ZBpTM
         OqqC6vT4ZINK0F9iQqUG6D1QGFAxtpiZgtPfdWIKgDJfBT9VMNIx+GRz9epSnQ2xcpd3
         Odag==
X-Gm-Message-State: AOJu0YyVBeyLZ8wt4f9HrwkdJigRxXtJLjJP0k6wHRhhVZdAFxxstxxZ
        KiK4haI08owjRmCiZ6TtNTgIGQ==
X-Google-Smtp-Source: AGHT+IFxp+JzhxcUoVKHvslrPps8Dw4oEec667yj2IQDPVIScvroTp5bGUX0pzhx54mNHPlMRJFIAA==
X-Received: by 2002:aa7:900b:0:b0:692:6417:728a with SMTP id m11-20020aa7900b000000b006926417728amr20734036pfo.14.1698193812121;
        Tue, 24 Oct 2023 17:30:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z21-20020aa79f95000000b0069323619f69sm8400317pfr.143.2023.10.24.17.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 17:30:11 -0700 (PDT)
Date:   Tue, 24 Oct 2023 17:30:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: ch: replace deprecated strncpy with strscpy
Message-ID: <202310241729.1740ED4F@keescook>
References: <20231023-strncpy-drivers-scsi-ch-c-v1-1-dc67ba8075a3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-strncpy-drivers-scsi-ch-c-v1-1-dc67ba8075a3@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 08:20:14PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> These labels get copied out to the user so lets make sure they are
> NUL-terminated and NUL-padded.
> 
> vparams is already memset to 0 so we don't need to do any NUL-padding
> (like what strncpy() is doing).
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's also opt to use the more idiomatic strscpy() usage of:
> (dest, src, sizeof(dest)) as this more closely ties the destination
> buffer to the length.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, these all look correct. I can confirm the open-coded "16" matches
the now-used sizeof().

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/scsi/ch.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
> index cb0a399be1cc..2b864061e073 100644
> --- a/drivers/scsi/ch.c
> +++ b/drivers/scsi/ch.c
> @@ -659,19 +659,23 @@ static long ch_ioctl(struct file *file,
>  		memset(&vparams,0,sizeof(vparams));
>  		if (ch->counts[CHET_V1]) {
>  			vparams.cvp_n1  = ch->counts[CHET_V1];
> -			strncpy(vparams.cvp_label1,vendor_labels[0],16);
> +			strscpy(vparams.cvp_label1, vendor_labels[0],
> +				sizeof(vparams.cvp_label1));
>  		}
>  		if (ch->counts[CHET_V2]) {
>  			vparams.cvp_n2  = ch->counts[CHET_V2];
> -			strncpy(vparams.cvp_label2,vendor_labels[1],16);
> +			strscpy(vparams.cvp_label2, vendor_labels[1],
> +				sizeof(vparams.cvp_label2));
>  		}
>  		if (ch->counts[CHET_V3]) {
>  			vparams.cvp_n3  = ch->counts[CHET_V3];
> -			strncpy(vparams.cvp_label3,vendor_labels[2],16);
> +			strscpy(vparams.cvp_label3, vendor_labels[2],
> +				sizeof(vparams.cvp_label3));
>  		}
>  		if (ch->counts[CHET_V4]) {
>  			vparams.cvp_n4  = ch->counts[CHET_V4];
> -			strncpy(vparams.cvp_label4,vendor_labels[3],16);
> +			strscpy(vparams.cvp_label4, vendor_labels[3],
> +				sizeof(vparams.cvp_label4));
>  		}
>  		if (copy_to_user(argp, &vparams, sizeof(vparams)))
>  			return -EFAULT;
> 
> ---
> base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
> change-id: 20231023-strncpy-drivers-scsi-ch-c-23b1cdac43cc
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook
