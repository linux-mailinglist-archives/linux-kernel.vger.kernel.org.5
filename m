Return-Path: <linux-kernel+bounces-92871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB80A872746
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7008028C4C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F929288DB;
	Tue,  5 Mar 2024 19:05:08 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D8E4DA11;
	Tue,  5 Mar 2024 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665508; cv=none; b=jPogaTfD68hn0tI2WwmWC0MYes3wIIcYTvdbnOHUZHkyjbgrbNVdV7d/GLBIjfyNW0eVvQ5ccpaU+9bLV/GNGLlq1sbShfGcdgO43g0tjdTao74+YWdAPXu3tnfsJbQjpV5c2XRzA4wd10dpE4tm4D6QRLpqRBgZr4q3uLutOBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665508; c=relaxed/simple;
	bh=H1Qiv31s9Oe+qmeR5ZSKcolby0D5p691hIDNCYdTa8w=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=KAaKy9UgSLF+AkHW70l1eM/Zf9OsSvseIwQnS/cvCSl75q6mMbeRI/XhoPj5ksPoV8rRoMF27WjytdLuFI+keN+gzuZz7wxh+5WyeG+NnrjL5xIhBWeBbYLqAMw4nhj39juJIamMptbbHw3tG6tp3ceKUPe3Fu7gHp0t+dbxFsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 7262F378201D;
	Tue,  5 Mar 2024 19:05:02 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <7657358.31r3eYUQgx@diego>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240305123648.8847-1-shreeya.patel@collabora.com>
 <20240305123648.8847-5-shreeya.patel@collabora.com> <7657358.31r3eYUQgx@diego>
Date: Tue, 05 Mar 2024 19:05:02 +0000
Cc: mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, jose.abreu@synopsys.com, nelson.costa@synopsys.com, dmitry.osipenko@collabora.com, sebastian.reichel@collabora.com, shawn.wen@rock-chips.com, nicolas.dufresne@collabora.com, hverkuil@xs4all.nl, hverkuil-cisco@xs4all.nl, kernel@collabora.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm@lists.infradead.org
To: =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <45138-65e76d00-9-580ee380@232156106>
Subject: =?utf-8?q?Re=3A?= [PATCH v2 4/6] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= Add device tree support for HDMI RX Controller
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, March 05, 2024 19:41 IST, Heiko St=C3=BCbner <heiko@sntech.=
de> wrote:

> Hi,
>=20

Hi Heiko,

