Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D677E70B0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344827AbjKIRq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjKIRqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:46:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3452D63
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699551983; x=1731087983;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QssnRjv79j1CmLy1KufvZFXBzpimYgGVJ1LiQOhDhiY=;
  b=Zx9yD/2fjTytiCambI9mPaKw4nCNoz8c3AekKNYiY6IO+HxJAleUgHhH
   5evntySMIfrMvqQO/ARcyLSv7cZx97luVESxr7ySoZkXa1HXRAWdu4Nf+
   Kcq2gN7LycAqC6AlsSmVXshkYmRynTAD2Tmq3BPk/nS7dwoZDIXph2cG8
   gVehGJm0ZVYas+8LkXu50ZVrGZkgymGQVv+1dzHHUR43o18jiN/i1hp4q
   R92yPKJ1wYFslDRyMUconzdJERiuSd/9xRLBP9FhxQhcmyF65YoLVukR0
   PojeMz3TMlPpE56lJXP6Ot+q9NUAP0t7zRov8HA5L7/ud7Dv0c0g6KDpZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="8691254"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="8691254"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:46:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="792624161"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="792624161"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 09:46:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:46:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:46:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 09:46:21 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 09:46:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYpgf3DCZp449z2kzDXf136f3rMiQtK+uURvRJF1UpjhE8zXCONip1Ls8FTO6+3UjK1+MchoHz48EzNT41Y+xmAUkteVc6FKAEz1bgt+f4eJbqRoS6oFQXUFflPLbZDAnCO1u3EENbRn2RXlZW+U0x3o8cz2hx39bS3U1bLw27TUv5+5EBW2NlK9NU/gjE5ARYRtLZKbjunoGR5U4gbPEWaclTIPY+7icvgYDJIHXSyLJPafZwMQfOhBcUE/cnGfu37p43zhFs3wgPcU34Aoi6P6eEZKKdoz1so9I1Xy73DbtjDwCgcRGIe3XzqNd4oEDOLRJFnK+IroIDTrPo+Uog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeiaYfj4m7FQTRupe3wR9bPfwO7pj1PfYmjpO9ID2fE=;
 b=Jk+Ae9i3BZuGtyqFSY0AXMHoaszGsvw9NY7lFDk9vm2U4385lZyxtQRkxp2bZwJC/lspwnFPy8CdYowZ4NL11FeSofYCC/Jv2O6GRn4hJlUJhzP+//buy4A6Llny7K35EcwuB78+t+G8r4KH3FyUyCWbKZn1zpMG15mQLEKwfzZmYC7pZAioVVqWktseD2f2DSrQLYZpWEDbRfbf5ZdsGTdCTL3epnq/LPvEz5NjVoNgmWAWi8XsWk8C5NtV8HT4AHxTdksPMvN6CVj0VG5xywzuI+XgK9hhSujyvGe0aSdzZzgHDAJyx8CUN12SB8sC3O4gpbS0ftrJjgoB+WImPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7303.namprd11.prod.outlook.com (2603:10b6:8:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 17:46:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 17:46:19 +0000
