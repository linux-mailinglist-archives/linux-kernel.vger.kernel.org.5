Return-Path: <linux-kernel+bounces-92545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B521D8721F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76731C2186E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEB4126F0F;
	Tue,  5 Mar 2024 14:49:56 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC61F95E;
	Tue,  5 Mar 2024 14:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650195; cv=none; b=UJ9JVrSYY3mTB8uCJf1m/0WhHNNxIMACURxHrJ2t+7fOL1HFJVBeTvpmCCY+a7Uk1AoxutsAeAmHlms5uBVrBt2ln0zaVqgL/wfE3U5ZAi6ydBXET8M859oDWl0mrGnJOCxj4WomJ2GFP+gmFx+6Rnkfqwz4SKGKk/y4AvK2B88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650195; c=relaxed/simple;
	bh=JrCH6EgXFgvmU54XTv3OGayoRVJM9AhD1jxlXOStzVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i2JN4QmpyuocRYHMfYPzLgRA/dorJe0atwUTzV/WfbjZ/SZCmaE10QCH5cw23Yg0KzE2V6ptt3d8DYpqYoWi4bVg5jMNMaac1C3HhZrvMUnXiia/wqL2kj7supMW3IkmMQ577hYbzIoAHaRC6QQNeqit+I9K18B+BCfYFAYpcRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9e.versanet.de ([83.135.90.158] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rhVVj-0006jN-HS; Tue, 05 Mar 2024 15:11:15 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 p.zabel@pengutronix.de, jose.abreu@synopsys.com, nelson.costa@synopsys.com,
 dmitry.osipenko@collabora.com, sebastian.reichel@collabora.com,
 shawn.wen@rock-chips.com, nicolas.dufresne@collabora.com, hverkuil@xs4all.nl,
 hverkuil-cisco@xs4all.nl, Shreeya Patel <shreeya.patel@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm@lists.infradead.org,
 Shreeya Patel <shreeya.patel@collabora.com>
Subject:
 Re: [PATCH v2 4/6] arm64: dts: rockchip: Add device tree support for HDMI RX
 Controller
Date: Tue, 05 Mar 2024 15:11:14 +0100
Message-ID: <7657358.31r3eYUQgx@diego>
In-Reply-To: <20240305123648.8847-5-shreeya.patel@collabora.com>
References:
 <20240305123648.8847-1-shreeya.patel@collabora.com>
 <20240305123648.8847-5-shreeya.patel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,


Am Dienstag, 5. M=E4rz 2024, 13:36:46 CET schrieb Shreeya Patel:
> Add device tree support for Synopsys DesignWare HDMI RX
> Controller.
>=20
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Co-developed-by: Dingxian Wen <shawn.wen@rock-chips.com>
> Signed-off-by: Dingxian Wen <shawn.wen@rock-chips.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
> Changes in v2 :-
>   - Fix some of the checkpatch errors and warnings
>   - Rename resets, vo1-grf and HPD
>   - Move hdmirx_cma node to the rk3588.dtsi file
>=20
>  .../boot/dts/rockchip/rk3588-pinctrl.dtsi     | 41 ++++++++++++++
>  arch/arm64/boot/dts/rockchip/rk3588.dtsi      | 55 +++++++++++++++++++
>  2 files changed, 96 insertions(+)

> diff --git a/arch/arm64/boot/dts/rockchip/rk3588.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3588.dtsi
> index 5519c1430cb7..8adb98b99701 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588.dtsi
> @@ -7,6 +7,24 @@
>  #include "rk3588-pinctrl.dtsi"
> =20
>  / {
> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;

add blank line here

> +		/*
> +		 * The 4k HDMI capture controller works only with 32bit
> +		 * phys addresses and doesn't support IOMMU. HDMI RX CMA
> +		 * must be reserved below 4GB.
> +		 */
> +		hdmirx_cma: hdmirx_cma {

phandles use "_", but node-names "-"

> +			compatible =3D "shared-dma-pool";
> +			alloc-ranges =3D <0x0 0x0 0x0 0xffffffff>;
> +			size =3D <0x0 (160 * 0x100000)>; /* 160MiB */

The comment above that node, could elaborate where the value of 160MB
originates from. I assume it is to hold n-times of 4K frames or whatever,
but it would be helpful for people to be able to read that.


> +			no-map;
> +			status =3D "disabled";
> +		};
> +	};
> +
>  	pcie30_phy_grf: syscon@fd5b8000 {
>  		compatible =3D "rockchip,rk3588-pcie3-phy-grf", "syscon";
>  		reg =3D <0x0 0xfd5b8000 0x0 0x10000>;
> @@ -85,6 +103,38 @@ i2s10_8ch: i2s@fde00000 {
>  		status =3D "disabled";
>  	};
> =20
> +	hdmi_receiver: hdmi-receiver@fdee0000 {

Maybe rename the label to "hdmirx:" ... that way in a board enabling the
cma region, both nodes would stay close to each other?


> +		compatible =3D "rockchip,rk3588-hdmirx-ctrler", "snps,dw-hdmi-rx";
> +		reg =3D <0x0 0xfdee0000 0x0 0x6000>;
> +		power-domains =3D <&power RK3588_PD_VO1>;
> +		rockchip,grf =3D <&sys_grf>;
> +		rockchip,vo1-grf =3D <&vo1_grf>;
> +		interrupts =3D <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH 0>;
> +		interrupt-names =3D "cec", "hdmi", "dma";
> +		clocks =3D <&cru ACLK_HDMIRX>,
> +			 <&cru CLK_HDMIRX_AUD>,
> +			 <&cru CLK_CR_PARA>,
> +			 <&cru PCLK_HDMIRX>,
> +			 <&cru CLK_HDMIRX_REF>,
> +			 <&cru PCLK_S_HDMIRX>,
> +			 <&cru HCLK_VO1>;
> +		clock-names =3D "aclk",
> +			      "audio",
> +			      "cr_para",
> +			      "pclk",
> +			      "ref",
> +			      "hclk_s_hdmirx",
> +			      "hclk_vo1";

the driver uses of_reserved_mem_device_init(), so doesn't this node need
a "memory-region =3D <&hdmirx_cma>; or similar?


> +		resets =3D <&cru SRST_A_HDMIRX>, <&cru SRST_P_HDMIRX>,
> +			 <&cru SRST_HDMIRX_REF>, <&cru SRST_A_HDMIRX_BIU>;
> +		reset-names =3D "axi", "apb", "ref", "biu";
> +		pinctrl-0 =3D <&hdmim1_rx>;
> +		pinctrl-names =3D "default";
> +		status =3D "disabled";
> +	};
> +
>  	pcie3x4: pcie@fe150000 {
>  		compatible =3D "rockchip,rk3588-pcie", "rockchip,rk3568-pcie";
>  		#address-cells =3D <3>;
> @@ -339,3 +389,8 @@ pcie30phy: phy@fee80000 {
>  		status =3D "disabled";
>  	};
>  };
> +
> +&hdmirx_cma {
> +	status =3D "okay";
> +};

I'd assume a board that enables &hdmi_receiver would also enable hdmirx_cma
and not the soc dtsi for _all_ boards?


Thanks
Heiko



