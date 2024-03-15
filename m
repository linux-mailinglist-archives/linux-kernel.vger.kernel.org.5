Return-Path: <linux-kernel+bounces-104179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6005387CA47
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165A51F217C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3301759F;
	Fri, 15 Mar 2024 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="coxq74mW"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F813FF6;
	Fri, 15 Mar 2024 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710493011; cv=none; b=UbFCfI4ep7Zsw3O4Je7B3kki+xkC94j2Bl4m8Oc/siHFBNx7vNB86OlkOLYAe05Ti9AcR9mJAUfsAvNvXig6MNqUpNMAN7BnqjGb8VG0gaQiCgQQMV32rc4eUzcMYxOaoSv/RcvCuzJm19lw2mCHf8E4LdihtINJ2kBwSVy5fEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710493011; c=relaxed/simple;
	bh=qb61K5pWeATihhGuwsVduoUDAauKR/JGszeuHTFfYMg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=SIKxlQzcSBno/+p0dCMaliTqePj0BTk/hw3OqbOEOU/NUneyPkMFr1WINB/GwZNvq1zNQ3cpPai3SSMpJi/eXFoWt+YxAajnOnNNrNT4ASwhNpgLoWe7c82VrMeAlJXJaqc3aB/WLtpjM9jr6ZqcFfOYjRLTXC9yLS5W2g6BBZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=coxq74mW; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1710493005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kUz6qpyy9cdZkFMKb4gBD1woiTAQDRac1rAs4MrKdg=;
	b=coxq74mW/0rF9Q0Rb/Z800rMexLRbjJb9WGZ6alpM9dg172em/APKVn1/PIYdkysuh9srS
	ysoors/+/3TRH2kQXs7ndD0JpkITwRzrtFc+FnA+AIdwNjxbeNtewEzyzmLlRwaL0D1gxX
	IP1lkYFgq6xsJoASbM0iAm2nms5C780y7S5OLogioumm+X3lBRpvPIi3leDKTmguAsvalV
	1nwAYeDCFvqD5vIf3/0k4O9AUcpA3R1qB+Q6qy0oRKokgXbwnw1CN/AjJFYJkEMfcOPGp5
	JS5NPfigVcy83NZvHsgNjFN9rUB8mtt1bZ/tP9x3h1A+yaZQQ8Piond9FXEaDg==
Date: Fri, 15 Mar 2024 09:56:44 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Lorenz Brun
 <lorenz@brun.one>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add &gmac2phy in rk3328-rock64
In-Reply-To: <20240315084018.2200581-1-himanshu.bhavani@siliconsignals.io>
References: <20240315084018.2200581-1-himanshu.bhavani@siliconsignals.io>
Message-ID: <96a53f8560b3563328eaf7b9d6f63d87@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Himanshu,

On 2024-03-15 09:40, Himanshu Bhavani wrote:
> Add '&gmac2phy' node to enable ethernet1 on rk3328-rock64
> 
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> index 229fe9da9c2d..cb919367db54 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
> @@ -12,6 +12,7 @@ / {
> 
>  	aliases {
>  		ethernet0 = &gmac2io;
> +		ethernet1 = &gmac2phy;
>  		mmc0 = &sdmmc;
>  		mmc1 = &emmc;
>  	};
> @@ -392,3 +393,7 @@ &vop {
>  &vop_mmu {
>  	status = "okay";
>  };
> +
> +&gmac2phy {
> +	staus = "okay";
> +};

Unfortunately, this isn't an acceptable change to the Rock64 dts file.
Yes, there's the second built-in Ethernet interface in the RK3328 SoC,
but the Rock64 layout doesn't expose it as a separate physical network
interface, i.e. it isn't available as a port.

Such a change would be fine to be applied to the dts by hand, by someone
who actually adds a second physical network port to their Rock64.

