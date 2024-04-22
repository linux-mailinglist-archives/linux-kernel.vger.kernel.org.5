Return-Path: <linux-kernel+bounces-152698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCBB8AC30E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2101F20FED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B6113AD8;
	Mon, 22 Apr 2024 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Kkbn6fSL"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EB8DDC3;
	Mon, 22 Apr 2024 03:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713756738; cv=none; b=E+9Y4OUrcoU3DP54rr1T32nSCkpvpVvglVJNa4Mi9ECkm2toKYG19D6/22BWWsyf7vt2x7daiGnKzC8UEKcEwOFsDeUljxMXyONwHPsSctj6X0attXv6WzonTx9UxkP26sn9aSV1F0PkujD7iJbYsq/CvIge/t47AJS5e8J1QiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713756738; c=relaxed/simple;
	bh=cgvVnOJwSqppiRYMyowCy4bS37KD0SONJ+bAG97oKHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swEuqAZwbprecMjH4CyA7rbwAk8AgQyBVlb438aubvzSwjcfc1onX7AquaXta2/fWphgwWwBajfc4CAXifPZoRZrzhqpZbiXrtJR+CWoUs1Cyc+C9RuZwNSJQAm4e5TQLppHd35Vg8e5lDYVTzkD2hjcDMRY/vQBeQ6V1QrL9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Kkbn6fSL; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=zXYjhFJrfJrOFJVIHpqe8pUDrSVH85/rIRMIUD46vag=;
	b=Kkbn6fSL2v0XjZzmcDc1Mxa1/1fGzoLT3Ex5EuIOjO6+hb36vUsOi3EpHbzwtV
	e8TrZxf6DokS1GXMX/ZGMWeWeBAjF9WbJOu0gFOksL68fsdXEBOZMEJEMBoDAp+I
	K4r/p6KMEpOrgBxaK9PFRN8rYde5ea6HxC9aswTHxW+nQ=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrADHLxkh2iVmFM0xBA--.28399S3;
	Mon, 22 Apr 2024 11:31:46 +0800 (CST)
Date: Mon, 22 Apr 2024 11:31:44 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: imx27-phytec: Add USB support
Message-ID: <ZiXaIMCatpF6jPUY@dragon>
References: <20240328-pca100-v2-1-d7ff1679f75b@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-pca100-v2-1-d7ff1679f75b@pengutronix.de>
X-CM-TRANSID:C1UQrADHLxkh2iVmFM0xBA--.28399S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4IJmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDgLIZVszYg77igAAsU

On Wed, Apr 03, 2024 at 10:18:27AM +0200, Michael Grzeschik wrote:
> This patch adds the pinmux and nodes for usbotg and usbh2.
> 
> In v6 revision of the pca100 the usb phys were changed to usb3320 which
> are connected by their reset pins. We add the phy configuration to the
> description.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Applied, thanks!


