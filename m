Return-Path: <linux-kernel+bounces-61702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E79B8851588
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F1F1C2312E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EA73D0D2;
	Mon, 12 Feb 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RB42Sh0O"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E9B3A269;
	Mon, 12 Feb 2024 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744891; cv=none; b=BMXnBYE7Dn4PP/ShCv6EYNptE1OcAlTnqVll1cjOYEO9Z34FjhZrDW0bOGbMrXfPvqu72oRwGT5buDwGYDBCBe8yDz5VrFhktTyFTJFtm6G6aGmnwWJ1Z6mZzbHWXocu/vTXOtBCTdsPdYOoYuxS2Oc65i1d/lnXzl07j5PDIV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744891; c=relaxed/simple;
	bh=uj5lO9sR/UE9wfGXJBX4nqEd4xreNOkRWIOk6TK60AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hTycqtKDJM/GuOf7DkrUtjsqXuuF13waYh5O59bAS+YcW8DPbBwDKv/YF+tZFZ9on5I/IzcKhASuqjlkk6Rd1t32454KXczJCSjexTKkCjzJX/aeYyF3FOhP7jlGVOzHFQVj0W9gkYBLVU+OjncK5dfp3SLrXJKxXobUjdhrFtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RB42Sh0O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CCbig5001434;
	Mon, 12 Feb 2024 13:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tJYyhClptr3AVB4G3zUwMsQ3DzI0++wyFJEJgpmpjt4=; b=RB
	42Sh0OQ2u939R6FEiTivpGnJSsSoae8i5IG1sBKc5pm3QY63W3OUX8elPiqqbGlZ
	0lkuCmCRALKWT1SzIppD9jwN1i6O88mznTHoJUG9MI4s0DIGJLq4Z6dn+jfiHQrt
	5vqFeJILielzIyH8ryXOYO15mssUjJAsSzj9DggS0tJYqDaE5MQoUaDsm0eSE65n
	P9HBubd9BehN+ecuC3zwgKdBs5A5wURmwOBTUpmw69lByUYvOr3vqeWzSqd4r7MI
	IDilzrV4MbJhYO7qRrauEE0FISLzZcBJXMDVt6ECJTV9MC4eFBYpQ32Qw641qRhS
	bK7kdASdATQggvRAyqZQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w62kt3gw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 13:34:19 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CDYIEZ006688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 13:34:18 GMT
Received: from [10.216.4.37] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 05:34:07 -0800
Message-ID: <45b5a4d3-b79f-aa66-67e9-2a57bbfb938e@quicinc.com>
Date: Mon, 12 Feb 2024 19:04:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 08/10] pstore/ram: Add dynamic ramoops region support
 through commandline
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>,
        <corbet@lwn.net>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <mathieu.poirier@linaro.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <matthias.bgg@gmail.com>, <kgene@kernel.org>,
        <alim.akhtar@samsung.com>, <bmasney@redhat.com>
References: <20240131110837.14218-1-quic_mojha@quicinc.com>
 <20240131110837.14218-9-quic_mojha@quicinc.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240131110837.14218-9-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b7zju1zBsjqMdLQtdXyPhmNeRZtQu4wR
X-Proofpoint-ORIG-GUID: b7zju1zBsjqMdLQtdXyPhmNeRZtQu4wR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_09,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120103

Hi @Kees/@Tony/@Guilherme,

Wanted to get your early feedback, especially on 8th and 9th patch.
please suggest.

-Mukesh

