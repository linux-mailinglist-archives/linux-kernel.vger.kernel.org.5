Return-Path: <linux-kernel+bounces-77664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB27186089D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80FE2286084
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0135D533;
	Fri, 23 Feb 2024 01:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="NSgdTAdO"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C7AC2FD;
	Fri, 23 Feb 2024 01:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653461; cv=none; b=YukoanJjmZqP7tBdyiGEYWx4ARQyrbOW0/u2zrhDdyxVRRBq0keUw0vpGs1NGtKqrQQ6dDoA8Cx0eFPcVG2QSM560VWOXY0+cPOCUpgCTvL+dIac5kBpbQ8zsNEL5l7zXZGxC9EdTKzaTCi89bF4JF447RBVewHNJtRg5Ig2Cok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653461; c=relaxed/simple;
	bh=hBwffJ7jMGCDiB0p9hTJUjaOe5jLhvAZ7aMnm5aKVcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5g14eM6u3xdZpNzVGgO49bYEte9s59qcerYJg0WEvjnKhsKDqF1FByqjksYlTKNONHgkZkJw7zS9N2+forDCmdOr6kCcQt4hs/1+5K65UKYugxfWCtgknS2cCGtZ1u5UeH1T28OXjLSr4Wi5MLx9Y4aRIUHTSqEwLxEs6sUHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=NSgdTAdO; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=OEooxaF4zLYDzWIoYAZzSri3rr+zOurKcrfcxANxOgs=;
	b=NSgdTAdObK6rsdQ9cpn9K8k7BdomrLytMMepCfPf1trWsDaiY51gWvcBMM8jeX
	Kv25caY8pgMO4NPt34ndy5wDMzXPaIdbLjYZD2ACkryVfRZJ6ViLRI+EilXbDI+Z
	19sp3qMNKzxFcr12ryqXSkwADCQEmKfk5viwrGRjSlyj4=
Received: from dragon (unknown [183.213.196.200])
	by smtp1 (Coremail) with SMTP id ClUQrAAnjxNf+9dljfIrBA--.50594S3;
	Fri, 23 Feb 2024 09:56:50 +0800 (CST)
Date: Fri, 23 Feb 2024 09:56:47 +0800
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
Subject: Re: [PATCH 1/2] arm64: dts: imx8dxl: add fsl-dma.h dt-binding header
 file
Message-ID: <Zdf7X5T/Gf8Bmigk@dragon>
References: <20240129201633.234255-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129201633.234255-1-Frank.Li@nxp.com>
X-CM-TRANSID:ClUQrAAnjxNf+9dljfIrBA--.50594S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxtxhDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBQKNZVsVCTz3jQAAsu

On Mon, Jan 29, 2024 at 03:16:31PM -0500, Frank Li wrote:
> Add fsl-dma.h dt-binding header file in imx8dxl chip dtsi file.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied both, thanks!


