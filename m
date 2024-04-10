Return-Path: <linux-kernel+bounces-137940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B6F89E9D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DC01C21555
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC58B28684;
	Wed, 10 Apr 2024 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CcrBEod+"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38781CD22;
	Wed, 10 Apr 2024 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712727402; cv=none; b=Xoyax6JOkH+AtUm+NI6te7r9oCl7Z1n1QZ5BPbQ2yQuKX0Eezc/WDH1JdsodiJoGNJNEmD/YPsxA1S3TInwaNgLvw+lxSXFcFXgkWX/5KRiMB0hpTA/rR7t95IeTrK5w1L2LqvbGd1L0+YkPKk+lOjxWL9uFA8ue49AWCeX7Mi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712727402; c=relaxed/simple;
	bh=LtSDeAsJ+4SWm9wByi2DhLCqTBwpDzN5PPJS7j+gizo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kxUoLAM+Dp4TO7mxMp20kbJiwJRJQWZScpe3iPmJG3FI6er6QoLh0D5NnsarIIOSlEDwOj2d/jKbWKO9foZcNYCTeXFWNAE9atYFuiu7i2JbsMQgNvTwhvceR3QHGXfnLnh6lH1zb2eYnclgVChz4Y8wRw5e/Wjropr95I9MjRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CcrBEod+; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43A5aS2A052354;
	Wed, 10 Apr 2024 00:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712727388;
	bh=Oxa0nWrISrf6ZE0JvFIznpZ3rLdWaI2az+Zz5A5Q81Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=CcrBEod+Cznes0dZwJ2ssshvTaaQ+/eP6eElyvGpylQk4M3Xu746cqCWamgUKvEHf
	 oRHoUY+IoyI9ueDaTRjO0/zfZc9riSb9505k4XN5YNvyS3hg8JxLfz2wHsf0SoEuSI
	 zozOtvxLI6rSQEe3nAHbsGpr/ebK7k0EMQg8OrpU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43A5aSa4124434
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 00:36:28 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 00:36:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 00:36:28 -0500
Received: from [172.24.20.156] (lt5cd2489kgj.dhcp.ti.com [172.24.20.156])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43A5aOJe016251;
	Wed, 10 Apr 2024 00:36:25 -0500
Message-ID: <a329fc6b-561c-4300-8778-c90ca97b70f3@ti.com>
Date: Wed, 10 Apr 2024 11:06:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: ti: k3-j721e-main: Add the MAIN domain
 watchdog instances
To: Neha Malcom Francis <n-francis@ti.com>, <robh@kernel.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>
References: <20240326122723.2329402-1-n-francis@ti.com>
 <20240326122723.2329402-4-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240326122723.2329402-4-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Neha

On 3/26/2024 5:57 PM, Neha Malcom Francis wrote:
> There are 10 watchdog instances in the MAIN domain:
> 	* one each for the 2 A72 cores
> 	* one for the GPU core
> 	* one for the C7x core
> 	* one each for the 2 C66x cores
> 	* one each for the 4 R5F cores
>
> Currently, the devicetree only describes watchdog instances for the A72
> cores and enables them. Describe the remaining but reserve them as they
> will be used by their respective firmware.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 93 +++++++++++++++++++++++
>   1 file changed, 93 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index c7eafbc862f9..d8930b8ea8ec 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -2157,6 +2157,99 @@ watchdog1: watchdog@2210000 {
>   		assigned-clock-parents = <&k3_clks 253 5>;
>   	};
>   

Looking at TRM, SPRUIJ7*3–December 2018–Revised March 2019,

Table 12-22646. RTI Instances, says There is gap in numbering

RTI0, RTI1, RTI15 and so on

IMO, labels for watchdog should be as per TRM.

eg watchdog2 to watchdog15, But I don't have strong opinion on either .

Let maintainer suggest on this



