Return-Path: <linux-kernel+bounces-77842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C6D860AE5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A2C1C223F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FFC12B98;
	Fri, 23 Feb 2024 06:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="dz8WNJUa"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A61812B6A;
	Fri, 23 Feb 2024 06:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670399; cv=none; b=HjeIF694qcwGDR95me2M6XCtSb4h+Bl7quCRFvtgAJvPT1lpRIX1Dxyo7QGLKXLf4pDnIKL+aXZBAVWr6qya359Ggw/l2iTmSrX2NpiMDfNrl0z1zQBXPrGbw4xzC25ZLbkfIKQrtdAgOejfVMtube3Btanb3TRawcnim+M3su4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670399; c=relaxed/simple;
	bh=KwiHJFK1Mbbz+BN9chz3t+DZpnNLTM0nxRYWqa83UmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPkVO4cvX7N1RLOkyFF5SU50sE76F/Ui9zwv8GOQUyNAPf11RwuOXPZChp5rTMAxupayYT615nZ/tadOp/0sif+8wMrkHTg/kh2N9fy03nfTXshaB9t2Jfi+sTYSMKulgHiFZeFcIZRDgZi+DVFr5zuoZ9q7H/gsayAsWaRbO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=dz8WNJUa; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=3msUX7Yu53rsu6BH2sOQ1nOJPUof7djniYPIovDSxFY=;
	b=dz8WNJUap54FKFNVZQJNaBjLRXwwEMwFnJ92OQhXTXMjKIoH0DIL+kaNdNV1od
	nKz3jrr+5wWM8ELe8235jCBVpzYz0/L6JH9iH+Y6BJavAiW3gcK/ySGPeH01qmb7
	OLAZvGJmc5yUmf3+yPsOwphCTP0bvcpLmLsDoHW0ZEOSQ=
Received: from dragon (unknown [183.213.196.200])
	by smtp2 (Coremail) with SMTP id C1UQrABHLYeRPdhleU4wBA--.7112S3;
	Fri, 23 Feb 2024 14:39:15 +0800 (CST)
Date: Fri, 23 Feb 2024 14:39:13 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] arm64: dts: imx8qm: add i2c4 and i2c4_lpcg node
Message-ID: <Zdg9kT35cKT+sVra@dragon>
References: <20240206225904.3565362-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206225904.3565362-1-Frank.Li@nxp.com>
X-CM-TRANSID:C1UQrABHLYeRPdhleU4wBA--.7112S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIxpnUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGBONZV6Nni+uTQAAsi

On Tue, Feb 06, 2024 at 05:59:03PM -0500, Frank Li wrote:
> Add i2c4 and i2c4_lpcg node for imx8qm.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied both, thanks!


