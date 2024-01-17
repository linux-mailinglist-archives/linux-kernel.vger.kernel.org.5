Return-Path: <linux-kernel+bounces-28998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EA6830664
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F7B28311E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6C61EB37;
	Wed, 17 Jan 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVmsQioh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7481EB25;
	Wed, 17 Jan 2024 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496362; cv=none; b=Eq5Wd7jLNMLXYU4wsy3Nzmdl6tOEDhgsWCbZTVX29nvGPrVdyPyaUNGZ0hN4e9IcJo/ACsHcjaiUPXxVok1KzFnRZxGy6d5SbcxqfbQfW9lt3DRWXhXYpyjiL9edBjIQOCBYI4qht2etsTfvJzpbczpTilkuBOaFSMNYbIKKORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496362; c=relaxed/simple;
	bh=vTROU2jcU9nWu+CYX4jqFbAAujvImlfaJDPY2q8o8Vg=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=CHBVLCDKO+WPCNtEbWIRuhiQg4ReZgXac37WedWtC4t8xScLIVNtCprh0dEjL/uD5ZoK2gldHTZ/7Hd/x6LuOoa1gvL2HsbzAUA3bxZKwQ/ToUPr7pcYNphqxEowVMNxPdlVCX7JdwPTu9hYCEh93dTlnskzOv3FbBzFGvPxkB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVmsQioh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A2FC433F1;
	Wed, 17 Jan 2024 12:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705496362;
	bh=vTROU2jcU9nWu+CYX4jqFbAAujvImlfaJDPY2q8o8Vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVmsQiohhFLbzEQ+55oJIC2vG/AfBFQp+crYO8KcUBSUXbSn/n2rgGYe131BHgJ8N
	 sg6NmbnJEMvp1ENbKLpdK/6Ykpt6K+f5/fOELRfltkioAezyQd4ghtkGkO1/5dwvbT
	 x5B7WiPDdSV8YtcOntlAvvEsVKgPg2tlv3NDv+47IS0LxntC70PqL2HzvDXBup5uQB
	 A/ChkdwtGpnXEnaR2ANhrdQ1gu8tilKkpJhowzmX+NAAgbZ4BjutJ+NvS40WACVda3
	 NdFW1Bzn06aSa5tdM7U0wqCgmPM4tkmF3sFFZkbchkVPLkxkjUmiQsi6MXsLO1wraE
	 ThhoM1oS0qliQ==
Date: Wed, 17 Jan 2024 12:59:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jingbao Qiu <qiujingbao.dlmu@gmail.com>, alexandre.belloni@bootlin.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, chao.wei@sophgo.com, unicorn_wang@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dlan@gentoo.org, inochiama@outlook.com
Subject: Re: [PATCH v6 3/3] riscv: dts: sophgo: add rtc dt node for CV1800
Message-ID: <20240117-turbulent-sustained-bf960186f7cc@spud>
References: <20240115160600.5444-1-qiujingbao.dlmu@gmail.com>
 <20240115160600.5444-4-qiujingbao.dlmu@gmail.com>
 <f2b3dff2-ce0d-4ddb-ad61-74abf2c3022d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ST0BWaOiT7MOC+eD"
Content-Disposition: inline
In-Reply-To: <f2b3dff2-ce0d-4ddb-ad61-74abf2c3022d@linaro.org>


--ST0BWaOiT7MOC+eD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 08:44:12AM +0100, Krzysztof Kozlowski wrote:
> On 15/01/2024 17:06, Jingbao Qiu wrote:
> > Add the rtc device tree node to cv1800 SoC.
> >=20
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/=
dts/sophgo/cv1800b.dtsi
> > index df40e87ee063..66bb4a752b91 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > @@ -119,5 +119,17 @@ clint: timer@74000000 {
> >  			reg =3D <0x74000000 0x10000>;
> >  			interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_intc 7>;
> >  		};
> > +
> > +		rtc: rtc@5025000 {
> > +			compatible =3D "sophgo,cv1800-rtc", "syscon";
> > +			reg =3D <0x5025000 0x2000>;
> > +			interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks =3D <&osc>;
> > +		};
> > +
> > +		por {
> > +			compatible =3D "sophgo,cv1800-por";
>=20
> What is this? Why is it here, how did it even appear? It misses unit
> address and reg or is clearly placed in wrong place. It seems you
> entirely ignored out previous discussion.
>=20
> NAK

It doesn't pass dtbs_check, so it's automatically not a runner. Please
make sure that your series adds no additional warnings at dtbs_check
with W=3D1.

Thanks,
Conor.

--ST0BWaOiT7MOC+eD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZafPJAAKCRB4tDGHoIJi
0iSTAP9PWEFPH4zQ1xBK8WJilwJJ9LXJX6NS+x9taovIstROjwD/eoiJGotb3Uyw
fZm3S1Pu5lHW4CRa4GOtJs500WJuZAk=
=353h
-----END PGP SIGNATURE-----

--ST0BWaOiT7MOC+eD--

