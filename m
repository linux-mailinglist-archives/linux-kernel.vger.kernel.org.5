Return-Path: <linux-kernel+bounces-143390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 017328A3800
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 23:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595EEB22516
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FF1152186;
	Fri, 12 Apr 2024 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mSkNhyJl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5C839FD5;
	Fri, 12 Apr 2024 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712958119; cv=none; b=p6VsPZHxeeSroQhxnACHW6MMVLob7gR7V4tFT+byqcYagZxbZNA3lF3pby6GVM+dn8UkUGMNnJ/wn/kJ9sn+MWktCZM0RveIWblK1IBAEQ7JVlNS5QpspovY3Ml+Rdpk/f2LOt7h/7KIjZncthfCQsaAOksfHdVBWLkZfyYIRzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712958119; c=relaxed/simple;
	bh=B342CtOdf9X8OyLmBAxcvx/5wPPbgymJ27LhrFXOkfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GNrd/XuSX62ZZzvbd5A5fyfS8FsYiZ+8edRqXFLnKC9EDSJuQtJyvOIwP9g9slYIftPIR27zkIXQguPnmkE3SQsgdYL6wqV55ytTU269HlAfISOlBk5e44ZLlxQUnX5IR6m6i918sgpQNZxEeXJ9PNdOePIUhNdGU7PnR2ILzgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mSkNhyJl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CLOcCf031674;
	Fri, 12 Apr 2024 21:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Nk4TG9yDmY9Q1U96or5wfZFuqpbTyezZPX1b/MEyft4=; b=mS
	kNhyJlU3LJuUasbUvYHNbbO4hKal6ay8cFUVgVl4i8/HWIQ9IRMh0dbzttTGor5c
	5VC4GSi6r2uuYwQXZOg94GxzLHxWgCfQs+bZFpuTvd84+pBmHqZ0a5XqTHikhZvf
	qAfAYnNlR2Ix/pTeeLAeHME3LfvRkHOXsAUxe5VL8gGz+KDD/05+b82+tRBf2AWt
	WN4Y0Ax6DhVp+op8O52AS0hVowovoNNLR2bY9/SBa0ySBtm8m1X1xeHqZ8XvfWQj
	YHDlOA5WQwJWPONlXqAPkHKmfUQXvSVmLZYvEMcBxBp9nkB/5fToW7/1DQrCqQ2i
	ZhUjj96ONHq1WWzF8elw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xer1ttx5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 21:40:46 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CLei3W009864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 21:40:44 GMT
Received: from [10.110.105.144] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 14:40:40 -0700
Message-ID: <7befeeb2-a481-46ac-97d0-a9d6d023427d@quicinc.com>
Date: Fri, 12 Apr 2024 14:38:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] of: reserved_mem: Use the unflatten_devicetree
 APIs to scan reserved mem. nodes
To: Rob Herring <robh+dt@kernel.org>
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
References: <20240328211543.191876-1-quic_obabatun@quicinc.com>
 <20240328211543.191876-4-quic_obabatun@quicinc.com>
 <CAL_Jsq+RQaKTqB6hnsCJ_d0zM6FkrMXQ0NF0r1P22q95_ZDM4A@mail.gmail.com>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <CAL_Jsq+RQaKTqB6hnsCJ_d0zM6FkrMXQ0NF0r1P22q95_ZDM4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bUs5QiPjttYcdFzuNPx6Sq6bSgwqw58d
X-Proofpoint-GUID: bUs5QiPjttYcdFzuNPx6Sq6bSgwqw58d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_18,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120156


On 4/11/2024 11:59 AM, Rob Herring wrote:
> On Thu, Mar 28, 2024 at 4:16 PM Oreoluwa Babatunde
> <quic_obabatun@quicinc.com> wrote:
>> The unflatten_devicetree APIs have been setup and are available to be
>> used by the time the fdt_init_reserved_mem() function is called.
>> Since the unflatten_devicetree APIs are a more efficient way of scanning
>> through the DT nodes, switch to using these APIs to facilitate the rest
>> of the reserved memory processing.
> Please use get_maintainers.pl. Specifically, you missed maintainers
> for kernel/dma/.

Sorry about that, Will include them in the next version.

>
>> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>> ---
>>  drivers/of/of_reserved_mem.c    | 77 +++++++++++++++++++++------------
>>  include/linux/of_reserved_mem.h |  2 +-
>>  kernel/dma/coherent.c           |  8 ++--
>>  kernel/dma/contiguous.c         |  8 ++--
>>  kernel/dma/swiotlb.c            | 10 ++---
>>  5 files changed, 64 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>> index 0aba366eba59..68d1f4cca4bb 100644
>> --- a/drivers/of/of_reserved_mem.c
>> +++ b/drivers/of/of_reserved_mem.c
>> @@ -99,7 +99,7 @@ static void __init alloc_reserved_mem_array(void)
>>  /*
>>   * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
>>   */
>> -static void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
>> +static void __init fdt_reserved_mem_save_node(struct device_node *node, const char *uname,
>>                                               phys_addr_t base, phys_addr_t size)
>>  {
>>         struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
>> @@ -109,7 +109,7 @@ static void __init fdt_reserved_mem_save_node(unsigned long node, const char *un
>>                 return;
>>         }
>>
>> -       rmem->fdt_node = node;
>> +       rmem->dev_node = node;
>>         rmem->name = uname;
>>         rmem->base = base;
>>         rmem->size = size;
>> @@ -178,11 +178,11 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>>  }
>>
>>  /*
>> - * __reserved_mem_check_root() - check if #size-cells, #address-cells provided
>> + * __fdt_reserved_mem_check_root() - check if #size-cells, #address-cells provided
>>   * in /reserved-memory matches the values supported by the current implementation,
>>   * also check if ranges property has been provided
>>   */
>> -static int __init __reserved_mem_check_root(unsigned long node)
>> +static int __init __fdt_reserved_mem_check_root(unsigned long node)
>>  {
>>         const __be32 *prop;
>>
>> @@ -200,6 +200,29 @@ static int __init __reserved_mem_check_root(unsigned long node)
>>         return 0;
>>  }
>>
>> +/*
>> + * __dt_reserved_mem_check_root() - check if #size-cells, #address-cells provided
>> + * in /reserved-memory matches the values supported by the current implementation,
>> + * also check if ranges property has been provided
>> + */
>> +static int __init __dt_reserved_mem_check_root(struct device_node *node)
> The normal prefix is 'of', not 'dt'. Weird, right?, but it dates back
> to OpenFirmware.
Got it! I will follow the same for the functions that I renamed in Patch 04 as well.
>
>> +{
>> +       const __be32 *prop;
>> +
>> +       prop = of_get_property(node, "#size-cells", NULL);
> Throughout, use the appropriate typed function. Here for example,
> of_property_read_u32().
ack.
>
>> +       if (!prop || be32_to_cpup(prop) != dt_root_size_cells)
>> +               return -EINVAL;
>> +
>> +       prop = of_get_property(node, "#address-cells", NULL);
>> +       if (!prop || be32_to_cpup(prop) != dt_root_addr_cells)
>> +               return -EINVAL;
>> +
>> +       prop = of_get_property(node, "ranges", NULL);
> Or for presence, just of_property_present().
ack.
>
>> +       if (!prop)
>> +               return -EINVAL;
>> +       return 0;
>> +}
>> +
>>  /**
>>   * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
>>   * reserved memory regions.
>> @@ -213,33 +236,38 @@ static int __init __reserved_mem_check_root(unsigned long node)
>>  static void __init fdt_scan_reserved_mem_reg_nodes(void)
>>  {
>>         int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
>> -       const void *fdt = initial_boot_params;
>> +       struct device_node *node, *child;
>>         phys_addr_t base, size;
>>         const __be32 *prop;
>> -       int node, child;
>>         int len;
>>
>> -       node = fdt_path_offset(fdt, "/reserved-memory");
>> -       if (node < 0) {
>> +       node = of_find_node_by_path("/reserved-memory");
>> +       if (!node) {
>>                 pr_info("Reserved memory: No reserved-memory node in the DT\n");
>>                 return;
>>         }
>>
>> -       if (__reserved_mem_check_root(node)) {
>> +       if (__dt_reserved_mem_check_root(node)) {
>>                 pr_err("Reserved memory: unsupported node format, ignoring\n");
>>                 return;
>>         }
>>
>> -       fdt_for_each_subnode(child, fdt, node) {
>> +       for_each_child_of_node(node, child) {
>>                 const char *uname;
>> +               struct reserved_mem *rmem;
>>
>> -               prop = of_get_flat_dt_prop(child, "reg", &len);
>> -               if (!prop)
>> +               if (!of_device_is_available(child))
>>                         continue;
>> -               if (!of_fdt_device_is_available(fdt, child))
>> +
>> +               prop = of_get_property(child, "reg", &len);
> We have specific unflattened functions for reading 'reg'. Note that
> you should use the 'translated' ones even though we have a check to
> disallow any real translation. That restriction should be fixed at
> some point.
"of_address_to_resource()" seems to be a function that reads the 'reg' property
the way you are describing here. I'll switch to that function and see how it works!

Please let me know if you had another function in mind for me to use here.
>
>> +               if (!prop) {
>> +                       rmem = of_reserved_mem_lookup(child);
>> +                       if (rmem)
>> +                               rmem->dev_node = child;
>>                         continue;
>> +               }
>>
>> -               uname = fdt_get_name(fdt, child, NULL);
>> +               uname = of_node_full_name(child);
>>                 if (len && len % t_len != 0) {
>>                         pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
>>                                uname);
>> @@ -269,7 +297,7 @@ int __init fdt_scan_reserved_mem(void)
>>         if (node < 0)
>>                 return -ENODEV;
>>
>> -       if (__reserved_mem_check_root(node) != 0) {
>> +       if (__fdt_reserved_mem_check_root(node) != 0) {
>>                 pr_err("Reserved memory: unsupported node format, ignoring\n");
>>                 return -EINVAL;
>>         }
>> @@ -447,7 +475,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
>>                        uname, (unsigned long)(size / SZ_1M));
>>                 return -ENOMEM;
>>         }
>> -       fdt_reserved_mem_save_node(node, uname, base, size);
>> +       fdt_reserved_mem_save_node(NULL, uname, base, size);
>>         return 0;
>>  }
>>
>> @@ -467,7 +495,7 @@ static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
>>                 reservedmem_of_init_fn initfn = i->data;
>>                 const char *compat = i->compatible;
>>
>> -               if (!of_flat_dt_is_compatible(rmem->fdt_node, compat))
>> +               if (!of_device_is_compatible(rmem->dev_node, compat))
>>                         continue;
>>
>>                 ret = initfn(rmem);
>> @@ -500,11 +528,6 @@ static int __init __rmem_cmp(const void *a, const void *b)
>>         if (ra->size > rb->size)
>>                 return 1;
>>
>> -       if (ra->fdt_node < rb->fdt_node)
>> -               return -1;
>> -       if (ra->fdt_node > rb->fdt_node)
>> -               return 1;
>> -
>>         return 0;
>>  }
>>
>> @@ -551,16 +574,16 @@ void __init fdt_init_reserved_mem(void)
>>
>>         for (i = 0; i < reserved_mem_count; i++) {
>>                 struct reserved_mem *rmem = &reserved_mem[i];
>> -               unsigned long node = rmem->fdt_node;
>> +               struct device_node *node = rmem->dev_node;
>>                 int len;
>>                 const __be32 *prop;
>>                 int err = 0;
>>                 bool nomap;
>>
>> -               nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
>> -               prop = of_get_flat_dt_prop(node, "phandle", &len);
>> +               nomap = of_get_property(node, "no-map", NULL) != NULL;
>> +               prop = of_get_property(node, "phandle", &len);
> We store the phandle in struct device_node, so reading and storing it
> here shouldn't be needed I think.
ack.
>
>>                 if (!prop)
>> -                       prop = of_get_flat_dt_prop(node, "linux,phandle", &len);
>> +                       prop = of_get_property(node, "linux,phandle", &len);
>>                 if (prop)
>>                         rmem->phandle = of_read_number(prop, len/4);
>>
>> @@ -574,7 +597,7 @@ void __init fdt_init_reserved_mem(void)
>>                 } else {
>>                         phys_addr_t end = rmem->base + rmem->size - 1;
>>                         bool reusable =
>> -                               (of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
>> +                               (of_get_property(node, "reusable", NULL)) != NULL;
>>
>>                         pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
>>                                 &rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
>> diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
>> index 4de2a24cadc9..b6107a18d170 100644
>> --- a/include/linux/of_reserved_mem.h
>> +++ b/include/linux/of_reserved_mem.h
>> @@ -10,7 +10,7 @@ struct reserved_mem_ops;
>>
>>  struct reserved_mem {
>>         const char                      *name;
>> -       unsigned long                   fdt_node;
>> +       struct device_node              *dev_node;
>>         unsigned long                   phandle;
>>         const struct reserved_mem_ops   *ops;
>>         phys_addr_t                     base;
>> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
>> index ff5683a57f77..0db0aae83102 100644
>> --- a/kernel/dma/coherent.c
>> +++ b/kernel/dma/coherent.c
>> @@ -362,20 +362,20 @@ static const struct reserved_mem_ops rmem_dma_ops = {
>>
>>  static int __init rmem_dma_setup(struct reserved_mem *rmem)
>>  {
>> -       unsigned long node = rmem->fdt_node;
>> +       struct device_node *node = rmem->dev_node;
>>
>> -       if (of_get_flat_dt_prop(node, "reusable", NULL))
>> +       if (of_get_property(node, "reusable", NULL))
>>                 return -EINVAL;
>>
>>  #ifdef CONFIG_ARM
>> -       if (!of_get_flat_dt_prop(node, "no-map", NULL)) {
>> +       if (!of_get_property(node, "no-map", NULL)) {
> While you are here, convert this to IS_ENABLED():
>
> if (IS_ENABLED(CONFIG_ARM) && !of_property_read_bool(node)) {
>   ...
> }
ack.


Thank you for your feedback!

Oreoluwa

