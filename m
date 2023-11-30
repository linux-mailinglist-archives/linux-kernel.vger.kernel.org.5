Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464007FFF93
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377337AbjK3Xkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377298AbjK3Xkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:40:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DD0172A;
        Thu, 30 Nov 2023 15:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701387659; x=1732923659;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b2ABMl5a8IPS2taARrSicD/3l+YFmUqeyiYnq7oJdlE=;
  b=MGIflrOgXU+dNoc1en196nRZraWbDvgS4ViRj2knva7sNqIP7Hs0RoIN
   stB3YKAUptsbLCEjLZa7m6AJLO/3PB5OC/JIoXvmv4eZJnv7AVqHnAtgD
   M8b/iOFSQMxlfkxS/B58nfBuVIM8YY1HeptjJu/wFph2rH8HDcFhWysnf
   /DnbIESbErcEjZaWfekWV4StQLusMp5J6SuMX8A73c85gd63QV+CS1ldV
   wqZi7xK6JliUkmvvVEh498Vzeb5PVKTBfkvtchywAz1iU4TOSzSL12l3I
   egoF/i1OA8I+Q8cJ+v7ReIbOGKE1WOLib01M5HMMBlpDlzlLd9AmYNI/P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="14958897"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="14958897"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 15:40:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="860366907"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="860366907"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 15:40:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 15:40:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 15:40:57 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 15:40:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj83EAnXMoO+TOq8tsQVgr6BiTBBAbKdhKWWJNdbtxSvaHARbvawZg7JFyyDWyCpD1TAzV9sKCn6OTruzKz1yNHgjC3JyFG7M8PRM8HdJRYpb+3PKNHLuey++vs6rzV5MQtz2cavpAcFKmlgFLbxnNoNHjZAGRLEnzYdse13xgRteEie1VusbLY6LFMJAUukxCIxG1lZuuAhSj3aC+SB+20yBEc+5XYt29KureOjIINBiZ5AlhT26HWXtyLt63XiXLY+LjPgXjKm+sLC5FDCSb/Z54oIU0lhKhev38kc866TAA0EpD90d/z3Rf+8R5S8QZ2FE0qo7mnl9WzPMZnqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UO24XW4ydpdVOID+RUGqffbmdGEN6Mqph1RYvReDCOg=;
 b=PsnCkozyQdxaxBJncY/O7RAgx+5Eq1dZj9Jc2S0QZuGH99FpgcysNOPC1kWVNFdQE01qZAx6NHykuoLckJzXXOcdzHDJViFzfM2Ml7Ib1cy+94fjWDVfIZHThmJzOjQ0OERklIjb7k1VfH2ZI5naGc3bSbyOH1T5KuWdqG9FDZItk87D0exfL8krs5ig4n1bmKDyAFkSiw/Sq9zC9i1QGURJfBiXnY3RR/eW96SF0W5+pdfxHkhUVzDj8P2TM0NCEYEodMwGukaeD77pNeWMreY7Yftg/bo8WpNKT9oak+U2LwA1VFBXQnCdJYCs76wydzMy2Brle8J1ZiNl547Wlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8571.namprd11.prod.outlook.com (2603:10b6:510:2fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 23:40:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 23:40:55 +0000
Message-ID: <5078f930-e56e-45b5-9df3-99e88c0858dd@intel.com>
Date:   Thu, 30 Nov 2023 15:40:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 7/8] x86/resctrl: Sub NUMA Cluster detection and
 enable
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Fam Zheng <fam@euphon.net>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20231109230915.73600-1-tony.luck@intel.com>
 <20231130003418.89964-1-tony.luck@intel.com>
 <20231130003418.89964-8-tony.luck@intel.com> <ZWjOBw0Ygyw226Cc@dell>
 <ZWj3NdI/qLNOgyg0@agluck-desk3>
 <1c1a16a5-f235-4179-9d0f-1556e11d9c11@intel.com>
 <ZWkQBwwtSae4nGgH@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZWkQBwwtSae4nGgH@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ab40fa-0512-4bf3-fa45-08dbf1fdcb86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRO5p8/lRlHEz/bEn77IBfyEksOKZaBL3IFR0wL80JMda2FS0a2QBqGY/lX10xdfAx7vpCwEb0/PMsfodUlY6SQE7ec3mzcxwRHJ+dEP70qr1WXdJG38HP3UHgx9+NWPOuKBUvcdDzrW6XFV+4TC8GGJxHdFoSkgRW8eZyjLtMKI0bpvHtACVUKxuEH9p5qTBMTv9CrlAwMkehFIeMOTUn7HvKtSGsllWf1A+HucuL/fA68IbDpF8UvnU7U5D+q9XxIq3/thw8aREUDWCC+vF39Eqnp0CQQx7rUojvvGhklmaBUdmz7bEmM4EgUHNFHkPwzW2faJPqK4V2HpIIx2fkGo7ER5o1twAN+RjBAfMduAkySIA3jJPaJoei+f86mlnhDq0I26D83mG6z1CNTR3t9+VQDXvnyshpGkWWQbHWHIcKzwCxuPjDoXxYhV5Coo0vk5LIJNMbYpzrgEpSLUWDZzlg7/sFuBHRtuPB6eyLgR2zOZpBwF7ut4fDjlfbOnlm0q6Ivwq5LjMa4OhW5G3nYCf5IfiREdE0Fd9Y7Anec2y2/R55pVQV4BZDRceON/NO8JYWq4ujxKTgXoh3ZRUHsp5gkCZiDHAFGdPl005DrybFCW+Q0lHuQQOh7C+I/hEqCreW0AvQGeyqNtPp3CkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6512007)(2616005)(6666004)(26005)(478600001)(66476007)(7416002)(37006003)(41300700001)(6636002)(83380400001)(44832011)(6506007)(6862004)(6486002)(53546011)(5660300002)(8936002)(66946007)(54906003)(66556008)(4326008)(316002)(8676002)(2906002)(82960400001)(36756003)(86362001)(31696002)(38100700002)(31686004)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODhRSFhYUnY1bXpkN2UrOXVGM2NaQis0SVVVcW1DT1ZNYXYybmdDeVhlMEw4?=
 =?utf-8?B?azJ6bGErUGdvaTRNMlpiajdVR1NIM2JWTmpMOCtIWnNuaVpySkVGOFVmYkpD?=
 =?utf-8?B?SWR3UjFhQ0k1RUoxSWtjeVg5dHZnL1N3SVFsNEVsS1pxWDYrazNWQk5xUzJH?=
 =?utf-8?B?ZVgvb1lYT3B1aGQyYjFpMVY0aCtJV1JQWFdnSUNtSmRjam95R1YwZVg5UVh2?=
 =?utf-8?B?SnJidzhVZ1hJV2h3WFlaVlJXdVllcmlQampYWkM0S24zU0Y0UW52aGxkZW9v?=
 =?utf-8?B?ODBtU2hvS2JOeFhiM1BURFF4TmFFQlhPSkc1RWZ4elBtbE5RRWgxWS9lN2dF?=
 =?utf-8?B?cXNuZG1UWE1JUTNiV2h1dzB6VFJHRXpXYitHc0JWdlZUa25kaytDVTdLeXZO?=
 =?utf-8?B?bFVDOFV0ZmFraWZSekc1VEM0dWZBa250d0xjbDIxcUc2RWU2WG1KR0hMMndi?=
 =?utf-8?B?d2dIMElJYVZYM29pT3dwTlMyUkxjREV6cUN4VmZ5azZiYWkvWlpIMmNSYklL?=
 =?utf-8?B?RkxrcVVyZEZJZ0V3dmllWDd4dU95ZDR5S29xOFVVTHhmTE5ZYnJLYkE4aWlR?=
 =?utf-8?B?eEg5OWJZc3p2bTJrQ0pVVC8xTnRqQ1VMWXZNNFdBL3lxeFNpeHo2L0YvVHlD?=
 =?utf-8?B?Uk5JeURrOVZmai94dHZ1Uk0zZTlmYkFKaEJOSTVKVmJpSUlGZnpob0JRajdl?=
 =?utf-8?B?RFpJMC9sYXZYODZWNnZ5NWFidnVXQldWZ0RTc1MvRmZvb29kSml0SjlTbUlY?=
 =?utf-8?B?dEpPSStxeloyVjR0emFnZTRTQlRZaVBacFdmQ3M5MTFRcHAyTXE4d2lGUjNI?=
 =?utf-8?B?RU0vTUhCd0thSGR6aTYycUlrSWRjeUV1dHhjRVR4Mlg1amIzZGxQMlRsNFY1?=
 =?utf-8?B?c0V5SmwyVzVkbFpqMUc5MGxrY2ppNE12U1QzK3B3K0RnZHJTTnZRSlJoNi8x?=
 =?utf-8?B?aHl4c0pIaURHTGpaUFVrcXZmazhaam1lYzJObHAxTkxVNDViNE5yVHRnSkE3?=
 =?utf-8?B?aVVmU1luN0xCV3NnemUzUTE1STdHTFVxNnU4T1JpZndvTUNEclV2bFA4QVlv?=
 =?utf-8?B?M2pkc1ZMbWM3R2FRWGUrRkh6MCtYc2U0Nk10UU41SFRnUnR4bk85L1FoUGNT?=
 =?utf-8?B?enN6RjF2YktFYUFQMk5DQ1JoNlVxckZ6MGVSZzlpSkxJVHhNRUUwUWxucHZB?=
 =?utf-8?B?SWNxRnBOVUJuejMrZTdRMUVlVnZvSlhiTW1wdmdFc0VyWVVjVzJYSmFwR2o2?=
 =?utf-8?B?akRDQm4xb1UxSy9ueFZmYkxTMkFUeWtpR2ptVE5JdzY0MEo4QlFGTnhWYWJt?=
 =?utf-8?B?L1lSNE11WEpydGxrTjM5S0QyelMwWDh4Z01DN2Q2UjdFYXJxenJaZCtVZzQr?=
 =?utf-8?B?M2xCOXJzSFZKa2RsYkNEcGdlUFl6R25YQjArekhzRG1yaTRvRUVLSDJFV3R4?=
 =?utf-8?B?UkF3dzdCQVJJSWpqaEQ5TlU4YW9LczhvRjRiQ0ZWdHJNTC9HazgySDhhQXMr?=
 =?utf-8?B?QmI5RDZDZlFiT3RwUzd2TTBqWk5CNzRYa2FXekZjNlhvbTJGRTBWUHBobXh1?=
 =?utf-8?B?VmNMeUt5ZFYvTFphWlBIM0VpVWVsbk1SU0Y2djBoQ1M2bjlkWkJIeHkxUW9z?=
 =?utf-8?B?d1BpS3RkQzZDODBrUFc2Wjh5NHhtbnM1WEhIMHluTk1IdFNWM1ZCRjNvcWsx?=
 =?utf-8?B?anJWcjFoQWh4eTBEbUdSTm91eEFjSG85WTQ0OUgxV3Z0dUhRbWpFNzRjNFNv?=
 =?utf-8?B?RjBzZHpoeDZhbHplUVVNVGhubk5POXBHVUkyeFExc2xJV3g0OXZqa3RWa3M4?=
 =?utf-8?B?K29nV0twTHFSOGh4QSsyUXRXVWplcis1RjBXYXd0RENEbEZlRUxQQUV2cWR2?=
 =?utf-8?B?YUZ3OFNPUzl3WG1wQ2g3M2FZRkxGVkVnOHFjdTRSN2l4WVdpRUptUTZxOFV2?=
 =?utf-8?B?dWgxVWtLcnJmckZqTmdpZE9JazJwWEJXZVFINm01c3NrZ1AxRHBtb1p2VGg3?=
 =?utf-8?B?ZFBITEJEWUJvUFpBYmorV252WEtnMlFGR3cwWWxXU1NqRTNwZkxYa3dIb1Iv?=
 =?utf-8?B?QWIyTnRGOTlER3lGaFVuVE9TcjJyajZ3VVpnZFpiTlZyb0c5aG1ZbjRIZFE4?=
 =?utf-8?B?YmNxTUlybDFQK2RSQk5TaXdhTUU0dFZpNlZaUXNmVjc3dU44TW5WRTlGYzZT?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ab40fa-0512-4bf3-fa45-08dbf1fdcb86
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 23:40:54.9094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wr2CewPyPLOsgXHXLJBheuYOp/iTj7ZhMjgf4gYs9/MWZHMZJ37kkmjh7pWed+iSGDpBdWD9GBhuBfUm7lx3QToDocxItnIiihnaxLPpg8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8571
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 11/30/2023 2:43 PM, Tony Luck wrote:
> On Thu, Nov 30, 2023 at 01:47:10PM -0800, Reinette Chatre wrote:

