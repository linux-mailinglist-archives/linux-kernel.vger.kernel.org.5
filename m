Return-Path: <linux-kernel+bounces-59292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E30084F499
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DF06B2C0BC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23F62DF7D;
	Fri,  9 Feb 2024 11:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Wi6hb8hO"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA82C6A7;
	Fri,  9 Feb 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477987; cv=none; b=KF7PaX8CSWs8MmB0uXpXKF1nJPevGIXMtUDGiVnpZw9Y606jIA28h8gqYAW1QJHQyHwUhJ1XZwoevvmWaVJTjUwEdl5vbjOerJtwNcpFmw14Hw2aGBHK3Qcl7RKmeR59QJxaFKwOOEvA7xoA7U6cGA05wayZ/wvDAprgCOvD3hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477987; c=relaxed/simple;
	bh=qrTxNPGt0tx46+3vaH90V3SXkJ/6/wED8nPoNKoBGWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llDc8xJkpWxMsvhUFehwoOS+P7HifDHf9nB6ADODVjLweG0M3wuUVIdWH8j1zzEqcPpUvEvhOjxkAqb4GppZzT6/wUkdVYvCWdvVWVCO/1SQXyKb8rlRdB3Hr0ZrAtr5ZkC93v7ZYgN/y5HugTt39dlzHJFSZCeGw6um37cYygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Wi6hb8hO; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id D623222AD1;
	Fri,  9 Feb 2024 12:26:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707477982;
	bh=QuYIpP+1VdjtMdfsKQxrXnyWfx02MoIKGnpaz4s2Vos=; h=From:To:Subject;
	b=Wi6hb8hOpvoAzQLrE/tLoK2GnlmHrSf6GgO0sQreJcqm5krc8b1yliSjkPNSwWKP8
	 rlWswByIJhzkIdoZfPt7msVR6u50K74nmc/lpksf+eXlcHsaT3vG9+8CpxhSBE4fJA
	 8hkzIr637I0GkUpFA/flzq3wolRzDoEoeN8/tY5/fvzUru8vSIKj9J2sWbcLf1QP3/
	 n25wZYg8DOCANnUHjzog8ZvxjIjHMvcKJydrw6llZX88KGPx2T41ElTC/ZVsAaLENy
	 Te5yyDWrLxvJK5MW3PWc2RcdR09VeYrKiveTDVr20f3J5QO4w7subGGK1/YBU6lWuX
	 ZSMCkLQ0YkDXQ==
Date: Fri, 9 Feb 2024 12:26:18 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: add support for Verdin
 USB1 interface
Message-ID: <20240209112618.GA7066@francesco-nb>
References: <20240209110500.22193-1-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209110500.22193-1-andrejs.cainikovs@gmail.com>

On Fri, Feb 09, 2024 at 12:05:00PM +0100, Andrejs Cainikovs wrote:
> From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> 
> Add support for Verdin USB1 interface, implements role switch
> functionality using "gpio-usb-b-connector", VBUS is also now
> controlled with "regulator-fixed" using a standard GPIO.
> 
> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 55 +++++++++++++++++-----
>  1 file changed, 44 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> index 6a06724b6d16..bfd44f4a15cf 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> @@ -1013,7 +1041,7 @@ &main_gpio1 {
>  		"",
>  		"",
>  		"SODIMM_17",
> -		"", /* 50 */
> +		"SODIMM 155", /* 50 */

this should be "SODIMM_155"

Francesco


