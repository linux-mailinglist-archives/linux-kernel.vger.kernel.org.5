Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8A67C93B3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 11:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbjJNJPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 05:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjJNJPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 05:15:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49520CF;
        Sat, 14 Oct 2023 02:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697274929; x=1728810929;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JYW86//yUL0QdpFHKCIQGEc6k1iMvbjB7mk9FRagBMs=;
  b=ALmPmWemRXINWlUhENC/6mKoVVJ7S0/kvK7WE9wJ/0FJcu4xQEU6+N4H
   vZTgp8UYpkulS6l5KPrxhJA5RBhAdfpRc473bLYnpelHcot7JB7pNVrA3
   J8URFI0nX/jEGtueoLA9MWjtA7G49T2fwRBKSu5tpyafMR3PzPms5vz+e
   rtgsY3vLGgX6gk1jyNzH3FtC6QlnNA7dR6CRiAgv03G+tB11NROrFsoXK
   UsLyrxhKo6wPAn+TtQhjt++6t1F+VmWD2xHN3u/VCH96ip/fVRAYhTUUh
   pXuuv6Jopf624be4Psikg1oPGNCN3kDCsZBaUcCbUeu0QxNlIxfi7zmHm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="385155275"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="385155275"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2023 02:15:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="748632803"
X-IronPort-AV: E=Sophos;i="6.03,224,1694761200"; 
   d="scan'208";a="748632803"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Oct 2023 02:15:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 14 Oct 2023 02:15:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 14 Oct 2023 02:15:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sat, 14 Oct 2023 02:15:27 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sat, 14 Oct 2023 02:15:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHYP+yAIB0XZLjuIq/Q8cB2hCC6rXPlRujP9g/y200VQZb5IoJM1HpPuLYjORpe4KYsBE499+iQjIYxeBtzJqFgYV5Kn26Xv4feZMwzIqx/Z8o2vbrBMLzxsF1I7FoTzEFpqbRHTLvMwjWDc5kclSoFyXrKaH3oFzysfQ3MgOh3yoySn8Bme1vJG+5TSotuAYP2lD3/DYMOixeJif2jM2hh0oTCnAoW0mtSaa6z/mOifBZfKjKdbRYTbsiYFmy3RBg9fr1NJYMNv7UJ1uVG8KCTFO5NBKW0fLF8YVIWzePN005tgrgrPDWUH4Qh6QxtOJPVsmx5N/PktiyzRY7BS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3h5wCLsR2UjH3wRlYs97jr4Np6Jppm6jK/FRDUGrMV0=;
 b=VKcfLlAA/5Inp2kDWtbRA9YeVOtty6bdgJ0966qFl2cX5d4qmGl+iXrRUsTCf2fSaqosgVSs/FbjnJ1GqtGd7a8ahMPyRrhxEP71AWpNgfrwS7gec0q/ejul+ukeQledzOzngPD4YG53kubbCjXZCbm9doC4NVDk+pJBO4FV5aXVM6Th+J70g+ZE8tc3mQbvcJuMRfYarfU3pPNmDYy6N7/aLzgvwXzeJ7g4a09fJG0zltq5v9MDUWSur1ctuBj7EabG5JgY9MLryqrybX6nQUkUKgiLpOsRuYXd4xLN2S4mLGNYgjLu9GMW4oi9AVhpm/X0hek2xbvG8CBWW1urHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3728.namprd11.prod.outlook.com (2603:10b6:208:f4::21)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Sat, 14 Oct
 2023 09:15:24 +0000
Received: from MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::e4db:e815:f217:9b6]) by MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::e4db:e815:f217:9b6%3]) with mapi id 15.20.6863.043; Sat, 14 Oct 2023
 09:15:24 +0000
Message-ID: <233e17ac-0ae5-4392-a5e4-ab811a155805@intel.com>
Date:   Sat, 14 Oct 2023 17:34:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>
CC:     <zhiquan1.li@intel.com>
References: <20231014051754.3759099-1-zhiquan1.li@intel.com>
 <SJ1PR11MB6083A23BB89F4EE0F44B2794FCD1A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Zhiquan Li <zhiquan1.li@intel.com>
