Return-Path: <linux-kernel+bounces-91189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A2D870AFF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19412865B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD9679DDC;
	Mon,  4 Mar 2024 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="oFGTEtVb"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DE91E4AA;
	Mon,  4 Mar 2024 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581887; cv=none; b=p9xZOCTFS/wggE2ou6/BYpPlTWNuE3kXYsPGJ0D/hU/MjpxDH0NNxuOR1KV96YCjFXEykykQcyuyA+1g06QOZ/pzvt3UquiIehQVyOt3lzhP9xR4qV1AJmXhyMnGe95k7NEOjaG5VnWsv4WflIa44IRDWfpStHva+II5yOgA4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581887; c=relaxed/simple;
	bh=OhgJRXuTB3k0zKcrFF9pnuEs+xWlMUxr3v8NIsiXFgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtqR/cCkMCPYO4gYYAssay66dCEoiFmSIgWcpKqqHEc+4tMAH7be6ezg3Ml5MSNaMJ1/nAmBDSR4T1Lpon7ifTZ65J7vmcczsDoDi7uDxNn4CaugUmaBjdXn7uslwdRgQbPCjr26f9+s083bWWhRu/CPBcClPe9OzoqZ1wBLp7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=oFGTEtVb; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709581874; bh=aUV7ui9OssFAkAUYQZM978SYBGiOeof7R/xUNj09ngo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oFGTEtVbNh/0r2cdHOgOXs8YzgvHRR6AtX0InqYiIjNB6x+iQ+9Ud53psrKHSpB0P
	 0W1YEXmLX1RnlfE1DOTDLPfQ19a/lKjjDFw/2fiHmVumx09z3egLMcXx01k/be7a0J
	 sWrZxr0uajJxqd+L3KEqcSgqU6BnKVc3/zuYesYE=
Received: from [IPV6:2001:da8:c800:d084:f0c8:5d03:8100:4abe] ([2001:da8:c800:d084:f0c8:5d03:8100:4abe])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id CCB30CA2; Tue, 05 Mar 2024 03:51:11 +0800
X-QQ-mid: xmsmtpt1709581871t0bl0pgus
Message-ID: <tencent_CD84A131884F52F041BBC3510D7732662705@qq.com>
X-QQ-XMAILINFO: M5g+bqkaOkZD1nVsDzmb/KiRnIRVOiuy4VyXCY3MwN6yKbdbcBhWCfQBQafO08
	 THBMK9a4n1j378qVIngxXGyXkyBcGa3If9za4BoFbgP0g4iw05d+QOlYLsSgQ5oBS7svrRwXWndt
	 6Z1vjwzbhvHkNN8b5v8Ay6p4SY3QsgqHgO7QDygd4WJLfujun7vUQdJuDxgaBvnXpt7eqW3wfIEI
	 3qVbwEgn18/la4PtbSHl8WNbONL1LpWG1pUXw8l3UfUTHnzKl1z0xzUvc/vKRbmcWstJ6h2Tsu4T
	 Dl50kGgKfiqcuP45KrN40VPFxH4du4DOJJ5FUKc8Y9jSYxDys8xtrRWZLZqebCrh2itAcK0s4z+E
	 jC3MKhvCgXilrB2Wd7HlU1CyfCALoF9Lw45DzxkyU5fV6cp8kJTbVlO3235dGnlP7LQEGOyeBv5g
	 OYfmv0DI9C7jKRWncRXY4gMFf86Hak1XsI4hPjKcp10ihoeQ0P1/iMEcgXlDKL4Ipn/c7LW518V2
	 CCk2k8RzeDbdFPr4Iukp3XIIrnqbpqgUXmKeppUp25BvyItceXfLoLu90s8vA0vf28Fy1SPyPdd6
	 g/r8UdGBhDy7eQfLUhH7JTgZcJ5+2HMEkWboaQLalwCBlTNPxgNyjUpShZVauz1Fv8LcC38gXK8h
	 EAT7YYdlqJrEethk7SG1+2WfOR9eImZKrB57WYg2+HQ2teq4dYf/1lOy8M2luMKwYIALAqfWMbDc
	 LGZFXj4Z4d8aSvMMaoqw2zJLTPNxNVJXrguxx90TLCfJ1Z76AWh9gtZRq9iYfQohuMnk9xMzz0Or
	 4nRcymljxOGp3Xf+mkf16mGULp6PGxwAxRGwbAuIwqLm4KLJtPrHfuOIjU8oiwMr1KPygl6M+ehD
	 Q3VS7nFe7YRb3cBKD6vGrFrz5Ca4HsTIdbrFv+8EqgmdD9fAbL6VZUVc/g5q+zZAJxjso4pLyFJU
	 dtcvaYMYNG988+fpLdiCTuWeiuRxg4XZRkMXNhZfCWeC6J9YlzXX+9gtUMB4YE
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-OQ-MSGID: <fe2f0f7e-f01a-4fd3-95f9-2afc807a9430@cyyself.name>
Date: Tue, 5 Mar 2024 03:51:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] riscv: dts: add initial canmv-k230 and k230-evb dts
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
 <tencent_1DB2D1914F4E30569BC4B103B724A6214405@qq.com>
 <20240304-veteran-frightful-b0700233c98f@spud>
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240304-veteran-frightful-b0700233c98f@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/5 03:00, Conor Dooley wrote:
> Hey,
> 
> Meant to reply here earlier but I got distracted.
> 
> On Sun, Mar 03, 2024 at 09:26:26PM +0800, Yangyu Chen wrote:
>> Add initial dts for CanMV-K230 and K230-EVB powered by Canaan Kendryte
>> K230 SoC [1].
>>
>> Some key considerations:
>> - Only enable BigCore which is 1.6GHz RV64GCBV
>>
>> Since is there cache coherence between two cores remains a mystery since
>> they have a dedicated L2 Cache. And the factory SDK uses it for other OS
>> by default.
>>
>> Meanwhile, although docs from Canaan said 1.6GHz Core with Vector is
>> CPU1, the csr.mhartid of this core is 0.
>>
>> - Support for "zba" "zbb" "zbc" "zbs" are tested by hand
>>
>> The user manual of C908 from T-Head does not document it specifically.
>> It just said it supports B extension V1.0-rc1. [2]
>>
>> - Support for "zicbom" is tested by hand
>>
>> Have tested with some out-of-tree drivers that need DMA and they do not
>> come to the dts currently.
>>
>> - Cache parameters are inferred from T-Head docs [2] and Cannan docs [1]
>>
>> L1i: 32KB, VIPT 4-Way set-associative, 64B Cacheline
>> L1d: 32KB, VIPT 4-Way set-associative, 64B Cacheline
>> L2: 256KB, PIPI 16-way set-associative, 64B Cacheline
>>
>> The numbers of cache sets are calculated from these parameters.
>>
>> - MMU only supports Sv39
>>
>> Since T-Head docs [2] says C908 should support sv48. However, it will fail
>> during the kernel probe. I also tested it by hand on M-Mode software,
>> writing sv48 to satp.mode will not trap but will leave the csr unchanged.
>>
>> [1] https://developer.canaan-creative.com/k230/dev/zh/00_hardware/K230_datasheet.html#chapter-1-introduction
>> [2] https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource//1699268369347/XuanTie-C908-UserManual.pdf
>>
>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>> ---
>>   arch/riscv/boot/dts/canaan/Makefile       |   2 +
>>   arch/riscv/boot/dts/canaan/canmv-k230.dts |  23 ++++
> 
> Could you name this file "k230-canmv.dts" please, so that the soc comes
> first?
> 

