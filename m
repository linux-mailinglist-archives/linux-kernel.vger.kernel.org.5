Return-Path: <linux-kernel+bounces-48570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC26845E22
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4859F1F246EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D8012BEB3;
	Thu,  1 Feb 2024 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mhGmApDj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0010779FB;
	Thu,  1 Feb 2024 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807375; cv=none; b=B2oziUmmn7cfWMtwc63HTDaUxSyCSR0m7PKEBudVls7DpXuw7ZDO1MVxwi9zsfqmXzxcnH0WfvQsOu/h0pd1ODr+ss/lNP9aYYtK+V7lWVilY9EdH7VVQt44ttfv35Y4TMy6EJM9KseBqaTU+EXtv4VtDTgH5QV5qcBuVllQw7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807375; c=relaxed/simple;
	bh=83XK30FQAqdWMyXglieZ0fMtTZaBrSzc5Jn77WaHEow=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YBA6rZnEnI/IXEk7noOzGXS+3GJ2MmEZut7T8MKDY8mEz1PugX5eeHiBYTmCvH/O/NjEZ2eUgS007chhqFcFNNZfwyNjgDiS1Hh1WfEMniA7hXResUa8VCqGADMbuwfHmwFUZBAQGcALI1Gs4pdWoSaB49I/nEW9a+BTzMPNKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mhGmApDj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 411FFF9A029659;
	Thu, 1 Feb 2024 17:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xxtyEGXNKxGjJjisA1RYcutusayLpyCAh8Nc3UiogKw=; b=mh
	GmApDjhTyhbuSnMkT8fU/j+Pq2NfU7TbmKETpdPBXWQ8QLR05jdAX37VYh7aX6gU
	rbojG2Jv3FQEs01to0rxWUKnfAAXzX0tlMee00Qix9SQ1mBDoO5ftsWiioiE9HL9
	5Q2EbNQFrlZ4NM4VsmZQa22poljIYBRJKWwaNfD78EgPNk41pLxsTl+k6jr7AdxL
	sAyV7kl/OicMPwVdWAn179AOJ8x79GV1ZA8oFiLv1tXHg6nJRG4QAh/B/Z2C1v+3
	ys3Ihe4zJ6XKre1+p0lmYyysXTCc4/5CPW5BCsVOb7B5YeGwOEUM0vChphOThABS
	ajcHN4LnQ+mRA9iL44Zg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0aws8qbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:08:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 411H8I2R023482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 17:08:18 GMT
Received: from [10.71.110.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 09:08:14 -0800
Message-ID: <51dc64bb-3101-4b4a-a54f-c0df6c0b264c@quicinc.com>
Date: Thu, 1 Feb 2024 09:08:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/46] Dynamic allocation of reserved_mem array.
To: Rob Herring <robh@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <frowand.list@gmail.com>,
        <vgupta@kernel.org>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <guoren@kernel.org>, <monstr@monstr.eu>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <dinguyen@kernel.org>,
        <chenhuacai@kernel.org>, <tsbogend@alpha.franken.de>,
        <jonas@southpole.se>, <stefan.kristiansson@saunalahti.fi>,
        <shorne@gmail.com>, <mpe@ellerman.id.au>, <ysato@users.sourceforge.jp>,
        <dalias@libc.org>, <glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
        <chris@zankel.net>, <jcmvbkbc@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240126235425.12233-1-quic_obabatun@quicinc.com>
 <20240131000710.GA2581425-robh@kernel.org>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <20240131000710.GA2581425-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LPcbI1CgCltXWnox5HjpuMkRQVGpH92Z
X-Proofpoint-ORIG-GUID: LPcbI1CgCltXWnox5HjpuMkRQVGpH92Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 spamscore=0 clxscore=1011 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 mlxlogscore=976 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010134


