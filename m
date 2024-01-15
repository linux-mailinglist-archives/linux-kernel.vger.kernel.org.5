Return-Path: <linux-kernel+bounces-25876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B03682D724
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA77EB212FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D3D101C1;
	Mon, 15 Jan 2024 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="M/EiVjFK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UUVk7WNf"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A54F1E864;
	Mon, 15 Jan 2024 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id BD7F45C0069;
	Mon, 15 Jan 2024 05:21:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jan 2024 05:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705314076; x=1705400476; bh=tlYr0vGJzYQYoc8BNv3wVi1q8e4xLb6C
	7VT9Mo7EniY=; b=M/EiVjFKbK39rm/VI0X3SyS5wcJdZI3C08Qn19lhEeE96fqs
	wlNyAymZgrVwZJBHuKVYDsLB8dmzfoFgbglEbUBacu1wUvfW7tbCZTcYpcx/waMX
	lmfo5hJohhbJcok8BciqL6M5/HtmHkL7qwh9GpTd/us+wJFnqDnyc0a+EPueVSZE
	kVbPLWLb5zDp04UoXXrKdK0Ql0SMUfvwgRNu5M42yP0OgwPu4fVgRWEit/GS6zdE
	bTdh0/gycVQJn7mZZSf+TfpfJ4CivS4ZvnMGy4YcfJDFV6DBJeRBQsz1W0JZfDDE
	t44GNtLgGDVCFYSSNikAuah3oDua33cSU3TcvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705314076; x=
	1705400476; bh=tlYr0vGJzYQYoc8BNv3wVi1q8e4xLb6C7VT9Mo7EniY=; b=U
	UVk7WNfdhdbTn5gRgDKsEN0X8fG5CmRZUPMQ3niVxCxsmW1C/WMgJcUNbWaQUxPA
	kN3DRl7EcpF/UAGIu//KwBZycyKulyxIFj1f+IpMAj4lizKx99m3W3YpfGK+h38l
	Oduf60AcZJOuhXGvXIXIhinDoGFCBVUNphoniY9WMDidpRNiPod51UODLWleDFqF
	i7WEOEaslCpHzfBsir8qDoOHQr56v3JGE5/EultYgTspP5RAUf0qD0HWSzKcGOlm
	28gmfbeJhGY9FbGnu7Iu05YcQPXpLUe3LxpTMQLRqHfd5EwXXDzc/Bh24cBUhfHa
	nPYk+x3w1ybys3VdxkvAQ==
X-ME-Sender: <xms:GwelZVZfUsMshNrdRrWNBbZqDKWle3w0fKvrTrW46CPGLVwrE9tbwg>
    <xme:GwelZcb39-o0FiWdjKxmHx90NFor9RU2XMOkoVfijVOefBU3ozBk89RjaXQ6bp6S_
    lsWCtFDRw>
X-ME-Received: <xmr:GwelZX-7GOrgD9BLemfbFvOKYnhnD4b0H-SsHf_8UbowFBWWeNU5fkw2umkX6PCFE9Z37dBlfsLdm_Ibbl-owAsSnY_uxDlmymRYVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepveeggfffkeduteefteekhfduueegteejteekkeekffeugfekkeevfefgleegveev
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpihhnfhhrrgguvggrugdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmsehf
    vggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:GwelZTpb8ySUrpafPsepb-zE9p5Rkuo85S7k0sSWwanBJhfxCqfuBw>
    <xmx:GwelZQq4TwGiT-N3N490mrPOKBoDE0gs_57qQkQaYadFF7jhQvj6KQ>
    <xmx:GwelZZT0aARP2eem_lQjP7OC1t0XM9v3Ie7YdhW1AXCWaChIwq9pSg>
    <xmx:HAelZca5QD6FJyAAQ85V4g-znoz6U8L8mTQa6U1RoH2zfVz6AwNFyQ>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 05:21:08 -0500 (EST)
