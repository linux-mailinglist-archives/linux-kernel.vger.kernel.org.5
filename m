Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A0D7B737B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241270AbjJCVpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241095AbjJCVpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:45:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F5CA6;
        Tue,  3 Oct 2023 14:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696369499; x=1727905499;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v6Yz8qnbwj/7NW6jjEXD645UyUF06//J+rSWqFgM7DY=;
  b=RO1On4VnnhxQt36Zx6Ovc1i6m9hYnaKvdfH5oVhD96sdQOlnnNsFffht
   pcO4LfGtbRDX1Y5A2xQGala7BrNGzVuWfQXQWSfiA1kHW7tba7hkKEddz
   Q4k7irmYH4+V5QMZAHqfvPOIyRi5QT1d8qQULvapk6uEEZUbqVZsmfwOf
   rHRN3wLfxwLmEO2nIoCUJL5P4CQvDVyPkeBtY4bEJYS0XR+gYKg+DELMn
   9/qXwlULkO7gF7fQAbDGPtomRQmA51ZikjvsUCqVf+Shj0WUxben5FiIO
   Ix+M4+Nu+0jLMHQurEZqrvObtFOCXmPZh0WO8ZVsf4ZhhzG2l5b0fvfOU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="363253687"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="363253687"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:44:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="874833153"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="874833153"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:44:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:44:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:44:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:44:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icMhj48VRLq5O2Ylg97c8JTM2ZotEA9SHeTAHCFEzqjb1qtKNXz1AIfEf0+tL4GbOJwosIyScB8qLvz0RueJmC3eOA9Pleo/hJIfenBc5qx3ow87EXNpbhIAHim8xzD4IoRROrqZ9wmUpdkUXXUl24f9EuqzcP4rkLGhXGF5nMio0HYer1qnMAuYdZf+mO50u44nIn/H2l9QRbIp/YKiBKrKThgbAiqP17P4+DpU/2bgHycAfdpv7UT1v3l1ZZfixfGzl/uB6+MENy828f7S4fvv6hs0B7KWUqY9SSkEuxn4hmYQCkg6ROIEu8Cupsur42MWFQ3FXDcrHzX2FRRnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOO/DqzNDFdWN8I60VeeTQ71Rusb/bO99nSJBl8m6Mo=;
 b=bTm7bsyXs2I2Yda93gK0CaiYSYwEC9Kr8Z2AZweIiTwMUqpqQcgmu6v1dzfuvhoGWzr9hjMafqE+neOfUaF31Z3FWNUw1e6/GP+5wcplR3Uqhz/kGLLQsw8J8AFb6XIZGaUvpO5UQMgAgfXvkx6ytFhL8KQXgRZyWZIWCXtvk2MJHZdzmXws1Snib5fHS+E2luSsH/gmklSLBGmCw+HP24M35251CsG06M67KFR+L88Kk3OUQwGUC1QwUkxCN0w1oai3+hAS3vQ+oYsWyH6paGZcJGpdGNksAx/xgl5XjN9QhlZsFA4XjcqGGeDCIEI1jnzIjHwEaVZy2KyQI5Yiiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4963.namprd11.prod.outlook.com (2603:10b6:303:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 21:44:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:44:21 +0000
Message-ID: <94a38b28-5af9-4280-1323-7c43d934ee37@intel.com>
Date:   Tue, 3 Oct 2023 14:44:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v8 0/8] Add support for Sub-NUMA cluster (SNC) systems
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230928191350.205703-1-tony.luck@intel.com>
 <20231003213043.13565-1-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231003213043.13565-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0216.namprd04.prod.outlook.com
 (2603:10b6:303:87::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec955ae-a3df-4d31-952e-08dbc459e73d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zSLp3hkseEkk5z+b6YQaV9gUSYPGjOILR725qgZgg6AbrYRGPiwmAkABLEvvFtkolwpFwRyTS67b5O8jLKBNajhzCczUi/mRlID5Qc7tkwZ3y+HUNhjXnb9qRLDlpErFK5uD46gCzAh8TwN6aCdgYmmc4sUHYBp/GhKY3X7/m4r4yklass6+hnhvWAihBsp3lq9BOuHBbZVy8eOrT805Z2BcKYpEpuummy08qGFymhEaTInsiKljNsdNI93NQ7BwNvh+TZk9Hxbe76nQJF/97hnv08QzbV89GQk7vYwV/XUUpN/YKVYLcH99oK7xY/ZYaoMv+MB48XKtdYAy+0hys97YsFGfMn+jRy6vtNa/ounOVot/gRs9Qb5M2vsvhB+hvEQcahf6jF4XPAGKnkYAEGvThe0Ktf7j78mq8J/oGWIp+ccN2guj1Gf4SFKdvCii5va+nWVkI2b0bTcztyW9XI4bfDFGs4ljRYURtElPgUZAFRSV1QvBXH8euAT63TcUDQ1Vs4d8x11nJ+J63NMrPwQIv6MZI09PFVSpJpTALSCtpJE0omrX/0BxXK6aEIz+dAnv0pcBCuTM50zIZLe6vm8yn3sQVPwDpCoAg/4WmjjJQdzl3cxiyFvQnLsgeolbCIu+o2P7/0jpeWcktC1XLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2616005)(82960400001)(26005)(5660300002)(6666004)(4326008)(8676002)(8936002)(31686004)(478600001)(86362001)(31696002)(966005)(6486002)(38100700002)(66556008)(66946007)(66476007)(54906003)(316002)(110136005)(53546011)(7416002)(6512007)(6506007)(83380400001)(36756003)(2906002)(41300700001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzI2dE5aQWIzK010ZUJzUC9FRzdydWNHai9YK0UyeFkvUk0zejhaZlQyenhR?=
 =?utf-8?B?NzRQVndrZ0tWZXovd0J0Ni9lYkd5dGZRdXRoUjlwM09PTncveFhtWkhOUStm?=
 =?utf-8?B?R1F5YVlCZ0tPL05jQVJiLzBPS1VIa3QwNjRkbXNyWHNzMGVpa2hRclZHRnc2?=
 =?utf-8?B?SFBkZkI2bE55S2Z1RFVkcXBGeFdNckJJdmFpNFB0Y2tXNUhIc3Q3TWJrd2Rv?=
 =?utf-8?B?UFJ0ZjRDb3IvZitSNzM4bmdEQ2NWRitxMjlHMnVEdFNjSHJLYjZqZk9VYlZJ?=
 =?utf-8?B?OFhiMFpON2RvRXFVV0xrd1ZiZXNYNlV4N0ZIZGFTTFFMVUZCWlU0M2djcFhV?=
 =?utf-8?B?WlBuMW1PRll5a0Ryc1kyMDRHM2wvM3VpNVpxN2JVVG1OeGlHbXpHQ3RvK1pX?=
 =?utf-8?B?NGYxTnU0dXhaT05hVGcxaHZFckhlOGZ3OXdHSURsSlZyQjNHM3pIcytoSmJB?=
 =?utf-8?B?eW1aR256OVhRWk1YYmhYS2V5aklOUDFXZWlRaG1CWlhUd0h2T2hKS25FTDdr?=
 =?utf-8?B?Qk1nVnE2QmtuTG5ZRDlNckdzL1VWTFlKL01QcEhzblUxSGRlUHloUU5vQ00v?=
 =?utf-8?B?RFkvb0RnSm1IcmFFaGZoUE9NOG5yMEZod2hWODV0NWptN1RGN2x2V2RvdXRC?=
 =?utf-8?B?Zmc2dE1NZ28vU1RkbVg0QXJCZmFxNjk0OHB3RTB5TkFwY0VvSXFOT0RUL09H?=
 =?utf-8?B?WFZYSVpqcWNBZWVzc0hETEwyY1Qza2Y4LzYxQThTWFl2N0VnYkp3N1gxVU1V?=
 =?utf-8?B?a3BTVjRDQ2YzRlpiRTREVTZWZTZIQlNhdFduT1hRTitTbUZuV2dpc05aZ1U1?=
 =?utf-8?B?WCtVdzBKbEMzb3RtNG5jNzlBWTRhN3hZSTBZQ2VsQXpqZCtXRmIzZEsvS1o2?=
 =?utf-8?B?cTZTNnlSVU1yR0VleUF2MTEzVy9mTEoycFFuN3huaUV2TEZBTkx5Y3lKV1Nq?=
 =?utf-8?B?aGx4Sy93T1h3MWVVK1F3SnlyNndrUkVpdUlFWVQ5RGh1REJpUjcyenJ6bk9m?=
 =?utf-8?B?dWgwYjZEOGYzQWR5ak5TZ0pZdUkvMXpJYnMrNThQNWgrL3lidE1ZeFJKN2ox?=
 =?utf-8?B?WnhEZVB2TVc5N1F4bUdMSkJMbnpEMXk1Um9pUkdBeEplYkpMWGh2Q010OEhv?=
 =?utf-8?B?VFVBRmZJRHFsWVBncnJUVUgxWTE3TWc1eTA4aW9sWlowcEdsTUgvNEN0WXIx?=
 =?utf-8?B?dGFWVmJpMGhPVXZ4bVI1Rm03TFV6WlZKdEVLZG9nck5wMk5GUXRwendZbm9B?=
 =?utf-8?B?S3ZnMVZGcEIvRVhYenk4Z2UrMGdWQ1ZidXp2TjFHSFEvSlBteHdSRU1pR2xy?=
 =?utf-8?B?WGV5UmJKRktCbVMrNk9HZ05hdS9RbFRLZmtlcTJQZDJPRFZMOHdpRWN0eEh1?=
 =?utf-8?B?cEFGS3Y0c0hWQ1FWOVNPWFVVV2dTNTk2UGovUDVHT1ZnOHl1d1oxWllKcGpW?=
 =?utf-8?B?bWMyTGNUZEpIbmUyZWk4bmJjYnVpNWdocGlJelNqTnlqZERoV2tEeGtWazE3?=
 =?utf-8?B?bnhlb0Q1ZkZBY3RwSDhHNFVsa0ZqamQ4ditiYjBVcCtWS2xaUFc1QWVwNUtw?=
 =?utf-8?B?MWZySUxJdjNOMTgzN1hnOVBtYkE1U2ZzZjVMdzlhaVpoQUxYUVM4bWhwWk9J?=
 =?utf-8?B?dmsxV0ZuMit3V3lhSGRNMkgrNW42MVREWXBBVkJ6OFg3aWJmSXhGT1BSQ3ox?=
 =?utf-8?B?cDNEVjRuanlKMGNsUmh2ZjUzdU8wenNnV2VhY004aTRkdllWNFJ5bVNtQkJz?=
 =?utf-8?B?SFdyTFNEdEdaQVV3U0hRSWJLdldMR3NEb21MMDBjaGpESG9GeGo1U0puRVI5?=
 =?utf-8?B?enJsL1ludnJlbTZxcDlDMXFGOTFJaE5ncUR3bjRsM0M5Uy92NnVMOWp3azhP?=
 =?utf-8?B?SmYwSDBMMk40VHlkZEM0RmZoNmtIRkRLa2Q4M3pORytKSlIwWGZPZExRa1BE?=
 =?utf-8?B?MFp1S3lGeWc5Y1Nod1NVaHoyYVpMVGUzRHNEdTBqamtTVlZLYUVwdjFXQWFG?=
 =?utf-8?B?d2lvMDg0YWE2ZjMrdStqR3lrVEJsRjRnR2FjMEdWT0dwZXFTbG5lcUl0WUV6?=
 =?utf-8?B?RGFGcHFTYzN4MGxzU0wraXJVb0RIY21wZWpyVCtRSzZTSjFOdVcvUmpmTmx0?=
 =?utf-8?B?enJXZUhxM0pMWElyT0R3bDBneVZ0ZWV4ODNSTXZvRTB5MTM3Ujg1cnZZd3g0?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec955ae-a3df-4d31-952e-08dbc459e73d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:44:21.4798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2BN4cv/4dhc8UbK555IgBb27NbfkagfU62C6se4iE5zEE1r6I3NCMk1EQOiW/v6EP4P5jF4/W21hPbd80iArmCaW5qcK2KVJRU17kqamqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4963
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

On 10/3/2023 2:30 PM, Tony Luck wrote:
> The Sub-NUMA cluster feature on some Intel processors partitions
> the CPUs that share an L3 cache into two or more sets. This plays
> havoc with the Resource Director Technology (RDT) monitoring features.
> Prior to this patch Intel has advised that SNC and RDT are incompatible.
> 
> Some of these CPU support an MSR that can partition the RMID
> counters in the same way. This allows for monitoring features
> to be used (with the caveat that memory accesses between different
> SNC NUMA nodes may still not be counted accurately.

Almost. For reference:
https://lore.kernel.org/lkml/e350514e-76ed-14ea-3e74-c0852658182f@intel.com/

No need to send a new series just for this, but this series does find
itself at the back of my queue.

> Note that this patch series improves resctrl reporting considerably
> on systems with SNC enabled, but there will still be some anomalies
> for processes accessing memory from other sub-NUMA nodes.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>

Reinette
