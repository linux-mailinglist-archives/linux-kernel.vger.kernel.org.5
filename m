Return-Path: <linux-kernel+bounces-93642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D750E8732B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00B61C21746
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E056E5DF34;
	Wed,  6 Mar 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F2TgoCUv"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AFA5D904;
	Wed,  6 Mar 2024 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718020; cv=none; b=HEi2e3ooAP/ystOzA/8wzPF39bYrFjmm7ZIo2yYen1amXkql5cC/L6tickX4X1KLAyM++HBrVX5jgoUZ7ZsA1INxnMpCRfvDdnjQ5idZdotWPBZ20lfxxKk3/k6yq+8PaxemTgANY/LgvsVUotda6x23ByFSgjtn3AoLZ/bVjBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718020; c=relaxed/simple;
	bh=799Tsb0xIH05EYhYK+RXjc9+4qLXqi3Jb64XLFVxStw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CfuCe43yTZAQM6u2v/30aOUab3LbvoUq1Upz9OvKUe78CVZENCx46zAkp8UmlBaZYPW3c718ZvcTAEXq7sH5NA1G7hWL5uXxHhowH42z4rz8NJ5c9uYfZlWowzzQu/vaF0u9OG4e9SoqLtG8JjJLEKM4AoMiw1tMXj3STtDCrsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F2TgoCUv; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A304C60007;
	Wed,  6 Mar 2024 09:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709718016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCGrsAuT0b0P0X1QOxE+TCi3XQ9pIjm2ZQrRXk6Wohc=;
	b=F2TgoCUvYbdq6tKAZgUhaVRHiF5tpGx87C+vLDeQ0NjTFAtW32EYjOJrJEzPK/K34hVIxk
	XhdJ2EOpqNrspqGR3XjPC+vmV7Ow9RVK69bz8gAvkWtvuspIbk94oXtcdiCY8teErIHMGi
	Xof6H0cXdzobS5C++hubRDNcnI2XGjFapcrkG25YH2kdpwhIBzh6CWJOzv5IG7i/Lk/pfn
	tXJAB1WXz6WSO5aZtGdfrcIWoNlGnet06YQu2jftROCVpXbZlSG0721M1Y4brg6W60mHSO
	QHWOwY8VxUR7yygsn3+SXbi9zVzPcgTBjTcgs7aapHWFgwcmZGMkFWM/ZXButQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 06 Mar 2024 10:40:15 +0100
From: Kamel BOUHARA <kamel.bouhara@bootlin.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Marco Felsch
 <m.felsch@pengutronix.de>, Jeff LaBundy <jeff@labundy.com>
Cc: catalin.popescu@leica-geosystems.com, mark.satterthwaite@touchnetix.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Gregory Clement
 <gregory.clement@bootlin.com>, bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v9 0/3] Input: Add TouchNetix axiom touchscreen driver
In-Reply-To: <20240301103909.167923-1-kamel.bouhara@bootlin.com>
References: <20240301103909.167923-1-kamel.bouhara@bootlin.com>
Message-ID: <6a93ecd5527b774a795942ec9c147ad5@bootlin.com>
X-Sender: kamel.bouhara@bootlin.com
Organization: Bootlin
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kamel.bouhara@bootlin.com

Le 2024-03-01 11:39, Kamel Bouhara a écrit :
> Add a new driver for the TouchNetix's axiom family of touchscreen
> controller. This driver only support i2c and can be later adapted for
> SPI and USB support.
> 

Hello,

Now that all the comments are addressed, do you think there is a chance 
that this driver could be merged for 6.9?

Regards,
--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

