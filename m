Return-Path: <linux-kernel+bounces-59761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F9D84FB7F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1B81C240BE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E284E7F491;
	Fri,  9 Feb 2024 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="KeL8jjIH"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070FB364D6;
	Fri,  9 Feb 2024 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501926; cv=none; b=qnrzn0vpE9GNEFQaAzo28NDPzzbc8Gh7KgwedW919ev5EYIg4xHfrHGqtBVBLUgqTyilfxc3AWLpq5Kc3uv7G3Gpy3KYkCA5W//GP1U+JDUK6azsFqHtijaBr0eEbdjxRTXtjGNn/OnjenKRREHOC6q4hh0CfriePOhybl31gRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501926; c=relaxed/simple;
	bh=lJyAU8yQz51SW8SOniYlqVu/+wOdi8AdTwmtfY7WCtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+kvu4b+UtRrLiMKkrS+Z1sNfkNPUok1Lq3Zb2/jqx4wVgAgXtg+ZXyditHz1OghP1mpWAiPQ3sShaCGJM5AvOempplv/kJCaEHMPQ/7gHeWH2n7P51DirYbvThmLBuc9VpcsP9PXnP/Jcw39f4WnRghB9sp8ECua4wPm9dR/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=KeL8jjIH; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EF8392073A;
	Fri,  9 Feb 2024 19:05:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707501919;
	bh=4QolG5s83ZgMBBHUDESDuQh8dOx2txXds4jPygj9pYc=; h=From:To:Subject;
	b=KeL8jjIHa9uWfkqypSt8R4bG6mhXZ3fROuLCo+zQQlGmTEIBEVno8vg3yYUKvjcuv
	 NaHtB6ra70WHL3ke7VGzn2vgM074PgLnwVMhMPVHiTpja4KzFrgEZMQRQreLAgp5bd
	 xOcm48ThYc86nfbWwP9jH+WQZ5rgbBp+GWfp3y8JQLR/iFmwJEYOzjMNXC1sNG0iWM
	 xY/gLcVFmlxDKCn+QAOnDDaOuP0Payb19AAvWi2rKe2n4DK/+89wtRvu07z6aKcqFd
	 Gt4SjVDSR29Wm/H/WOqtkOsnQsLTSlGB9J5fYyt4t1x896hdr/Zho9aZyU69QTYRXm
	 AZykZZZnNwkAQ==
Date: Fri, 9 Feb 2024 19:05:15 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Judith Mendez <jm@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 6/9] arm64: dts: ti: k3-am6*: Remove DLL properties
 for soft PHYs
Message-ID: <20240209180515.GA29650@francesco-nb>
References: <20240207225526.3953230-1-jm@ti.com>
 <20240207225526.3953230-7-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207225526.3953230-7-jm@ti.com>

On Wed, Feb 07, 2024 at 04:55:23PM -0600, Judith Mendez wrote:
> Remove DLL properties which are not applicable for soft PHYs
> since these PHYs do not have a DLL to enable.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi       | 3 ---
>  arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 3 ---
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi      | 1 -
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts        | 1 -
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts        | 1 -
>  arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 --
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi       | 1 -
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts        | 1 -
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts         | 1 -
>  9 files changed, 14 deletions(-)

you missed k3-am62-verdin-dev.dtsi and more ?

$ ack --dts -g k3-am6[24] | ack -x -l ti,driver-strength-ohm
arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi
arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
arch/arm64/boot/dts/ti/k3-am642-evm.dts
arch/arm64/boot/dts/ti/k3-am642-sk.dts
arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi

Francesco