> +	/*
> +	 * The following RTI instances are coupled with MCU R5Fs, c7x and
> +	 * GPU so keeping them reserved as these will be used by their
> +	 * respective firmware
> +	 */
> +	watchdog2: watchdog@22f0000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x22f0000 0x00 0x100>;
> +		clocks = <&k3_clks 257 1>;
> +		power-domains = <&k3_pds 257 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 257 1>;
> +		assigned-clock-parents = <&k3_clks 257 5>;
> +		/* reserved for GPU */
> +		status = "reserved";
> +	};

Please help me to understand, where from you got it for GPU,

May be I am looking at wrong data, Again above TRM

Table 12-22645. RTI Hardware Requests. RTI-15 says esm0

> +
> +	watchdog3: watchdog@2300000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2300000 0x00 0x100>;
> +		clocks = <&k3_clks 256 1>;
> +		power-domains = <&k3_pds 256 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 256 1>;
> +		assigned-clock-parents = <&k3_clks 256 5>;
> +		/* reserved for C7X */
> +		status = "reserved";

This I see in above table for Compute Cluster


> +	};
> +
> +	watchdog4: watchdog@2380000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2380000 0x00 0x100>;
> +		clocks = <&k3_clks 254 1>;
> +		power-domains = <&k3_pds 254 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 254 1>;
> +		assigned-clock-parents = <&k3_clks 254 5>;
> +		/* reserved for C66X_0 */
> +		status = "reserved";
> +	};
> +
> +	watchdog5: watchdog@2390000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x2390000 0x00 0x100>;
> +		clocks = <&k3_clks 255 1>;
> +		power-domains = <&k3_pds 255 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 255 1>;
> +		assigned-clock-parents = <&k3_clks 255 5>;
> +		/* reserved for C66X_1 */
> +		status = "reserved";
> +	};
> +
> +	watchdog6: watchdog@23c0000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x23c0000 0x00 0x100>;
> +		clocks = <&k3_clks 258 1>;
> +		power-domains = <&k3_pds 258 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 258 1>;
> +		assigned-clock-parents = <&k3_clks 258 5>;
> +		/* reserved for MAIN_R5F0_0 */

TRM says, this covers both MAIN_R5F0_0 and MAIN_R5F0_1.

Suggest , if split is done at fw level

> +		status = "reserved";
> +	};
> +
> +	watchdog7: watchdog@23d0000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x23d0000 0x00 0x100>;
> +		clocks = <&k3_clks 259 1>;
> +		power-domains = <&k3_pds 259 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 259 1>;
> +		assigned-clock-parents = <&k3_clks 259 5>;
> +		/* reserved for MAIN_R5F0_1 */
> +		status = "reserved";

TRM says, this covers both MAIN_R5F0_0 and MAIN_R5F0_1.

Suggest , if split is done at fw level

> +	};
> +
> +	watchdog8: watchdog@23e0000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x23e0000 0x00 0x100>;
> +		clocks = <&k3_clks 260 1>;
> +		power-domains = <&k3_pds 260 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 260 1>;
> +		assigned-clock-parents = <&k3_clks 260 5>;
> +		/* reserved for MAIN_R5F1_0 */
> +		status = "reserved";
> +	};


TRM says, this covers both MAIN_R5F1_0 and MAIN_R5F1_1.

Suggest , if split is done at fw level

> +
> +	watchdog9: watchdog@23f0000 {
> +		compatible = "ti,j7-rti-wdt";
> +		reg = <0x00 0x23f0000 0x00 0x100>;
> +		clocks = <&k3_clks 261 1>;
> +		power-domains = <&k3_pds 261 TI_SCI_PD_EXCLUSIVE>;
> +		assigned-clocks = <&k3_clks 261 1>;
> +		assigned-clock-parents = <&k3_clks 261 5>;
> +		/* reserved for MAIN_R5F1_1 */

TRM says, this covers both MAIN_R5F1_0 and MAIN_R5F1_1.

Suggest , if split is done at fw level

> +		status = "reserved";
> +	};
> +
>   	main_r5fss0: r5fss@5c00000 {
>   		compatible = "ti,j721e-r5fss";
>   		ti,cluster-mode = <1>;

