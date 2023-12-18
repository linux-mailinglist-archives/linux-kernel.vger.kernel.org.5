Return-Path: <linux-kernel+bounces-4206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4B581791B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9151F27851
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CEE5D74C;
	Mon, 18 Dec 2023 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naM/PjGX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7084A5D73B;
	Mon, 18 Dec 2023 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3ac28ae81so13783315ad.0;
        Mon, 18 Dec 2023 09:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921331; x=1703526131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MGc3H1mZH6buwISmfip+JfxIDpEG4RSu3DvfL7xLHYM=;
        b=naM/PjGXR+ZvuuwwNlrNflE4mn1iPSGtvi0kA6Pswm793wmWZm5PMI37LZwLW7Fm4A
         tLOjwa0wl3JyLcpKOViFUry+TQEY/yg4QnJeQYKDRGUdinxhKSTGiFsw+H8W+QMzX3kI
         Vi7ZOA3uJhFevYnyuMn/mZD7CsniUuaRw9RfdDqGOqQ5Zk+EFM1FJo1kTi2STd0QnK1r
         8MK62oVw8jLSvsu6xhChBZC6QxtKztSVtOqTaI25Bl2wrCjqaVIj53UTkHRd4bwRbo3D
         rTF8wx2/SDtHrMnX2ndDvkYDy3sFBwaKgespEKePPos6CoEaZamFNGDTOHiissDAzjfP
         7GfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921331; x=1703526131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGc3H1mZH6buwISmfip+JfxIDpEG4RSu3DvfL7xLHYM=;
        b=HPzYHYsS/mQSaNMnnLhy6Px5C3z/hhDrwJROF+5wP0+zviML+zZ27cri1h2UWiRHc1
         YffDwOqGZ48CrqqUNLlzjZjlh9+6iT8RqsVSUqFmwH1zYch0N6BY3RyI4ZZ5X1GtvYb6
         hjUFvOiAkMBueca+IFqOhzIVLOcnsKxPpHdyKDypJWEZRHyUkZTGD48tl0pSsFuNaNMX
         2jDYnCTVwp94Zahq3KqARxBduhFSmvA9Cdk3rxNlo8PH8KosHiDVtZtk+9Z/5Nukdzzq
         MQnqWppLKz3KZTxJE+uq+S2itnFZIFt6nT2YHEPvZZKYsMIgGaVJiV1gxYdIqOy1OPwV
         Jb6Q==
X-Gm-Message-State: AOJu0YzY4eI3sVj0c0FnVoAwl2Uw65Xb7fNjDazDnTshUwqWYguhtIpH
	eS+qqMpbCfnNfyg+gCg5hn8=
X-Google-Smtp-Source: AGHT+IED5rEnW8aoqaiiA/2rqOwUboP7/NHnORKUO0aZalPEfPHyGBYCERMEgw6AFHRANrIrYLaoFg==
X-Received: by 2002:a17:902:ab83:b0:1d0:6ffd:e2ef with SMTP id f3-20020a170902ab8300b001d06ffde2efmr15136709plr.137.1702921330684;
        Mon, 18 Dec 2023 09:42:10 -0800 (PST)
Received: from localhost ([2804:30c:160d:b800:be05:2c5b:24c0:12aa])
        by smtp.gmail.com with ESMTPSA id a21-20020a1709027d9500b001cfed5524easm19233051plm.288.2023.12.18.09.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:42:10 -0800 (PST)
Date: Mon, 18 Dec 2023 14:42:01 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
	joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	paul.cercueil@analog.com, Michael.Hennerich@analog.com,
	lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/15] iio: adc: ad7091r: Enable internal vref if
 external vref is not supplied
Message-ID: <ZYCEaXAm53X_Vig-@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
 <ce92ae93b1c2e36b20a9881b145c8c2c85acb1dd.1702746240.git.marcelo.schmitt1@gmail.com>
 <CAMknhBF7Ab0FZCKYkSq8siDMPtX5VRRn04FS7XiYLtK-1TJa3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMknhBF7Ab0FZCKYkSq8siDMPtX5VRRn04FS7XiYLtK-1TJa3A@mail.gmail.com>

On 12/17, David Lechner wrote:
> On Sat, Dec 16, 2023 at 11:49 AM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
> >
> > The ADC needs a voltage reference to work correctly.
> > Enable AD7091R internal voltage reference if no external vref is supplied.
> >
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  drivers/iio/adc/ad7091r-base.c | 7 +++++++
> >  drivers/iio/adc/ad7091r-base.h | 1 +
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> > index aead72ef55b6..9d0b489966f5 100644
> > --- a/drivers/iio/adc/ad7091r-base.c
> > +++ b/drivers/iio/adc/ad7091r-base.c
> > @@ -217,7 +217,14 @@ int ad7091r_probe(struct device *dev, const struct ad7091r_init_info *init_info,
> >         if (IS_ERR(st->vref)) {
> >                 if (PTR_ERR(st->vref) == -EPROBE_DEFER)
> >                         return -EPROBE_DEFER;
> > +
> >                 st->vref = NULL;
> > +               /* Enable internal vref */
> > +               ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> > +                                        AD7091R_REG_CONF_INT_VREF, BIT(0));
> 
> Can we use regmap_set_bits() here to avoid the BIT(0)?
> 
> The same comment applies to other patches in this series.

Looks good, will do.

Thanks

> 
> > +               if (ret)
> > +                       return dev_err_probe(st->dev, ret,
> > +                                            "Error on enable internal reference\n");
> >         } else {
> >                 ret = regulator_enable(st->vref);
> >                 if (ret)
> > diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> > index 81b8a4bbb929..9cfb362a00a4 100644
> > --- a/drivers/iio/adc/ad7091r-base.h
> > +++ b/drivers/iio/adc/ad7091r-base.h
> > @@ -20,6 +20,7 @@
> >  #define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
> >
> >  /* AD7091R_REG_CONF */
> > +#define AD7091R_REG_CONF_INT_VREF      BIT(0)
> >  #define AD7091R_REG_CONF_ALERT_EN      BIT(4)
> >  #define AD7091R_REG_CONF_AUTO          BIT(8)
> >  #define AD7091R_REG_CONF_CMD           BIT(10)
> > --
> > 2.42.0
> >

