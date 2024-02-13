Return-Path: <linux-kernel+bounces-63595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 649158531FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059F7B268DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A2056449;
	Tue, 13 Feb 2024 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="zduP417c"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C456740;
	Tue, 13 Feb 2024 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707831148; cv=none; b=sjoziyySf/LkYS4rakTC7ywtYrlBQvVYxiJhUTJV+AqHWmGuYNUUiQC/XCxJ+/dQsB6HDs8fT2DYQRmnIRG6R8o3SSMtQFCZSTcspwtQ3/zGwgmUb51KH9vM31sHfoH/TRdNKLSNkxE/fLsr9EgjOx5NDDLvoK6yXeP5gd6LM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707831148; c=relaxed/simple;
	bh=XGf+6GSE1aTEFLzYyfaXBhpbaZBwxkfHTNrFHlLjxmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=axmXF69Er8vpHYK+tv6H1X0M+KZGQNeTGn99CM36eZT+RbCu872RuvEOavsGTl5J7xvRVxdUZxQ50T6NXd23mR5HIlM8j/38a4cpRv3CgJEgyIexQhayY4usqX6jgj8JtTBx7TZW5ASZtb9tdEhUYXehE0SXp8liwGT66an+ggE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=zduP417c; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DCB8wv021006;
	Tue, 13 Feb 2024 14:32:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=34e9c7UGprBPKQ0+1IALD+tum6v0BgoVmf0mxf39HAE=; b=zd
	uP417cKD+QCfrJIkj2xjU71gUsE+mehTeZLO0zW/cWOd2vg38YC6jS1TYQPIXPPl
	Jg+aZFFkZ+WXIiIDnL99vuYDMktpeWeVTwVdXj0CoRZ/zdp1IvZymrT4NLwRp8CO
	fXnrSzEwejIG+FdZeLIAzvRcKw0ZdYfyG6V6auRh00T1JlXCJUZEdWc/Ieo/WhEI
	iRLYIVtlkvQOKtdz+lsPdY6gf56JzAQx/xpTRxjahcQfB1++RpLJn21j2t44Xjj0
	Yc/nbvHVT/5kzjtTkAR4Mg5Um1QNAnv3vWvQKSphNOpGtXQZaMEof6UwWya7VG6p
	AjcOr02kfxoTWJ+04asw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w62ktjwbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 14:32:10 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D4E3A40044;
	Tue, 13 Feb 2024 14:32:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 315FC257ABA;
	Tue, 13 Feb 2024 14:31:24 +0100 (CET)
Received: from [10.201.22.200] (10.201.22.200) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 13 Feb
 2024 14:31:23 +0100
Message-ID: <ebd4b93a-80c5-4f22-974b-eb91e896e510@foss.st.com>
Date: Tue, 13 Feb 2024 14:31:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] memory: stm32-fmc2-ebi: add runtime PM support
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-8-christophe.kerello@foss.st.com>
 <7cb51fed-66fc-4ab1-be09-85a00d94514b@linaro.org>
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <7cb51fed-66fc-4ab1-be09-85a00d94514b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_07,2024-02-12_03,2023-05-22_02



On 2/13/24 08:59, Krzysztof Kozlowski wrote:
> On 12/02/2024 18:48, Christophe Kerello wrote:
>> Add runtime PM support in FMC2 ebi driver to be able to manage GENPD
>> support when it will be enabled.
> 

Hi Krzysztof,

> You don't do any real runtime PM here (turning on PM domain on probe is
> not real PM), so please explain what is the goal of it and say that it
> is basic RPM for keeping domain on.
> 

Yes, you are true, I will modify the commit message.

>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> ---
>>   drivers/memory/stm32-fmc2-ebi.c | 40 ++++++++++++++++++++++++++-------
>>   1 file changed, 32 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
>> index 04248c15832f..8c30e56be3b0 100644
>> --- a/drivers/memory/stm32-fmc2-ebi.c
>> +++ b/drivers/memory/stm32-fmc2-ebi.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/of_platform.h>
>>   #include <linux/pinctrl/consumer.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>   #include <linux/regmap.h>
>>   #include <linux/reset.h>
>>   
>> @@ -1381,6 +1382,7 @@ static int stm32_fmc2_ebi_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   
>>   	ebi->dev = dev;
>> +	platform_set_drvdata(pdev, ebi);
> 
> Does not look related.
> 

With pm_runtime_resume_and_get API now called, 
stm32_fmc2_ebi_runtime_resume needs ebi data to enable the clock. It
means that the platform data has to be set before this call.

Regards,
Christophe Kerello.

> 
> Best regards,
> Krzysztof
> 