Message-ID: <0ac2701a-9498-4952-848b-fb614900f3ab@feathertop.org>
Date: Mon, 15 Jan 2024 21:21:05 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Hardkernel ODROID-M1S board
To: KyuHyuk Lee <lee@kyuhyuk.kr>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Tianling Shen <cnsztl@gmail.com>, Chris Morgan <macromorgan@hotmail.com>,
 Ondrej Jirman <megi@xff.cz>, Andy Yan <andyshrk@163.com>,
 Jagan Teki <jagan@edgeble.ai>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 David Heidelberg <david@ixit.cz>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240112135004.28907-1-lee@kyuhyuk.kr>
 <5774eb3f-dfdc-4e4d-985e-3ec4b69ad206@feathertop.org>
 <ZaP5de5wchr/b9WM@kyuhyuk.kr>
Content-Language: en-US
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <ZaP5de5wchr/b9WM@kyuhyuk.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lee,

On 1/15/24 02:10, KyuHyuk Lee wrote:
>>> +
>>> +		regulator-state-mem {
>>> +			regulator-off-in-suspend;
>>> +		};
>>> +	};
>>> +
>>> +	rk809: pmic@20 {
>>> +		compatible = "rockchip,rk809";
>>> +		reg = <0x20>;
>>> +		interrupt-parent = <&gpio0>;
>>> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>>> +		#clock-cells = <1>;
>>> +		pinctrl-names = "default";
>>> +		pinctrl-0 = <&pmic_int_l>;
>>> +		rockchip,system-power-controller;
>>> +		vcc1-supply = <&vcc3v3_sys>;
>>> +		vcc2-supply = <&vcc3v3_sys>;
>>> +		vcc3-supply = <&vcc3v3_sys>;
>>> +		vcc4-supply = <&vcc3v3_sys>;
>>> +		vcc5-supply = <&vcc3v3_sys>;
>>> +		vcc6-supply = <&vcc3v3_sys>;
>>> +		vcc7-supply = <&vcc3v3_sys>;
>>> +		vcc8-supply = <&vcc3v3_sys>;
>>> +		vcc9-supply = <&vcc3v3_sys>;
>>> +		wakeup-source;
>>> +
>>> +		regulators {
>>> +			vdd_logic: DCDC_REG1 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt = <500000>;
>>> +				regulator-max-microvolt = <1350000>;
>>> +				regulator-init-microvolt = <900000>;
Also "regulator-init-microvolt" is also copied from downstream and not 
currently supported, see:
https://lore.kernel.org/all/20230707162217.675390-1-cristian.ciocaltea@collabora.com/
>>> +				regulator-ramp-delay = <6001>;
>>> +				regulator-initial-mode = <0x2>;
>>> +				regulator-name = "vdd_logic";
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vdd_gpu: DCDC_REG2 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt = <500000>;
>>> +				regulator-max-microvolt = <1350000>;
>>> +				regulator-init-microvolt = <900000>;
>>> +				regulator-ramp-delay = <6001>;
>>> +				regulator-initial-mode = <0x2>;
>>> +				regulator-name = "vdd_gpu";
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vcc_ddr: DCDC_REG3 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-initial-mode = <0x2>;
>>> +				regulator-name = "vcc_ddr";
>>> +				regulator-state-mem {
>>> +					regulator-on-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vdd_npu: DCDC_REG4 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt = <500000>;
>>> +				regulator-max-microvolt = <1350000>;
>>> +				regulator-init-microvolt = <900000>;
>>> +				regulator-ramp-delay = <6001>;
>>> +				regulator-initial-mode = <0x2>;
>>> +				regulator-name = "vdd_npu";
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vdda0v9_image: LDO_REG1 {
>>> +				regulator-boot-on;
>>> +				regulator-always-on;
>>> +				regulator-min-microvolt = <900000>;
>>> +				regulator-max-microvolt = <900000>;
>>> +				regulator-name = "vdda0v9_image";
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vdda_0v9: LDO_REG2 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt = <900000>;
>>> +				regulator-max-microvolt = <900000>;
>>> +				regulator-name = "vdda_0v9";
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vdda0v9_pmu: LDO_REG3 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt = <900000>;
>>> +				regulator-max-microvolt = <900000>;
>>> +				regulator-name = "vdda0v9_pmu";
>>> +				regulator-state-mem {
>>> +					regulator-on-in-suspend;
>>> +					regulator-suspend-microvolt = <900000>;
>>> +				};
>>> +			};
>>> +
>>> +			vccio_acodec: LDO_REG4 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt = <3000000>;
>>> +				regulator-max-microvolt = <3000000>;
>>> +				regulator-name = "vccio_acodec";
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vccio_sd: LDO_REG5 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt = <1800000>;
>>> +				regulator-max-microvolt = <3300000>;
>>> +				regulator-name = "vccio_sd";
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vcc3v3_pmu: LDO_REG6 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt = <3300000>;
>>> +				regulator-max-microvolt = <3300000>;
>>> +				regulator-name = "vcc3v3_pmu";
>>> +				regulator-state-mem {
>>> +					regulator-on-in-suspend;
>>> +					regulator-suspend-microvolt = <3300000>;
>>> +				};
>>> +			};
>>> +
>>> +			vcca_1v8: LDO_REG7 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt = <1800000>;
>>> +				regulator-max-microvolt = <1800000>;
>>> +				regulator-name = "vcca_1v8";
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vcca1v8_ddr: LDO_REG8 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt = <1800000>;
>>> +				regulator-max-microvolt = <1800000>;
>>> +				regulator-name = "vcca1v8_pmu";
>>> +				regulator-state-mem {
>>> +					regulator-on-in-suspend;
>>> +					regulator-suspend-microvolt = <1800000>;
>>> +				};
>>> +			};
>>> +
>>> +			vcca1v8_image: LDO_REG9 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt = <1800000>;
>>> +				regulator-max-microvolt = <1800000>;
>>> +				regulator-name = "vcca1v8_image";
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vcc_1v8: DCDC_REG5 {
>> Maybe its just me, but seems odd that DCDC_REG5 is out of order with the
>> other DCDC regulators above.
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-min-microvolt = <1800000>;
>>> +				regulator-max-microvolt = <1800000>;
>>> +				regulator-name = "vcc_1v8";
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vcc_3v3: SWITCH_REG1 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-name = "vcc_3v3";
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +
>>> +			vcc3v3_sd: SWITCH_REG2 {
>>> +				regulator-always-on;
>>> +				regulator-boot-on;
>>> +				regulator-name = "vcc3v3_sd";
>>> +				regulator-state-mem {
>>> +					regulator-off-in-suspend;
>>> +				};
>>> +			};
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&pinctrl {
>>> +	leds {
>>> +		led_power_pin: led-power-pin {
>>> +			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
>>> +		};
>>> +		led_work_pin: led-work-pin {
>>> +			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
>>> +		};
>>> +	};
>>> +
>>> +	pmic {
>>> +		pmic_int_l: pmic-int-l {
>>> +			rockchip,pins =
>>> +				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
>>> +		};
>>> +	};
>>> +};
>>> +
>>> +&pmu_io_domains {
>>> +	pmuio2-supply = <&vcc3v3_pmu>;
>>> +	vccio1-supply = <&vccio_acodec>;
>>> +	vccio3-supply = <&vccio_sd>;
>>> +	vccio4-supply = <&vcc_3v3>;
>>> +	vccio5-supply = <&vcc_3v3>;
>>> +	vccio6-supply = <&vcc_3v3>;
>>> +	vccio7-supply = <&vcc_3v3>;
>>> +	status = "okay";
>>> +};
>> Did you miss pmuio1 and vccio2 here? the latter of which is the eMMC domain.
>>
>> Are you planning to add additional patches for usb, gmac etc? I had been
>> working through cleaning up these device tree files with a view to
>> submitting them soon also.
>>
>> Regards
>>     Tim
> Hello Tim. Thank you for your reviewing.
>
> I'll check you said above.
>
> Yes, I am planning additional patches like usb, gmac as you said.
> May I understand that you cleaned up my patch?

No, I've been working from the Hardkernel  and Tobetters device trees.


Regards
    Tim

> I look forward to your reply.



>
> Thank you,
> KyuHyuk Lee.
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

