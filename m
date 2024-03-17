Return-Path: <linux-kernel+bounces-105583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F29387E108
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E82B1C20B55
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0A721A0B;
	Sun, 17 Mar 2024 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at+yLSU/"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89F61C6A4;
	Sun, 17 Mar 2024 23:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710717008; cv=none; b=CM+cDC0/3aaXL+tVRaZsJfbT4ItZwsRlEx0V5McMwP1y/uSgzQqCvSrisKNKzsPwaKnYBrFLbhJXdWCzql+th89w16vfVbYSQBz4LEOv9vshk+Lp8PlMwZqtiGAxdpBjQPxI4Lsvho3EmHAr66jiP7h/6UymWGkQmNN6ZlQQvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710717008; c=relaxed/simple;
	bh=+oquWYzYCWyBcOWP9+QVXQnEUl/xfWN2KshQJYRoLH0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9mGVmH/7EmIYVLfLmUj5hWp+6c9usw0Cw2gMynbCWIeym5TcD/DHFeOpgJMeJLXRpTFr9IaRBDtNFHGOHpPrh+GvPckYbUlg7iDpJirSLsva1aCoUI6NjBBgDNje3PntScQCvUGHt1Dsehw92EEUTLYF78ZAZFIVC+bI5qykzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at+yLSU/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4644bde1d4so494029766b.3;
        Sun, 17 Mar 2024 16:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710717004; x=1711321804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OppHWKfWTZKJRPOBZ8IE/hPwTxkg/hJdwgKT8S1vkzg=;
        b=at+yLSU/OKRLhbl8c5ltp5Imvo6oII/oRJ11KX0+eZg3X3VmfJVkqFcexayBAeHN+g
         80Xkrpgq7z4t9l0kGUyt7IKoneFT3qKFtPW06D9NgMLEllIzZCg3YXi+mCAWsK6E0mgj
         RKJjtfrvdrDUXjleZijnbdVGJ9U8ILnTrfrs4OR1NZb5j3PdSb0IiJCXMZSCTT4bSgjD
         tzz46Tdg4ef4l8KbYcfnugGA3QhBGqZok9Il0/LGZU+9GxPU2TBqzY2C18z5LjbS5Nl2
         onCccHomCdrvBvU8piHy7EkbD9xxQbeAYSYTJiHkMB3oRO2t0UWF+b3MYfD86jChFjCT
         3O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710717004; x=1711321804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OppHWKfWTZKJRPOBZ8IE/hPwTxkg/hJdwgKT8S1vkzg=;
        b=ah//AmtjN5A14E4rkHaOI+JlAsPaLDeva7rLrE51xT/ntolzzmD5KGli86gDu0TpZ1
         ACGtN3jjv3p2ceYd0MTPvIoiLeAfqJy5XWr6j2oKiGUe0j/1+M6scPftVuioazClHtVZ
         Bcr+kVnZ4EQoUimxPtzVXbN8Lum5/4/sonuW1lbSg08K7PNG3eoQIh9HqjeDWbnp9VC9
         8RyiJdYsb7zz+PScQRV5MlywMsqZxjQbZFmz0eqWfyyGxBANsjz1iBL0FE1bWj6oh1Gx
         G8OZykZ40G0/7ttc2JDJIKJjiAef+ZQm/5mEZts9JfoTRkl2/L/H1YjON3LDUxTiqFF2
         jPCg==
X-Forwarded-Encrypted: i=1; AJvYcCVBLsss3NbIpDCKtPkviVgcNy76A8VXQloRP/MjFd7mPtjNy0gjgRcaGDK5R8TEXQnJrB+Uvj/DSnjm9s0T2sMmnd8QWVo9V4OhGhupfnwHQ3PU60LKAeBpuI+KRqqSl7dYZ4aW7kQcoT7O+UseE+Z1sBOozmzrRLIVomJO07iRhjtx7J3ob0jvHlijmoBw8FQyL3PQFWaaIhns8A==
X-Gm-Message-State: AOJu0YyVoxwmgnmQPQW/pRt7Zbwd58ogMghB7uC8XpLc7pAioY5SX87v
	QKj0ZQt6+posoSr2bDQ5/go8FJzS2uT/WVYgeFvrvRTLR/lWEihV
