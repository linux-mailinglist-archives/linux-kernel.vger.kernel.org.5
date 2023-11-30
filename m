Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F2B7FFDCB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376953AbjK3VrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjK3VrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:47:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850DF10F8;
        Thu, 30 Nov 2023 13:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701380839; x=1732916839;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mA5GDu4ov3SXCLuEryEhnz/LwEnjl07dZWHNXF368Gw=;
  b=eqSL0vvd8sSDbMykTFi7bBNY3pi+xS8Zc8oguyO6oVK6g0RfbrCAlRTV
   Jimp9PDJW8gnwmqskdFrN99EDWkiUoqncYFFTyEVfIE7zLTGTFpCv7BJT
   Y5Zj4au8utgK26IPL76/NdTyGW13A1pTHYWCWEnTsXtzhJaq/BKArL1i6
   zCH4KwFHZ2P3pEUb+K68hpky4IUUyfSvRul+720GJ/ynzNx8YIF6d600Q
   xwEztqz85+3s/QQPGiQA9hfjshGcJodSmZP58jTUQGcmmmiDUwL4dCeZy
   pMIGVOqBpn6wtNUR4SF+NJwbQC3zMBFzsX5gBAWIVYY+62M7dayDmjSOX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="6631253"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="6631253"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 13:47:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="719262935"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="719262935"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 13:47:17 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 13:47:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 13:47:16 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 13:47:16 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 13:47:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geD452dx3RjDw2qZPnOvuh+iwMQJmswpO7LUgtP4DD0PiwD3gf7KOmGrt0h3pdS8y83hl8myftA8jBIoxfc3xBLZCETjI5chh+hni4usAs5mx1EbxjiEllhg+Ko0YEKq82nXnQvIYGYw3pG+GZ5Eg44T6u2Bbml4Kdlfpsh5Btq4Mzmuw5zW1R4Yy09CjCIGF9l7pg837kiDj+FxpBPl7rN+2qWoLQt0jtaOJrjTHynpm+c/LlKKzGm307J2UkxRLUfm80Bnv6WjmC8uiDGUwwCqfMW0rTe9GjNDjFkFwl7r0zsRWptOICObBgjyOW2MtzHWkazqedyvL/7tgl+E8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffWVl9cpYEZYcI5qMHNEocLp8L08JICiAmP59bjc9kc=;
 b=aebrR2eOFGQlbIw/pi/c0/Vyz6KR4Lue5WPJ6nZJNQAenVjW6xpVVRMoaGyHIj/K6SW6kMSuTkyDZHW2pEKpWDnitXZ4kGyVXWUVvXZUwShS/yKSYHl7EIpHLnba3CMCkeMtbbxtZ3PpVHk+P/mtstP08md1Mv293xDHtm3Q3MMFNoCYv+Vqn12TKaNsahpC0CEaSNnH8MHdq103rgZ3iRHQ0m+xOlKp+4jV42WWS72KnE8UIGgqhMg8R6HNFX+NSl1N9MsvrLjvwFBeCO2KxIW9pA55DoE1O8IMkziJghe7zgqtrlxtXSt6vZd//xTwAkcK8TfwCo/Tp8/1yUsQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6089.namprd11.prod.outlook.com (2603:10b6:930:2f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 21:47:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 21:47:13 +0000
