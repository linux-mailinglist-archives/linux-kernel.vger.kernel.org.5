Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25457B1392
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjI1HGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjI1HGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:06:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1703D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695884799; x=1727420799;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bnoabGW8qVhr2r7Ni3XnES6qDOVhduUfSOnzcoCH238=;
  b=jOZDrrYLsUmLpLqPHXnaKeUvxPqn3QOgHX1okZzFvXg4O9soi0uZNQWU
   3WF5llyIeo5nMj0GK9bvxIn+66o9+TjzL/ezz+bGHBBFu86mBL/3Ur9ai
   01lhjXd4qTG7p4Jc3B4HbTr8lO1MRPQMb0idZPRlFF4Vuclle/532oSbh
   nHxm63qE+o9JbrpZnd+pLjp3BQDwo/V6mEzy3fFnG98q2hdBaKGrR+7MT
   0bIVXpHii8j/fnX+8wIF28jeosZvGZCyJGDsqo5yt/8jLMA4q0Gyfra0S
   Ob8VUe3aQizqWM/uTOPfVTTaQSUELzWRpI+yB8VKj1ZOjUWBkiCzHRALf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="448491309"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="448491309"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:06:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="749513822"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="749513822"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 00:06:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 00:06:37 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 00:06:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 00:06:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 00:06:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHQAfFUV6Cr/8lugHZFFuVqyv+qVfbK2I4vqDctBWVxxZeQAxL/I6rFlMVUOHGIjQSQNt4TXszoE95bqj8obbUnW9Stm50pnEYCk7TjNTfbkvAE94ef7CMUVTsqTs90yNsIuJv7S5/2QcMMaZAgFUa2M+bbOry2tb6Uq2J+lgiAfZ/+xCXcESt6ZUKgYg4PZ6lhhvPHgrMD947jfXIC80GNuemi3DtfwwPaCTvvDxhwg0McKP8ssanVCjmP30N/nE8QuyCkbemXFLkxValFM9aDH4fnTlBLoCb4i0A3T3oGIl8qPi09Ida0FhSX8y33cxY2o+/DuzkudRDEDiorWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DApgmxYjAghFTG5/riJ87KZyQmzkKb8Lrla0DIntiVE=;
 b=MJYYpL+DkzAQ0QFAjNBTvUOGCK2fxa/MRasf3r0My4xAyjwSGRlvnOXuZ/Qa06vY37o+FpkDJHDqqCY+5rjvSiunRE/gXwxWgLtmiD1bHrCMMifCEDrwmy0ntQEZ7GuZu4UuyqyIUulFM+Y0ssjp9jrtAugxEFDH19ydTXgPFM39bfRDUyXgzBxcaxMeWTd9NFJxFFSVr3qD8RrRUIwfz1RScV4MURzM5ZSIa3dMaROXhz7xgfRZO71Dhl9duZsY+QGDaT3SuuPJWSJ7aP80L6+SlxPc8jTsFtR7DhfpJfPAPnfVz2lhP9r8bvHcL0heS02rpjmv2saXDaLf4W9jUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CO1PR11MB4770.namprd11.prod.outlook.com (2603:10b6:303:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 28 Sep
 2023 07:06:35 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3%5]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 07:06:34 +0000
Date:   Thu, 28 Sep 2023 09:06:28 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     <babu.moger@amd.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] x86/resctrl: Enable non-contiguous bits in Intel
 CAT
Message-ID: <4sxjxe4cgvookcobwbrmsoeszjordi3bpjg22zxut3lanjc46j@xpqt6nblx6uc>
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
 <918e147601697b1d4b8f8589f5751e05d6ceccdf.1695371055.git.maciej.wieczor-retman@intel.com>
 <9751cbaf-8653-d32a-6058-13c251c59b3d@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9751cbaf-8653-d32a-6058-13c251c59b3d@amd.com>
