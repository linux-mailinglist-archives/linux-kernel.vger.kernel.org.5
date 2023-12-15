Return-Path: <linux-kernel+bounces-431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9848F814108
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9321C222E0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5035C8B;
	Fri, 15 Dec 2023 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="blWWs3oA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DA61C31;
	Fri, 15 Dec 2023 04:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BF4ZMPm007874;
	Thu, 14 Dec 2023 22:35:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702614922;
	bh=TqkuE3IaNsfxGluCRlbhiAbEisNRx1SSuG+cTdskFHE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=blWWs3oAptNKU2UgSac/LIDWL3b9wJiLR8/lTyJrWJV4bmQnkBoYlz6tqF1+JdYrU
	 KqyUJeC+A8VMiwIsoZEA6b1cx3VahgcgnBaXzcrlLARFNGFyVv8rUHv9fniRZWQtjf
	 Ujbaw/E/ialE+vBL/V+cy5ze9CAW5XnpScOSi2cs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BF4ZMe0077973
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 Dec 2023 22:35:22 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Dec 2023 22:35:22 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Dec 2023 22:35:22 -0600
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BF4ZJPW117255;
	Thu, 14 Dec 2023 22:35:19 -0600
Message-ID: <babed3d7-0daf-4aa0-8bab-627d585ca224@ti.com>
Date: Fri, 15 Dec 2023 10:05:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e: Add support for DFS in J721E
 A72
To: Nishanth Menon <nm@ti.com>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <a-nandan@ti.com>, <kristo@kernel.org>, <u-kumar1@ti.com>
References: <20231214075637.176586-1-n-francis@ti.com>
 <20231214125130.zqtq6ioj4c533wha@elbow>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231214125130.zqtq6ioj4c533wha@elbow>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth

On 14/12/23 18:21, Nishanth Menon wrote:
> On 13:26-20231214, Neha Malcom Francis wrote:
>> Add 2G, 1.5G, 1G, 750M, 500M and 250M as the supported frequencies for
>> A72. This enables support for Dynamic Frequency Scaling (DFS).
>>
> 
> Just curious, since I picked up the PMIC support... can we do dvfs? if
> not, please indicate that in the commit message.
> 

DVFS is not supported on J7 devices, I'll mention that in v2.

>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>> Boot logs:
>> https://gist.github.com/nehamalcom/e3c3d0446f0467e7fd28706f7ffaeea8
>>
>> J721E SoC has three different speed grade devices (see [1], 7.5
>> Operating Performance Points) which as of today are indiscernible in
>> software, users of a different speed grade device must manually change
>> the DTS to ensure their maximum speed frequency is supported.
>>
>> [1] https://www.ti.com/lit/gpn/tda4vm
> This is critical info in the commit message and in documentation of
> source.
> 

Will put that in the commit message.

> I am also concerned if the table should be separated out as a dtsi and
> included at board.dts level to prevent downstream users going crazy..
> 

Hm... could you elaborate on that more? I don't understand the reasoning of 
including this at a board level for a SoC problem.

> Are you absolutely sure this has no detection logic that can be
> implemented? Almost all TI K3 SoCs seem to have a standard scheme to
> detect the speed grades till date. /me wonders what the heck happened
> here..
> 

Going through the reference manual and data sheet I didn't find anything that 
could differentiate between speed grades, this was confirmed for J7200, I'll do 
the needful to confirm this for J721E as well before v2.

>>
>>   arch/arm64/boot/dts/ti/k3-j721e.dtsi | 35 ++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
>> index a200810df54a..fe92879f5812 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
>> @@ -48,6 +48,9 @@ cpu0: cpu@0 {
>>   			d-cache-line-size = <64>;
>>   			d-cache-sets = <256>;
>>   			next-level-cache = <&L2_0>;
>> +			clocks = <&k3_clks 202 2>;
>> +			clock-names = "cpu";
>> +			operating-points-v2 = <&cpu0_opp_table>;
>>   		};
>>   
>>   		cpu1: cpu@1 {
>> @@ -62,9 +65,41 @@ cpu1: cpu@1 {
>>   			d-cache-line-size = <64>;
>>   			d-cache-sets = <256>;
>>   			next-level-cache = <&L2_0>;
>> +			clocks = <&k3_clks 203 0>;
>> +			clock-names = "cpu";
>> +			operating-points-v2 = <&cpu0_opp_table>;
>>   		};
>>   	};
>>   
>> +	cpu0_opp_table: opp-table {
>> +		compatible = "operating-points-v2";
> Don't you need opp-shared ?

opp-shared would imply that the CPUs switch DFS states together... is that 
something we want?

>> +
>> +		opp6-2000000000 {
>> +			opp-hz = /bits/ 64 <2000000000>;
>> +		};
>> +
>> +		opp5-1500000000 {
>> +			opp-hz = /bits/ 64 <1500000000>;
>> +		};
>> +
>> +		opp4-1000000000 {
>> +			opp-hz = /bits/ 64 <1000000000>;
>> +		};
>> +
>> +		opp3-750000000 {
>> +			opp-hz = /bits/ 64 <750000000>;
>> +		};
>> +
>> +		opp2-500000000 {
>> +			opp-hz = /bits/ 64 <500000000>;
>> +		};
>> +
>> +		opp1-250000000 {
>> +			opp-hz = /bits/ 64 <250000000>;
> Could you add clock-latency-ns ?

Will add in v2.

>> +		};
>> +
>> +	};
>> +
>>   	L2_0: l2-cache0 {
>>   		compatible = "cache";
>>   		cache-level = <2>;
>> -- 
>> 2.34.1
>>
> 
> 

Thanks for reviewing!

-- 
Thanking You
Neha Malcom Francis