On 1/31/2024 4:38 PM, Mukesh Ojha wrote:
> The reserved memory region for ramoops is assumed to be at a fixed
> and known location when read from the devicetree. This may not be
> required for something like Qualcomm's minidump which is interested
> in knowing addresses of ramoops region but it does not put hard
> requirement of address being fixed as most of its SoC does not
> support warm reset and does not use pstorefs at all instead it has
> firmware way of collecting ramoops region if it gets to know the
> address and register it with apss minidump table which is sitting
> in shared memory region in DDR and firmware will have access to
> these table during reset and collects it on crash of SoC.
> 
> So, add the support of reserving ramoops region to be dynamically
> allocated early during boot if it is request through command line
> via 'dyn_ramoops_size=<size>' and fill up reserved resource structure
> and export the structure, so that it can be read by ramoops driver.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   Documentation/admin-guide/ramoops.rst | 23 +++++++++-
>   fs/pstore/Kconfig                     | 15 ++++++
>   fs/pstore/ram.c                       | 66 +++++++++++++++++++++++++--
>   include/linux/pstore_ram.h            |  5 ++
>   init/main.c                           |  3 ++
>   5 files changed, 108 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
> index e9f85142182d..6de61002f9e9 100644
> --- a/Documentation/admin-guide/ramoops.rst
> +++ b/Documentation/admin-guide/ramoops.rst
> @@ -33,6 +33,13 @@ memory are implementation defined, and won't work on many ARMs such as omaps.
>   Setting ``mem_type=2`` attempts to treat the memory region as normal memory,
>   which enables full cache on it. This can improve the performance.
>   
> +Ramoops supports its memory to be allocated dynamically during early boot
> +for plaforms that do not have support for warm boot i.e., no assurance
> +that Ram content will be preserved across boot and for these platforms
> +giving static Ramoops memory is not necessary as it has separate backend
> +mechanism to retrieve ramoops content on system failure. More about
> +how to enable Dynamic ramoops in ``Setting the parameters`` A.b section.
> +
>   The memory area is divided into ``record_size`` chunks (also rounded down to
>   power of two) and each kmesg dump writes a ``record_size`` chunk of
>   information.
> @@ -59,7 +66,7 @@ Setting the parameters
>   
>   Setting the ramoops parameters can be done in several different manners:
>   
> - A. Use the module parameters (which have the names of the variables described
> + A.a  Use the module parameters (which have the names of the variables described
>    as before). For quick debugging, you can also reserve parts of memory during
>    boot and then use the reserved memory for ramoops. For example, assuming a
>    machine with > 128 MB of memory, the following kernel command line will tell
> @@ -68,6 +75,20 @@ Setting the ramoops parameters can be done in several different manners:
>   
>   	mem=128M ramoops.mem_address=0x8000000 ramoops.ecc=1
>   
> + A.b  Ramoops memory can be also be dynamically reserved by Kernel and in such
> + scenario ``mem_address`` i.e., Ramoops base address can be anywhere in the RAM
> + instead of being fixed and predefined. A separate command line option
> + ``dyn_ramoops_size=<size>`` and kernel config CONFIG_PSTORE_DYNAMIC_RAMOOPS
> + are provided to facilitate Dynamic Ramoops memory reservation during early boot.
> + The command line option and the config should only be used in the presence of
> + separate backend which knows how to recover Dynamic Ramoops region otherwise
> + regular ramoops functionality will be impacted.
> + ``mem_size`` should not be used if Dynamic Ramoops support is requested and if
> + both are given ``mem_size`` value is overwritten with ``dyn_ramoops_size`` value
> + i.e., Dynamic Ramoops takes precedence::
> +
> +	dyn_ramoops_size=2M ramoops.console_size=2097152
> +
>    B. Use Device Tree bindings, as described in
>    ``Documentation/devicetree/bindings/reserved-memory/ramoops.yaml``.
>    For example::
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 3acc38600cd1..b8bdbd2f0e73 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -81,6 +81,21 @@ config PSTORE_RAM
>   
>   	  For more information, see Documentation/admin-guide/ramoops.rst.
>   
> +config PSTORE_DYNAMIC_RAMOOPS
> +	bool "Reserve ramoops region dynamically"
> +	select PSTORE_RAM
> +	help
> +	  This enables the dynamic reservation of ramoops region for a special case
> +	  where there is no need to access the logs from pstorefs on next boot;
> +	  instead there is separate backend mechanism like minidump present which has
> +	  awareness about the dynamic ramoops region and can recover the logs. This is
> +	  enabled via command line parameter dyn_ramoops_size=<size> and should not be
> +	  used in absence of separate backend which knows how to recover this dynamic
> +	  region.
> +
> +	  Note whenever this config is selected ramoops driver will be built statically
> +	  into kernel.
> +
>   config PSTORE_ZONE
>   	tristate
>   	depends on PSTORE
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 88b34fdbf759..1faf0835700b 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -20,6 +20,7 @@
>   #include <linux/compiler.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> +#include <linux/memblock.h>
>   #include <linux/mm.h>
>   
>   #include "internal.h"
> @@ -103,6 +104,59 @@ struct ramoops_context {
>   };
>   
>   static struct platform_device *dummy;
> +static struct resource dyn_ramoops_res = {
> +	.name  = "ramoops",
> +	.start = 0,
> +	.end   = 0,
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_NONE,
> +};
> +static int dyn_ramoops_size;
> +
> +#ifdef CONFIG_PSTORE_DYNAMIC_RAMOOPS
> +static int __init parse_dyn_ramoops_size(char *p)
> +{
> +	char *tmp;
> +
> +	dyn_ramoops_size = memparse(p, &tmp);
> +	if (p == tmp) {
> +		pr_err("ramoops: memory size expected\n");
> +		dyn_ramoops_size = 0;
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +early_param("dyn_ramoops_size", parse_dyn_ramoops_size);
> +
> +/*
> + * setup_dynamic_ramoops() - Reserve memory for dynamic ramoops
> + *
> + * Enables dynamic reserve memory support for ramoops through
> + * command line.
> + */
> +void __init setup_dynamic_ramoops(void)
> +{
> +	unsigned long long ramoops_base;
> +	unsigned long long ramoops_size;
> +
> +	if (!dyn_ramoops_size)
> +		return;
> +
> +	ramoops_base = memblock_phys_alloc_range(dyn_ramoops_size, SMP_CACHE_BYTES,
> +						 0, MEMBLOCK_ALLOC_NOLEAKTRACE);
> +	if (!ramoops_base) {
> +		pr_err("cannot allocate ramoops dynamic memory (size:0x%llx).\n",
> +			ramoops_size);
> +		dyn_ramoops_size = 0;
> +		return;
> +	}
> +
> +	dyn_ramoops_res.start = ramoops_base;
> +	dyn_ramoops_res.end = ramoops_base + dyn_ramoops_size - 1;
> +	insert_resource(&iomem_resource, &dyn_ramoops_res);
> +}
> +#endif
>   
>   static int ramoops_pstore_open(struct pstore_info *psi)
>   {
> @@ -915,13 +969,19 @@ static void __init ramoops_register_dummy(void)
>   
>   	/*
>   	 * Prepare a dummy platform data structure to carry the module
> -	 * parameters. If mem_size isn't set, then there are no module
> -	 * parameters, and we can skip this.
> +	 * parameters.
> +	 *
> +	 * dyn_ramoops_size takes precedence over mem_size if it is
> +	 * enabled and valid.
>   	 */
> -	if (!mem_size)
> +	if (!dyn_ramoops_size && !mem_size)
>   		return;
>   
>   	pr_info("using module parameters\n");
> +	if (dyn_ramoops_size) {
> +		mem_size = dyn_ramoops_size;
> +		mem_address = dyn_ramoops_res.start;
> +	}
>   
>   	memset(&pdata, 0, sizeof(pdata));
>   	pdata.mem_size = mem_size;
> diff --git a/include/linux/pstore_ram.h b/include/linux/pstore_ram.h
> index 9d65ff94e216..1efff7a38333 100644
> --- a/include/linux/pstore_ram.h
> +++ b/include/linux/pstore_ram.h
> @@ -39,4 +39,9 @@ struct ramoops_platform_data {
>   	struct persistent_ram_ecc_info ecc_info;
>   };
>   
> +#ifdef CONFIG_PSTORE_DYNAMIC_RAMOOPS
> +void __init setup_dynamic_ramoops(void);
> +#else
> +static inline void __init setup_dynamic_ramoops(void) {}
> +#endif
>   #endif
> diff --git a/init/main.c b/init/main.c
> index ef3ce41b8fc5..3d74241bcb2b 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -99,6 +99,8 @@
>   #include <linux/init_syscalls.h>
>   #include <linux/stackdepot.h>
>   #include <linux/randomize_kstack.h>
> +#include <linux/moduleloader.h>
> +#include <linux/pstore_ram.h>
>   #include <net/net_namespace.h>
>   
>   #include <asm/io.h>
> @@ -890,6 +892,7 @@ void start_kernel(void)
>   	pr_notice("%s", linux_banner);
>   	early_security_init();
>   	setup_arch(&command_line);
> +	setup_dynamic_ramoops();
>   	setup_boot_config();
>   	setup_command_line(command_line);
>   	setup_nr_cpu_ids();