Message-ID: <1c1a16a5-f235-4179-9d0f-1556e11d9c11@intel.com>
Date:   Thu, 30 Nov 2023 13:47:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 7/8] x86/resctrl: Sub NUMA Cluster detection and
 enable
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fam Zheng <fam@euphon.net>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
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
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZWj3NdI/qLNOgyg0@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:303:8f::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 285c1d5c-170b-4e89-c607-08dbf1ede9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: diwm+9BayVUeQTupT4AeIQ75xK+n6WqyjCm7pts8jN7GRMV8LKZfN46a3ijAsp4GITsGtQ0eb4BVDlrkGOXHnb7OK03PYBUUyHKZaTVxpuToLs+jvujQ5UCOhYuKvuBipy17HjDdCv3ClZn3kiGYmba5cC92Cwm/wo4pZ5Oj9ft0JXc4EOPD8yRlnHhpfmQHkq6B0v3LTWbXbI1Q/2Ap1LqLJORH4ypLStLtNYg9J18b7HsspGbkzGswR60NyZlImLeZij1DGarhMdib93OAqdy9mXfT7ULNwBDGLyYapPUu7pqmkM6XVAWESJYtfzv3n86ABUefMIEeVn73g9xv2Se+vcTzwFBcXGb5w9n8C01vuSIi/OJx5wRlaSXR+ctfRVrtMMx0SWzXkl+eV4oFufS35p8YfR+P2eUgoApd2FxsYrkPBy5p1jmVCYQ/luo5eMbBVcAIfbqSjj31rK/haXCmIXpkEqoLxgZc4rUpfXAyGzK1+P5QFU7mGMlZ+ha5Z0xWYn/fWI/xwQomMr9uUgpdZAq6FlsZSxef9zGMM7e3C7RlhLezvBSX60R1KZKyUwrd32K2gjEp7Ms0DotdNMmCMaabyOS8csMJi35lmuuIajMr9fCVixZjFiimlua4nypVmDKlPpzjRgvqRdaqrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(86362001)(66899024)(31686004)(31696002)(66476007)(54906003)(66946007)(82960400001)(38100700002)(36756003)(83380400001)(26005)(53546011)(6506007)(2616005)(6512007)(110136005)(478600001)(2906002)(66556008)(316002)(6486002)(44832011)(8676002)(4326008)(7416002)(8936002)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0wyaVovRzM1KzZjdm9yWHBzcXZhUTIwckwwWmxPT2ZWUzJ5T2FPM3lRelRM?=
 =?utf-8?B?VnRlMFFoLzFyKzA1bGFuQWFZbkozYnBYQ2Z3bFdQRENVakR3SC80a01nS2Rp?=
 =?utf-8?B?cFF2YkhoWHNsUTNPNkZWWjdvVW5Ld0kyWGFmdlkwT3M3KytvenIxeHM4ZXRT?=
 =?utf-8?B?RUVzT2R5TTl2QTAvZGFBdUtCOWo0QndDQ21sc1QyRGtISTNlWXQ5cW81N1Vu?=
 =?utf-8?B?bEVENjhWdnZCYi9YWnhFbVM0b09QUHBlb1huMlpXa2swTVltVjI0TGM2Ym5z?=
 =?utf-8?B?aEVGUkRVWXREOFhFdjZrRGJSOHR6TjFzd2xWSzB2ZjdkL1BGNHlXZm5uKzd3?=
 =?utf-8?B?RDkyMTRNd09IQzZ6cXR6U3E4NGd6RmlSWW9xNDY4aTFSU2VWU1FFVEEzOVF1?=
 =?utf-8?B?RTJZcnJDS3pRV251aXpsWWRITlN5MWxaNWxqMzlNOEtJOVhRZVl3bUNCK3ds?=
 =?utf-8?B?MnY3SktiNlhMeXRzdGtrUzRrakxibEVwejZCTkI2S29NYnF3M29CUXVoOVIr?=
 =?utf-8?B?QWNQZllIWTM3cm82aHBIUUhwNVZFMktuVDJpSDZSYUlhN3ROeE54ZGdSbGVu?=
 =?utf-8?B?ayt1UlBveW9jZ1p2WDRlQUJVY1Q4TVNBb21pZ05WcW16OWhYOW8wWFZZc2dK?=
 =?utf-8?B?NWZnRDN1dXk4WVNYUFJjRE1qdUJKKzBMRlIzV3JkR082Tkx5V0dZT2paSkd1?=
 =?utf-8?B?N1ZLV1VJTE0vU3NvNjYwNmFQZEs0VE8yZjNTeEJRZFVkZjZ0b0ZoWlpjZHJ6?=
 =?utf-8?B?eEFQdU1JYUkwSU9yVkdxRk9GSXUyYlAyVGpKTzE3aVFFTlljTmJYeTh2SkNr?=
 =?utf-8?B?RjdNK1NpSWgrMXBZeU5zV2pqWjhZME1LUW9iZzJzSEcvRDNmaU5DTTNaRXBI?=
 =?utf-8?B?MVd6aTNxd1h1bDB2YWIxUmlydzBUQXFjSmZZV0oxUVprMk1SaHVxcCsxVHUv?=
 =?utf-8?B?UGt1N0RRa25YelVVMXZhaWhjTkVVazVhM2c0bUlVVjJNN09QQlJnNGxYU2dk?=
 =?utf-8?B?VGw2TlVhSlI5aGlvVEVCOHRxNEVMdzNuVUowL213SzNwYW5UVUxBQVJZN3ZU?=
 =?utf-8?B?UUR5MUh1RjFtQVAzeVRFeWlNU2NWbk4xcSt3cUdQMUsyekVseUVObUNCS2lr?=
 =?utf-8?B?Y1lLT2JwV0Qyc2tsQmxEaTIxQzl3M0RUM05WVlZaR2dYWVF5aWtNcWJ1a2dk?=
 =?utf-8?B?TGVWeFJzSEdwU2VoWS9wak5pelV5cjd1ZGFTZFU1Tlk3bFptZnNtYVdWMTFW?=
 =?utf-8?B?eXVGclEvRmdYNGQxZWhJdVRRbzFKS1RMRlRuUnR5SVVSMkN4L2JmU1FmTExW?=
 =?utf-8?B?dEhCQ25PVVNZOFRJR3ZJV2FqZjJqK2NXbzM4ZGphZ1pVenJqRGpYR0xzUENM?=
 =?utf-8?B?bXEySnhCV1N3Sm0zL0FMZ0prMkFzY2srOFd4Z2p3M2NDU2lNUkIreUhFR2Z4?=
 =?utf-8?B?KzhnVHQ1VW5CTkdYc2JDVkFlOEdINjhldWZBQktDUFZTZVA2YWl6MGJ4RkFU?=
 =?utf-8?B?a3l5WWVCTDh4eS8xMkttUVRzeWlROS9tcDNqVDRkVytGLzVrUm5naXhYNFk0?=
 =?utf-8?B?UXJ2YWFidjlmSkZDUFRQSnpaNG1NMDlFbTRUTE5LNTBpbXZKMEkrZStJR1Fo?=
 =?utf-8?B?L1crVnF6d3Jtamcyb2t3TVFEY3dVVEl2aUVkZlZFSmlDaHJBR3FyaTVKTUlM?=
 =?utf-8?B?UjlxSnA1SkxBLzhOVGR5YThKOHdrV1FycHpWK0hTOHhwRE9tZDcvVWRCWm1B?=
 =?utf-8?B?MVhJQzlpUGNBTWU1RTA1WWVoWlVzcXBsVHR4Zlc1TnVWdTR4dkhLbDNvdkcw?=
 =?utf-8?B?ZUg5NkJCOGF3OUhXOXIweHlCUU5BVFpXUElPcFFkeXZwRTRXNzkyUmhKZHJ0?=
 =?utf-8?B?VzJoTTQ5dEJ4RUxvNVNxejRNTHJhV2RHbXZBZkhMc1REYnJ6dDd2N2p3SjdM?=
 =?utf-8?B?ZFZXMWJ3cW9DWEFyays2MjQ5TkNOQTNURHZoYUdWSFVlMFRBai9za0RueVRR?=
 =?utf-8?B?WGN5V3BjbHJyazNRK0V0ODAycExqdENESlV3MXhQNWMyNXF5c09Bb1ZnMGZa?=
 =?utf-8?B?SEVZOU40MXZsM05pd3JvRFlrdEpDcmQ5UzZ6aDNzekhGbGpIYlZXaVZKQklJ?=
 =?utf-8?B?Vnp3bHN3MC9NT3NmZ3BtWjM1aTFWeTl3WlBXUmQ0eWFYY1JyUVBaQVk2Rko0?=
 =?utf-8?B?ZUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 285c1d5c-170b-4e89-c607-08dbf1ede9aa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 21:47:13.4712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGz+m40MG4Tfpe2GbsBSf8dPdd9N8p6abzrRBBwxKlRJ3IlYPdhEup9mp6TzNrZTqBau9avutc+fWTxTLt5EtbZeUoSMLjMp6nLwsTN2QcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6089
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

