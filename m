Return-Path: <linux-kernel+bounces-47674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC8B845110
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC804B23494
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0498982893;
	Thu,  1 Feb 2024 05:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="DM8xbrHo"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81278286F;
	Thu,  1 Feb 2024 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766816; cv=none; b=GZ/2qUakKwHhiOF+AGe7gWjYDds0UKkp8DFqz8TkCwyK8VDm2tAvpQzxVo0CduE6M/m18DVIwS6ftG/G3U2Pq0myq2iq6BkAegDok9yvzWSAhncrmcSj8tDol68pJqwRhFJF4PLIU9m+oetXCoQpFMC4IUcPyBzAz+z7s2FrdcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766816; c=relaxed/simple;
	bh=AMDcIniZzCTTe3m6Kx1T7sK45RG+dKky3PyruYQqQJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W/7BYG5jz8da3fHFKzx7BP+zVBDCCWTtMtpW+Mln/Lz72bV28zcWTEBdqiAzvIhJmFrYTW/gY4c3K5xhR1nD20s/NA6bAw9yWrfRA5P+ohasRyXuKjrnPRGHhDZRbpwDiWnUTTgZolir1loHEtEr8iA0QcbmK/5HW+LNX+V0+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=DM8xbrHo; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-76-194.adl-apt-pir-bras31.tpg.internode.on.net [14.2.76.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B8E6E2017A;
	Thu,  1 Feb 2024 13:53:31 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1706766812;
	bh=rI8P+diGy8KEwpMykWyWoBLcsgBDvjFoVkDPmpqeTSo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DM8xbrHotWktCfZXqrNxsoWb3wCYAx/NrtfEqSeuDwct39ip1/+neHABCwpE1PWY8
	 6XgRKKHOUT4STg71WQcjkOP46UCu7Ljr2DtDi8TGwNomsg/iF6G2WT8X1cP5bXJRIu
	 mky4vsFVfHQxIM87mm4Y7FZHXZRn79FOqG08yT9CcaYCpNAhiZgmAX0j4U1hzPxcVO
	 3HlpUJuGWy/NaQ1KbvCrMa8vlAfhzmYk3x1rXfsm06Gcckf1tRjXmsFE0IFclEHM0Y
	 K7zkrx64iWCMyJVUfg/V9joGg3hdN13JVQQ5Jaw3VThqnZH8sSibP0wdLmTPYYT9jV
	 oo1Jdmd+hhDAw==
Message-ID: <6f39a2cc2a853b45624553d5fdc66c3b65830721.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 18/21] ARM: dts: aspeed: yosemite4: add mctp config
 for NIC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 16:23:31 +1030
In-Reply-To: <20240131084134.328307-19-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-19-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> add mctp config for NIC

How does this integrate into the MCTP network(s)? It would be good to
have more of a description.

>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
> Changelog:
>   - v4
>     - Revise device node name
>   - v2
>     - Add patch for NIC mctp config
> ---
>  .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index 7c7c9e85bb92..b9b6fe729cd6 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1273,40 +1273,64 @@ imux24: i2c@0 {
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
>  			reg =3D <0>;
> +			mctp-controller;
>  			temperature-sensor@1f {
>  				compatible =3D "ti,tmp421";
>  				reg =3D <0x1f>;
>  			};
> +
> +			temperature-sensor@3c {
> +				compatible =3D "smsc,emc1403";
> +				reg =3D <0x3c>;
> +			};

This is unrelated to the MCTP configuration? Same with the other nodes
in the patch.

Andrew

