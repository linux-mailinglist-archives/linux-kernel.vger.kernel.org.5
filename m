Return-Path: <linux-kernel+bounces-78449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B378613AB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1BE51F22E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E268063A;
	Fri, 23 Feb 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="pCt+DOqE"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749937FBD7;
	Fri, 23 Feb 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697490; cv=none; b=WIgD21VCmEFguy8hPY2zd6obNV72mV4hK46JuytjXNnIBGRUnOu1SomYSpenOPHL8nRqQilhSkCR5x2wcjWG/087r8vFKDMTmDWn1w1QPFjXJULxc2C+7Q/fQ8m5g0h9cyKnDnoGGaj5toPmLec0X0INShM33VSrGOlXQljQzlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697490; c=relaxed/simple;
	bh=lrm5L7yNNJvaTYZvuDy4wqTrXSwaAHUq7sLAbGr3+9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K0AxdcJUm7+AWTSh8Pk2GWgH50KrAj7Phjjwa8siNZJAb/+PIJdKlsoRf6jSaG3OgVWNXtbMcuSh2fmio4FFcfwkmDYl7kdmAYPFuMhIwgJjHouzv0FgQqi5c1SrOkKrpZ7Ar9M443340IQ9lWia117Ibysg3HJvpMqfphBxs0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=pCt+DOqE; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N8C67k012818;
	Fri, 23 Feb 2024 15:11:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=BtiOK7zNGmf7T/HNpNbS7LRFrHlD65J1Nz54bRzladI=; b=pC
	t+DOqE5VNZYO1AF14Au2IruOE4S9FDoF3BkLNh6k7+/2X+Bh3XFjyzpTbA0vfw14
	ifnMSoqHxO1FGhffD86z63Plq+2shAbSKNSowLIt6Qbpka9JNoTzso30Z6SfpUi4
	qXaMFYNisKMw26zDwOwgHrfFmPvcNFwIPzLNocjYeGP+H+qlc3XzQ6iDLkaQKzs7
	sy8cykZ2WEd3fv2IZA3DPogrIZCRZFyD4/L3hhXmhDNFpKLxiQ0hvF5e84TiuMyW
	mpKsALRzc1TtPDGwScf8zSk82JETDKV2i8kdg2P/rD00vgSAQtNRN9IoifuF9bUC
	GnUqi1WSAfTz2AZFYpTA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3weqn41faw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:11:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 464FF4002D;
	Fri, 23 Feb 2024 15:10:59 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D0DB42A14CB;
	Fri, 23 Feb 2024 15:10:05 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 23 Feb
 2024 15:10:05 +0100
Received: from [10.252.31.57] (10.252.31.57) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 23 Feb
 2024 15:10:04 +0100
Message-ID: <c80d0ca1-1ae3-4af3-ba84-6dc5efaff1c7@foss.st.com>
Date: Fri, 23 Feb 2024 15:10:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Introduction of a remoteproc tee to load signed
 firmware
Content-Language: en-US
To: Naman Jain <quic_namajain@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Jens
 Wiklander" <jens.wiklander@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>
References: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
 <fe4ec29f-7521-4369-a382-bae50dbf0ee5@quicinc.com>
 <adcf0c0d-f452-4285-8651-c147fcca001b@foss.st.com>
 <8af59b01-53cf-4fc4-9946-6c630fb7b38e@quicinc.com>
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <8af59b01-53cf-4fc4-9946-6c630fb7b38e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02



On 2/22/24 10:55, Naman Jain wrote:
> On 2/22/2024 2:17 PM, Arnaud POULIQUEN wrote:
>> Hello Naman,
>>
>> On 2/22/24 06:43, Naman Jain wrote:
>>> On 2/14/2024 10:51 PM, Arnaud Pouliquen wrote:
>>>> Updates from the previous version [1]:
>>>>
>>>> This version proposes another approach based on an alternate load and boot
>>>> of the coprocessor. Therefore, the constraint introduced by tee_remoteproc
>>>> is that the firmware has to be authenticated and loaded before the resource
>>>> table can be obtained.
>>>>
>>>> The existing boot sequence is: >
>>>>     1) Get the resource table and store it in a cache,
>>>>        calling rproc->ops->parse_fw().
>>>>     2) Parse the resource table and handle resources,
>>>>        calling rproc_handle_resources.
>>>>     3) Load the firmware, calling rproc->ops->load().
>>>>     4) Start the firmware, calling rproc->ops->start().
>>>>    => Steps 1 and 2 are executed in rproc_fw_boot(), while steps 3 and 4 are
>>>>      executed in rproc_start().
>>>> => the use of rproc->ops->load() ops is mandatory
>>>>
>>>> The boot sequence needed for TEE boot is:
>>>>
>>>>     1) Load the firmware.
>>>>     2) Get the loaded resource, no cache.
>>>>     3) Parse the resource table and handle resources.
>>>>     4) Start the firmware.
>>>
>>> Hi,
>>> What problem are we really addressing here by reordering load, parse of
>>> FW resources?
>>
>> The feature introduced in TEE is the signature of the firmware images. That
>> means that before getting the resource table, we need to first authenticate the
>> firmware images.
>> Authenticating a firmware image means that we have to copy the firmware into
>> protected memory that cannot be corrupted by the non-secure and then verify the
>> signature.
>> The strategy implemented in OP-TEE is to load the firmware into destination
>> memory and then authenticate it.
>> This strategy avoids having a temporary copy of the whole images in a secure
>> memory.
>> This strategy imposes loading the firmware images before retrieving the resource
>> table.
>>
>>> Basically, what are the limitations of the current design you are referring to?
>>> I understood that TEE is designed that way.
>>
>> The limitation of the current design is that we obtain the resource table before
>> loading the firmware. Following the current design would impose constraints in
>> TEE that are not straightforward. Step 1 (getting the resource table and storing
>> it in a cache) would require having a copy of the resource table in TEE after
>> authenticating the images. However, authenticating the firmware, as explained
>> before, depends on the strategy implemented. In TEE implementation, we load the
>> firmware to authenticate it in the destination memory.
>>
>> Regards,
>> Arnaud
> 
> 
> Hello Arnaud,
> I think now I got your point. In TEE, you don't want to do anything(read
> resource table) with FW images, until its loaded and authenticated.
> Since current design was not allowing you to do it, you had to reorganize the
> code so that this can be achieved.
> 
> Generally speaking, in current design, if authentication fails for some
> reason later, one can handle it, but it depends on the implementation of
> parse_fw op if the damage is already done.
> 
> Please correct me if this is wrong assumption.

That's correct.

Regards,
Arnaud

> Patch looks good to me.
> 
> Regards,
> Naman Jain

