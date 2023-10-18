Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AE57CE095
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345104AbjJRO75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbjJRO7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:59:55 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3325F7;
        Wed, 18 Oct 2023 07:59:53 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6c7c2c428c1so3927697a34.0;
        Wed, 18 Oct 2023 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697641193; x=1698245993; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sHyZ+387T3oqeq7HqyYoKhzeb1fsbRphT6DeM11cMrU=;
        b=UPGQmpPYMWFi+7dT10f6uc6yrlteDkfdqRvQY1jVE5+cNLt2FJrx5hzvRKplwlW2bZ
         Y5WIo2NXQl7EKxTPwv8kXjalAl9eNd/9vyVyvc2dShyHYaEq8S+kE3Na46JxJElS3rhU
         QTFUUJYU5yZjxGiI273cD/MTTgtIxh9Tll9dr90mLqV2KeRaverLjyNpIxLgWRI3FPkY
         XbPCJoRwkIA7rvL+2202LsQcZJzPP0AJV1xT10u/42crogkZ3YuQ1Marrxpv+q44Yq+i
         6WsSV2sCCIAvAsY/fkR6n5Ycy7+ii2XE6wYeqnWsZEA0UPnIgn++b+WLa8/auj+AaUMJ
         JMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697641193; x=1698245993;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHyZ+387T3oqeq7HqyYoKhzeb1fsbRphT6DeM11cMrU=;
        b=rI7pZx57fHs6ZynB3HaEmcWb7+HKya7XNg88AhiUSriG3PxQgEKvPD5SAH/0vg7qxb
         gvc11WsAJEqyKVMurhxoQ+eaWaqcnc/rNm0QyYdin6mtI+iOjwsB9LjYFpwLaO5RmGFt
         BPJP2a4aSAVUIZQhkhV70OSRxPaDzY5o4wYoQN3cHSCMpbb2FJ+EdWjj78u3RGSwrcb1
         n7XBZ4QZMameYSeg49HGAAayI2kY4AqIUii0Sd8tehnFCU6tn6M7Is/4FNZ71ofNjchS
         ArEHTFIP5fF6crfoHGeMkZPZspa+heySnWH/FI0GStd9/z40eqHQQU5iEAV9GR5m13Dk
         6I9g==
X-Gm-Message-State: AOJu0Yz3i2C7dUYYmQjfo2ow1V+320Vvezj5OFrPupYXk4dv84M93q7k
        qE5MdRKi7vPG0PSsdfuPdSc=
X-Google-Smtp-Source: AGHT+IEzA71SI0QmQIR3m82OpQngFmOKztXN6e8Mqg3eyX7M+EodNAtDriB1JpnpL66F+ts/JJJhBw==
X-Received: by 2002:a05:6830:92a:b0:6c4:6af2:ea72 with SMTP id v42-20020a056830092a00b006c46af2ea72mr2634754ott.3.1697641192840;
        Wed, 18 Oct 2023 07:59:52 -0700 (PDT)
Received: from neuromancer. ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id g8-20020a056830308800b006bf0f95f702sm652980ots.64.2023.10.18.07.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 07:59:52 -0700 (PDT)
Message-ID: <652ff2e8.050a0220.2e2de.4666@mx.google.com>
X-Google-Original-Message-ID: <ZS/y5yxqg4QE2QNH@neuromancer.>
Date:   Wed, 18 Oct 2023 09:59:51 -0500
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Ondrej Jirman <megous@megous.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Samuel Holland <samuel@sholland.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ondrej Jirman <megi@xff.cz>, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/panel: st7703: Pick different reset sequence
References: <20230211171748.36692-1-frank@oltmanns.dev>
 <20230211171748.36692-2-frank@oltmanns.dev>
 <ZSvf0HIA3GaZlbac@qwark.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSvf0HIA3GaZlbac@qwark.sigxcpu.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 02:49:20PM +0200, Guido Günther wrote:
> Hi,
> On Sat, Feb 11, 2023 at 06:17:48PM +0100, Frank Oltmanns wrote:
> > From: Ondrej Jirman <megi@xff.cz>
> > 
> > Switching to a different reset sequence, enabling IOVCC before enabling
> > VCC.
> > 
> > There also needs to be a delay after enabling the supplies and before
> > deasserting the reset. The datasheet specifies 1ms after the supplies
> > reach the required voltage. Use 10-20ms to also give the power supplies
> > some time to reach the required voltage, too.
> > 
> > This fixes intermittent panel initialization failures and screen
> > corruption during resume from sleep on panel xingbangda,xbd599 (e.g.
> > used in PinePhone).
> 
> Thanks, applied to drm-misc-next.
> Cheers,
>  -- Guido

Thank you. Probably too late, but this fixes problems I have with a
different ST7703 based panel.

Tested-by: Chris Morgan <macromorgan@hotmail.com>

> 
> > 
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> > Reported-by: Samuel Holland <samuel@sholland.org>
> > ---
> >  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 25 ++++++++++---------
> >  1 file changed, 13 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> > index 6747ca237ced..45695aa51f62 100644
> > --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> > +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> > @@ -411,29 +411,30 @@ static int st7703_prepare(struct drm_panel *panel)
> >  		return 0;
> >  
> >  	dev_dbg(ctx->dev, "Resetting the panel\n");
> > -	ret = regulator_enable(ctx->vcc);
> > +	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> > +
> > +	ret = regulator_enable(ctx->iovcc);
> >  	if (ret < 0) {
> > -		dev_err(ctx->dev, "Failed to enable vcc supply: %d\n", ret);
> > +		dev_err(ctx->dev, "Failed to enable iovcc supply: %d\n", ret);
> >  		return ret;
> >  	}
> > -	ret = regulator_enable(ctx->iovcc);
> > +
> > +	ret = regulator_enable(ctx->vcc);
> >  	if (ret < 0) {
> > -		dev_err(ctx->dev, "Failed to enable iovcc supply: %d\n", ret);
> > -		goto disable_vcc;
> > +		dev_err(ctx->dev, "Failed to enable vcc supply: %d\n", ret);
> > +		regulator_disable(ctx->iovcc);
> > +		return ret;
> >  	}
> >  
> > -	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> > -	usleep_range(20, 40);
> > +	/* Give power supplies time to stabilize before deasserting reset. */
> > +	usleep_range(10000, 20000);
> > +
> >  	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> > -	msleep(20);
> > +	usleep_range(15000, 20000);
> >  
> >  	ctx->prepared = true;
> >  
> >  	return 0;
> > -
> > -disable_vcc:
> > -	regulator_disable(ctx->vcc);
> > -	return ret;
> >  }
> >  
> >  static const u32 mantix_bus_formats[] = {
> > -- 
> > 2.39.1
> > 
