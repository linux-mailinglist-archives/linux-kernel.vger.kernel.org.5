Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D412C79A2C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjIKFX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjIKFXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:23:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A331AE;
        Sun, 10 Sep 2023 22:23:20 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B5B9o4021297;
        Mon, 11 Sep 2023 05:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=lkyvSTifW8hwqAfyZDZUScLKkb5MVZe0rb+UU4sdYas=;
 b=lXLfO7kbd+7Zmm/zQ/9xPjqmdgt/FtW9iLEsNNrdHueNLfwsm8JDi+6NANCfICox1p2r
 FXWlioQXMIdweHAMD0LRMlw/W0izncPZHierx43xAZJAaI7EAgx24ab10c2AfiSmnhYP
 UOb9KwVjbU8UQfjmyw3l3IkmYfFfTQK2g1Q2y8dPjgnsjXnU2yQt+cbTthpbXRuZ0LCL
 kXfti9pS+aq65Tb1HIfj5qR+bV60dtN2zDj2r1XlriS6BXMFKdMNp6yWSyoLAu1OWdzu
 iNV6Zgtu8rIsyl2tL+07cjvAlwUR3Dul+C6stLOnxg3gVkv4Zket7VXbs1+xPZKfQqbz Tw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0edmjyew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 05:22:42 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38B5Mfjs020917
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 05:22:41 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 10 Sep 2023 22:22:29 -0700
Date:   Mon, 11 Sep 2023 10:52:26 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>
Subject: Re: [PATCH v5 08/17] arm64: mm: Add dynamic ramoops region support
 through command line
Message-ID: <8b0d2b06-70ae-4afa-bd04-13eaa4280c03@quicinc.com>
References: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
 <1694290578-17733-9-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1694290578-17733-9-git-send-email-quic_mojha@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -pc2VDeTkrg7_ECaO77KCjJGShGVo8GQ
X-Proofpoint-GUID: -pc2VDeTkrg7_ECaO77KCjJGShGVo8GQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 01:46:09AM +0530, Mukesh Ojha wrote:
> The reserved memory region for ramoops is assumed to be at a fixed
> and known location when read from the devicetree. This may not be
> required for something like Qualcomm's minidump which is interested
> in knowing addresses of ramoops region but it does not put hard
> requirement of address being fixed as most of it's SoC does not
> support warm reset and does not use pstorefs at all instead it has
> firmware way of collecting ramoops region if it gets to know the
> address and register it with apss minidump table which is sitting
> in shared memory region in DDR and firmware will have access to
> these table during reset and collects it on crash of SoC.
> 
> So, add the support of reserving ramoops region to be dynamically
> allocated early during boot if it is request through command line
> via 'dyn_ramoops_size=' and fill up reserved resource structure and
> export the structure, so that it can be read by ramoops driver.
> 

This needs to be documented at
Documentation/admin-guide/kernel-parameters.txt

> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  arch/arm64/mm/init.c       | 94 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pstore_ram.h |  2 +
>  2 files changed, 96 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index d31c3a9290c5..14d7086758bf 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -31,6 +31,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/acpi_iort.h>
>  #include <linux/kmemleak.h>
> +#include <linux/pstore_ram.h>
>  
>  #include <asm/boot.h>
>  #include <asm/fixmap.h>
> @@ -73,6 +74,93 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
>  
>  #define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
>  
> +#define RAMOOPS_ADDR_HIGH_MAX		(PHYS_MASK + 1)
> +
> +/* Location of the reserved area for the dynamic ramoops */
> +struct resource dyn_ramoops_res = {
> +	.name  = "ramoops",
> +	.start = 0,
> +	.end   = 0,
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_NONE,
> +};
> +EXPORT_SYMBOL(dyn_ramoops_res);

Use EXPORT_SYMBOL_GPL.

> +
> +static int __init parse_dynamic_ramoops(char *cmdline, unsigned long long *size)
> +{
> +	const char *name = "dyn_ramoops_size=";
> +	char *p = NULL;
> +	char *q = NULL;
> +	char *tmp;
> +
> +	if (!cmdline)
> +		return -ENOENT;
> +
> +	/* Check for "dyn_ramoops_size" and use the later if there are more */
> +	p = strstr(cmdline, name);
> +	while (p) {
> +		q = p;
> +		p = strchr(p, ' ');
> +		if (!p)
> +			break;
> +
> +		p = strstr(p + 1, name);
> +	}
> +
> +	if (!q) {
> +		pr_err("ramoops: No entry found for %s\n", name);
> +		return -ENOENT;
> +	}
> +
> +	p = q + strlen(name);
> +	*size = memparse(p, &tmp);
> +	if (p == tmp) {
> +		pr_err("ramoops: memory value expected\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init parse_dyn_ramoops_size_dummy(char *arg)
> +{
> +	return 0;
> +}
> +early_param("dyn_ramoops_size", parse_dyn_ramoops_size_dummy);
> +

Any reason why we can't parse and cache the size in early param handler
it self?

> +/*
> + * reserve_dynamic_ramoops() - reserves memory for dynamic ramoops
> + *
> + * This enable dynamic reserve memory support for ramoops through
> + * command line.
> + */
> +static void __init reserve_dynamic_ramoops(void)
> +{
> +	char *cmdline = boot_command_line;
> +	unsigned long long ramoops_base;
> +	unsigned long long ramoops_size;
> +
> +	if (!IS_ENABLED(CONFIG_PSTORE_RAM))
> +		return;
> +

Should not most part of this patch be under CONFIG_PSTORE_RAM?

> +	if (parse_dynamic_ramoops(cmdline, &ramoops_size))
> +		return;
> +
> +	ramoops_base = memblock_phys_alloc_range(ramoops_size, SMP_CACHE_BYTES,
> +						 0, RAMOOPS_ADDR_HIGH_MAX);

It may be appropriate to use one of MEMBLOCK_ALLOC_xxx flags for the end
marker.

> +	if (!ramoops_base) {
> +		pr_err("cannot allocate ramoops dynamic memory (size:0x%llx).\n",
> +			ramoops_size);
> +		return;
> +	}
> +
> +	kmemleak_ignore_phys(ramoops_base);

Looks like you need MEMBLOCK_ALLOC_NOLEAKTRACE

> +
> +	dyn_ramoops_res.start = ramoops_base;
> +	dyn_ramoops_res.end = ramoops_base + ramoops_size - 1;
> +	insert_resource(&iomem_resource, &dyn_ramoops_res);
> +}
> +
>  static int __init reserve_crashkernel_low(unsigned long long low_size)
>  {
>  	unsigned long long low_base;
> @@ -456,6 +544,12 @@ void __init bootmem_init(void)
>  	 */
>  	reserve_crashkernel();
>  
> +	/*
> +	 * Reserving ramoops region resource dynamically in case it is
> +	 * requested from command line.
> +	 */
> +	reserve_dynamic_ramoops();
> +
>  	memblock_dump_all();
>  }
>  
> diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
> index 9d65ff94e216..07d700b7649d 100644
> --- a/include/linux/pstore_ram.h
> +++ b/include/linux/pstore_ram.h
> @@ -10,6 +10,8 @@
>  
>  #include <linux/pstore.h>
>  
> +extern struct resource dyn_ramoops_res;
> +

What about other architectures?

>  struct persistent_ram_ecc_info {
>  	int block_size;
>  	int ecc_size;
> -- 
> 2.7.4
> 
