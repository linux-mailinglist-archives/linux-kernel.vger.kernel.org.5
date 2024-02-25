Return-Path: <linux-kernel+bounces-79962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DAE8628FF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81698B211C5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37DC610B;
	Sun, 25 Feb 2024 03:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Jfef2hm9"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76797460;
	Sun, 25 Feb 2024 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708831362; cv=none; b=cGnF7jtZ23pvNShjNiaRTOlA+lpj8VPPgrUVPg9hg2Sbpa/71qB1OSnU7ht4OBhFguMUoMcihhP2bhW0seCBjtD9Q0EYUK1ErV7UdLGaE/qr9Z9bTmwIPfr9S7q+rtzmMwUkv72GGmVrWE5EDfeN3ueNBN6NMCznS5gDGT/u/aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708831362; c=relaxed/simple;
	bh=t7izA1++TpQnw4MKZdATx3B+DYwSyzXeTLi1/tEOcoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ipr3t36ffcGD9sg2ScooYd+R1rqKu447Sn/Hehfr4CZg6nJewY7x8yYgBEICjPUkPMb7XS5RIseCt01Yf1fKsUpos/plWESZbPdWaTyTfXtHWnZPpDIXt/83JveJ02NeyP+JzzTpDww6DrxDh/tGpVGjO6Pjdiui6cXFiTLajBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Jfef2hm9; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=kstgYFnYbS4TM+8qLmC87++xXjnye/1CI6vcEBA0fnI=;
	b=Jfef2hm9LFdr/bzxrSTS8LHUdMaXye0reEtq23oBTRBuzBGfudVbv6oKqNC5HG
	2POCsxwCZrfdWP/kloxpPxY+JPoAo3GOOsDdIp87x7kLu/khU/eBSckKuWs4cHLG
	/1ZeV9Kmzz38GBAw4jm3pMirfeuaLAt4eQilURT6H7z7c=
Received: from dragon (unknown [183.213.196.200])
	by smtp1 (Coremail) with SMTP id ClUQrADX3O1kstplwDhRBA--.11765S3;
	Sun, 25 Feb 2024 11:22:14 +0800 (CST)
Date: Sun, 25 Feb 2024 11:22:12 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de,
	aford@beaconembedded.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mn: Slow default video_pll clock rate
Message-ID: <ZdqyZCudSlazj7gW@dragon>
References: <20240211231508.188567-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211231508.188567-1-aford173@gmail.com>
X-CM-TRANSID:ClUQrADX3O1kstplwDhRBA--.11765S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GryrXr1UWFy8GF4fXFWrZrb_yoW3Gwc_ur
	W5JF4vkw15Xrs3Kr1DKF45Zw1xZa129Fy5Xw1kWr4vgry8Za95ta4kZF1ruF17Wa9a934D
	X3s5Xr1a9rZxAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8z6wtUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDg+PZVszYWG3kAACsm

On Sun, Feb 11, 2024 at 05:15:08PM -0600, Adam Ford wrote:
> Since commit 8208181fe536 ("clk: imx: composite-8m:
> Add imx8m_divider_determine_rate") the lcdif controller has
> had the ability to set the disp_pixel_clk rate which propagates
> up the tree and sets the video_pll rate automatically.
> 
> By setting this value low, it will force the recalculation of
> video_pll to the lowest rate needed by lcdif instead of
> dividing a larger clock down to the desired clock speed. This
> has the  advantage of being able to lower the video_pll rate
> from 594MHz to 148.5MHz when operating at 1080p. It can go even
> lower when operating at lower resolutions and refresh rates.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!