On 1/30/2024 4:07 PM, Rob Herring wrote:
> On Fri, Jan 26, 2024 at 03:53:39PM -0800, Oreoluwa Babatunde wrote:
>> The reserved_mem array is used to store data for the different
>> reserved memory regions defined in the DT of a device.  The array
>> stores information such as region name, node, start-address, and size
>> of the reserved memory regions.
>>
>> The array is currently statically allocated with a size of
>> MAX_RESERVED_REGIONS(64). This means that any system that specifies a
>> number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
>> will not have enough space to store the information for all the regions.
>>
>> Therefore, this series extends the use of the static array for
>> reserved_mem, and introduces a dynamically allocated array using
>> memblock_alloc() based on the number of reserved memory regions
>> specified in the DT.
>>
>> Some architectures such as arm64 require the page tables to be setup
>> before memblock allocated memory is writable.  Therefore, the dynamic
>> allocation of the reserved_mem array will need to be done after the
>> page tables have been setup on these architectures. In most cases that
>> will be after paging_init().
>>
>> Reserved memory regions can be divided into 2 groups.
>> i) Statically-placed reserved memory regions
>> i.e. regions defined in the DT using the @reg property.
>> ii) Dynamically-placed reserved memory regions.
>> i.e. regions specified in the DT using the @alloc_ranges
>>     and @size properties.
>>
>> It is possible to call memblock_reserve() and memblock_mark_nomap() on
>> the statically-placed reserved memory regions and not need to save them
>> to the reserved_mem array until memory is allocated for it using
>> memblock, which will be after the page tables have been setup.
>> For the dynamically-placed reserved memory regions, it is not possible
>> to wait to store its information because the starting address is
>> allocated only at run time, and hence they need to be stored somewhere
>> after they are allocated.
>> Waiting until after the page tables have been setup to allocate memory
>> for the dynamically-placed regions is also not an option because the
>> allocations will come from memory that have already been added to the
>> page tables, which is not good for memory that is supposed to be
>> reserved and/or marked as nomap.
>>
>> Therefore, this series splits up the processing of the reserved memory
>> regions into two stages, of which the first stage is carried out by
>> early_init_fdt_scan_reserved_mem() and the second is carried out by
>> fdt_init_reserved_mem().
>>
>> The early_init_fdt_scan_reserved_mem(), which is called before the page
>> tables are setup is used to:
>> 1. Call memblock_reserve() and memblock_mark_nomap() on all the
>>    statically-placed reserved memory regions as needed.
>> 2. Allocate memory from memblock for the dynamically-placed reserved
>>    memory regions and store them in the static array for reserved_mem.
>>    memblock_reserve() and memblock_mark_nomap() are also called as
>>    needed on all the memory allocated for the dynamically-placed
>>    regions.
>> 3. Count the total number of reserved memory regions found in the DT.
>>
>> fdt_init_reserved_mem(), which should be called after the page tables
>> have been setup, is used to carry out the following:
>> 1. Allocate memory for the reserved_mem array based on the number of
>>    reserved memory regions counted as mentioned above.
>> 2. Copy all the information for the dynamically-placed reserved memory
>>    regions from the static array into the new allocated memory for the
>>    reserved_mem array.
>> 3. Add the information for the statically-placed reserved memory into
>>    reserved_mem array.
>> 4. Run the region specific init functions for each of the reserve memory
>>    regions saved in the reserved_mem array.
> I don't see the need for fdt_init_reserved_mem() to be explicitly called 
> by arch code. I said this already, but that can be done at the same time 
> as unflattening the DT. The same conditions are needed for both: we need 
> to be able to allocate memory from memblock.
>
> To put it another way, if fdt_init_reserved_mem() can be called "early", 
> then unflattening could be moved earlier as well. Though I don't think 
> we should optimize that. I'd rather see all arches call the DT functions 
> at the same stages.
Hi Rob,

The reason we moved fdt_init_reserved_mem() back into the arch specific code
was because we realized that there was no apparently obvious way to call
early_init_fdt_scan_reserved_mem() and fdt_init_reserved_mem() in the correct
order that will work for all archs if we placed fdt_init_reserved_mem() inside the
unflatten_devicetree() function.

early_init_fdt_scan_reserved_mem() needs to be
called first before fdt_init_reserved_mem(). But on some archs,
unflatten_devicetree() is called before early_init_fdt_scan_reserved_mem(), which
means that if we have fdt_init_reserved_mem() inside the unflatten_devicetree()
function, it will be called before early_init_fdt_scan_reserved_mem().

This is connected to your other comments on Patch 7 & Patch 14.
I agree, unflatten_devicetree() should NOT be getting called before we reserve
memory for the reserved memory regions because that could cause memory to be
allocated from regions that should be reserved.

