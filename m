Return-Path: <linux-kernel+bounces-158094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D638B1B63
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4968D284E94
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F456A005;
	Thu, 25 Apr 2024 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="QNWc5fqZ"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260425BACF;
	Thu, 25 Apr 2024 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714028630; cv=none; b=DTE7yxxdjHxhn1CDqL9Rwg7FvLXcnCZ3c68FNja1EQ8/Rmikb56WXl6XKVR20gDh8Oyk5qVIZ9b1rjk5Gyv1bp1e+HHWSrOJH9TwLiwPO13Xt/gHYiZ8SFXm5/9RaDe6VCDHq9csr7GYYnM4PYM1VXN+vb5lYeel47kUh4OHtlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714028630; c=relaxed/simple;
	bh=a9pxUeSvXj0YjRIYapeT1g/Jcq2rXjn/otoGvhCnm94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foCwL7YPZiVofkqDQqR/TFp8OvDFzQi73cu7djf/z5QdAO4S3biuiJb07I9tQ67SKLQbpyFgUtyIBq+J396o39xvU5qPoShymSjbvh0CTcP5O7mjMeDoUj863JWOQU0IIT0KXnM8gQhiQM4So4S9ruoEIatjaxy3QecEqSjIfwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=QNWc5fqZ; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=8I5SepTp7Ur5JNM2XvBCPKYmcp0vIpHbn9Chz0RD2d8=;
	b=QNWc5fqZOwIxLUGcu2Ux9MWlSkGPKgx+TOSXNW/x+lxSWd7rp8+bXo5isHUJ+M
	H8xbjVM8IojV0RQMe7DvJ/CF6RdCU6gJkdLTsbPloslgobiLwdZeuMdmBhD8zG0t
	LNQNEEtJA3RNl9Mz+F0/6UsXv7Z7jeb6p3dA3X00wmMpw=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrADXX1AuACpmzAN0BA--.9663S3;
	Thu, 25 Apr 2024 15:03:11 +0800 (CST)
Date: Thu, 25 Apr 2024 15:03:10 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
	Luke Wang <ziniu.wang_1@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH v2 00/12] arm64: dts: imx93: various update
Message-ID: <ZioALo6flIQOu1Vk@dragon>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
X-CM-TRANSID:C1UQrADXX1AuACpmzAN0BA--.9663S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1UGrWktF1kWF48JFWUurg_yoW8XrWfpa
	93ZrZ3Kr1DKr4rZrsxZFn2y3y5Ca98W3W5Kr13X3s09ayYya47Z3W5KFy3Wr4UGryUZrW7
	t3ZxCFyvy342vr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jlWlkUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGALLZV6NnuzZkQABsc

On Fri, Apr 19, 2024 at 11:36:55AM +0800, Peng Fan (OSS) wrote:
> This patchset has several updates in imx93 dtsi and imx93-11x11-evk dts
> - add dma for lpspi/lpi2c
> - add nvmem for fec/eqos
> - update sdhc assigned clocks
> - update resource table for m33
> - add sleep pinctrl
> - add reset gpios for network phys
> - includes a defconfig patch to build in OCOTP ELE.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v2:
> - Add new patch 1 to convert dma bit mask to FSL_EDMA_RX
> - Use FSL_EDMA_RX for patch 2,3
> - Update commit log for patch 7. Add Fixes tag for patch 7.
> - Link to v1: https://lore.kernel.org/r/20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com
> 
> ---
> Haibo Chen (1):
>       arm64: dts: imx93: assign usdhc[1..3] root clock to 400MHz
> 
> Luke Wang (1):
>       arm64: dts: imx93-11x11-evk: add different usdhc pinctrl for different timing usage
> 
> Peng Fan (9):
>       arm64: dts: imx93: use FSL_EDMA_RX for rx channel
>       arm64: dts: imx93: add dma support for lpi2c[1..8]
>       arm64: dts: imx93: add dma support for lpspi[1..8]
>       arm64: dts: imx93: add nvmem property for fec1
>       arm64: dts: imx93: add nvmem property for eqos
>       arm64: dts: imx93-11x11-evk: update resource table address
>       arm64: dts: imx93-11x11-evk: add sleep pinctrl for eqos and fec
>       arm64: dts: imx93-11x11-evk: add sleep pinctrl for sdhc2
>       arm64: defconfig: build in OCOTP ELE
> 
> Wei Fang (1):
>       arm64: dts: imx93-11x11-evk: add reset gpios for ethernet PHYs

Applied all, except the defconfig one.


