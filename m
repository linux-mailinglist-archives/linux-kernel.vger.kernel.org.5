Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ED177FD2A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354068AbjHQRnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354070AbjHQRmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:42:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A31010C8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692294173; x=1723830173;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NhWO1DXyYW1UAbyAhrXJF1JxIgRzNw65nhUdab2SreU=;
  b=eM28IrPff6Cl1M6uDEK6oKbqYKsCxsBbI6CVDZMDHh0gRjL2amg93me8
   BGU6WIIDQH8tn/dQiWDtqM//No0znoMbC5gJl7L0Uo0IFsLS5lSUmL1CP
   85jRY0AuNzdPfxY7Poyb4nOTmMI22JpHGMOJ9LDfjKOy7oJ+qLHGKFqTC
   L9mWGgUwNu5qR70IngyrG7QGXLg1r6Txa6YbeWhw2e0TlWAN8uK+UnUeB
   2gLaH1UWXT4xZqhPkd8eTI5lgmoYbxwiVZKG83d70QG759GdJMuNxkFTm
   sCYm1jPspvysZYG8Q17SRIFoNuuJ3xzX55fiG5V/WN4ELLs8pK2yPclC0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="436804141"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="436804141"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 10:42:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="684520186"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="684520186"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2023 10:42:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 10:42:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 10:42:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 10:42:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 10:42:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9bkQxrGr++uZDTbUSQLI3mPzGGdJRbPyQtp4LnFsGpbcdoLTh1LQqqBs7UxWpTBCfOrKOjQDBd8/w6zniEtbdATG9KmT7M2S3twYA1qZOsz6MIrpcOJ0BMfqjWCmM8ga5Lz8P6rZOHtTfrunnLdQjhddrRtjjKCxbHfNOuWm54o/yaJ2kgLkM0PI6OIPKsg3AAj4Ai5+SsW6VOFUwzapt6Ys1rTvcsmqP9Z20PcMBEcx3+mKLbs4vgj4Hxw5uJh9fXAhldg5m9+H13PcXSIlOknD9xPLcf5riUb3HEBVSVsWlKCn7hSQvVEL/mcMqwDhNdXMYenpFDpqhx5nBLmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIXpkORa+UWE3nCKjKLhdeZMO1iEo7brOJgHlO3VJxA=;
 b=YXkNvra0vakX1qvdlKVhD6d0x57tFlxLNJ5uz6bj9HW232bCLBI6ZZO1wVrr32TitT1VLiL9bjGfUPJfktct5gpaCPF7iAc3Zr4+jbvKkfF4wqZP2bzsE2XG+IJOI9BG9k5K+Jo2Q1bAJFoHCdjxIwLHaekrm6FIB0envEPsISsQOpNec5mFXVKfOLBOWEX0GkmURFqlvrG/npYHXeMry13uUYvDhOJPOR9jRt/ehclksnCN5MyEpjwLr0XW0x351ex6gk8VBU035m3ooOhv3NL7A/mJ2LhUC3LIdDu6Xyt8pkl1fA+sT76PReYMDzd6jVln8B25bWz2L4Y+pRx1Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SA1PR11MB8352.namprd11.prod.outlook.com (2603:10b6:806:377::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 17:42:49 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 17:42:49 +0000
Message-ID: <c9466b46-6a03-e57b-4b8c-edeae8081951@intel.com>
Date:   Thu, 17 Aug 2023 10:42:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [RFC 06/12] fs/resctrl: Extend schemata read for priority
 partition control
Content-Language: en-US
To:     Amit Singh Tomar <amitsinght@marvell.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <reinette.chatre@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>, <peternewman@google.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
 <20230815152712.1760046-7-amitsinght@marvell.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230815152712.1760046-7-amitsinght@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::8) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SA1PR11MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a996c2a-1e16-4308-c2a1-08db9f495fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5I3SEsrsAwCAe4X1PhTotW4mvINPC8G4KvjV8agW7ijnrEPC9KRuboR67Ep+JWBXBuGHmeSgHfmS/65DPUMb0C5/xIOVhjolZ6CDhxU9eoTq5vR14SJoXa0UyednlCqT0WI3ISZ3dnsgpVPfjyvKtIPrQe3+7AtqfJmfS64CERqyBX1LeTRrYTwxJLPAEUKuO1m+2edYWEbWmXvlCZhJ/u6WmxwfiU8wqr170lpIf7yeoFPJp9Em+cpbO+4bPZcWvH5suqn+atOpociC2CxZovVU5Gr8qDqMf7iuXzSE7nRQV4qNHPiKFlICSjcLrNTN/ThjbMXeMCm9yGs51L1OzIXYPILHP8AY9PDgDt5/QIFiZwdsC8q6LG9hfWs+2GQ+QVkVaJPWbfJFg0X09KCWiMgBJlf6OsEKI1pFOr0n2Bz7ndBgNHPMgjR2RtoTuE56myhQ8JqwpRhMTQeMcX8JDE4atpX/iQlq9lyoLOSWCUzovjwJfoRMg40wZzGzDqj+bIO5tzXLaNB605kuTwj4Nl77LaIaAp9S5hsl9yBvUgOPrDJE5gouoHKuVG97mTyC80VbdzOKHhvPB6npQFdTW4BKy5JuMrpHIZTY2NoljHVKfUnY7C6Ko1bsXUfkrIMbPKjtQWZyLESYRBBdy67Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(346002)(376002)(186009)(451199024)(1800799009)(31696002)(2906002)(83380400001)(26005)(86362001)(478600001)(36756003)(6506007)(6666004)(2616005)(6486002)(6512007)(53546011)(44832011)(5660300002)(41300700001)(316002)(66476007)(66556008)(66946007)(31686004)(4326008)(8676002)(8936002)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU5jTVNXaUxWd1EzNlJOWE15aGZJTzRlUkhNMlhzWHhSYkJyNTI3dFc1M0ho?=
 =?utf-8?B?MXdndXBHQ1N2eEpNTHpNaEh2eTd1ZkNrMHJvU2NwSUVWaFdLMEhpSTlmLzd6?=
 =?utf-8?B?TXJiTk1PMDRDYkJFQ1loSXhaZzNiZVBPWHJLVHdGNXRyME9QZExNZ1BDQlpI?=
 =?utf-8?B?YVF3RVlLdUhTRGkwUHp4M1F3Z21HcTVpQjRFOTFEVVlFN2d0NDFlNkVRNHZK?=
 =?utf-8?B?cVN2cjVhcTNYVkFIc1pkbUpuczh2MnhOMjNhVVdEaWxubk9CRThFUFZjOFF6?=
 =?utf-8?B?YmhrSDVlNHNnTTVseWk3blB1QUp1dlFNdVRVMlFGYTczV1gwMU41MDNoQTV1?=
 =?utf-8?B?U1BxMDBnNTZ1WHZwcVM3UEtIVXVTNDI3Uk5Gc2xWWlIvdjZYSllNOU85VnVp?=
 =?utf-8?B?Ym1lSkwvL2ZNdlBWTVkwZitZMjNzWVpldzJPZGZwSW9uWitMV0FpdHFRc0FE?=
 =?utf-8?B?Qjg1aWkwUGFPSTY5S1F5ZkpmcGQwdUQzS3JMODM1K2l3R1NMcm1DcXhxNjU2?=
 =?utf-8?B?SHRVbWhzOUExMTNFTDNNRE1XQm1wYWduQ3Z1YlJQWVNSWDNsV2JJUHBneDhk?=
 =?utf-8?B?M2NxWTFRYXdmbUxna1pxNWhsakVEVkE0MTMzWG5NZUlsdnhSUXNLQ2U1NEoz?=
 =?utf-8?B?akw0MWNCZnRvbEpVMjVublk3MmNDWndhUnZTMXM4SjE2cDNnMGpRaURtRk9J?=
 =?utf-8?B?ZFFtMzU0RTRVK1N4ZDEyNktPS0ZXa0t5U1pwbnVkb2toeWlBSlhVbUdldS92?=
 =?utf-8?B?STIrakc1M3NRQ2FWeDF4ZityN0FhUlVGazcyeFpxU3Q2VW8wQ0hrN3h1cktM?=
 =?utf-8?B?Tmc0dXVPTWc1K0tXSmF4Qnc1UEVGR3dsc2xrVEpzOXRNWTB6QXNwTFRRSGhB?=
 =?utf-8?B?MGJjUS9KbjF3VTRVaTZ4eGVnbC90RGsxYVNFdGR0N1UzblAvRWVqOTgyaHU5?=
 =?utf-8?B?VUpKQ25pcTRGdzdQWTJTOGJid2loU2RsdDM2NDhjOHZ6bjBmb05qU05wUWxJ?=
 =?utf-8?B?ZE5NUnNLRFk0dGFKNWx6SHpWN3huN3h0SUFlNGZTcUU0b2x5bkFMRk5lRnhu?=
 =?utf-8?B?LzUybStBWmJKSGhlcndLbFVCMzFuSE1XS2pSbk13aCtmQTVOWDF4SHNMT2lU?=
 =?utf-8?B?SE9ZdWM1eEl2Y3NhSjZCZnlSQzhQRWVGdWFRS2lYZnlLTXRLcUFhN3BkOFdm?=
 =?utf-8?B?eW43aHBNMFNacDA4VlRLMHloQzNrU3BDRVFOMDRwaWs5R1VtTmxaNTRYTFpH?=
 =?utf-8?B?dXBEQTd6Wkd5MHlsWTZaMGZJL0UyOW9vYmFPSFVWNzMzejFmLzlYTDc4SlRD?=
 =?utf-8?B?ZFJMcnRjQkRjOGJjWUgrZWNCMElZbm9jT2l1ckZqdG4xTE1NS1N3T2pOV3BJ?=
 =?utf-8?B?TXdRT0ZxQkhBYnpFWGREN3hkeVVOTC9qNzQwWFNIV05EWDZwMFltbWwvcWhO?=
 =?utf-8?B?NmRuMHdYY25PTlhONHFrL2MvZGNNcnU3L3BiaytQeWpLYUt3c3RFc21NVWVC?=
 =?utf-8?B?WE5DWEdxM0pRWXdMUDd4cldqNUNqR2VuV3c3OVV3bytHQXZKSkFNb2NrRldx?=
 =?utf-8?B?WFk3Z1czQTFMZGtQUHp1b2VVandEYXBlb1VZSjZacURaZlhLQklWcjRHMnpQ?=
 =?utf-8?B?UHhFSjBwZVhZVHMvQkEyVGN3T1NQUlovbkc0aWlObzdDbU5xU2hrLzQ1Q2VX?=
 =?utf-8?B?TFZDVUgrc2tPMEdraVoxaUoyOGxuVHR3bzl2ZGE4cUZqQ2w0N3RFaStkUG0w?=
 =?utf-8?B?VmpXME5YMHFuWkVrdnFjKzFwTnBQZDhpNkNJSWVVQWNKWllPMFlHeWFLWUc1?=
 =?utf-8?B?a05SZEM1M2daVTF4SzBDZm1Lanp1UW5UdFBBRjZIbkR5SWl1bWF2WExDN3VF?=
 =?utf-8?B?QUlCM1Z1Vng1WjgybnhYUE02a29KbytkVHFVSHFubXVKWVhOZkFJeDdjNGhJ?=
 =?utf-8?B?SGR2OHgyMnpxMGlGbWNPT1gyQ29rbVl3K0VuZzVxNDJvQjJvd1NmWHpEU1Q0?=
 =?utf-8?B?Q0haWmZEa1BQNm1KSjMyZHFQd2xEZk5IblpXNS8rdlVXNWROU2JpeEtxZysz?=
 =?utf-8?B?NFIzbGd5OUdPNDIxQkxNc0RFL2ppNGU2bU8xMC9CeVRMNlJITitjWkJJWEdn?=
 =?utf-8?Q?p0dvD7Tgg3kuwSe7dwrAGubCc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a996c2a-1e16-4308-c2a1-08db9f495fcb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 17:42:49.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /X+sUlr+76gy+gvvsQ+9XkZgfwnDcX/zC/VEH65yegV1SPXDJo7Tav2s3gJBT6Xp3G0rF2Q+f90mjaxORVdQbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8352
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Amit,

