Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D01F7CEC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjJRXqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJRXqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:46:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA47CFA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:46:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c9b1e3a809so50929815ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697672789; x=1698277589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3v1rhi+yKtok5E46TzBIftVhW1iXBs0xE9buXjfaVnI=;
        b=lwH0JzFHtMMa+2pD9EDGoYQLPpua1jrlyu94Ll4kNXAxnTk27UN6vsWJMwdUJuWT5b
         SCj+201ECpXk8GA+Qcklj02ZJyMUnlcTV0P1fBOcrSt7TqnmI3Hc7wyLSY87lZmrzGDd
         yjIsazmpitZedKc16KcWGfAQTRJ8dUtIWxkaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697672789; x=1698277589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v1rhi+yKtok5E46TzBIftVhW1iXBs0xE9buXjfaVnI=;
        b=PGmXxdQm2T9O2Sd9+A/cJ/cJmf1yHAE4Zd0duZatnjRjpPQIErOeBPWVgRmg0JiexX
         VHrxX0zpY/Zin3VpLvn39/M5te3CtwcTO1/7VdMmFjtPwxpU1+Uvf98jj0NRtj6BDy3O
         e+z53r9INm4/DbhNX70eBiGRzlmXccrGSKRqIfK48B8OXWefAdz5QkVXWUnWjmiIqtVK
         dF2TkmveOgPP3eS5LJnXu4/I0iDHFLx8ecD7sjO6DjQAwp3UPPr84PVC1Jd1R16tTlCC
         77t0VBo286cY8dpLzxiH22ZO2a/C8pA5WiK9/aVWSSPhoNpXHuKFQ//sCrj2U/VNJWFf
         bQgQ==
X-Gm-Message-State: AOJu0YxdBnt/UCXQ5Tar6w3kTqXpVf/9Eb3OtqXjrpBovMZ0TfqTzoc+
        aR9iQXQu/65hK7/EyGzxmcw6oA==
X-Google-Smtp-Source: AGHT+IFp6P8pqIxvXv4Y1V94ikCTA6ZBwWNCz2ZyYtPkXdFvATMca6D7EmktS1Sfy3E+tpGKb9S5Yw==
X-Received: by 2002:a17:903:32d2:b0:1c3:5f05:922a with SMTP id i18-20020a17090332d200b001c35f05922amr930264plr.60.1697672789354;
        Wed, 18 Oct 2023 16:46:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l21-20020a170902d35500b001c736370245sm506840plk.54.2023.10.18.16.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:46:28 -0700 (PDT)
Date:   Wed, 18 Oct 2023 16:46:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] atmel: replace deprecated strncpy/strcpy with strscpy
Message-ID: <202310181643.47D7231BF5@keescook>
References: <20231016-strncpy-drivers-net-wireless-atmel-atmel-c-v1-1-038d0e73c402@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-strncpy-drivers-net-wireless-atmel-atmel-c-v1-1-038d0e73c402@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:22:45PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces. strcpy() is also deprecated [2] and shouldn't be used.

Since these are read-only const C strings being copied into a fixed
sized buffer, I would actually prefer to just leave these as-is since
they're already getting verified by FORTIFY_SOURCE.

> We expect priv->firmware_id to be NUL-terminated based on its usage
> with seq_printf() and strlen() in atmel.c:
> 1420 |       seq_printf(m, "%s loaded by host\n", priv->firmware_id);
> ...
> 3884 |       if (strlen(priv->firmware_id) == 0) {
> 
> NUL-padding is not required, which is evident by the usage of a plain
> strcpy():
> 3891 |   strcpy(priv->firmware_id, "atmel_at76c502.bin");
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Let's also replace hard-coded lengths to be `sizeof(...)` for buffers
> that the compiler can detect the size for as this is less error prone.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [2]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [3]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/net/wireless/atmel/atmel.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/atmel/atmel.c b/drivers/net/wireless/atmel/atmel.c
> index 7c2d1c588156..199b9144ef63 100644
> --- a/drivers/net/wireless/atmel/atmel.c
> +++ b/drivers/net/wireless/atmel/atmel.c
> @@ -2011,7 +2011,7 @@ static int atmel_get_name(struct net_device *dev,
>  			  union iwreq_data *wrqu,
>  			  char *extra)
>  {
> -	strcpy(wrqu->name, "IEEE 802.11-DS");
> +	strscpy(wrqu->name, "IEEE 802.11-DS", sizeof(wrqu->name));
>  	return 0;
>  }
>  
> @@ -2651,8 +2651,7 @@ static int atmel_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
>  
>  		priv->firmware = new_firmware;
>  		priv->firmware_length = com.len;
> -		strncpy(priv->firmware_id, com.id, 31);
> -		priv->firmware_id[31] = '\0';
> +		strscpy(priv->firmware_id, com.id, sizeof(priv->firmware_id));

I wonder why this ever used strncpy -- they're both 32 byte buffer
arrays. Regardless, yup, this looks correct to me. Can you respin
without the strcpy() changes?

-Kees

>  		break;
>  
>  	case ATMELRD:
> @@ -3889,7 +3888,8 @@ static int reset_atmel_card(struct net_device *dev)
>  					printk(KERN_INFO
>  					       "%s: if not, use the firmware= module parameter.\n",
>  					       dev->name);
> -					strcpy(priv->firmware_id, "atmel_at76c502.bin");
> +					strscpy(priv->firmware_id, "atmel_at76c502.bin",
> +						sizeof(priv->firmware_id));
>  				}
>  				err = request_firmware(&fw_entry, priv->firmware_id, priv->sys_dev);
>  				if (err != 0) {
> 
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231016-strncpy-drivers-net-wireless-atmel-atmel-c-7ca951cf7cfa
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
