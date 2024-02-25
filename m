Return-Path: <linux-kernel+bounces-80080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58106862A85
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C4DAB21120
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B232212E70;
	Sun, 25 Feb 2024 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="fQfwNdQU"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0D113FF9;
	Sun, 25 Feb 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708869379; cv=none; b=P/USGE1nsRlZxHTIrDP+dZ8oagDV7S/pFkWrPDTV3BhrsYS3GGSTusW+VdtOg9u+lTLcl56ts4dT/RO6YGycKHJgdZgHAiG/aWiU/QUHMNNEei03u97L+2875wKWlfi+FGVE7EjVadZvwiy7U7L1ZQp7KurJ4LY7xbnUt5r1Enc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708869379; c=relaxed/simple;
	bh=bFox5vt3yES0/bl+/cu7ObttgKmzLlYDLno0ZbZ2VV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiEOdrVQLfOFNrmBzeWOgWg4VTV9C7y12Crp+qVLj6Cn3Mq3x6Sbwk2C6eVzI7MiX77e1AXFWHWKfgt8vXWGupCcIiDrqhN1lV0anWs1BiY0AIkPQMvlL1cQRjabcburlveZ3N5XHEaKHRSF1tIfda8RQGlyi81ZeyefuCJx+5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=fQfwNdQU; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=C1f2qdKoa1bTwsGqLLsNBDfuOiDTBjlq3NCHtEYO1ds=;
	b=fQfwNdQUe2gH8ZIIUGG1skjcrUywQhJtA6N8B6E9EXLSGQVtCnlUMDDJxC8o0x
	MTK9BD4TtWxElr2GWTS/Bm/BGX4LnrZBrkn5CuoLLzI/gvh8yiNRwKLnOeQiLbrc
	4CO4ZZcxBOBz1IlBMwPFq4N114njtHcsxKX7Ybk6gaSUo=
Received: from dragon (unknown [183.213.196.200])
	by smtp1 (Coremail) with SMTP id ClUQrAAnjxPMRttl1sBXBA--.59498S3;
	Sun, 25 Feb 2024 21:55:26 +0800 (CST)
Date: Sun, 25 Feb 2024 21:55:24 +0800
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
Subject: Re: [PATCH v4 09/16] ARM: dts: imx6ul: Remove fsl,anatop from usbotg1
Message-ID: <ZdtGzO90NGXWj+y3@dragon>
References: <20240224213240.1854709-1-sre@kernel.org>
 <20240224213240.1854709-10-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224213240.1854709-10-sre@kernel.org>
X-CM-TRANSID:ClUQrAAnjxPMRttl1sBXBA--.59498S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUI6pBDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFQ6PZV6Nm6Z6iQAAss

On Sat, Feb 24, 2024 at 10:29:41PM +0100, Sebastian Reichel wrote:
> fsl,anatop should only be added to the usbphy nodes.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Applied, thanks!


