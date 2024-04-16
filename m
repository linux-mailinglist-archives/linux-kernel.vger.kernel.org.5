Return-Path: <linux-kernel+bounces-146368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CB98A6458
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178F31F22A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4584B6E619;
	Tue, 16 Apr 2024 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Xh9iSzh1"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02266EB52;
	Tue, 16 Apr 2024 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250237; cv=none; b=WVm7vbOxuDk3g4zM0ieNPvrDws5BlJdGXgR95z9bEJhFRMWTXi1tzyGwJ79kbHQGJDDQhiRkhE2puN0IRSpB3WrLAPe03xpsUMrW90Oe8Q/HliqRVfbVg0XWK4v632EjgTeYtGHPT/S08a+rZK+hqtg9j6YPNSlmNQaqW5fszFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250237; c=relaxed/simple;
	bh=YUGZwHqiq1W3MzxtYTRa8+HF8RgNF2wEckhkYevrEUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkaQXzdM3tDWbrZj97bKJYpAAC3G/xCqdUGn1grj3j6P5/sf5O0dxb1Vwg9Ob95pqRdLlnpYEuonKerHFqcCRg1ivKPudsWeVxadVUmEY2mQRdNVjkoVog68VXVKC/YFRct1oOjzTNLyFeqJKHo8G4jRN35KxhjUxbX2isaCtmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Xh9iSzh1; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0265D1FA40;
	Tue, 16 Apr 2024 08:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1713250231;
	bh=2JDMaBzmcBBzqO9RDDM7vP4GiAz+o6rv+8K49cAJSZk=; h=From:To:Subject;
	b=Xh9iSzh1Rh5ETY1mAwYy8F81MscjfJqphqCgVnOOjsMFHqU4/kunbKFer8UpjFhlY
	 YRYk1P+y7aH/STYbKP5Tk2ompVqP/0S1sT1TnM2Zqti2uIp6wvOpP7rwpB8+yfQHiu
	 pyGAJ1UmKDdqSI9vY1zEeO5HOBlKrYn1a8UYvR5cZY2IBl5V5GiM/i1hXfd+5YO2ce
	 q5yQTkJU7+dM6c/V78rzdnLE8qMqIwfL5JmD8ZnuULZj1gEWH7e+cfgGZjMH66/XDv
	 36nObQHSYoimyrMimLKxeQ7aUGqA+p+2xyoXp5q6uoF+ws/0UHjwcl1CWV6h9cot6z
	 ac13Anb+JEHPw==
Date: Tue, 16 Apr 2024 08:50:26 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] arm64: dts: imx8qm-ss-audio: add audio nodes
Message-ID: <20240416065026.GA4165@francesco-nb>
References: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
 <20240415-dts_8qm_audio-v1-2-2976c35a0c52@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415-dts_8qm_audio-v1-2-2976c35a0c52@nxp.com>

Hello Frank,

On Mon, Apr 15, 2024 at 03:46:38PM -0400, Frank Li wrote:
> Add i.MX8QM audio related nodes and update eDMA[0,1]'s information.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi | 473 +++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi          |  86 ++++
>  2 files changed, 559 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
> new file mode 100644
> index 0000000000000..ed5a1b4af1d76
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
> @@ -0,0 +1,473 @@
> +// SPDX-License-Identifier: GPL-2.0+

OR MIT?

Normally for device tree files having both is preferred.

> +/*
> + * Copyright 2024 NXP
> + *	Dong Aisheng <aisheng.dong@nxp.com>
> + */
> +
> +/delete-node/ &acm;
> +/delete-node/ &sai4;
> +/delete-node/ &sai5;
> +/delete-node/ &sai4_lpcg;
> +/delete-node/ &sai5_lpcg;

Can you explain these delete-node ? This is something that I would
expect when a dtsi is previously included, not in this case.

Francesco


