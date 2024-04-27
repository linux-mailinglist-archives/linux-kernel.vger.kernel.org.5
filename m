Return-Path: <linux-kernel+bounces-161159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37718B47CC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 22:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7E8281CCA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 20:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426D2143C7B;
	Sat, 27 Apr 2024 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="RL8s896W"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E23112836B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714248818; cv=none; b=LXhzee5A60pr7SAOCuyGpYnujUTMIpPgh2FR7UCcG+c5Qf8HJ2GMtAxZUjnCEbwpoLm3ix6dKs//6ilfJ0iuSctu5U+1yv5hi41His7OVpv0q4L0T8OHiyzYBhY0ZUS6ZV2v2znymIc9/BkLSDoJfx4rrMkY07Nnu6JdICAzr6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714248818; c=relaxed/simple;
	bh=wGN6bj0kx4wdQZ7bd1/jkomx57IfKd1M7hVYebziA/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1wjYFR+Cd6oSzH+z6+77p+RrFrjv23tPy0ZPX6+tez+iVEj30WREqFzUhnzywJeqDIQGhJha9meu/vYvHesjobfzk8sPGWANLyjI83I/vIc2qJ7OeMQqTWCLV2u0BVZG2XWpYqbuQmvUHSeL4saCyCrBj8Sxt3Z1tT11C09fN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=RL8s896W; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so36766251fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 13:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714248815; x=1714853615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7PcVoVCgAUFYmI7HjTKiahQ20SBHs/bY7KmtF5ZOEs=;
        b=RL8s896WiHKw/CAe6HK6UU9sZ6rjTdtD0NkGIwMqxkyu0+WT9y/NDh27hy/xIPy9of
         Bc9gWWUGklv1sGPalWA4N19xnJGgwnXwNCxUffK70xz+6AuUjO34NHMwo2+kWLrmKqm5
         egRMt8z/rO2AP+MgvjtH113CVfOObWazxCxNA8MJJy3EfROuawu38w/V8eQQBDTCm5cn
         ybXqhu9hom/oPbcDiOW0WL0M0rxAqVehGtJRMVbPQc1DZUP2EmyyLqsublL39j2NXFiB
         SK0O/kMbUga5Xm0EySTtCRJeNXqsGVzwPtNQlyhoj78J3RVEqs3fFEOqdiDInRxG088B
         dzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714248815; x=1714853615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7PcVoVCgAUFYmI7HjTKiahQ20SBHs/bY7KmtF5ZOEs=;
        b=ANJbRByKXcc63tdBczhkYytinu9SVxDXsBp+2aQJNYwKjZNmc9I0xq7+fvx0Jo/w/5
         /ks4AWOy9B8vtLwDVPhVms07peDC5P5Flw5Ypr8S3Vl+i9inWa08CdGCAoaBEAqLQUat
         sQ1WvHvyJPcVAH1LMNRjUaW82NXj/nRHlYPfr3J/HnSHmNhfAx8QGa/lNztEI4BqVwMS
         1SuGJir/FhNPgVcXZ2N4CbuYdaN2vd735K1nP6gQS6Sng8uVhm88esNpJC6UDiyPEdWi
         eNMk9yQSlgpFBtDfvNp7EQPnutzx86EM7bxYRXmSgq6bxqCji9MtpdYBzaZ6ilufoZRT
         O22A==
X-Forwarded-Encrypted: i=1; AJvYcCWw+EHbeCOHVQIWkytFUYEQV6Jvg8ZpBFNqy8RvklX5yLR6aZ7XNC8cb+LpjQeqjf6xlZHPtb62q48CNWv3RxUssorA7dB/4hbgL76h
X-Gm-Message-State: AOJu0Yz9/i2Kpixw4I0bscFx4BxQCCj5My4tXpDQZ+zPguXOXUBfM7YB
	sZNa24pt5ueyTz422gDP97chw6s1040Z177j4/u2+1OoHCxQJzAgQFFNy4mL+AE=
X-Google-Smtp-Source: AGHT+IF6o3RLIgU5nqneRSQOEV5Q7GKgH1RiuCDeT4uFt/t6nA1KoF1F5yKLoEtiyshDT9jTj4ws2Q==
X-Received: by 2002:a05:651c:69f:b0:2d8:7bbf:fd01 with SMTP id x31-20020a05651c069f00b002d87bbffd01mr3277311ljb.15.1714248815226;
        Sat, 27 Apr 2024 13:13:35 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id e1-20020a2e9301000000b002de118decbbsm1558689ljh.53.2024.04.27.13.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 13:13:34 -0700 (PDT)
Date: Sat, 27 Apr 2024 22:13:33 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Conor Dooley <conor@kernel.org>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 11/12] microchip: lan865x: add driver support
 for Microchip's LAN865X MAC-PHY
Message-ID: <Zi1cbScrKzFN3PNT@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-12-Parthiban.Veerasooran@microchip.com>
 <Zi1PxgANUWh1S0sO@builder>
 <20240427-vaporizer-pencil-be6a25030f08@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427-vaporizer-pencil-be6a25030f08@spud>

On Sat, Apr 27, 2024 at 08:57:43PM +0100, Conor Dooley wrote:
> >  static const struct of_device_id lan865x_dt_ids[] = {
> > -       { .compatible = "microchip,lan8651", "microchip,lan8650" },
> 
> Huh, that's very strange. I don't see a single instance in the tree of a
> of_device_id struct like this with two compatibles like this (at least
> with a search of `rg "\.compatible.*\", \"" drivers/`.
> 
> Given the fallbacks in the binding, only "microchip,lan8650" actually
> needs to be here.
> 
> > +       { .compatible = "microchip,lan865x", "microchip,lan8650" },
> >         { /* Sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, lan865x_dt_ids);
> > 
> > Along with compatible = "microchip,lan865x" in the dts
> 
> Just to be clear, the compatible w/ an x is unacceptable due to the
> wildcard and the binding should stay as-is. Whatever probing bugs
> the code has need to be resolved instead :)
> 

All right, so when I change to

@@ -364,7 +364,7 @@ static void lan865x_remove(struct spi_device *spi)
 }

 static const struct of_device_id lan865x_dt_ids[] = {
-       { .compatible = "microchip,lan8651", "microchip,lan8650" },
+       { .compatible = "microchip,lan8650" },
        { /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lan865x_dt_ids);

I still get the output
[    0.124266] SPI driver lan865x has no spi_device_id for microchip,lan8650
But the driver does probe and I get a network interface.

If no one beats me to it I'll single step the probe tomorrow.
R

