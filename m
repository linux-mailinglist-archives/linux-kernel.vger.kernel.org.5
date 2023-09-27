Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A0D7B021A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjI0Kny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI0Knv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:43:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849FB139;
        Wed, 27 Sep 2023 03:43:50 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso1376384566b.1;
        Wed, 27 Sep 2023 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695811429; x=1696416229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozgRDTC+2UK6mD107LVNtKBM9DQ8506FxPydFp9FLHU=;
        b=WP8qZHGLln5e3/FHLTK6pZxxr2azrFmDxBAkmMdndcBcsc36I7iOqZO7E1CLMuJbZ5
         MNxlnR9wvrHC3rT0PTVeKnp+nJFF3oLshQEOR5hCq8UFHSge/3jM0MYLdFQy+QOu5Knc
         OnzTrHTtKuM1sUksq+3H+Y04cX2V6YzNMuM6zc1Bo9zL2gFTC/0WjR4vHOW7ySn4UwRC
         VhiBoLHtRYw4adbTTqZEzCNpzhbN8O55xHJYWMU6eyrSidFJvWHplxnSZngq1zCq2ZVa
         II4NYVnIWOkMEWzk1H8KzU2vg2FsBBLdPRgwgcqPY3O8c2FS1Caz27qPLK308MU7ZYNb
         UQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695811429; x=1696416229;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozgRDTC+2UK6mD107LVNtKBM9DQ8506FxPydFp9FLHU=;
        b=nSV/UJyc6i6gaYLNp2ZGE1eduqU7iiIMvdkIaDHPxBXsWZvCg/lxHX/QbCxgYe5+Yj
         QrW7NRpOUKAQKku6+Cn2eveECaOvHk+vgfnVAvgmFWbxJcv2IqKSeS3dTTA9HcEz8otn
         uvsXv1D5RFf1OU7SFme6tKWG4QCygq/dwqYG9ief/FWVDxZlVenujXLRIfx/a7lccJgC
         s6MyflqkyXqFHZfgv+5F/ooth2Z9OOweHBcBxYtemOX6k4rqi8lHR4epbfRNLaxSIRW8
         nuD4wz2uyCtbytq/q+O0Hikf9UNX1EHeww6P6L7e8plrt04XDZdEJq1gImWlpvf/Et5I
         QCmA==
X-Gm-Message-State: AOJu0YxaPuEaGEmMcBPo2Q4ML+hgGUVMpihHrcg8lJmVSiOvV4qpniR5
        XLBzs3bd3Z4I0MTY68I5eXMGEl8bVpI=
X-Google-Smtp-Source: AGHT+IFrfTl0CPJDAs5rBjmyIwqBNlUP129i/O3iWILp8f0G9qcw0Tg7SqobzwuGvCR0qdEB+F9qWg==
X-Received: by 2002:a17:906:d41:b0:9ae:4843:66ee with SMTP id r1-20020a1709060d4100b009ae484366eemr1400373ejh.36.1695811428590;
        Wed, 27 Sep 2023 03:43:48 -0700 (PDT)
Received: from localhost (81-226-149-122-no518.tbcn.telia.com. [81.226.149.122])
        by smtp.gmail.com with ESMTPSA id lw3-20020a170906bcc300b009ade1a4f795sm9013116ejb.168.2023.09.27.03.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 03:43:48 -0700 (PDT)
Date:   Wed, 27 Sep 2023 12:43:46 +0200
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] drm/gma500: refactor deprecated strncpy
Message-ID: <fmvdws32xrjj3a3vqwcghnniojcglrpzs4mk5cw67vog6vlwta@zmoz6bv2i5iw>
Mail-Followup-To: Justin Stitt <justinstitt@google.com>, 
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230919-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-v2-1-9ebe6983b4cb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-v2-1-9ebe6983b4cb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 04:41:16AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> Since `chan->base.name` is expected to be NUL-terminated, a suitable
> replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer without also unnecessarily
> NUL-padding (since `chan` is kzalloc'd already).
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Applied to drm-misc-next.

Thanks
Patrik

> ---
> Changes in v2:
> - use sizeof() instead of I2C_NAME_SIZE (thanks Kees, Patrik)
> - Link to v1: https://lore.kernel.org/r/20230914-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-v1-1-0a53a076ce20@google.com
> ---
>  drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
> index 06b5b2d70d48..939c53fd09e8 100644
> --- a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
> +++ b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
> @@ -141,7 +141,7 @@ struct gma_i2c_chan *oaktrail_lvds_i2c_init(struct drm_device *dev)
>  
>  	chan->drm_dev = dev;
>  	chan->reg = dev_priv->lpc_gpio_base;
> -	strncpy(chan->base.name, "gma500 LPC",  I2C_NAME_SIZE - 1);
> +	strscpy(chan->base.name, "gma500 LPC",  sizeof(chan->base.name));
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