...

>>>  	if (!x86_match_cpu(snc_cpu_ids))
>>>  		return 1;
>>
>> I understand and welcome this change as motivated by robustness. Apart
>> from that, with this being a model specific feature for this particular
>> group of systems, it it not clear to me in which scenarios this could
>> run on a system where a present CPU does not have access to L3 cache.
> 
> Agreed that on these systems there should always be an L3 cache. Should
> I drop the check for "-1"?

Please do keep it. I welcome the additional robustness. The static checker I
tried did not complain about this but I expect that it is something that
could trigger checks.

> 
>>>  
>>> -	node_caches = bitmap_zalloc(nr_node_ids, GFP_KERNEL);
>>> +	node_caches = bitmap_zalloc(num_online_cpus(), GFP_KERNEL);
>>
>> Please do take care to take new bitmap size into account in all
>> places. From what I can tell there is a later bitmap_weight() call that
>> still uses nr_node_ids as size.
> 
> Oops. I was also using num_online_cpus() before cpus_read_lock(), so
> things could theoretically change before the bitmap_weight() call.
> I switched to using num_present_cpus() in both places.

Thanks for catching this. I am not sure if num_present_cpus() is the right
choice. I found its comment to say "If HOTPLUG is enabled, then cpu_present_mask
varies dynamically ...". num_possible_cpus() seems more appropriate when looking
for something that does not change while not holding the hotplug lock. Reading its
description more closely also makes me wonder if the later
	num_online_cpus() != num_present_cpus()
should also maybe be 
	num_online_cpus() != num_possible_cpus() ?
It seems to more closely match the intention.

>>>  	if (!node_caches)
>>>  		return 1;
>>>  
>>> @@ -1072,10 +1073,13 @@ static __init int snc_get_config(void)
>>>  
>>>  	for_each_node(node) {
>>>  		cpu = cpumask_first(cpumask_of_node(node));
>>> -		if (cpu < nr_cpu_ids)
>>> -			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
>>> -		else
>>> +		if (cpu < nr_cpu_ids) {
>>> +			cache_id = get_cpu_cacheinfo_id(cpu, 3);
>>> +			if (cache_id != -1)
>>> +				set_bit(cache_id, node_caches);
>>> +		} else {
>>>  			mem_only_nodes++;
>>> +		}
>>>  	}
>>>  	cpus_read_unlock();
>>>  
>>
>> Could this code be made even more robust by checking the computed
>> snc_nodes_per_l3_cache against the limited actually possible values?
>> Forcing it to 1 if something went wrong?
> 
> Added a couple of extra sanity checks. See updated incremental patch
> below.

Thank you very much. The additional checks look good to me.

Reinette