X-ClientProxiedBy: FR0P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::19) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CO1PR11MB4770:EE_
X-MS-Office365-Filtering-Correlation-Id: 8030c7e5-2c04-48c4-5b89-08dbbff172d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRDEjnzZRRlOGszqpspLVGHf+fCjxogOmls29apWsX+t7V28BOhVgf64KzZic873kw7cpFhrphYbu4+gq9IaYcFUIPZVSrtE3moLnPYKp7fqZv0WinE+9bxFHkXFH0YC3TDFeaFWM2RxIB7KdFL6vD4IVeYos2KFv5m4H1pP0R6jmeIgjafCduAx34CBJSjxUssZhfKJxaoQbe9AXiWjdaFln+dBjMvgqtqAwvkmn3d8hv0aiDXzkBlQ9VYOGyZX8OT70SsACCvRx3JaqcWys14/e9tPQ40L+jAQ6VcGRz4dTazAfpNlLHgeXX8WHoaUCoGZGTfDG1AB3mQSVqLm6FXH8OJTM7rg9bYrV+80oFvEPnQS8zgnK9NzH8n5Xmni9uzp9qp+CZpS3RloSSL0TbtIV3p1Ri70WQDfRPA0OA/SuphcKFUTLnw0Bay3QvWdKBFwFkhgApj6xO/1esuSW4w1QS32xmR4FfaORSFqqW/1XilIhPwxbDTJIK3FIJaqfSMKukuKRO8jRnlx9DRqD15tg8y3MqeVjZ9Or44MpPWTJ+m6J7bznKx+eBrFSaxv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(66946007)(83380400001)(38100700002)(41300700001)(8676002)(316002)(5660300002)(478600001)(66476007)(54906003)(6486002)(2906002)(6512007)(33716001)(6916009)(8936002)(82960400001)(6666004)(4326008)(6506007)(9686003)(53546011)(66556008)(26005)(86362001)(66574015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ichJWf5aI0GJJlSUCW5eQvR5M+IZNdFKWYJLv/pJkAuYrWurF03s+IF7FD?=
 =?iso-8859-1?Q?d03zAaDOZB+ET0PiBX2D8f/4Hn3yBjgJ268pzEYlwqaZOXvGagCxtZgGNL?=
 =?iso-8859-1?Q?06gmiksmxfEzje3ZLth/17nmpBx6ppO4cGFYsjUEBJEcQTsLZwQ8+KjcyY?=
 =?iso-8859-1?Q?wzvBU5IbQKocI896h1E8VueKzdes50YyWSY61GjweRmteY9JwrZAeXCdQS?=
 =?iso-8859-1?Q?8oowqdwftb6KNGwzlXikPOSPvLfvW2OlE4GQqmcDMBIk9FI64pHh31IeBS?=
 =?iso-8859-1?Q?HDG49HgmiLrsA2lw39Z1RVewYTAqad2gNDLihfsN32jOifYAFbEtwou9rU?=
 =?iso-8859-1?Q?ilWNFRaNrZ3+97dK9ip3a1kAoHluEMVA7D1XVpeBZiwnp/o0jVWwaImpcL?=
 =?iso-8859-1?Q?YoyelLndoFK3lCh3XlHwwOMMppLoPaEYmE4ddN5MC2K/Qlv6BbYkmyUkrh?=
 =?iso-8859-1?Q?DJXSZQghEJEOJbpP78DIoY4PuH3ryA/x3oukPLbayDmQIpR3LA6IMGWAqC?=
 =?iso-8859-1?Q?S1a0kAaHo36vdfrpJew+65jM+qWfPO6yPsSDkPOncuFP7xNotUN07SlDh+?=
 =?iso-8859-1?Q?/vTUb5qYUs1uq77cz7hqZar40zQcuIwbI8SH7Z/Fg3lXxg2rR/upCIDNva?=
 =?iso-8859-1?Q?Cau6TY6D5yMj09ED+o50KzF0uQDRfZDP0GwZpld/sWLXmworekNZr+zv8o?=
 =?iso-8859-1?Q?7dBwaInkZ9PuLycma6evkmcWWE+JlgMVn7iwL0xStUgEkEu0gs4VTvIZfN?=
 =?iso-8859-1?Q?gbbRCGqKypOJ+7AYuvs+s0vqzvODt2LfUa14C0XulYNmcyqBQV+D3cwa0w?=
 =?iso-8859-1?Q?4w09hLnmcNc6LYqGrxUxax11lbtaCqGsR+JJ506O0rmfGQ77C1Ch6er3Yl?=
 =?iso-8859-1?Q?zK7a5FVxxL7OBi/czDskA7l3fUIO4o69aw4sj0ZjYzyQhe9PFtSax1V/QL?=
 =?iso-8859-1?Q?ZM9MiUHc6mV5MK0WwkOIIruvL0Y2KCdBV5iSPPgjrsRagC06fkvaVRnCBt?=
 =?iso-8859-1?Q?ajQ1YDRESUFTPGrh2OeFwzeFRk0QY2MVt5wRwpV3nhL8OBfW+w/qmgRwnU?=
 =?iso-8859-1?Q?Mar4/bjrRIvbG789jsDJ33WdEl5Qn5xxlBtaiu3V96tAZoS2LuJY/tvMtx?=
 =?iso-8859-1?Q?VIj05c1hkDstb3IXPnPQjL2qhf0cvbQTrrtFdBwegcUb1aK6z8pQ7ggJ5M?=
 =?iso-8859-1?Q?KGxG+N2UVNsGo1k1P/gWah2dbsh2W7whFLI9HRkcn5zFwM7qTgRA0SP8kG?=
 =?iso-8859-1?Q?FSSvHb6G8YX3PxlWN1W5Sf5zsRiXnRDaYSNPVY5aeNFVBAdwCQZmdLmg0n?=
 =?iso-8859-1?Q?V+jYcTmgCRrChlZ0gKk6b8KuCpMqv9itGJWeDXR1HbV6QXbTic5PskcnVB?=
 =?iso-8859-1?Q?s34EQgLvOSfF9gOx4gthOQfPgAk49BMv8nQo53AaGd6iKftrrN1e5+dbyv?=
 =?iso-8859-1?Q?MebaIPA6VnfqsdgKIjIja338lArGGmsFugmPScjN7+UnJplBCOEFyRFkqM?=
 =?iso-8859-1?Q?WrcVN2v7zBAcPfU+x1DNsYV/3xBMp2KNW3SRvksdr5/tyXcXwN4R9c5JCd?=
 =?iso-8859-1?Q?6gIsJ5kOqwWZjE1fv87J4ZvoJzAjR9ubLlzhX06KcIWPVN99fmKNoJysQ4?=
 =?iso-8859-1?Q?tJTeFAMgBA0MaAYgDLAWKCbnCNY9rTu5Ml8kYeo3xnIjP/AXpXsIaRP045?=
 =?iso-8859-1?Q?Sq0ZAl0KuZwbTEuAIYM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8030c7e5-2c04-48c4-5b89-08dbbff172d8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 07:06:34.0581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQ0SUJKc6BTPSXSeyR9IQT254uc5YBUutoT8rdR5eqG9opohvAUOk5DjgYUTi4yUbKXu7gviqnep3e/3oBC+kkd6DbSwbp9C7uB/6+RvLho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4770
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks for reviewing the series,

On 2023-09-27 at 17:34:27 -0500, Moger, Babu wrote:
>Hi Maciej,
>
>How about this subject line?
>
>x86/resctrl: Enable non-contiguous CBMs on Intel CAT

Changing "bits" to "CBMs" does indeed seem sensible so I'll do that if
there are no objections.

But I'm not sure the preposition collocation change from "in" to "on"
would be grammatical (at least from what I've read in docs about Intel
CAT so far).

>On 9/22/2023 3:48 AM, Maciej Wieczor-Retman wrote:
>> The setting for non-contiguous 1s support in Intel CAT is
>
>> hardcoded to false. On these systems, writing non-contiguous
>> 1s into the schemata file will fail before resctrl passes
>> the value to the hardware.
>> 
>> In Intel CAT CPUID.0x10.1:ECX[3] and CPUID.0x10.2:ECX[3] stopped
>> being reserved and now carry information about non-contiguous 1s
>> value support for L3 and L2 cache respectively. The CAT
>> capacity bitmask (CBM) supports a non-contiguous 1s value if
>> the bit is set.
>> 
>> Replace the hardcoded non-contiguous support value with
>> the support learned from the hardware. Add hardcoded non-contiguous
>> support value to Haswell probe since it can't make use of CPUID for
>> Cache allocation.
>> 
>> Originally-by: Fenghua Yu <fenghua.yu@intel.com>
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v2:
>> - Rewrite part of a comment concerning Haswell. (Reinette)
>> 
>>   arch/x86/kernel/cpu/resctrl/core.c        |  9 ++++++---
>>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 10 ++++++----
>>   arch/x86/kernel/cpu/resctrl/internal.h    |  9 +++++++++
>>   3 files changed, 21 insertions(+), 7 deletions(-)
>> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 030d3b409768..c783a873147c 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -152,6 +152,7 @@ static inline void cache_alloc_hsw_probe(void)
>>   	r->cache.cbm_len = 20;
>>   	r->cache.shareable_bits = 0xc0000;
>>   	r->cache.min_cbm_bits = 2;
>> +	r->cache.arch_has_sparse_bitmaps = false;
>
>Is this change required?
>
>This is always set to false in rdt_init_res_defs_intel().

The logic behind moving this variable initialization from
rdt_init_res_defs_intel() into both cache_alloc_hsw_probe() and
rdt_get_cache_alloc_cfg() is that the variable doesn't really have a
default value anymore. It used to when the CPUID.0x10.1:ECX[3] and
CPUID.0x10.2:ECX[3] bits were reserved.

Now for the general case the variable is dependent on CPUID output.
And only for Haswell case it needs to be hardcoded to "false", so the
assignment makes more sense in Haswell probe rather than in the default
section.

>>   	r->alloc_capable = true;
>>   	rdt_alloc_capable = true;
>> @@ -267,15 +268,18 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
>>   {
>>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>>   	union cpuid_0x10_1_eax eax;
>> +	union cpuid_0x10_x_ecx ecx;
>>   	union cpuid_0x10_x_edx edx;
>> -	u32 ebx, ecx;
>> +	u32 ebx;
>> -	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx, &edx.full);
>> +	cpuid_count(0x00000010, idx, &eax.full, &ebx, &ecx.full, &edx.full);
>>   	hw_res->num_closid = edx.split.cos_max + 1;
>>   	r->cache.cbm_len = eax.split.cbm_len + 1;
>>   	r->default_ctrl = BIT_MASK(eax.split.cbm_len + 1) - 1;
>>   	r->cache.shareable_bits = ebx & r->default_ctrl;
>>   	r->data_width = (r->cache.cbm_len + 3) / 4;
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>> +		r->cache.arch_has_sparse_bitmaps = ecx.split.noncont;
>>   	r->alloc_capable = true;
>>   }
>> @@ -872,7 +876,6 @@ static __init void rdt_init_res_defs_intel(void)
>>   		if (r->rid == RDT_RESOURCE_L3 ||
>>   		    r->rid == RDT_RESOURCE_L2) {
>> -			r->cache.arch_has_sparse_bitmaps = false;
>
>Why do you have to remove this one here?   This seems like a right place to
>initialize.

Look at the previous comment.

-- 
Kind regards
Maciej Wieczór-Retman