OK. For patch v3.

>>   arch/riscv/boot/dts/canaan/k230-evb.dts   |  23 ++++
>>   arch/riscv/boot/dts/canaan/k230.dtsi      | 146 ++++++++++++++++++++++
>>   4 files changed, 194 insertions(+)
>>   create mode 100644 arch/riscv/boot/dts/canaan/canmv-k230.dts
>>   create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
>>   create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi
>>
>> diff --git a/arch/riscv/boot/dts/canaan/Makefile b/arch/riscv/boot/dts/canaan/Makefile
>> index 987d1f0c41f0..b4a0ec668f9a 100644
>> --- a/arch/riscv/boot/dts/canaan/Makefile
>> +++ b/arch/riscv/boot/dts/canaan/Makefile
>> @@ -5,3 +5,5 @@ dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_bit.dtb
>>   dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_dock.dtb
>>   dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_go.dtb
>>   dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maixduino.dtb
>> +dtb-$(CONFIG_ARCH_CANAAN) += k230-evb.dtb
>> +dtb-$(CONFIG_ARCH_CANAAN) += canmv-k230.dtb
>> \ No newline at end of file
>> diff --git a/arch/riscv/boot/dts/canaan/canmv-k230.dts b/arch/riscv/boot/dts/canaan/canmv-k230.dts
>> new file mode 100644
>> index 000000000000..09777616d30e
>> --- /dev/null
>> +++ b/arch/riscv/boot/dts/canaan/canmv-k230.dts
>> @@ -0,0 +1,23 @@
>> +// SPDX-License-Identifier: GPL-2.0+
> 
> Is there a reason that you only put these under GPL-2.0+?
> The usual license for DT stuff is (GPL-2.0 OR BSD-2-Clause), dual
> licensing makes it easier for other projects to use the devicetrees.
> 

No. Just choose the same license from K210. I will change to both 
GPL-2.0 or BSD-2-Caluse on patchv3.

>> +
>> +		plic: interrupt-controller@f00000000 {
>> +			compatible = "thead,c900-plic";
>> +			reg = <0xf 0x00000000 0x0 0x04000000>;
>> +			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
>> +			interrupt-controller;
>> +			reg-names = "control";
>> +			#address-cells = <0>;
>> +			#interrupt-cells = <2>;
>> +			riscv,ndev = <208>;
>> +		};
>> +
>> +		clint: timer@f04000000 {
>> +			compatible = "thead,c900-clint";
>> +			reg = <0xf 0x04000000 0x0 0x04000000>;
>> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
>> +		};
> 
> Both of these should have SoC-specific compatibles. Without them, this
> should not pass dtbs_check. Did you run it?
> 

Sorry. I haven't run it before submitting patch v1. But I have run it 
and got something fixed on patchv2.

> Cheers,
> Conor.
> 

To be honest, I want some review comments on the CPU node. As we know 
K230 is a dual-core soc. But I didn't know the details of the bus, even 
for is there was cache coherence between two cores. The factory SDK also 
provides a linux dts having only one core. I don't know whether it is 
acceptable.


