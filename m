Return-Path: <linux-kernel+bounces-32497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE99835C63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0657B2841A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFB520DE8;
	Mon, 22 Jan 2024 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JjuFux0T"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFC7210E0;
	Mon, 22 Jan 2024 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705911448; cv=none; b=lZ5JgOKAcBu0B/WQT8z0CDI6VWr1fiXKu1SrPnrGzmE1tcKu85lnTwUo8lbw3q9dQS+7AGt0gxnFQpI0Us4BCi7moIeSDSj4V9+4cQ8V1KbGUOXgIs0ksnxcfIrlKx2asGGJ2JH68D6jQFw+b2N4HTaFRdU7h249YjoBcURnUFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705911448; c=relaxed/simple;
	bh=aq/witDg2poUOUnqF60PQr7UvlvL7TKPJSmbDOt5ik8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SirgKTkwAddQwv8RI2VzPhcSDuuAZe5xyrZhd5CNE8EOqzBDxbophxeEpennJe/7sROWvc2xoftMHUbgHb2jo6a/D2oSSXe1MdEeAfmlGPcThTYmV+Pu4AUj9o23n/0YuVOZELwAHOeR3HtX1kLxvdV13G5+TUmKGKBXDdWKT9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JjuFux0T; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DAF611BF20D;
	Mon, 22 Jan 2024 08:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705911443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hftQ/3NQ3SEsGANsB0kuwB+4HmiO86h7hcHpWei/1cY=;
	b=JjuFux0TPgsxBh3Wr7htl8dzLwncaA4+bhaVv9DjNXlLHYsfxKhXWRrYnOqdccPFWYSZU9
	nNFBMmyBIWLVAGLqlnovcDgvQDTpJM4XF9OwsZ4VGK8s21Hkh0zFTCci0aDpFaglnJuBEC
	HXedDV07MNMJl+T0ZqExJpNZsTl2JGDXDarLF/EfYaKCjrxbSyOZmUbgnvFcG7h6ZLXgyo
	3h9D0EZf93N9d8qYXzBYH6pe6s43wiIWp6Ve+iaw0pIPsLYLUneUN1eJcAq8ZdEvk00N54
	BXNp5k31h49FARUEokf7um+pXt69qcw8NRSIwxkTncL9F4XUeiq1dujnyR55rw==
Date: Mon, 22 Jan 2024 09:17:22 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, chao.wei@sophgo.com, unicorn_wang@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dlan@gentoo.org
Subject: Re: [PATCH v7 2/3] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Message-ID: <20240122081722868bdda5@mail.local>
References: <20240122080631.2880-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122080631.2880-1-qiujingbao.dlmu@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 22/01/2024 16:06:30+0800, Jingbao Qiu wrote:
> Implement the RTC driver for CV1800, which able to provide time alarm
> and calibrate functionality.
> 
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> ---
> 
> Depends on https://lore.kernel.org/all/IA1PR20MB4953C774D41EDF1EADB6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com/

What is the dependency?


Also, please fix the checkpatch.pl --strict warnings

> +/**
> + * cv1800_rtc_32k_coarse_val_calib() - Using an external
> + * clock to coarse calibrate the crystal oscillator
> + * @info: the device of calibrated
> + *
> + * @return 0 on success, or -1 on fail
> + *
> + * This RTC has an independent 32KHz oscillator. However,
> + * the accuracy of this oscillator is easily affected by
> + * external environmental interference,resulting in lower
> + * accuracy than the internal oscillator.Therefore, a 25M
> + * crystal oscillator is used as a reference source to
> + * calibrate the RTC and improve its accuracy.Calibration
> + * is completed through two steps, namely rough calibration
> + * and fine calibration.
> + */
> +static int cv1800_rtc_32k_coarse_val_calib(struct cv1800_rtc_priv *info)

This is still not working as well as you think it is. You should
Implement the offset callbacks instead.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

