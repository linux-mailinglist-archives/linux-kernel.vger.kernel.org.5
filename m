Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEAE774ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjHHW7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjHHW7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:59:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63BE19A1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 15:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691535541; x=1723071541;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cAEJf13AwC4zpHhUebZcvNBsSX3vQ7SnEdTOmYdhvb4=;
  b=RZV/kJk1QkeYsCgG/2bYLntRgHxtHh2zpV0uRsYzDLX87O4+3YZgfpq2
   s+LllqNPcwcKg1YMm0gTqbuv2hRkximsNmWomvyxirpBQ9O/Ugs4flo0z
   JAvlsCndt0J2Ocu8z2NWHSffbrQgbhIIpAON+Vq9x7OOWs1O8TOGl3D+O
   2m0OkJjUV1TJWMYp1m6yGWwIQ/JDp6zLFgAffIl8XNECGwUxx62K3cRm9
   fWO4oGhebTYyZm0d/h+BChQ80q1kyqFdLisZPeuzimi16xEIvDWkFcCos
   BlpXUA740heaJ9DIimLCciYbnrNMkPNuLku1E+5ntUqKo0o7xOhMUvxrj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="355935547"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="355935547"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 15:59:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="978138461"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="978138461"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 08 Aug 2023 15:59:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 15:59:00 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 15:59:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 15:59:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 15:59:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUI33I0h8bFFBVo5koco/CBq6nrWzxIjHK1UkvpWth/vI27j1IfNKVSkw0vzNDBOyCvpzRcHu+DTTT4Dyo7nM2HP7xlt+BdpMhaQkzoDZrhFFTV9N3mSi5lh9Y3Brf7KRcUdFuv7DIoJrpHx/VIvL5q9lIBkP4Smcljk1twVWzXPvYewexLfib7/HRcMtODaK8x9rGoggkipweYm1YWvzYaflj8hwati6PzeC2aysjeaPj2QiriPWBdbdF7oZfDIxjsVHNxbcrclJ9DLUPSqn7Ro9KZ47mHFj251014GMMP0BxZukcxM9g6Yc5Ut9L0ve3IC4n5eJT2LIDHTqob6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3M4sXeymI4INOViFaLtMo9iXac+jTUkPxU85bmRAShE=;
 b=cImc4qMwWKSH99V5vWyfIDH0jfpvyCDIVg5MNPfvwma3k13cmIfSQeKfltf47NW1T6dQYB3BQxOflRgp1Ykw8puCFYoAbo69lpmAKRPnLa7fqjqBwVLoJE/Ct9tlpIpW+9hX99g4f9uDzXIKiLdmNQxQty8hiYG6nhN0ugA+Z2NmMZdjl8pTr9Gn2YoHnKzW3JpRMy6JwrdJCeqQqvAO8v717Jczy5aHFo7K8RcZDJ8o+nj1Oe1MqbLSe+GEp76jyP+pMzWhPSZFxZGr2CUBybAKcKRWV33it1EZotLYOI+dJ5peZ7u7Sjt4wvL7iRhS22Rf1uklYBqJIuYQ3PLVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB6400.namprd11.prod.outlook.com (2603:10b6:8:c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.26; Tue, 8 Aug 2023 22:58:57 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::70ac:fe46:e033:41be]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::70ac:fe46:e033:41be%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 22:58:57 +0000
Message-ID: <ee7ee03c-43b0-a891-e94e-4a2eb7c5da64@intel.com>
Date:   Tue, 8 Aug 2023 15:58:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [patch 00/53] x86/topology: The final installment
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Arjan van de Ven" <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>,
        "Juergen Gross" <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
