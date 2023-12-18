Return-Path: <linux-kernel+bounces-4157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8434C81789A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0111C24270
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3EF5A868;
	Mon, 18 Dec 2023 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hy4egaGl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EF85A853;
	Mon, 18 Dec 2023 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3d0faf262so4445475ad.3;
        Mon, 18 Dec 2023 09:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702920160; x=1703524960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=swHb+bpKc/FOLBJk5aXyiAe2btdfPThbJHNtTqWonqM=;
        b=hy4egaGld9dCL/hTvdaywVgNDkStp2w7uNvP4ZyVFRHAmFM2hCyJ2N0/SL52N8FBT+
         pSfp0WhWYXlouEERjFYI5SJNbNRJGdmt+keAEsK3qrWAk7Fd3AvbeaLEaNokGRu+wOqa
         a/vJ0WXLm7XMtDEQVPy9R8kLXPtoHry9GpYr8DWUy9wdAReF543C4G/pPXK/HljtosII
         jiPQs0AaeKr63+hH85RANiwGRr+vOMFLrsRvbgOWEMLujp2pu6fpzWiwsb6/cMKZEeIr
         ScoJbLbvTKtfxN+yhbpfXydHq7WdW/54uANOzb6hRvTDHZIYqXGysaGeimE+hE5dTrxH
         a5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702920160; x=1703524960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swHb+bpKc/FOLBJk5aXyiAe2btdfPThbJHNtTqWonqM=;
        b=WNNfS2/lKp7w2xelqoLNxfQZkJOS5fLkXXNzHKJxVk62ZCpMxu1WFCkbgIAbCaHCAN
         bfbpqXbncYCWfM5I3SvLHfJ303VL0SRJWEUxmtTnmaJDmTCqenMNwwteLfyRn0iji3dJ
         NhkQqyifSGML7gmp7xWLwVtVnH4noYo4qoPdaf/SgHbAHq4EeCtIi7WuKKjr4HlK5I1G
         8UdrJcLIew14cfSvplCkBQTxyaYsEVhBIWq71kMkBfzE311ykIrDVjJwJ8d1R1IAUES+
         szB6YozT4FnMBn5s66aeaMTWD0wy/MK5ZVtn1nfOiiKMA6WxQ9JyqhD10mj7z6EUlI08
         dCwA==
X-Gm-Message-State: AOJu0YzEhmLXgfaCamVVCd+xE1SnUcQBvJpKy7xUWQ6KdVxtwT9skb2Y
	7Z4DY/cQMLSHFULthZ4dGY4=
X-Google-Smtp-Source: AGHT+IGvWH3ApaJT30GMBDHaC6sU9MaWSJy/od8idTY+qKQ9TlOjtXAFqD551F0KAIyGyU9ZR2TVkQ==
X-Received: by 2002:a17:902:ab88:b0:1d3:9486:c222 with SMTP id f8-20020a170902ab8800b001d39486c222mr4719640plr.24.1702920160067;
        Mon, 18 Dec 2023 09:22:40 -0800 (PST)
Received: from localhost ([2804:30c:160d:b800:be05:2c5b:24c0:12aa])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902bccc00b001d072365b87sm19239452pls.106.2023.12.18.09.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:22:39 -0800 (PST)
Date: Mon, 18 Dec 2023 14:22:31 -0300
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
Subject: Re: [PATCH v4 03/15] iio: adc: ad7091r: Set alert bit in config
 register
Message-ID: <ZYB_1ymQEhUbdSki@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
 <e8da2ee98d6df88318b14baf3dc9630e20218418.1702746240.git.marcelo.schmitt1@gmail.com>
 <20231217145557.36d6a738@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217145557.36d6a738@jic23-huawei>

On 12/17, Jonathan Cameron wrote:
> On Sat, 16 Dec 2023 14:46:37 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > The ad7091r-base driver sets up an interrupt handler for firing events
> > when inputs are either above or below a certain threshold.
> > However, for the interrupt signal to come from the device it must be
> > configured to enable the ALERT/BUSY/GPO pin to be used as ALERT, which
> > was not being done until now.
> > Enable interrupt signals on the ALERT/BUSY/GPO pin by setting the proper
> > bit in the configuration register.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Hi Marcelo,
> 
> In V3 review I asked if this should have a fixes tag.  I've assumed for now
> the answer is no and applied it without.  If you let me know fast enough
> I can probably slip on in, but if not you may want to consider requesting
> a backport after this is upstream.

The events for these devices would not work both because of the broken
dereference fixed in patch 2 and the alert signal was not being enabled.
Patch 2 fixed a null pointer dereference that would lead to an error in the
kernel. This patch (on top of the previous one) makes the event generation
actually work although it's not fixing any errors.
I was hesitant in marking this one with a fixes tag too worrying I might be
adding too many fixes tags for a feature that never worked.
Anyway, looks like I should have added that so at least now I have learned something.
Will see how to ask backports for the fixing patches once they get in mainline.

Thanks

> 
> Applied to the togreg branch of iio.git and pushed out as testing for 0-day
> to take a look at it.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/ad7091r-base.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
> > index 0e5d3d2e9c98..8aaa854f816f 100644
> > --- a/drivers/iio/adc/ad7091r-base.c
> > +++ b/drivers/iio/adc/ad7091r-base.c
> > @@ -28,6 +28,7 @@
> >  #define AD7091R_REG_RESULT_CONV_RESULT(x)   ((x) & 0xfff)
> >  
> >  /* AD7091R_REG_CONF */
> > +#define AD7091R_REG_CONF_ALERT_EN   BIT(4)
> >  #define AD7091R_REG_CONF_AUTO   BIT(8)
> >  #define AD7091R_REG_CONF_CMD    BIT(10)
> >  
> > @@ -232,6 +233,11 @@ int ad7091r_probe(struct device *dev, const char *name,
> >  	iio_dev->channels = chip_info->channels;
> >  
> >  	if (irq) {
> > +		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
> > +					 AD7091R_REG_CONF_ALERT_EN, BIT(4));
> > +		if (ret)
> > +			return ret;
> > +
> >  		ret = devm_request_threaded_irq(dev, irq, NULL,
> >  				ad7091r_event_handler,
> >  				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, iio_dev);
> 

