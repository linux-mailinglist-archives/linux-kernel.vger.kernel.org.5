Return-Path: <linux-kernel+bounces-7069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B2281A139
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8EA286B19
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AEA3D3B8;
	Wed, 20 Dec 2023 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X0tJIcSN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAA33D388;
	Wed, 20 Dec 2023 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703083139;
	bh=R2rCuNyBRNg+TZc+54PKcT/z1boJ+LwN+LmqAXkaP/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X0tJIcSNYys6pId5gicm+KV2lXyiMvnfhqnbfLkeIrLVagWhtD9/nu0HkawJJDZ92
	 9LsuYl+fGgBv71HfR/uf8KTiD3CMZSj0sOBklIQxsM7Nej+ajAsdmOsxJVrCS763gY
	 By0r6Vufa3ZmiJ/gxTKM8ac/SMsKZn4nDWjaN/GCMp6wIsVjT34bLCAzM5MBUSlMrm
	 nvLayth3R3flPJztmXFpey/7AbgNVk49+TAZ4dIIFW3PyrOZ29r95hz8Vtm0EvMiCI
	 F2VOLNYuqLcFguIbZ419VfnJUrRi6jZMHEd73Z3z7rlO72UReuFNxBsXxX5mz/NMlw
	 xFGETRxG0hMMQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F30873781F8F;
	Wed, 20 Dec 2023 14:38:57 +0000 (UTC)
Message-ID: <3b2d41cd-4c0a-4277-8650-e6da37139023@collabora.com>
Date: Wed, 20 Dec 2023 16:38:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] riscv: dts: starfive: jh7100: Add sysmain and gmac
 DT nodes
Content-Language: en-US
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kernel@collabora.com
References: <20231220004638.2463643-1-cristian.ciocaltea@collabora.com>
 <20231220004638.2463643-2-cristian.ciocaltea@collabora.com>
 <CAJM55Z9DhojDTDPEqx3NO5g61=ezRg-U9odixbZugcXRRVmS7w@mail.gmail.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAJM55Z9DhojDTDPEqx3NO5g61=ezRg-U9odixbZugcXRRVmS7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/23 15:43, Emil Renner Berthing wrote:
> Cristian Ciocaltea wrote:
>> Provide the sysmain and gmac DT nodes supporting the DWMAC found on the
>> StarFive JH7100 SoC.
>>
>> Co-developed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>> ---
>>  arch/riscv/boot/dts/starfive/jh7100.dtsi | 36 ++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
>> index c216aaecac53..2ebdebe6a81c 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
>> @@ -204,6 +204,37 @@ sdio1: mmc@10010000 {
>>  			status = "disabled";
>>  		};
>>
>> +		gmac: ethernet@10020000 {
>> +			compatible = "starfive,jh7100-dwmac", "snps,dwmac";
>> +			reg = <0x0 0x10020000 0x0 0x10000>;
>> +			clocks = <&clkgen JH7100_CLK_GMAC_ROOT_DIV>,
>> +				 <&clkgen JH7100_CLK_GMAC_AHB>,
>> +				 <&clkgen JH7100_CLK_GMAC_PTP_REF>,
>> +				 <&clkgen JH7100_CLK_GMAC_TX_INV>,
>> +				 <&clkgen JH7100_CLK_GMAC_GTX>;
>> +			clock-names = "stmmaceth", "pclk", "ptp_ref", "tx", "gtx";
>> +			resets = <&rstgen JH7100_RSTN_GMAC_AHB>;
>> +			reset-names = "ahb";
>> +			interrupts = <6>, <7>;
>> +			interrupt-names = "macirq", "eth_wake_irq";
>> +			max-frame-size = <9000>;
>> +			snps,multicast-filter-bins = <32>;
>> +			snps,perfect-filter-entries = <128>;
>> +			starfive,syscon = <&sysmain 0x70 0>;
>> +			rx-fifo-depth = <32768>;
>> +			tx-fifo-depth = <16384>;
>> +			snps,axi-config = <&stmmac_axi_setup>;
>> +			snps,fixed-burst;
>> +			snps,force_thresh_dma_mode;
> 
> Compared to v4 you're missing a
> 
>   snps,no-pbl-x8;
> 
> here. It might be the right thing to do, but then I would have expected
> it to me mentioned in the cover letter version history.

Oh yes, I missed to add this to the changelog, sorry!  I dropped that
because the property is only valid for snps,dwmac-{3.50a, 4.10a, 4.20a,
5.20} compatibles, while we have plain snps,dwmac to handle 3.7x.

We could have probably used snps,dwmac-3.70a or snps,dwmac-3.710, but
I'm not sure which is the exact chip revision and it wouldn't really
change anything as there is no special handling for them in the
snps,dwmac.yaml binding.

>> +			status = "disabled";
>> +
>> +			stmmac_axi_setup: stmmac-axi-config {
>> +				snps,wr_osr_lmt = <16>;
>> +				snps,rd_osr_lmt = <16>;
>> +				snps,blen = <256 128 64 32 0 0 0>;
>> +			};
>> +		};
>> +
>>  		clkgen: clock-controller@11800000 {
>>  			compatible = "starfive,jh7100-clkgen";
>>  			reg = <0x0 0x11800000 0x0 0x10000>;
>> @@ -218,6 +249,11 @@ rstgen: reset-controller@11840000 {
>>  			#reset-cells = <1>;
>>  		};
>>
>> +		sysmain: syscon@11850000 {
>> +			compatible = "starfive,jh7100-sysmain", "syscon";
>> +			reg = <0x0 0x11850000 0x0 0x10000>;
>> +		};
>> +
>>  		i2c0: i2c@118b0000 {
>>  			compatible = "snps,designware-i2c";
>>  			reg = <0x0 0x118b0000 0x0 0x10000>;
>> --
>> 2.43.0
>>

