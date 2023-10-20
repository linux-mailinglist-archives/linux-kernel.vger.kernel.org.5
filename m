Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A5E7D0E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377058AbjJTL1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376883AbjJTL1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:27:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E759BC2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:27:31 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c504a5e1deso11192601fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697801250; x=1698406050; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cMmNFqskfyUOXpQegXuQzmiikeYo6k8K/89VdvccPyY=;
        b=V7jMwcp8I6tDHGfkUpaYKQytTUshyfYOcR3VIrM4Vkte3JKiOUFyv/1fY0f6QQioh+
         KUSmplFsXbZKKI1A0IcK+SdAwZYl3BoCARVqLaCnROmBuQ5Nfpg45vypZql0/4XR9wqb
         X/qDr//smzBinnqI6BMr77gphAxDeYjFmlUOa2DNLOThuUvQUQO+Tz/RKsiPHrc+jQIV
         XD+ubwrZClTBV6hCnu1AfTLSQmuFi+hFTWGBvEuB/tkyVjxZegp9WuEcTtc9PLKNNCvN
         wH6ISrOsW7sbwQ0xfDy51uvZLoTlaIOQkfnqqx+DQyt0gEZuDsGWLHF3sYvpP9q9deeG
         EHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697801250; x=1698406050;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMmNFqskfyUOXpQegXuQzmiikeYo6k8K/89VdvccPyY=;
        b=jWjbOQ65MvEuxLMdbGC3TapAVO/okb2WDvtU0Z+7YspRUO6T1gPmKT8HwPctetUfjr
         XyCfDbTYeoVL7gnwslQgxNwvfHBMqYTiIyv669MhyRJxesdoMPvJWO8ljVl6HL3cixZv
         RRZ9U4wa9kCargQ+KlMLIh+xIpvFcw8lRZJ7TL/JMDuOrHbtLhOC5sQw3Zg9zDTH7gAd
         HaIzE2IgkpK11wkSRjS3EslCNzdfUd1xNENYtalRKjIyZ64X32kUkKM2DE8r8XEO1sGg
         EnngrACs6TAQRmhio+fATYqxwVXGuC2EF3PXXfhBe61A1y9ViaC1qqa73e3yQuLHhydk
         8ZUg==
X-Gm-Message-State: AOJu0Yxj7kUn2nmIrigFZ+6Vyzg+qc4eitibE6ptmaKygeIIO1SVh3pa
        Duh/efiHHnkvpmJK/h1KthKPQA==
X-Google-Smtp-Source: AGHT+IF6PQTaN2LIwk2vIQs8dGQckxx0OgLpZjue64p2nFkQLUkLGAUYJizVCo1QpyNFwO8uojzoSw==
X-Received: by 2002:a2e:a99b:0:b0:2b9:3684:165 with SMTP id x27-20020a2ea99b000000b002b936840165mr1279776ljq.8.1697801250111;
        Fri, 20 Oct 2023 04:27:30 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bi9-20020a05600c3d8900b003fc16ee2864sm1912171wmb.48.2023.10.20.04.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:27:29 -0700 (PDT)
Date:   Fri, 20 Oct 2023 12:27:27 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Avoid backlight flicker applying
 initial PWM state
Message-ID: <20231020112727.GF23755@aspen.lan>
References: <20230608-backlight-pwm-avoid-flicker-v1-1-afd380d50174@pengutronix.de>
 <20231018210741.6t3yfj6qgmpwhhlo@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018210741.6t3yfj6qgmpwhhlo@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:07:41PM +0200, Uwe Kleine-König wrote:
> Hello Philipp,
>
> On Thu, Jun 08, 2023 at 04:11:14PM +0200, Philipp Zabel wrote:
> > The initial PWM state returned by pwm_init_state() has a duty cycle
> > of 0 ns.
>
> This is only true for drivers without a .get_state() callback, isn't it?

pwm_init_state() explicitly zeros the duty-cycle in order to avoid
problems when the default args have a different period to the currently
applied config:
https://elixir.bootlin.com/linux/latest/source/include/linux/pwm.h#L174


Daniel.


> > To avoid backlight flicker when taking over an enabled
> > display from the bootloader, skip the initial pwm_apply_state()
> > and leave the PWM be until backlight_update_state() will apply the
> > state with the desired brightness.
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> > With a PWM driver that allows to inherit PWM state from the bootloader,
> > postponing the initial pwm_apply_state() with 0 ns duty cycle allows to
> > set the desired duty cycle before the PWM is set, avoiding a short flicker
> > if the backlight was previously enabled and will be enabled again.
> > ---
> >  drivers/video/backlight/pwm_bl.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index fce412234d10..47a917038f58 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -531,12 +531,10 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >  	if (!state.period && (data->pwm_period_ns > 0))
> >  		state.period = data->pwm_period_ns;
> >
> > -	ret = pwm_apply_state(pb->pwm, &state);
> > -	if (ret) {
> > -		dev_err(&pdev->dev, "failed to apply initial PWM state: %d\n",
> > -			ret);
> > -		goto err_alloc;
> > -	}
> > +	/*
> > +	 * No need to apply initial state, except in the error path.
>
> Why do you want to modify the PWM in the error path? I would have
> expected not touching it at all in .probe() is fine?!
>
> > +	 * State will be applied by backlight_update_status() on success.
> > +	 */
> >
> >  	memset(&props, 0, sizeof(struct backlight_properties));
> >
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |
