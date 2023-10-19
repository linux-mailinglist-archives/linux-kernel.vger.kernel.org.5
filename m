Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344DF7D050B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346689AbjJSWxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjJSWxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:53:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8294134;
        Thu, 19 Oct 2023 15:45:59 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JMWR8n012269;
        Thu, 19 Oct 2023 22:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HGh5RIhqjkjYPosV8+pUioVK+MKtfbrBwhNPit3GNXU=;
 b=jrdiF//huxYBB5lmGOtZFKARb45SdOBUHpTj9WVdwB+mn9ME3fauwEzXRyIB0YYjtseD
 DGh0gWk55tK1UVWUorn+qgWVD35DtC5dkiT3gebnLrq5qr/DlvbfI341kaq8qWDsoK8n
 m2ndDPySi3igjsSVwI3ampRwEQR/z7mSOdKeNSo0ISTJlxr63mhl8rqQYXhpF7sVdDR3
 zkK9cvkaYSdmMa6hiPQEEkh3XSEFU9V0VaVC20KyDH2n3SjFFxI3L4U41xr37lpvueGr
 GFRNuxMGZPFuKPm3jhpvLdSbcZoikk3O53X8Zg7mkdhwVEz6AT1EvvVe0qEUuTnsFBbv bg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tubwr068f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 22:45:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39JMjmdr015028
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 22:45:48 GMT
Received: from [10.71.110.214] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 19 Oct
 2023 15:45:45 -0700
Message-ID: <7e6ddffc-81a5-4183-9e59-7060776c936a@quicinc.com>
Date:   Thu, 19 Oct 2023 15:45:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] of: reserved_mem: Change the order that
 reserved_mem regions are stored
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <frowand.list@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>
References: <20231019184825.9712-1-quic_obabatun@quicinc.com>
 <20231019184825.9712-2-quic_obabatun@quicinc.com>
 <CAL_Jsq+pUv29277spzXB7QJ=OZTwGy_FmW55CzQPWYLPktA0EA@mail.gmail.com>
From:   Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <CAL_Jsq+pUv29277spzXB7QJ=OZTwGy_FmW55CzQPWYLPktA0EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C-h5FgffPKD3GbcCCAXzGuMC5Jn6tkiM
X-Proofpoint-ORIG-GUID: C-h5FgffPKD3GbcCCAXzGuMC5Jn6tkiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 mlxscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310170001 definitions=main-2310190193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/19/2023 12:46 PM, Rob Herring wrote:
> On Thu, Oct 19, 2023 at 1:49 PM Oreoluwa Babatunde
> <quic_obabatun@quicinc.com> wrote:
>> The dynamic allocation of the reserved_mem array needs to be done after
>> paging_init() is called because memory allocated using memblock_alloc()
>> is not writeable before that.
>>
>> Nodes that already have their starting address specified in the DT
>> (i.e. nodes that are defined using the "reg" property) can wait until
>> after paging_init() to be stored in the array.
>> But nodes that are dynamically placed need to be reserved and saved in
>> the array before paging_init() so that page table entries are not
>> created for these regions.
>>
>> Hence, change the code to:
>> 1. Before paging_init(), allocate and store information for the
>>    dynamically placed reserved memory regions.
>> 2. After paging_init(), store the rest of the reserved memory regions
>>    which are defined with the "reg" property.
>>
>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>> ---
>>  arch/arm64/kernel/setup.c       |  4 +++
>>  drivers/of/fdt.c                | 56 ++++++++++++++++++++++++++-------
>>  drivers/of/of_private.h         |  1 -
>>  drivers/of/of_reserved_mem.c    | 54 ++++++++++++++-----------------
>>  include/linux/of_fdt.h          |  1 +
>>  include/linux/of_reserved_mem.h |  9 ++++++
>>  6 files changed, 83 insertions(+), 42 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index 417a8a86b2db..6002d3ad0b19 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -27,6 +27,8 @@
>>  #include <linux/proc_fs.h>
>>  #include <linux/memblock.h>
>>  #include <linux/of_fdt.h>
>> +#include <linux/of_reserved_mem.h>
>> +
>>  #include <linux/efi.h>
>>  #include <linux/psci.h>
>>  #include <linux/sched/task.h>
>> @@ -346,6 +348,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>>
>>         paging_init();
>>
>> +       fdt_init_reserved_mem();
>> +
> You removed this call from the common code and add it to arm64 arch
> code, doesn't that break every other arch?
Yes, the same changes will be needed for every other arch. I was hoping to
get some feedback on the RFC before implementing this on other archs which
is why the change is currently only in arm64.
> The very next thing done here is unflattening the DT. So another call
> from the arch code to the DT code isn't needed either.
Yes, I see that unflatten_device_tree() is being called right after here.
Just to clarify, are you suggesting to move fdt_init_reserved_mem() into the
unflatten_device_tree() call?


Thanks, Oreoluwa
