Return-Path: <linux-kernel+bounces-72409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF385B2E7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E7E3B209CF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494C15915B;
	Tue, 20 Feb 2024 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M6hcCK90"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273459149;
	Tue, 20 Feb 2024 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708410532; cv=none; b=HwG7b+B5W8sB66xN6738t2v0Yb4PLE8Dz6awpaWkJd/J0XgFbn7vBh7kXqJi0YxuDmEZ5LlGOtJ3lr5mPhfdieYDqhyw7ADKrLa25KZdN6gZ77XG9v9xQ8rYiL8OFn5taB+Yq2Vb5xduchPTiVDfiBP70AfFd7M6Hdjyc+vw4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708410532; c=relaxed/simple;
	bh=ccVrK2Iff7tTq28JNYp1XntXvVJ1uoYZCUCr1EVZB68=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yr7P/mO6bW3YQqGCp3njBkYArvJfqrJxxr5hbWYRrMLwhWJDi96dJwZkzrEs8/GMUs3cVMQgvtU4FNgEOnHWxyt4q8N8YgerafOjC82gBW4JePLhLlOmEUwglXHyYic71EQtvdKznx3zGdeW8Kzs8YkfG3DhblEExFz98TKXoAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M6hcCK90; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K10CfG021178;
	Tue, 20 Feb 2024 06:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Xd2HlGPjlW3lnWzmcbx40LZsSwC7XGHf2iTmpoAjFfg=; b=M6
	hcCK90UJshfW5GkD+Hy2EYg+AsBe+3yMRXMHJaZZtufY1Zu3FUEC2xSSYfutZlEV
	7gOl7fkrkWtViNVds6v1lwNRFR+7KbIhLjkhTWhh20OuWhDEVgJmVcBlxgEvMvHA
	YTnsmV8JoeYnSM8XnUUsplxRltlFp/SZg4eIZ4rTb78PxrVZDdaTuimBBIESfWMT
	3FiyyDzufDgUPMfZTvL8CcE58z50rQ2OzOx4a8f5JjctBWqYBIHx5FUWiIvvi2fx
	vlT3F67kH6ObMhNGhoxBElYQDlE+2TtQBvxWTSN1g8o+dT1o40WzWWPcb6p/nBek
	ZcyMliMx3FNcxGOv80uA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wc54b20w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 06:28:39 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41K6ScY7005432
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 06:28:38 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 19 Feb
 2024 22:28:35 -0800
Message-ID: <a44a435c-e52d-4ee5-b05e-9f43a071c479@quicinc.com>
Date: Tue, 20 Feb 2024 14:28:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memblock: avoid to create memmap for memblock nomap
 regions
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: Vijayanand Jitta <quic_vjitta@quicinc.com>, <karahmed@amazon.de>,
        <qperret@google.com>, <robh@kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>
References: <YlW2TO0O8qDHpkGW@kernel.org>
 <7b18bea8-b996-601d-f490-cb8aadfffa1b@quicinc.com>
 <YnQBKPWtPa87y4NA@kernel.org>
 <42f28e7b-c001-7d01-1eb6-fe963491898e@quicinc.com>
 <Ynj+M9cRm6zdCMMi@kernel.org>
 <22aca197-8d18-2c9e-b3c4-f6fdc893ceb1@quicinc.com>
 <Yu1t8TpXT1f372v/@kernel.org>
 <76cb3b37-5887-404f-95b7-10a22a7ba65b@quicinc.com>
 <ZcxvKvSfJv6L2O9e@kernel.org>
 <CAA8EJpqpGN6yzd5pUs06aax=L5wDwPK6aM6R2X784y7ot+P-aQ@mail.gmail.com>
 <ZcyEzHva7pq-3Zav@kernel.org>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <ZcyEzHva7pq-3Zav@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: skF8QPo9vkm3DYIUS7msQOzdc31ACWQj
X-Proofpoint-ORIG-GUID: skF8QPo9vkm3DYIUS7msQOzdc31ACWQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_05,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1011 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200045



