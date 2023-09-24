Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B70E7AC685
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 05:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjIXDnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 23:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXDnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 23:43:16 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8932109
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:43:09 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c4e38483d2so144120a34.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 20:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695526989; x=1696131789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=seBNO35I6t27+aW9cJIbrOKykhwY8CBfF73TPyxAkzU=;
        b=EDFXaiYkSd1bB8l0T5fa8bmSbpBIrk1zJeZoev6LOoy0s0jSOIXjiJtr+XPk517mCe
         vW8k3VAizHB85g+A8uuCFlJtOPhHO55Z3Ilsqw46eFFernrVTPXTQ42bEn6sS9HDganI
         5ZJxuRwCRizbTpOZ/jBfOfHyaA86KqFaUoNYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695526989; x=1696131789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seBNO35I6t27+aW9cJIbrOKykhwY8CBfF73TPyxAkzU=;
        b=QBiFsTtxbXQtGATmjoGeYmSYpfOztHVHpQMeZNzB0MUCearDKibYHatSHHNuxOCg1W
         pBWzQ46muF7QNb0HiaOoh/7D6TwDqiiWmv2honICyKo8/lMbUGFMIb+fdymdC7az8fXf
         C71w9LsX/vWAmu8R0uqugb81bKaq7FSwUnR9x+Pe0AJOILc1cAcHSExWHv06/opngfkP
         H1iE8yJ7lOYq7iOjin240fpQFsBmFS24pPW9sZbQMlTNZ6G2IlYvnMmTYeCwNtXZ7LbG
         AF/a5k4CIVSS9XsKfTooV9Sd8w/B+Lc44fceJizKEP8H/0Plk/Io1RCIsEwdYgXgcM3p
         nx1A==
X-Gm-Message-State: AOJu0Yz/3LSTN7OxXyHAAx6PCVYbsXGPTQiasSTeOYoHzbPiNdaYimDM
        yiLpvkuiWeZIY4/L2IvgLQjQ3w==
X-Google-Smtp-Source: AGHT+IE2/HgUIEM6nD5lxm0qSmNTG5hyr9cbCU3gawGphubnH/fGhDM5TcuGczSqA2L3/1x/UlkG6A==
X-Received: by 2002:a05:6358:41a3:b0:143:9f18:d71a with SMTP id w35-20020a05635841a300b001439f18d71amr3868238rwc.14.1695526989027;
        Sat, 23 Sep 2023 20:43:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a199700b002694fee879csm8008047pji.36.2023.09.23.20.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 20:43:08 -0700 (PDT)
Date:   Sat, 23 Sep 2023 20:43:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] leds: lp3952: replace deprecated strncpy with strscpy
Message-ID: <202309232039.979F3B4@keescook>
References: <20230922-strncpy-drivers-leds-leds-lp3952-c-v1-1-4941d6f60ca4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922-strncpy-drivers-leds-leds-lp3952-c-v1-1-4941d6f60ca4@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 03:27:17PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `dest` to be NUL-terminated due to its use with dev_err.
> 
> lp3952_get_label()'s  dest argument is priv->leds[i].name:
> |    acpi_ret = lp3952_get_label(&priv->client->dev, led_name_hdl[i],
> |                                priv->leds[i].name);
> ... which is then assigned to:
> |    priv->leds[i].cdev.name = priv->leds[i].name;
> ... which is used with a format string
> |    dev_err(&priv->client->dev,
> |            "couldn't register LED %s\n",
> |            priv->leds[i].cdev.name);
> 
> There is no indication that NUL-padding is required but if it is let's
> opt for strscpy_pad.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/leds/leds-lp3952.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/leds-lp3952.c b/drivers/leds/leds-lp3952.c
> index 3bd55652a706..62ade3f05a87 100644
> --- a/drivers/leds/leds-lp3952.c
> +++ b/drivers/leds/leds-lp3952.c
> @@ -101,7 +101,7 @@ static int lp3952_get_label(struct device *dev, const char *label, char *dest)
>  	if (ret)
>  		return ret;
>  
> -	strncpy(dest, str, LP3952_LABEL_MAX_LEN);
> +	strscpy(dest, str, LP3952_LABEL_MAX_LEN);

Given my desire to use sizeof(dest) for these things, I wonder if it'd
be nicer to pass more context here for the compiler as the only user of
this function is the immediately next function. Instead of passing in
"char *dest", it could pass "struct lp3952_led_array *priv", and
suddenly sizeof() would be possible.

But, since it's technically correct as-is:

struct lp3952_ctrl_hdl {
        struct led_classdev cdev;
        char name[LP3952_LABEL_MAX_LEN];

There's no pressing need to actually do the priv refactor. It's just a
comment on the coding style of the original code. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  	return 0;
>  }
>  
> 
> ---
> base-commit: 2cf0f715623872823a72e451243bbf555d10d032
> change-id: 20230922-strncpy-drivers-leds-leds-lp3952-c-666fcfabeebd
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
