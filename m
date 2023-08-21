Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B35F78287F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbjHUMEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjHUMEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:04:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08433EA;
        Mon, 21 Aug 2023 05:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAYqE7u2YlvYkkfyYIWaLISs0b00xafrK7BKA9ukcrtGaeZpmAYP7KIMJzYZyNEmVklT470xl53RUA1Cd8g3ZZ2WsFaFfLxb6OXvRQm89DbZwZxTsGvI5upxZWg8NU1iuRgGemp6pBpEDlB9p+H2wWrGsS3YbnsYDMnqbheZbKPAc0Phq4pVUptbqJls/pejZ/M4hgTWfgySmlepE+ZrPQsIR8JKeVzu7YvRIrwBxPIcA/ib74pAWXWWlE3grruO92Y12BEGy/ekRKTBpGt5QhEti8yNKN6hQYXskTN3sUatWx4SQCztT6WVVsacGLmEl1MrI1S8Gpit9mE5izNOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dioL6Aa6WE4M3qb3Wlgzj4nP+bmTmnnJ+Px2FKUzQMw=;
 b=hGZhx/AB0gDMr/R6etKa24PuzeB4/yS6or/mirRyBO4RJFrkAamiPc90BajJc/umOQyninBjleSOR1HRNulVaaeVgkprCXtcwuDpVn5gRIyiix0tZz59cr4HAyv9JGh5bPmm2EDn0EkvC4p5pXoef6J/+1ka3t2BcYJ96wBFyKQkSCvkktl9+VHXYjI70apUw6/TO6x1yWUo/aN0X5lclGmKovgL8vXJPCH3XhMdmVl9nKxnmnS+JC3X8OMtL27K11wZaMrVI0omB9UceUTFbRlpctG1atOgGPJtk1E1qzTXCx8/5jc6DZZ/2Dnh9T82ubVCDJM/QjUppV3yLhgpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dioL6Aa6WE4M3qb3Wlgzj4nP+bmTmnnJ+Px2FKUzQMw=;
 b=EEcIfUj3uBpajy5uEI4o/Uvvua0dTYTcSmd5BWJQDZGXOzJE5nV0IXKW6vbId0hGhIzmkm0w9m5HfFFEi6dmJSkvWmhfQZVdm8Q5RACB1tNe2FyIyU+PkmDnasROJlycF4bIlmrG8V4yrUzFUH/0WxwjWoI1lbhxIFZlH8bz5bACjQ2AC+2JU4Sz+kPRNvoGc9TuahoMUGZIVmMlOkL/TxBj3cs5xmN2Q+mrSshhG60GCcPNCsmUr1X52yKvxO8ffEKqm7/EJg7QUPGY+t5NOwo9Dcf0gKUKFwvhqc2xE3xzzefVHy/KbshvR2yMJDVEPY3DhckUGLuasLc8HKiNTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 12:04:41 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::3bf6:11f3:64d7:2475%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 12:04:41 +0000
References: <20230721012932.190742-1-ying.huang@intel.com>
 <20230721012932.190742-5-ying.huang@intel.com>
 <87edkwznsf.fsf@nvdebian.thelocal>
 <87cz0gxylp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH RESEND 4/4] dax, kmem: calculate abstract distance with
 general interface
