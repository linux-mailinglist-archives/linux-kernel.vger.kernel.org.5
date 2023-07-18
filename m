Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8D5758625
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjGRUg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjGRUgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:36:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510B0EC;
        Tue, 18 Jul 2023 13:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689712612; x=1721248612;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FKgcB+3eA3uvDCdLLy6kbNL3zTO+dQo4Pd4hi/O0b1g=;
  b=VImayJ7jREJ0aUCWQTtIsHfDpqCMSa8+2GBbJq8tllDWMGIcPfgfhc+R
   uZETsIzeQWl5Yx7TX8dfaWBgmsQOPewPzsdj31XEHoWCE0zW0caDJKa3t
   pG3mJu8HbjgRqt5Tco7zZsvs8YQmi4TpZweN0YhNiXofvyh2ox1pj3MTU
   5VbAVg+7H+t+tzWOyYq9puk3DyTACXmrNYcVcd+GR45gCWnAzx+5ezdbQ
   PfyRlBCWoPPdq29AG6Ja6Fg1SuEYyvLAo3Mxdyor33I1n2Y4vqESJpabV
   gPhkxWi1DDIPgzttq3AI1sQmYJSbMXYmxy77/4puDRhb8Aul5V7TRiRKc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="356254969"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="356254969"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 13:36:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="701035074"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="701035074"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 18 Jul 2023 13:36:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 13:36:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 13:36:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 13:36:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PavqWG2B1KcNIc9mjeEkuIcA7uoXJDZh5IWdtfBn592Ruw0wTeOtu2tcTIrVeUimunGC6WrRzwrKVekz9VP7J6D62Ah2GKUhxmGV84I7M/XaTDjJWJpClF8ca91TAfBC43Od3TAvPvll6omH79fHDSn8Y4eCJd7GgnuNSVWmZbUH04UutAOLpQ4x7flePquTDZuYdFFdiIB1SB83CC2nxGrlLyTABLlvRKU19/55hnFOf3zzhuW2wMYYlNA+FqRmY1ElOvisZnsJ7P2sroFdk1T3IYuG66few6ngF8X1h5Qm6a7s89vuro7SJnM/TEy5+Y/FESMBDq4ILzu7jLL1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWYJhPSTKkLR96QetXFu8WRPn9wsjv+yZZoFtYMkG9g=;
 b=LW0Cg+5kp2P1sj9/XmsJROIcOEeI9DZA4kp6E1WfiGEZk007w0Jn4RZgKsUYMOq0DCYwgk65ZCTxfuFdJoY/CQhKFSGwZuMtKM7Gs6bgyUa7ud5rLofs4iPVkB3JY2wNunFcyupq425tMTUsF5+UcQqvb2yNlO37cNjlQUJ0gb09Rw7z7KMgdNsHQJ6bU3kNZMU5CxTLE1y4Zf/nX4A71NQNqPSIE8mnV60h1mh2/A/bIsHAt6nH2BID6/QL7f8hAAbLx2DSsldnXsfZnFhfud3nSoUhAWwHajAcVoQfgk22Kdc92+gsXnco68OQ0n6m5sqWuhXro+CMFFvNm77COg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7576.namprd11.prod.outlook.com (2603:10b6:a03:4c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 20:36:29 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 20:36:29 +0000
Message-ID: <09847c37-66d7-c286-a313-308eaa338c64@intel.com>
Date:   Tue, 18 Jul 2023 13:36:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/8] x86/resctrl: Refactor in preparation for
 node-scoped resources
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
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230713163207.219710-2-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713163207.219710-2-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:303:6a::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 74162dcb-54d8-46b5-e2b3-08db87cea9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXbFGPDal9S/CJBdl9VRuQf6QqpVqrQ8HwPeFD3QLJ4pDUPc/0svgsLMWvE+fIIHqCtB5Ser3QeI3NBjUjmabPwmMNyqZnnG42DnIZaSckij0hUn8eYrW+QyJiNhJN3Rbb15k0evfB8xNrhgciuiBXFDLwEiZlVfi4qaDsiTBzXLbk8m2I3l1RGKbILtZo8YSZX7xKJjzwu64xSlQEqYLhE/SKAVMUQeWOddX8pff8BWrFsLSES+/EsUqNUgUmTiK+3MOMADt+Igb/eszUD2AexDA0jQ80B36j5ktjj4iG8PVBVHgw9xe/xUzoUYnw/tZ55pYizq8cZJwLOnAj1OG/ne/BBfwkw48iOX+3dMhIWTQWrKZGbL3JqZjXc0u5x3TV1RpH5Rn4wueQ+NRZ4fcP/NQ0DpxeUgeE58uQAnx6bQ7imusqSU8DViny0+52lBfUeMisVE0CNTH3TmYGZn9H9W6IbC2cWTShwn6GEZ0xyvMlNLD0mW60r8VcvVLtTgAKMe/j61EWZsyHVC4rfZ0xyj57j7iGzVmjTG0zt1Kc2mF96LX2ylJmeDXcSwXLrMgQmLy18BsT7xXqnVxbYbktzSC206qDU1P4/+ZD/tx+Tn+Z8UzGdeKIa5x3VVC0+VV+w1mEIDQcnQI3UT8/rk+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(54906003)(6486002)(38100700002)(82960400001)(110136005)(6666004)(41300700001)(8676002)(8936002)(316002)(66556008)(478600001)(66946007)(66476007)(5660300002)(4326008)(6512007)(186003)(83380400001)(2616005)(6506007)(26005)(53546011)(86362001)(31696002)(44832011)(2906002)(36756003)(7416002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1lxdGRLSXp0c3lETlRFTXZ0VllLcmNyYnZUS1BtaUdTU0p1Zm82REU4dXNI?=
 =?utf-8?B?V0ViQW9sWGdUTWJvbG5tWmhGcGRONzZNUG5Vcml1b2hCQ1J1RnQyMlplenZR?=
 =?utf-8?B?amNHUFhDZWhwU3ZCcHg1RUt5MjdRRHhPM1JTSkZwbFpZbzZyZFV5Sks4NEl0?=
 =?utf-8?B?Y0JqMzREdEViMjFJZVRUbUJ2WmxrZWNlL3VUWnFNa3cvbnRwZHF0UTBLUE12?=
 =?utf-8?B?bnJnYURRU3hhK3ZkYWlpWG1iOWl4VDNranBxbFBlSHhiUDRyQUhKZEFoQkpk?=
 =?utf-8?B?ODl3ZlJyTWtRWkJtUmV0SXhZaXNxRkk5cUJwNmhrWUh0T0hOSjl6YzVza1Vh?=
 =?utf-8?B?S0ltc0tIT051b2Jka0pzS3BpTW9PanU3UzNySHBrcVpCWUh5RGZlUXZlV0ZF?=
 =?utf-8?B?TUp6SmVPbXVua2RXNHNSRkFvNFh1T3Vlc0IrYmppM25sS2o2WHVWNmhMUXY1?=
 =?utf-8?B?VkJpM2xXWjY5S3Jvdm1mOCtYb21jeEdua3lGL1dRZEJpMitXeDRNYzFYbG1r?=
 =?utf-8?B?VS9EZkRPa25zazdvbFNRV0x4VkpEaWFqWklqNzFJbytvVVRKVXVrK2xXUUds?=
 =?utf-8?B?YWRRS2sxRUFEOHIvdlNWeUN2aG5NeVZ1R2ZqVlhQRWF5YVg4VHVMZmdlSm1H?=
 =?utf-8?B?RE1WTzN1WnpQZVd1WDBRc2FkU0ZPbFZ6MUNZMnJOcDdmSkozQ2pIMjQ1Nnd3?=
 =?utf-8?B?S1VzU3VYY3N1WDNWMDc0aFlWbUlRWnczbkNKbWZ2ZlNMUEwzbXN5UWVzNnpa?=
 =?utf-8?B?L0J0ZDJzTlRYaDdFQkZMNi9FM0hpSGwwUVNXVTFuN3pMQS9POEFlK1ZPZW9N?=
 =?utf-8?B?NnZHeWJkTDZUYjZQRURpQkFkTTcyZGFidFFsQkQ5Q2JNVFdjY0J2R0pyeHRr?=
 =?utf-8?B?QnFhZVNMYVZmellqcUJ2Zi8xZmhLRjdrMjdTcFdQVFN6Z2tweEQzNGgxZmZr?=
 =?utf-8?B?N2pZcGJENHp6RUNyWHlmbVE1Y010cFZkQjd4VVQwSkxjZ0tHMFFjWjFPc1hS?=
 =?utf-8?B?dFVhWUNaNTVFc1Q0SEdDb3ZHU3R0MXEvUzY4SklKMkxMbk42NC9mVXM1Risv?=
 =?utf-8?B?dHdxbFVwSjFTbDdlZGhDRzEzRjYreXZoOEozdVIzMy8wOGQ5T25ZNEZiUHds?=
 =?utf-8?B?eU5SQmw2ZGdiU3UwNFZlT2tYRW1XZklDbjc0cFNNTFhIenhITDVhNEJNTW5N?=
 =?utf-8?B?QVoreUNjOFZCYWpOV3BvZElPZ2VzN0s3d2pHYkJNNml6dlN4VHpoTXd5Z09z?=
 =?utf-8?B?bTRhaE0wcmFhb3lLQy83ZkJLWFVzNTd5YXZ3U3V3VzMzbFdCWERTZ0J0TGhj?=
 =?utf-8?B?c3VXNGVaRldnbnZMaHBwTm9oVzVHYkY3VU9nWUZqcGEyWkJOeUcwNFdCTFFF?=
 =?utf-8?B?dUlRbDVkVDNzVmF4K0lsMkZxK21EWCtSc2pGSU1rOFdtWjY2d0w1eVk2UzFq?=
 =?utf-8?B?K3d2UTRJd0hIYWxHV2VSWUErcjloNDJaWlliT0RrSU5QMEMvM1BzdHRvR1Vl?=
 =?utf-8?B?RnZsTTJaOGlKS2RCa1NudGhyL1dEV2M5NUw5OEhXQ0I5MGQweHROMWdMbENP?=
 =?utf-8?B?TXVTMkFmeEtJaVBsUTNZekhxalVQTUJRaTZaZlo1UkI1elhCUlExTkxlWUZZ?=
 =?utf-8?B?NjhyTVV4Z09KU2Y2bVZrbGFwVHkvK3c1YnYxTW9sdGNkckQ4RUx0ZnhGRmVG?=
 =?utf-8?B?ZXcrQjNVc3RvaGYxdU40a2FKdVdDWW1TNWk4MDIxajFsMTB1MkdwWEdsdVF1?=
 =?utf-8?B?dVNzSmh0bUk2ZlQrWGIwMkFYRUtGYzUzUjk4WFdIZnh6MGhKaDNVWUw3S1FL?=
 =?utf-8?B?SWVMeEhScU9MODFaZjZSeThja1lrS3VCSnIrWUJoZDcrdkZwcmNVNGRkWDhn?=
 =?utf-8?B?cVZVNEpWYlZwSm5KcUg5NE9RZE1QOFBLNTdDYnF4RDZQc3ZlWEtjdmdwaFkz?=
 =?utf-8?B?VXdZVnErekloUVA3MWI0Y3FTb0hWekFvZXlMRkZsOW9DZWpvSGNEaUJkZkw0?=
 =?utf-8?B?S3ZXQ2xrR1ZCL3RReXhKN01venh2ejAzQ1poRmRyQjhieGFEQUdxTTVJcVA3?=
 =?utf-8?B?V3Rpd2gwblV3SXk2V1dVYmZGbUsyUm9hLzl5Z2ZiSjlRVU44eXhYSElSWXBT?=
 =?utf-8?B?S3BDOExqNC8yZ0E3Qm52bXZsZXlmeXI0M094QzRlc2xya1BsZEYzNHdYNkxZ?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74162dcb-54d8-46b5-e2b3-08db87cea9fb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 20:36:29.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMJyubRtlEmBpTpGJDSavh4Lu+VZwUC5/jZ5yjNIUhGktJATXrUwLDxtK93sDruGZanNA5SAajT5ugWNJJ0z0kg0Em+mm/3KRFnnoxI/Zlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7576
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/13/2023 9:32 AM, Tony Luck wrote:
> Sub-NUMA cluster systems provide monitoring resources at the NUMA
> node scope instead of the L3 cache scope.
> 
> Rename the cache_level field in struct rdt_resource to the more
> generic "scope" and add symbolic names and a helper function.

Can the changelog elaborate how the helper function is intended
to be used? When changelog just states "add a helper function" it
is unnecessary since that is clear from the code.

> 
> No functional change.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> ---

...

> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 030d3b409768..6571514752f3 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -65,7 +65,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L3,
>  			.name			= "L3",
> -			.cache_level		= 3,
> +			.scope			= SCOPE_L3_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_L3),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -79,7 +79,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L2,
>  			.name			= "L2",
> -			.cache_level		= 2,
> +			.scope			= SCOPE_L2_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_L2),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
> @@ -93,7 +93,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_MBA,
>  			.name			= "MB",
> -			.cache_level		= 3,
> +			.scope			= SCOPE_L3_CACHE,
>  			.domains		= domain_init(RDT_RESOURCE_MBA),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
> @@ -105,7 +105,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_SMBA,
>  			.name			= "SMBA",
> -			.cache_level		= 3,
> +			.scope			= 3,

