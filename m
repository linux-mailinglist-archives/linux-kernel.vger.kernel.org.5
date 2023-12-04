Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109BF802AD4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 05:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjLDES5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 23:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDESz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 23:18:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB66D5;
        Sun,  3 Dec 2023 20:19:01 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B44C9X9014543;
        Mon, 4 Dec 2023 04:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZsDGkJSdSvK8hXzGIcTgchroJYDSrqFpKaJKqePNBYY=;
 b=B71R2AE3avwD6aM6InEDj4hTMIV0eXmskdvAd8D58hoHyvLP4O4XYarSiaVlWriZXE2b
 F1CbU2kzv4ECj1TYf2UE3jPD76XkXiXkc96HZdwkdzcUMOeGKCbyZiOZE9JzYaKsjotY
 fnpNxigOAwBIVnhyTUBRTOg85xo0S3OTSv4D10bx2oQXtJ5j+Dv0nvnNlAwAzU0N08ft
 9BFzbilm23wJV7ujio4FWKLzCfmqtNKqql3GxATKEUwIagl+q7cRFiMgmnpVjWN9YKDO
 U2PJTzpUHa0/B1P0KAH7hn2eMFXuWTtMjvwGBWiGYim56rS455iQL6AJMQQ/BHnKv9YJ +g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqv672wvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 04:18:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B44ITvU028660
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 04:18:29 GMT
Received: from [10.110.9.118] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 3 Dec
 2023 20:18:26 -0800
Message-ID: <ef20a676-cf56-499d-bb99-ed271a1691d4@quicinc.com>
Date:   Sun, 3 Dec 2023 20:18:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] of: reserved_mem: Change the order that
 reserved_mem regions are stored
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <frowand.list@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>
References: <20231019184825.9712-1-quic_obabatun@quicinc.com>
 <20231019184825.9712-2-quic_obabatun@quicinc.com>
 <20231024193210.GA407269-robh@kernel.org>
