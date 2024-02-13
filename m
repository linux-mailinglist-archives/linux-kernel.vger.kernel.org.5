Return-Path: <linux-kernel+bounces-63384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D53C6852E87
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1483A1C22BED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A082C69A;
	Tue, 13 Feb 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6ZPqJa+2"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2929420;
	Tue, 13 Feb 2024 10:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821907; cv=none; b=F7amw9VqaYjy94gDARPZupX6ZDArYFcqDmu6lapl5OXSSLmaJFu8PNhW+VDhqMmU4rFb3MPDeiApK2NYkMloMFz4+4ECCZX7Hlye2Xwn/X1Yilt6vjp7Eh2uCZKt5ecmaC9NIkgW9uQtG1iYFDwo1l0n8cFrO0Ajwvqz9bLHT2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821907; c=relaxed/simple;
	bh=UgB+8ZtRhu7TUaQ2trDdQ5fupcUTGL2n5aP65YQYHrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f7INNEq5gIW2A021zmqCtLALjcdz5vh9aLiZK+ZQ4Lf810RN8/28+qoT0294kEcxZlMX40fDL2i6XcHwDtFAwTrnXRe4/HD/se3U9F7wOgWdjtuVgTmsA+XIRtwwSSBXxWtEGbpIX7F0jO/eVijBeJdvApJ4Pbpxn3xETdmziXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6ZPqJa+2; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D93h83027449;
	Tue, 13 Feb 2024 11:58:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=MqVHf3uRw4/ojVWoHbhr1qq3qDu3EwZ3KJh63HDsAkU=; b=6Z
	PqJa+2AGymrJgQ8fCMvuFWqeUM7uxZIObcC2dPqmw83Oe16PRxMNol/NFikQJl/T
	Pj1LMkx0Ne0OCsY+fogCQN62ErJjf2F4Kjwyopu4X3WLPeYOkqMETaHsU+L9CZ2q
	x6QB0dVW4VmNFcra8cyIzSHrzYcNej2Bc5wLZOONyBpsJfS39fnuDWbiWwlO0HUF
	yXnQUbYSThWkvYnF1T1ajWnEC9gFUgFzV4tAaHgiLmBy9EcsBXvB39sqeGbTOJA8
	sJ1GxyO5l69DUudnfskvhZmYHZJb0DLZGkk/0YvNVVhRb8pGfcF4vOo92BGFIiC4
	cLPSj6AcygDje5LF7xPw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w6mynfvk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:58:04 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0634C40047;
	Tue, 13 Feb 2024 11:57:59 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8704622AFEA;
	Tue, 13 Feb 2024 11:57:13 +0100 (CET)
Received: from [10.201.22.200] (10.201.22.200) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 13 Feb
 2024 11:57:12 +0100
Message-ID: <d27fb238-ec05-4a6e-95e9-c236c0d4727f@foss.st.com>
Date: Tue, 13 Feb 2024 11:56:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] dt-bindings: memory-controller: st,stm32: add MP25
 support
To: Conor Dooley <conor@kernel.org>
CC: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-2-christophe.kerello@foss.st.com>
 <20240212-dial-strangle-0b6861b35ec9@spud>
Content-Language: en-US
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <20240212-dial-strangle-0b6861b35ec9@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_05,2024-02-12_03,2023-05-22_02



On 2/12/24 19:30, Conor Dooley wrote:
> On Mon, Feb 12, 2024 at 06:48:11PM +0100, Christophe Kerello wrote:
>> Add a new compatible string to support MP25 SOC.
> 
> You're missing an explanation here as to why this mp25 is not compatible
> with the mp1.
> 
> Cheers,
> Conor.
> 

Hi Conor,

On MP1 SoC, RNB signal (NAND controller signal) and NWAIT signal (PSRAM
controler signal) have been integrated together in the SoC. That means
that the NAND controller and the PSRAM controller (if the signal is
used) can not be used at the same time. On MP25 SoC, the 2 signals can
be used outside the SoC, so there is no more restrictions.

MP1 SoC also embeds revision 1.1 of the FMC2 IP when MP25 SoC embeds 
revision 2.0 of the FMC2 IP.

I will add this explanation in the commit message.

Regards,
Christophe Kerello.

>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> ---
>>   .../bindings/memory-controllers/st,stm32-fmc2-ebi.yaml        | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml b/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
>> index 14f1833d37c9..12e6afeceffd 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
>> +++ b/Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
>> @@ -23,7 +23,9 @@ maintainers:
>>   
>>   properties:
>>     compatible:
>> -    const: st,stm32mp1-fmc2-ebi
>> +    enum:
>> +      - st,stm32mp1-fmc2-ebi
>> +      - st,stm32mp25-fmc2-ebi
>>   
>>     reg:
>>       maxItems: 1
>> -- 
>> 2.25.1
>>

