Return-Path: <linux-kernel+bounces-40158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7066883DB62
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950031C2347F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140C1B973;
	Fri, 26 Jan 2024 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oUxtrhiv"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9781BF2C;
	Fri, 26 Jan 2024 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277557; cv=none; b=XrblSXv0BKLXjPXkdlVxOvaKl0TZY+f2lnQ9k2qzc092jIH7+lPqkaHk7JPzPBAC21LfkM95ufbJHKjWX4BihP6Csp8qOOAmHb7v+xYpi+2QmnORWFyOdKG52oTKpdsgYzBbmRbJ/2178KxEkf/aGdmGgnFwISxkXQceHJMFkWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277557; c=relaxed/simple;
	bh=pyF83y5tVfnL83cZxX2TVpeE+02/AnbnZJxbFrSpVlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VQP+1Sq70SyFpzR8BgbGlFF+9UNlpVD9u2kk63LsRJXF5j7WrKe5weVTc/7co6tuFrBZKQLoOOBpPVT4Tx8MaVqrI00isK67P5KwAby+GPOzVSFy6yfbJ0/P9DkHTMlHJaO6G6285QPOrt5dvRwK6qu8dCAUjvfgiJXg3lC44zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oUxtrhiv; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QAM0hg008172;
	Fri, 26 Jan 2024 14:59:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=DlWza8//9CYZZEeRqSDaLqxbATgDAXvWp1xCzj+RZZU=; b=oU
	xtrhivReW8tupdJ7UOkEzvmrzBPQFQe71EqRyka0OiB7Yz5BsEh8uokt99zDBqPX
	BDM6qM9OyKMNfz6ShTLBDpKIddOp8j5HDLkPk1izK7RSK9zAAHwiDgaXnSI17qvN
	4L505JAg6PYayJQjKmMh6LyW9S/9aqwXUxSwZuf+NS1IXFKM4VRAJcydiz7qFhEl
	wes1JCvYiWvNzRgcvBlyxHLnVlqBhNKoFzwyaI0pLKK2GX+cN/gPxHF560KoEnMg
	HfXfMfz//03zjBfeL5rocmw31SISD3vzGOajQJsLKVPKKrs7DJtTvSYt9NyVvFSW
	DW8DTUEdXL4PW2C1Ikvg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vtun2bxj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 14:59:02 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EEFAC10004F;
	Fri, 26 Jan 2024 14:59:01 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D627E2ABBF5;
	Fri, 26 Jan 2024 14:59:01 +0100 (CET)
Received: from [10.252.25.40] (10.252.25.40) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 26 Jan
 2024 14:59:01 +0100
Message-ID: <6e45d577-ab03-457e-ada6-1b75735d42ed@foss.st.com>
Date: Fri, 26 Jan 2024 14:59:00 +0100
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
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jens
 Wiklander <jens.wiklander@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>
References: <20240118100433.3984196-1-arnaud.pouliquen@foss.st.com>
 <20240118100433.3984196-3-arnaud.pouliquen@foss.st.com>
 <75429209-8f30-4880-8f92-ecb3cf90ae33@linaro.org>
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <75429209-8f30-4880-8f92-ecb3cf90ae33@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02

Hello Krzysztof,

On 1/26/24 12:03, Krzysztof Kozlowski wrote:
> On 18/01/2024 11:04, Arnaud Pouliquen wrote:
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
> 
> The patch looks good to me, but I wonder about this choice of two
> compatibles.
> 
> Basically this is the same hardware with the same interface, but two
> compatibles to differentiate a bit different firmware setup. We have
> already such cases for Qualcomm [1] [2] and new ones will be coming. [3]
> 
> I wonder whether this should be rather the same compatible with
> additional property, e.g. "st,tee-control" or "remote-control".

Yes the point is valid, I asked myself the question.

I proposed a compatibility solution for one main reason. On the STM32MP15, if
the firmware is loaded by Linux, no driver is probed in OP-TEE. But if the
firmware is authenticated and loaded by OP-TEE, a Op-TEE driver is probed to
manage memory access rights.

The drawback of a property is that we would need to probe the OP-TEE driver for
the STM32MP1 platform even if it is not used, just to check this property.

Thanks,
Arnaud

> 
> [1]
> https://elixir.bootlin.com/linux/v6.7.1/source/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml#L54
> 
> [2]
> https://elixir.bootlin.com/linux/v6.7.1/source/Documentation/devicetree/bindings/net/qcom,ipa.yaml#L129
> (that's a bit different)
> 
> [3] https://lore.kernel.org/linux-devicetree/20240124103623.GJ4906@thinkpad/
> 
> @Rob,
> Any general guidance for this and Qualcomm?
> 
> Best regards,
> Krzysztof
> 

