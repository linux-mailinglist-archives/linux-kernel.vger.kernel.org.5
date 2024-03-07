Return-Path: <linux-kernel+bounces-95018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23721874839
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7627BB213D0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9801CD09;
	Thu,  7 Mar 2024 06:34:05 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4726DDC9;
	Thu,  7 Mar 2024 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709793245; cv=none; b=W4co+dC4+JmEHlHeatDlnIecA7TAOKNGkhZfgjoRkqZVutAY6XvamqZhuItGcYLf47B47KOU/B9nQGXNvl+OB2m2aQulAlSuR1CrStXBswEO+XPO+pv11LFG1u1PPHyStAblqyMAhDKyD8YaHTPrGm3Cr++DMgIVoPNV+zhZYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709793245; c=relaxed/simple;
	bh=oFK8GPKzEFobqtEf4MAuTP757DML8r6JRq7tpUItZ8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jd6CkVggCnHcyS9TylaplKqBmzuqtJfvnDpgem8/gCzS13+0q/TUgkB4XESxEJl8TkccS5+iUOjqr02c7El3l5aMJ1AyxlUdpo+R6vfKbr97ClOpv2RaYHQmtoLK5YVwkLIMGoCxRO7w7rBbVXg1BFPWU7s2XGFRfVd84+oRkKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp85t1709793182tujdeesz
