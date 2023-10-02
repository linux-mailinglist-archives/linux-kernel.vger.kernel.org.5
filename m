Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D937B59BE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbjJBSFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238702AbjJBSFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:05:20 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D759AD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:05:16 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5859d13f73dso2109177a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696269915; x=1696874715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UzW0YVguzNw7sySoEGaMr3yWzidp8N0IwGPJ49IGe8U=;
        b=YRoYavZYeCPNp9Tp8RUruIaoht2DPbUFG5v5tuGTbBOnK9CUbJ3lKpdNRr6Sl93Nnp
         wbByOMHspc2cU1VbhiCYx8xlVZdqOdqajIa/W06wMWR8Cb8uZDdiAzaR0LoF13rNDbEL
         uuRe4XgUX3mGurXAEmFJbmmufH6er5Q3RW75U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269915; x=1696874715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzW0YVguzNw7sySoEGaMr3yWzidp8N0IwGPJ49IGe8U=;
        b=GNZFzrPpxWfmB6lThdID17sEAZP4vQlNNDs4NQ8dA5WLpyz8duhzqx9CJexa5GZvzV
         edKSYO7kw83yO203E0Cjz3468FYm0cMWU7thr8Fj13oAFlSQC2HE+4tns0YJse2SFGQo
         zU7l7om6MFxj7GC+B43p9lgEHti6kTIgtk5OvsH3kp1wkhRoaFqBShOmObBXGwiC4Mib
         AIRRuExnS7uJWlOyCAWOZMpXmX8+f4m/0WQ6PbZQDDB3jzKor/qXtU/rM5v/8kRiBf3r
         psO7ZE25cDbU5CoUvEMZHiVnnbEyCXR8pZt0ODjLdx1bD2qkFBnid3O78AoiRCtaUfPz
         EcVA==
X-Gm-Message-State: AOJu0YwTSHXBjcmC6eXKiWMG5UyL2jUIQ+IpbJogS1+BO/oEoeogib7j
        WJSmvC7TPg9TuUSSRgNrfIuvjQ==
X-Google-Smtp-Source: AGHT+IH/MouaVnR9EdrEnIBcyIKUEno0+AsWLhGW19SNRxdiN+LbRG2ox56FkU8qF8Zj8mpmHLzHwA==
X-Received: by 2002:a05:6a20:560b:b0:163:ab2b:bddd with SMTP id ir11-20020a056a20560b00b00163ab2bbdddmr4702632pzc.27.1696269915513;
        Mon, 02 Oct 2023 11:05:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902740c00b001c62b9a51c0sm13314483pll.103.2023.10.02.11.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:05:15 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:05:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drivers: misc: ti-st: replace deprecated strncpy with
 strscpy
Message-ID: <202310021104.30D14A206F@keescook>
References: <20230927-strncpy-drivers-misc-ti-st-st_kim-c-v1-1-29bbdeed1a2c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-strncpy-drivers-misc-ti-st-st_kim-c-v1-1-29bbdeed1a2c@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 06:17:34AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect both `kim_data->dev_name` and `kim_gdata->dev_name` to be
> NUL-terminated.
> 
> `kim_data->dev_name` seems to not require NUL-padding.
> 
> `kim_gdata` is already zero-allocated and as such does not require
> NUL-padding:
> |       kim_gdata = kzalloc(sizeof(struct kim_data_s), GFP_KERNEL);
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
>  drivers/misc/ti-st/st_kim.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
> index fe682e0553b2..a034b5d8b585 100644
> --- a/drivers/misc/ti-st/st_kim.c
> +++ b/drivers/misc/ti-st/st_kim.c
> @@ -590,7 +590,7 @@ static ssize_t store_dev_name(struct device *dev,
>  {
>  	struct kim_data_s *kim_data = dev_get_drvdata(dev);
>  	pr_debug("storing dev name >%s<", buf);
> -	strncpy(kim_data->dev_name, buf, count);
> +	strscpy(kim_data->dev_name, buf, count);

This is again the early truncation issue. This should use
sizeof(kim_data->dev_name). "buf" will be %NUL terminated already.

>  	pr_debug("stored dev name >%s<", kim_data->dev_name);
>  	return count;
>  }
> @@ -751,7 +751,8 @@ static int kim_probe(struct platform_device *pdev)
>  	}
>  
>  	/* copying platform data */
> -	strncpy(kim_gdata->dev_name, pdata->dev_name, UART_DEV_NAME_LEN);
> +	strscpy(kim_gdata->dev_name, pdata->dev_name,
> +		sizeof(kim_gdata->dev_name));

This looks correct.

>  	kim_gdata->flow_cntrl = pdata->flow_cntrl;
>  	kim_gdata->baud_rate = pdata->baud_rate;
>  	pr_info("sysfs entries created\n");
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230927-strncpy-drivers-misc-ti-st-st_kim-c-e1663a211a0c
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
