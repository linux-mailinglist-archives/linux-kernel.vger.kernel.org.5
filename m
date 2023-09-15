Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C519E7A14D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 06:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjIOEhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 00:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjIOEhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:37:38 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0395D270C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:37:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so15484915ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694752652; x=1695357452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lud7J0kQvKKVpUJfUwiDxIroUbqIAEqeTTjdBEz5LAE=;
        b=HyK5FtHkPTo72Z3h5Yg/eOa/OPfTG5u3mhniwm6m/yGQjt11mjjjemwGHUt5nd3P4V
         +ZYj42/gn8ozOpV6EXQXUjMzfK1YNB/rcbf0ilBKZL5DlsCRqqSlJd5yXm+17MpIBmsH
         gjWZhef92Iqr6ydkNXapcr7yjmqtJgnX9QnKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694752652; x=1695357452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lud7J0kQvKKVpUJfUwiDxIroUbqIAEqeTTjdBEz5LAE=;
        b=cfhHkDciHOI1TSR4wPg4kXX7Wf74dOfAxJ7mKfrpmlBEN2dcLKjxOuYW5ZYGYNp/B3
         tV7fGH0UUleeWInSsQA/xlXxB3FH0pnIIgh+n8sMhBPsBdXwFRHWnUdKV7QSmXmSqHAh
         p89j7cSIwxVL3sB3zlpfdmtLJIpRL3nzOTKbxf+cOsuVY2Nd0y5jdksSUzGfU1dsA+vZ
         tlDjeq7r7Hu8ToxowuBs11kS93ghA4UK/9w5uCuG4wZ68WfiZW/fU9LtZFm0/7CE0o8s
         0xnFI7UNafbT2N1+EbQctpgyvYi49ITHUYuxs1vKV2jRU74/5CqD+pDlC52P7WMYvfCU
         E7nA==
X-Gm-Message-State: AOJu0YzIk5QUFZT1ZZjrOSKdNNwYauH7iact+Q0zbkpoJlDuUHClBep3
        mB5gs1jXMwofZ+YaJBHLoOSCzg==
X-Google-Smtp-Source: AGHT+IGIeRbvnxCp056eR7o04HYzcINgzzT4WzRCg/DYfYTFWSI7K7p21iVLjcZDM8PdtIN9vSXuEQ==
X-Received: by 2002:a17:90a:83:b0:274:a021:9383 with SMTP id a3-20020a17090a008300b00274a0219383mr227611pja.17.1694752652282;
        Thu, 14 Sep 2023 21:37:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gv4-20020a17090b11c400b00273f65fa424sm2107850pjb.8.2023.09.14.21.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:37:31 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:37:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/gma500: refactor deprecated strncpy
Message-ID: <202309142135.16032DEA8@keescook>
References: <20230914-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-v1-1-0a53a076ce20@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-v1-1-0a53a076ce20@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 08:52:21PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> Since `chan->base.name` is expected to be NUL-terminated, a suitable
> replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer without also unnecessarily
> NUL-padding.

How did you decide about %NUL padding? (I see it is kzalloc'd, so it
doesn't matter.)

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> 
> 
> drm/gma500: refactor deprecated strncpy
> ---
>  drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
> index 06b5b2d70d48..68458cbdd6d5 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
> @@ -141,7 +141,7 @@ struct gma_i2c_chan *oaktrail_lvds_i2c_init(struct drm_device *dev)
>  
>  	chan->drm_dev = dev;
>  	chan->reg = dev_priv->lpc_gpio_base;
> -	strncpy(chan->base.name, "gma500 LPC",  I2C_NAME_SIZE - 1);
> +	strscpy(chan->base.name, "gma500 LPC",  I2C_NAME_SIZE - 1);

What's going on here with the destination buffer size? chan->base.name
is 48 bytes. I2C_NAME_SIZE is 20.

Ultimately it doesn't matter since the source is a const char string,
but it's still weird. Therefore:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  	chan->base.owner = THIS_MODULE;
>  	chan->base.algo_data = &chan->algo;
>  	chan->base.dev.parent = dev->dev;
> 
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-a53c6d8bd62f
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
