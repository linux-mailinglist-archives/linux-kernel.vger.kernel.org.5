Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192287A4219
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjIRHRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjIRHQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:16:50 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F344AA;
        Mon, 18 Sep 2023 00:16:44 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c00e1d4c08so8229021fa.3;
        Mon, 18 Sep 2023 00:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695021402; x=1695626202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtYLAbUkW1EE5YSKH4JQuk4HIHGauzB0S/KhIJUqMLY=;
        b=DCsccc3AjycbMZut9Z42XNMVxf/CChADAylXGlOPclg+AgB6qCMCBxM528rh02Ac1G
         PfyE4CWXSk+NdxiOUw/NsReFHkbvq0HMKOHNBzX9QsyJwg6Nra94+gUlIPB9CH/VDtl4
         9/Rw4V1jMq32DGltOwvMrdAs158Z5vOxnZVZylZ7O301qQ1bg+v8aUJ1G2CeRrgwYS3c
         FbTbVA9TLqX5pHpzRSeGTjQENP1+BO9jzSnfixGGW/s+9QPN6993zt5uydBnZrH4Tb0h
         iLpdMszP94UmWQVvoGRB5hAShF25VL9xk5DTNrLyqHJ2YB7InnLLpqHLbGUxC3zwX8RQ
         kasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695021402; x=1695626202;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HtYLAbUkW1EE5YSKH4JQuk4HIHGauzB0S/KhIJUqMLY=;
        b=r8rGpPCgq0VqHbMbnTEXrW4j9onXpxHmN4qHbUautk2BwN5YJuNUvZvjPQCK7TYbc7
         evohlBYUvIFgHnVeUeRxkjxawAW6TQuRJV+fNd4bb+g2aJlzWEfSS4/AiD5JAji3LnYC
         3n2K9WxnncBpWPvnBC8iDB64+dkZ5xnMoiHBTkopk3jTPEAUBuIcvnN1Iu4e6/LE7BFu
         gqhSWftyvdKKrKrnNCyBMv7jtuFPI278OwJ4se9ten4RocjeQLlfIyy7GzIMP/3v+YKr
         5S1m+cZ7UrMr/wDHdunb4SEJdVbhOPK1dGEAVnwYmkgQKM+5es5jQ1lsExiC9ssc5cAV
         meCg==
X-Gm-Message-State: AOJu0YxXBxHVagXLzXFVlppzj9EC6/AiWQ/aga8g6iqBHjk72q1QeJbU
        oZNZCyQC1Q39YNYi6wAGR0I=
X-Google-Smtp-Source: AGHT+IG38LcxzwKXLpAT//j7BucjbiMzO8rRJFcNYXDrwkHSK8FMz6yosThkN68Vrff6++hYDjGT3g==
X-Received: by 2002:a05:651c:610:b0:2c0:18e0:708a with SMTP id k16-20020a05651c061000b002c018e0708amr408980lje.46.1695021402207;
        Mon, 18 Sep 2023 00:16:42 -0700 (PDT)
Received: from localhost (81-226-149-122-no518.tbcn.telia.com. [81.226.149.122])
        by smtp.gmail.com with ESMTPSA id n6-20020a2e8786000000b002bcc866ec9esm1980739lji.119.2023.09.18.00.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 00:16:41 -0700 (PDT)
Date:   Mon, 18 Sep 2023 09:16:39 +0200
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/gma500: refactor deprecated strncpy
Message-ID: <7rldvf22zvtvvqpqsoeidg57sqwnuz6pfclve7igw6kuxp5jfp@vkt3z7br5hll>
Mail-Followup-To: Kees Cook <keescook@chromium.org>, 
        Justin Stitt <justinstitt@google.com>, David Airlie <airlied@gmail.com>, 
        Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
        linux-hardening@vger.kernel.org
References: <20230914-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-v1-1-0a53a076ce20@google.com>
 <202309142135.16032DEA8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309142135.16032DEA8@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 09:37:31PM -0700, Kees Cook wrote:
> On Thu, Sep 14, 2023 at 08:52:21PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> > 
> > We should prefer more robust and less ambiguous string interfaces.
> > 
> > Since `chan->base.name` is expected to be NUL-terminated, a suitable
> > replacement is `strscpy` [2] due to the fact that it guarantees
> > NUL-termination on the destination buffer without also unnecessarily
> > NUL-padding.
> 
> How did you decide about %NUL padding? (I see it is kzalloc'd, so it
> doesn't matter.)
> 
> > 
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > 
> > 
> > drm/gma500: refactor deprecated strncpy
> > ---
> >  drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
> > index 06b5b2d70d48..68458cbdd6d5 100644
> > --- a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
> > +++ b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
> > @@ -141,7 +141,7 @@ struct gma_i2c_chan *oaktrail_lvds_i2c_init(struct drm_device *dev)
> >  
> >  	chan->drm_dev = dev;
> >  	chan->reg = dev_priv->lpc_gpio_base;
> > -	strncpy(chan->base.name, "gma500 LPC",  I2C_NAME_SIZE - 1);
> > +	strscpy(chan->base.name, "gma500 LPC",  I2C_NAME_SIZE - 1);
> 
> What's going on here with the destination buffer size? chan->base.name
> is 48 bytes. I2C_NAME_SIZE is 20.

It seems I2C_NAME_SIZE is used for i2c_client.name but is abused here
for i2c_adapter.name as well. Using sizeof() would be better. Justin,
would you mind changing that as well?

Thanks
Patrik

> 
> Ultimately it doesn't matter since the source is a const char string,
> but it's still weird. Therefore:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> -Kees
> 
> >  	chan->base.owner = THIS_MODULE;
> >  	chan->base.algo_data = &chan->algo;
> >  	chan->base.dev.parent = dev->dev;
> > 
> > ---
> > base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> > change-id: 20230914-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-a53c6d8bd62f
> > 
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> > 
> 
> -- 
> Kees Cook
