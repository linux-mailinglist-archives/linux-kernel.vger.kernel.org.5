Return-Path: <linux-kernel+bounces-55620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545A084BF14
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096571F2457E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFAB1B956;
	Tue,  6 Feb 2024 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WcOizr7B"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E93F1B947;
	Tue,  6 Feb 2024 21:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707253964; cv=none; b=S8rmdeynlsJSXEiVSBfn9Jp2RXSHzQO1Z+yttshpuNYmP1LUzpfXh7RuiB1ajmrV0jCGSaeYMnMmk45ClDVrozb2ElBJo9zbjB9U4oskT26u01hnm4sNhIlwXHPwLOBw7SllqzcoNX7fooqDzpXXAf9FM18uD7WJmVXlUzXcjQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707253964; c=relaxed/simple;
	bh=FPuvvimZTpaY25Gs4EyvjPMeN6Ad+s68r//oKWLrE98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZHSCptCEOevTYFedKr985Ysm3RnIVpJy6eBE93DEUk+Zi9FWijwhAx6DiWy2772PD4qEXd/jk99vkSISlz4f25iSu1iNXGdeSVTcF+C5pie8DxmgQeUUHjGKT5hWnx2QByPYJ/Hh5v4p7xL6GKovN87UV8vsa+8TIGwlIyw8ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WcOizr7B; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5541A1C0002;
	Tue,  6 Feb 2024 21:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707253959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pH4z4UKwceDQ2f9zFX4FLpXxDjaZqCXvUUyn1++Jaag=;
	b=WcOizr7B6r3RSJEO2d4RUKr8qOpQnPtM3BbM8ZhVPH0bboCmQaVP35Ve06Vet6+OG7hOpz
	DEM9gWKljSJ65UWpjFy/CRK6Y0ZoRrfnjopM2Bam2GMga0j+WF2hEvXcKbBjNkU493sCjY
	yGV8L8LEzdKab7yy4M9K4B+YvjOGew3l1c3s+VOOtHBW3THZOOeNxpn3a+ZvOGqYPBLMcU
	f+qK8tkvXYqC9w2L5czXDVbt3vyiHM4mbQYfT044Z1+cEz+SxZ32GG7zpIaspd0qIpL0+s
	Yef6Zw59Rozepg5kjU989wQmbdR4W0267nMMDFVUyG3IF8XjxISSP1FAVizJzg==
Date: Tue, 6 Feb 2024 22:12:37 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"antoniu.miclaus@analog.com" <antoniu.miclaus@analog.com>,
	"noname.nuno@gmail.com" <noname.nuno@gmail.com>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
Subject: Re: [PATCH v6 2/2] dt-bindings: rtc: add max313xx RTCs
Message-ID: <20240206211237d9192660@mail.local>
References: <20240202025241.834283-1-chris.packham@alliedtelesis.co.nz>
 <20240202025241.834283-3-chris.packham@alliedtelesis.co.nz>
 <aecd80a3-a017-405f-b77d-6deda67ef704@linaro.org>
 <5d4b7fa1-5cc2-4a4a-8fa4-d2c7a8d070b7@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d4b7fa1-5cc2-4a4a-8fa4-d2c7a8d070b7@alliedtelesis.co.nz>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 06/02/2024 20:19:20+0000, Chris Packham wrote:
> That is an incredibly good point. The max31335 binding covers one specific chip. This binding covers more and with that there are a few more properties that the max31335 on it's own doesn't have (e.g. the clock consumer, the ability to have different i2c addresses). Binding wise I could probably roll all of the max31335 into this max313xx binding.
> 
> Driver wise things are a bit trickier. I've only got access to one of
> the variants so I am hoping to leverage the work Ibrahim had already
> done. I could attempt to incorporate max31335 support into the
> max313xx driver but I wouldn't really be able to test it properly and
> there is a reasonably high chance of regressing something.

But I won't take a separate driver. Everything would be better if Analog
was sharing the datasheets...


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