X-Google-Smtp-Source: AGHT+IHQunvWWEWfbr/6/+8gKQTg4pQ6vAgajArEEoYssmrVoYfM2++IFTm231t7lc0ApdMDoAFV0g==
X-Received: by 2002:a17:907:20f3:b0:a44:4a94:a6d5 with SMTP id rh19-20020a17090720f300b00a444a94a6d5mr5691303ejb.27.1710717003907;
        Sun, 17 Mar 2024 16:10:03 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::f845])
        by smtp.gmail.com with ESMTPSA id wr6-20020a170907700600b00a4623030893sm4104646ejb.126.2024.03.17.16.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 16:10:03 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
X-Google-Original-From: Wadim Mueller <wadim.mueller@continental.com>
Date: Mon, 18 Mar 2024 00:10:00 +0100
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Wadim Mueller <wafgo01@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Chester Lin <chester62515@gmail.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Johannes Zink <j.zink@pengutronix.de>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Swee Leong Ching <leong.ching.swee@intel.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: S32G3: Introduce device tree for
 S32G-VNP-RDB3
Message-ID: <20240317231000.GA22886@bhlegrsu.conti.de>
References: <20240315222754.22366-1-wafgo01@gmail.com>
 <20240315222754.22366-2-wafgo01@gmail.com>
 <cc55daa1-0256-48d1-97a4-0f755fb4951b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc55daa1-0256-48d1-97a4-0f755fb4951b@linaro.org>

