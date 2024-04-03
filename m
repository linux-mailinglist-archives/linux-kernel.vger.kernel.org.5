Return-Path: <linux-kernel+bounces-128955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE9B896239
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED861C22500
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E76168A8;
	Wed,  3 Apr 2024 01:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="HqMo8bGW"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE327125CC;
	Wed,  3 Apr 2024 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108786; cv=none; b=pF1niQ392ex7yG1Yi+qcsq/fAfGD2Bds4e8A/gE0nv32CN4uLpeezEUvWM9Y6JMAkDj5ejS6FvHBbFleQU4Q+Z2oF3TNG2qS6MX+dzQJ62BjmO9Hsj7xRRxCvMxq77aO36OoPYjlT9i//uY+hvmMLs9a53DKjOZEVPRiop277ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108786; c=relaxed/simple;
	bh=MuznxIArtT+GpJBNXazw+Q5Rm/vUC2YziMQinmmP118=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baQz7wKjekgOMq9XBsyxHNC0zltmY5dTNxPP6VXnAHTYr2soJOGPwsn7sMFhpIKaZJcNTq2Cgo/3PGZE9pjT1/eyzimCsmAyRcZVl5iaR9kU5/uWB81RXnS4orTVX3mjn2ela20w6ZI6+X0jn4JhwxZ3idj4nvhqY/oBKRUMI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=HqMo8bGW; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=wI38BOff83Z3O570b58MMMyCQE8jw/HSaBPct6nheZw=;
	b=HqMo8bGW80N59J7AVklQNLtkhdt3Lmt0/fjZ14xq1zmIzbw+7qekdRb8+pgTlB
	Vzj+uQB0/oWpr99oTyFv/P9X34eXQxMr2xez6/lxTMBkkXDPQP5IlVdQZtpI23Ze
	3Nf4/GJjatmsrgJlNcQn8TpFyMsFeWFegEcYy8C+ZDPEw=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrADnDyDQtAxmZ6ytAQ--.3637S3;
	Wed, 03 Apr 2024 09:45:53 +0800 (CST)
Date: Wed, 3 Apr 2024 09:45:52 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v5 0/4] arm64: dts: imx8: add cm40 and cm40_uart
Message-ID: <Zgy00Iky4hXlK+Gc@dragon>
References: <20240402-m4_lpuart-v5-0-3292629ba808@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-m4_lpuart-v5-0-3292629ba808@nxp.com>
X-CM-TRANSID:ClUQrADnDyDQtAxmZ6ytAQ--.3637S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsyCJDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBRG1ZVsVCbg3pQAAsp

On Tue, Apr 02, 2024 at 10:41:27AM -0400, Frank Li wrote:
> Alice Guo (1):
>       arm64: dts: imx8dxl: add lpuart device in cm40 subsystem
> 
> Dong Aisheng (1):
>       arm64: dts: imx8: add cm40 subsystem dtsi
> 
> Frank Li (2):
>       arm64: dts: imx8dxl: update cm40 irq number information
>       dts: arm64: imx8dxl-evk: add lpuart1 and cm40 uart

arm64: dts: imx8dxl-evk: ...

Fixed it up and applied the series, thanks!

Shawn


