Return-Path: <linux-kernel+bounces-16842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446938244CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA371C21E35
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0B1241E8;
	Thu,  4 Jan 2024 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cJmiX8ix"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1022249FF;
	Thu,  4 Jan 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 404FGoGf022442;
	Thu, 4 Jan 2024 09:16:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704381410;
	bh=1vVZQWCwm6Aj79XrJxm6KaggjAzeXoVxnAU3BgYJzNE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=cJmiX8ixi+74wWuZdZaxJehD+9jpabLWXKenhDNsCPEdm8MCUpHi6Nl5IiSCNfsnW
	 FUO/lZOpvtCmJyuyeI0oiv/eObYGls0euuQvRKSybj0rhKupUkG6TINwPogag6rZuu
	 ty7rT1Z6l1hEJACvkx1SA+1VlaG9lQ7WXXWGECCg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 404FGoc2012514
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jan 2024 09:16:50 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jan 2024 09:16:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jan 2024 09:16:50 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 404FGoSG002746;
	Thu, 4 Jan 2024 09:16:50 -0600
Date: Thu, 4 Jan 2024 09:16:50 -0600
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <a-nandan@ti.com>, <kristo@kernel.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721e: Add support for DFS in
 J721E A72
Message-ID: <20240104151650.my3cuhgase4yf7gj@luminance>
References: <20240104111922.832040-1-n-francis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240104111922.832040-1-n-francis@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 16:49-20240104, Neha Malcom Francis wrote:
> Add 2G, 1G, 500M and 250M as the supported frequencies for A72. This
> enables support for Dynamic Frequency Scaling (DFS). Note that Dynamic
> Voltage and Frequency Scaling (DVFS) is not supported on J7 devices.
> 
> J721E SoC has three different speed grade devices (see [1], 7.5
> Operating Performance Points) which as of today are indiscernible in
> software, users of a different speed grade device must manually change
> the DTS to ensure their maximum speed frequency is supported.
> 
> To obtain clock-latency-ns, the maximum time was found to switch from/to
> any frequency for a CPU and this value was rounded off and set.
> 
> [1] https://www.ti.com/lit/gpn/tda4vm
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Test and boot logs:
> https://gist.github.com/nehamalcom/33608837ab5ad3332ff11a7fa7a602e2
> 
> Changes since v1:
> https://lore.kernel.org/all/20231214075637.176586-1-n-francis@ti.com/
> - removed OPPs 1.5G and 750M as they introduced boot regression in
>   J721E-SK

I do not think this is the right approach precisely for the above
reason.

See my comment in V1: https://lore.kernel.org/all/20231214125130.zqtq6ioj4c533wha@elbow/

"
I am also concerned if the table should be separated out as a dtsi and
included at board.dts level to prevent downstream users going crazy..
"

I suspect there is no magic opp configuration that will work with all
downstream and board variations. instead of creating a trimmed down
non-datasheet tuples of OPP configuration, use the data sheet provided
OPP configurations into each dtsi and the boards can apply the dtsi
based on the type of sample they have.

I don't see any other scheme (overlays, maybe?).. but this approach is
broken and your note above proves why this approach is broken.

> - Nishanth
> 	- indicated DVFS not supported in commit message
> 	- moved critical data sheet info from below tear line to commit
> 	  message
> 	- added opp-shared property
> 	- added clock-latency-ns property
> 
>  arch/arm64/boot/dts/ti/k3-j721e.dtsi | 31 ++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> index a200810df54a..5de6c70bd989 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> @@ -48,6 +48,9 @@ cpu0: cpu@0 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <256>;
>  			next-level-cache = <&L2_0>;
> +			clocks = <&k3_clks 202 2>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu0_opp_table>;
>  		};
>  
>  		cpu1: cpu@1 {
> @@ -62,6 +65,34 @@ cpu1: cpu@1 {
>  			d-cache-line-size = <64>;
>  			d-cache-sets = <256>;
>  			next-level-cache = <&L2_0>;
> +			clocks = <&k3_clks 203 0>;
> +			clock-names = "cpu";
> +			operating-points-v2 = <&cpu0_opp_table>;
> +		};
> +	};
> +
> +	cpu0_opp_table: opp-table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp6-2000000000 {
> +			opp-hz = /bits/ 64 <2000000000>;
> +			clock-latency-ns = <300000>;
> +		};
> +
> +		opp4-1000000000 {
> +			opp-hz = /bits/ 64 <1000000000>;
> +			clock-latency-ns = <300000>;
> +		};
> +
> +		opp2-500000000 {
> +			opp-hz = /bits/ 64 <500000000>;
> +			clock-latency-ns = <300000>;
> +		};
> +
> +		opp1-250000000 {
> +			opp-hz = /bits/ 64 <250000000>;
> +			clock-latency-ns = <300000>;
>  		};
>  	};
>  
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

