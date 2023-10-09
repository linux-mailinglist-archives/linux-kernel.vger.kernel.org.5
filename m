Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1965E7BEB59
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378573AbjJIULA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378616AbjJIUKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:10:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C1F10A;
        Mon,  9 Oct 2023 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696882248; x=1728418248;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xn2pfSbKeUku/h0A23CciC1e7lKVmqdTDxJmLKBhJlQ=;
  b=lyKkxPUSGfeKif6yX/lgpUZdoi1vwKbqfV9mKeber/r2qkCR6KhNzeJM
   9N9cDDQLQCs+DfT16LVO6Bio8rmgsR0goIiUd3He10BuhPE81a0g9gNuT
   ztXDl2Gi0hOZ3TWAGm3hGiV150WgMtvtTWcB86UyuWhUK8xRokhTKSYEU
   yllM6fdchUIC87sTRyFiuJ4l7vTa4JhNY+S2egON1q6xXJGzENpOQ+Q3b
   p8xHCxwEbrE/vvuduXyTN/EWOWjB0/qkrfBK4ZT/2axGhFuO/7Zyslbc6
   EGX2pD+bAe7FGTr7SCfAox3in3RhPDxoBCpLuRit5ptwwONz9SM4Y83ZO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="363590511"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="363590511"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 13:10:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="876939965"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="876939965"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 13:10:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 13:10:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 13:10:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 13:10:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duCwiYYfl/iALmWTkOq4y07xD7qcWsUHjrP6aDulZMNE9z3s3/ZURJE1woSEnDxWHJoZ7wqsGumwrEB65lOPyX+0E0bUIv/p9yIOfDP7eYaLpDHMzxXvXvlfjoKVXh0ctdMajiqtxGJSQs1kL0Mq6j4fHwEwTYBos8PLQ95Y5KNraR2ZD7H2DebFqwdVbyWn7Xv/4pSO348MBVSgPcjxIWtkFgIUThevyZPvVDiJOOjCaZ1u+A4UtIQ8PP2yKUhEFmNMISmgx3OSV34wim/sAhP76KfQcov2itwBoDA3binUDdli5HY1OXKHS0h0YSSqmfMMDSR5JG7AxplB/ErRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcKWNfCznIO393J2KCuyV6j1hC7bA6HeQ8ur0XBD9dI=;
 b=FLqt/g/74DhwvmR0PabP8pFK/P7fwWFTWFj2QI4SmKwG1QyZNqI/w53mBV3yuw8G42ZNP0Cct0xTbgX2CEignHb1E6O0DvqyuyNbKkbY/ff1+T1FHdljm+n78M7unGykEU1boOFt2CRxRLuFbSa/+RilqcKCnZKV77F27yOFz1Gr+7GP55wqp09mSK49i80X9nE2wlj/ucY1uk+wSZ2KnSzCRqIe6ktybQBYmqtQVkN8vmdllrswY25Suf2AMaRmeNJpJBQuP2dxMFyBYpFYo6UYNtWmj8fltqjOYkOnmeGLX0ISJ32z1HddsvPzFfX1TNNEbDqAxh2p8/AYgqlmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5061.namprd11.prod.outlook.com (2603:10b6:510:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 20:10:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 20:10:29 +0000
Message-ID: <07e8d51d-6e40-44ba-8223-9f2af36a8bb1@intel.com>
Date:   Mon, 9 Oct 2023 13:10:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/10] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
CC:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <fenghua.yu@intel.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-6-babu.moger@amd.com>
 <20231009172517.GRZSQ3fT05LGgpcW35@fat_crate.local>
 <51277249-2351-4933-98d5-2cb74a14c7dd@intel.com>
 <20231009192340.GEZSRTPE9b9hOtu0JJ@fat_crate.local>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231009192340.GEZSRTPE9b9hOtu0JJ@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:303:2a::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5061:EE_