On 8/15/23 08:27, Amit Singh Tomar wrote:
> At present, "schemata" file under resource control group reveals
> information about Cache portion bitmap and Memory Bandwidth allocation.
> With the introduction of priority partition control "schemata" is updated
> to adopt priority value.
> 
> Let's enable support for reading the priority values for "schemata" file.
> 
> Signed-off-by: Amit Singh Tomar <amitsinght@marvell.com>
> ---
>   drivers/platform/mpam/mpam_resctrl.c |  4 ++++
>   fs/resctrl/ctrlmondata.c             | 15 ++++++++++++---
>   include/linux/resctrl.h              |  4 ++++
>   3 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/mpam/mpam_resctrl.c b/drivers/platform/mpam/mpam_resctrl.c
> index cc843f1b0fb7..b491a0f897fd 100644
> --- a/drivers/platform/mpam/mpam_resctrl.c
> +++ b/drivers/platform/mpam/mpam_resctrl.c
> @@ -735,7 +735,11 @@ static int mpam_resctrl_resource_init(struct mpam_resctrl_res *res)
>   
>   		if (has_ppart) {
>   			r->priority_cap = true;
> +			if (class->props.dspri_wd > 0x10)
> +				class->props.dspri_wd = 0x10;
> +
>   			r->dspri_default_ctrl = BIT_MASK(class->props.dspri_wd) - 1;
> +			r->dspri_data_width = (class->props.dspri_wd + 3) / 4;
>   		}
>   
>   		/*
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index b19ac2509e38..8c8a4d09d22c 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -379,7 +379,7 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
>   	struct rdt_resource *r = schema->res;
>   	struct rdt_domain *dom;
>   	bool sep = false;
> -	u32 ctrl_val;
> +	u32 ctrl_val, dspri_ctrl_val;
>   
>   	/* Walking r->domains, ensure it can't race with cpuhp */
>   	lockdep_assert_cpus_held();
> @@ -395,9 +395,18 @@ static void show_doms(struct seq_file *s, struct resctrl_schema *schema, int clo
>   			ctrl_val = resctrl_arch_get_config(r, dom, closid,
>   							   schema->conf_type);
>   
> -		seq_printf(s, r->format_str, dom->id, max_data_width,
> -			   ctrl_val);
> +		if (r->priority_cap) {
> +			r->dspri_show = true;
> +			dspri_ctrl_val = resctrl_arch_get_config(r, dom, closid,
> +								 CDP_NONE);
> +			seq_printf(s, r->format_str, dom->id, max_data_width, ctrl_val,
> +					r->dspri_data_width, dspri_ctrl_val);

Move r->dspri_show = false to here.

> +		} else
> +			seq_printf(s, r->format_str, dom->id, max_data_width,
> +				   ctrl_val);
> +
>   		sep = true;
> +		r->dspri_show = false;

dspri_show is irrelevant without priority_cap.

>   	}
>   	seq_puts(s, "\n");
>   }
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index d5b0661c0f70..d7100c330945 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -199,12 +199,14 @@ struct resctrl_membw {
>    * @mon_capable:	Is monitor feature available on this machine
>    * @priority_capable:   Is priority partitioning feature available on this machine
>    * @dspri_store:
> + * @dspri_show:		flag to indicate downstream priority read
>    * @num_rmid:		Number of RMIDs available
>    * @cache_level:	Which cache level defines scope of this resource
>    * @cache:		Cache allocation related data
>    * @membw:		If the component has bandwidth controls, their properties.
>    * @domains:		RCU list of all domains for this resource
>    * @name:		Name to use in "schemata" file.
> + * @dspri_data_width    Character width of dspri value when displaying
>    * @data_width:		Character width of data when displaying
>    * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
>    * @dspri_default_ctrl: Specifies default downstream priority value.
> @@ -219,6 +221,7 @@ struct rdt_resource {
>   	bool			mon_capable;
>   	bool                    priority_cap;
>   	bool			dspri_store;
> +	bool                    dspri_show;
>   	int			num_rmid;
>   	int			cache_level;
>   	struct resctrl_cache	cache;
> @@ -226,6 +229,7 @@ struct rdt_resource {
>   	struct list_head	domains;
>   	char			*name;
>   	int			data_width;
> +	int			dspri_data_width;
>   	u32			default_ctrl;
>   	u32			dspri_default_ctrl;
>   	const char		*format_str;

Thanks.

-Fenghua