Message-ID: <acfa2d99-1bfe-48ff-9bb3-348ad27a6f60@intel.com>
Date:   Thu, 9 Nov 2023 09:46:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/24] x86/resctrl: Allocate the cleanest CLOSID by
 searching closid_num_dirty_rmid
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-11-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231025180345.28061-11-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:303:86::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b10b2f-5d3e-4f73-3cb2-08dbe14bc781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xzh4h8vBHJfCNRcrlap09A1OB6oOhKHp3HCWKQif3wZ08Y6Vf+92PLEnVYjwZYw2r/yiYtTZacZBiXZE/y7/efrk3wAjLORuOfTmHEXvLsvjClnZ4UTu5uhX5xWZEF+EEznEvSWwzyuV6Sc9/HfNhbg/x7VxV7SnQroa61YeI24rfJ3DydaOWl/f5ekwEGZJKI3+lrI/4QJUSEXoa/zcHKxsBn4alHTtdeoP7f2NPHLGzGqnri6i/sitwFck0AB5cByrv1HHYgvJcRwNCbWkP1o9uxSPB7cvhpqaDujkypqTgCCF320L0HV0e9vAIQYHMal5XDh+fcyTD1+dSw39YsY2hro7gF42SlMSFAWpe997s47Q67f+X1UElZ9jvhBZ/K+xcvcbThwZc8m4dGEEUAn0bLbldWDbR5YOs6k4i2AaXTGMxBrCSPnSU4ayb+PoYEFdFtdDf1QHKJnnfmA4+5irMdGgk4w4wmprlqbgN7U3WffN5mmyZllBWP+fptnN6IWpFL+qDnnXgqMAqywvwTMTW311VKXdWyAbM5t9ZyQ21DSqX11dgdt65Du4DY5W0I1pA9gDRfoF9P97/mDNmvvo6Pd/sl7Dv5x1jIscrP8208nqaxHmNnfqNCuxULA8FczzlBU6UBnnjPMROKdj9nuO1J86AIfEWvvBdyxwQoY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6506007)(6666004)(82960400001)(83380400001)(6512007)(53546011)(36756003)(26005)(2616005)(38100700002)(6486002)(478600001)(31686004)(66946007)(8936002)(8676002)(4326008)(31696002)(66556008)(66476007)(54906003)(316002)(86362001)(5660300002)(7416002)(2906002)(44832011)(41300700001)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDVZRWFidXUveHBlK3N3am9kY3BuU1poUm1aRWtoUlFzU3Z2bU9RVFBlSndu?=
 =?utf-8?B?dmozNHNsMU5KZjNmTnNhMGQwVlM0S1FwV240UVF4U0lmZnBldTQydlhGWHBq?=
 =?utf-8?B?Y3JzN1ZlRkJxQnZEeGdmNGxrUFR1YXduNDN3aXhpdGxtdUtxNk4zT08yK0NF?=
 =?utf-8?B?WTVRdXJhbTMwTDZueXZ4cTMxWG8wRDZwUm01K0w2L3JsV1lucG91YmlybUxx?=
 =?utf-8?B?YW4vTjZRejR2WnNtNXpNMFlFZjh1clIveXRrNmxPYWU1cnJicy80NkhzT2F5?=
 =?utf-8?B?SmJzYXM2c1JaZDd0L0JpTVp2d1l4aklvWUZ4dWhBZFpsdVEyUXBCL210ZkpR?=
 =?utf-8?B?dGw0UU1uUUN3MHg2OVlqK1BJdHlNTlQzOXJONmNKWVp5ckdwYkx2cjVFRVNn?=
 =?utf-8?B?YjRDT1k1K0ZTWmVLdHVFZmZMM2JTdW4wNnJwVVVNeDNUMGFZTW9wNUlwOTBV?=
 =?utf-8?B?WVZJVS93SjVzRU5MRVRiQy9LOTdqeFZRb1RmemxUVlZIQjFLN2treFBwcGJK?=
 =?utf-8?B?Y2xuaFVEdjBRYm9jZ3A1L3l0NFIwR3lNYWt3cU5vbHdmNUNjZjFDOS8rSjhI?=
 =?utf-8?B?SC9CNDViSzJWUDhtL3hxYVpqVkpIcTRwOWpPSmxSUTMwQjBFRW5mSXoyT2dn?=
 =?utf-8?B?blB6Q1ZhZWRSTlR1N1Q3cnRGUHN2cEdlQ2hFZG93MkxLQkpMYUo0M2VYNjNF?=
 =?utf-8?B?M2I5RUlUUzlOVmQvRHFJZFlBelZUUDdwT21CdE5iakF5a1FSbERldE9OdHJT?=
 =?utf-8?B?ajB1OFhJcHlQaXZNeWEra0w0N08vMVk4ZjdnVUcyT2YvVVRsckFWMmVWWnV6?=
 =?utf-8?B?NTU3OGpKZnUzZWhlT0hFa3dYVmpscC92MDVEMEdDK3BXOHg3U2ZXZzdyd2Jv?=
 =?utf-8?B?cG8vY1RVU3EvZUZmamJveFR0aC9oOTFQLzBkbkltelI4dXlMRnZPMkdxS2Fv?=
 =?utf-8?B?KzNWeU1Hd1JDTEhRSXdEaHdBV0paMEwrb1FIUVp4a2ZXVFNWeWRHYkU0cm9r?=
 =?utf-8?B?ZDZQMGZXeEw2U2VRS1ljQ1FUU09FazV4NXhtK1drNS9qMXRBRExlZ3FVWHI5?=
 =?utf-8?B?UDNVVzFocXJaU2wwb0FVRDVOZ0hLazRTUnhGc2tRK042RzI5ZHZkcGg2NHFI?=
 =?utf-8?B?MlU0REFNUEpUZEh6M1lxQ3ZkNmxDTWVJZDBTQlMzSlJZTlJVVWR5QWpidSt4?=
 =?utf-8?B?eWlBNDRwQnJzTXhld1JRUjdFL1dhZHBVVVlIbUJmc0RFdmF5QTJTRTB5UlMr?=
 =?utf-8?B?eFcxRVhtZ1hCNzBSM2twRUt2b0sxa0tDRXdBNWRpSjBRZUxHS3lNY3hlOHNW?=
 =?utf-8?B?aFM5MXB4YVF4VkFxVWdrVUN4RnRWYTFtdnlhK3FIN3d5NVNFUnNNOElLazMr?=
 =?utf-8?B?SjUyMWt2VVFnS21LTmlpRzlGcDI1NklrZi80c2gwUmF1MXpJWDZqQVpYQmpP?=
 =?utf-8?B?NmU0VVhPRktBUEtCaVJmOE9YYnM3YVVETVVXYzQ3YzV5TnJ0SzZ3cmcwYlZK?=
 =?utf-8?B?cVhrcjdleThLbTlkeThiT3JXSnBFY2FGK29MWUdVcVQxVEIxNlExckhzdHg5?=
 =?utf-8?B?dzExNHRjOU8yTFZYK1doTFMxNDdtclBlTEJ3eWpJaVNJdFhqaWh4dkpBZU1J?=
 =?utf-8?B?cWVEQ0ErWDlxTTBEajh6VU5rWm9jQjRjanBFd2NCQlp0TkRxS0ExOVVrNExY?=
 =?utf-8?B?SjFHVlhpeEtNZzdpL0pQbFlpTElmZC8ySHc5dG5ZdUtOckFTb1pYYm05Zmx1?=
 =?utf-8?B?OUxiVGdEUGR5cnN0R1pBY0t0ZHJ3anBsTlBycTB0UDREaWRLUytCR0hmQXdY?=
 =?utf-8?B?SWJyMGUxOU0xTDJhN0s4WXJUM1R6OE55Tk5nQzU0ditwaSs4cVowRjYyQ3dr?=
 =?utf-8?B?c1Z3aFpucWNhWTBiTFNMN3hFN2I4TVRSOTY4cHFHZTV3OGhOVXlpTnZiOWFF?=
 =?utf-8?B?cU1sbGJ0dXJuSmRWYXNRTFBucmlGYjY3VVZCRFBrRE1KY3BOQldlRlRMazhr?=
 =?utf-8?B?MU5tVVdONUs2TzBBeEszMlFPQnBpcDJLOFJKZ3pyTzRWdERrVVVkZHVVeURB?=
 =?utf-8?B?bmdRR1hSa1VSUzhkc01iM0Vxa1pYL3FzVTVza09GM1I1WlRxcUhoSnpZU1J6?=
 =?utf-8?B?TG50Nk13RjQ5MzFlamlOVTZPekRUVDRtekFJdWgwZkF2dlFmU05MdUQvWUsv?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b10b2f-5d3e-4f73-3cb2-08dbe14bc781
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:46:19.0098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zENJ8VL7fyhgOm89rE6HW+ZaptC6RwzBABaqoqf1uqnk2p9N9xKlqisFVhHJkpRcun9ZRb1TJpDKJu+WXDYj/787xdDHTgPEAMafu/5D3Zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7303
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/2023 11:03 AM, James Morse wrote:
> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
> used for different control groups.
> 
> This means once a CLOSID is allocated, all its monitoring ids may still be
> dirty, and held in limbo.
> 
> Instead of allocating the first free CLOSID, on architectures where
> CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is enabled, search
> closid_num_dirty_rmid[] to find the cleanest CLOSID.
> 
> The CLOSID found is returned to closid_alloc() for the free list
> to be updated.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v4:
>  * Dropped stale section from comment
> 
> Changes since v5:
>  * Renamed some variables.
> 
> No changes since v6

I use these patch changelogs to determine if I need to look at a
patch for which I already provided a review tag. At first this
patch appears to not deserve a second glance because I already provided a
review tag and the above states "No changes since v6". Unfortunately
this is false. I counted four changes. Now I cannot trust these
"No changes since v6" and I need to dig out v6 to diff patches I already
reviewed to determine if I need to look at them again. False patch
changelogs make a patch series harder to review.

Reinette
