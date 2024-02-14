Return-Path: <linux-kernel+bounces-65990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B69418554DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24662B218CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F1013F000;
	Wed, 14 Feb 2024 21:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lk+ojk3f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7ED134740;
	Wed, 14 Feb 2024 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946467; cv=none; b=nJgkqwpt3etEE5QEAYbTQtk69CKZW5i/JAUM8OjlnzgH0Z9AHAIViUk9xg8YcNq4lZGhIiOJUzZaISx85a2vrDj471EJjYFt0UoL9gXM+31q32iFq3nCHTH5mdfRheJfHKA9xy34chp+i/b/Yc1yjGgY9HV3XCi7A+SKp+mAHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946467; c=relaxed/simple;
	bh=Q6j4BHMns0h+WxQIjqSMnT4o7C6OxX6xtAP1jLjnNNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DSMrAUEGBwwcHJBohw3z5bvdil03cyLwmUVRwO+7ni3XsEXYnpn3hRjD902FPtDuBvYEiS9j8Glhtx0ONNIKps1EMRPVDCJmFU9zmyt11/eXuvPKlLuZihs/Zsp+zjpuIYOMW5WpU3XORpgAGjAPuNlNqnPFlvQlmm1zaXEejX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lk+ojk3f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41ELUeZ9005821;
	Wed, 14 Feb 2024 21:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dbVwpts8F08fJF//2xqBb1oUCy/fQrwva/LA3Jl6tbE=; b=lk
	+ojk3fxEKc2MVBIKWw87aFtQb5Diu3u/9AwC1170Rid8VLeo1VyJf5HBycZUdN1C
	fruWjgflEnWxGxGWlunnh8lTr/NEb749q02Tdcof7cwi/eGIsAMQV2Mb8VW5BSZZ
	ZudRu0AtcBrwuHyE4v66aT/XP3LcOIQjvrEgOggN0izMS7bqWn82AwfDwUILczmw
	2NPqOu6my3IdI+PoqpPoIsUpif0rlH4b8fkeCzZ4xVODuWkVX6w93ed8216Adqcq
	S/Rlh6KOIJSiNHOIptYAbw4PRYEUTSLbY4Ha6QFcFbuqCmLaCa/VwEWhIw0/USyg
	VmbEag0rBBNQhCXJbRVQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8myg26dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 21:31:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41ELVnJn016056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 21:31:49 GMT
Received: from [10.71.110.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 13:31:46 -0800
Message-ID: <03c2c48d-d05f-4906-b63b-711c94133489@quicinc.com>
Date: Wed, 14 Feb 2024 13:31:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] loongarch: Call arch_mem_init() before
 platform_init() in the init sequence
To: Huacai Chen <chenhuacai@kernel.org>
CC: <jonas@southpole.se>, <stefan.kristiansson@saunalahti.fi>,
        <shorne@gmail.com>, <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <glaubitz@physik.fu-berlin.de>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <linux-openrisc@vger.kernel.org>,
        <loongarch@lists.linux.dev>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kernel@quicinc.com>
References: <1707524971-146908-1-git-send-email-quic_obabatun@quicinc.com>
 <1707524971-146908-2-git-send-email-quic_obabatun@quicinc.com>
 <CAAhV-H5f5e-cCaX7Gr20oG8F-aywJcosLn4ajxx2SQWoB8JtSA@mail.gmail.com>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <CAAhV-H5f5e-cCaX7Gr20oG8F-aywJcosLn4ajxx2SQWoB8JtSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QnVTO4n29rWWGb8jdilowa6YD6gHzyG_
X-Proofpoint-ORIG-GUID: QnVTO4n29rWWGb8jdilowa6YD6gHzyG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_14,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402140166


On 2/14/2024 5:03 AM, Huacai Chen wrote:
> Hi, Oreoluwa,
>
> On Sat, Feb 10, 2024 at 8:29 AM Oreoluwa Babatunde
> <quic_obabatun@quicinc.com> wrote:
>> The platform_init() function which is called during device bootup
>> contains a few calls to memblock_alloc().
>> This is an issue because these allocations are done before reserved
>> memory regions are set aside in arch_mem_init().
>> This means that there is a possibility for memblock to allocate memory
>> from any of the reserved memory regions.
>>
>> Hence, move the call to arch_mem_init() to be earlier in the init
>> sequence so that all reserved memory is set aside before any allocations
>> are made with memblock.
>>
>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>> ---
>>  arch/loongarch/kernel/setup.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
>> index edf2bba..66c307c 100644
>> --- a/arch/loongarch/kernel/setup.c
>> +++ b/arch/loongarch/kernel/setup.c
>> @@ -597,8 +597,8 @@ void __init setup_arch(char **cmdline_p)
>>         parse_early_param();
>>         reserve_initrd_mem();
>>
>> -       platform_init();
>>         arch_mem_init(cmdline_p);
>> +       platform_init();
> Thank you for your patch, but I think we cannot simply exchange their
> order. If I'm right, you try to move all memblock_reserve() as early
> as possible, but both arch_mem_init() and platform_init() call
> memblock_reserve(), we should do a complete refactor for this. And
> since it works with the existing order, we can simply keep it as is
> now.
>
> Huacai
Hi Huacai,

Thank you for your response!

I'm not trying to move all memblock_reserve() to be as early as possible,
I'm trying to move the call to early_init_fdt_scan_reserved_mem() to be
as early as possible. This is the function that is used to set aside all the
reserved memory regions that are meant for certain devices/drivers.

The reserved memory regions I am referring to are explicitly defined in
the DT. These regions are set aside so that the system will have either
limited access or no access to them at all.
Some of these regions are also defined with a property called no-map
which tells the system not to create a memory mapping for them.
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/reserved-memory/reserved-memory.yaml#L79

Hence, setting aside these memory regions should take priority and should
be done first before any memblock allocations are done so that the system
does not  unknowingly allocate memory from a region that is meant to be
reserved for a device/driver.

Eg:
    unflatten_and_copy_device_tree() eventually calls memblock_alloc():
    https://elixir.bootlin.com/linux/latest/source/drivers/of/fdt.c#L1264

    Since unflatten_and_copy_device_tree() is called in platform_init(), this
    allocation is done before we are able to set aside any of the reserved
    memory regions from the DT which is supposed to be done by
    early_init_fdt_scan_reserved_mem() in the arch_mem_init() function.

    Hence, it is possible for unflatten_and_copy_device_tree() to allocate
    memory from a region that is meant to be set aside for a device/driver
    without the system knowing.

This can create problems for a device/driver if a region of memory that was
supposed to be set aside for it ends up being allocated for another use case
by memblock_alloc*().

Regards,

Oreoluwa