On 11/30/2023 12:57 PM, Tony Luck wrote:
> On Thu, Nov 30, 2023 at 06:02:42PM +0000, Fam Zheng wrote:
>>> +static __init int snc_get_config(void)
>>> +{
>>> +	unsigned long *node_caches;
>>> +	int mem_only_nodes = 0;
>>> +	int cpu, node, ret;
>>> +	int num_l3_caches;
>>> +
>>> +	if (!x86_match_cpu(snc_cpu_ids))
>>> +		return 1;
>>> +
>>> +	node_caches = bitmap_zalloc(nr_node_ids, GFP_KERNEL);
>>> +	if (!node_caches)
>>> +		return 1;
>>> +
>>> +	cpus_read_lock();
>>> +
>>> +	if (num_online_cpus() != num_present_cpus())
>>> +		pr_warn("Some CPUs offline, SNC detection may be incorrect\n");
>>> +
>>> +	for_each_node(node) {
>>> +		cpu = cpumask_first(cpumask_of_node(node));
>>> +		if (cpu < nr_cpu_ids)
>>> +			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
>>
>> Are we sure get_cpu_cacheinfo_id() is an valid index here? Looking at
>> the function it could be -1 or larger than nr_node_ids.
> 
> Fam,
> 
> Return -1 is possible (in the case where first CPU on a node doesn't
> have an L3 cache). Larger than nr_node_ids seems a bit more speculative.
> It would mean a system with multiple L3 cache instances per node. I
> suppose that's theoretically possible. In the limit case every CPU may
> have its own personal L3 cache, but still have multiple CPUs grouped
> together on a node.
> 
> Patch below (to be folded into part7 of next version). Increases the
> size of the bitmap. Checks for get_cpu_cacheinfo_id() returning -1.
> Patch just ignores the node in this case. I'm never quite sure how much
> code to add for "Can't happen" scenarios.
> 

Thank you.

> -Tony
> 
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 3293ab4c58b0..85f8a1b3feaf 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -1056,12 +1056,13 @@ static __init int snc_get_config(void)
>  	unsigned long *node_caches;
>  	int mem_only_nodes = 0;
>  	int cpu, node, ret;
> +	int cache_id;
>  	int num_l3_caches;

Please do maintain reverse fir order.

>  
>  	if (!x86_match_cpu(snc_cpu_ids))
>  		return 1;

I understand and welcome this change as motivated by robustness. Apart
from that, with this being a model specific feature for this particular
group of systems, it it not clear to me in which scenarios this could
run on a system where a present CPU does not have access to L3 cache.

>  
> -	node_caches = bitmap_zalloc(nr_node_ids, GFP_KERNEL);
> +	node_caches = bitmap_zalloc(num_online_cpus(), GFP_KERNEL);

Please do take care to take new bitmap size into account in all
places. From what I can tell there is a later bitmap_weight() call that
still uses nr_node_ids as size.

>  	if (!node_caches)
>  		return 1;
>  
> @@ -1072,10 +1073,13 @@ static __init int snc_get_config(void)
>  
>  	for_each_node(node) {
>  		cpu = cpumask_first(cpumask_of_node(node));
> -		if (cpu < nr_cpu_ids)
> -			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
> -		else
> +		if (cpu < nr_cpu_ids) {
> +			cache_id = get_cpu_cacheinfo_id(cpu, 3);
> +			if (cache_id != -1)
> +				set_bit(cache_id, node_caches);
> +		} else {
>  			mem_only_nodes++;
> +		}
>  	}
>  	cpus_read_unlock();
>  

Could this code be made even more robust by checking the computed
snc_nodes_per_l3_cache against the limited actually possible values?
Forcing it to 1 if something went wrong?

Reinette
