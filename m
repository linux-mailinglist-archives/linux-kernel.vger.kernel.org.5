Return-Path: <linux-kernel+bounces-76142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B3C85F36B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E30DBB22ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0932C689;
	Thu, 22 Feb 2024 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1C4BRdbL"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA724A04;
	Thu, 22 Feb 2024 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591733; cv=none; b=evayYu6qs22YM7P2LDk9PCvru1KSWjjZeDSJswcXAhc4WqVZ4hRZRW2luSF0mahIFbsib5Jsm7bfUygTYusrKCJn3WrGEcTAD1rljm6EVydNz0jc5WW4Xgy8taAcmJT1JT/D1l0UdclI2rNza6dMXfpfwwdyc1TvEUwCbEEptsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591733; c=relaxed/simple;
	bh=Y920rcuHCDAXn6CAcOMUfz0HIVqB1L+/VVPopiRqKYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=utYq/z/X34WoyQlRg6lN1qWDrnxqgJ2SPgYqLDqRyJdVaovq6uSWZmslvIRqbI7u8TNxn2g5P/tJ7KvDpu3JF3V1rbODsZlnig3Y/DGaHdVAiEDEj/WpkQ+sYN1wW1FXQh7bR9GBhVFGVHJUZ8mWHgKZhRQ5gOnn80kUvas78M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1C4BRdbL; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M5VbiF028185;
	Thu, 22 Feb 2024 09:48:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=MzQfgSPOvlgzIc/To6XZ7nOyLSlsNDINxhaTxuo7Bww=; b=1C
	4BRdbLbw+j2x8CxsjcrQWbVQWS2Ok6JgpboEwvLC83CeRvPE2kPdGUuMC+SlV6LX
	0IW2zyO9vcO3afRcWE3SBHZLcVMAhFDGnVQcFNcZCNUzwhZtSGKTOIDvYD0L4lX+
	3KrXwCS6G5EblEuMNNxpQ3CfzWZ6tDue7HfwsBDHIJ00LdScrZQYpZIZQmlH1wcS
	BpMFq3HEZadHoYBlyLrJ6fqRRJ6YL/6o76KfPo7JWyGAKutSmknJXduzHtnlrFg1
	4ZM5d/hMaCeaOy2OBe8xpXDxKVjnZCb3nL+B1rXoP5cqH/xliQ9FACKCvjwir4K8
	qQiXpSRS/po8b6sDsX0Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wd201q8f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 09:48:31 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0EFCF40046;
	Thu, 22 Feb 2024 09:48:19 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CD5F52967CA;
	Thu, 22 Feb 2024 09:47:53 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Feb
 2024 09:47:53 +0100
Received: from [10.201.20.75] (10.201.20.75) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Feb
 2024 09:47:52 +0100
Message-ID: <adcf0c0d-f452-4285-8651-c147fcca001b@foss.st.com>
Date: Thu, 22 Feb 2024 09:47:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Introduction of a remoteproc tee to load signed
 firmware
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
Content-Language: en-US
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <fe4ec29f-7521-4369-a382-bae50dbf0ee5@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_06,2024-02-22_01,2023-05-22_02

Hello Naman,

On 2/22/24 06:43, Naman Jain wrote:
> On 2/14/2024 10:51 PM, Arnaud Pouliquen wrote:
>> Updates from the previous version [1]:
>>
>> This version proposes another approach based on an alternate load and boot
>> of the coprocessor. Therefore, the constraint introduced by tee_remoteproc
>> is that the firmware has to be authenticated and loaded before the resource
>> table can be obtained.
>>
>> The existing boot sequence is: >
>>    1) Get the resource table and store it in a cache,
>>       calling rproc->ops->parse_fw().
>>    2) Parse the resource table and handle resources,
>>       calling rproc_handle_resources.
>>    3) Load the firmware, calling rproc->ops->load().
>>    4) Start the firmware, calling rproc->ops->start().
>>   => Steps 1 and 2 are executed in rproc_fw_boot(), while steps 3 and 4 are
>>     executed in rproc_start().
>> => the use of rproc->ops->load() ops is mandatory
>>
>> The boot sequence needed for TEE boot is:
>>
>>    1) Load the firmware.
>>    2) Get the loaded resource, no cache.
>>    3) Parse the resource table and handle resources.
>>    4) Start the firmware.
> 
> Hi,
> What problem are we really addressing here by reordering load, parse of
> FW resources?

The feature introduced in TEE is the signature of the firmware images. That
means that before getting the resource table, we need to first authenticate the
firmware images.
Authenticating a firmware image means that we have to copy the firmware into
protected memory that cannot be corrupted by the non-secure and then verify the
signature.
The strategy implemented in OP-TEE is to load the firmware into destination
memory and then authenticate it.
This strategy avoids having a temporary copy of the whole images in a secure memory.
This strategy imposes loading the firmware images before retrieving the resource
table.

> Basically, what are the limitations of the current design you are referring to?
> I understood that TEE is designed that way.

The limitation of the current design is that we obtain the resource table before
loading the firmware. Following the current design would impose constraints in
TEE that are not straightforward. Step 1 (getting the resource table and storing
it in a cache) would require having a copy of the resource table in TEE after
authenticating the images. However, authenticating the firmware, as explained
before, depends on the strategy implemented. In TEE implementation, we load the
firmware to authenticate it in the destination memory.

Regards,
Arnaud

> 
>>
>> Then the crash recovery also has to be managed.For recovery, the cache is
>> used to temporarily save the resource table and then reapply it on
>> restart:
>>    1) Stop the remote processor, calling rproc->ops->stop().
>>    2) Load the firmware, calling rproc->ops->load().
>>    3) Copy cached resource table.
>>    4) Start the remote processor, calling rproc->ops->start().
>>
>> => This sequence is also needed when TEE manages the boot of the remote
>>     processor.
>> => The rproc->ops->load() is also used in recovery sequence.
>>
>> Based on the sequences described above, the proposal is to:
>>
>> - Rework tee_rproc API to better match the rproc_ops structure.
>>    This allows to simply map the function to implement the load ops, which
>>    is not optional. The tee_rproc_load_fw() is updated in consequence.
>> - Remove the call of rproc_load_segments from rproc_start() to dissociate
>>    the load and the start. This is necessary to implement the boot sequence
>>    requested for the TEE remote proc support.
>> - Introduce an rproc_alt_fw_boot() function that is an alternative boot
>>    sequence, which implements the sequence requested for the TEE remoteproc
>>    support.
>>
>>
>> [1]
>> https://lore.kernel.org/lkml/20240118100433.3984196-1-arnaud.pouliquen@foss.st.com/T/
>>
>>
>> Description of the feature:
>>
>> This series proposes the implementation of a remoteproc tee driver to
>> communicate with a TEE trusted application responsible for authenticating and
>> loading the remoteproc firmware image in an Arm secure context.
>>
>> 1) Principle:
>>
>> The remoteproc tee driver provides services to communicate with the OP-TEE
>> trusted application running on the Trusted Execution Context (TEE).
> 
> s/Context/Environment?
> 
>> The trusted application in TEE manages the remote processor lifecycle:
>>
>> - authenticating and loading firmware images,
>> - isolating and securing the remote processor memories,
>> - supporting multi-firmware (e.g., TF-M + Zephyr on a Cortex-M33),
>> - managing the start and stop of the firmware by the TEE.
>>
> 
> Regards,
> Naman Jain
> 