On Sun, Mar 17, 2024 at 03:50:55PM +0100, Krzysztof Kozlowski wrote:
> On 15/03/2024 23:27, Wadim Mueller wrote:
> > This commit adds device tree support for the NXP S32G3-based
> > S32G-VNP-RDB3 Board (Vehicle Networking Platform - Reference Design Board) [1].
> > 
> > The S32G3 features an 8-core ARM Cortex-A53 based SoC developed by NXP.
> > 
> > The device tree files are derived from the official NXP downstream Linux tree [2].
> > 
> > This addition encompasses a limited selection of peripherals that are upstream-supported. Apart from the ARM System Modules (GIC, Generic Timer, etc.), the following IPs have been validated:
> > 
> >     UART: fsl-linflexuart
> >     SDHC: fsl-imx-esdhc
> >     Ethernet: synopsys gmac/stmac
> > 
> > Clock settings for the chip rely on ATF Firmware [3]. Pin control integration into the device tree is pending and currently relies on Firmware/U-Boot settings [4].
> > 
> > These changes were validated using the latest BSP39 Firmware/U-Boot from NXP [5].
> > 
> > The modifications enable booting the official Ubuntu 22.04 from NXP on
> > the RDB3 with default settings from the SD card and eMMC.
> > 
> > [1] https://www.nxp.com/design/design-center/designs/s32g3-vehicle-networking-reference-design:S32G-VNP-RDB3
> > [2] https://github.com/nxp-auto-linux/linux
> > [3] https://github.com/nxp-auto-linux/arm-trusted-firmware
> > [4] https://github.com/nxp-auto-linux/u-boot
> > [5] https://github.com/nxp-auto-linux/auto_yocto_bsp
> > 
> > Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> >  arch/arm64/boot/dts/freescale/s32g3.dtsi      | 352 ++++++++++++++++++
> >  .../boot/dts/freescale/s32g399a-rdb3.dts      |  57 +++
> >  .../dt-bindings/clock/nxp,s32-scmi-clock.h    | 158 ++++++++
> 
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.
> 
> Bindings are not DTS.
> 
> >  4 files changed, 568 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/s32g3.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> >  create mode 100644 include/dt-bindings/clock/nxp,s32-scmi-clock.h
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > index 2cb0212b63c6..e701008dbc7b 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -252,3 +252,4 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx-rpidsi.dtb
> >  dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
> >  dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb
> >  dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
> > +dtb-$(CONFIG_ARCH_S32) += s32g399a-rdb3.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> > new file mode 100644
> > index 000000000000..481ddcfd3a6d
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> > @@ -0,0 +1,352 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > +#include <dt-bindings/clock/nxp,s32-scmi-clock.h>
> > +/ {
> > +	compatible = "nxp,s32g3";
> 
> Order your patches correctly. Bindings come before users.
> 
> > +	interrupt-parent = <&gic>;
> > +	#address-cells = <0x02>;
> > +	#size-cells = <0x02>;
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu-map {
> > +			cluster0 {
> > +				core0 {
> > +					cpu = <&cpu0>;
> > +				};
> > +
> > +				core1 {
> > +					cpu = <&cpu1>;
> > +				};
> > +
> > +				core2 {
> > +					cpu = <&cpu2>;
> > +				};
> > +
> > +				core3 {
> > +					cpu = <&cpu3>;
> > +				};
> > +			};
> > +
> > +			cluster1 {
> > +				core0 {
> > +					cpu = <&cpu4>;
> > +				};
> > +
> > +				core1 {
> > +					cpu = <&cpu5>;
> > +				};
> > +
> > +				core2 {
> > +					cpu = <&cpu6>;
> > +				};
> > +
> > +				core3 {
> > +					cpu = <&cpu7>;
> > +				};
> > +			};
> > +		};
> > +
> > +		cpu0: cpu@0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x0>;
> > +			enable-method = "psci";
> > +			clocks = <&dfs S32_SCMI_CLK_A53>;
> > +			next-level-cache = <&cluster0_l2_cache>;
> > +			#cooling-cells = <2>;
> > +		};
> > +
> > +		cpu1: cpu@1 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x1>;
> > +			enable-method = "psci";
> > +			clocks = <&dfs S32_SCMI_CLK_A53>;
> > +			next-level-cache = <&cluster0_l2_cache>;
> > +			#cooling-cells = <2>;
> > +		};
> > +
> > +		cpu2: cpu@2 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x2>;
> > +			enable-method = "psci";
> > +			clocks = <&dfs S32_SCMI_CLK_A53>;
> > +			next-level-cache = <&cluster0_l2_cache>;
> > +			#cooling-cells = <2>;
> > +		};
> > +
> > +		cpu3: cpu@3 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x3>;
> > +			enable-method = "psci";
> > +			clocks = <&dfs S32_SCMI_CLK_A53>;
> > +			next-level-cache = <&cluster0_l2_cache>;
> > +			#cooling-cells = <2>;
> > +		};
> > +
> > +		cpu4: cpu@100 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x100>;
> > +			enable-method = "psci";
> > +			clocks = <&dfs S32_SCMI_CLK_A53>;
> > +			next-level-cache = <&cluster1_l2_cache>;
> > +			#cooling-cells = <2>;
> > +		};
> > +
> > +		cpu5: cpu@101 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x101>;
> > +			enable-method = "psci";
> > +			clocks = <&dfs S32_SCMI_CLK_A53>;
> > +			next-level-cache = <&cluster1_l2_cache>;
> > +			#cooling-cells = <2>;
> > +		};
> > +
> > +		cpu6: cpu@102 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x102>;
> > +			enable-method = "psci";
> > +			clocks = <&dfs S32_SCMI_CLK_A53>;
> > +			next-level-cache = <&cluster1_l2_cache>;
> > +			#cooling-cells = <2>;
> > +		};
> > +
> > +		cpu7: cpu@103 {
> > +			device_type = "cpu";
> > +			compatible = "arm,cortex-a53";
> > +			reg = <0x103>;
> > +			enable-method = "psci";
> > +			clocks = <&dfs S32_SCMI_CLK_A53>;
> > +			next-level-cache = <&cluster1_l2_cache>;
> > +			#cooling-cells = <2>;
> > +		};
> > +
> > +		cluster0_l2_cache: l2-cache0 {
> 
> l2-cache-0
> 
> > +			compatible = "cache";
> > +			status = "okay";
> 
> Why do you need it? It's enabled by default.
> 

Thanks for the hint, will drop it.

> Anyway it incomplete:
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
>

I was not aware of this make target. Thanks for pointing me to the doc.
I will try to remove all warnings and come back with a fixed version.

> > +		};
> > +
> > +		cluster1_l2_cache: l2-cache1 {
> 
> l2-cache-1
> 
> > +			compatible = "cache";
> > +			status = "okay";
> > +		};
> > +	};
> > +
> > +	pmu {
> > +		compatible = "arm,cortex-a53-pmu";
> > +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> > +
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* sec-phys */
> > +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* virt */
> > +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* hyp-virt */
> > +		             <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>, /* sec-phys */
> > +		             <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>; /* phys */
> > +		always-on;
> > +	};
> > +
> > +	reserved-memory  {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		scmi_tx_buf: shm@d0000000 {
> > +			compatible = "arm,scmi-shmem";
> > +			reg = <0x0 0xd0000000 0x0 0x80>;
> > +			no-map;
> > +		};
> > +
> > +		scmi_rx_buf: shm@d0000080 {
> > +			compatible = "arm,scmi-shmem";
> > +			reg = <0x0 0xd0000080 0x0 0x80>;
> > +			no-map;
> > +		};
> > +	};
> > +
> > +	firmware {
> > +		scmi: scmi {
> > +			compatible = "arm,scmi-smc";
> > +			mbox-names = "tx", "rx";
> > +			shmem = <&scmi_tx_buf>, <&scmi_rx_buf>;
> > +			arm,smc-id = <0xc20000fe>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			status = "okay";
> 
> Drop or explain why is it needed.
> 

status is superfluous, right?

> > +			interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;
> > +			interrupt-names = "p2a_notif";
> > +
> > +			dfs: protocol@13 {
> > +				reg = <0x13>;
> > +				#clock-cells = <1>;
> > +			};
> > +
> > +			clks: protocol@14 {
> > +				reg = <0x14>;
> > +				#clock-cells = <1>;
> > +			};
> > +
> > +			reset: protocol@16 {
> > +				reg = <0x16>;
> > +				#reset-cells = <1>;
> > +			};
> > +
> > +			pinctrl_scmi: protocol@80 {
> > +				reg = <0x80>;
> > +				#pinctrl-cells = <2>;
> > +
> > +				status = "disabled";
> > +			};
> > +		};
> > +
> > +		psci: psci {
> > +			compatible = "arm,psci-1.0";
> > +			method = "smc";
> > +		};
> > +	};
> > +
> > +	soc@0 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0 0 0 0x80000000>;
> > +
> > +		uart0: serial@401c8000 {
> > +			compatible = "nxp,s32g3-linflexuart",
> > +				     "fsl,s32v234-linflexuart";
> > +			reg = <0x401c8000 0x3000>;
> > +			interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart1: serial@401cc000 {
> > +			compatible = "nxp,s32g3-linflexuart",
> > +				     "fsl,s32v234-linflexuart";
> > +			reg = <0x401cc000 0x3000>;
> > +			interrupts = <GIC_SPI 83 IRQ_TYPE_EDGE_RISING>;
> > +			status = "disabled";
> > +		};
> > +
> > +		uart2: serial@402bc000 {
> > +			compatible = "nxp,s32g3-linflexuart",
> > +				     "fsl,s32v234-linflexuart";
> > +			reg = <0x402bc000 0x3000>;
> > +			interrupts = <GIC_SPI 84 IRQ_TYPE_EDGE_RISING>;
> > +			status = "disabled";
> > +		};
> > +
> > +		gic: interrupt-controller@50800000 {
> > +			compatible = "arm,gic-v3";
> > +			#interrupt-cells = <3>;
> > +			interrupt-controller;
> > +			reg = <0x50800000 0x10000>,
> > +			      <0x50900000 0x200000>,
> > +			      <0x50400000 0x2000>,
> > +			      <0x50410000 0x2000>,
> > +			      <0x50420000 0x2000>;
> > +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> > +			mbi-ranges = <167 16>;
> > +		};
> > +
> > +		qspi: spi@40134000 {
> 
> Keep order by unit address.
> 

Will fix that, thanks.

> > +			compatible = "nxp,s32g3-qspi";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			reg = <0x0 0x00000000 0x0 0x20000000>,
> > +				<0x0 0x40134000 0x0 0x1000>;
> > +			reg-names = "QuadSPI-memory", "QuadSPI";
> > +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> > +			clock-names = "qspi_en", "qspi";
> > +			clocks = <&clks S32_SCMI_CLK_QSPI_FLASH1X>,
> > +				 <&clks S32_SCMI_CLK_QSPI_FLASH1X>;
> > +			spi-max-frequency = <200000000>;
> > +			spi-num-chipselects = <2>;
> > +			status = "disabled";
> > +		};
> > +
> > +		usdhc0: mmc@402f0000 {
> > +			compatible = "nxp,s32g3-usdhc",
> > +			             "nxp,s32g2-usdhc";
> > +			reg = <0x402f0000 0x1000>;
> > +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&clks S32_SCMI_CLK_USDHC_MODULE>,
> > +				 <&clks S32_SCMI_CLK_USDHC_AHB>,
> > +				 <&clks S32_SCMI_CLK_USDHC_CORE>;
> > +			clock-names = "ipg", "ahb", "per";
> > +			status = "disabled";
> > +		};
> > +
> > +		gmac0: ethernet@4033c000 {
> > +			status = "disabled";
> 
> Random code... sorry, but status does not come first. Put it last and
> please read carefully DTS coding style.
>

Will be fixed, thanks!

> > +			compatible = "nxp,s32-dwmac";
> > +			reg = <0x4033c000 0x2000>, /* gmac IP */
> > +			      <0x4007c004 0x4>;    /* S32 CTRL_STS reg */
> > +			interrupt-parent = <&gic>;
> > +			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "macirq";
> > +			tx-fifo-depth = <20480>;
> > +			rx-fifo-depth = <20480>;
> > +			dma-coherent;
> > +			snps,mtl-rx-config = <&mtl_rx_setup_gmac0>;
> > +			snps,mtl-tx-config = <&mtl_tx_setup_gmac0>;
> > +			clocks = <&clks S32_SCMI_CLK_GMAC0_AXI>,
> > +				 <&clks S32_SCMI_CLK_GMAC0_AXI>,
> > +				 <&clks S32_SCMI_CLK_GMAC0_TX_SGMII>,
> > +				 <&clks S32_SCMI_CLK_GMAC0_TX_RGMII>,
> > +				 <&clks S32_SCMI_CLK_GMAC0_TX_RMII>,
> > +				 <&clks S32_SCMI_CLK_GMAC0_TX_MII>,
> > +				 <&clks S32_SCMI_CLK_GMAC0_RX_SGMII>,
> > +				 <&clks S32_SCMI_CLK_GMAC0_RX_RGMII>,
> > +				 <&clks S32_SCMI_CLK_GMAC0_RX_RMII>,
> > +				 <&clks S32_SCMI_CLK_GMAC0_RX_MII>,
> > +				 <&clks S32_SCMI_CLK_GMAC0_TS>;
> > +			clock-names = "stmmaceth", "pclk",
> > +				      "tx_sgmii", "tx_rgmii",
> > +				      "tx_rmii", "tx_mii",
> > +				      "rx_sgmii", "rx_rgmii",
> > +				      "rx_rmii", "rx_mii",
> > +				      "ptp_ref";
> > +
> > +			mtl_rx_setup_gmac0: rx-queues-config {
> > +				snps,rx-queues-to-use = <5>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				queue@0 {};
> > +				queue@1 {};
> > +				queue@2 {};
> > +				queue@3 {};
> > +				queue@4 {};
> > +			};
> > +
> > +			mtl_tx_setup_gmac0: tx-queues-config {
> > +				snps,tx-queues-to-use = <5>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +
> > +				queue@0 {};
> > +				queue@1 {};
> > +				queue@2 {};
> > +				queue@3 {};
> > +				queue@4 {};
> > +			};
> > +
> > +			gmac0_mdio: mdio0 {
> 
> mdio?
>

Can you please explain what the problem with mdio is? Is it the label?

> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> 
> > +				compatible = "snps,dwmac-mdio";
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> > +		};
> > +
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> > new file mode 100644
> > index 000000000000..707b503c0165
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> > @@ -0,0 +1,57 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "s32g3.dtsi"
> > +
> > +/ {
> > +	model = "NXP S32G3 Reference Design Board 3 (S32G-VNP-RDB3)";
> > +	compatible = "nxp,s32g399a-rdb3", "nxp,s32g3";
> 
> Missing bindings.
> 

Will be fixed. Thanks

> 
> 
> Best regards,
> Krzysztof
> 

