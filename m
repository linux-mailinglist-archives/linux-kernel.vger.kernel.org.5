Return-Path: <linux-kernel+bounces-162397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A1B8B5A92
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF74F28B45F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8427C6D4;
	Mon, 29 Apr 2024 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MFPwtNQR"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B97BB15;
	Mon, 29 Apr 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398691; cv=none; b=GA5ysuWGIJOzj+uEYbO9JpKWehIYOrfAdYLRSZZ71RmdI+2NOmwgTFhEaM71llItx1saaST7ARRhDzKS29S3R5o4yzsvLpBgBBEn/13jPSY3H55sJPmO5q1PuPB3SH0Qm0Blj/5/DSeLl3/ymfxyJgBl6qpAivP6ke0qnLfly0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398691; c=relaxed/simple;
	bh=b7Rg1QyyNp473bNWrsPGhu6YROme/S3QIe4I6xPMgrw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lyzhm6XE5WHEZk5teE8BohOifu8JREM0l1+OqP7KdUonbybBHy2GeLzMkVeVMOb6DXmfiSVWcXej5E7zzZyQnfCjXx1zUVhey8WCIRiCiwLMRSIYm1Gkhl/q2FGSQC6Fdn1DbHrt5iI20u5T2hSqRYY3R3rzCQb1rAfmnkqmQ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MFPwtNQR; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714398684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YSn6AgyIXRGau81MN3D1/UxkQL5cT1aZKXSLaJirts=;
	b=MFPwtNQRuOOkgnq58Vrp262/QR28weK3CTp7uOtSQGrJ+B3I1NyvN+srZ+FYWxDK/WGk96
	/DGS2DnHkYxDzZ7dicu6yaFpwj4rCB4lV8Nvwv42dDfqAG2UOci1Y1ggHhSG8cgk8sJDQQ
	aGhzaV1KSxVIEjf68TXhWrVgMdBKkxEFjD7L9vNj+5Smryl7gQ0ei8+UHoRMlJMDeg766A
	rRRtpUQ8kfdaGjwXZkIbguFjU5o5qOpr7Y+0AHMLe38fFt8NK29Do1DWw6HuQT2ctMUWPD
	9g8bLBiNo4676hTW3rTcONhAwgrFGDJA9BL25pyQgvWZLX6mcZ2YpOZ2E/Qvtg==
Date: Mon, 29 Apr 2024 15:51:23 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for A64
In-Reply-To: <20240429113321.1f4da653@donnerap.manchester.arm.com>
References: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
 <20240429113321.1f4da653@donnerap.manchester.arm.com>
Message-ID: <789ac34fc2e0329210b4cfe73eb30bec@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andre,

On 2024-04-29 12:33, Andre Przywara wrote:
> On Sun, 28 Apr 2024 13:40:35 +0200
> Dragan Simic <dsimic@manjaro.org> wrote:
> thanks for taking care of this!

Thank you for reviewing my patch!

>> Add missing cache information to the Allwinner A64 SoC dtsi, to allow
>> the userspace, which includes lscpu(1) that uses the virtual files 
>> provided
>> by the kernel under the /sys/devices/system/cpu directory, to display 
>> the
>> proper A64 cache information.
>> 
>> While there, use a more self-descriptive label for the L2 cache node, 
>> which
>> also makes it more consistent with other SoC dtsi files.
>> 
>> The cache parameters for the A64 dtsi were obtained and partially 
>> derived
>> by hand from the cache size and layout specifications found in the 
>> following
>> datasheets and technical reference manuals:
>> 
>>   - Allwinner A64 datasheet, version 1.1
>>   - ARM Cortex-A53 revision r0p3 TRM, version E
>> 
>> For future reference, here's a brief summary of the documentation:
>> 
>>   - All caches employ the 64-byte cache line length
>>   - Each Cortex-A53 core has 32 KB of L1 2-way, set-associative 
>> instruction
>>     cache and 32 KB of L1 4-way, set-associative data cache
>>   - The entire SoC has 512 KB of unified L2 16-way, set-associative 
>> cache
> 
> So that looks correct when checking the manuals, and the per-CPU
> entries below match both between themselves and with that description
> above.
> However I have some level of distrust towards the Allwinner manuals,
> regarding the cache sizes (which are chosen by Allwinner).

Quite frankly, I was surprised a bit to see that the A64 contains
512 KB of L2 cache.  IMHO, that's quite a lot for an SoC that was
advertised primarily as a cost-effective solution.

> So while I haven't measured this myself, nor checked the cache type
> registers, tinymembench's memory latency test supports those sizes are
> correct:
> https://github.com/ssvb/tinymembench/wiki/PINE64-(Allwinner-A64)

Ah, that's a nice benchmark report.  Let me copy & paste the most
relevant part of that report below, just for future reference in
case that web page becomes inaccessible at some point:

