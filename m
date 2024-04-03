Return-Path: <linux-kernel+bounces-128956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4683189623D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B14284E73
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590D5168DE;
	Wed,  3 Apr 2024 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="BeMuzgLd"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A5B14006;
	Wed,  3 Apr 2024 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712109069; cv=none; b=kMf2m13RHOmsWqPIP3obTQTbkpN+AeubeyHrb9Lbn3J5mvl83+RSxj7vCRlpY3bzhdHm/islAxuomX3kmDsZbRQiojqly3sQGgMDjRlF7aGaOr8s1pedru7gcdV+y8rGKWrMNnxcvLt+NPtEUoWLE+7XpFkJM55TLkBobu9tiUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712109069; c=relaxed/simple;
	bh=AUn408o5zF2Evj1dSYZFE/QDZDOFRaaeO0o7pv48Alk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gk3dag+I+1WYMT96ZjYUFbPRDvz8A5nc0iMwX/cRG5Cdlist0Y/vm9Pn7+xGadxebbTQ7Oyg221Mug4WGgEWLmEBgS0+gd7ifBebytraCo6SD4Usls3tiNKKXvv7oGi1cma5QjrYo0wIohVHsC7jrHSSB42qLVQ4j1CJVO6svQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=BeMuzgLd; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=0ZpIemGJwBDqYoWurg9vfIC28+h0FY31ig8VDbMFrmw=;
	b=BeMuzgLdnvGuLOCMkTbmQAwjVJMeBmhogr59a3iI4UXujVHaf95L2PLet1RIbZ
	ogkpYCJ7IJmhCsk+qtJOcIkf47pYutC5fVYftaBOuBvZwlBvk81/aYm+2WWQpspD
	uaY7iXNZyFPeI53q51eCPf0vQng2jYROjsjc6A9KbCp6U=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrADX32X3tQxmi8CtAQ--.14739S3;
	Wed, 03 Apr 2024 09:50:48 +0800 (CST)
Date: Wed, 3 Apr 2024 09:50:47 +0800
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
Subject: Re: [PATCH] arch: arm: mxc: phyCARD-i.MX27: Add USB support
Message-ID: <Zgy191gmlZ9No5pi@dragon>
References: <20240328-pca100-v1-1-58df67c2c950@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-pca100-v1-1-58df67c2c950@pengutronix.de>
X-CM-TRANSID:ClUQrADX32X3tQxmi8CtAQ--.14739S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUI5fHUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFRi1ZV6NnBtGbQAAsi

On Tue, Apr 02, 2024 at 09:35:33AM +0200, Michael Grzeschik wrote:
> This patch adds the pinmux and nodes for usbotg and usbh2.
> 
> In v6 revision of the pca100 the usb phys were changed to usb3320 which
> are connected by their reset pins. We add the phy configuration to the
> description.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

"ARM: dts: ..." for subject prefix.

Shawn