On 2/14/2024 5:15 PM, Mike Rapoport wrote:
> On Wed, Feb 14, 2024 at 10:11:40AM +0200, Dmitry Baryshkov wrote:
>> On Wed, 14 Feb 2024 at 09:44, Mike Rapoport <rppt@kernel.org> wrote:
>>>
>>> On Thu, Feb 08, 2024 at 02:37:25PM +0800, Aiqun Yu (Maria) wrote:
>>>>
>>>> On 8/6/2022 3:22 AM, Mike Rapoport wrote:
>>>>> Hi Vijay,
>>>>>
>>>>> On Wed, Aug 03, 2022 at 04:27:33PM +0530, Vijayanand Jitta wrote:
>>>>>>
>>>>>> On 5/9/2022 5:12 PM, Mike Rapoport wrote:
>>>>>>> On Mon, May 09, 2022 at 04:37:30PM +0530, Faiyaz Mohammed wrote:
>>>>>>>>
>>>>>>>> On 5/5/2022 10:24 PM, Mike Rapoport wrote:
>>>>>>>>> On Thu, May 05, 2022 at 08:46:15PM +0530, Faiyaz Mohammed wrote:
>>>>>>>>>> On 4/12/2022 10:56 PM, Mike Rapoport wrote:
>>>>>>>>>>> On Tue, Apr 12, 2022 at 12:39:32AM +0530, Faiyaz Mohammed wrote:
>>>>>>>>>>>> This 'commit 86588296acbf ("fdt: Properly handle "no-map" field in the
>>>>>>>>>>>> memory region")' is keeping the no-map regions in memblock.memory with
>>>>>>>>>>>> MEMBLOCK_NOMAP flag set to use no-map memory for EFI using memblock api's,
>>>>>>>>>>>> but during the initialization sparse_init mark all memblock.memory as
>>>>>>>>>>>> present using for_each_mem_pfn_range, which is creating the memmap for
>>>>>>>>>>>> no-map memblock regions. To avoid it skiping the memblock.memory regions
>>>>>>>>>>>> set with MEMBLOCK_NOMAP set and with this change we will be able to save
>>>>>>>>>>>> ~11MB memory for ~612MB carve out.
>>>>>>>>>>> The MEMBLOCK_NOMAP is very fragile and caused a lot of issues already. I
>>>>>>>>>>> really don't like the idea if adding more implicit assumptions about how
>>>>>>>>>>> NOMAP memory may or may not be used in a generic iterator function.
>>>>>>>>>> Sorry for delayed response.
>>>>>>>>>> Yes, it is possible that implicit assumption can create
>>>>>>>>>> misunderstanding. How about adding command line option and control the
>>>>>>>>>> no-map region in fdt.c driver, to decide whether to keep "no-map" region
>>>>>>>>>> with NOMAP flag or remove?. Something like below
>>>>>>>>> I really don't like memblock_remove() for such cases.
>>>>>>>>> Pretending there is a hole when there is an actual DRAM makes things really
>>>>>>>>> hairy when it comes to memory map and page allocator initialization.
>>>>>>>>> You wouldn't want to trade system stability and random memory corruptions
>>>>>>>>> for 11M of "saved" memory.
>>>>>>>>
>>>>>>>> Creating memory map for holes memory is adding 11MB overhead which is
>>>>>>>> huge on low memory target and same time 11MB memory saving is good enough
>>>>>>>> on low memory target.
>>>>>>>>
>>>>>>>> Or we can have separate list of NOMAP like reserved?.
>>>>>>>>
>>>>>>>> Any other suggestion to address this issue?.
>>>>>>>
>>>>>>> Make your firmware to report the memory that Linux cannot use as a hole,
>>>>>>> i.e. _not_ report it as memory.
>>>>>>
>>>>>> Thanks, Mike for the comments.
>>>>>>
>>>>>> Few concerns with this approach.
>>>>>>
>>>>>> 1) One concern is, even if firmware doesn't report these regions as
>>>>>> memory, we would need addresses for these to be part of device tree so
>>>>>> that the clients would be able to get these addresses. Otherwise there
>>>>>> is no way for client to know these addresses.
>>>>>>
>>>>>> 2) This would also add a dependency on firmware to be able to pass these
>>>>>> regions not as memory, though we know that these regions would be used
>>>>>> by the clients. Isn't it better to have such control within the kernel ?
>>>>>
>>>>> If it is memory that is used by the kernel it should be reported as memory
>>>>> and have the memory map.
>>>>> If this is a hole in the memory layout from the kernel perspective, then
>>>>> kernel should not bother with this memory.
>>>> Hi Mike,
>>>>
>>>> We've put effort on bootloader side to implement the similar suggestion of
>>>> os bootloader to convey the reserved memory by omit the hole from
>>>> /memory@0{reg=[]} directly.
>>>> While there is a concern from device tree spec perspective, link [1]: "A
>>>> memory device node is required for all devicetrees and describes the
>>>> physical memory layout for the system. "
>>>> Do you have any idea on this pls?
>>>
>>> I'm not sure I understand your concern. Isn't there a /memory node that
>>> describes the memory available to Linux in your devicetree?
>>
>> That was the question. It looks like your opinion on /memory was that
>> it describes "memory available to Linux", while device tree spec
>> defines it as "physical memory layout".
>   
> I suggested a workaround that will allow to save memory map for the
> carveout.
> The memory map is a run time description of the physical memory layout and
> core mm relies on availability of struct page for every physical frame.
> Having only partial memory map will lead to subtle bugs and crashes, so
> it's not an option.
Any idea of a formal solution for this case?
It is a real use case for the commercial device. Memory saving is always 
a good topic for commercial devices. So for a total 128MB memory, ~60MB 
for kernel total available memory, and ~1M free memory saving is 
important from OEM point of view.

There are 3 types of memory:
1. used by firmware and not available to kernel at any time.
Either struct page can be avoided by kernel. Or bootloader not pass this 
part of physical memory was discussed here.
Any good ideas?
2. shared by firmware/subsystem, and can be read/write access by kernel.
Just as it is now. Struct page can be allocated inside kernel and also 
reserved memory for this.
3. freely used by kernel.
Just as it is now.
> 
>>>> [1] https://github.com/devicetree-org/devicetree-specification/blob/main/source/chapter3-devicenodes.rst
>>
>> -- 
>> With best wishes
>> Dmitry
> 

-- 
Thx and BRs,
Aiqun(Maria) Yu

