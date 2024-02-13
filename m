Return-Path: <linux-kernel+bounces-63385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4A2852E89
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7001F217BA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468D5364C5;
	Tue, 13 Feb 2024 10:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="4lKeigsm"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2A2BB09;
	Tue, 13 Feb 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821908; cv=none; b=sq/heuUtQ6cWzrr4ktrTK5LYGujSV7szUH6KpFOQE16uZELiwKx6nS8YLogPoC7u5+sZvskIgj+WP7HpUawGFEDmLmhHIiToyibyfYB6WC03oAedMnIg6uPfAJN/Q8AhDqR6f2Qhcz10dM0uWVmBUzpAjdEiG6l54ZNeTfxX3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821908; c=relaxed/simple;
	bh=0WirMBbWssbyY1Zxpsq0pBMfD2qxvM/rMR6Y+Q2bQyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZoiJWiidTOjUH+NcYPKDntkOjasASNO+yWhFic1DEVtAv0SlryuVah2i3TAWqUh/NQJRaCJD5bfSt4qJyuB4clPxP3DjGoA35Oh1hfTzhml1K+tIi1OVxlZVI4HppS+Cwrg54vCTtOZ6LJKYrPz4INZ+uAzX/BkX8Te1Y3dTzPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=4lKeigsm; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DA9Si1026396;
	Tue, 13 Feb 2024 11:58:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=1J5ztYg9uk0Ni/zb1+iLOfL8R7ELBVGeERYFdVqxo4k=; b=4l
	KeigsmJRyRSZpDB1GGpZeGwsU+pxVgR5svCf0mUhv4HRWOKBopyE/cjDw8pfG5MY
	1X/2MSOr7n3mRjNQ4NCjlj0G24eGjJ2rCmnGP94JlQYEtqJmvPV472r8hkSgONFp
	sOo1C7E6uory1zMAPzC6LkjgG/RvRdi6CwwfAMBRhwfyxj3HiY+yDWtvpexGvAst
	NNhTjTGSq/P52etuCNGLWx27555zq/dpT4S5P07XC7thxZfm2zHYxq+ztRFYnQk8
	MZn4FFIxbLMYVjkziRIhgZHwuJPJ9Im66MWQugZk92r3V8+t+R2esBoS7GlcRCz/
	RykY3g4r9eUJq1U4xnIA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w6kk4r3h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:58:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5C7D140049;
	Tue, 13 Feb 2024 11:58:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E12A22D19E;
	Tue, 13 Feb 2024 11:57:28 +0100 (CET)
Received: from [10.201.22.200] (10.201.22.200) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 13 Feb
 2024 11:57:27 +0100
Message-ID: <4ec4a926-fd1c-44e7-990b-4af0e09b9224@foss.st.com>
Date: Tue, 13 Feb 2024 11:57:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] dt-bindings: mtd: st,stm32: add MP25 support
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
CC: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-9-christophe.kerello@foss.st.com>
 <20240212-squeak-mortality-5a53a4d1039c@spud>
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <20240212-squeak-mortality-5a53a4d1039c@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_05,2024-02-12_03,2023-05-22_02



On 2/12/24 19:38, Conor Dooley wrote:
> On Mon, Feb 12, 2024 at 06:48:18PM +0100, Christophe Kerello wrote:
>> Add 2 new compatible strings to support MP25 SOC.
>> MP25 SOC supports up to 4 chip select.
> 
> Again, please explain why the new device is not compatible with the
> existing ones. Also, please explain why two compatibles are required for
> the mp25.
> 

Hi Conor,

FMC2 IP supports up to 4 chip select. On MP1 SoC, only 2 of them are 
available when on MP25 SoC, the 4 chip select are available.

MP1 SoC also embeds revision 1.1 of the FMC2 IP when MP25 SoC embeds 
revision 2.0 of the FMC2 IP.

I will add this explanation in the commit message.

Regards,
Christophe Kerello.

> Thanks,
> Conor.
> 
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> ---
>>   .../bindings/mtd/st,stm32-fmc2-nand.yaml      | 58 ++++++++++++++++++-
>>   1 file changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
>> index e72cb5bacaf0..33a753c8877b 100644
>> --- a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
>> @@ -14,10 +14,12 @@ properties:
>>       enum:
>>         - st,stm32mp15-fmc2
>>         - st,stm32mp1-fmc2-nfc
>> +      - st,stm32mp25-fmc2
>> +      - st,stm32mp25-fmc2-nfc
>>   
>>     reg:
>>       minItems: 6
>> -    maxItems: 7
>> +    maxItems: 13
>>   
>>     interrupts:
>>       maxItems: 1
>> @@ -92,6 +94,60 @@ allOf:
>>               - description: Chip select 1 command
>>               - description: Chip select 1 address space
>>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: st,stm32mp25-fmc2
>> +    then:
>> +      properties:
>> +        reg:
>> +          items:
>> +            - description: Registers
>> +            - description: Chip select 0 data
>> +            - description: Chip select 0 command
>> +            - description: Chip select 0 address space
>> +            - description: Chip select 1 data
>> +            - description: Chip select 1 command
>> +            - description: Chip select 1 address space
>> +            - description: Chip select 2 data
>> +            - description: Chip select 2 command
>> +            - description: Chip select 2 address space
>> +            - description: Chip select 3 data
>> +            - description: Chip select 3 command
>> +            - description: Chip select 3 address space
>> +
>> +        clocks:
>> +          maxItems: 1
>> +
>> +        resets:
>> +          maxItems: 1
>> +
>> +      required:
>> +        - clocks
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: st,stm32mp25-fmc2-nfc
>> +    then:
>> +      properties:
>> +        reg:
>> +          items:
>> +            - description: Chip select 0 data
>> +            - description: Chip select 0 command
>> +            - description: Chip select 0 address space
>> +            - description: Chip select 1 data
>> +            - description: Chip select 1 command
>> +            - description: Chip select 1 address space
>> +            - description: Chip select 2 data
>> +            - description: Chip select 2 command
>> +            - description: Chip select 2 address space
>> +            - description: Chip select 3 data
>> +            - description: Chip select 3 command
>> +            - description: Chip select 3 address space
>> +
>>   required:
>>     - compatible
>>     - reg
>> -- 
>> 2.25.1
>>

