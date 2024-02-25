Return-Path: <linux-kernel+bounces-80077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31585862A7D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B938A1F21510
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7286F12E6A;
	Sun, 25 Feb 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="nMkrICdf"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8943B12B95;
	Sun, 25 Feb 2024 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708869302; cv=none; b=MwfT7BV+G2ie88s52dnuUvzeSPGwF5EJj/D8MtxlzYnoC36Pe5/XZMNwqItjYdP+yzP6K+KY73Ub+/7NfH9XmjUdxxR5ejb9vElo2p1qRKtAd16UhEkBSub/q+ZB3YDXs+yvd0odcCBL0KewAWrlOSYoIsszPpXoP+J8bKXmqZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708869302; c=relaxed/simple;
	bh=CF7ylrleXE8OYyD9KiFOOGPMOA1ygVTR4WBLFMktj1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFbiTUmuSK/pImVwCU6tBNDXX2OAPOqYjPwt8Mtk4aNW5vCH9AT1nncTyvInkX+3iThr7s9CD37zcOk+Hk4x9QhIwCJz26jE5K4di5C6jZ/TPaXZyloeT+sZBYcKXhcig77jLz3S0aJW2AjU/H5sSHr/pWTXrMQBvowJcCjQ6/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=nMkrICdf; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=y9oooywQXHAQODFZ5gFVoh+n8Q1+E35JxIjvw7KQnY4=;
	b=nMkrICdfr00DTogMaO0XroK/FNgDdRLt9TUzXpHQi9nA3/j7viIN9IFjZazvK7
	YHpyEGaL+j07HHxj5QfmbQNQCDFFdnve+X9gBJwF+l974N0YDfqOIe7Fl3nq66hK
	l41STSP+cXdUfXfsy3jfsM6QrDCwEb2EtvA72wQ2xfxLg=
Received: from dragon (unknown [183.213.196.200])
	by smtp2 (Coremail) with SMTP id C1UQrADXHyt3RttlS61WBA--.31690S3;
	Sun, 25 Feb 2024 21:54:01 +0800 (CST)
Date: Sun, 25 Feb 2024 21:53:59 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/16] ARM: dts: imx6ul: add missing
 #thermal-sensor-cells
Message-ID: <ZdtGdxBtS+Zxiovq@dragon>
References: <20240224213240.1854709-1-sre@kernel.org>
 <20240224213240.1854709-11-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224213240.1854709-11-sre@kernel.org>
X-CM-TRANSID:C1UQrADXHyt3RttlS61WBA--.31690S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUfDDGUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDhqPZVszYWKg0AAAsl

On Sat, Feb 24, 2024 at 10:29:42PM +0100, Sebastian Reichel wrote:
> Fix the following warning found via CHECK_DTBS:
> 
> tempmon: '#thermal-sensor-cells' is a required property
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Thanks for the patch!  But I had picked up the one [1] from Alexander
Stein.

Shawn

[1] https://lore.kernel.org/linux-arm-kernel/ZcCNdrQPb10i4rl2@t480/T/