Hence, resolving this issue should allow us to call fdt_init_reserved_mem() from
the  unflatten_devicetree() function without it changing the order that we are
trying to have.

I will work on implementing this and send another revision.
>
>> Once the above steps have been completed and the init process is done
>> running, the original statically allocated reserved_mem array of size
>> MAX_RESERVED_REGIONS(64) will be automatically freed back to buddy
>> because it is no longer needed. This is done by marking the array as an
>> "__initdata" object in Patch 0018.
>>
>> Note:
>>
>> - Per Architecture, this series is effectively only 10 patches. The
>>   code for each architecture is split up into separate patches to
>>   allow each architecture to be tested independently of changes from
>>   other architectures. Should this series be accepted, this should
>>   allow for each arcitecture change to be picked up independently as
>>   well.
> Only if patches 1 and 2 are accepted in one cycle and the arch ones in 
> the next cycle. No need for that though, I can take the whole thing 
> (when it's ready).
ack.
>
>>   Patch 0001: Splits up the processing of the reserved memory regions
>>   between early_init_fdt_scan_reserved_mem and fdt_init_reserved_mem.
>>
>>   Patch 0002: Introduces a copy of early_init_fdt_scan_reserved_mem()
>>   which is used to separate it from fdt_init_reserved_mem() so that the
>>   two functions can be called independently of each other.
>>
>>   Patch 0003 - Patch 0016: Duplicated change for each architecture to
>>   call early_init_fdt_scan_reserved_mem() and fdt_init_reserved_mem()
>>   at their appropriate locations. Here fdt_init_reserved_mem() is called
>>   either before of after the page tables have been setup depending on
>>   the architecture requirements.
>>
>>   Patch 0017: Deletes the early_init_fdt_scan_reserved_mem() function
>>   since all architectures are now using the copy introduced in
>>   Patch 0002.
>>
>>   Patch 0018: Dynamically allocate memory for the reserved_mem array
>>   based on the total number of reserved memory regions specified in the
>>   DT.
>>
>>   Patch 0019 - Patch 0029: Duplicated change for each architecture to
>>   move the fdt_init_reserved_mem() function call to below the
>>   unflatten_devicetree() function call. This is so that the unflatten
>>   devicetree APIs can be used to process the reserved memory regions.
>>
>>   Patch 0030: Make code changes to start using the unflatten devicetree
>>   APIs to access the reserved memory regions defined in the DT.
>>
>>   Patch 0031: Rename fdt_* functions as dt_* to refelct that the
>>   flattened devicetree (fdt) APIs have been replaced with the unflatten
>>   devicetree APIs.
>>
>>   Patch 0032 - Patch 0045: Duplicated change for each architecture to
>>   switch from the use of fdt_init_reserved_mem() to
>>   dt_init_reserved_mem(), which is the same function but the later uses
>>   the unflatten devicetree APIs.
>>
>>   Patch 0046: Delete the fdt_init_reserved_mem() function as all
>>   architectures have switched to using dt_init_reserved_mem() which was
>>   introduced in Patch 0031.
>>
>> - The limitation to this approach is that there is still a limit of
>>   64 for dynamically-placed reserved memory regions. But from my current
>>   analysis, these types of reserved memory regions are generally less
>>   in number when compared to the statically-placed reserved memory
>>   regions.
>>
>> - I have looked through all architectures and placed the call to
>>   memblock_alloc() for the reserved_mem array at points where I
>>   believe memblock allocated memory are available to be written to.
>>   I currently only have access to an arm64 device and this is where I am
>>   testing the functionality of this series. Hence, I will need help from
>>   architecture maintainers to test this series on other architectures to
>>   ensure that the code is functioning properly on there.
>>
>> Previous patch revisions:
>> 1. [RFC V1 Patchset]:
>> https://lore.kernel.org/all/20231019184825.9712-1-quic_obabatun@quicinc.com/
>>
>> 2. [RFC V2 Patchset]:
>> https://lore.kernel.org/all/20231204041339.9902-1-quic_obabatun@quicinc.com/
>> - Extend changes to all other relevant architectures.
>> - Add code to use unflatten devicetree APIs to process the reserved
>>   memory regions.
> Dropping RFC does not make this v1. RFC is a state of the patches not a 
> version.
ack.


Thank you for your comments!

Oreoluwa

