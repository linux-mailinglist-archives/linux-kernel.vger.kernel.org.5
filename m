Return-Path: <linux-kernel+bounces-62938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B085281F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA001C23386
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A51611C83;
	Tue, 13 Feb 2024 05:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="boqa0wPn"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D311717
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707800881; cv=none; b=CxkHPWLbRxckgAEj4jzuwgtjoYB9XJUsWyZBlE/1j/pdHIJlhMHDu4baguO4IpV3I4IK1JPY862Y0ECRQHAE9HfyYhwWEwOtxSHh8sX5fH+SI+dXMPjFUN1/RdeAvCirlExSDCBaDGXWPdwzoPVaDf1EWkSxq5lFAbUCHCc+LoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707800881; c=relaxed/simple;
	bh=V7CGg+gTzz4+Jsmr0SjZ2mADbOPxXv7WOSoerAh6rtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nZjfD/tIRJ9aNyXbLRfDRhA6yDNYHp6UskQ/Ikb+jxeXgNU9caCguy88NXM1UmY/wW0O7UBTI/r3QfGFE7k2vVwstmps1ByPLCfCx7oWXCmVGb8An4YDcAVsIRNZOre255MobaSaKRoqIxgkp6CS4rrqxseVvGoZPdzvbWlket4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=boqa0wPn; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1707800865; x=1710392865;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V7CGg+gTzz4+Jsmr0SjZ2mADbOPxXv7WOSoerAh6rtg=;
	b=boqa0wPnWh4cSU8cBgkwCjVPxPDRdgEB6gA+FVvo4598SYLg7zQvwlnAPfq46M9X
	IGeWcH8zC18/wrRi4Y2FpZjYIieq+qx/QtlMjUWSGm6I/u415JL97Sf9lfI3YRkS
	UhlWHMGXj1/gV/KgsWVsec21IpIQa/I1JsGhMrrdpKk=;
X-AuditID: ac14000a-fbefe7000000290d-3e-65caf920208b
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id DC.4D.10509.029FAC56; Tue, 13 Feb 2024 06:07:44 +0100 (CET)
Received: from [172.20.10.5] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 13 Feb
 2024 06:08:02 +0100
Message-ID: <c6ad3a3e-330c-40cd-8e25-fd259fd1e398@phytec.de>
Date: Tue, 13 Feb 2024 06:07:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] arm64: dts: ti: k3-am6*: Fix bus-width property in
 MMC nodes
To: Judith Mendez <jm@ti.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
References: <20240213002416.1560357-1-jm@ti.com>
 <20240213002416.1560357-9-jm@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240213002416.1560357-9-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWyRpKBR1fh56lUg2VHTSzW7D3HZDH/yDlW
	i7tLfzJafPqQabH882x2i74XD5ktNj2+xmpxedccNos3P84yWbTuPcJu8f/sB3YHbo9NqzrZ
	PO5c28PmsXlJvcfxG9uZPDa98vD4vEkugC2KyyYlNSezLLVI3y6BK+PW06esBWd0KpY+vsLS
	wHhauYuRk0NCwERi5r6PrF2MXBxCAouZJNbtu8oI4dxhlFj44DUrSBWvgI3E9iOH2boYOThY
	BFQlHh3QhAgLSpyc+YQFxBYVkJe4f2sGO4gtLBAlcefBE3aQOSICCxglDh3exQTiMAu0Mkk8
	aHjJDjJISCBc4vAjsCuYBcQlbj2ZzwRiswmoS9zZ8A1sL6eAocSBo/NYIWosJBa/OcgOYctL
	bH87hxnEFgKyX1xazgLxjbzEtHOvmSHsUImtX7YzTWAUnoXk1llI1s1CMnYWkrELGFlWMQrl
	ZiZnpxZlZusVZFSWpCbrpaRuYgRFmwgD1w7GvjkehxiZOBgPMUpwMCuJ8F6acSJViDclsbIq
	tSg/vqg0J7X4EKM0B4uSOO/qjuBUIYH0xJLU7NTUgtQimCwTB6dUA2PJXhf3JzLeywzvqQpk
	ppTf339lpcWzpusTma85H//LKnGZQVy7OO32v/3Ptnf8K5tmlWO5/tehyUEH1q4Ovdtt9fjw
	rcDL+08utXfY6d7Hr32v9Gvy+vUHDtVJ+9vHikZtdo9dmfTg8+y0p61zjaW/yHYmbIiP8Nn1
	Za9mqjhP37y6o1HHqycqsRRnJBpqMRcVJwIAflPswaQCAAA=

Hi Judith,

Am 13.02.24 um 01:24 schrieb Judith Mendez:
> Move bus-width property to *main.dtsi, above the OTAP/ITAP
> delay values. While there is no error with where it is
> currently at, it is easier to read the MMC node if the
> bus-width property is located above the OTAP/ITAP delay
> values consistently across MMC nodes.
>
> Add missing bus-width for MMC2 in k3-am62-main.
>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi       | 5 +++--
>   arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 1 -
>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi      | 2 +-
>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi       | 2 ++
>   arch/arm64/boot/dts/ti/k3-am642-evm.dts        | 2 --
>   arch/arm64/boot/dts/ti/k3-am642-sk.dts         | 1 -