X-MS-Office365-Filtering-Correlation-Id: 864a43ac-355c-4d5f-b350-08dbc903c8b0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0IZqyGOi2QanVglvZ3ju/f6/2SQiYF79OKPezRCFIpsGo8cu+Px+1vHygaIgOvzmiCR0n5HUgGuE4F/Jp3izvWW3OQUUSoEhd8wTuXQAkf0dBoWgqTWV6NNIC7Bijt0FV5OVjgnWnYn7GznfLyd/lt3pRs1mtTuDO14ajguQoHED93YWNnf+P+pQt3Dri8jRFvSEkYMXR7mPaGaVXBnP2XmgvollZstzXLfRba3Y6S77j2nOmMlYBMzizPge/WCZQd6/VjgXcy7x5PXeY5TTxoXUtctYVj6OV9PuzdBAWImBmrBfIFgW4ID2VCPkx6MsMRSfVHFgtbinbk/xpMASqG8apRCwD/x+jb4WnKuxh4fjhM+AKddP2E1f6AND7aKLosUfTWumhbcp82ueGNDi0fpYOmKRvHYn6ifJZPP+CPUIPS1pscZJuufTgsjP7t6SFOb32XqCCRnDaR1BWUdSnIcASK6B91Vf+aYeUN6Fg+KYgAuuZGbE4gFokveYmSBz2NXzvl5h44LRz3YqGJMNYe1+B80yxgImFgsP+eEfEAn4RbBqZB902SErusmBorcXm2sve5me3bIzVNInz12SkbbSoEjz/uEItStYwNxCLkSYidffy8Vlm+2wurJStNvQTMQVEy8HyYNSJaM5wWyALA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(7406005)(31686004)(7416002)(2906002)(86362001)(82960400001)(41300700001)(6916009)(316002)(66476007)(66556008)(38100700002)(5660300002)(66946007)(44832011)(4326008)(8936002)(8676002)(478600001)(6486002)(36756003)(6512007)(6506007)(53546011)(31696002)(6666004)(2616005)(26005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzRzRFAwQU1FKzZ5REJwODJyaEdlbElNdkw5SVQyUWpDazB5amw2bkNic3hz?=
 =?utf-8?B?YlNhTXlSdjl4ZjRKYXYvZmtySyttdkRlekVkM3BrOEQzVW5OQW9tVnBZak4r?=
 =?utf-8?B?M2xteFdwV1RPSlR0NkFkRVdQYXpLbGlKTThZb2p4ZmhuYXBLVjVIbnNlYStp?=
 =?utf-8?B?VDdFODMxSTNKSWZQZnloYloxM1hkSG5kOWNQRUhLN2MvUzlMaHVKb0lNTzF0?=
 =?utf-8?B?aW5wUGhwTGg4YWxCZXgzbkNNOFMvR3BWZVV6dG5ieHlCNE5KVXM4RERaVTk5?=
 =?utf-8?B?cG9nSEZmM1dJSlJLKzNNVUpsb2g4dUJ3QzRndXBxMFlLNm1iclRoTHAvV1RU?=
 =?utf-8?B?M1g2Szhrb0NrMHZ3MjZwdVRIK1RWSHN3QVVMTVgrMzBvRWd1bWtRNnp1eVJz?=
 =?utf-8?B?dVl3WGVkVDlXS1UzZnY0ZFQ2LzFvbWQvYzZIbmlwSVU1MW94ekFUNG5DaEto?=
 =?utf-8?B?ZnIxYWo0Z3RRd0JrclNoUEtKUGsyWmJaWFRtNWl4NisvbXBhTk9tVVpBWE9p?=
 =?utf-8?B?aHNlcTNUMEhNVGM2NlBJamlteHFFaWxld2ZLSFNMbGxLTiswMDhBYTVvaWZ3?=
 =?utf-8?B?dEVUNkhRc1hHN1RZbTVxV1ZUWDVMQUVIK01BYUtqU3Z6SGx3VEZnSDQ3Y0Vt?=
 =?utf-8?B?NFdQaEIzaHNmK0xKcW1sV3VYNDhlZThuR1VSbEYxRkx6Nm40MDdtWG5ybGxV?=
 =?utf-8?B?U3JJWEF2V3NxVXJzYzUyTjNvQktyd0pvYnpOM09iNUtONnlOWnFqVldEeUor?=
 =?utf-8?B?N2xjWFZxSkhmVEVCT2c3ZWc1dGg2VmhBZ2dQYVB2WlNBZVE0aWgvRzM5eVBE?=
 =?utf-8?B?a0lJY1kzMjBnTldhYml3Slhoa0k5QkJQSldGZkFKNlRWTjJ3THp4SU1PeC8y?=
 =?utf-8?B?U2dzaDVoRUVZdWZRQVRoZG9yb3hNNTRPT3VCOHFzWWZpdXQrSE5mQytSTWlW?=
 =?utf-8?B?K2N4TDRhN3NYT3R0VHgwUUk5MWJpejNGVTI4cTBST0dSZ1NCbFg0eENRTlN5?=
 =?utf-8?B?blJBeEhZdUlMVHd0Smpid2o1OE1JOTUvVmlHdGhITkZPaG5KV1R3b0g4eS9q?=
 =?utf-8?B?LzA2VlJGYkZ1blJjNHFIM0RMWGJKTVVsWjRkUFZNaE5WalNpb3dRSlA4eTZZ?=
 =?utf-8?B?V3RHVEFxTUVHWGt3ckhta05qR0RyclJ2QWxRcnJoRHRpdUx4dVVwMGE1L1Rp?=
 =?utf-8?B?U3VKeURVMEd4c2pYZ2RtUFVtL2lrOW5McUVteFljR3FKSmttb24wZWpFcDlE?=
 =?utf-8?B?Z2dUamJUcVhrdDdUN0xBc2FpZzVZTGVBb0hyU0pEK2xUT1R0V0hxcHQ2a1lq?=
 =?utf-8?B?dFBhOUtpNnBBQ0tENjlHUGdHMm1hZVBYL2xpR1dhT0VqWS9WcnlQWUJvazRy?=
 =?utf-8?B?a3NKd1ZwYnFuMVJ5UXF6ZStkS3JTbmpRRHhaQ0EvUWxNL3h4TzhySXA5ekx0?=
 =?utf-8?B?K29xeklTK2lkVWg5NmUxV05pNVdrY2dPNW5VK1ZGYWZlSDF2OG15WGhkWEFM?=
 =?utf-8?B?MUdSNXdNRjNQSFRaRzQzTTVNTnh3OVdUeXZIaFNDd1lBYVhJUDBPU05MTkUv?=
 =?utf-8?B?SVRGMm5QbzBscnB4UUhFMU5HcW1CeEZWZHlVSkExV1gwOXRnU2t2YmZ1eEdq?=
 =?utf-8?B?MTZXRUEzNm02bXptOHp6VlNhT2Nyd3BVb2VOZ25ITmxMcGVSTzBUbTZmbm80?=
 =?utf-8?B?ZjgwTjNoaGIxVmlreGNwMGpVR3lhRHVnUXdPNzBZSVpFZ3hQSGlPZkh1SHli?=
 =?utf-8?B?WDNrY0dPNUpFNW1kU1lKZnF0SW5pSkxvcUJZTkxaRVM1bVdXSGhNS0phSTBn?=
 =?utf-8?B?aVRmMCs0elVVc25VN2E4c2NxdXdhWjc3dmVtemxjTGQzZTVpUDlLcVFLaEZa?=
 =?utf-8?B?VG5tb1hIdkRRMElZbmNaeDNTbjI0ZzVjTGNrRXJaQmRRYllHZzVhV0x5bDFW?=
 =?utf-8?B?YUgwZWppUTZsb0ZHSHBSSUppVDg4dXlmVjYxVWNVY0wwVHNaeWxtWmp2dWNu?=
 =?utf-8?B?OFFabXAyT3ZxVmVQb0xPd0IzMWkzTUhDWTBvQ2dhSytNT1EyMGMyVDJ4YzJh?=
 =?utf-8?B?RlhibHR5MlVmcWhCVlR4VWd0N0FtV0JGckh5Nk9XRlRnQks4Q2VTZ2ozZm1F?=
 =?utf-8?B?Yzh3WUNFOEhtVVZreDlGVlhuQVplVlhVa2dHcGEwbE1KcWJ2bnVKQU9yQjYr?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 864a43ac-355c-4d5f-b350-08dbc903c8b0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 20:10:29.5691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VH1wMvYvBFaJGA0VpLetXvOmgfZdpWqN2K1ktWOLxb/199jABbkAb9KxR3pQg4xYYuNQHaXY9/U9l24h7XXRyQWajZpx92Vy1EEORWSVQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5061
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/9/2023 12:23 PM, Borislav Petkov wrote:
> On Mon, Oct 09, 2023 at 10:59:27AM -0700, Reinette Chatre wrote:
>> Is it the fourth paragraph (mentioning cdp_disable_all()) that is annoying? I
>> can see that it is redundant. Would it be more palatable if the fourth paragraph
>> is just dropped?
> 
> Yes, basically you don't want to explain what a patch does as that
> should be obvious from the diff. Rather, it should talk about why
> a change is being done. Sure, sometimes, you need to talk about the
> change in case you want to highlight certain aspects of why the code is
> being changed in the first place but explaining in text what is already
> visible in the diff is not very useful.
> 
> I always give the example about git archeology here: put enough info in
> the commit message so that any future reader of it can understand why
> the change was done. The "what" of a patch doesn't belong to that text.
> 
> I hope that makes more sense.
> 

This is clear. Thank you very much. (I am still working on getting it right
in practice though.)

Reinette
