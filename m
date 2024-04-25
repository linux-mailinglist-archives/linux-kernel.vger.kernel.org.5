Return-Path: <linux-kernel+bounces-158045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEE98B1A98
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD92A1C2149B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CDA3EA9B;
	Thu, 25 Apr 2024 06:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="NPXOfC2K"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34ED3BBF1;
	Thu, 25 Apr 2024 06:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025101; cv=none; b=m1okDRjbh/mCzoVCkQL/fvXHEfAwBeJ82YxwndVG9cWfm88TfxYqdcFyfN5Ih0yrQ2nKibVevPUjyanYAe1YQ2go90GZOAW8fYnz6fxWaxBVBziGF2W0hEtNV+qU48lX7ssNeH2fqzNqBSJH6nZF/eiwl2qeSUNzpPP5WDONxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025101; c=relaxed/simple;
	bh=QUQG+Au4nyfmFO8jA9DZFlZEoXZH4qWYwBsqjio9lYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnM69y9pohppJfoN63aQJzb/DY+kbKAtZRHUyhCpWC1mvVp9O15Pr+zTUIM3sp/CZ/2QOAhAm+9xHsY1FVmqeeLQqRi7Cw0FVjE5gExv3sOHOMslOzsijxmd6IIqFKfpGArvHJK/0On2DjIjbVgURShUc5DsO/aWQk8WTstqqQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=NPXOfC2K; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=2C6s/85da0RJSSvd67KCawJgQFPLGk3aFoMgtZIA07M=;
	b=NPXOfC2KCL7xEYNz1EvZHBo1DlzqOegVGr9frQA1NigmvYj9f1uyfQX56FAQWk
	7N4BF0z4VXDpp7sQjU5PqaLrMum/7pCCY9m09mm0LdxKn/YcftzF8ofJjtu3pHNb
	TOh5SbL2Drp7fLXxImJl88ff4J6ACI+td1iBzGji8aALE=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrADX31Bd8ilmYzhzBA--.7650S3;
	Thu, 25 Apr 2024 14:04:16 +0800 (CST)
Date: Thu, 25 Apr 2024 14:04:13 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] arm: dts: nxp: imx6: fix esai related dtb_check
 warning
Message-ID: <ZinyXZ6NhhX1ETlI@dragon>
References: <20240416-esai_arm_dts_warning-v2-0-879e59c0c3b8@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-esai_arm_dts_warning-v2-0-879e59c0c3b8@nxp.com>
X-CM-TRANSID:C1UQrADX31Bd8ilmYzhzBA--.7650S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUV73kDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGAHLZV6Nnuy2QQAAsh

On Tue, Apr 16, 2024 at 10:47:46AM -0400, Frank Li wrote:
> Frank Li (4):
..
>       arm: dts: nxp: imx6sx: fix esai related warning when do dtb_check
>       arm: dts: nxp: imx6qdl: fix esai clock warning when do dtb_check

We historically use prefix "ARM: dts: ..." for i.MX arm DTS changes.

Fixed them up and applied.

Shawn