I think you missed to update all non TI boards.

Regards,
Wadim

>   6 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 410b390ce5d5..55420eb1c620 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -559,9 +559,9 @@ sdhci0: mmc@fa10000 {
>   		clock-names = "clk_ahb", "clk_xin";
>   		assigned-clocks = <&k3_clks 57 6>;
>   		assigned-clock-parents = <&k3_clks 57 8>;
> +		bus-width = <8>;
>   		mmc-ddr-1_8v;
>   		mmc-hs200-1_8v;
> -		bus-width = <8>;
>   		ti,clkbuf-sel = <0x7>;
>   		ti,otap-del-sel-legacy = <0x0>;
>   		ti,otap-del-sel-mmc-hs = <0x0>;
> @@ -579,6 +579,7 @@ sdhci1: mmc@fa00000 {
>   		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
>   		clock-names = "clk_ahb", "clk_xin";
> +		bus-width = <4>;
>   		ti,clkbuf-sel = <0x7>;
>   		ti,otap-del-sel-legacy = <0x8>;
>   		ti,otap-del-sel-sd-hs = <0x0>;
> @@ -591,7 +592,6 @@ sdhci1: mmc@fa00000 {
>   		ti,itap-del-sel-sd-hs = <0x1>;
>   		ti,itap-del-sel-sdr12 = <0xa>;
>   		ti,itap-del-sel-sdr25 = <0x1>;
> -		bus-width = <4>;
>   		status = "disabled";
>   	};
>   
> @@ -602,6 +602,7 @@ sdhci2: mmc@fa20000 {
>   		power-domains = <&k3_pds 184 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 184 5>, <&k3_clks 184 6>;
>   		clock-names = "clk_ahb", "clk_xin";
> +		bus-width = <4>;
>   		ti,clkbuf-sel = <0x7>;
>   		ti,otap-del-sel-legacy = <0x8>;
>   		ti,otap-del-sel-sd-hs = <0x0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> index bb6a5837bcb3..a34e0df2ab86 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> @@ -842,7 +842,6 @@ &sdhci2 {
>   	vmmc-supply = <&wlan_en>;
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&wifi_pins_default>, <&wifi_32k_clk>;
> -	bus-width = <4>;
>   	non-removable;
>   	ti,fails-without-test-cd;
>   	cap-power-off-card;
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> index ddb76cd66f88..253c1857eedf 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -561,6 +561,7 @@ sdhci1: mmc@fa00000 {
>   		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 58 5>, <&k3_clks 58 6>;
>   		clock-names = "clk_ahb", "clk_xin";
> +		bus-width = <4>;
>   		ti,clkbuf-sel = <0x7>;
>   		ti,otap-del-sel-legacy = <0x0>;
>   		ti,otap-del-sel-sd-hs = <0x0>;
> @@ -573,7 +574,6 @@ sdhci1: mmc@fa00000 {
>   		ti,itap-del-sel-sd-hs = <0x0>;
>   		ti,itap-del-sel-sdr12 = <0x0>;
>   		ti,itap-del-sel-sdr25 = <0x0>;
> -		bus-width = <4>;
>   		no-1-8-v;
>   		status = "disabled";
>   	};
> diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> index bea05be7cb48..bc9c9ff993e6 100644
> --- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
> @@ -626,6 +626,7 @@ sdhci0: mmc@fa10000 {
>   		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 57 0>, <&k3_clks 57 1>;
>   		clock-names = "clk_ahb", "clk_xin";
> +		bus-width = <8>;
>   		mmc-ddr-1_8v;
>   		mmc-hs200-1_8v;
>   		ti,clkbuf-sel = <0x7>;
> @@ -647,6 +648,7 @@ sdhci1: mmc@fa00000 {
>   		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
>   		clocks = <&k3_clks 58 3>, <&k3_clks 58 4>;
>   		clock-names = "clk_ahb", "clk_xin";
> +		bus-width = <4>;
>   		ti,clkbuf-sel = <0x7>;
>   		ti,otap-del-sel-legacy = <0x0>;
>   		ti,otap-del-sel-sd-hs = <0x0>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> index f308076d608a..83f2b00726b5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
> @@ -494,7 +494,6 @@ eeprom@0 {
>   /* eMMC */
>   &sdhci0 {
>   	status = "okay";
> -	bus-width = <8>;
>   	non-removable;
>   	ti,driver-strength-ohm = <50>;
>   	disable-wp;
> @@ -506,7 +505,6 @@ &sdhci1 {
>   	status = "okay";
>   	vmmc-supply = <&vdd_mmc1>;
>   	pinctrl-names = "default";
> -	bus-width = <4>;
>   	pinctrl-0 = <&main_mmc1_pins_default>;
>   	disable-wp;
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> index b286eaa02ada..67cd41bf806e 100644
> --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> @@ -469,7 +469,6 @@ &sdhci1 {
>   	status = "okay";
>   	vmmc-supply = <&vdd_mmc1>;
>   	pinctrl-names = "default";
> -	bus-width = <4>;
>   	pinctrl-0 = <&main_mmc1_pins_default>;
>   	disable-wp;
>   };

