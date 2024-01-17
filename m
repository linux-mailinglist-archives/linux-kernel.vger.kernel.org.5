Return-Path: <linux-kernel+bounces-28971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53BF830586
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38032B23F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56241DDEA;
	Wed, 17 Jan 2024 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I6T1Wbui"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AE11BDFF;
	Wed, 17 Jan 2024 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705495110; cv=none; b=UKuhM5QwCtNk254BYmgY6yv8jNju8BIloWnuJl7n0o2/yJQiU2zdni7gHhdzq7Yzwf1CI8aW6yPB2t6E41pF9j5NgYud4GyEhcEGV78HG8vfcxxapZb6i25UJZHcOBooMpwuwile1QUOwF1oavcNpGxRY9kcyt4vCBAYfPK3W2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705495110; c=relaxed/simple;
	bh=2FIO2o8hG/hMWQ2hz4cmYEoZO1ZdvYv7c3poyLa+E0w=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=Abe1zyvCdmUVg4ObRWcUXOGmfX5JB/WXyj83GruFhZaCcuyoeDFn62Mrguajyl9GOtxPeZWUsSo9e9xrGd026BmWgt0trrhh6YOcpML7gEKbaE8xoOjr96sY0wmDXUNp28W5Wyr2BY/EVji97j6ArA8v8/cwvGKs2srUdTUmKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I6T1Wbui; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HC3ie4024293;
	Wed, 17 Jan 2024 12:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ss9xAIxbEeXnQeBjjduwMj7ruvLLHItecP2OUi0UCec=; b=I6
	T1WbuiwnWvViaUtiZpdCx66OT4s2dkGNpBuKbg1OeNymvXzobjwaiEhl5GtkQS2H
	Bxk4jeKEomAs0Mg2rWASxnEsYbRDqPqjYsUP7OPUXAB/CvErY/c2o7FJD75u/1kn
	zgxmBhaRaCMrAxjcGu5yBW175F8Omq3tVNqZk57NDN6J/9eu+W0KbpLctRh7jlTP
	dKs2dKdxnKLLsOURTwoVMDTnpjBAys3oO7WDWRlumx/KiVdjKJag58pvAIJaHCBE
	P5wz5uKAdvqx/IZNTdOtrg4ABAtrJKv2jDTLSP0idWeSxLltGmI07eTOt2HCQkTI
	Ue/Dtcd1lRxmvsgtKQDQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpejp02k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 12:38:01 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40HCc0FR004088
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 12:38:00 GMT
Received: from [10.216.41.142] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 04:37:51 -0800
Message-ID: <6cb0b6bb-9ef9-a7c9-0f59-fbd760aac644@quicinc.com>
Date: Wed, 17 Jan 2024 18:07:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 08/12] pstore/ram: Add dynamic ramoops region support
 through commandline
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, <corbet@lwn.net>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <matthias.bgg@gmail.com>, <kgene@kernel.org>,
        <alim.akhtar@samsung.com>, <bmasney@redhat.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240109153200.12848-1-quic_mojha@quicinc.com>
 <20240109153200.12848-9-quic_mojha@quicinc.com>
 <e48c1e84-b27e-4109-b80d-084ba8a399ff@infradead.org>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <e48c1e84-b27e-4109-b80d-084ba8a399ff@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yjUgOLl4neUNeF3oMjtISgrfh9yuFEnL
X-Proofpoint-GUID: yjUgOLl4neUNeF3oMjtISgrfh9yuFEnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_06,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401170090



