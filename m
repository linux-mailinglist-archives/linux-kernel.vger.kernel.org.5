Return-Path: <linux-kernel+bounces-92951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A6387287F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D16CB2A7EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0BF12AADC;
	Tue,  5 Mar 2024 20:21:18 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A11272CC;
	Tue,  5 Mar 2024 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709670077; cv=none; b=mtzit3H6WbpxeK4v+dAm9hycqu1WGQJDuyzYbrdSwJ5NEdVbxBOC5K1+VX+c7j2YghW72t8WBDkj4RawxIjRqCtmSleRyvhux+5b1MvSoTyzlvde8pkMYT6SDkO/Wsb0ZW88RMy0rrBOvn3koHanYdJZ9h3P3hF78tg8f0qGGDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709670077; c=relaxed/simple;
	bh=OCFxQK/+lGBfLc8K0Ryr/REQzOrbTSaeg5/d5Exp6bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=re8zf3+RWq9z7cpee+AfgAgkT8fuzW1agjX/0WCDkSig0VPoQ6EWmyEO5B8PpjvrHQVfK+HJ2ixZN60Ah+CxH3aOos/g/NznzXqa2UvW77UIrvRb0lOFHdhrARzfe1MMwATmuaz6H+TVys164359yBRBHMJ4xjjbPaEMXxum/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9e.versanet.de ([83.135.90.158] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rhbHV-0003er-CG; Tue, 05 Mar 2024 21:20:57 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 p.zabel@pengutronix.de, jose.abreu@synopsys.com, nelson.costa@synopsys.com,
 dmitry.osipenko@collabora.com, sebastian.reichel@collabora.com,
 shawn.wen@rock-chips.com, nicolas.dufresne@collabora.com, hverkuil@xs4all.nl,
 hverkuil-cisco@xs4all.nl, kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm@lists.infradead.org
Subject:
 Re: [PATCH v2 4/6] arm64: dts: rockchip: Add device tree support for HDMI RX
 Controller
Date: Tue, 05 Mar 2024 21:20:55 +0100
Message-ID: <6040170.44csPzL39Z@diego>
In-Reply-To: <45138-65e76d00-9-580ee380@232156106>
References:
 <20240305123648.8847-1-shreeya.patel@collabora.com>
 <7657358.31r3eYUQgx@diego> <45138-65e76d00-9-580ee380@232156106>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi again :-)

