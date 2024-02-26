Return-Path: <linux-kernel+bounces-80753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1869F866C14
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E96E1C21364
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2558A1CA9C;
	Mon, 26 Feb 2024 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="rem6OKKw"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF41CA87;
	Mon, 26 Feb 2024 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935964; cv=none; b=jbRs3Hn7Dz+eaqIUHgJizVclMS5RlAu9QGk1HNrAt0zDP8VzI69xJPzG+bUHnD1UlHxZIYV4978H1RMw/2t+tam1ZLScfA4zJFEbTB4zYTnEPtmR8CJ2Dw/byHlt5NHctR7LALXHkjnyL+1BEgj3DzY7x+89aCW34VsfHPbrYWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935964; c=relaxed/simple;
	bh=I+M+uyV5FpwwpkemvG8PFA89tmGoOFufVYcPptG81kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cXMqESCL9C81oPg5yhs+FYE6eEa5jU88kbYYncDkj2IlI7ih7R7zs5gXwFZWMIn59fwM4Lf9EX5XLgQS6pRt57JvNdsAkN+pXBx5VWgwXjTXe+t22hZhJvnDc4Vnb/AiAXqrmXzy0pkr0d7VHSfHob3UM67Z9fZVElaqrtrx0CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=rem6OKKw; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q3T6cD001925;
	Mon, 26 Feb 2024 09:25:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=ipjqMNVCa6S6fgiDE7vR21a99GdkTx/G11g4uP/BcWo=; b=re
	m6OKKwNwvCp2pW4u/6mMlfjuS8RNmSFjVPAmlz2bPp9F+JqJox3Hc/SBI2Q5yadI
	dGPwtVG/NEKZEs3agmVqVQ5BcX2oxwPMMkbh65QGAV4GlAyHist0zk+J59ucHGin
	FmAFH6qAfwOzUf2ONh9hKbTwgE0qMQbNSzWuCL1QAlBJ6OaWCzZMcyc9x3BQAkii
	+3+u4SVAdfy1xN413PoKsb3nvp+/sAmqIg415Wk/Dx6UPvlzlgelKuOlxI9tweoL
	UBeFFz/9GKvnTn6kU8fqc9Dg6w1Juv2LbZfBxpfKbUs3nfY1pmg2NT9YMF2q6rYa
	dQETh34CLS96SptsmWZA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wf6rke8dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 09:25:42 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 492164002D;
	Mon, 26 Feb 2024 09:25:38 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C3E12243FD1;
	Mon, 26 Feb 2024 09:25:07 +0100 (CET)
Received: from [10.201.21.177] (10.201.21.177) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 26 Feb
 2024 09:25:07 +0100
Message-ID: <9859023c-57bf-4316-911c-c5f5ade1ebb4@foss.st.com>
Date: Mon, 26 Feb 2024 09:25:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] memory: stm32-fmc2-ebi: check regmap_read return
 value
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20240219140202.85680-1-christophe.kerello@foss.st.com>
 <20240219140202.85680-3-christophe.kerello@foss.st.com>
 <1c4ab974-2b72-45ce-ab20-de158b91e356@linaro.org>
Content-Language: en-US
From: Christophe Kerello <christophe.kerello@foss.st.com>
In-Reply-To: <1c4ab974-2b72-45ce-ab20-de158b91e356@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_05,2024-02-23_01,2023-05-22_02

Hi Krzysztof,

On 2/21/24 09:29, Krzysztof Kozlowski wrote:
> On 19/02/2024 15:01, Christophe Kerello wrote:
>> Check regmap_read return value to avoid to use uninitialized local
>> variables.
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
>> ---
>> Changes in v2:
>>   - New patch added
>>
>>   drivers/memory/stm32-fmc2-ebi.c | 128 +++++++++++++++++++++++---------
>>   1 file changed, 94 insertions(+), 34 deletions(-)
>>
> 
> ...
> 
>> -static void stm32_fmc2_ebi_save_setup(struct stm32_fmc2_ebi *ebi)
>> +static int stm32_fmc2_ebi_save_setup(struct stm32_fmc2_ebi *ebi)
>>   {
>>   	unsigned int cs;
>> +	int ret;
>>   
>>   	for (cs = 0; cs < FMC2_MAX_EBI_CE; cs++) {
>> -		regmap_read(ebi->regmap, FMC2_BCR(cs), &ebi->bcr[cs]);
>> -		regmap_read(ebi->regmap, FMC2_BTR(cs), &ebi->btr[cs]);
>> -		regmap_read(ebi->regmap, FMC2_BWTR(cs), &ebi->bwtr[cs]);
>> +		ret = regmap_read(ebi->regmap, FMC2_BCR(cs), &ebi->bcr[cs]);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = regmap_read(ebi->regmap, FMC2_BTR(cs), &ebi->btr[cs]);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret = regmap_read(ebi->regmap, FMC2_BWTR(cs), &ebi->bwtr[cs]);
>> +		if (ret)
>> +			return ret;
> 
> These are just:
> 
> ret |= regmapr_read()
> and one "if (ret)" clause.
> 

Ok, it will be done in V3.

Regards,
Christophe Kerello.

> 
> 
> Best regards,
> Krzysztof
> 