References: <20230807130108.853357011@linutronix.de>
 <c8ca9e16-ce03-1fe0-cf9f-f6cc2302dbac@intel.com> <87h6p9l58u.ffs@tglx>
 <7ef60626-28ab-a4cc-2f24-4f35e3d946aa@intel.com> <87edkdl10w.ffs@tglx>
 <20230808221039.GH212435@hirez.programming.kicks-ass.net>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230808221039.GH212435@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:40::28) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b0fcc7f-f25c-45d7-0ebb-08db98630bdf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lfiqD5qjDc1RSTX6JKG0zUkHvZTqvvbP59QJYAEMgGLXgIi7lx2BbP3skHVfMOnqTZ/9dzB08dutzBfT57Jyhm9eP4g/f3U76TWBonCWjR2VPFl6a1lVm/N3FlJ6kDy9ztIDUYtkCpIAGVPPkZf2svTFM6DxgWP3oGxs9TbHFN6FTtXXvHJCP1IUP0Zz3usc7f39ZT05rO/dUQMVcwpb62i/rVAymkLDls9C4KH1fhMuN976tjJ6bjMu9KC3+4xSfqcABpRIdy3tns/oS+YPi9CzMcLEkslDzBTDqe7OuPGk6Zkt3TaSZyNgtsuu9O8/LW9aK89cNgeZtNVGNb+p2QeblnPUUluDjykSwwVG2QN2MSOneFcvarAbFTz4tb46MCKXHRr3PLStmxUlSJ7Zbmhq0AlnoxrLufxJ57JwnN4vqhXnCTUI2WVHvPjGu+wYOoAEdSAzUjwzoMsVdaPGAMDueLnGaj2zS3TodoE1ry4eSoyIyGSQKnoX34Ij1G/lrQtF6GKfC8uqYWtPiz/5WptFeaTl0MmyFoqe/VdZTnoA/9S+nn++CB/2whxEFzvShRL/avaIuxw4XrshdnV9S18YQIhGQKcCP9uh72ALcAbvuchKGTTKTgi+/Pwh7dYlaXFmxsd56Bn6qdCiEKmxWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(376002)(396003)(366004)(186006)(1800799006)(451199021)(2906002)(66946007)(66476007)(4326008)(6486002)(6666004)(83380400001)(5660300002)(44832011)(7416002)(41300700001)(316002)(8936002)(8676002)(66556008)(110136005)(54906003)(38100700002)(2616005)(31686004)(478600001)(82960400001)(26005)(53546011)(6506007)(36756003)(31696002)(86362001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTlXL0U3ckFzeDFJL1RiUGdoK1ZXRHBYQ2xhanNWN01WSnFrd0pmeDh2emVG?=
 =?utf-8?B?cjdpWXpsaGNZUDIwWXFSakZtankwY3NrVU94cGRVWG5aTVgydE90K2Vka0tP?=
 =?utf-8?B?Uk0rSU9YMTdoM0M4aXkvRGhOUW51SGtwL250TXFlc2l3STRENlNmNkVkRElZ?=
 =?utf-8?B?OVlpeUF5SmdPUVcxRi96UkJtRmNaRUhlMWZ1N1pmZnJpQ1ZKczg3dncwZjlo?=
 =?utf-8?B?NzU2TVp2bS9UOXNCQnhJa0p4bmZnOHdXUzFFZEU3QSttb3FVdk44d25xa0cx?=
 =?utf-8?B?TUlhNXJWa1FYTTVKdExHZDVKQXpudStXK2NjeHRrMmMwanZmRnYzUXlwNUFK?=
 =?utf-8?B?RmdJUWNWMXVRTStJdTNpMjE4QlhqVGFkQ1lqVndhbm9HVTloVDBKL1VhRUhv?=
 =?utf-8?B?a2syVUk3dUtlbiszSUZ4b3l5SVJNSnMrUUdHd25FNkJHZHcxNVI4aEhiTnZh?=
 =?utf-8?B?RFlpblJSaFBTQmtxZC9kWHNyR1BqWE40c0ZsTWYrSURkQ05tZjYvOHRTNlBK?=
 =?utf-8?B?MnhjRFcwMnJ5T2hBeGRXSHFDbXk0MEV1bGtmUUdrTXVjSWlwTGlCTXpwdkxE?=
 =?utf-8?B?VFFOTmZiYzdza2tlK2lISlR0QWUzL3ZoZDRxU0p6NXd5WTQycmJYdE55djZG?=
 =?utf-8?B?aDhWM0s1VmtNcmVFanErc3lxdkc2M1JRTnJvY2lISlkxaEt0SVNjUnB5L0VY?=
 =?utf-8?B?NzVlSmw1VzcwN25WWlF5VGZsRUk1SUUwQ2g4OEVJYU9KdVRIUFU1QnZaYXlS?=
 =?utf-8?B?NUdKakRRVlVwK1VWWU0zZGRpbzVsbzVZR1lBdmxFZXpTcnhhOStBQlU4QVU1?=
 =?utf-8?B?UGYzakJpaXJkZjd0Y1d1Q01rUlVZVDk5NllLalZQdDkxNG5RS1hUdzQ4djVq?=
 =?utf-8?B?TTlYbGtRcG1ZODY5U09YUXdpVWFQQ0l6NlFteG1HeVo0WDcrc2VuNE1KNTVR?=
 =?utf-8?B?UXl1OGxWV0I4SzRkRlFuZFc1UnlEUkdqUkVheldQRlh6aGJIVy9UVHBZMmdG?=
 =?utf-8?B?ZEZ1d21rS2lPTFhwQytEY1hvZ2VvWnZsQ2hUSWUrendheVF1UmpYRnZUazFV?=
 =?utf-8?B?bU52NkFGQnlLdlRDYjNOWGJaUDlFMmFDUTQ2MjFib1RsWm9sQW1ERG0wdUxx?=
 =?utf-8?B?a2M4TWpSSS9kY0I4bkJlQlBtVklkSEl3QjB2UmhXSW51RXEzUWZNYUNLRUhN?=
 =?utf-8?B?SmlIZWZpTE92M3pPK0FjbzM4UGsvbVRMOGMwdWpGdFlEcWY4ZFJYazBQb1k2?=
 =?utf-8?B?bmJSWS9KcTMwYVdqY25RcjF3RmUxbm5NOXVBdTU5SjQzOEJ4WDJuNFZiREdl?=
 =?utf-8?B?R0V3VmRoT21sbGRxMWRpcXo4eDA0aXJSSUljZHlFZ0wwQzJFNUwzbE1iMUJJ?=
 =?utf-8?B?Q2swMmZsb0R5WU1nUStHcjh1S0N2UG8zMWpRWVZnWVZnbkhsK1FVSWtsdXpl?=
 =?utf-8?B?UWRSclRkd3pEdlFSZm41R3dqcm1lMERsbndyY2xKWURpNElTMUcyb1JqMk85?=
 =?utf-8?B?dVVDOWNGMC9GT1RLOFJ2SFY0QStCTkxMbHFyYWhMbEF4blRUaldxakRSclB1?=
 =?utf-8?B?K0t1aHQ3Z0VGZHV3ODBvMVpuVk9iUVFBZDc1Sy9zVk5WQlordkxHYmc1UUN1?=
 =?utf-8?B?T2N4NEVQWjAxMkhOQnZLQTQrTmJJenluUHNiY2JtelBNM2l1ei85NmNxR1dl?=
 =?utf-8?B?ellFbXBqWW5TbGIrVXBaNzQ2aVFhK2tlNVFCMjVhaVl6Wmdnd0x1eXdtcmdv?=
 =?utf-8?B?OVV6Y3RoOXNOMnByVnlJZmRpTElNTjhwWGlHQ2tsOTlheGFkMS9GTVFpazNK?=
 =?utf-8?B?SVI1Zm0rM29xdmJKUHNNSUJEeitrT0UvR2hzUy9kZHJ6RkJMaUoveTNVSjcy?=
 =?utf-8?B?Y2VzV3Q1Vno0THk3eHNSb3F0V2N6R0IzSUgybE1WRmJ1ZDQ4RERtclpVOFhm?=
 =?utf-8?B?YjRtM2dpZFRGSGtBd1prYVAvWG0wejJKU1lSNzI5MTlOZzBIdWpJbWxLTTZM?=
 =?utf-8?B?T1dTSmpoQzFMUUFqSjZiSU95c096cTJvWUVUUEc1aHdDOEJiVDhXKzhwVXd1?=
 =?utf-8?B?eHRueTRZalBOZnBNNHpqZDhVVEJFbXo3V280OHlSQVFLS0VGNzhzUXdvbmR4?=
 =?utf-8?Q?LW3Jyx/R18f7TiSDy9DyhppF8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0fcc7f-f25c-45d7-0ebb-08db98630bdf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 22:58:57.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JPFjyHNmiUZTtCXWwbja2haOioy804bTSjSYPs9bLNKCE/feenQsp07wp13sQ3Uwnv+DWksj9JjSj38pSQ2Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6400
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/2023 3:10 PM, Peter Zijlstra wrote:
> It works better if you move this hunk into acpi_parse_x2apic() instead.
> Then I can indeed confirm it works as advertised -- also having one of
> them afflicted ivb-ep machines.
> 

I had a disappointed email typed up and was about to send it when I saw
this.

The inconsistency and warning on my system resolves with this. I lost
120 imaginary hotpluggable cpus but other than that everything seems fine :)