X-QQ-Originating-IP: AI4d7leqGTROiTbd83gq6iTXH3y2/ecS+TzgiSBY+Eo=
Received: from [127.0.0.1] ( [223.112.234.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Mar 2024 14:33:00 +0800 (CST)
X-QQ-SSF: 00400000000000B0B000000A0000000
X-QQ-FEAT: C46Rb8GPIEcRpnFVLA74bpmpIbS/J/k/EPLIGHxpBmuaZe2xrro+ZMxlF+a/x
	gmUkTfrmuJbXZ1XUoMuEPjPJQ18W1FduaoOSqaOEes4TBhwj/+1cTzm0CHqFNbUXsJUxlY/
	f38OvExuYimS/PEPmXAHaho4FEn5BxEyXzkfGA4+zpD8B2HI/1wG7Oh7+Km+fkjHicjQNb3
	JPlmK6zNtXXUn+F6GQ95MMgLWG0c/X6zdQ4oh/F1n457t21FqvWi4rFaImJYQUjBU1mgySo
	8XpK2gauQNs/b37wKyvuOqPOlzs1174m76Mhz33s430X6YK0ZZEuWypp3LbfcyyBljOAt9h
	0bvACCw8drK2Kkrml+KJ9//TRmQA9Tdr0jzsUo33xyU9dscp/7+UH8FmrUm9da/iwmGjwEi
	iYLzZR8YZ6f2tl2thxTDQg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17887917072289545076
Message-ID: <09CB11C098C9BD27+6a0b4632-9886-4677-9e16-671ef457ee4f@shingroup.cn>
Date: Thu, 7 Mar 2024 14:33:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: perf: Support uncore NI-700 PMU
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, shenghui.qu@shingroup.cn,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1709694173.git.jialong.yang@shingroup.cn>
 <f674ec19ce824dfc13258396931256c3d33cd207.1709694173.git.jialong.yang@shingroup.cn>
 <7f2576291e51043b33296a2cd9e21263d16ca077.1709694173.git.jialong.yang@shingroup.cn>
 <20240306214613.GA716904-robh@kernel.org>
From: =?UTF-8?B?WWFuZyBKaWFsb25nIOadqOS9s+m+mQ==?= <jialong.yang@shingroup.cn>
In-Reply-To: <20240306214613.GA716904-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz6a-1



在 2024/3/7 5:46, Rob Herring 写道:
> On Wed, Mar 06, 2024 at 02:16:02PM +0800, JiaLong.Yang wrote:
>> Add file corresponding to hx_arm_ni.c introducing ARM NI-700 PMU
>> driver for HX.
>>
>> Signed-off-by: JiaLong.Yang <jialong.yang@shingroup.cn>
>> ---
>> v1 --> v2:
>> 1. Submit dt-bindings file Seperately.
>> 2. Do some check:
>>     ~ #: make dt_binding_check DT_SCHEMA_FILES=perf
>>     LINT    Documentation/devicetree/bindings
>>     CHKDT   Documentation/devicetree/bindings/processed-schema.json
>>     SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>>     DTEX    Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.example.dts
>>     DTC_CHK Documentation/devicetree/bindings/perf/hx,c2000-arm-ni.example.dtb
>>
>> v2 --> v3:
>> 1. Change vendor from hx to hexin.
>> 2. Submit driver and dt-bindings files together.
>> 3. Delete pccs-id property. Use alias-id to do this.
>> 4. There are at least one interrupt line for the hardware and driver
>>     for handling counter overflow.
>> 5. Use 4 spaces for example indentation in yaml file.
>>
>>   .../bindings/perf/hexin,c2000-arm-ni.yaml     | 51 +++++++++++++++++++
>>   MAINTAINERS                                   |  6 +++
>>   2 files changed, 57 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/perf/hexin,c2000-arm-ni.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/perf/hexin,c2000-arm-ni.yaml b/Documentation/devicetree/bindings/perf/hexin,c2000-arm-ni.yaml
>> new file mode 100644
>> index 000000000000..b2641ee84d60
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/perf/hexin,c2000-arm-ni.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/perf/hexin,c2000-arm-ni.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: HX-C2000 NI (Network-on-chip Interconnect) Performance Monitors
>> +
>> +maintainers:
>> +  - Jialong Yang <jialong.yang@shingroup.cn>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - hexin,c2000-arm-ni
> 
> As this seems to be Arm IP, I'd expect arm,ni-700-pmu or something.
> 
> Are there Hexin modifications to it?

Maybe only the employee of Hexin wrote it and it was written for a 
product named c2000... But in hardware layer, there is almost no difference.
Chould below?
enum:
	- hexin,c2000-ni-pmu
	- arm,ni-700-pmu

> 
>> +
>> +  reg:
>> +    items:
>> +      - description: Physical address of the base (PERIPHBASE) and
>> +          size of the whole NI configuration address space.
> 
> Just 'maxItems: 1' if there is only 1 entry.

OK.

> 
>> +
>> +  interrupts:
>> +    minItems: 1
>> +    items:
>> +      - description: Overflow interrupt for clock domain 0
>> +      - description: Overflow interrupt for clock domain 1
>> +      - description: Overflow interrupt for clock domain 2
>> +      - description: Generally, one interrupt line for one PMU. But this also
>> +          support one interrupt line for a NI if merged.
> 
> I don't understand this last entry.

Specially, one NI could have many PMUs with many interupt numbers.
The last entry means that the driver supports merging interrupts into 
one if hardware layer merged them.

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    aliases {
>> +        ni-pmu0 = &nipmu0;
> 
> Drop. Please don't make up your own alias names.

Here I need a index to differ more than one NI node. Last version I used 
a custom property. Krzysztof Kozlowski advised me to use IDR, DT
aliases or something else.
Here I can use which one?...
It's my fault to forget writing the change in changelog.

> 
>> +    };
>> +
>> +    nipmu0: pmu@23ff0000 {
>> +        compatible = "hexin,c2000-arm-ni";
>> +        reg = <0x2b420000 0x10000>;
>> +        interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4f298c4187fb..4b664cec98a7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18890,6 +18890,12 @@ L:	linux-riscv@lists.infradead.org
>>   S:	Maintained
>>   F:	arch/riscv/boot/dts/thead/
>>   
>> +HX ARM-NI-700 PMU DRIVERS
>> +M:	Jialong Yang <jialong.yang@shingroup.cn>
>> +S:	Supported
>> +F:	Documentation/devicetree/bindings/perf/hexin,c2000-arm-ni.yaml
>> +F:	drivers/perf/hx_arm_ni.c
>> +
>>   RNBD BLOCK DRIVERS
>>   M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
>>   M:	Jack Wang <jinpu.wang@ionos.com>
>> -- 
>> 2.25.1
>>
> 


