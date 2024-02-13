Return-Path: <linux-kernel+bounces-63823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778268534E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B77B1C22B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4786B5EE72;
	Tue, 13 Feb 2024 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="jItxVyzT"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D235D91C;
	Tue, 13 Feb 2024 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838764; cv=none; b=TSWKOlYEFln5oVmxKZwx6z+SddFY1n1T/pCp+2gZZ2KO10EIpy3mnmTNe6m/BWpalkSgqS7JN9JHCswyKPUc2lwYHUzk4myIzjpW50ZRYuuto6Fc5FdENExv9fJei3Lr4IoWeCEbquAJh42ByZXLJ7a2At/MG1an21SZMsBG0vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838764; c=relaxed/simple;
	bh=br136el6UaDXusBTYKwUruEk6ZvTMR+slHPELf6HSJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CDYu2/q/m4KyjWkjOaZwgBzYhBQ4Q/1/poRhc0K6MYQmwKtYaMHZdZ8//kf6sxQsGuu10Fa8DtBtYB0WXVXmKq5CJYXQhUDd5fZYxeW7y/VTn9YjHL43jTJcZmGbwDc5qlBGwynjjnnnvJFsMnw+wslzT8ujUDVBuCwRQPERC1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=jItxVyzT; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DC2m9r028796;
	Tue, 13 Feb 2024 16:39:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=9YKyfytPzdwnWuIKvgHDoE69dO38fSaD90N83hiwVcw=; b=jI
	txVyzT4iT/QI9lZDzPQzOPlM7H6axH4a3UlgsEhUjNezm4hxiCVPCvtv2RgyCQpC
	b4V2NWbMLBPnrPCCWu2sQeI6/giRzxQRgVDeNJzrA/N0pxQ9Z1JmrPWVWCfUdDm4
	OWIrju+NbCqEIuRw7czgGuZkGlDNP30A8sCxhdMoEjORNVdsuE1kwM5E80q0Yked
	6yDQfEaytr2eIBU2vgv8+pYzmn4MO/fIvonHTxmlfe1lXlvYSLeHY7de0VZW/ewC
	CdvwNUmvKAErLXFp5XlKY+HpbWrPkAlMH95IVXvcBB6GeOPLfdtBsm0/SOlgw+KE
	qUllRVyutGZnC7TxtUWQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w62jsbmdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 16:39:05 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8384040046;
	Tue, 13 Feb 2024 16:39:01 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 10D4626FA0B;
	Tue, 13 Feb 2024 16:38:13 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 13 Feb
 2024 16:38:12 +0100
Received: from [10.201.20.75] (10.201.20.75) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 13 Feb
 2024 16:38:12 +0100
Message-ID: <32b5b04b-c644-43d0-b190-4200f0e92979@foss.st.com>
Date: Tue, 13 Feb 2024 16:38:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: remoteproc: Add compatibility for TEE
 support
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>
References: <20240118100433.3984196-1-arnaud.pouliquen@foss.st.com>
 <20240118100433.3984196-3-arnaud.pouliquen@foss.st.com>
 <20240130175112.GA2040002-robh@kernel.org>
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20240130175112.GA2040002-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_08,2024-02-12_03,2023-05-22_02

Hello Rob,

On 1/30/24 18:51, Rob Herring wrote:
> On Thu, Jan 18, 2024 at 11:04:31AM +0100, Arnaud Pouliquen wrote:
>> The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
>> where the Cortex-M4 firmware is loaded by the Trusted execution Environment
>> (TEE).
>> For instance, this compatible is used in both the Linux and OP-TEE
>> device-tree:
>> - In OP-TEE, a node is defined in the device tree with the
>>   st,stm32mp1-m4-tee to support signed remoteproc firmware.
>>   Based on DT properties, OP-TEE authenticates, loads, starts, and stops
>>   the firmware.
>> - On Linux, when the compatibility is set, the Cortex-M resets should not
>>   be declared in the device tree.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> V1 to V2 updates
>> - update "st,stm32mp1-m4" compatible description to generalize
>> - remove the 'reset-names' requirement in one conditional branch, as the
>>   property is already part of the condition test.
>> ---
>>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 52 +++++++++++++++----
>>  1 file changed, 43 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> index 370af61d8f28..6af821b15736 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> @@ -16,7 +16,12 @@ maintainers:
>>  
>>  properties:
>>    compatible:
>> -    const: st,stm32mp1-m4
>> +    enum:
>> +      - st,stm32mp1-m4
>> +      - st,stm32mp1-m4-tee
>> +    description:
>> +      Use "st,stm32mp1-m4" for the Cortex-M4 coprocessor management by non-secure context
>> +      Use "st,stm32mp1-m4-tee" for the Cortex-M4 coprocessor management by secure context
>>  
>>    reg:
>>      description:
>> @@ -142,21 +147,40 @@ properties:
>>  required:
>>    - compatible
>>    - reg
>> -  - resets
>>  
>>  allOf:
>>    - if:
>>        properties:
>> -        reset-names:
>> -          not:
>> -            contains:
>> -              const: hold_boot
>> +        compatible:
>> +          contains:
>> +            const: st,stm32mp1-m4
>> +    then:
>> +      if:
>> +        properties:
>> +          reset-names:
>> +            not:
>> +              contains:
>> +                const: hold_boot
> 
> Note that this is true when 'reset-names' is not present. If that is not 
> desired, then you need 'required: [reset-names]'. Not really a new issue 
> though.
> 

Yes that corresponds to my expectation, for compatibility with legacy DT.
If the hold_boot reset was not used, reset-names was not mandatory
I will add the 'required: [reset-names]' in the else

Thanks,
Arnaud

>> +      then:
>> +        required:
>> +          - st,syscfg-holdboot
>> +          - resets
>> +      else:
>> +        properties:
>> +          st,syscfg-holdboot: false
>> +        required:
>> +          - resets
> 
> 'resets' is always required within the outer 'then' schema, so you can 
> move this up a level.
> 
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: st,stm32mp1-m4-tee
>>      then:
>> -      required:
>> -        - st,syscfg-holdboot
>> -    else:
>>        properties:
>>          st,syscfg-holdboot: false
>> +        reset-names: false
>> +        resets: false
>>  
>>  additionalProperties: false
>>  
>> @@ -188,5 +212,15 @@ examples:
>>        st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
>>        st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
>>      };
>> +  - |
>> +    #include <dt-bindings/reset/stm32mp1-resets.h>
>> +    m4@10000000 {
>> +      compatible = "st,stm32mp1-m4-tee";
>> +      reg = <0x10000000 0x40000>,
>> +            <0x30000000 0x40000>,
>> +            <0x38000000 0x10000>;
>> +      st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
>> +      st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
>> +    };
>>  
>>  ...
>> -- 
>> 2.25.1
>>

