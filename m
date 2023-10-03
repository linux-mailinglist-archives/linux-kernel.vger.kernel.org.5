Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79207B5FAD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjJCEFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 00:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjJCEE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:04:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578CEBF;
        Mon,  2 Oct 2023 21:04:55 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3933poOt006814;
        Tue, 3 Oct 2023 04:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=U7FoVMIUPKVd7swA6cZj6O2sbhpE8R0uUpBw3uYZfDI=;
 b=lT7u6aIzXqJ+LHY06rWvEjO/h3OkyN6pnBvzaZ/o1WB7g8MzUM7phgmcCzKQV0K/iJZm
 g03avU9EUlRrg33MtJYuTG10mkhiXg3NVtQx9sCU82P3T52nOONrt+NPK1arPFQF8v0p
 gqTk3EUybUKPc87/waJVDHOrMK0xHqmaVZ1OMD0cl7H3Zd5RIeJeWiNVPiYDYMLJUm3I
 UTD8T9yleX3P8QHDpwy7PbkmWIH7uKJShGerGlifKXbqvDB2OoLj89pVBw7WRPC0N6Kf
 U9y1/1IYjWMj6K2xWKEsmcTOJh9RDBNI3iiA8/Lb+1Un98rIJksK/9R2PQIsg1RFszJs UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgbe486m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 04:04:22 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3933sauw012675;
        Tue, 3 Oct 2023 04:04:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgbe486hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 04:04:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3931THFL025094;
        Tue, 3 Oct 2023 04:04:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3texcxxufj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 04:04:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39344Hq918285094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Oct 2023 04:04:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FA5320040;
        Tue,  3 Oct 2023 04:04:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0DE020043;
        Tue,  3 Oct 2023 04:04:14 +0000 (GMT)
Received: from [9.109.209.30] (unknown [9.109.209.30])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  3 Oct 2023 04:04:14 +0000 (GMT)
Message-ID: <73bdc58d-edc1-4344-b42a-4b83ca885329@linux.ibm.com>
Date:   Tue, 3 Oct 2023 09:34:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dax/kmem: allow kmem to add memory with
 memmap_on_memory
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>
References: <20230928-vv-kmem_memmap-v4-0-6ff73fec519a@intel.com>
 <20230928-vv-kmem_memmap-v4-2-6ff73fec519a@intel.com>
Content-Language: en-US
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20230928-vv-kmem_memmap-v4-2-6ff73fec519a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AbbWTPc-C8-lXIHv-op9eRtHvv3IMeZt
X-Proofpoint-GUID: BBGCWA_xlo3i5mukOCPNhg8frxODiPgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030032
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/23 2:00 AM, Vishal Verma wrote:
> Large amounts of memory managed by the kmem driver may come in via CXL,
> and it is often desirable to have the memmap for this memory on the new
> memory itself.
> 
> Enroll kmem-managed memory for memmap_on_memory semantics if the dax
> region originates via CXL. For non-CXL dax regions, retain the existing
> default behavior of hot adding without memmap_on_memory semantics.
> 

Are we not looking at doing altmap space for CXL DAX regions? Last discussion around
this was suggesting we look at doing this via altmap reservation so that
we get contigous space for device memory enabling us to map them
via 1G direct mapping entries? 