==========================================================================
== Memory latency test                                                  
==
==                                                                      
==
== Average time is measured for random memory accesses in the buffers   
==
== of different sizes. The larger is the buffer, the more significant   
==
== are relative contributions of TLB, L1/L2 cache misses and SDRAM      
==
== accesses. For extremely large buffer sizes we are expecting to see   
==
== page table walk with several requests to SDRAM for almost every      
==
== memory access (though 64MiB is not nearly large enough to experience 
==
== this effect to its fullest).                                         
==
==                                                                      
==
== Note 1: All the numbers are representing extra time, which needs to  
==
==         be added to L1 cache latency. The cycle timings for L1 cache 
==
==         latency can be usually found in the processor documentation. 
==
== Note 2: Dual random read means that we are simultaneously performing 
==
==         two independent memory accesses at a time. In the case if    
==
==         the memory subsystem can't handle multiple outstanding       
==
==         requests, dual random read has the same timings as two       
==
==         single reads performed one after another.                    
==
==========================================================================

block size : single random read / dual random read, [MADV_NOHUGEPAGE]
       1024 :    0.0 ns          /     0.0 ns
       2048 :    0.0 ns          /     0.0 ns
       4096 :    0.0 ns          /     0.0 ns
       8192 :    0.0 ns          /     0.0 ns
      16384 :    0.0 ns          /     0.0 ns
      32768 :    0.0 ns          /     0.0 ns
      65536 :    5.9 ns          /    10.0 ns
     131072 :    9.1 ns          /    14.0 ns
     262144 :   10.7 ns          /    15.5 ns
     524288 :   12.7 ns          /    17.7 ns
    1048576 :   92.8 ns          /   143.2 ns
    2097152 :  134.9 ns          /   184.4 ns
    4194304 :  163.5 ns          /   207.1 ns
    8388608 :  178.6 ns          /   217.6 ns
   16777216 :  187.5 ns          /   223.7 ns
   33554432 :  192.8 ns          /   228.0 ns
   67108864 :  195.8 ns          /   230.7 ns

block size : single random read / dual random read, [MADV_HUGEPAGE]
       1024 :    0.0 ns          /     0.0 ns
       2048 :    0.0 ns          /     0.0 ns
       4096 :    0.0 ns          /     0.0 ns
       8192 :    0.0 ns          /     0.0 ns
      16384 :    0.0 ns          /     0.0 ns
      32768 :    0.0 ns          /     0.0 ns
      65536 :    5.9 ns          /    10.0 ns
     131072 :    9.1 ns          /    14.0 ns
     262144 :   10.7 ns          /    15.6 ns
     524288 :   12.6 ns          /    17.8 ns
    1048576 :   92.7 ns          /   142.6 ns
    2097152 :  134.7 ns          /   184.3 ns
    4194304 :  155.8 ns          /   198.4 ns
    8388608 :  166.4 ns          /   203.8 ns
   16777216 :  171.6 ns          /   206.0 ns
   33554432 :  174.2 ns          /   206.9 ns
   67108864 :  175.4 ns          /   207.4 ns

>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks!

>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 37 
>> ++++++++++++++++---
>>  1 file changed, 32 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi 
>> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> index 57ac18738c99..86074d03afa9 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
>> @@ -51,49 +51,76 @@ cpu0: cpu@0 {
>>  			device_type = "cpu";
>>  			reg = <0>;
>>  			enable-method = "psci";
>> -			next-level-cache = <&L2>;
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-names = "cpu";
>>  			#cooling-cells = <2>;
>> +			i-cache-size = <0x8000>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <256>;
>> +			d-cache-size = <0x8000>;
>> +			d-cache-line-size = <64>;
>> +			d-cache-sets = <128>;
>> +			next-level-cache = <&l2_cache>;
>>  		};
>> 
>>  		cpu1: cpu@1 {
>>  			compatible = "arm,cortex-a53";
>>  			device_type = "cpu";
>>  			reg = <1>;
>>  			enable-method = "psci";
>> -			next-level-cache = <&L2>;
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-names = "cpu";
>>  			#cooling-cells = <2>;
>> +			i-cache-size = <0x8000>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <256>;
>> +			d-cache-size = <0x8000>;
>> +			d-cache-line-size = <64>;
>> +			d-cache-sets = <128>;
>> +			next-level-cache = <&l2_cache>;
>>  		};
>> 
>>  		cpu2: cpu@2 {
>>  			compatible = "arm,cortex-a53";
>>  			device_type = "cpu";
>>  			reg = <2>;
>>  			enable-method = "psci";
>> -			next-level-cache = <&L2>;
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-names = "cpu";
>>  			#cooling-cells = <2>;
>> +			i-cache-size = <0x8000>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <256>;
>> +			d-cache-size = <0x8000>;
>> +			d-cache-line-size = <64>;
>> +			d-cache-sets = <128>;
>> +			next-level-cache = <&l2_cache>;
>>  		};
>> 
>>  		cpu3: cpu@3 {
>>  			compatible = "arm,cortex-a53";
>>  			device_type = "cpu";
>>  			reg = <3>;
>>  			enable-method = "psci";
>> -			next-level-cache = <&L2>;
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-names = "cpu";
>>  			#cooling-cells = <2>;
>> +			i-cache-size = <0x8000>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <256>;
>> +			d-cache-size = <0x8000>;
>> +			d-cache-line-size = <64>;
>> +			d-cache-sets = <128>;
>> +			next-level-cache = <&l2_cache>;
>>  		};
>> 
>> -		L2: l2-cache {
>> +		l2_cache: l2-cache {
>>  			compatible = "cache";
>>  			cache-level = <2>;
>>  			cache-unified;
>> +			cache-size = <0x80000>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <512>;
>>  		};
>>  	};

