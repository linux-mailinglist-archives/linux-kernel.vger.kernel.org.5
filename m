Return-Path: <linux-kernel+bounces-158026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 373318B1A57
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835811F22C42
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9C23B796;
	Thu, 25 Apr 2024 05:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldFimn6V"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14603B78B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714023094; cv=none; b=QggoDO94mGZRFsFq4vI1RK8EvTXxHRfeIMQhPpNtUgJW4rBboGwyCT4EkkqUB6uarM1ZRszrFlDk3m7duOjasVnUtDrePqyj+ns4ZeVsFi8oraQZ0AvfR9GNodGXJRiADSFxjSYF4gIPdQtbrrpcyEo/ZgeNRgClh06e+zLlEew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714023094; c=relaxed/simple;
	bh=nVBrL7YJuNzCkb+t0TQFbZ+nLpcpPgHNZvsiUTjW2s0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n8r2gLSvj1CiJDQLes4XsKcUxe13xkG0dGOiOl2+b+ATtP4EeL8SR0DzCuUlsjg4wktXJiPZOuBbxfvKQzRxSsyKheHcTfaDcoaQw3e+RzalCPDF1VUGwmM8nEOX80uYwL6zlLF2eyIcMS6G2BRRmrETbXVpGE1Leb0HVby8KD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ldFimn6V; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so4872535e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714023091; x=1714627891; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cMmQUcIVgSzWuW2ZWEiFPzqJ+do6tt+UV73InjD+R7U=;
        b=ldFimn6VYEKPYfJ9z5hDKati26skJB1gGPdBZe0X7eJRUsk+gtLG2+DlOgM8AOh/Fr
         s7M+g4rwXfq+RQddUFeGF813CkiDWUYYiNXcWXR89Am46oIpkd3J9Oz6uyRnj/isW3Iw
         Gr3Q02mQ9ApYrTrPkuN2djPeRkQIL/ztKS6ENrhxcFVrVO6wfUtLunCN1wQK4ovue/V5
         X5vQ/bo+O8weL0PZR8gECG8aN9o9zSzn9e8bzh8OaB6re6N0Kf+ckxkEWI+Vr+VpqyiL
         nEZoiB6OE4rurow5bx6imA7zSTxrE2Fd8Zuo+RtIMIo6LdEV+SD8xTsCgEHM9qHKT/zS
         bMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714023091; x=1714627891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMmQUcIVgSzWuW2ZWEiFPzqJ+do6tt+UV73InjD+R7U=;
        b=OYBEXuYqB4wcav7KMOPKlGiRxNsTe/UpuIDs/+K6MmyJ5WYswOohR872B4+BcF6VUB
         wWXCD3X5BsvAX4bp2jqadtPeRH6RbRwPmib/vOoU/mGUV81IQif/Jvnfkxyz7ocaWHBx
         mePD0m5VGPXSQJhX0RYTt1JymhzYnCKiGQisPyqNCAYzN0KreDj6zLELokVo4n/y50b2
         4ptXtjzKFP1xSPq42cjnk5q4Vt4BUoXYB7IkRjvto6zsmRsDq8Qky1/1WiFaV6REbimS
         s8sOsJVflDbm36usPa2MhFyLvuaqJu1x7/Qqb9+mVr4ZLiZrvNF/65qXvQGf4881qmPV
         /H4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGEmbo9raoQfhqg3pQyXjYpMFqyHuEPv9WFnk0lr1SFZxNLMbWsURF0IaD3/WeEjqmGp7JsJf0es6xuLhu3KjZzUpqACZVnNOzHEPl
X-Gm-Message-State: AOJu0YycmHXqEV1Y73Bjc4XCoLmQ2+Ix7QT2BV5uOaayOYq45ZoD8t4e
	0Xg1l28lxBjUvTq8GUVzUTp8ahwxZL7yDpb7liJPhGnzDbpiKAx4iqwOHWYBXas=
X-Google-Smtp-Source: AGHT+IGnkVtA5Wtwo7q3DYXIHysN+Cu0EJxSPiMeca2h/hO/A4Gzv4GhNLke0XTi2A49j9T/1rc+tw==
X-Received: by 2002:a05:600c:4f8f:b0:418:58ac:7477 with SMTP id n15-20020a05600c4f8f00b0041858ac7477mr3171421wmq.30.1714023090830;
        Wed, 24 Apr 2024 22:31:30 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id fj3-20020a05600c0c8300b00416b2cbad06sm29941718wmb.41.2024.04.24.22.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 22:31:30 -0700 (PDT)
