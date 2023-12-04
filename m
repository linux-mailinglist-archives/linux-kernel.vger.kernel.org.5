Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE25803D9D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343895AbjLDSz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjLDSzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:55:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414CD1B6;
        Mon,  4 Dec 2023 10:55:11 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4INYdn015584;
        Mon, 4 Dec 2023 18:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dSvfU/A9FYj1qwwOVJDS9+Ju7eixVYgLzQFvbz4/wN0=;
 b=lgGzNrVw3PrYNy5zmck71zSQhOAHdsCthOzNQCQWj4Jw6nQ05j09aYfqss+uMdcJSwaw
 cCLQFpHd/hs6tesTZ/C+1y3J5WuaU0yZDHQ3f2Jj13Iyoulgojpc16KsHO4zkUGRe4Nx
 b1S982VmTpCeLBFyOMSqLMrEbsaK2oIA9/n334jT+x+oc/gpSiT0BkYjVyraXgHjMbQz
 kHKoziP3IWvIc4QeL3eVHgzTmRp0AWsHIz8CLfkqbnQj4YyD1iZXupONXlhlywhjjZwd
 wfevyhfTZh+S7buhyH+JvsHy4lDowjTXrBS2jNn2Sx6KDR3tFSIJp/NtBIzrqbDd3J78 /A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3us81yj1sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 18:55:01 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B4It0Zr030512
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 18:55:00 GMT
Received: from [10.71.110.214] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Dec
 2023 10:54:57 -0800
Message-ID: <6602b327-f0a6-4eb5-860f-bf91cbfdff41@quicinc.com>
Date:   Mon, 4 Dec 2023 10:54:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/6] Dynamic allocation of reserved_mem array.
Content-Language: en-US
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>
References: <20231204041339.9902-1-quic_obabatun@quicinc.com>
From:   Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <20231204041339.9902-1-quic_obabatun@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bsIB1V5-Jc8GhGDBKvQaqP7GfBgc_pXW
X-Proofpoint-GUID: bsIB1V5-Jc8GhGDBKvQaqP7GfBgc_pXW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_18,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=943 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/3/2023 8:13 PM, Oreoluwa Babatunde wrote:
> The reserved_mem array is used to store the data of the different
> reserved memory regions specified in the DT of a device.
> The array stores information such as the name, node, starting address,
> and size of a reserved memory region.
>
> The array is currently statically allocated with a size of
> MAX_RESERVED_REGIONS(64). This means that any system that specifies a
> number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
> will not have enough space to store the information for all the regions.
>
> Therefore, this series extends the use of a static array for
> reserved_mem, and introduces a dynamically allocated array using
> memblock_alloc() based on the number of reserved memory regions
> specified in the DT.
>
> Memory gotten from memblock_alloc() is only writable after paging_init()
> is called, but the reserved memory regions need to be reserved before
> then so that the system does not create page table mappings for them.
>
> Reserved memory regions can be divided into 2 groups.
> i) Statically-placed reserved memory regions
> i.e. regions defined in the DT using the @reg property.
> ii) Dynamically-placed reserved memory regions.
> i.e. regions specified in the DT using the @alloc_ranges
>     and @size properties.
>
> It is possible to call memblock_reserve() and memblock_mark_nomap() on
> the statically-placed reserved memory regions and not need to save them
> to the array until after paging_init(), but this is not possible for the
> dynamically-placed reserved memory because the starting address of these
> regions need to be stored somewhere after they are allocated.
>
> Therefore, this series achieves the allocation and population of the
> reserved_mem array in two steps:
>
> 1. Before paging_init()
>    Before paging_init() is called, iterate through the reserved_mem
>    nodes in the DT and do the following:
>    - Allocate memory for dynamically-placed reserved memory regions and
>      store their starting address in the static allocated reserved_mem
>      array.
>    - Call memblock_reserve() and memblock_mark_nomap() on all the
>      reserved memory regions as needed.
>    - Count the total number of reserved_mem nodes in the DT.
>
> 2. After paging_init()
>    After paging_init() is called:
>    - Allocate new memory for the reserved_mem array based on the number
>      of reserved memory nodes in the DT.
>    - Transfer all the information that was stored in the static array
>      into the new array.
>    - Store the rest of the reserved_mem regions in the new array.
>      i.e. the statically-placed regions.
>
> The static array is no longer needed after this point, but there is
> currently no obvious way to free the memory. Therefore, the size of the
> initial static array is now defined using a config option.
> Because the array is used only before paging_init() to store the
> dynamically-placed reserved memory regions, the required size can vary
> from device to device. Therefore, scaling it can help get some memory
> savings.
>
> A possible solution to freeing the memory for the static array will be
> to mark it as __initdata. This will automatically free the memory once
> the init process is done running.
> The reason why this is not pursued in this series is because of
> the possibility of a use-after-free.
> If the dynamic allocation of the reserved_mem array fails, then future
> accesses of the reserved_mem array will still be referencing the static
> array. When the init process ends and the memory is freed up, any
> further attempts to use the reserved_mem array will result in a
> use-after-free.
>
> Note:
>
> - The limitation to this approach is that there is still a limit of
>   64 for dynamically reserved memory regions.
> - Upon further review, the series might need to be split up/duplicated
>   for other archs.
>
>
> Oreoluwa Babatunde (6):
>   of: reserved_mem: Change the order that reserved_mem regions are
>     stored
>   of: reserved_mem: Swicth call to unflatten_device_tree() to after
>     paging_init()
>   of: resevred_mem: Delay allocation of memory for dynamic regions
>   of: reserved_mem: Add code to use unflattened DT for reserved_mem
>     nodes
>   of: reserved_mem: Add code to dynamically allocate reserved_mem array
>   of: reserved_mem: Make MAX_RESERVED_REGIONS a config option
>
>  arch/loongarch/kernel/setup.c      |   2 +-
>  arch/mips/kernel/setup.c           |   3 +-
>  arch/nios2/kernel/setup.c          |   4 +-
>  arch/openrisc/kernel/setup.c       |   4 +-
>  arch/powerpc/kernel/setup-common.c |   3 +
>  arch/sh/kernel/setup.c             |   5 +-
>  arch/um/kernel/dtb.c               |   1 -
>  arch/um/kernel/um_arch.c           |   2 +
>  arch/xtensa/kernel/setup.c         |   4 +-
>  drivers/of/Kconfig                 |  13 +++
>  drivers/of/fdt.c                   |  39 +++++--
>  drivers/of/of_private.h            |   6 +-
>  drivers/of/of_reserved_mem.c       | 175 +++++++++++++++++++++--------
>  include/linux/of_reserved_mem.h    |   8 +-
>  kernel/dma/coherent.c              |   4 +-
>  kernel/dma/contiguous.c            |   8 +-
>  kernel/dma/swiotlb.c               |  10 +-
>  17 files changed, 205 insertions(+), 86 deletions(-)
re-sending this to include maintainers for the other
archs.

Regards,

Oreoluwa

