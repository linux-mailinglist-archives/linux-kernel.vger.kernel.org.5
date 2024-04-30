Return-Path: <linux-kernel+bounces-163169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D7F8B66AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AE0283D96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868A0A41;
	Tue, 30 Apr 2024 00:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="NF7MSW9M"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D1F170;
	Tue, 30 Apr 2024 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714435313; cv=none; b=OIMrhaqrAOcBWcQ9A8EwuuvNwG6WruC9MTX/vso8rXL41XaA9mQ1GqfO6hHVxzSj9Pxenp+C4fbcoNt0q/AH34tppLSSwDG1EITIFJMgdHgv8mN34xOY8bHAebyiZKVSKXtAGtqYEX4hZcHpNC2ISmzmfaQPClWVb6nE/oq7cXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714435313; c=relaxed/simple;
	bh=hyO5mxaOMy740ArG70RQJBQX5mYJSrZA65t1Uw8LE08=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dzUFdXPghSnTpM1rG+/cK+wEp16pnCCmEu6Quk68m9Jnt2KyG7Zm+PBIHrLSTXN8FB5K13aZwsmD/xtAov9ZcZ1ZajuICW7zp1n4YRMEtaO6KEbRgz/Qu0Vo72GiOqsXZLvPwGp74EVIYJAJ6acw3E94q7/bUKk2bmJg3j3/5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=NF7MSW9M; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714435302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkew1tIkLVQgYYiweS5ptVSTslJUHpeAoTydAPPtY9s=;
	b=NF7MSW9MJPxJW57lCO8ohx0ru+W6XCfWTK29Y5BJBZmMLXJjgh4lCTyR8y1+qFBgYp3L83
	Qg5VaKNSlzL2JC/8oTQXgmvDt0i62KIH+e/i5daWSiEEpUExwbiWRqI2QqtTzz/tHD5WMh
	sxF93G13H28NbVccUE7tCSkCMndFHV1nDsew94Ob4Am6Em0jhUCtZwccHWMkf8UQhF/6IM
	9ifPw/hFaZgiaVNsndwIiPMJkrqcSKpRYwT8Ajk3v0iZh3HnIwKKwXxpBwy2nrOqm3ii6g
	IbDlHD5i4Tz5ShQn9RC5PkwbTv1F1P+veox6WgB3YS5CTqXqh3vjXgK461xVpA==
Date: Tue, 30 Apr 2024 02:01:42 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev, wens@csie.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: Add cache information to the SoC
 dtsi for H6
In-Reply-To: <20240430001002.4797e4e3@minigeek.lan>
References: <6a772756c2c677dbdaaab4a2c71a358d8e4b27e9.1714304058.git.dsimic@manjaro.org>
 <49abb93000078c692c48c0a65ff677893909361a.1714304071.git.dsimic@manjaro.org>
 <20240430001002.4797e4e3@minigeek.lan>
Message-ID: <6fdeb49d57ccccca62e4f43dbe9475e3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andre,

On 2024-04-30 01:10, Andre Przywara wrote:
> On Sun, 28 Apr 2024 13:40:36 +0200
> Dragan Simic <dsimic@manjaro.org> wrote:
> 
>> Add missing cache information to the Allwinner H6 SoC dtsi, to allow
>> the userspace, which includes lscpu(1) that uses the virtual files 
>> provided
>> by the kernel under the /sys/devices/system/cpu directory, to display 
>> the
>> proper H6 cache information.
>> 
>> Adding the cache information to the H6 SoC dtsi also makes the 
>> following
>> warning message in the kernel log go away:
>> 
>>   cacheinfo: Unable to detect cache hierarchy for CPU 0
>> 
>> The cache parameters for the H6 dtsi were obtained and partially 
>> derived
>> by hand from the cache size and layout specifications found in the 
>> following
>> datasheets and technical reference manuals:
>> 
>>   - Allwinner H6 V200 datasheet, version 1.1
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
>> 
>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> 
> I can confirm that the data below matches the manuals, but also the
> decoding of the architectural cache type registers (CCSIDR_EL1):
>   L1D: 32 KB: 128 sets, 4 way associative, 64 bytes/line
>   L1I: 32 KB: 256 sets, 2 way associative, 64 bytes/line
>   L2: 512 KB: 512 sets, 16 way associative, 64 bytes/line

Thank you very much for reviewing my patch in such a detailed way!
It's good to know that the values in the Allwinner datasheets match
with the observed reality, so to speak. :)

> tinymembench results for the H6 are available here:
> https://github.com/ThomasKaiser/sbc-bench/blob/master/results/26Ph.txt
> and confirm the theory. Also ran it locally with similar results.

Here's a quick copy & paste of the most important benchmark results
from the link above, as a quick reference for anyone reading this
thread in the future, or as a data source in case the link above
becomes inaccessible at some point in the future:

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
      65536 :    3.8 ns          /     6.5 ns
     131072 :    5.8 ns          /     9.1 ns
     262144 :    6.9 ns          /    10.2 ns
     524288 :    7.8 ns          /    11.2 ns
    1048576 :   74.3 ns          /   114.5 ns
    2097152 :  110.5 ns          /   148.1 ns
    4194304 :  132.6 ns          /   164.5 ns
    8388608 :  144.0 ns          /   172.3 ns
   16777216 :  151.5 ns          /   177.3 ns
   33554432 :  156.3 ns          /   180.7 ns
   67108864 :  158.7 ns          /   182.9 ns

block size : single random read / dual random read, [MADV_HUGEPAGE]
       1024 :    0.0 ns          /     0.0 ns
       2048 :    0.0 ns          /     0.0 ns
       4096 :    0.0 ns          /     0.0 ns
       8192 :    0.0 ns          /     0.0 ns
      16384 :    0.0 ns          /     0.0 ns
      32768 :    0.0 ns          /     0.0 ns
      65536 :    3.8 ns          /     6.5 ns
     131072 :    5.8 ns          /     9.1 ns
     262144 :    6.9 ns          /    10.2 ns
     524288 :    7.8 ns          /    11.2 ns
    1048576 :   74.3 ns          /   114.5 ns
    2097152 :  110.0 ns          /   147.5 ns
    4194304 :  127.6 ns          /   158.3 ns
    8388608 :  136.4 ns          /   162.2 ns
   16777216 :  141.2 ns          /   165.6 ns
   33554432 :  143.7 ns          /   168.4 ns
   67108864 :  144.9 ns          /   168.9 ns

> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks!

>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 37 
>> ++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi 
>> b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> index d11e5041bae9..1a63066396e8 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> @@ -29,36 +29,73 @@ cpu0: cpu@0 {
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-latency-ns = <244144>; /* 8 32k periods */
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
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-latency-ns = <244144>; /* 8 32k periods */
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
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-latency-ns = <244144>; /* 8 32k periods */
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
>>  			clocks = <&ccu CLK_CPUX>;
>>  			clock-latency-ns = <244144>; /* 8 32k periods */
>>  			#cooling-cells = <2>;
>> +			i-cache-size = <0x8000>;
>> +			i-cache-line-size = <64>;
>> +			i-cache-sets = <256>;
>> +			d-cache-size = <0x8000>;
>> +			d-cache-line-size = <64>;
>> +			d-cache-sets = <128>;
>> +			next-level-cache = <&l2_cache>;
>> +		};
>> +
>> +		l2_cache: l2-cache {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-unified;
>> +			cache-size = <0x80000>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <512>;
>>  		};
>>  	};