Date: Thu, 25 Apr 2024 08:31:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Aren Moynihan <aren@peacevolution.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Aren Moynihan <aren@peacevolution.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Willow Barraco <contact@willowbarraco.fr>
Subject: Re: [PATCH v2 2/6] iio: light: stk3310: Implement vdd supply and
 power it off during suspend
Message-ID: <b47ad9a6-2b17-497f-ac2d-33ffec1b2750@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423223309.1468198-4-aren@peacevolution.org>

Hi Aren,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aren-Moynihan/dt-bindings-iio-light-stk33xx-add-vdd-and-leda-regulators/20240424-064250
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240423223309.1468198-4-aren%40peacevolution.org
patch subject: [PATCH v2 2/6] iio: light: stk3310: Implement vdd supply and power it off during suspend
config: i386-randconfig-141-20240424 (https://download.01.org/0day-ci/archive/20240425/202404251021.4OPER3OS-lkp@intel.com/config)
compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202404251021.4OPER3OS-lkp@intel.com/

smatch warnings:
drivers/iio/light/stk3310.c:615 stk3310_probe() error: uninitialized symbol 'ret'.

vim +/ret +615 drivers/iio/light/stk3310.c

9046d80dce04c6 Uwe Kleine-König 2022-11-18  592  static int stk3310_probe(struct i2c_client *client)
be9e6229d67696 Tiberiu Breana   2015-04-27  593  {
be9e6229d67696 Tiberiu Breana   2015-04-27  594  	int ret;
be9e6229d67696 Tiberiu Breana   2015-04-27  595  	struct iio_dev *indio_dev;
be9e6229d67696 Tiberiu Breana   2015-04-27  596  	struct stk3310_data *data;
be9e6229d67696 Tiberiu Breana   2015-04-27  597  
be9e6229d67696 Tiberiu Breana   2015-04-27  598  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
be9e6229d67696 Tiberiu Breana   2015-04-27  599  	if (!indio_dev) {
be9e6229d67696 Tiberiu Breana   2015-04-27  600  		dev_err(&client->dev, "iio allocation failed!\n");
be9e6229d67696 Tiberiu Breana   2015-04-27  601  		return -ENOMEM;
be9e6229d67696 Tiberiu Breana   2015-04-27  602  	}
be9e6229d67696 Tiberiu Breana   2015-04-27  603  
be9e6229d67696 Tiberiu Breana   2015-04-27  604  	data = iio_priv(indio_dev);
be9e6229d67696 Tiberiu Breana   2015-04-27  605  	data->client = client;
be9e6229d67696 Tiberiu Breana   2015-04-27  606  	i2c_set_clientdata(client, indio_dev);
d6ecb01583d4e0 Arnaud Ferraris  2022-04-20  607  
d6ecb01583d4e0 Arnaud Ferraris  2022-04-20  608  	device_property_read_u32(&client->dev, "proximity-near-level",
d6ecb01583d4e0 Arnaud Ferraris  2022-04-20  609  				 &data->ps_near_level);
d6ecb01583d4e0 Arnaud Ferraris  2022-04-20  610  
be9e6229d67696 Tiberiu Breana   2015-04-27  611  	mutex_init(&data->lock);
be9e6229d67696 Tiberiu Breana   2015-04-27  612  
dd231c1d219f6b Ondrej Jirman    2024-04-23  613  	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
dd231c1d219f6b Ondrej Jirman    2024-04-23  614  	if (IS_ERR(data->vdd_reg))
dd231c1d219f6b Ondrej Jirman    2024-04-23 @615  		return dev_err_probe(&client->dev, ret, "get regulator vdd failed\n");

s/ret/PTR_ERR(data->vdd_reg)/

dd231c1d219f6b Ondrej Jirman    2024-04-23  616  
be9e6229d67696 Tiberiu Breana   2015-04-27  617  	ret = stk3310_regmap_init(data);
be9e6229d67696 Tiberiu Breana   2015-04-27  618  	if (ret < 0)
be9e6229d67696 Tiberiu Breana   2015-04-27  619  		return ret;
be9e6229d67696 Tiberiu Breana   2015-04-27  620  
be9e6229d67696 Tiberiu Breana   2015-04-27  621  	indio_dev->info = &stk3310_info;
be9e6229d67696 Tiberiu Breana   2015-04-27  622  	indio_dev->name = STK3310_DRIVER_NAME;
be9e6229d67696 Tiberiu Breana   2015-04-27  623  	indio_dev->modes = INDIO_DIRECT_MODE;
be9e6229d67696 Tiberiu Breana   2015-04-27  624  	indio_dev->channels = stk3310_channels;
be9e6229d67696 Tiberiu Breana   2015-04-27  625  	indio_dev->num_channels = ARRAY_SIZE(stk3310_channels);
be9e6229d67696 Tiberiu Breana   2015-04-27  626  
dd231c1d219f6b Ondrej Jirman    2024-04-23  627  	ret = regulator_enable(data->vdd_reg);
dd231c1d219f6b Ondrej Jirman    2024-04-23  628  	if (ret)
dd231c1d219f6b Ondrej Jirman    2024-04-23  629  		return dev_err_probe(&client->dev, ret,
dd231c1d219f6b Ondrej Jirman    2024-04-23  630  				     "regulator vdd enable failed\n");
dd231c1d219f6b Ondrej Jirman    2024-04-23  631  
dd231c1d219f6b Ondrej Jirman    2024-04-23  632  	/* we need a short delay to allow the chip time to power on */
dd231c1d219f6b Ondrej Jirman    2024-04-23  633  	fsleep(1000);
dd231c1d219f6b Ondrej Jirman    2024-04-23  634  
be9e6229d67696 Tiberiu Breana   2015-04-27  635  	ret = stk3310_init(indio_dev);
be9e6229d67696 Tiberiu Breana   2015-04-27  636  	if (ret < 0)
dd231c1d219f6b Ondrej Jirman    2024-04-23  637  		goto err_vdd_disable;
be9e6229d67696 Tiberiu Breana   2015-04-27  638  
6839c1b0700a79 Octavian Purdila 2015-09-23  639  	if (client->irq > 0) {
3dd477acbdd1f1 Tiberiu Breana   2015-04-27  640  		ret = devm_request_threaded_irq(&client->dev, client->irq,
3dd477acbdd1f1 Tiberiu Breana   2015-04-27  641  						stk3310_irq_handler,
3dd477acbdd1f1 Tiberiu Breana   2015-04-27  642  						stk3310_irq_event_handler,
3dd477acbdd1f1 Tiberiu Breana   2015-04-27  643  						IRQF_TRIGGER_FALLING |
3dd477acbdd1f1 Tiberiu Breana   2015-04-27  644  						IRQF_ONESHOT,
3dd477acbdd1f1 Tiberiu Breana   2015-04-27  645  						STK3310_EVENT, indio_dev);
7c7a9eeaa335df Hartmut Knaack   2015-07-09  646  		if (ret < 0) {
3dd477acbdd1f1 Tiberiu Breana   2015-04-27  647  			dev_err(&client->dev, "request irq %d failed\n",
3dd477acbdd1f1 Tiberiu Breana   2015-04-27  648  				client->irq);
7c7a9eeaa335df Hartmut Knaack   2015-07-09  649  			goto err_standby;
7c7a9eeaa335df Hartmut Knaack   2015-07-09  650  		}
3dd477acbdd1f1 Tiberiu Breana   2015-04-27  651  	}
3dd477acbdd1f1 Tiberiu Breana   2015-04-27  652  
037e966f2d6389 Hartmut Knaack   2015-07-09  653  	ret = iio_device_register(indio_dev);
037e966f2d6389 Hartmut Knaack   2015-07-09  654  	if (ret < 0) {
037e966f2d6389 Hartmut Knaack   2015-07-09  655  		dev_err(&client->dev, "device_register failed\n");
7c7a9eeaa335df Hartmut Knaack   2015-07-09  656  		goto err_standby;
037e966f2d6389 Hartmut Knaack   2015-07-09  657  	}
037e966f2d6389 Hartmut Knaack   2015-07-09  658  
7c7a9eeaa335df Hartmut Knaack   2015-07-09  659  	return 0;
7c7a9eeaa335df Hartmut Knaack   2015-07-09  660  
7c7a9eeaa335df Hartmut Knaack   2015-07-09  661  err_standby:
7c7a9eeaa335df Hartmut Knaack   2015-07-09  662  	stk3310_set_state(data, STK3310_STATE_STANDBY);
dd231c1d219f6b Ondrej Jirman    2024-04-23  663  err_vdd_disable:
dd231c1d219f6b Ondrej Jirman    2024-04-23  664  	regulator_disable(data->vdd_reg);
be9e6229d67696 Tiberiu Breana   2015-04-27  665  	return ret;
be9e6229d67696 Tiberiu Breana   2015-04-27  666  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


