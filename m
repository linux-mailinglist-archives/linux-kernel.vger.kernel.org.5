Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B627DF52D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjKBOfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjKBOfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:35:32 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FE4130
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:35:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so1759958a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698935724; x=1699540524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2kxXGpASHb8vQvtPgEKuD/+7aWXQWstAKgMPv5Qzafs=;
        b=ywaYldh7n7bub0eOEO2RqApDey7SiTeoIdO4aEA7H9T/sElvGa3wj4H3Uq/Lw/RU4+
         jl5SLscMOeRcS9sX9Xqq/BSmOSWsxdSUpRvDJdzoIbbcN0njUlFiUtxNID06obKMypqO
         AMc4j+HI5IlJ4rR3znzdPuYXUzP10BzJjD3mAnB3P3JDUmSs2QRbzBc4RXi4Hp3t9gUN
         mLnzdSMALnu2pEJOtZr6wavFXe+FwxbssSZmzyQJABh5v1BohtoGuZSUC50DIbBefuJ4
         4CJoC6N+AKTqVDhJe+AtcT6L5NXQy8iZL+Y0RM1DWp/WLG/zBOGkUlRM/+zLiIokuasR
         ZBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698935724; x=1699540524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2kxXGpASHb8vQvtPgEKuD/+7aWXQWstAKgMPv5Qzafs=;
        b=tZaRAq0lXCoWP1yDWA9bJzYFJavyed8hb8RkcfAsbn79eB9s0uPw+PSswa83uIAyXE
         rhFz0A02w3yx7YgJyRQUYKm54yLHJcl8sjI1ygPT9/0Ey2Rk/5veOME+S/k+N0OsJiU2
         WVTa5uSWVnxBPWDs4vDL4CD47qY//bjfkL01LwduCm+i1D6FTUZm589RK8KGBqWvBsGG
         YngJc8dkH2UE3cz4wql7rJg0zYluzcbVe/lQ8trWjGS5IBxjx3+Xo8I+8hCWTkGMWgqR
         voC6sdx8bpkLxiYOzE30cpWEw1sPOJnODRijAFGnJZLyqaOajviRP7V052k0lR84tZyz
         6MYw==
X-Gm-Message-State: AOJu0YxZUXXa6JIRDv61Fm4ZXyyR3qF3YArwCXOZQhM5/BMbyqyTSKN+
        2hL87tMpfyMLLR1uz1kJjxcXHA==
X-Google-Smtp-Source: AGHT+IHi4X/4Ey2n4dyewNyEL9R+lcjlEa8aSyNJ4kvkobPnvns1KYaw7NdgxkYdUuj6rCBOabCwMQ==
X-Received: by 2002:a50:aa93:0:b0:543:6ce3:f091 with SMTP id q19-20020a50aa93000000b005436ce3f091mr6167475edc.7.1698935724023;
        Thu, 02 Nov 2023 07:35:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j8-20020a50ed08000000b0053eb9af1e15sm2386006eds.77.2023.11.02.07.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 07:35:23 -0700 (PDT)
Date:   Thu, 2 Nov 2023 17:35:09 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Alexandra Diupina <adiupina@astralinux.ru>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 1/4] Remove redundant return value check
Message-ID: <11e6e0bd-eab1-4aa7-8c5c-29de6cff1b3d@kadam.mountain>
References: <20231102141135.369-1-adiupina@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102141135.369-1-adiupina@astralinux.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 05:11:32PM +0300, Alexandra Diupina wrote:
> media_entity_pads_init() will not return 0 only if the
> 2nd parameter >= MEDIA_ENTITY_MAX_PADS (512), but 1 is
> passed, so checking the return value is redundant
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: ad85094b293e ("Revert "media: staging: atomisp: Remove driver"")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
>  drivers/staging/media/atomisp/i2c/atomisp-gc2235.c        | 4 +---
>  drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c       | 6 +-----
>  drivers/staging/media/atomisp/i2c/atomisp-ov2722.c        | 2 --
>  drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693.c | 2 --
>  4 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c b/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
> index 9fa390fbc5f3..f10931a03285 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
> @@ -840,9 +840,7 @@ static int gc2235_probe(struct i2c_client *client)
>  	dev->ctrl_handler.lock = &dev->input_lock;
>  	dev->sd.ctrl_handler = &dev->ctrl_handler;
>  
> -	ret = media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
> -	if (ret)
> -		gc2235_remove(client);

Not related to your patch but why doesn't this error path return an
error?  Can that be right?

> +	media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
>  
>  	return atomisp_register_i2c_module(&dev->sd, gcpdev, RAW_CAMERA);

regards,
dan carpenter
