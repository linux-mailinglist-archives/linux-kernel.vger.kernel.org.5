Return-Path: <linux-kernel+bounces-158069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B2D8B1B01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B711F22F97
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2827044C68;
	Thu, 25 Apr 2024 06:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="WRPdkha1"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA283EA9B;
	Thu, 25 Apr 2024 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026481; cv=none; b=K9oeV+u1jtLGGG/qvLRLg/c6SzMs74jpjB3xRe+FRavIOcyiHOwost/ihErzs730BGo4f6102rEYqG8I4hW+71wC8/J+FRdzUSCRzZMeuxas3VfCQ+iYLbcJLLOgp3HYqeI8zjU/MeI7fd7K6OrIAi3Rjs4d9plDSu3BxZsMtgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026481; c=relaxed/simple;
	bh=SiMqzdMtou6kAayXXS0uiVZiQoklH13hCuMPwP1iRQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Us808wK5+mAd5+veIAF01/OvKckVJvGWWBL7yH98p0eTENnt5hkr1rbJZCh8ACRgC3R7BYcpgn5K2fUjTnE8bjRxfl6/LxABmqVIyJPuk4RnPiwrQOZEzgxyf2W381j2VRtZJVzpsTRRT7zctci8+OOzVe431ONy9BAo/fUfznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=WRPdkha1; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=D26qblXcQ4jrB+4QyFeKaKxnGrY0sSzMJdsfGunhcOI=;
	b=WRPdkha1CJ4RnL+zPIsf/x5T/GBduA+Wfu3Z8W6QlnHFmIsdShsPO1CFrmtfiz
	3WSVmr3s2fwL1vwYfKzs1CoMtAgc4inAWQcer/tXnm+7HKHUj6v+S0fzbW05lwGZ
	KiWBM6TEdDlDV3i2yjNtQvORVdJBOuU8TEMH/8jL5QwUM=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrAC3f0Gs9ylmbD9sAw--.38992S3;
	Thu, 25 Apr 2024 14:26:53 +0800 (CST)
Date: Thu, 25 Apr 2024 14:26:52 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: francesco@dolcini.it, festevam@gmail.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] arm64: dts: imx8qxp-mek: add cm40_i2c, wm8960 and
 sai[0,1,4,5]
Message-ID: <Zin3rNoY5JL7bv/L@dragon>
References: <20240417150829.333152-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417150829.333152-1-Frank.Li@nxp.com>
X-CM-TRANSID:ClUQrAC3f0Gs9ylmbD9sAw--.38992S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4IJmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDw-LZVnxcqq8GwAAs5

On Wed, Apr 17, 2024 at 11:08:29AM -0400, Frank Li wrote:
> Add cm40_i2c, wm8960 and sai[0,1,4,5] for imx8qxp-mek (SCH-38813).
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