Date:   Mon, 21 Aug 2023 22:03:43 +1000
In-reply-to: <87cz0gxylp.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <871qfwwqi3.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0105.ausprd01.prod.outlook.com
 (2603:10c6:10:111::20) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DM4PR12MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: de8efce8-ae38-477e-7dc2-08dba23ecd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3sA6Wn6bQxAC28Tp9NSeAOAuPL5vbNMxb7ogh3MWQQQNIpl4UUxrxxbfvGmXvGdQn4fFwU0DXmIWdiUEqwWlQWifA43Gk9edoe32qJIx/YZGG8iYAbVpinOPbgWS3IA9NhH387QiiihVexc0yrNBaFm37D5NGO8Gue1ATkB/r7Rho75jfjleXM+CD/evStQYpX4ifFMXU1ISH2T9kL5JsAuRHwO7Ngl0f9TXS9Ypjl2O7GULbVu9wneqLjOQc8yp3Ze2RDPQDforOoWmwv8Oden+TMlkIS8rwBltLaAZ2PY3GXKeuRx8IGIzG/mydtrfoi2LTqhbY9XF53NSd4npQeaHHaxc844RzSYbXYIJ1cBFAl+Uz6vKilbWwjAd+Yb8EvGHdZgZMZcN/keQZHkrzGOopiNB91L7H7qRQnNTxBxomLx0/9CpHMXBw1ViaK3RWCHya20ynxVEH9F24YSWHex464XiF3wxJ0hrbns4j1jl4pIJEHR9jc54GD77tYRk2C/QnM/nZWVZlxO9gUHywtQMD3138Igx6PDz3jCVkM1fKjWlH3CITHbgi2l4M49
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(1800799009)(451199024)(186009)(66476007)(41300700001)(6916009)(66556008)(66946007)(54906003)(316002)(6506007)(6486002)(38100700002)(26005)(8936002)(4326008)(8676002)(5660300002)(83380400001)(7416002)(9686003)(6512007)(2906002)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gy2iStiffJ9yGVuMehvG9/0KSALwLYAvSHL2inXPUbUW2MZMcgWV3XqlzlJV?=
 =?us-ascii?Q?DtWMuGNPZILwxdInMWtx+kBW7DTyk0B98kZM17f+oMaCpoHufZyDkzxyru1m?=
 =?us-ascii?Q?RpYgjrMd9TApIAAYWECzoJ6IVALLvi95zp/Jam1imi6f4OLAULlxGwxLPM+6?=
 =?us-ascii?Q?o0unZHo3FCWddSAJRO9yKRv3riIKcIcl3caSa21vo4dtcC5HN78YkY5BCg/5?=
 =?us-ascii?Q?lw8hyLZezptrlC8q+G7y3HA5TmkuMkfrxOnUYF+prN9SiX+GPbUKFZ1cW0l+?=
 =?us-ascii?Q?IaeWWKHht+8tOUwY+hg32WI3bJHyA3xAha4IRwtn/pVPov0ZZoMHT+HBthyY?=
 =?us-ascii?Q?t5lORQYkZEU+Y0p9eBvto3R1U1B0Ka2LUapwhgJF1r0CHBX3XLNX8glzT5aj?=
 =?us-ascii?Q?qpZdJNM4GPovLpTT87y/7nFHNToMw0ogRLeShzkWqSw8C4Mnb53y0EKUMmF0?=
 =?us-ascii?Q?J7PDbb34sA/+yao1zM91uPQsobzLeS0i0z31iE09aKzUo3yOUvaWIZHb59AB?=
 =?us-ascii?Q?vWO9YLRTHDbYbHctW7GcTeSiK43SGQwBf7AJ5J4P5UgOX7r3tCKOPTFmGZ91?=
 =?us-ascii?Q?W1B182SsGTUUaO8qzoxLhenDV+1+yjG+oZlQ7yE/Kvpr+ehst0/dT0f4cb8A?=
 =?us-ascii?Q?Vbc6SxtTVZp2BeiQIHH08OmJ9llvvByC2h2ro3tcZLJKbqcKngk8+qN4+xCr?=
 =?us-ascii?Q?VmIqyF4wUkxkvDPZBUlF9Vjh8I/w1H2uxbU49fVeJhv8459DZ6+PtXFoP6Ge?=
 =?us-ascii?Q?RcT2ORGsiOrA/vPwCBj3Tz6naTnFtA2SJ9L5rQ9MDZEV1ebkNfk1eIL0flTw?=
 =?us-ascii?Q?8eWcF6sSZR3IwH4z48ytkQk8e+AUXUUNu46FPeKMkU/xIAKLDQ+8E6DuZrsW?=
 =?us-ascii?Q?xlUS1voUZPavmakA16fyeZUiz9s3tCW5I+VL3Fl+r8nfRLUsC8SomgpYWNwR?=
 =?us-ascii?Q?jF6zQtbWxoHao2rPb5bJSDR3XAOE/XcqviSLhlheKafRKVHKV0jbAq88Lt0m?=
 =?us-ascii?Q?zfe5ZlQXQcY7g4735NzgmKNuAKDC02MwTPy87om3z3+598gqDj7XLsdu2057?=
 =?us-ascii?Q?/DU8OkIiZeHJzDRUg7V0DMwALJMPe9FVjrZLVcHk+kqCeWBzy3WysMpbWYBX?=
 =?us-ascii?Q?hQ67uxFABmsKk/5Qht6pQWRV9Jfgp/2dRIWHsktIZLwlqbp7p6VFJOOyItZ1?=
 =?us-ascii?Q?O7qKsFvubNF1DV1eSBUUe7WYxnkgK8QzVP3+LSRJ94ac9BvPHX8u1/zrreGD?=
 =?us-ascii?Q?kDr/wmCF5ImGmpA0kSc8DtMD4hFsdsHJEp03zM+HBZmmYiq8MKFP9xwoMFyg?=
 =?us-ascii?Q?x3Jj/jkHxNTcgU0ZEHLR6tNJTbilbS45R5Jk1BH07qlgE5PheuvwMlZiZf+q?=
 =?us-ascii?Q?5C9yAaYePExLOC28w8jDEdvwrrdwq/FIIbKEKp4rXNc+w07BiSBbAKwkiJw2?=
 =?us-ascii?Q?K4AGRWVbnuMbJ0ZSe8d/Z+j1u0rJIMSuCVmR1+0WUhD1obyePYz9pvXHskKj?=
 =?us-ascii?Q?Co10TStctcJ0fVwdstc4rtZu58euaqVOAujgtIFLRBVpwAFGITr7A0UWix0v?=
 =?us-ascii?Q?Byc9o+RHzYvffHggVcdgGr6eJ0quBB4U8tavkgrZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8efce8-ae38-477e-7dc2-08dba23ecd0a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:04:41.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpTyjS9UDx2zbOxarqdIb77g5rmZkD8q40XEiTpriyrKuaNkPSCcvDDhelBjtwvfeWF9Gyv4nQyY+C4hqTZCbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5167
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Huang, Ying" <ying.huang@intel.com> writes:

> Alistair Popple <apopple@nvidia.com> writes:
>
>> Huang Ying <ying.huang@intel.com> writes:
>>
>>> Previously, a fixed abstract distance MEMTIER_DEFAULT_DAX_ADISTANCE is
>>> used for slow memory type in kmem driver.  This limits the usage of
>>> kmem driver, for example, it cannot be used for HBM (high bandwidth
>>> memory).
>>>
>>> So, we use the general abstract distance calculation mechanism in kmem
>>> drivers to get more accurate abstract distance on systems with proper
>>> support.  The original MEMTIER_DEFAULT_DAX_ADISTANCE is used as
>>> fallback only.
>>>
>>> Now, multiple memory types may be managed by kmem.  These memory types
>>> are put into the "kmem_memory_types" list and protected by
>>> kmem_memory_type_lock.
>>
>> See below but I wonder if kmem_memory_types could be a common helper
>> rather than kdax specific?
>>
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> Cc: Wei Xu <weixugc@google.com>
>>> Cc: Alistair Popple <apopple@nvidia.com>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Cc: Michal Hocko <mhocko@kernel.org>
>>> Cc: Yang Shi <shy828301@gmail.com>
>>> Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>  drivers/dax/kmem.c           | 54 +++++++++++++++++++++++++++---------
>>>  include/linux/memory-tiers.h |  2 ++
>>>  mm/memory-tiers.c            |  2 +-
>>>  3 files changed, 44 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>>> index 898ca9505754..837165037231 100644
>>> --- a/drivers/dax/kmem.c
>>> +++ b/drivers/dax/kmem.c
>>> @@ -49,14 +49,40 @@ struct dax_kmem_data {
>>>  	struct resource *res[];
>>>  };
>>>  
>>> -static struct memory_dev_type *dax_slowmem_type;
>>> +static DEFINE_MUTEX(kmem_memory_type_lock);
>>> +static LIST_HEAD(kmem_memory_types);
>>> +
>>> +static struct memory_dev_type *kmem_find_alloc_memorty_type(int adist)
>>> +{
>>> +	bool found = false;
>>> +	struct memory_dev_type *mtype;
>>> +
>>> +	mutex_lock(&kmem_memory_type_lock);
>>> +	list_for_each_entry(mtype, &kmem_memory_types, list) {
>>> +		if (mtype->adistance == adist) {
>>> +			found = true;
>>> +			break;
>>> +		}
>>> +	}
>>> +	if (!found) {
>>> +		mtype = alloc_memory_type(adist);
>>> +		if (!IS_ERR(mtype))
>>> +			list_add(&mtype->list, &kmem_memory_types);
>>> +	}
>>> +	mutex_unlock(&kmem_memory_type_lock);
>>> +
>>> +	return mtype;
>>> +}
>>> +
>>>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>  {
>>>  	struct device *dev = &dev_dax->dev;
>>>  	unsigned long total_len = 0;
>>>  	struct dax_kmem_data *data;
>>> +	struct memory_dev_type *mtype;
>>>  	int i, rc, mapped = 0;
>>>  	int numa_node;
>>> +	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
>>>  
>>>  	/*
>>>  	 * Ensure good NUMA information for the persistent memory.
>>> @@ -71,6 +97,11 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> +	mt_calc_adistance(numa_node, &adist);
>>> +	mtype = kmem_find_alloc_memorty_type(adist);
>>> +	if (IS_ERR(mtype))
>>> +		return PTR_ERR(mtype);
>>> +
>>
>> I wrote my own quick and dirty module to test this and wrote basically
>> the same code sequence.
>>
>> I notice your using a list of memory types here though. I think it would
>> be nice to have a common helper that other users could call to do the
>> mt_calc_adistance() / kmem_find_alloc_memory_type() /
>> init_node_memory_type() sequence and cleanup as my naive approach would
>> result in a new memory_dev_type per device even though adist might be
>> the same. A common helper would make it easy to de-dup those.
>
> If it's useful, we can move kmem_find_alloc_memory_type() to
> memory-tier.c after some revision.  But I tend to move it after we have
> the second user.  What do you think about that?

Usually I would agree, but this series already introduces a general
interface for calculating adist even though there's only one user and
implementation. So if we're going to add a general interface I think it
would be better to make it more usable now rather than after variations
of it have been cut and pasted into other drivers.
