Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7210A7BABE0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjJEVRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJEVQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:16:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B26B93;
        Thu,  5 Oct 2023 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696540615; x=1728076615;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KKUNAdv13jac4BB+rrLim3ABYe0qmwIUw4zInFneuqk=;
  b=GoEJHcCzG9tccZDNJ5h/OP+daSAE3qfgV7Mcdlyon/lnbZzq3L/8jvgf
   dSIEIivHbdNqfdKeeOqXFBh5r10eBdZ66kKGohzeaBkLZ1rcJn+jrFzUH
   pjaa991gamtHeysLa6HPiGg73FPFBVcl1uwT7pPcqvQL4cQfPfrVKdGlD
   ARHjQjE7PzdAnJfE+bYO6+QIGE3H2OD1Opan4GPJnqPfa8VbVhFSDI/Sn
   FQofjk3ZxSVjiTmG/srns86ZqlteyUKkzk2ndyExYxlbBUMndmLPH3pkG
   AlOdciqe5Dd2Z/jiDSoO/EbH6hKqENBQna1way0NHGQLKQqLhb39mrMHU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2222212"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2222212"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 14:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="1083173835"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="1083173835"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 14:16:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 14:16:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 14:16:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 14:16:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj6YLyN1B3iQAPrQAfgIHf4oV8HopJJmAhhsTQE5enkl2cie6clQLeo8aDN+OuxdacckIQSo0LC7Mj91e5twvy5hQNYEnayssImEiq+ZO+Ur6tzxg00vJwjKXGEWeSEwo/3vf35iiV5+pbCHlMGzWqNZUI7ALOIw+fdt0I6ZuKTPI4uHB/X1mWL/HEwlHQwFDUHBNILLPTksxlKkED9qb63O3lVwR0h8oeHn3oj/SqMSon4VWNkFGkSlXLohEquB4lFOfxZ9pPHUdVgAn2tWBzJfAltv/uwVqOqb8zZyWrYMdWwqMnPHpQqOmXv0R782A8/UdBChjNwA/JqRUsFs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpmtF691GUW7Yesh67Jff9e4kkloAhl0FsH/OFdkD7Y=;
 b=UePYx0SM121Mgow61RqF15bkeyqHJvHQHkTUUNlQfT2RJ39sOGibyB7tphcpUD+hQEpsrS3kzR3OgpCdVL998T6Sl1B3PdnmmzdHstd78Nj98moITsEHmbORONLv6sZWr0OwTz94G1qcey0I5nkQmlepS8Zg2JaptlfFB/Eq7nNHqrm+zspgw7da9qBXc0mkk0Sf0duRAgniZHhV2DBIDBfI2iSfiLAlALFxvN3igrgbuAb+x8/ZHDkAcxc0X7kdLgkfvcZu6M4VjyevwqLgbZeEhrnz7Ge95vDLqu38V3RPIEpIKQjPxCNT71/HD+yTcMIE5+n10tJD9XaI6VKysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB8248.namprd11.prod.outlook.com (2603:10b6:208:447::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 5 Oct
 2023 21:16:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 21:16:48 +0000
Date:   Thu, 5 Oct 2023 14:16:39 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: RE: [PATCH v5 2/2] dax/kmem: allow kmem to add memory with
 memmap_on_memory
Message-ID: <651f27b728fef_ae7e7294b3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
 <20231005-vv-kmem_memmap-v5-2-a54d1981f0a3@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231005-vv-kmem_memmap-v5-2-a54d1981f0a3@intel.com>
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: e938cf14-dfed-4ebe-80ca-08dbc5e8628a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nosHbhXva8zaaC2gQsyCKGUzCD/7IzTvozIg8NPlVPYAMYexCjtGk6OGwyqRQzQUhYHMOfYWcKu52pKUnxJY6OgReZy+elhnEdJ7yx0NsbDeNjx9vV3K4ORYn7w5fYV6q1lVcqVq4gYbXDD09AvDkEsn6+Ss3SK/iexLsHEgjF3D2uVCxbVjy7pbcAhvJdR9AtSFYVx9JJ1NfBLJGLttwNHccxnUK5RxLovwTOL1pV3C2atQG1SOlG+eV6TDLIOKk6hoZukOD5nDnNi57ztPlYjESrd5/fZDg+O+xPdMkkMU6s1AIQpYO9Jv3QEmlHms8ijR2OtlQuvzGjNra+mgN1CzYgNmTj/bHcLr3gYA5kNyO5xfACpXH+TLs/trsWKzOYhW1kiZORYFaChIq7s7Q4Aw2iXhge/KUS2pY4oNvBZE9/1fw8KhZlR7DXXq6hbZ+EGZw4g4IcszXwJwaigXDgeHROJcRqTdi6XQwSinkmSKcFcT3MtKpMEYZP0/53x25BHHxM1O+uAF6S5JvHy4otpbIY/aR1dyBYCrcEckTOGkoSeyUJqeigJO6T9tYyfc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(9686003)(2906002)(6636002)(7416002)(8936002)(6666004)(41300700001)(316002)(8676002)(5660300002)(4326008)(110136005)(38100700002)(86362001)(82960400001)(66946007)(6512007)(6506007)(66556008)(54906003)(26005)(66476007)(478600001)(6486002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u3q/qOvE0PQBtBidRtX8H+EQppZUWweBA7vOoiKJ01MTLO32S88IJTh1ND6V?=
 =?us-ascii?Q?UbsU3Y+DO5jXYGhJGU7B5V3ktfGFBw5kVbTdODHz8U2EHNfXxkABg66PNRfz?=
 =?us-ascii?Q?Ak0RRBsQ1ehx+ZW7hA7CHAiarSlhANMHzcRaz29Vyo+7YHoo3GgrH0HDqTYC?=
 =?us-ascii?Q?s/9efKPqUj/WPzsDPOtBH7LIpf1jPvm2ihtm2RNf7jsjKJ9E9pqCla1REe72?=
 =?us-ascii?Q?M7T2Br3HI/7lJAjefB0zBYwYv3cJdnGBINuXpfdssiPOL7rr7nlt+nr8WH+d?=
 =?us-ascii?Q?2Kor+Zx80CtPFSJJchLbqPYUJzw4QsMhKFnnND41QMpcUi90SwGc5ZplutyG?=
 =?us-ascii?Q?+MvCLlUAjjzbQk8ExzD7CX1rVIGtaNKkkQkUFIq3TMNEWg1ESqpMhEBA1JbJ?=
 =?us-ascii?Q?RTpiTmvdAe0JGo3nMEsLcwaWR/rO1spRVXkvMIVmUWECp2spBL4Pyl2cHTnB?=
 =?us-ascii?Q?EeiblSiupE6/Y5I0gYozvDcFetzRH4gRc8Z1CM8JBIirwrkYSrmsahznGwxr?=
 =?us-ascii?Q?fXEkbcU3OEWo0jmC/s8xDzK0uezrOQXaCzFt9RzhJiL3kug8cCSWkjZnrjui?=
 =?us-ascii?Q?ifEwLsRsfxSNHhDuDv987t/o/FmPRywDDw4tJ42oJVSnf1HqobvHJ4SiSOSB?=
 =?us-ascii?Q?GCaPa1N7FBE6/dt3owqGaA5cF35eAZ9eQIACL5+rxc78DpEqRrpz/nP5x6Ly?=
 =?us-ascii?Q?EpHkraVDL2U/VvdfiigTdKaaftwboCyKP+3XJoeYN7eFMLkFmV5OYuiBxH5V?=
 =?us-ascii?Q?moBbsWW9j8uWeJshcBM/A2XQvJC9LdkVJ9P2Bnax7Zuu6U/HeuBD/GsEhxCA?=
 =?us-ascii?Q?YtFZlH7Jj5P29ztnWYIJpZqxRVUhCp1xOBvKrzGZ/JNNGIebLLlNDHRwGMny?=
 =?us-ascii?Q?Ku8fDK7VLcF3y2lVDujAVZMNn9Wq7kr2YYRcvHE7Wxrbw0/8g1BzZCYAmP6+?=
 =?us-ascii?Q?dV6wLq+ByXLgrVmLwcDH6ClwXfXEmyquKSDxRIEitNzuPy0WYrSHDHyLN0Ku?=
 =?us-ascii?Q?Q9c0khU41Aijb7F4leWV6AQIjDrKWPSxYcwFeSXBte9VUj+2M1S5mp4LHH4A?=
 =?us-ascii?Q?JhAhK46L5Ye2OxJDEOPsuL0w956KQfWSYCIME232Kpfwyj331g/g+kRp0q1p?=
 =?us-ascii?Q?M1Za58epl4PBGLxaWRoQfi2H2UpsfTmG631g14ZQnY4L+gMcPdxgE9mXUBHK?=
 =?us-ascii?Q?9jI8IdP7pD0JsWTpFXClZw3KLg8Ztcp3WZ2u6uVoXqdpRcJHzozfTkjLn6QB?=
 =?us-ascii?Q?dT5GNR0eQis/6DWn40w3ifQ+EkfVplZnUwJfibCTvpOHeuTloTco6F4Dt4HO?=
 =?us-ascii?Q?7x3RXZIzvuQ6aWL9+Lxp8FNtnaZRXEXNoyWNhJhDFJto5ZVJ4Ujc46SbCVd3?=
 =?us-ascii?Q?9xeWcZVinVue0/eumiXcfL93NXmkR9IQId8Qb69x2hT33YzzQuWXFks//ZpL?=
 =?us-ascii?Q?RVaCuKJintdYWJFY6GHImUNk7SG92EPbpl6/muaK3IX9fQVMJgmAUyKSoQzn?=
 =?us-ascii?Q?BPqRN1QLCe5zEtyDvrkw4ILv85ZGtYGUWDCLzBpJLDnFgGJPSOq9M7r7M5N5?=
 =?us-ascii?Q?IAojMHJzqABWUSslcSxMiIbTDMI5QX6+5n2eaL4GOKwN3aTI56dXhCwwk66N?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e938cf14-dfed-4ebe-80ca-08dbc5e8628a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 21:16:48.1299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnGNP2EIEkKMWT6R8fCWW1fpt/CjkA2Mlumq4TvphxCNuz9wjVGl+/sUM5rT7hi/GGMDttBDIjVToTtAMwDypdClW2ZHh0qcXmIBV/GA6xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8248
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vishal Verma wrote:
> Large amounts of memory managed by the kmem driver may come in via CXL,
> and it is often desirable to have the memmap for this memory on the new
> memory itself.
> 
> Enroll kmem-managed memory for memmap_on_memory semantics if the dax
> region originates via CXL. For non-CXL dax regions, retain the existing
> default behavior of hot adding without memmap_on_memory semantics.
> 
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
> Reviewed-by: David Hildenbrand <david@redhat.com>
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
> index 0ee96e6fc426..43be95a231c9 100644
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

Perhaps:

if (dev_dax->memmap_on_memory == val)
	return len;

...and skip the check below when it is going to be a nop

> +
> +	device_lock(dax_region->dev);
> +	if (!dax_region->dev->driver) {

Is the polarity backwards here? I.e. if the device is already attached to
the kmem driver it is too late to modify memmap_on_memory policy.

> +		device_unlock(dax_region->dev);
> +		return -ENXIO;

I would expect -EBUSY since disabling the device allows the property to be
set and -ENXIO implies a more permanent error.

> +	}
> +
> +	dev_dax->memmap_on_memory = val;
> +
> +	device_unlock(dax_region->dev);
> +	return len;
> +}
> +static DEVICE_ATTR_RW(memmap_on_memory);

This new attribute needs a new Documentation/ABI/ entry... in fact all of
these attributes need Documentation/ entries. I can help with that base
document to get things started.

Perhaps split this sysfs ABI into its own patch and, depending on how fast
we can pull the Documentation together, start with the
region-driver-conveyed approach in the meantime.