In-Reply-To: <SJ1PR11MB6083A23BB89F4EE0F44B2794FCD1A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:4:91::23) To MN2PR11MB3728.namprd11.prod.outlook.com
 (2603:10b6:208:f4::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3728:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: e593b7ae-bf85-45b6-4286-08dbcc9618f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7ePWL3jHV6vgcbBOif0GTg63u0Wm9+8zhKeVGhUCsLp6BveDcixsNxJfHNglMwGJ4ITs8viwzdOsWOAAZwbaGxx36c5IPhy1IZ+ntucb3ClV7EilS+BMRm88AGuD9rVOOfBq8UB50YVTbgyoNiODgQcjxZ/27zHiMokQBdKLISXcEB1rRCAf0j8NkZt5Jp+7cYzmUFx1xh6ntnsptDiLxgFVTuxsVoiYm6+HAIz4+nXxfNMDSm/VPvpntsc1n6F9le5zD7sFCJGbWbdVUcqITjyrzC75/C+MsmXK9JiLtyZ6tdvfZJ90OMGkZCfxsg7Ugz1BDr/9adRmmc4BG7GxfSwn7t6eZHvV/ZaXn3xPFXD6Ql6GT9C+336kGDQT+3LwmkLopfy2lbNCsbnBFHGtqFfZKxi6+W6ZfihHTuk0cJzjxkVsEybtz7oafGc93YFk3lr9sifpDm5dzlQABwqRi+rvmhuOKx9dn6N94SKZ1p51/mQ2FQIhSLYsCgGKyl98MrOUt3Q2nt/XJtzDg9bRcKfFeG1AeFDyS0YuTdLiytEUPqMO15gv3JurW6iZSeeGrTMSN2eltr8aR+hzTr6gLBPPWAHnzr2ReewdP81dE1JP1FvMAh2bd4Df0ktxXVbTDch7FaLgQDi5ylSYNuzZVRSs/5lauzcTv6PDZrri2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3728.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(8676002)(8936002)(5660300002)(83380400001)(41300700001)(66476007)(316002)(110136005)(66946007)(66556008)(478600001)(4326008)(966005)(6486002)(31686004)(6666004)(6512007)(6506007)(107886003)(53546011)(2616005)(26005)(82960400001)(36756003)(86362001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejNKTE5HdjdMOW0vN2RuV2N3dnBxZnRXVmVTYjQySVMzUUR0eXhBRWhRNGd2?=
 =?utf-8?B?bkhNYkFXTklXM0Z3YWhDbkh5T0dtNVZrUmxyK3Q5M2JuT2dqNzBpRFIyT0ta?=
 =?utf-8?B?ekwrK0ZHcm10ejJrT2JGNDNET2pDNnhTbWNjNmhWUGwrcExlWDBYaXo2Y1lz?=
 =?utf-8?B?T0JlRENUQzBaS0lVQjUwSUJWVEFkcVBGYnl5MHZLWEVsVSs0aFVreGNFWGNL?=
 =?utf-8?B?SmU1RFhFWWVUcURvWGZSTEVxWVRKRk4xZWlHQnRzZGlETGJ4SlJ5ajhMSVFI?=
 =?utf-8?B?M3huYklRSUc2WlU1NWt2VGg5bHQ5NjM4bjJxcytWK3pLRXJqTXZzMHV1OGhY?=
 =?utf-8?B?a09kQmFocjdKa0dhNHBlVUIwRlh2RGd4TUtMeHgxOGNicDBCMXVPdHgzamtT?=
 =?utf-8?B?UHVEUm8vdVhnalplM0Y0NFcwczZWQzc0bkdrdWdkbm95SVhFU2xadlo4Uy9k?=
 =?utf-8?B?cmFNcVBCaXVlaUhHaG1wRmRjdk01SmJWYThkTm1JQXpQZzlvUXNSaVNuK2Zz?=
 =?utf-8?B?UWhKSlREUUNzL01rVXJyRXd4dGJUVUZrUnp1bEF0VFJRZWxBcXFRWDEwREs0?=
 =?utf-8?B?dmNhK3ZIbC94WE1wRlFNK3dmZGhpWnVsZzZLS2hqbVEyUkYwb0I3eUIrTGZB?=
 =?utf-8?B?VGJNTHM3Y21BdFFSM2ZRT0VremdUUk9DajNob0kzVXFQajVDbC83ZTlvK1Ro?=
 =?utf-8?B?UVBEUis0QkpGYi9lODc5VFQvZWxtR3pHMUZsem4rdTdiRjNSMnRwN2gvZXhl?=
 =?utf-8?B?UWs4ODRpSmNtL0pxRWYra1Z0US9oMkNUWG83cVpBTGpNNUd3SmJtZko3TWtN?=
 =?utf-8?B?Y1JzTmE4L0U0SGlaZlhYSDZxOEtuaVZmYlFrZGRjTUZHMzNGdFdHRnJVS1Vj?=
 =?utf-8?B?RitFMTJFeVphLzhmd3NVSGZNaTJHWWhSN1J4SDBpQTlVR1FxRi9udzNRY1Nw?=
 =?utf-8?B?eC9jQzZDem1mcDBUZXovbnFYWFBleDVTMStPNk9ka3hybUVhR3hLdWdNV0lU?=
 =?utf-8?B?RGpFczdjK3NWbnpnODBUZytNRHdMelNlLzhRNGxGL2dmQi9vbGR2SkV2Z1ZW?=
 =?utf-8?B?OWdMby9RcUd6bGtWV2d5NnpQbWh1NmtzL0QvVk5KZk5kMjFiZkZLNUx0R2sy?=
 =?utf-8?B?OHZDVU9wK0hHVzVwdWNISitBVEV1aTZodHBRUnVWdnkrQ1k1bm0yTVlZeW9m?=
 =?utf-8?B?K3B0NVlnaWZwa3BIblU2UVluZVo3a2x1SWdZbVBucVFCVUxXTE9JTkhTdVc0?=
 =?utf-8?B?WGVic2NEZXlnR21OWENVWHFLYTRQZHE3QUlsNVRXdXJzTTJoL05NVjhlbytT?=
 =?utf-8?B?Q0w4THZ0OFdyYzZoQXNSV3FCeW4zUXF6VFZyOG9RVTRnd2RRcHFFMDdBazVC?=
 =?utf-8?B?WEFUYjZNUkU2cGNhOVBJdVM2em14T1V4OUFLeitSbDBiWGtlYW5MczBHOHRU?=
 =?utf-8?B?MmtVUzg0SVVXdUFoblBEOTd5QUxVZXp6elJZU2p5d1V5UnpQMzJSbXhQcGFO?=
 =?utf-8?B?TDJvRGRZWWoyU090aTNrWDl4bFZodVZaMktDTTgyNU1EUEN5eG1rRXZRKzhi?=
 =?utf-8?B?aUI1bldZYi9oQ1E0ZnVRWEhDOWM1RTJvNnkvSzhnamQ2KzhGbzZSMTQ0Zmtr?=
 =?utf-8?B?ZkZGdmhSeFV5cnYxVGJMWHNxakJKT1JFSmRaa2xjaExsSEhTMG9KVmlENzRm?=
 =?utf-8?B?K2gxQ29tNGowa3pKakxEUHc3aWcyVFZwNUVuTnBLaEppQVovNnZ3TGdReWl4?=
 =?utf-8?B?RnNsTHBTVWZaRE5DUzcybnQrUDBhVGNyZUp5aTUrc0Vialp5VnZjS2NtcGhR?=
 =?utf-8?B?VDdBVUliUHZldEttL1EyaHFBZGo4VVN3SjlteE4ydmx1eVFKZWlzUnhEUXFw?=
 =?utf-8?B?OTBscTVqTjNWQjF0QmlNSHpzZlBjRytucHUzVGxIL0VPU2F2MzFXOE1CQjNZ?=
 =?utf-8?B?aGVQYXU4eFBGY2J6cjErM3JDVkRwdnMzdjRlN1lSMVl1ckZmT29paU8rd2FS?=
 =?utf-8?B?cHd3U1lPcXQrK1ZXUFdSS2l1SUl5Mk9kenhtTGVRQ3dIZ2Y3aFdrRjdsK1pn?=
 =?utf-8?B?TThKK3o5UTBrMkdkdVNBZXc1K1d4Y3hrS01lcWp2aCtlVzM0bm1HQnNjUk5u?=
 =?utf-8?Q?o4wTlwC/4DE8xdUHQvypz5CoU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e593b7ae-bf85-45b6-4286-08dbcc9618f9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3728.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 09:15:24.0225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1lydsvbq2l8VhBet99FtYt5QJa5JdyxktI0N73SUF6IfN5N0wymCv42wETUQiiCXPiTuFXEmKJIk7zEZOm2qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/14 13:12, Luck, Tony wrote:
>> Co-developed-by: Youquan Song <youquan.song@intel.com>
>> Signed-off-by: Youquan Song <youquan.song@intel.com>
>> Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>> Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Link: https://lore.kernel.org/all/20230719211625.298785-1-tony.luck@intel.com/#t
> 
> This still has problems.  You should have removed my Signed-off-by. You should NOT
> have added Ingo's Signed-off-by (the only time to add someone else's Signed-off-by
> is when paired with a Co-developed-by).
> 

Oh, this is V3, not RESEND, I should reset the SoB chain.
Thanks for your reminder, Tony.

If my understanding is correct, the version below fixes the tag list.

Best Regards,
Zhiquan

========>
From: Zhiquan Li <zhiquan1.li@intel.com>
Date: Sat, 14 Oct 2023 13:03:17 -0600
Subject: [PATCH v3] x86/mce: Set PG_hwpoison page flag to avoid the capture kernel panic

Memory errors don't happen very often, especially the severity is fatal.
However, in large-scale scenarios, such as data centers, it might still
happen.  For some MCE fatal error cases, the kernel might call
mce_panic() to terminate the production kernel directly, thus there is
no opportunity to queue a task for calling memory_failure() which will
try to make the kernel survive via memory failure handling.

Unfortunately, the capture kernel will panic for the same reason if it
touches the error memory again.  The consequence is that only an
incomplete vmcore is left for sustaining engineers, it's a big headache
for them to make clear what happened in the past.

The main task of kdump kernel is providing a "window" - /proc/vmcore,
for the dump program to access old memory.  A dump program running in
userspace determines the "policy".  Which pages need to be dumped is
determined by the configuration of dump program, it reads out the pages
that the sustaining engineer is interested in and excludes the rest.

Likewise, the dump program can exclude the poisoned page to avoid
touching the error page again, the prerequisite is the PG_hwpoison page
flag is set correctly by kernel.  The de facto dump program
(makedumpfile) already supports this function in a decade ago.  To set
the PG_hwpoison flag in the production kernel just before it panics is
the only missing step to make everything work.

And it would not introduce additional overhead in capture kernel or
conflict with other hwpoision-related code in production kernel.  It
leverages the already existing mechanisms to fix the issue as much as
possible, so the code changes are lightweight.

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Borislav Petkov <bp@alien8.de>

---

V2: https://lore.kernel.org/all/20230914030539.1622477-1-zhiquan1.li@intel.com/

Changes since V2:
- Rebased to v6.6-rc5.
- Explained full scenario in commit message per Boris's suggestion.
- Included Ingo's fixes.
  Link: https://lore.kernel.org/all/ZRsUpM%2FXtPAE50Rm@gmail.com/

V1: https://lore.kernel.org/all/20230127015030.30074-1-tony.luck@intel.com/

Changes since V1:
- Revised the commit message as per Naoya's suggestion.
- Replaced "TODO" comment in code with comments based on mailing list
  discussion on the lack of value in covering other page types.
- Added the tag from Naoya.
  Link: https://lore.kernel.org/all/20230327083739.GA956278@hori.linux.bs1.fc.nec.co.jp/
---
 arch/x86/kernel/cpu/mce/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6f35f724cc14..905e80c776b8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -233,6 +233,7 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	struct llist_node *pending;
 	struct mce_evt_llist *l;
 	int apei_err = 0;
+	struct page *p;
 
 	/*
 	 * Allow instrumentation around external facilities usage. Not that it
@@ -286,6 +287,17 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
+		/*
+		 * Kdump can exclude the HWPoison page to avoid touching the error
+		 * page again, the prerequisite is that the PG_hwpoison page flag is
+		 * set.  However, for some MCE fatal error cases, there is no
+		 * opportunity to queue a task for calling memory_failure(), and as a
+		 * result, the capture kernel panics.  So mark the page as HWPoison
+		 * before kernel panic() for MCE.
+		 */
+		p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
+		if (final && (final->status & MCI_STATUS_ADDRV) && p)
+			SetPageHWPoison(p);
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
-- 
2.25.1

