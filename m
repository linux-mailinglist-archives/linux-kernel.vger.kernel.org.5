Return-Path: <linux-kernel+bounces-116873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF2B88A4B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E991C23B47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043217173A;
	Mon, 25 Mar 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yybf2YRz"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816BB1B7F52
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364738; cv=none; b=Zcx1cjCxPuTgl9E2G5B0x+Ck/LDN9NTg4tO0gcFs3u7scN4KEXrOLs0u+Pybu2W9CrsMfKiLVaesD9QqJE9U9jmwkYvOWSLKBu4rWocN/eVGzqQPYCTxQ+5AmDMrOxPhZktVrObYD/mMsY2YSiHU7eW8cjOQqh0JnDTly3Txqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364738; c=relaxed/simple;
	bh=7iS7PHbquIUiCrCMtkBdkxuqi/jTqc2cY3j9OhS1Ij4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amU6HUlogVnGZnlNMmPLVRu/SXceIq/Lhf1WTSIviQJTNix1anVqWdyvAHkENvWP/kgIQVJXY/XHdiuPlBw3lY7wVLbH2m/5NPZj4GCsuGgD0yxqR4+/w7/oda4CfYW1b35FhgefcXB629xna+jsakP7Jkqg5RoksPfi5L8ehx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yybf2YRz; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso5143789a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711364734; x=1711969534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRILSzvwAIpvZwjiJmtXP3wS29AHppU0XGaszbPtEV8=;
        b=yybf2YRz6BdziJvnzuIzK0mlybWc0quywKx9lFEYwuMGpFGMwwuqd7rGVqTcWiCUW3
         u5Kf50ZmAXMWjZ+GVzGk7heO5znoRwDrB6jvIcukzzUm1eWgU/RVzCjnJRZpXBPLjo43
         CbKYaS4g1qIH+LPfFB38T6MPWDJbOo4WmrVcnpSb/pIB+LM7ftlKQxhZbjK6zezpxki1
         7QjLFn6ob9ipuRMF1uSgmuzp1bi2pqdlYVKXrfX+BqC3/qy0OfUiQfbvkVC2H6BEvZ7e
         v9aU1GJeto8AgaSTqYR1GBG2achbjMQBRMacmqkej2SVzjOfSuomr/GiDtspIxppE8gD
         f3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711364734; x=1711969534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRILSzvwAIpvZwjiJmtXP3wS29AHppU0XGaszbPtEV8=;
        b=eJU/hr6Ydma0LwbKZOMLzvvzXKu2CDKP9VhNSdWPvmYDcXshl62n0cDDujM4cQgQER
         eUbG/0Jle9NzTHKfC5zdcdP7RKB1AY/2lCjw7LHjLM60EVnNJLO67VJ2/1EdzE18Mmr0
         USa0/9Wo6o9cGodhhpG+lHQJwstojsPyhtC7zpZAqm4cUxS271mtdMYA0vtKYcvyntDP
         9HjC6EUfN5Yz9XwTs4vkIYwT7nJLV8XTj0m8OZHk/k0/lCeQowFCgTEBtIO++iz4JAXD
         A+aNDug6CYY3sArbNo/ayY/iAWGgMXUVoXtn8mRKlBRjSugQdLZyToOWd7Z64M3vc3wy
         xRUw==
X-Forwarded-Encrypted: i=1; AJvYcCWm2d/uYHLA3orl4oVkIcSJsJ/fE4HJpgrlHQwKcExgEhYNWap5LeE8RcKA6gnW4eYP4J1P3KH3fxJgL9UTahOWzlwJ7wJwSiF2yKPj
X-Gm-Message-State: AOJu0YxIO/N+RKTKq3NenJuIpCZ2VBZZD90HOiQJYfNRBdmz+zZuJDjm
	dszDWN/EdMmW90axP009O/r1xI1hyzu3rOAG0btrjghVozxq7eBXQzAB/PCqKM0=
X-Google-Smtp-Source: AGHT+IEhtdf7x6x6qjqq4K75Nxdbj/nJMl44w91CE9A41I8PB9hLaFhw4s15oV2TjS9l0ZLDyPjoIA==
X-Received: by 2002:a17:906:40ca:b0:a47:206b:5951 with SMTP id a10-20020a17090640ca00b00a47206b5951mr4770720ejk.59.1711364733579;
        Mon, 25 Mar 2024 04:05:33 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id m3-20020a1709061ec300b00a449026672esm2901792ejj.81.2024.03.25.04.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 04:05:33 -0700 (PDT)
Date: Mon, 25 Mar 2024 14:05:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Jonathan.Cameron@huawei.com, Laurent.pinchart@ideasonboard.com,
	airlied@gmail.com, andrzej.hajda@intel.com, arm@kernel.org,
	arnd@arndb.de, bamv2005@gmail.com, brgl@bgdev.pl, daniel@ffwll.ch,
	davem@davemloft.net, dianders@chromium.org,
	dri-devel@lists.freedesktop.org, eajames@linux.ibm.com,
	gaurav.jain@nxp.com, gregory.clement@bootlin.com,
	hdegoede@redhat.com, herbert@gondor.apana.org.au,
	horia.geanta@nxp.com, james.clark@arm.com, james@equiv.tech,
	jdelvare@suse.com, jernej.skrabec@gmail.com, jonas@kwiboo.se,
	linus.walleij@linaro.org, linux-crypto@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@roeck-us.net,
	maarten.lankhorst@linux.intel.com, mazziesaccount@gmail.com,
	mripard@kernel.org, naresh.solanki@9elements.com,
	neil.armstrong@linaro.org, pankaj.gupta@nxp.com,
	patrick.rudolph@9elements.com, rfoss@kernel.org, soc@kernel.org,
	tzimmermann@suse.de
Subject: Re: [PATCH v5 08/11] devm-helpers: Add resource managed version of
 debugfs directory create function
Message-ID: <486947a7-98fc-4884-a5fd-354677fa66ce@moroto.mountain>
References: <20240323164359.21642-1-kabel@kernel.org>
 <20240323164359.21642-9-kabel__6885.49310886941$1711212291$gmane$org@kernel.org>
 <f7c64a5a-2abc-4b7e-95db-7ca57b5427c0@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7c64a5a-2abc-4b7e-95db-7ca57b5427c0@wanadoo.fr>

On Sat, Mar 23, 2024 at 10:10:40PM +0100, Christophe JAILLET wrote:
> >   static int pvt_ts_dbgfs_create(struct pvt_device *pvt, struct device *dev)
> >   {
> > -	pvt->dbgfs_dir = debugfs_create_dir(dev_name(dev), NULL);
> > +	pvt->dbgfs_dir = devm_debugfs_create_dir(dev, dev_name(dev), NULL);
> > +	if (IS_ERR(pvt->dbgfs_dir))
> > +		return PTR_ERR(pvt->dbgfs_dir);
> 
> Not sure if the test and error handling should be added here.

Yep.  debugfs_create_dir() is not supposed to be checked here.  It
breaks the driver if CONFIG_DEBUGFS is disabled.  I have written a blog
about this:

https://staticthinking.wordpress.com/2023/07/24/debugfs-functions-are-not-supposed-to-be-checked/

regards,
dan carpenter