>=20
> Am Dienstag, 5. M=C3=A4rz 2024, 13:36:46 CET schrieb Shreeya Patel:
> > Add device tree support for Synopsys DesignWare HDMI RX
> > Controller.
> >=20
> > Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Co-developed-by: Dingxian Wen <shawn.wen@rock-chips.com>
> > Signed-off-by: Dingxian Wen <shawn.wen@rock-chips.com>
> > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> > ---
> > Changes in v2 :-
> >   - Fix some of the checkpatch errors and warnings
> >   - Rename resets, vo1-grf and HPD
> >   - Move hdmirx=5Fcma node to the rk3588.dtsi file
> >=20
> >  .../boot/dts/rockchip/rk3588-pinctrl.dtsi     | 41 ++++++++++++++
> >  arch/arm64/boot/dts/rockchip/rk3588.dtsi      | 55 +++++++++++++++=
++++
> >  2 files changed, 96 insertions(+)
>=20
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/=
boot/dts/rockchip/rk3588.dtsi
> > index 5519c1430cb7..8adb98b99701 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> > @@ -7,6 +7,24 @@
> >  #include "rk3588-pinctrl.dtsi"
> > =20
> >  / {
> > +	reserved-memory {
> > +		#address-cells =3D <2>;
> > +		#size-cells =3D <2>;
> > +		ranges;
>=20
> add blank line here
>=20
> > +		/*
> > +		 * The 4k HDMI capture controller works only with 32bit
> > +		 * phys addresses and doesn't support IOMMU. HDMI RX CMA
> > +		 * must be reserved below 4GB.
> > +		 */
> > +		hdmirx=5Fcma: hdmirx=5Fcma {
>=20
> phandles use "=5F", but node-names "-"
>=20
> > +			compatible =3D "shared-dma-pool";
> > +			alloc-ranges =3D <0x0 0x0 0x0 0xffffffff>;
> > +			size =3D <0x0 (160 * 0x100000)>; /* 160MiB */
>=20
> The comment above that node, could elaborate where the value of 160MB
> originates from. I assume it is to hold n-times of 4K frames or whate=
ver,
> but it would be helpful for people to be able to read that.
>=20

right, we did the following calculation to come up with this value :-
3840 * 2160 * 4 (bytes/pix) * 2 (frames/buffer) / 1000 / 1000 =3D 66M
and then we do the 2x times of this value to be on the safer side
and support all practical use-cases.

I'll add some more details to the comment in v3.

>=20
> > +			no-map;
> > +			status =3D "disabled";
> > +		};
> > +	};
> > +
> >  	pcie30=5Fphy=5Fgrf: syscon@fd5b8000 {
> >  		compatible =3D "rockchip,rk3588-pcie3-phy-grf", "syscon";
> >  		reg =3D <0x0 0xfd5b8000 0x0 0x10000>;
> > @@ -85,6 +103,38 @@ i2s10=5F8ch: i2s@fde00000 {
> >  		status =3D "disabled";
> >  	};
> > =20
> > +	hdmi=5Freceiver: hdmi-receiver@fdee0000 {
>=20
> Maybe rename the label to "hdmirx:" ... that way in a board enabling =
the
> cma region, both nodes would stay close to each other?
>=20

Umm we already have receiver in the name so I am not sure if adding rx =
will be
a good idea. I was trying to keep it consistent with the names used in =
other device tree files.
In case you still feel otherwise then do let me know, I'll make the cha=
nge.

>=20
> > +		compatible =3D "rockchip,rk3588-hdmirx-ctrler", "snps,dw-hdmi-rx=
";
> > +		reg =3D <0x0 0xfdee0000 0x0 0x6000>;
> > +		power-domains =3D <&power RK3588=5FPD=5FVO1>;
> > +		rockchip,grf =3D <&sys=5Fgrf>;
> > +		rockchip,vo1-grf =3D <&vo1=5Fgrf>;
> > +		interrupts =3D <GIC=5FSPI 177 IRQ=5FTYPE=5FLEVEL=5FHIGH 0>,
> > +			     <GIC=5FSPI 436 IRQ=5FTYPE=5FLEVEL=5FHIGH 0>,
> > +			     <GIC=5FSPI 179 IRQ=5FTYPE=5FLEVEL=5FHIGH 0>;
> > +		interrupt-names =3D "cec", "hdmi", "dma";
> > +		clocks =3D <&cru ACLK=5FHDMIRX>,
> > +			 <&cru CLK=5FHDMIRX=5FAUD>,
> > +			 <&cru CLK=5FCR=5FPARA>,
> > +			 <&cru PCLK=5FHDMIRX>,
> > +			 <&cru CLK=5FHDMIRX=5FREF>,
> > +			 <&cru PCLK=5FS=5FHDMIRX>,
> > +			 <&cru HCLK=5FVO1>;
> > +		clock-names =3D "aclk",
> > +			      "audio",
> > +			      "cr=5Fpara",
> > +			      "pclk",
> > +			      "ref",
> > +			      "hclk=5Fs=5Fhdmirx",
> > +			      "hclk=5Fvo1";
>=20
> the driver uses of=5Freserved=5Fmem=5Fdevice=5Finit(), so doesn't thi=
s node need
> a "memory-region =3D <&hdmirx=5Fcma>; or similar?
>=20

yes, we should have the memory-region property here. My bad, I'll corre=
ct this in v3.

>=20
> > +		resets =3D <&cru SRST=5FA=5FHDMIRX>, <&cru SRST=5FP=5FHDMIRX>,
> > +			 <&cru SRST=5FHDMIRX=5FREF>, <&cru SRST=5FA=5FHDMIRX=5FBIU>;
> > +		reset-names =3D "axi", "apb", "ref", "biu";
> > +		pinctrl-0 =3D <&hdmim1=5Frx>;
> > +		pinctrl-names =3D "default";
> > +		status =3D "disabled";
> > +	};
> > +
> >  	pcie3x4: pcie@fe150000 {
> >  		compatible =3D "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
> >  		#address-cells =3D <3>;
> > @@ -339,3 +389,8 @@ pcie30phy: phy@fee80000 {
> >  		status =3D "disabled";
> >  	};
> >  };
> > +
> > +&hdmirx=5Fcma {
> > +	status =3D "okay";
> > +};
>=20
> I'd assume a board that enables &hdmi=5Freceiver would also enable hd=
mirx=5Fcma
> and not the soc dtsi for =5Fall=5F boards?
>=20

Actually this node should be in the rock-5b.dts file instead of here.
v1 had it correct but I made a mistake in v2 :(
Thanks for pointing this out, I'll fix this and send a v3 soon.


Thanks,
Shreeya Patel

>=20
> Thanks
> Heiko
>=20
>=20
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com
> This list is managed by https://mailman.collabora.com


