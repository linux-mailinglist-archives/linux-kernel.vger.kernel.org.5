Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CB57A5A2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjISGuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjISGuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:50:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA40D100;
        Mon, 18 Sep 2023 23:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695106246; x=1726642246;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=manKITcYWwCB6LpTBHEbqmgFeC4oFXN3BBPxyxfYT0Q=;
  b=Ka5zqrokbdlRSgi7PgVbAfrGUppLQZb/CSZ65Xt/eJWAlve79SIanUsU
   2HFgb3KYMKI5N8nfcC4nhGWG5X7ul54O3WsntTAWAsblKf/z3dMJ+JYSr
   PTkF95nG4gF2JINZcB5ps7kP0AmUd5a+lmXq0WZSZ0xdOTwxiRTZQn7qn
   qdfD4bQRw8p2UdPywWjuDQdQEVZ96y4OGsuNyz46O33KSTCuauBBujJ57
   OT9uy+zfthcdKSflaE8idgqg53mxQDMBkgej/NSpLv5FxrHEvuxSMHoQg
   MlvbcSOxQcu8AEIC9jv2fLd4DQM2kcfiItmQgX+hzork927G8xZqum7px
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359268018"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="359268018"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 23:50:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="919757365"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="919757365"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 23:50:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 23:50:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 23:50:43 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 23:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgmaE7Rkt0G/DBvDOOQT7yn7YcOWjN/XEYJ9oq9i0b9gyWamsybwdcwBdczRLLtFK9OPSz7upPWs1JRsJem0OYyVB8imJDJ5q8zKCZ4MPsRqKk0HpodpxVga8SaTMUJcHJFnP1qO/5qBwokE7hEfyDskllFj1gJRJPdP9305s/dYbocSvtUfK19//oG4ldwcsppTZFkv15sntKduAPWO0S382bAxPCTNNQCbjHnD2ktyjiCJbSB6AhjtOR4uDRUbpoXzxHZTfkJoqza+xcoGqCRu1IuwHQAIQgixDkk7E/t4yDaXkcwO/eY+VBLxs9bY1QeF+C1WXTXKJCseVStiSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPF9o5ct8Xi8UQ8m94+zVIFS0vxKPf2mItmUAGrCzMM=;
 b=hPQ9QPo4I1QPxTDbwVow8DBT97c2annxJ/QYs6swBv6+eVPpNE2+cO7fJyvOnKYtS307Hu19eoPurIDButKXOb1ge8MCKGIvDo0cgmV7QwW3C9TOhtvmEikoFk6mQHTp6uYgujesGNdNSeX8NV1EjI+bSSfvvQrPDQMU2JAh1hD9SoifSCKj3KS4onV5VarWYJiZzn2Y3+WpGmyisiI8bz3UB0IygHzw5fBG1zPoEHp4cPMmjejNkbHNaggrVtEegJx9ckKuaQGhJ7i9I1Cqn3kX3vyKohuijm5kmrNXA+eKtMTP1izlVgdWJ6A530Lxf4J6/jDx8xFavK5yJtTeWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CH3PR11MB7842.namprd11.prod.outlook.com (2603:10b6:610:128::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Tue, 19 Sep
 2023 06:50:42 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6ecb:9e9a:87e5:f342]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6ecb:9e9a:87e5:f342%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 06:50:41 +0000
