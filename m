Return-Path: <linux-kernel+bounces-54241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7648C84ACBD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 138C7B227B0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B6F74299;
	Tue,  6 Feb 2024 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmDxqupA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E9B1E86D;
	Tue,  6 Feb 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707189070; cv=none; b=dcP67akiAiuTKXyGh8J1DtPEHFn2F/AKFmgXRbwD5nRY8NSDo46ws9nQX4cnRITtMeyTMA5OShBUDMWfG/TU/D4naFeHa9mvP91BB3Fem/4PLda7ikkRziKI3NBwDap4up4MEmLaQoee7RQShGzKFHWrVCcCf7a3idkFiDLkkPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707189070; c=relaxed/simple;
	bh=JBbzQiMIyRNQkHSvJ9vi5exp7CSEo5Z8O7BLUiZ/mBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nal5YOWRKDuEP0tGnoNy3+Jeyza/W1zsM3fA+/tDgWoBLY/nbey5V23NDWGsQPMjg54chKyVcWaKWGFPZnMkqHo4LKY58dxzegEmy/3nNnCC8+zxIXjju0/roSD8cURRR4ZJ7q4H4ziJ3shO1UQ26GDd+PGSdCdVYA9KBO004z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmDxqupA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E16C433C7;
	Tue,  6 Feb 2024 03:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707189068;
	bh=JBbzQiMIyRNQkHSvJ9vi5exp7CSEo5Z8O7BLUiZ/mBU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=gmDxqupApi+IvheVBPHwfgCZY+3FTaeC4+Or0OO611MjRbNGbFvWIRWP528mtnX/r
	 eNphy238xKie014dn6UoEmVSiMctMho9mRKLRi65CW1BK5opN525Ju0SV84/SeuBET
	 EPpp36CB08qqpZgpkzESn0TThsoJ6mCyKlOr5VFp1BLAHn4+nZtT0EbwFav7o2xgkx
	 Iy+dEdip3+FZS7aKtqcIcaTsMenicIxdeoQdxCcTF7O1JVoX3K5lVPwiew9kyNzZ55
	 UxaEmcmCy0BB7+yzDDFpGapr1AJP7J3GHCtUCgJ4lMGTc5FXUV+79BVr7+9Ojm+ZII
	 z7VXBYOxWMR2g==
Message-ID: <f3ae2e5a-1850-461f-aa9c-2c7bceac8318@kernel.org>
Date: Mon, 5 Feb 2024 21:11:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: intel: agilex5: drop "master" I3C node
 name suffix
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?Przemys=C5=82aw_Gaj?= <pgaj@cadence.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Conor Culhane <conor.culhane@silvaco.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Boris Brezillon <bbrezillon@kernel.org>, Nicolas Pitre
 <npitre@baylibre.com>, linux-i3c@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
 <20240117075618.81932-3-krzysztof.kozlowski@linaro.org>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20240117075618.81932-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/17/24 01:56, Krzysztof Kozlowski wrote:
> Following change in the I3C bindings, the "master" suffix in I3C
> controller node name is discouraged (it is "controller" now) and not
> accurate (if device supports also target mode).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> The change can be applied through independent trees, if the I3C bindings
> change is applied.  Therefore please take it once I3C bindings is
> applied.
> ---
>   arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied.

Thanks,
Dinh