CPU topo: Max. logical packages:   2
CPU topo: Max. logical dies:       2
CPU topo: Max. dies per package:   1
CPU topo: Max. threads per core:   2
CPU topo: Num. cores per package:    10
CPU topo: Num. threads per package:  20
CPU topo: Allowing 40 present CPUs plus 0 hotplug CPUs
CPU topo: Thread    :    40
CPU topo: Core      :    20
CPU topo: Module    :     2
CPU topo: Tile      :     2
CPU topo: Die       :     2
CPU topo: Package   :     2

domain: Thread     shift: 1 dom_size:     2 max_threads:     2
domain: Core       shift: 5 dom_size:    16 max_threads:    32
domain: Module     shift: 5 dom_size:     1 max_threads:    32
domain: Tile       shift: 5 dom_size:     1 max_threads:    32
domain: Die        shift: 5 dom_size:     1 max_threads:    32
domain: Package    shift: 5 dom_size:     1 max_threads:    32

/sys/kernel/debug/x86/topo/cpus/39
online:              1
initial_apicid:      39
apicid:              39
pkg_id:              1
die_id:              1
cu_id:               255
core_id:             12
logical_pkg_id:      1
logical_die_id:      1
llc_id:              32
l2c_id:              56
amd_node_id:         0
amd_nodes_per_pkg:   0
num_threads:         20
num_cores:           10
max_dies_per_pkg:    1
max_threads_per_core:2

Sohil
