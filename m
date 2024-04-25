Return-Path: <linux-kernel+bounces-158632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1548B2342
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC901C21807
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91889149DF0;
	Thu, 25 Apr 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6TNY6uGc"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451ED5B201;
	Thu, 25 Apr 2024 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053427; cv=none; b=qjRXfLwtegVBKLBRJMkh/ICe03zyu7vuJsiwye2c+bLE73dJUZYvt9Qgh0dRBdPROSM5iu3g9/1B2hTCTjrOOUNOutsIITFWTjLXf5kY5aEDg2l93JVGv4WyLMzCsOCrjW7UASg7FbUuMcCr0atugY35x8yOsbNAinhOe/IyCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053427; c=relaxed/simple;
	bh=BNX2BmVJr83vkvYxeoCfJkJOM19LwMOcIkR56pZmKtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TEvcLJOAwwuQpvS+hmpfem9nPxREF4TV/ra/ZtnCbY7CPx9mARkvR2TCZA5/9bl5drE/C5JR57Ryn5Iqijl4QjYwZGn+eHN0Fb/ku+YLgsK++IMhVmamd6xFnsIYwBW+b70/xd81y0BsJuxKuun/ydJ51jupuq/4rECcF+lJ/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6TNY6uGc; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PCfwiL029882;
	Thu, 25 Apr 2024 15:56:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=z2KbHlfPPNmNdidIl6BW3+Ahv5hYokeRGG3kRqWEAJM=; b=6T
	NY6uGcyj6bnDhV0GfwEOIhLbK7rplt7NdBCaUYGNS2Z/BNpCOQz7zGNXThfrUfWa
	vZm18ddLvzPiodC/lT+tJIcmNIO4gVKmA4PQtjMGAPowbx9djFTPI6bDMDShco7q
	3BPIl7eK69D66Az4HQpzBbRpM6Ycv1qV/nJD5jpTf2G5tVPy4HDfDC5jAOs4HFaW
	kjVj0zis3q43Osa5qlCjj7ni0RDIM5rklYG+7rfziLrkKgG7Omt7Mr5yIAT049E6
	CCtO5EGJmwMVZoj0lhzG0Om7AQZ2u2pVOtlzQvIRfZog/57mqwD/gBQD09OF5SOA
	1ISHICeIJ7XOg8A37LBQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xmrnjbe6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 15:56:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 111DA4002D;
	Thu, 25 Apr 2024 15:56:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4557C221979;
	Thu, 25 Apr 2024 15:56:02 +0200 (CEST)
Received: from [10.48.86.112] (10.48.86.112) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 15:56:01 +0200
Message-ID: <7ce28eee-263c-4a06-85b5-5b382cbed35a@foss.st.com>
Date: Thu, 25 Apr 2024 15:55:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: regulator: st,stm32mp1-pwr-reg: add
 correct compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre TORGUE
	<alexandre.torgue@foss.st.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Pascal Paillet <p.paillet@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240425074835.760134-1-patrick.delaunay@foss.st.com>
 <20240425094829.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
 <2b78be92-08a5-4bf8-a1e1-477ecbbe73da@kernel.org>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <2b78be92-08a5-4bf8-a1e1-477ecbbe73da@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_13,2024-04-25_01,2023-05-22_02

Hi,

On 4/25/24 10:52, Krzysztof Kozlowski wrote:
> On 25/04/2024 09:48, Patrick Delaunay wrote:
>> Remove the unexpected comma in the compatible "st,stm32mp1,pwr-reg"
>> and define the new compatible "st,stm32mp1-pwr-reg".
>> The old compatible is only keep for compatibility with old device trees.
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>>
>>   .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml  | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
>> index c9586d277f41..2a52f9e769c2 100644
>> --- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
>> +++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
>> @@ -11,7 +11,9 @@ maintainers:
>>   
>>   properties:
>>     compatible:
>> -    const: st,stm32mp1,pwr-reg
>> +    enum:
>> +      - st,stm32mp1-pwr-reg
>> +      - st,stm32mp1,pwr-reg
> Please make it oneOf:
>   - const: new one
>   - const: old one
>     deprecated: true

ok, I push a V2 soon.


>
> Best regards,
> Krzysztof

Regards

Patrick