From:   Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <20231024193210.GA407269-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cuYkVsclmXvWYSGGRZVrhRNSWo1GvDBG
X-Proofpoint-GUID: cuYkVsclmXvWYSGGRZVrhRNSWo1GvDBG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1011 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312040031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/24/2023 12:32 PM, Rob Herring wrote:
> On Thu, Oct 19, 2023 at 11:48:23AM -0700, Oreoluwa Babatunde wrote:
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
> Looking at this a bit more...
>
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
>>  	paging_init();
>>  
>> +	fdt_init_reserved_mem();
>> +
>>  	acpi_table_upgrade();
>>  
>>  	/* Parse the ACPI tables for possible boot-time configuration */
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index bf502ba8da95..d51a1176a7b9 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -504,7 +504,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>>  	phys_addr_t base, size;
>>  	int len;
>>  	const __be32 *prop;
>> -	int first = 1;
>>  	bool nomap;
>>  
>>  	prop = of_get_flat_dt_prop(node, "reg", &len);
>> @@ -532,10 +531,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>>  			       uname, &base, (unsigned long)(size / SZ_1M));
>>  
>>  		len -= t_len;
>> -		if (first) {
>> -			fdt_reserved_mem_save_node(node, uname, base, size);
>> -			first = 0;
>> -		}
>>  	}
>>  	return 0;
>>  }
>> @@ -564,9 +559,44 @@ static int __init __reserved_mem_check_root(unsigned long node)
>>  }
>>  
>>  /*
>> - * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
>> + * Save the reserved_mem reg nodes in the reserved_mem array
>>   */
>> -static int __init fdt_scan_reserved_mem(void)
>> +static void save_reserved_mem_reg_nodes(unsigned long node, const char *uname)
>> +
>> +{
>> +	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
>> +	phys_addr_t base, size;
>> +	int len;
>> +	const __be32 *prop;
>> +
>> +	prop = of_get_flat_dt_prop(node, "reg", &len);
>> +	if (!prop)
>> +		return;
>> +
>> +	if (len && len % t_len != 0) {
>> +		pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
>> +		       uname);
>> +		return;
>> +	}
>> +	base = dt_mem_next_cell(dt_root_addr_cells, &prop);
>> +	size = dt_mem_next_cell(dt_root_size_cells, &prop);
>> +
>> +	if (size)
>> +		fdt_reserved_mem_save_node(node, uname, base, size);
>> +}
>> +
>> +/*
>> + * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory.
>> + * @save_only: Option to determine what kind of fdt scan the caller is
>> + * requesting.
>> + *
>> + * The fdt is scanned twice here during device bootup. The first scan
>> + * is used to save the dynamically allocated reserved memory regions to
>> + * the reserved_mem array. The second scan is used to save the 'reg'
>> + * defined regions to the array. @save_only indicates which of the scans
>> + * the caller is requesting.
>> + */
>> +int __init fdt_scan_reserved_mem(bool save_only)
> It's generally discouraged to use flags to make a function do 2 
> different operations. Splitting it will naturally happen though with my 
> next comment.
>
>>  {
>>  	int node, child;
>>  	const void *fdt = initial_boot_params;
>> @@ -589,9 +619,14 @@ static int __init fdt_scan_reserved_mem(void)
>>  
>>  		uname = fdt_get_name(fdt, child, NULL);
>>  
>> +		if (save_only) {
>> +			save_reserved_mem_reg_nodes(child, uname);
>> +			continue;
>> +		}
>> +
>>  		err = __reserved_mem_reserve_reg(child, uname);
>>  		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
>> -			fdt_reserved_mem_save_node(child, uname, 0, 0);
>> +			__reserved_mem_alloc_size(child, uname);
>>  	}
>>  	return 0;
>>  }
>> @@ -631,11 +666,12 @@ void __init early_init_fdt_scan_reserved_mem(void)
>>  {
>>  	int n;
>>  	u64 base, size;
>> +	bool save_only = false;
>>  
>>  	if (!initial_boot_params)
>>  		return;
>>  
>> -	fdt_scan_reserved_mem();
>> +	fdt_scan_reserved_mem(save_only);
>>  	fdt_reserve_elfcorehdr();
>>  
>>  	/* Process header /memreserve/ fields */
>> @@ -645,8 +681,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
>>  			break;
>>  		memblock_reserve(base, size);
>>  	}
>> -
>> -	fdt_init_reserved_mem();
>>  }
>>  
>>  /**
>> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
>> index f38397c7b582..e52b27b8392d 100644
>> --- a/drivers/of/of_private.h
>> +++ b/drivers/of/of_private.h
>> @@ -175,7 +175,6 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
>>  }
>>  #endif
>>  
>> -void fdt_init_reserved_mem(void);
>>  void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
>>  			       phys_addr_t base, phys_addr_t size);
>>  
>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>> index 7ec94cfcbddb..13e694f5e316 100644
>> --- a/drivers/of/of_reserved_mem.c
>> +++ b/drivers/of/of_reserved_mem.c
>> @@ -132,8 +132,7 @@ static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
>>   * __reserved_mem_alloc_size() - allocate reserved memory described by
>>   *	'size', 'alignment'  and 'alloc-ranges' properties.
>>   */
>> -static int __init __reserved_mem_alloc_size(unsigned long node,
>> -	const char *uname, phys_addr_t *res_base, phys_addr_t *res_size)
>> +int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
>>  {
>>  	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
>>  	phys_addr_t start = 0, end = 0;
>> @@ -212,10 +211,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
>>  		       uname, (unsigned long)(size / SZ_1M));
>>  		return -ENOMEM;
>>  	}
>> -
>> -	*res_base = base;
>> -	*res_size = size;
>> -
>> +	fdt_reserved_mem_save_node(node, uname, base, size);
>>  	return 0;
>>  }
>>  
>> @@ -309,6 +305,9 @@ static void __init __rmem_check_for_overlap(void)
>>  void __init fdt_init_reserved_mem(void)
>>  {
>>  	int i;
>> +	bool save_only = true;
>> +
>> +	fdt_scan_reserved_mem(save_only);
> This is now called just before unflattening. Why can't it be done right 
> after unflattening instead. Then we can use the unflattened API rather 
> than the flatten API which is less efficient.
>
> Rob

Hi Rob,

My apologies for the delayed response.
I was able to implement the use of the unflattened devicetree APIs to
scan through the DT after paging_init() as per one of your comments.

Regarding your second comment, I moved the call to
fdt_init_reserved_mem() into the unflatten_device_tree() function
to remove the dependency of the DT code on the arch specific code.

This was an easy change for the arm64 arch which I am currently working
with, but some other archs needed an additional change for this to work.
I noticed that some other archs have the ordering reversed for how
paging_init() and unflatten_device_tree() are called.

These are the archs which have the call order reversed:
nios2, loongarch, mips, openrisc, powerpc, sh, um, xtensa.

Since the order in which paging_init() and fdt_init_reserved_mem() are
called is important for this series to work, moving the call to
fdt_init_reserved_mem() into the unflatten_device_tree() function would
have broken for the above mentioned architectures.

Hence, in my v2 rfc patch, I have changed the order in which
paging_init() and unflatten_device_tree() functions are called for the
above mentioned archs to make unflatten_device_tree() be called
after paging_init().

Regards,

Oreoluwa
