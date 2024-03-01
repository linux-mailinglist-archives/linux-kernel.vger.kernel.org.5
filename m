Return-Path: <linux-kernel+bounces-87714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC99A86D817
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A551E284BDB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DA41FDB;
	Fri,  1 Mar 2024 00:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="TDvZPeRh"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837FE365;
	Fri,  1 Mar 2024 00:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251315; cv=none; b=WflXAJ2v3oHcMMotQjKWAh9ozlZzbi8KV9aeIAUTmZ5ZovpEMA/mBHm0kGkm+hYZssD+t/OEW18cXxpnV5spphaJElpTuOR/iiTtqIRg1UDOfrhjgDhvuTXtYHKLrOASA3EyTOJfZWf9YjhhlMYizV0+8gArw8nhSzsjEVw8YPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251315; c=relaxed/simple;
	bh=t0X7t7GGFniRIOEqYfK4TYBaU7eXwThHc9/pKtKp17w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JnQrwfxGJwTp4Pv5vAp6oFP505Lgjanu4Fb0/YkR77CXHtbOFkwlS+w3n28hUUGspaizJUlKUhuc4eqA/Yz0rt7f2ft5P4YMQL2puskOqtMslwq9fpqY2Axhkpvu81sfFrixkiXmDI1e9TOoWvL+Tb85B0ntvztJ+z72pXea82E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TDvZPeRh; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-70-176.adl-apt-pir-bras31.tpg.internode.on.net [14.2.70.176])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 21BD22012A;
	Fri,  1 Mar 2024 08:01:50 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1709251311;
	bh=wLcneC51g0yvr2rzTMvDPFpjn3ptVrIuHETKFxaBzdQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TDvZPeRhAQ/ae5/L624GhlPAeR3buY0n8UuSKpHSUNxzU+Oc12emprmoIoHsRaIeu
	 MkFUPSISftOmnJv+B1ew/H3oAvCgSoxsCgcJue/SizLC6PMC2ElnRb9Fgj0dA9ZkhC
	 yX/NfH5gtdMsaYAm595hUfiJwfeHC1hhAvVe4tLejzqS9SomPFYy10/gf+87knqox/
	 f44qFlLO3i4WKXEBykHfikAVUP1Y47xSuKxn8PweCj16eENDn7HPq8PP1GaJ1RaCys
	 sFUMhiZzA4J5CRayMyuEEpSzBYR49shqXw8LpD2HA15kz59xs/Ru87jSSCi0bScftq
	 kCtM4H64KHGSw==
Message-ID: <cc13d3f4fc7f117d0f29cf18a085066fd4b560cc.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 2/2] ARM: dts: aspeed: x4tf: Add dts for asus x4tf
 project
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kelly Hung <ppighouse@gmail.com>, robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, kelly_hung@asus.com, Allenyy_Hsu@asus.com
Date: Fri, 01 Mar 2024 10:31:47 +1030
In-Reply-To: <20240229111123.1932504-2-Kelly_Hung@asus.com>
References: <20240229111123.1932504-1-Kelly_Hung@asus.com>
	 <20240229111123.1932504-2-Kelly_Hung@asus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-29 at 19:11 +0800, Kelly Hung wrote:
> Base on aspeed-g6.dtsi and can boot into BMC console.
>=20
> Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
>=20
> ---
> V4 -> V5: None
> V3 -> V4: None
> V2 -> V3:
> - fmc lable change to bmc.
> - use 64M partition layout.
> - rename spi1 label to bios.
> - remove bios partition section.
> V1 -> V2:
> - do schema check and remove all warings.
> - remove all unnecessary sections.
> ---
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  | 581 ++++++++++++++++++
>  2 files changed, 582 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
>=20
> diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed=
/Makefile
> index d3ac20e31..32c41f3d9 100644
> --- a/arch/arm/boot/dts/aspeed/Makefile
> +++ b/arch/arm/boot/dts/aspeed/Makefile
> @@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
>  	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>  	aspeed-bmc-asrock-e3c246d4i.dtb \
>  	aspeed-bmc-asrock-romed8hm3.dtb \
> +	aspeed-bmc-asus-x4tf.dtb \
>  	aspeed-bmc-bytedance-g220a.dtb \
>  	aspeed-bmc-delta-ahe50dc.dtb \
>  	aspeed-bmc-facebook-bletchley.dtb \
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts b/arch/arm=
/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
> new file mode 100644
> index 000000000..64f4ed07c
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
> @@ -0,0 +1,581 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright 2024 ASUS Corp.
> +
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include "aspeed-g6-pinctrl.dtsi"

aspeed-g6.dtsi already includes aspeed-g6-pinctrl.dtsi, so the include
here is unnecessary.

Other than that the patch looks okay to me. There are bunch of issues
exposed by `make CHECK_DTBS=3Dy aspeed/aspeed-bmc-asus-x4tf.dtb`, however
they're almost all generic issues with aspeed-g6.dtsi or deficient
binding definitions for the Aspeed controllers. I've put together a
patch stack to clean them up and am working to upstream them.

So for now:

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

I'll put v5 in a tree for Joel to pick up if he doesn't have any
concerns. I'll drop the redundant include when applying the patch
there.

Andrew

