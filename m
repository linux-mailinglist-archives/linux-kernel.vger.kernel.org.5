Return-Path: <linux-kernel+bounces-79963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E3D862901
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69D2281AFA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8026610B;
	Sun, 25 Feb 2024 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="dQ0px0Vt"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2948F49;
	Sun, 25 Feb 2024 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708831432; cv=none; b=rQPmSESPwE1sN8bgZRlQn3dS0GqW8xR0h+L1QN7bw6Hu+5sfW9/SK853Dg7Qzp1F0Cdc/X7PHX1hNt96h+qL2g56n4DigIyeajAn9aRb4sqmtdWJWREvkbVLOR88/V/GbJ+mo/S9VCXvwkNGCSr3FnRaFHtzu3pIwDy/N7q3jG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708831432; c=relaxed/simple;
	bh=oNwmQ8Dhys+ewuZqO5KEgeY6Y2LW5Tzc+YP+zzv9rJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2ZIDUkmbBQs7I6tpsdu7bsWRJB714thOGpJXZEYwqOVi4Q5WUksqVYnDu4qWDOTU+HxvclDkqhrf9we2wIYcAU5yFz7eHabhOt5MhkC/ckB/UaCkjmX9tYQElTe8BL9oksHPkvM9XnCNuzYLrZ2Akit1yj9Jj8K5Uv7lGxg59k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=dQ0px0Vt; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=bfXn6aGSokp6ouTKx6H2cX2ZgHurpE61hgzLEPmiJEM=;
	b=dQ0px0Vt1r4hg10uRlO4CoM+SdPh98DrfJPL1dfPC/XaqBYkPS9PJbBJP25KuI
	vUNgae8lu1AFAtavboYNsJIooQ7YkySfv3RFKv4yGCAqrvJ5ODO0UNDweAmDE/zA
	8lE85PiXP6iCZ5rQdGbDh7LIYHCQoTmnEFftNfB8sG9Hs=
Received: from dragon (unknown [183.213.196.200])
	by smtp1 (Coremail) with SMTP id ClUQrAA33mysstplkjpRBA--.11604S3;
	Sun, 25 Feb 2024 11:23:25 +0800 (CST)
Date: Sun, 25 Feb 2024 11:23:24 +0800
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
Subject: Re: [PATCH] arm64: dts: imx8mn-beacon: Remove unnecessary clock
 configuration
Message-ID: <ZdqyrKQAVCwSsZ6e@dragon>
References: <20240211231802.188843-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211231802.188843-1-aford173@gmail.com>
X-CM-TRANSID:ClUQrAA33mysstplkjpRBA--.11604S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4GQ6DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFQ2PZV6Nm6WPWwAAsL

On Sun, Feb 11, 2024 at 05:18:02PM -0600, Adam Ford wrote:
> Since commit 8208181fe536 ("clk: imx: composite-8m:
> Add imx8m_divider_determine_rate") the lcdif controller has
> had the ability to set the disp_pixel_clk rate which propagates
> up the tree and sets the video_pll rate automatically.
> 
> As such, there is no need to define it in the board file.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!