Am Dienstag, 5. M=E4rz 2024, 20:05:02 CET schrieb Shreeya Patel:
> On Tuesday, March 05, 2024 19:41 IST, Heiko St=FCbner <heiko@sntech.de> w=
rote:
> > Am Dienstag, 5. M=E4rz 2024, 13:36:46 CET schrieb Shreeya Patel:
> > > Add device tree support for Synopsys DesignWare HDMI RX
> > > Controller.
> > >=20
> > > Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > > Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > > Co-developed-by: Dingxian Wen <shawn.wen@rock-chips.com>
> > > Signed-off-by: Dingxian Wen <shawn.wen@rock-chips.com>
> > > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> > > ---
> > > Changes in v2 :-
> > >   - Fix some of the checkpatch errors and warnings
> > >   - Rename resets, vo1-grf and HPD
> > >   - Move hdmirx_cma node to the rk3588.dtsi file
> > >=20
> > >  .../boot/dts/rockchip/rk3588-pinctrl.dtsi     | 41 ++++++++++++++
> > >  arch/arm64/boot/dts/rockchip/rk3588.dtsi      | 55 +++++++++++++++++=
++
> > >  2 files changed, 96 insertions(+)
> >=20
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/bo=
ot/dts/rockchip/rk3588.dtsi
> > > index 5519c1430cb7..8adb98b99701 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> > > @@ -7,6 +7,24 @@
> > >  #include "rk3588-pinctrl.dtsi"
> > > =20
> > >  / {
> > > +	reserved-memory {
> > > +		#address-cells =3D <2>;
> > > +		#size-cells =3D <2>;
> > > +		ranges;
> >=20
> > add blank line here
> >=20
> > > +		/*
> > > +		 * The 4k HDMI capture controller works only with 32bit
> > > +		 * phys addresses and doesn't support IOMMU. HDMI RX CMA
> > > +		 * must be reserved below 4GB.
> > > +		 */
> > > +		hdmirx_cma: hdmirx_cma {
> >=20
> > phandles use "_", but node-names "-"
> >=20
> > > +			compatible =3D "shared-dma-pool";
> > > +			alloc-ranges =3D <0x0 0x0 0x0 0xffffffff>;
> > > +			size =3D <0x0 (160 * 0x100000)>; /* 160MiB */
> >=20
> > The comment above that node, could elaborate where the value of 160MB
> > originates from. I assume it is to hold n-times of 4K frames or whateve=
r,
> > but it would be helpful for people to be able to read that.
> >=20
>=20
> right, we did the following calculation to come up with this value :-
> 3840 * 2160 * 4 (bytes/pix) * 2 (frames/buffer) / 1000 / 1000 =3D 66M
> and then we do the 2x times of this value to be on the safer side
> and support all practical use-cases.
>=20
> I'll add some more details to the comment in v3.

thanks, that will be helpful for me and everybody reading the dts later on

>=20
> >=20
> > > +			no-map;
> > > +			status =3D "disabled";
> > > +		};
> > > +	};
> > > +
> > >  	pcie30_phy_grf: syscon@fd5b8000 {
> > >  		compatible =3D "rockchip,rk3588-pcie3-phy-grf", "syscon";
> > >  		reg =3D <0x0 0xfd5b8000 0x0 0x10000>;
> > > @@ -85,6 +103,38 @@ i2s10_8ch: i2s@fde00000 {
> > >  		status =3D "disabled";
> > >  	};
> > > =20
> > > +	hdmi_receiver: hdmi-receiver@fdee0000 {
> >=20
> > Maybe rename the label to "hdmirx:" ... that way in a board enabling the
> > cma region, both nodes would stay close to each other?
> >=20
>=20
> Umm we already have receiver in the name so I am not sure if adding rx wi=
ll be
> a good idea. I was trying to keep it consistent with the names used in ot=
her device tree files.
> In case you still feel otherwise then do let me know, I'll make the chang=
e.

I'm somewhat partial to the actual name, I was more getting at similar
names to keep things together.

General sorting rules are that &foo phandles are sorted alphabetically
in board devicetrees.

So having

&hdmirx {
	status =3D "okay";
};

&hdmirx_cma {
	status =3D "okay";
};

in the board dt, makes them stay together automatically ;-)

So if it's hdmirx + hdmirx_cma or hdmi_receiver + hdmi_receiver_cma
doesn't matter that much, just that they share a common basename.


I really want to stay away from allowing special rules for things as much
as possible, because that becomes a neverending story, so it's
alphabetical sorting.

But nothing prevents us from naming phandles in an intelligent way ;-) .


Thanks
Heiko

> > > +		compatible =3D "rockchip,rk3588-hdmirx-ctrler", "snps,dw-hdmi-rx";
> > > +		reg =3D <0x0 0xfdee0000 0x0 0x6000>;
> > > +		power-domains =3D <&power RK3588_PD_VO1>;
> > > +		rockchip,grf =3D <&sys_grf>;
> > > +		rockchip,vo1-grf =3D <&vo1_grf>;
> > > +		interrupts =3D <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH 0>,
> > > +			     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH 0>,
> > > +			     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH 0>;
> > > +		interrupt-names =3D "cec", "hdmi", "dma";
> > > +		clocks =3D <&cru ACLK_HDMIRX>,
> > > +			 <&cru CLK_HDMIRX_AUD>,
> > > +			 <&cru CLK_CR_PARA>,
> > > +			 <&cru PCLK_HDMIRX>,
> > > +			 <&cru CLK_HDMIRX_REF>,
> > > +			 <&cru PCLK_S_HDMIRX>,
> > > +			 <&cru HCLK_VO1>;
> > > +		clock-names =3D "aclk",
> > > +			      "audio",
> > > +			      "cr_para",
> > > +			      "pclk",
> > > +			      "ref",
> > > +			      "hclk_s_hdmirx",
> > > +			      "hclk_vo1";
> >=20
> > the driver uses of_reserved_mem_device_init(), so doesn't this node need
> > a "memory-region =3D <&hdmirx_cma>; or similar?
> >=20
>=20
> yes, we should have the memory-region property here. My bad, I'll correct=
 this in v3.
>=20
> >=20
> > > +		resets =3D <&cru SRST_A_HDMIRX>, <&cru SRST_P_HDMIRX>,
> > > +			 <&cru SRST_HDMIRX_REF>, <&cru SRST_A_HDMIRX_BIU>;
> > > +		reset-names =3D "axi", "apb", "ref", "biu";
> > > +		pinctrl-0 =3D <&hdmim1_rx>;
> > > +		pinctrl-names =3D "default";
> > > +		status =3D "disabled";
> > > +	};
> > > +
> > >  	pcie3x4: pcie@fe150000 {
> > >  		compatible =3D "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
> > >  		#address-cells =3D <3>;
> > > @@ -339,3 +389,8 @@ pcie30phy: phy@fee80000 {
> > >  		status =3D "disabled";
> > >  	};
> > >  };
> > > +
> > > +&hdmirx_cma {
> > > +	status =3D "okay";
> > > +};
> >=20
> > I'd assume a board that enables &hdmi_receiver would also enable hdmirx=
_cma
> > and not the soc dtsi for _all_ boards?
> >=20
>=20
> Actually this node should be in the rock-5b.dts file instead of here.
> v1 had it correct but I made a mistake in v2 :(
> Thanks for pointing this out, I'll fix this and send a v3 soon.