Should this be SCOPE_L3_CACHE?

>  			.domains		= domain_init(RDT_RESOURCE_SMBA),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",

...

> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 458cb7419502..42f124ffb968 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -297,7 +297,7 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
>  
>  	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == plr->s->res->cache_level) {
> +		if (ci->info_list[i].level == plr->s->res->scope) {
>  			plr->line_size = ci->info_list[i].coherency_line_size;
>  			return 0;
>  		}
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 725344048f85..418658f0a9ad 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1348,7 +1348,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>  	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
>  	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
>  	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == r->cache_level) {
> +		if (ci->info_list[i].level == r->scope) {
>  			size = ci->info_list[i].size / r->cache.cbm_len * num_b;
>  			break;
>  		}

The last two hunks are red flags to me. Clearly the "cache_level"->"scope"
change is done in preparation for "scope" to be assigned more values than
2 or 3. Yet the code continue to use these values as cache levels, comparing
it to cacheinfo->level for which I only expect cache levels 2 or 3 to be valid.
The above two hunks thus now have potential for errors when rdt_resource->scope
has a value that is not 2 or 3. 

Even if these functions may not be called if rdt_resource->scope is not 2 or 3,
this change makes the code harder to understand and maintain because now it
requires users to know in which flows particular functions can be called and/or
when code paths with invalid values are "ok".

Reinette