Date:   Tue, 19 Sep 2023 08:50:33 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Message-ID: <7gbxb6kxwa6anvcc4dquyuu7yronww6ztelazn2xllplorhbp5@i7o4fum5tjuf>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-9-tony.luck@intel.com>
 <TYAPR01MB633033C489AAC0E514CBC6688BEEA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <SJ1PR11MB60839EB5CC3D172D864DF7A7FCEEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB60839EB5CC3D172D864DF7A7FCEEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: BE1P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::19) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CH3PR11MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 67402029-5f4c-4666-4a14-08dbb8dcbd30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wdAIPgNwohS2d5lsOON5dsujC9Z/8cWGx4zDapiLFUqlXABSTt9kAY2gzGdaQf2sJHoke8dRgqi2QbYzzhu+SzE9C+DYr2kJU4ZnA02+kyFdEYMGbwcfcapw5CxllwMR1xH18EiaMnDVYhm2h2ZeT8XYmxlTtAqOHIavgC7le4A8Bp3JaVq5CqLhZBhfRvyjjPNyNo4pZyqp8A9vob43uSEkVXep8RTO7ClouyMgileXMBJbYdSrLPWjzhdBUNJ/hqs9t5k4SPF+6qPjVTJdAnEFDQAb4oYxgrTdLqOx4gz+IBcPsV7Mh6pybVr+d/dwo84UC+81lIw8WSux7hDbdMTAlhXSOrmQ4VoKQta+xKyT3hPjE+uCmGIbK3cXlFJGgS2J/llmculfkVrEvUFXm1JbbhfUb9b/fy37irpYjBgoQhuSib9EpR3W5vNu58QBD8ppKQ31SEVvXHdRUHKWQfOlIRdqeb595cStCdx3k9xrXMTi2lI5iFNZML5vsWz9Q++J2/aQgxO94tIeUx4hjhDieUaV6bZJv7tHxyKbtkeMw2QW4YOlZQj661qlyha
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(346002)(376002)(366004)(39860400002)(1800799009)(451199024)(186009)(4326008)(8936002)(8676002)(6862004)(6636002)(316002)(38100700002)(66574015)(7416002)(26005)(5660300002)(2906002)(478600001)(41300700001)(6666004)(6486002)(82960400001)(9686003)(6506007)(33716001)(66476007)(66556008)(53546011)(86362001)(66946007)(6512007)(83380400001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elg5NFRpMXNVZEhpYU1icWVqcVN4TTh0TWh1V2x5V1VMWmdKa3NaTEFKUnR5?=
 =?utf-8?B?cVVoTVp6ZXh2a3RRdE5seStKck1PeTFyMnpTcnlpQW1PTHZ6UkhDUnYwZGRX?=
 =?utf-8?B?OFhTc3N3VXFYcmc4VmtPM21xTTdzeWkvbDd1OThuUGFUM2cybWhFK0s2ZUJn?=
 =?utf-8?B?UTQvQy8vcFR1TUFCdnEzUVJYU214VUpIdHFlOHdzLzJaTExDYkpNc2NRM2RL?=
 =?utf-8?B?R2lseW5jMGYwMnFGTjlaeTREYnF2K1dWbWJaVkE3RjVFUGlsMTBndlJrQ012?=
 =?utf-8?B?YnJ2c3U4YnhQcTFRelErTmdRWFYyYzhJYUVIZzBUb1lMaW5UUzg1MlFXdytE?=
 =?utf-8?B?Vy85QVNRU1ZycnUwR1VNeUI5OTdFMU53NG1aVituNEsrMWFxd1grS25MU21p?=
 =?utf-8?B?bGl5aWZJY00vbmRoZ0JLMVoxR2xhV2M5NWJ5ZjZ0YmtJVmNLUkJFakQ4RDBX?=
 =?utf-8?B?K1dlOGR0M0Izd2VpeGlNR2ZOeDBVUzBZaEF3ZDE5QUw2U3A1bXBYMENtaisz?=
 =?utf-8?B?Q29Vc1Q0Yjk5ZVFCdUtNbkhvVUthUC90UmFjbTZFV0MxK3lRSE80L1dCRU45?=
 =?utf-8?B?NE45NUJoWnBGd1pWWkE2aXdCSjRZaWJ4UjcrcEZEL0ZFb2FCLzB4ZGZ1cUtE?=
 =?utf-8?B?dzZyOHJwVWdZMGhyRy9td2g2YStRajB0Um45d0xYQTJVNFRSVkZVSENEMHZT?=
 =?utf-8?B?Z1pmSFZaNlluUkFWWDIzZlY3VUNaWUduMVluZnNMY25TU20wampLOGVGUlZp?=
 =?utf-8?B?a2Z5cGcwUWpTRFNhSzMrV0VmMXdySG9mL1VPQXNkbWR0ZlpVbHVieE11NHJu?=
 =?utf-8?B?SkRSdVJwWjM3NEtQUTJQWDNqaTloOG1uUHhSVTR5azdQWjJYSWZVYThTK2ZC?=
 =?utf-8?B?bjlLbU1NN3NWL0UvUFRwOWJyWmtjZVZKVGwxWHNrMGVtT3ZzQ1piZHJzdVN6?=
 =?utf-8?B?MlRwSU1hejZxZEpRMVd4MTlCV3ZMUUJJTTNpTGQxblVaM2hvNnJIRDV5eTlE?=
 =?utf-8?B?cW1EeDJXMjNTQndmUDNCUGxiNzFxek0yVmNla3RzT3pQMzd2bkRZalVOd050?=
 =?utf-8?B?RkE3QW9CdEJpbWJta2tpdi9PREc3VlY5TUN3Zmp4eVQ2TVhZWm4wTGxxc2lC?=
 =?utf-8?B?aEFMeG13MmFTdTRKcWhtRGxNMTN3UzMyeGhoS01Wb0hDV1FFTHNRaFM4VEI0?=
 =?utf-8?B?RDlITi9mYkhRVVhwUEVxRjBzek1sMjdOUXVxM2QzNUpoaTNlVkpnRHRHMmlT?=
 =?utf-8?B?S1VnUzFoL210enZFbjlDNUZhdkIrWGlTOWF2QXlKNnUrdzNBYlRWRDY3NHhn?=
 =?utf-8?B?WW5kNzNxaHhudkl4OWtNdjFGb1cwaFlLRTdOV0h0RUZzajN0Rjc0Z3EvV1F3?=
 =?utf-8?B?OGVobDVyRlUxaE1MbG4rTHd2UTU3c0oyT1B1enB4TmR2TGVWSldDZ3NMSkhB?=
 =?utf-8?B?SW5YckVRa0N3MWdCalNQdkxqcEw1T2lhbDlGL0JVYU94OXJmVFJuNnBON0o5?=
 =?utf-8?B?bmIxWUNNNkFnZWxBZi9pbmRrMXV1RnY0RzBBS2J4STJxMUxRWDBVbUgxTEZo?=
 =?utf-8?B?KzRFWVNvakV0SE4zNjcydXpyQmM0akRtMWx6L3JkeFNidmJPWWtvQjMzRUZK?=
 =?utf-8?B?cHlDRW1NVUhuNWN5L3BiNEh1aDRZUlJKY3lqYVcwc3pJR2xnWDcxcDZuRTFR?=
 =?utf-8?B?MXluQWJHR2ROTDF0Vk5pWlpFSy8yVEdnOWpOZUFlc0FtOXpFdFRkZ2hFNytv?=
 =?utf-8?B?K1d4Y01xdUcyd2RvVGZKK2RRWEZWeHlXNTYxaTJ2Z2J2d3BLTG0xRFpURXM5?=
 =?utf-8?B?Nm43czdUN21JSHh4ZGhzaFJXSWxJVU5KaFV2dnlWTTBVVnlmWkpaeFV2ZXd0?=
 =?utf-8?B?Q2tOdThlNEl5MWRLZEhCQjVTUHNzb3ZYK2gwQXZKZFRPRGprQXRLNlFyalM4?=
 =?utf-8?B?cGp1b0ZRUmRPQ21jOUNTUm80NXQ3WXJudThkVWcveXhtQTg3Mkh1L05tSU9F?=
 =?utf-8?B?M0dpNkxUMmJJamFUSUlEMnJHeGlWbTJqWHNuUFBXZmVNeXFVN1NuRFIxR3Jm?=
 =?utf-8?B?M2xsTXo2ZG94ZmRGbXFyQTNIMllmai9xS040WTZsUzI2RWIxMlZFYi80ZkdF?=
 =?utf-8?B?KzhJNVZKUkhYWHFJa1ZQTkNnQzRXS1JXUGc3cDlyc0ZnTEFSUUdINkFFS0Nl?=
 =?utf-8?Q?leuwu9/euC1+jz3gkZQBM0A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67402029-5f4c-4666-4a14-08dbb8dcbd30
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 06:50:41.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znWrT1CPvtsxverZtRw4jWUy+eI5a6ci52PJvUqLrMZ9+x/Y3hkPtrkP4Hy0BWAC4gT6Fw4KaQw341KOEsSPvgs3U4mhkWYZTJS2c17hFbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7842
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-07 at 16:19:37 +0000, Luck, Tony wrote:
>> > +   if (4 * node_cpus >= cache_cpus)
>> > +           return 4;
>> > +   else if (2 * node_cpus >= cache_cpus)
>> > +           return 2;
>>
>>
>> If "4 * node_cpus >= cache_cpus " is not true，
>> "2 * node_cpus >= cache_cpus" will never be true.
>> Is it the following code?
>>
>> +     if (2 * node_cpus >= cache_cpus)
>> +             return 2;
>> +     else if (4 * node_cpus >= cache_cpus)
>> +             return 4;
>
>
>Shaopeng TAN,
>
>Good catch. Your solution is the correct one.
>
>Will fix in next post.

I played around with this code a little and I think the logical
expressions are returning wrong values.

On a system that has SNC disabled the function reports both "node_cpus"
and "cache_cpus" equal to 56. In this case snc_ways() returns "2". It is
the same on a system with SNC enabled that reports the previously mentioned
variables to be different by a factor of two (36 and 72).

Is it possible for node_cpus and cache_cpus to not be multiples of each
other? (as in for example cache_cpus being 10 and node_cpus being 21?).
If not I'd suggest using "==" instead of ">=".

If yes then I guess something like this could work? :

+     if (node_cpus >= cache_cpus)
+             return 1;
+     else if (2 * node_cpus >= cache_cpus)
+             return 2;
+     else if (4 * node_cpus >= cache_cpus)
+             return 4;

PS. I did my tests on two Intel Ice Lakes.

-- 
Kind regards
Maciej Wieczór-Retman