> Add a sysfs override under the dax device to control this behavior and
> override either default.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  drivers/dax/bus.h         |  1 +
>  drivers/dax/dax-private.h |  1 +
>  drivers/dax/bus.c         | 38 ++++++++++++++++++++++++++++++++++++++
>  drivers/dax/cxl.c         |  1 +
>  drivers/dax/hmem/hmem.c   |  1 +
>  drivers/dax/kmem.c        |  8 +++++++-
>  drivers/dax/pmem.c        |  1 +
>  7 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index 1ccd23360124..cbbf64443098 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -23,6 +23,7 @@ struct dev_dax_data {
>  	struct dev_pagemap *pgmap;
>  	resource_size_t size;
>  	int id;
> +	bool memmap_on_memory;
>  };
>  
>  struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index 27cf2daaaa79..446617b73aea 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -70,6 +70,7 @@ struct dev_dax {
>  	struct ida ida;
>  	struct device dev;
>  	struct dev_pagemap *pgmap;
> +	bool memmap_on_memory;
>  	int nr_range;
>  	struct dev_dax_range {
>  		unsigned long pgoff;
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 0ee96e6fc426..81351eb69884 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -367,6 +367,7 @@ static ssize_t create_store(struct device *dev, struct device_attribute *attr,
>  			.dax_region = dax_region,
>  			.size = 0,
>  			.id = -1,
> +			.memmap_on_memory = false,
>  		};
>  		struct dev_dax *dev_dax = devm_create_dev_dax(&data);
>  
> @@ -1269,6 +1270,40 @@ static ssize_t numa_node_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(numa_node);
>  
> +static ssize_t memmap_on_memory_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct dev_dax *dev_dax = to_dev_dax(dev);
> +
> +	return sprintf(buf, "%d\n", dev_dax->memmap_on_memory);
> +}
> +
> +static ssize_t memmap_on_memory_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct dev_dax *dev_dax = to_dev_dax(dev);
> +	struct dax_region *dax_region = dev_dax->region;
> +	ssize_t rc;
> +	bool val;
> +
> +	rc = kstrtobool(buf, &val);
> +	if (rc)
> +		return rc;
> +
> +	device_lock(dax_region->dev);
> +	if (!dax_region->dev->driver) {
> +		device_unlock(dax_region->dev);
> +		return -ENXIO;
> +	}
> +
> +	dev_dax->memmap_on_memory = val;
> +
> +	device_unlock(dax_region->dev);
> +	return rc == 0 ? len : rc;
> +}
> +static DEVICE_ATTR_RW(memmap_on_memory);
> +
>  static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
>  {
>  	struct device *dev = container_of(kobj, struct device, kobj);
> @@ -1295,6 +1330,7 @@ static struct attribute *dev_dax_attributes[] = {
>  	&dev_attr_align.attr,
>  	&dev_attr_resource.attr,
>  	&dev_attr_numa_node.attr,
> +	&dev_attr_memmap_on_memory.attr,
>  	NULL,
>  };
>  
> @@ -1400,6 +1436,8 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
>  	dev_dax->align = dax_region->align;
>  	ida_init(&dev_dax->ida);
>  
> +	dev_dax->memmap_on_memory = data->memmap_on_memory;
> +
>  	inode = dax_inode(dax_dev);
>  	dev->devt = inode->i_rdev;
>  	dev->bus = &dax_bus_type;
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 8bc9d04034d6..c696837ab23c 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -26,6 +26,7 @@ static int cxl_dax_region_probe(struct device *dev)
>  		.dax_region = dax_region,
>  		.id = -1,
>  		.size = range_len(&cxlr_dax->hpa_range),
> +		.memmap_on_memory = true,
>  	};
>  
>  	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index 5d2ddef0f8f5..b9da69f92697 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -36,6 +36,7 @@ static int dax_hmem_probe(struct platform_device *pdev)
>  		.dax_region = dax_region,
>  		.id = -1,
>  		.size = region_idle ? 0 : range_len(&mri->range),
> +		.memmap_on_memory = false,
>  	};
>  
>  	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index c57acb73e3db..0aa6c45a4e5a 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -12,6 +12,7 @@
>  #include <linux/mm.h>
>  #include <linux/mman.h>
>  #include <linux/memory-tiers.h>
> +#include <linux/memory_hotplug.h>
>  #include "dax-private.h"
>  #include "bus.h"
>  
> @@ -56,6 +57,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  	unsigned long total_len = 0;
>  	struct dax_kmem_data *data;
>  	int i, rc, mapped = 0;
> +	mhp_t mhp_flags;
>  	int numa_node;
>  
>  	/*
> @@ -136,12 +138,16 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		 */
>  		res->flags = IORESOURCE_SYSTEM_RAM;
>  
> +		mhp_flags = MHP_NID_IS_MGID;
> +		if (dev_dax->memmap_on_memory)
> +			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
> +
>  		/*
>  		 * Ensure that future kexec'd kernels will not treat
>  		 * this as RAM automatically.
>  		 */
>  		rc = add_memory_driver_managed(data->mgid, range.start,
> -				range_len(&range), kmem_name, MHP_NID_IS_MGID);
> +				range_len(&range), kmem_name, mhp_flags);
>  
>  		if (rc) {
>  			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
> diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
> index ae0cb113a5d3..f3c6c67b8412 100644
> --- a/drivers/dax/pmem.c
> +++ b/drivers/dax/pmem.c
> @@ -63,6 +63,7 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
>  		.id = id,
>  		.pgmap = &pgmap,
>  		.size = range_len(&range),
> +		.memmap_on_memory = false,
>  	};
>  
>  	return devm_create_dev_dax(&data);
> 

