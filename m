Return-Path: <linux-kernel+bounces-144462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72BB8A46AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DFC1C214BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51259FBF0;
	Mon, 15 Apr 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hBy7g+t/"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F1E3FDB;
	Mon, 15 Apr 2024 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146424; cv=none; b=Uf3P0zC+cj6F9nVsLMIGbl8WhKZGfqdijh9LOzBsRgBkdcVWg/E4cXD/8yNn4aVWrp3XF2+MI1lfecLc0pVCH4R6/BA75e2P++pMo7XAjxzOPpywSyPPsQCOXfX5Via4tBLaLu1udW5o1ztEb2m3oXHXdnhLDk0D3DI13GTmlUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146424; c=relaxed/simple;
	bh=vi9fj0oeHzZslS4vPIBn1Q71KptvDZx7SmvkEIXIF/I=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fAzgAXUieXegeuPa+qGqgoupg3YhayhBDHze5m2NQ2Yam8I9XrRSMCgpZbGJZueQpvqlbC0z9/3UslIrllOZzv4tanPi/Vv/FogSM9HmI+H3KBdt+ENjz6Tvo8UOMACd/uAL8gwVElhYkfgS/YBCfmf78FD1YgaxzlgNoANjwOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hBy7g+t/; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-127-66.adl-apt-pir-bras32.tpg.internode.on.net [14.2.127.66])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 02EBF20178;
	Mon, 15 Apr 2024 10:00:16 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1713146421;
	bh=4JN0tAr608v0a3WDiRHuCB76k+2EG5tPDD9zb/YKbbI=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=hBy7g+t/Ktc0HAQjVZsZridZcZqOWWQUY7N0QVUIDq3zNeN4Im8BKMf0qtOycLPXi
	 xBq4fpA/kaZH5goAwfoueX3uRkyimqDvxdbM52pyC3hfSDatmoJe1kl6ozjBTPs4CY
	 c60IMdkEeknajh1SnLUfVkJQrpEkaCyTofYpfp0oMJX/cwBmLOrAuJiLWp835MUUpJ
	 ky9NnYGT7Tkl/mHVXIXEA+ckKd7KWMT8CPcjfWmwy9gvqx2ln6DKxj5Yequ0yDiPAP
	 XDn7sDcV0z7drPRCSMhIljXQ+BFp5phmwfcxiysZD70PCq7vWWJT5pSfkNhcv/YCEG
	 p4cShrTqagJSg==
Message-ID: <3eb80a2f21a96cc0fc275db60631f673bb14e77f.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 00/12] Revise Meta(Facebook) Harma BMC(AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 15 Apr 2024 11:30:14 +0930
In-Reply-To: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
References: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-12 at 17:15 +0800, Peter Yin wrote:
> Summary:
> Revise linux device tree entry related to Meta(Facebook) Harma
> specific devices connected to BMC(AST2600) SoC.
>=20
> Base on : https://lore.kernel.org/all/CACPK8XePx+PvDKzPMjPRn_g9z8yrtAmLvP=
8Qbepm1AVjuCbaKw@mail.gmail.com/
>=20
> Change log:
>=20
> v4 -> v5
>   - Patch 0011 - Add retimer device
>   - Patch 0012 - Modify gpio line name
>=20
> v3 -> v4
>   - Patch 0010 - Revise node name
>   - fixed PDB temperature node name in Patch 0006
>=20
> v2 -> v3
>   - Patch 0007 - Revise max31790 address
>   - Patch 0008 - Harma: Add NIC Fru device
>   - Patch 0009 - Add ltc4286 device
>=20
> v1 -> v2
>   - Add infineon,slb9670 information for tpm.
>   - Patch 0006 - Add PDB temperature.
>=20
> v1
>   - Patch 0001 - Revise SGPIO line name.
>   - Patch 0002 - Mapping ttyS2 to UART4.
>   - Patch 0003 - Remove Vuart.
>   - Patch 0004 - Add cpu power good line name.
>   - Patch 0005 - Add spi-gpio.
>=20
> Peter Yin (12):
>   ARM: dts: aspeed: Harma: Revise SGPIO line name.
>   ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
>   ARM: dts: aspeed: Harma: Remove Vuart
>   ARM: dts: aspeed: Harma: Add cpu power good line name
>   ARM: dts: aspeed: Harma: Add spi-gpio
>   ARM: dts: aspeed: Harma: Add PDB temperature
>   ARM: dts: aspeed: Harma: Revise max31790 address
>   ARM: dts: aspeed: Harma: Add NIC Fru device
>   ARM: dts: aspeed: Harma: Add ltc4286 device
>   ARM: dts: aspeed: Harma: Revise node name
>   ARM: dts: aspeed: Harma: Add retimer device
>   ARM: dts: aspeed: Harma: Modify GPIO line name
>=20
>  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 107 ++++++++++++++----
>  1 file changed, 85 insertions(+), 22 deletions(-)
>=20

Joel had applied an earlier version of this series to his for-next
branch. I'm collecting patches targeting it while he's on leave. I've
updated the series he'd applied to the v5 you've posted here.

Can you please post any further changes as patches on top? You can find
my branch here:

https://github.com/amboar/linux/tree/for/bmc/dt-6.10

Andrew

