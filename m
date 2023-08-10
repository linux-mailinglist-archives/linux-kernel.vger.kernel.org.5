Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5987777795
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjHJLyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjHJLyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:54:09 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE6E91;
        Thu, 10 Aug 2023 04:54:08 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37ABrk8c028316;
        Thu, 10 Aug 2023 06:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691668426;
        bh=2x5vUfJ+hzoSv36AHHqY1x0GU0dc6lOs8jv6cI6xFzs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=gr6vhGLaxPoyfXC+8xcWtbewhvCWx+HrKgS36YsrqyrQyRyveS/Tgnaf3gv9ADWzJ
         No8noWxvJ+QS0gnvP7N/1O1yDQbI/0+A6sRXgtNlqpZ+R8kTacJ4DSb3UDKCm1eJgJ
         JJxG7XUNVX9TjflK8ILvFS1/oWkT5iAZUigPNZ8k=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37ABrkYs031658
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 06:53:46 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 06:53:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 06:53:45 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37ABrdbi089170;
        Thu, 10 Aug 2023 06:53:40 -0500
Message-ID: <ab69c4df-708f-8fff-a58b-a6531e15627b@ti.com>
Date:   Thu, 10 Aug 2023 17:23:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j7200: Add the supported
 frequencies for A72
To:     Nishanth Menon <nm@ti.com>, Apurva Nandan <a-nandan@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rafael J Wysocki <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Keerthy J <j-keerthy@ti.com>,
        <u-kumar1@ti.com>
References: <20230809173905.1844132-1-a-nandan@ti.com>
 <20230809173905.1844132-3-a-nandan@ti.com>
 <20230809190943.unpcbrinyn5ppei7@hydrated>
Content-Language: en-US
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230809190943.unpcbrinyn5ppei7@hydrated>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/2023 12:39 AM, Nishanth Menon wrote:
> On 23:09-20230809, Apurva Nandan wrote:
>> From: Keerthy <j-keerthy@ti.com>
>>
>> Add 750M, 1G, 1.5G & 2G as the supported frequencies for A72.
>> This enables support for Dynamic Frequency Scaling(DFS)
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j7200.dtsi | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
>> index ef73e6d7e858..7222c453096f 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
>> @@ -48,6 +48,10 @@ cpu0: cpu@0 {
>>   			d-cache-line-size = <64>;
>>   			d-cache-sets = <256>;
>>   			next-level-cache = <&L2_0>;
>> +			clocks = <&k3_clks 202 2>;
>> +			clock-names = "cpu";
>> +			operating-points-v2 = <&cpu0_opp_table>;
>> +			#cooling-cells = <2>; /* min followed by max */
>>   		};
>>   
>>   		cpu1: cpu@1 {
>> @@ -62,6 +66,30 @@ cpu1: cpu@1 {
>>   			d-cache-line-size = <64>;
>>   			d-cache-sets = <256>;
>>   			next-level-cache = <&L2_0>;
>> +			clocks = <&k3_clks 203 0>;
>> +			clock-names = "cpu";
>> +			operating-points-v2 = <&cpu0_opp_table>;
>> +			#cooling-cells = <2>; /* min followed by max */
>> +		};
>> +	};
>> +
>> +	cpu0_opp_table: opp-table {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp4-2000000000 {
>> +			opp-hz = /bits/ 64 <2000000000>;
>> +		};
>> +
>> +		opp3-1500000000 {
>> +			opp-hz = /bits/ 64 <1500000000>;
>> +		};
>> +
>> +		opp2-1000000000 {
>> +			opp-hz = /bits/ 64 <1000000000>;
>> +		};
>> +
>> +		opp1-750000000 {
>> +			opp-hz = /bits/ 64 <750000000>;
>>   		};
>>   	};
>>   
>> -- 
>> 2.34.1
>>
> Are you sure this is correct to enable all OPPs without efuse bit checks?
>
> https://www.ti.com/lit/ds/symlink/dra821u-q1.pdf
> 7.5 Operating Performance Points
> DRA821xC operates only upto 750MHz
> DRA821xE at 1GHz
> DRA821xL upto 1.5GHz and
> DRA821xT upto 2GHz

Looks, top SKUs is considered here .

After detecting which SKU we are running (I hope TRM should have this 
information- through efuse or some other register)

I think, we can follow two approaches.

1) have OPP table for each SKU and select based SKUs type or

2) Do run time fixup by u-boot based upon SKU type


