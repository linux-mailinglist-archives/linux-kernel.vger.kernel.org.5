Return-Path: <linux-kernel+bounces-4177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A1C8178DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97CAC1F22E81
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E985BFB0;
	Mon, 18 Dec 2023 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq3l9H8D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7B125C8;
	Mon, 18 Dec 2023 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d6d48354ccso778053b3a.1;
        Mon, 18 Dec 2023 09:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702920938; x=1703525738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Zkd2xmVN0GgzkQe6vI9LUZBQ24OEQyIJfPs7VhXir0=;
        b=fq3l9H8Dci85BeJ60b/zweONFhFR7wAy9qUbA97rJWXqd62/iZJIye1Ysti+bTp83c
         BJP+oSJkBSDa6TO50hjvKN0qHRWM1L3BMgC3xKVKMuz1Sbc2bSBNHvun1P+L9Zzt0j+D
         qqnBDhLjSlNHq+j1B2gggdGRK8Bx0ssBpR1Lgz+zl3W15D8lzfFDLIEF8Qj151WM8c//
         0EfpbtObUHpZT3FmSS937pDW8+iYnSpBQtWq75Cx2+6YHiENflQKAbQfYs7JL6GLY8py
         cyAsKG0yDRYi1Mv0470ABSyNEl3V6Bfxb18+cV35Y29tlViR2RhDMe+3kjIe4kzJH5hm
         xmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702920938; x=1703525738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Zkd2xmVN0GgzkQe6vI9LUZBQ24OEQyIJfPs7VhXir0=;
        b=FF4owpCNDJ3ciITNviU3C1BbNDHKUbAyIPa2mcpTAPcpmZUhhXDgBHmJnmZnl6Dav3
         5h84gadYA/SOFYWY/p7QPb84Jzcwt3NC5HoOdbdBgi7b4LfUoKao/xnaiBvqZottQ3ee
         KdMiDc5lTpFQX3bmgToO87JktfOIusuo41p34YfKPZ1x7VduwNlZwPdKGOPH40D61hu4
         UELttqN+n3tpV4zV7qZCfOAsno6+2io3MUTBL2/l7DMPK7zorTXbIswlc14NhBMYSqzI
         fHD/R5YlcmLv5WMSQXowftFYLuasZKHfWeruG7SAO1/YLyKxBuFanFr+HHIBaNOiNQI/
         vkVg==
X-Gm-Message-State: AOJu0YyZ4lFMkvCFYCrnJF4FtnuzfKxmzhem5kTmrBIinEhRc8yGZs1m
	qJJuTJVseq8clikaG1Zhtgk=
X-Google-Smtp-Source: AGHT+IGBh2KbFeynBsSsrsj/nflN9jiIRZ35BFoMgRGxjXJEEyYS3+YRmN8gWDEAKgbqupOviman8g==
X-Received: by 2002:a05:6a00:2e20:b0:6d2:9679:841d with SMTP id fc32-20020a056a002e2000b006d29679841dmr1553945pfb.25.1702920937705;
        Mon, 18 Dec 2023 09:35:37 -0800 (PST)
Received: from localhost ([2804:30c:160d:b800:be05:2c5b:24c0:12aa])
        by smtp.gmail.com with ESMTPSA id g19-20020a056a00079300b006d4d8819343sm3016418pfu.73.2023.12.18.09.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:35:37 -0800 (PST)
Date: Mon, 18 Dec 2023 14:35:27 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
	joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	paul.cercueil@analog.com, Michael.Hennerich@analog.com,
	lars@metafoo.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dan.carpenter@linaro.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/15] iio: adc: ad7091r: Enable internal vref if
 external vref is not supplied
Message-ID: <ZYCC3z44hMzgQTa6@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
 <ce92ae93b1c2e36b20a9881b145c8c2c85acb1dd.1702746240.git.marcelo.schmitt1@gmail.com>
 <20231217154142.191ba69b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217154142.191ba69b@jic23-huawei>

On 12/17, Jonathan Cameron wrote:
> On Sat, 16 Dec 2023 14:49:07 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > The ADC needs a voltage reference to work correctly.
> > Enable AD7091R internal voltage reference if no external vref is supplied.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> This one sounds to me like it should have a fixes tag and be
> much earlier in the set to perhaps simplify backports.

Could be. If we stick to the fact that the dt-binding does not require a voltage
regulator then this can be seen as a fix.
Though, if users can provide an external reference this patch makes no
difference them.
I am using the internal reference for testing so having this one makes a
difference for me.

> 
> Jonathan
> 
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
> >  	if (IS_ERR(st->vref)) {
> >  		if (PTR_ERR(st->vref) == -EPROBE_DEFER)
> >  			return -EPROBE_DEFER;
> > +
> >  		st->vref = NULL;
> > +		/* Enable internal vref */
> > +		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> > +					 AD7091R_REG_CONF_INT_VREF, BIT(0));
> > +		if (ret)
> > +			return dev_err_probe(st->dev, ret,
> > +					     "Error on enable internal reference\n");
> >  	} else {
> >  		ret = regulator_enable(st->vref);
> >  		if (ret)
> > diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
> > index 81b8a4bbb929..9cfb362a00a4 100644
> > --- a/drivers/iio/adc/ad7091r-base.h
> > +++ b/drivers/iio/adc/ad7091r-base.h
> > @@ -20,6 +20,7 @@
> >  #define AD7091R_REG_CH_HYSTERESIS(ch) ((ch) * 3 + 6)
> >  
> >  /* AD7091R_REG_CONF */
> > +#define AD7091R_REG_CONF_INT_VREF	BIT(0)
> >  #define AD7091R_REG_CONF_ALERT_EN	BIT(4)
> >  #define AD7091R_REG_CONF_AUTO		BIT(8)
> >  #define AD7091R_REG_CONF_CMD		BIT(10)
> 
> 

