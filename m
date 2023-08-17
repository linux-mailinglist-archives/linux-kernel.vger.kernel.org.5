Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3592777FDEE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354464AbjHQSez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354451AbjHQSeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:34:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7D01BE7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692297275; x=1723833275;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LKQYsJ9cQjzZoC8XfDyhTlJaXh9BuHAgwnXdgrjQMOc=;
  b=Yg8wI1xykD9YmVaL3e5i658cYdbEoqVzL3KWAZoHuOOr20b3B9Mg+rFJ
   lc3ZCh+jRahy2jq1vV9oHOMnLlkA+sxXAJU3EvRt6+7Ixs+dmac4Ro7YN
   j1vHa9Yq36bEqbpL0oR2hBlIb1E5KdvQZuGHuLZq457ZBHg6YNdY6qtjD
   u9auQyue0irSDM2p+AVfFHGt8vkywsHePH8h2bHIJAhmurG/aBOATrtf0
   n7BYnPYXMKzbejLnYukEoAZktDMzZHaXhFMIDktheLjxa7ygoG5dvr9Yb
   L+VnSwB+Hh2v1wOQZzEr9D1r6O92VlbqUtBBkZq+b4TZcL7KNMHuF96SG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="352484448"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="352484448"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 11:34:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="728258076"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="728258076"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 17 Aug 2023 11:34:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 11:34:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 11:34:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 11:34:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 11:34:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9OmaSbwCDGg9smNPJXrwq1DwvuLgKVUwwsFE5sGQivVXy25TVArfFU2a5wiBgx5vLSSig3GBY04d2B24V1seRRlq9z5UkwJXXFdd7jxKGnj00Wd0CnCt/8iD+tB2B1drhG5bn9tElwDumx9AdPycKVexKOC5WbEhGKmlGcDyOpzZorGidBcAJ1D5X21ZjegTQ1e1ormBH7OuyF23baO/gaf14GD9XqNF+KIW9LgemdDiqw5+WCyZ4+oqESwfX0SQtWc8wptVYUCWIuBWOIaV9GwAK6a/v18+HoX5pDYJwPQI5csAMQTnQXqC1y4SumjESmfAX4TZxQsMEnBwmCvEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+ClBV4afhq//X378s1cVZsd2rzNpgKPEgLquZRoUBs=;
 b=MGzUitPSkrx6Ij37QOF8kw7UFammc2TFrR4+fL0wHJB/2Ohpy4dAz7rD+Pj4qh2FOLjNrrxRS8jRYRz4VeIK6Cc2cmAuc4Wapinh90JsThkVciVoISo89u0UP1PFqTGTqmSlH3yXVrbzw/prfiC4QMpncVqeZFt6Fxcp5fI+i827Vqt4ZqN58iqUv66ic4hs1zi5Tlvnv8Rdnqoz/grJSKL9qEVO/01rwAO99E720yPihGlywTjCdP9eVUaDGS8e9fiK7rREwNFkZMaZeZfZY7vPyIMId8EEp2kAR6/iV/SeAxBQz/RuIUqheUegsjtBQMGo14F9do/xTc1mGwKzbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CH3PR11MB7321.namprd11.prod.outlook.com (2603:10b6:610:150::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 18:34:31 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 18:34:31 +0000
Message-ID: <99939c7d-3c8d-f1d4-9226-81f32925e045@intel.com>
Date:   Thu, 17 Aug 2023 11:34:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v5 19/24] x86/resctrl: Add helpers for system wide
 mon/alloc capable
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-20-james.morse@arm.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230728164254.27562-20-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:74::19) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CH3PR11MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 63cfe8ec-bea6-44a8-e321-08db9f5098ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/0ecEKZxqeRf5nh9KxqTUxyS5C9zFh4oIV4T5g+B7o8ehrWZ16vZz4D0OAUBPrqs9yT+c7diPrY0aB0YluJgUH0E8/EGJxB+rfBYBpV6JNvH17nGsZNzpWNLw5z9Njk8N1l53BrTHa+jdVVzO9BydlEzbtQGiksW8nnENKcLH5qruoGVtfO4aF0AWL9OgtNeu8l5STfTHCCyMuuPiYgFkkKb0O6z9i0wp7jFbkmBCgj7/HHdejqdxjJBY9ZQEp0g//U50YxV+voAjbM+5xWecmk9EDK1HqTiEh+TSs659EQvkD9KkKCTB6cBxqwVu9CoNja6ZW1CCuPG2hinuB8LcMuRYWn08XXEAFdFQl71mZrqEZxcdjT+51vK5AjGK5kHJGxTRvs7fhEjpWYgxupYcTyANvdE68UGQkyMUADp05KJS2S+msrXPUMLaXaoBxh3pon6hD3ZHyQiD1EfAUwvsjw/WiR8DL9x218AS/rJVdJxQs42AKC0LtAYIUj+t0k9xKb5JOZHQP+TdHVgc47PLkwc2xXT44MpjLHYmva19juFFH+SJJMo2iHHi3Em4yBuyRAbgdi2J9uEXRR3nkD4dE7MZjPvI3PPa2CfHM0m6c7J3cqQNeHpZeT4RlsIN0/J7KzEnwqXCzfG5SL4MmM5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199024)(186009)(1800799009)(316002)(54906003)(66946007)(66476007)(66556008)(31686004)(5660300002)(41300700001)(44832011)(38100700002)(8676002)(8936002)(4326008)(82960400001)(26005)(2906002)(31696002)(30864003)(83380400001)(478600001)(86362001)(7416002)(36756003)(53546011)(6512007)(6506007)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bksyam9idGp6U2R1b09ScVJ0czJ4MzJGTGdXZXhWQXlXcXk2VmlCSGxPQWF3?=
 =?utf-8?B?MkllRzVnRmw5OWNSVXNpeldxWDVkckZnNzRJRHNLZkU5aEVSMlpIRHRNVDFU?=
 =?utf-8?B?OHZ0SVJWNHpFUStXOEltc01EYTBlNndKTXE0MjJyT2x5REo5T2F0MldidHRL?=
 =?utf-8?B?N1pGQlpLWGlpakdGV2g2OCtGSm5Uak5BYmRNd0JqWU5remszcEp6VGpEZFE3?=
 =?utf-8?B?dXpmQ3RoQmU0RUNPM0dXVzhZTzEwWlJMQjM1emNNOFM5a0QrdytWaU1qOHZZ?=
 =?utf-8?B?YmRnS1EzSlZZODhEd2REVnYzTVZxeGorWlFnUXZkR0xRT0VZbEoxb0tkODJm?=
 =?utf-8?B?TUM3Y2x3VXl2MlFLaFFNSnFTU085dkhjTUkzeDBjY2tWbTdyZmo4aEpBczdk?=
 =?utf-8?B?SmN3dktlWVZla2thSXBLVHg4a0dCa3JBc0l2YXhDSXMwaUoxaXRYZWduamQ0?=
 =?utf-8?B?azRsdGk2UTEzWDJ3SHl1WnRXaSsvOVVoekN5VmlXQ0FvUDZpaTRMNDNKSkMz?=
 =?utf-8?B?M1JRRlQrenVoakl4MkhUUThHTVZLbXZTeFdkWS84akJRUkNqZGtuRjJDS1dO?=
 =?utf-8?B?VTl3U0l1TUg5NGJ3YXNSUHY3Q0kxM0NhS2FYMC9wK3NMbno4bjNab096endT?=
 =?utf-8?B?K3QxRmtYYWROSE9YaVFxby8zUzRQYzVSbmY1d3crZXpCL0hpd0NoSVVPSmRJ?=
 =?utf-8?B?M3VQR0I0VDErR1gvamRxelhuRXphc01YTlpFOU1lakdKQzRXd3ZZTm85WnY3?=
 =?utf-8?B?TU53WVczVWNwSjN1OVAvZ0dTalhBM3pyb2hnbUZQN1kxWlEycFE2ZFJWa3cy?=
 =?utf-8?B?NzFVSzR6QnlUTW42U1RlZUZZUzVsbXQxZEtxUWFtT0hXeUhZcDRaSVVNN2Zv?=
 =?utf-8?B?cXM4dExpVWVxd1pnRDU1TVh4bEFNRTRLc3F4dGxXVHBrd2ZYSDRreG9YUDB6?=
 =?utf-8?B?WERBTlQvTjRqbGtZMGpwRW54bXFLTnd3RmNveGpOOVVqRTBWcFRibFZIa0JJ?=
 =?utf-8?B?aHNKYjNBZGk5V05LQnRTbkQ5YitlN2c0R1grNnJkM1J3RU1UUCsvcnIxYXJP?=
 =?utf-8?B?dEdjaTJaT1VHZHlENjFFUEN0Y2E5c2RHTUFEdElTZTI3eGFCSWhPY3hxNnhM?=
 =?utf-8?B?aEVXeG5FeW91bnZxVUNPVmxsaHB2cE1MWkszVEZEc05OWEVTVHpidk5ZWDZP?=
 =?utf-8?B?d2RvV29McThuK2FsTWFXODAvMmI1dUNNS3FBa2Z5VWwyczY1NmZpenR4SHFt?=
 =?utf-8?B?eXdSZlVPTjJyQVdjamEwOHJmMjNnQW5iM1ZBTnprWUhiaWpST2FrUE92ekd4?=
 =?utf-8?B?VXVJK3RQenhsanRoU3dTR2JyK2JnbkZZNDIxVjFFL29yZUFoZjF2MWQyekox?=
 =?utf-8?B?d2pYcTJDYjdMY1ZoUFNEOUYzZHZCemlzdk1tcTF4cXhxV0pxUTc1eUVQQjZw?=
 =?utf-8?B?V04zY2JBbjN0VjZGY3VLTlRtdkdhZSt6ZXpWMzN4WVVaMHJLaWIzR0hMamVY?=
 =?utf-8?B?L3A1Z2VrVW0vSWp5d21hTTBxT3YxUDlHa1VicE9jR1ZLZGxXa3o4M1N5WWc3?=
 =?utf-8?B?MVdJMGw3T05PaHhGSWdKbm1oMnRGS2wrZkFNTTJuZjdBWVh0alo5d0g3bWow?=
 =?utf-8?B?bkM0Ly9KMUN2WkZCSnhSS3VOd05CK3l5YjI0Wm1WS0ZwbkxjSGZydTZnNG1K?=
 =?utf-8?B?WndIaGJXK0xlcWJBNmtvOWtHekVTM0gvVGRnTVM3OUxmZVBqOWgzQjJqR1Rh?=
 =?utf-8?B?VGREUnpiV0EvMElrRGdFVHJYUHpCOEo1QlFnQjBxeUYxdGdzR1NHUklsei92?=
 =?utf-8?B?QkhJTmtyLzBJd2tSZlBUemtjVXdPazFJSjBwVXJ6SDhGOURGeXhPeXRKOCtL?=
 =?utf-8?B?ak15cGc3UVdJZXdETzhQTmpJNmt4eTExMVYzQjB1amkrcXE3cjdkeG1mRHFV?=
 =?utf-8?B?SlJqUUFMZkEwRENCWFBqdFMvK2tKTHJoREIyS0tSVXNTaFZKQ3RXTzhGQ1Vm?=
 =?utf-8?B?bzRrNytMOWUwL2pTSHBJVkpDU1BDKzZIbitNKzhxQkZwbzRVZ3VKSDJqYWFV?=
 =?utf-8?B?aVo1NFlmOU1seVlEbDNGUnRPTzV5RGZoOU9Va2s4UWJRT2EybkgyRTBDVDhk?=
 =?utf-8?Q?hiH2HiB8Eyy7Juz3YwxLBM1Au?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63cfe8ec-bea6-44a8-e321-08db9f5098ba
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:34:31.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Trr9Y0J/JENZefbUFCZBHzKqRy6WE2tKfBi05GMADoOVXjf/W6R3lMWmD+MPqcrx1ueQkbLcXxiDw+9H+Xmz0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7321
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James,

