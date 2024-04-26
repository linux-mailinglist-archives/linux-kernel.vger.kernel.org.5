Return-Path: <linux-kernel+bounces-159403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5928B2E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37DE1C21DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3BA4A3F;
	Fri, 26 Apr 2024 00:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="jZHya2SQ"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C3D4685;
	Fri, 26 Apr 2024 00:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714093153; cv=none; b=JdevuRNCuOm4skXg+hJfcrEZl8gw88+wqAz8sksKEz3AaQG/t2UMs7+pi+uatpkv6FksPz7RQ0chgxtJmv7QxMhezieM0ZXjn0Vz4o9kQWCrdcw6FaHP9rlrelBBKFHZNGRA93OXTB2ui/T3Pl8oTQMJXWb9RPkOjEQzDbCXBg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714093153; c=relaxed/simple;
	bh=yOCDZvzSiMgXT1+ANWimx5Yi1spr4PiVR1sfXFbNTcg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUhoXYCf7w2o+EYrMFCtSJaQ3rZvyYVXveHUcN+lqLQuTSbA9Lz7HyPQRdkqLKbk3Z4DUKhocEwrfPD2k8L85T5WmenaXJTdZFOlNpkpAm2DWhGbWXKtJHhI9rVpvuNty2Mjx5nkS37jJEJg5WI+CgxE1dKdEi9ikHaY9bqteMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=jZHya2SQ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-127-66.adl-apt-pir-bras32.tpg.internode.on.net [14.2.127.66])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7711320075;
	Fri, 26 Apr 2024 08:59:09 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1714093150;
	bh=MAnTooQ3NWgoEkJO0tXSf39pJZ1lMIpBC5h/JQHXvew=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jZHya2SQ6YJ7VWUlGZbqB0aMCTZfYXBAsGHhVoMIGiACDXu8l7aI9qVxqPF6RStCa
	 /trLlmZPQAPAeGw9kVikC96f+Ur0+azQhWR3z3lXgosxtyh/Igijl0xzPTHjX/mv/z
	 kK77IgFgLZkNAWpa0x+wsDuh0CfA1sbFWhtVczMiwjd1dEYlIfFAJNZZQ6OZV9O/YP
	 t1CBaTlDYVgRgk1wNcq0eAuw39LeRq8KIl3Pdj7k5fEjGzdl0WJQTs+r92bEuDtBiV
	 jgAiObK3rdJKlKiRnv6qm98UTa9rW+OnY/rU1VIpEH5P6lET5M70qLCaXpVPPq4sab
	 oS/3+SJ8rYPWg==
Message-ID: <cfa6d4071f3789ee6ddef302f685c63d4de0ba36.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 2/2] Add nct7363 in yosemite4 dts
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 26 Apr 2024 10:29:08 +0930
In-Reply-To: <20240425060626.2558515-3-Delphine_CC_Chiu@wiwynn.com>
References: <20240425060626.2558515-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240425060626.2558515-3-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-25 at 14:06 +0800, Delphine CC Chiu wrote:
> ARM: dts: aspeed: yosemite4:

This should be in the patch subject, not the commit message body.

> Add nct7363(0x21 and 0x23) in yosemite4.dts
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index e45293762316..06b709b0a706 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -467,6 +467,42 @@ channel@5 {
>                                  };
>  			};
> =20
> +			hwmon0: hwmon@21 {

I feel hwmon describes a subsystem in linux more than it does hardware,
and using it for a node name feels a bit off to me. It's not listed in
the devicetree spec (v0.4) as a recommended generic name, and is only
used in a handful of devicetrees - two of which are ancient BMC
devicetrees:

((v6.9-rc5)) $ git grep -l hwmon@ -- arch/arm/boot/dts/
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-vesnin.dts
arch/arm/boot/dts/intel/ixp/intel-ixp42x-freecom-fsg-3.dts
arch/arm/boot/dts/intel/ixp/intel-ixp42x-gateworks-gw2348.dts
arch/arm/boot/dts/intel/ixp/intel-ixp43x-gateworks-gw2358.dts
arch/arm/boot/dts/marvell/armada-370-c200-v2.dts
arch/arm/boot/dts/marvell/armada-385-atl-x530.dts
arch/arm/boot/dts/microchip/lan966x.dtsi
arch/arm/boot/dts/nxp/imx/imx6q-apalis-eval-v1.2.dts
arch/arm/boot/dts/xilinx/zynq-zc702.dts

> +				compatible =3D "nuvoton,nct7363";

This compatible seems to be undocumented as of v6.9-rc5? Should you
also send a binding patch?

Andrew

