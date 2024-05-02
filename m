Return-Path: <linux-kernel+bounces-166615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B44058B9D14
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0AA1F217E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AFF15AAB8;
	Thu,  2 May 2024 15:09:47 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B411EB37;
	Thu,  2 May 2024 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662587; cv=none; b=uMawTX/QAWTE0tNjn2rb3d2u+7tfE7dnCe7quVpJA53HjzOcupzCUW/8R2ZXm4QymvJk+BL7GOmOb+/wsGDv354Uew5fuuX2ySSZlN6qTH2nvF8nj3Wi1Z8ZG6xPqzo8PVP2ssT+QgP0qE1WHT2M1E90Sb3k0ib6jrM8LUdjkIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662587; c=relaxed/simple;
	bh=APDCBbNTDHP0gxMNaAlwd0W5R4UUIyeqEqB4+Qh8MY0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRqQX2aTSivaQxusZe2vBGZJ2YS0V/ve3abK1bnMRYoY67H8E34GC48VpKaTtvSniIXgCXMkYtWpW3wXQcqpt6l4LEmVlBJIWKJHUMi7k7Q/wASbcsoop33S6X/GJnusv6WYwppwrr5xrPmjU23Gz51lDHmOhbPyu3nNvwo404w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VVcj92v0Jz6J6YS;
	Thu,  2 May 2024 23:06:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id ADDE214065C;
	Thu,  2 May 2024 23:09:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 2 May
 2024 16:09:40 +0100
Date: Thu, 2 May 2024 16:09:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Peter Rosin <peda@axentia.se>
CC: =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=
	<jpaulo.silvagoncalves@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <joao.goncalves@toradex.com>
Subject: Re: Supporting a Device with Switchable Current/Voltage Measurement
Message-ID: <20240502160938.00007691@Huawei.com>
In-Reply-To: <ad190ae3-48d2-a5db-dd36-d52b1c4cf460@axentia.se>
References: <20240501233853.32y4ev7jvas5ahdz@joaog-nb>
	<20240502133623.0000463e@Huawei.com>
	<44f47927-52aa-5248-6ae4-21028076fd51@axentia.se>
	<ad190ae3-48d2-a5db-dd36-d52b1c4cf460@axentia.se>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 2 May 2024 16:05:45 +0200
Peter Rosin <peda@axentia.se> wrote:

> 2024-05-02 at 15:49, Peter Rosin wrote:
> > Since you appear to need to change both the gpio pin and the io-channel, the
> > mux isn't a perfect fit. The closest you can get with the current code is to
> > create a gpio mux, I think. You would then use that mux twice to fan out both
> > io-channels, but only expose the "left leg" on the first fan-out and only the
> > "right leg" on the other. Something like this (untested, probably riddled with
> > errors, use salt etc etc):
> > 
> > rcs: raw-current-sense {
> > 	compatible = "current-sense-shunt";
> > 	io-channels = <&adc 0>;
> > 	io-channel-name = "raw-current";
> > 	#io-channel-cells = <1>;
> > 
> > 	shunt-resistor-micro-ohms = <3300000>;
> > };
> > 
> > rvs: raw-voltage-sense {
> > 	compatible = "voltage-divider";
> > 	io-channels = <&adc 1>;
> > 	io-channel-name = "raw-voltage";
> > 	#io-channel-cells = <1>;
> > 
> > 	output-ohms = <22>;
> > 	full-ohms = <222>;
> > };
> > 
> > mux: gpio-mux {
> > 	compatible = "gpio-mux";
> > 	#mux-control-cells = <0>;
> > 
> > 	gpios-mux = <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
> > };
> > 
> > current-sense {
> > 	compatible = "io-channel-mux";
> > 	io-channels = <&rcs 0>;
> > 	io-channel-names = "parent";
> > 
> > 	mux-controls = <&mux>;
> > 
> > 	channels = "current", "";
> > };
> > 
> > voltage-sense {
> > 	compatible = "io-channel-mux";
> > 	io-channels = <&rvs 0>;
> > 	io-channel-names = "parent";
> > 
> > 	mux-controls = <&mux>;
> > 
> > 	channels = "", "voltage";
> > };
> > 
> > What the mux solves is exclusion, so that the gpio pin is locked while
> > measurement is made on either current-sense or voltage-sense.
> > 
> > However, the channels from the raw-{current,voltage}-sense nodes are exposed
> > to user space, and it will be possible to make "raw" measurements without
> > regard to how the gpio pin is set. That will of course not yield the desired
> > results, but is also a user error and might not be a big problem?  
> 
> I just realized that it's also possible to do this "the other way around". Maybe
> that makes more sense?
Ah, I'd failed to realize that this is about routing a single wire
through two different analog circuits that end on 'different' ADC inputs.

Pictures would help me out btw!  Everyone loves ascii art.

Anyhow, I 'think' what you have here should work.

Jonathan

> 
> Cheers,
> Peter
> 
> mux: gpio-mux {
> 	compatible = "gpio-mux";
> 	#mux-control-cells = <0>;
> 
> 	gpios-mux = <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
> };
> 
> rcs: raw-current-sense {
> 	compatible = "io-channel-mux";
> 	io-channels = <&adc 0>;
> 	io-channel-names = "parent";
> 	#io-channel-cells = <1>;
> 
> 	mux-controls = <&mux>;
> 
> 	channels = "raw-current", "";
> };
> 
> rvs: raw-voltage-sense {
> 	compatible = "io-channel-mux";
> 	io-channels = <&adc 1>;
> 	io-channel-names = "parent";
> 	#io-channel-cells = <1>;
> 
> 	mux-controls = <&mux>;
> 
> 	channels = "", "raw-voltage";
> };
> 
> current-sense {
> 	compatible = "current-sense-shunt";
> 	io-channels = <&rcs 0>;
> 	io-channel-name = "current";
> 
> 	shunt-resistor-micro-ohms = <3300000>;
> };
> 
> voltage-sense {
> 	compatible = "voltage-divider";
> 	io-channels = <&rvs 1>;
> 	io-channel-name = "voltage";
> 
> 	output-ohms = <22>;
> 	full-ohms = <222>;
> };
> 
> Cheers,
> Peter