On 7/28/23 09:42, James Morse wrote:
> resctrl reads rdt_alloc_capable or rdt_mon_capable to determine
> whether any of the resources support the corresponding features.
> resctrl also uses the static-keys that affect the architecture's
> context-switch code to determine the same thing.
> 
> This forces another architecture to have the same static-keys.
> 
> As the static-key is enabled based on the capable flag, and none of
> the filesystem uses of these are in the scheduler path, move the
> capable flags behind helpers, and use these in the filesystem
> code instead of the static-key.
> 
> After this change, only the architecture code manages and uses
> the static-keys to ensure __resctrl_sched_in() does not need
> runtime checks.
> 
> This avoids multiple architectures having to define the same
> static-keys.
> 
> Cases where the static-key implicitly tested if the resctrl
> filesystem was mounted all have an explicit check added by a
> previous patch.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Changes since v1:
>   * Added missing conversion in mkdir_rdt_prepare_rmid_free()
> 
> Changes since v3:
>   * Expanded the commit message.
> ---
>   arch/x86/include/asm/resctrl.h            | 13 +++++++++
>   arch/x86/kernel/cpu/resctrl/internal.h    |  2 --
>   arch/x86/kernel/cpu/resctrl/monitor.c     |  4 +--
>   arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  6 ++--
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 34 +++++++++++------------
>   5 files changed, 35 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 3876d4bb4bed..63a4a2332d61 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -38,10 +38,18 @@ struct resctrl_pqr_state {
>   
>   DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
>   
> +extern bool rdt_alloc_capable;
> +extern bool rdt_mon_capable;
> +
>   DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
>   DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>   DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>   
> +static inline bool resctrl_arch_alloc_capable(void)
> +{
> +	return rdt_alloc_capable;
> +}
> +
>   static inline void resctrl_arch_enable_alloc(void)
>   {
>   	static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
> @@ -54,6 +62,11 @@ static inline void resctrl_arch_disable_alloc(void)
>   	static_branch_dec_cpuslocked(&rdt_enable_key);
>   }
>   
> +static inline bool resctrl_arch_mon_capable(void)
> +{
> +	return rdt_mon_capable;
> +}
> +
>   static inline void resctrl_arch_enable_mon(void)
>   {
>   	static_branch_enable_cpuslocked(&rdt_mon_enable_key);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index ac39fecba4ca..f99e0a1f39c8 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -136,8 +136,6 @@ struct rmid_read {
>   	void			*arch_mon_ctx;
>   };
>   
> -extern bool rdt_alloc_capable;
> -extern bool rdt_mon_capable;
>   extern unsigned int rdt_mon_features;
>   extern struct list_head resctrl_schema_all;
>   extern bool resctrl_mounted;
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 5350d44b16b6..c0b1ad8d8f6d 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -842,7 +842,7 @@ void mbm_handle_overflow(struct work_struct *work)
>   	 * If the filesystem has been unmounted this work no longer needs to
>   	 * run.
>   	 */
> -	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
> +	if (!resctrl_mounted || !resctrl_arch_mon_capable())
>   		goto out_unlock;
>   
>   	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> @@ -879,7 +879,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>   	 * When a domain comes online there is no guarantee the filesystem is
>   	 * mounted. If not, there is no need to catch counter overflow.
>   	 */
> -	if (!resctrl_mounted || !static_branch_likely(&rdt_mon_enable_key))
> +	if (!resctrl_mounted || !resctrl_arch_mon_capable())
>   		return;
>   	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
>   	dom->mbm_work_cpu = cpu;
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 5ebd6e54c7f2..460421051abf 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -567,7 +567,7 @@ static int rdtgroup_locksetup_user_restrict(struct rdtgroup *rdtgrp)
>   	if (ret)
>   		goto err_cpus;
>   
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>   		ret = rdtgroup_kn_mode_restrict(rdtgrp, "mon_groups");
>   		if (ret)
>   			goto err_cpus_list;
> @@ -614,7 +614,7 @@ static int rdtgroup_locksetup_user_restore(struct rdtgroup *rdtgrp)
>   	if (ret)
>   		goto err_cpus;
>   
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>   		ret = rdtgroup_kn_mode_restore(rdtgrp, "mon_groups", 0777);
>   		if (ret)
>   			goto err_cpus_list;
> @@ -762,7 +762,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
>   {
>   	int ret;
>   
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>   		ret = alloc_rmid(rdtgrp->closid);
>   		if (ret < 0) {
>   			rdt_last_cmd_puts("Out of RMIDs\n");
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index ce1ed485e4f7..fef78a3dc632 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -630,13 +630,13 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
>   
>   static bool is_closid_match(struct task_struct *t, struct rdtgroup *r)
>   {
> -	return (rdt_alloc_capable && (r->type == RDTCTRL_GROUP) &&
> +	return (resctrl_arch_alloc_capable() && (r->type == RDTCTRL_GROUP) &&
>   		resctrl_arch_match_closid(t, r->closid));
>   }
>   
>   static bool is_rmid_match(struct task_struct *t, struct rdtgroup *r)
>   {
> -	return (rdt_mon_capable && (r->type == RDTMON_GROUP) &&
> +	return (resctrl_arch_mon_capable() && (r->type == RDTMON_GROUP) &&
>   		resctrl_arch_match_rmid(t, r->mon.parent->closid,
>   					r->mon.rmid));
>   }
> @@ -2519,7 +2519,7 @@ static int rdt_get_tree(struct fs_context *fc)
>   	if (ret < 0)
>   		goto out_schemata_free;
>   
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>   		ret = mongroup_create_dir(rdtgroup_default.kn,
>   					  &rdtgroup_default, "mon_groups",
>   					  &kn_mongrp);
> @@ -2541,12 +2541,12 @@ static int rdt_get_tree(struct fs_context *fc)
>   	if (ret < 0)
>   		goto out_psl;
>   
> -	if (rdt_alloc_capable)
> +	if (resctrl_arch_alloc_capable())
>   		resctrl_arch_enable_alloc();
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>   		resctrl_arch_enable_mon();
>   
> -	if (rdt_alloc_capable || rdt_mon_capable)
> +	if (resctrl_arch_alloc_capable() || resctrl_arch_mon_capable())
>   		resctrl_mounted = true;
>   
>   	if (is_mbm_enabled()) {
> @@ -2560,10 +2560,10 @@ static int rdt_get_tree(struct fs_context *fc)
>   out_psl:
>   	rdt_pseudo_lock_release();
>   out_mondata:
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>   		kernfs_remove(kn_mondata);
>   out_mongrp:
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>   		kernfs_remove(kn_mongrp);
>   out_info:
>   	kernfs_remove(kn_info);
> @@ -2815,9 +2815,9 @@ static void rdt_kill_sb(struct super_block *sb)
>   	rdt_pseudo_lock_release();
>   	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>   	schemata_list_destroy();
> -	if (rdt_alloc_capable)
> +	if (resctrl_arch_alloc_capable())
>   		resctrl_arch_disable_alloc();
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>   		resctrl_arch_disable_mon();
>   	resctrl_mounted = false;
>   	kernfs_kill_sb(sb);
> @@ -3197,7 +3197,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>   {
>   	int ret;
>   
> -	if (!rdt_mon_capable)
> +	if (!resctrl_arch_mon_capable())
>   		return 0;
>   
>   	ret = alloc_rmid(rdtgrp->closid);
> @@ -3219,7 +3219,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
>   
>   static void mkdir_rdt_prepare_rmid_free(struct rdtgroup *rgrp)
>   {
> -	if (rdt_mon_capable)
> +	if (resctrl_arch_mon_capable())
>   		free_rmid(rgrp->closid, rgrp->mon.rmid);
>   }
>   
> @@ -3385,7 +3385,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
>   
>   	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
>   
> -	if (rdt_mon_capable) {
> +	if (resctrl_arch_mon_capable()) {
>   		/*
>   		 * Create an empty mon_groups directory to hold the subset
>   		 * of tasks and cpus to monitor.
> @@ -3440,14 +3440,14 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
>   	 * allocation is supported, add a control and monitoring
>   	 * subdirectory
>   	 */
> -	if (rdt_alloc_capable && parent_kn == rdtgroup_default.kn)
> +	if (resctrl_arch_alloc_capable() && parent_kn == rdtgroup_default.kn)
>   		return rdtgroup_mkdir_ctrl_mon(parent_kn, name, mode);
>   
>   	/*
>   	 * If RDT monitoring is supported and the parent directory is a valid
>   	 * "mon_groups" directory, add a monitoring subdirectory.
>   	 */
> -	if (rdt_mon_capable && is_mon_groups(parent_kn, name))
> +	if (resctrl_arch_mon_capable() && is_mon_groups(parent_kn, name))
>   		return rdtgroup_mkdir_mon(parent_kn, name, mode);
>   
>   	return -EPERM;
> @@ -3779,7 +3779,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>   	 * If resctrl is mounted, remove all the
>   	 * per domain monitor data directories.
>   	 */
> -	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
> +	if (resctrl_mounted && resctrl_arch_mon_capable())
>   		rmdir_mondata_subdir_allrdtgrp(r, d->id);
>   
>   	if (is_mbm_enabled())
> @@ -3862,7 +3862,7 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>   	 * by rdt_get_tree() calling mkdir_mondata_all().
>   	 * If resctrl is mounted, add per domain monitor data directories.
>   	 */
> -	if (resctrl_mounted && static_branch_unlikely(&rdt_mon_enable_key))
> +	if (resctrl_mounted && resctrl_arch_mon_capable())
>   		mkdir_mondata_subdir_allrdtgrp(r, d);
>   
>   	return 0;

Why isn't rdt_alloc_capable in get_rdt_alloc_resources() replaced by the 
helper?

static __init bool get_rdt_alloc_resources(void)
{
...
         if (rdt_alloc_capable)
...

Thanks.

-Fenghua