On 1/10/2024 4:03 AM, Randy Dunlap wrote:
> 
> 
> On 1/9/24 07:31, Mukesh Ojha wrote:
>> The reserved memory region for ramoops is assumed to be at a fixed
>> and known location when read from the devicetree. This may not be
>> required for something like Qualcomm's minidump which is interested
>> in knowing addresses of ramoops region but it does not put hard
>> requirement of address being fixed as most of it's SoC does not
> 
>                                                  its
> 
>> support warm reset and does not use pstorefs at all instead it has
>> firmware way of collecting ramoops region if it gets to know the
>> address and register it with apss minidump table which is sitting
>> in shared memory region in DDR and firmware will have access to
>> these table during reset and collects it on crash of SoC.
>>
>> So, add the support of reserving ramoops region to be dynamically
>> allocated early during boot if it is request through command line
>> via 'dyn_ramoops_size=<size>' and fill up reserved resource structure
>> and export the structure, so that it can be read by ramoops driver.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   Documentation/admin-guide/ramoops.rst | 23 +++++++++-
>>   fs/pstore/Kconfig                     | 15 ++++++
>>   fs/pstore/ram.c                       | 66 +++++++++++++++++++++++++--
>>   include/linux/pstore_ram.h            |  5 ++
>>   init/main.c                           |  2 +
>>   5 files changed, 107 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
>> index e9f85142182d..517b00981e99 100644
>> --- a/Documentation/admin-guide/ramoops.rst
>> +++ b/Documentation/admin-guide/ramoops.rst
>> @@ -33,6 +33,13 @@ memory are implementation defined, and won't work on many ARMs such as omaps.
>>   Setting ``mem_type=2`` attempts to treat the memory region as normal memory,
>>   which enables full cache on it. This can improve the performance.
>>   
>> +Ramoops supports its memory to be allocated dynamically during early boot
>> +for plaforms that does not have support for warm boot i.e., no assurance
> 
>         platforms that do not have
> 
> 
>> +of Ram content will be preserved across boot and for these platform
> 
>     that RAM content                             and for these platforms
> 
>> +giving static Ramoops memory is not necessary as it has separate backend
>> +mechanism to retrieve ramoops content on system failure. More about
>> +how to enable Dynamic ramoops in ``Setting the parameters`` A.b section.
>> +
>>   The memory area is divided into ``record_size`` chunks (also rounded down to
>>   power of two) and each kmesg dump writes a ``record_size`` chunk of
>>   information.
>> @@ -59,7 +66,7 @@ Setting the parameters
>>   
>>   Setting the ramoops parameters can be done in several different manners:
>>   
>> - A. Use the module parameters (which have the names of the variables described
>> + A.a  Use the module parameters (which have the names of the variables described
>>    as before). For quick debugging, you can also reserve parts of memory during
>>    boot and then use the reserved memory for ramoops. For example, assuming a
>>    machine with > 128 MB of memory, the following kernel command line will tell
>> @@ -68,6 +75,20 @@ Setting the ramoops parameters can be done in several different manners:
>>   
>>   	mem=128M ramoops.mem_address=0x8000000 ramoops.ecc=1
>>   
>> + A.b  Ramoops memory can be also be dynamically reserve by Kernel and in such
> 
>                                                     reserved
> 
>> + scenario ``mem_address`` i.e, Ramoops base address can be anywhere in the RAM
> 
>                               i.e.,
> 
>> + instead of being fixed and predefined. A separate command line option
>> + ``dyn_ramoops_size=<size>`` and kernel config CONFIG_PSTORE_DYNAMIC_RAMOOPS
>> + is provided to facilitate Dynamic Ramoops memory reservation during early boot.
> 
>      are provided
> 
>> + The command line option and the config should only be used in the presence of
>> + separate backend which knows how to recover Dynamic Ramoops region otherwise
>> + regular ramoops functionality will be impacted.
>> + ``mem_size`` should not be used if Dynamic Ramoops support is requested and if
>> + both are given ``mem_size`` value is overwritten with ``dyn_ramoops_size`` value
>> + i.e, Dynamic Ramoops takes precedence::
> 
>      i.e.,
> 
>> +
>> +	dyn_ramoops_size=2M ramoops.console_size=2097152
>> +
>>    B. Use Device Tree bindings, as described in
>>    ``Documentation/devicetree/bindings/reserved-memory/ramoops.yaml``.
>>    For example::
>> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
>> index 3acc38600cd1..2f2bb483fd85 100644
>> --- a/fs/pstore/Kconfig
>> +++ b/fs/pstore/Kconfig
>> @@ -81,6 +81,21 @@ config PSTORE_RAM
>>   
>>   	  For more information, see Documentation/admin-guide/ramoops.rst.
>>   
>> +config PSTORE_DYNAMIC_RAMOOPS
>> +	bool "Reserve ramoops region dynamically"
>> +	select PSTORE_RAM
>> +	help
>> +	  This enables the dynamic reservation of ramoops region for a special case
>> +	  where there is no requirement to access the logs from pstorefs on next boot
> 
> 	                                                                         boot;
> 
>> +	  instead there is separate backend mechanism like minidump present which has
>> +	  awareness about the dynamic ramoops region and can recover the logs. This is
>> +	  enabled via command line parameter dyn_ramoops_size=<size> and should not be
>> +	  used in absence of separate backend which knows how to recover this dynamic
>> +	  region.
>> +
>> +	  Note whenever this config is selected ramoops driver will be build statically
> 
> 	                                                               built
> 
>> +	  into kernel.
>> +
>>   config PSTORE_ZONE
>>   	tristate
>>   	depends on PSTORE
>> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
>> index 88b34fdbf759..795a8300631e 100644
>> --- a/fs/pstore/ram.c
>> +++ b/fs/pstore/ram.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/compiler.h>
>>   #include <linux/of.h>
>>   #include <linux/of_address.h>
>> +#include <linux/memblock.h>
>>   #include <linux/mm.h>
>>   
>>   #include "internal.h"
>> @@ -103,6 +104,59 @@ struct ramoops_context {
>>   };
>>   
>>   static struct platform_device *dummy;
>> +static struct resource dyn_ramoops_res = {
>> +	.name  = "ramoops",
>> +	.start = 0,
>> +	.end   = 0,
>> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
>> +	.desc  = IORES_DESC_NONE,
>> +};
>> +static int dyn_ramoops_size;
>> +
>> +#ifdef CONFIG_PSTORE_DYNAMIC_RAMOOPS
>> +static int __init parse_dyn_ramoops_size(char *p)
>> +{
>> +	char *tmp;
>> +
>> +	dyn_ramoops_size = memparse(p, &tmp);
>> +	if (p == tmp) {
>> +		pr_err("ramoops: memory size expected\n");
>> +		dyn_ramoops_size = 0;
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +early_param("dyn_ramoops_size", parse_dyn_ramoops_size);
>> +
>> +/*
>> + * setup_dynamic_ramoops() - reserves memory for dynamic ramoops
>> + *
>> + * This enable dynamic reserve memory support for ramoops through
> 
>             enables

Thanks for the review, Noted all the points for the next version.

-Mukesh
> 
>> + * command line.
>> + */
> 
> 

