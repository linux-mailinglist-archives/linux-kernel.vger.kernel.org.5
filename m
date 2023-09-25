Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EFD7AE234
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjIYXZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIYXZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:25:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE68136;
        Mon, 25 Sep 2023 16:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695684327; x=1727220327;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LFlk+Vo3ZML/6LDqQHG1AHIXBd4dKU9WCLK1kbEBReM=;
  b=hCbexrc1QPEgzxBmuQmRjRq+8eKBmyKcdemtR9ZnZyV91s9CJFTEy+SX
   6hG1TbGzcls1Kng1V+XJpxxAglQF/YBkAij4QvG9PVUdSNZAh7bq6qkjO
   5mBGZ1oQXv5fHVHWPFck+3Akgs7zObulxGgROxir8vH/skHxDu6oBVLaW
   7yyAv8lHowpGYYuGyAULGMhLVkEAG5sZ/us2pp2Eitwnnprz0vyO5Tbu6
   sUuMzkkOvJ066j6f2BNWUGQt0zXPgWcSuDwABHZA7WF9AiM1rwMoP/Gvz
   ohsrJCxgyPwTEcQoAO+5z8tuStkHvXxg8pqM3u67B1pfSPoKHGOrOUUdT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="384215865"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="384215865"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 16:25:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995595596"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="995595596"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 16:25:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:25:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 16:25:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 16:25:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQVfe0CpiSW0mKxUCqhUEjlcJJCyRQo3LmpSh/+AX4bVyiLb4wMP6v9aIGilyP04RWWYqpkQzpfxFFcvy/pQhUvAgB1+B+j+f1aAQywhTH8m0S+BhnkNINi2EfZT5LDOaGTnl/T35XLv2FR/2b67MmzwTWabhnfrsW2Ib6KMrlzfXM8cuvp0Po5gexXi/kA6XYuv+jGBq0byCv1OiwMW0mogrwXjJFqVKAth7uwt4lq7TU0O7WnO9C1eFeV1SJZZ4mvKx9Wi5BPj6FG2L1l5L2WS0HDEkSlB70gAukmEpRh/Ze5AI/lEq0ESSiwJLdyJ6i2azF0Shuy+gV3sU+glew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iml24Va7oHlaBZ3+9J601+x2oVYTtyV190dsObV2EXo=;
 b=WaUkJFAZIarz/MAdEy6whBWeth6Bviq+CZdyv1DLj/3u6C8KxwqQl1cgEi2dacHXaAiKcn6rPaqRFa9rujMY9yrz+fBBIA7cB7yejoamFJDefR91Hvtp9vL26XbbNBQobZAK6ToWf55TSq9mkhNSrp1prN8Yg4Bf1gjonvEdY0RWHDMqx8ukxdaX2ftddYDC1yqPO8gm3KmNtkRPvBVPieY+Xns5m36qcng9QPHfi9PZvppd17bcR/H7tp2uV1k5XJnkz+9uq2L2AKzyY/i1EhmojyUa2YzgsSmZWOmgD5RTS6JgZt9Af9yW6TeuRiIjWDZYoTA6FP5PvYT6y4K7rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 23:25:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 23:25:18 +0000
Message-ID: <5f1256d3-737e-a447-abbe-f541767b2c8f@intel.com>
Date:   Mon, 25 Sep 2023 16:25:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 3/8] x86/resctrl: Split the rdt_domain structure
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
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-4-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230829234426.64421-4-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0327.namprd03.prod.outlook.com
 (2603:10b6:303:dd::32) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ddb2cd4-f44e-451a-5fe5-08dbbe1eae01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/Uaz2BA54+MfZvtVtcBMlqpPAY3FU68Fn/zsRFl1PpffJZrg7IsFS2lpymHzjm77eQfoewXIR6HCUCdpfHQYSi59nn1Kg5JmoAsk4voManvrmfw2X0l+5INw10ti1NnIbkSVzzEq5GxMfsBm2TVRTpvEeNbF4Dx2+s3dGP0+uY5uvzOpumRC4h7xZCRwGgg1P/7jBgtB5bWvtVBxKj+rS6trLQ7q36U0SeMaGVsoLSKmLLKzQs2GwE2A15xy8Jlh19K+PyoI3G2Wmr+BjyzLRxrKyqUd9rieFfGIJs55qFjOtL7Itd4aMBIuBmlvK2YNCM2J+RXwolnBm9MaUTQzuhWsWPu/oPNPWfF/E42mWKYOXO//MSLKDX96ax9JeFKmxwbDcaM6sPnfCvu6swcH8fdcJASUmftBKfgNemTZ2xp+1Fm0GKdhoSeBRgWV9TsCVCSjavUlH+fa8UKuO6zd9dsPs7IaWt1uUZm9tkl3Tt9ywdyyhgzuMdiDZZCQqtUsjqOBn/2JGutToPFwhsMpkgAcr0zHrxdpnOyK640/oxtxelWtV4uWkCrfKiwZdE4coMK9JeAZHxiX3paXvgLB/vR1XoeAZCmYnP9nAr8VNyJacS8uR3zVrYsCn8FgiBnpvWLcmXUymSdFRueuaqEWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(31686004)(2906002)(7416002)(5660300002)(110136005)(66476007)(44832011)(66946007)(66556008)(54906003)(478600001)(6666004)(6512007)(53546011)(2616005)(26005)(6506007)(6486002)(4326008)(8676002)(8936002)(316002)(41300700001)(83380400001)(82960400001)(31696002)(36756003)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djhJdmc2VXNaVkRuR0doSVBRUXF4K3hQdWhia1h5RWgrZDBpSDJ1bGJkR054?=
 =?utf-8?B?MlcvcUVCcUNZbzVXdENqWGpZNUt0SHR0cWpraTR3QllUY3c1QTlpR0ljdzFQ?=
 =?utf-8?B?d3kzcEszWGlHSVNpSVQ4T2piZFhUZTl3eWp1dy8wbTN4WlNXeEhDZUhPeXlk?=
 =?utf-8?B?MU50emp4YTQ0TWNTOXg4dXJyRFc5K1lmcFhpamdMQ29pVno0YWlsSVdtdVB2?=
 =?utf-8?B?cUJKWHVrWnlzdk81SElJLzJzTEI4cUswMm40anR5V0dOTVpDM0ZPV1JPT0g5?=
 =?utf-8?B?U2ZBVGR0aU5yRGRrcVQ0L2xkVFVZZmZQUExTYkpqZmdaZFZLTzVaRUhyTUpN?=
 =?utf-8?B?MzFDdFNsWDFaNFZnbXl0VXZqQklLeTVHNUJiZ21hd1dsNmRHajcyK1k3bjRD?=
 =?utf-8?B?UFI3K3VBWjJuaDBFL0RCRCtHWm9CRzVLK3h5THV3YW9QS3FaTDVseDdxSlJa?=
 =?utf-8?B?NDRtWXdCQjZJdm8zYVl1cnk0NFVxTjY4ZGY0SW1uWnBGNExwMUFUYnVoZ0JW?=
 =?utf-8?B?VmhHWEVVenNUVkVxUXhVdHBFMThJVEx3ZTZLWTdiY0xiN01VZjZCVnp6Vkt5?=
 =?utf-8?B?MmMwM25OWXJWMTJEYzVxQVZTdVJXV3MzdVZvNDR1WWxjaDlGMVFaNzQ5TXdM?=
 =?utf-8?B?TDZNRnMrb2xKY3Fwa2lZUVRtNmZmQlMzYisrUHlIaEg3cGNEMStLUTk4ZzJN?=
 =?utf-8?B?ZVdxa09SbnY3dGdhTlR2SEU3aXF1SkZwUGhUdmJGaUxtVy9hTGVlTWZ1ZHhs?=
 =?utf-8?B?Y1lPaC9kdEpYNkRjcUZ3Tm9nTGw4TkdLbS8vQUkwWTduQkE0eHAreVRaMTFK?=
 =?utf-8?B?Ukc0TE9tb29uTWVQSnlVS2xJWXh1MSt2ZUttT284eVdKZW5sZ1BiVWl1Z1RQ?=
 =?utf-8?B?eS90Yk9VME9SNFBmbXlBSHBKaE43dkFYVzBpcWtvZFlwQXR5Y3VQd043dGFT?=
 =?utf-8?B?d3FhVXhKVTg3aUNZOWdzL3pBcllrZ0pFc3VQT1V3OFJXUXBrNnJTaXlWeDFt?=
 =?utf-8?B?T2c5MW9kUzl4ZEpQM09QcEhUcEFXR0pnWlhPZzROalJHeFBBVU5BWTNXWDBu?=
 =?utf-8?B?bU1UV0FleUVkVTkrOGZ4T01vdG5hSWVZeElMSUN0SE5uTVk3Z3cvQ3ZvMmpJ?=
 =?utf-8?B?eTYrQUtyTkh2OTl2cjBxSDFHNnQ1K3JyTVV5Mkp3bkpJcTA3VjM0TzcwbklX?=
 =?utf-8?B?RzFnNDdyeGphYUN2Zk9EQWs5a2RoNWhLYkxPV1pLRkVESTN3cHBMaEZZd3ZY?=
 =?utf-8?B?MkJxYVA0aERHdGtLcU4xWS9iT29GaHhXbHRrTVdPby9WNkNwUFhVM3BKcEsr?=
 =?utf-8?B?TEpZWjQ2VmZJbU9XQ2JoN0I5SmpxOW1sQ3FHcUVvNkwyQSt4OGV1Z2QwNllG?=
 =?utf-8?B?MVVEd3R5L3NoNGRYZ1dEdVhJSjljWlNNWTZmWVdqWWVpYlk0K2J4Y0p2eVMz?=
 =?utf-8?B?OWJaZmJwTHlDU0o1V2FwcXcxMkVyRENtWUhIazNxaklacGxSRU5pQnh2a1F4?=
 =?utf-8?B?K1dZMFozSE1Pb2kzVTdnaVpRTUI1b1hlMlV6UTUzN0JiOXZaakRMdDcxekV0?=
 =?utf-8?B?T0YzRFBVZ3VlMkRlOExVbEpEQm9RT0g5TU5tMkJXcTZ1MXh0aisvR0Q5bCtV?=
 =?utf-8?B?S3plVjlyS2dEaVVmZDgrSkFyNDBKaUVkakIrOWphZmdsUEtRRlNUeTBtdDJv?=
 =?utf-8?B?MWhXOUE3NmxvZmNseEdxMDY1R0FWYUt4YmJtSDNUM1NwdmxxcDh0WnRObmlK?=
 =?utf-8?B?K3J5Mnp3NmFCamdLcXM5eWRPbE9nZVJ2UFBWZjZqd2J1MkZFOTdac3hhU3lh?=
 =?utf-8?B?YTVHdHRBd0hFREdEYTFUS01BbGh4bEM1c1E2L3h5WUdpUmxnQ0l1cStxVndp?=
 =?utf-8?B?VHZGc3hUbTh1ZWhrUUpwK1NxZnlmWjdvQWJkVy9PSDVabUxCckV1c2NWaEwr?=
 =?utf-8?B?QnQwSFlSZHBlME5VWjE0OHM5dDhaNkIvMmxoaTQyb2hnVG1OVDgxbEI4djY2?=
 =?utf-8?B?cFgwZTJQWjRUZVBVSGxXaUNWbkx3SDN6b2FaZkRaaXhBQU82OHJ1aFZLbE9Z?=
 =?utf-8?B?ei9XTHdmVERsQitrU0xXSXN2MW1WSW9nQXZEVyt6eVJDMWFvdkk3UXhyOUVu?=
 =?utf-8?B?VjRuQzkwUDdKTUxnSVJXNmVNNUV0SU15Q2NnNzZ0Q0FBS0dnSFFiWmdFY1VY?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddb2cd4-f44e-451a-5fe5-08dbbe1eae01
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:25:18.1992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0D3FrfFo9IbCcpTn0wxG7SHzTAABLbwhYzuIY06tsgVX661r9i2W0OwDMcJrou+bKtVswXC1a+Vm+/i6TknZKzD0EkgZ130eq0ZyGHn5HU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8033
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Subject:

x86/resctrl: Split the rdt_domain and rdt_hw_domain structures


On 8/29/2023 4:44 PM, Tony Luck wrote:
> The same rdt_domain structure is used for both control an monitor

"control an monitor" -> "control and monitor"

> functions. But this results in wasted memory as some of the fields
> are only used by control functions, while most are only used for monitor
> functions.
> 
> Create a new rdt_mondomain structure tailored explicitly for use in
> monitor parts of the core. Slim down the rdt_domain structure by
> removing the unused monitor fields.
> 

Similar to the previous patch I think it will make the code
easier to understand if the naming is clear for both
monitoring and control structured. Why not rdt_mondomain
and rdt_ctrldomain instead?


> Similar breakout of struct rdt_hw_mondomain from struct rdt_hw_domain.

rdt_hw_mondomain and rdt_hw_ctrldomain?

> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  include/linux/resctrl.h                   | 46 +++++++++++++++--------
>  arch/x86/kernel/cpu/resctrl/internal.h    | 38 +++++++++++++------
>  arch/x86/kernel/cpu/resctrl/core.c        | 18 ++++-----
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  4 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 40 ++++++++++----------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 24 ++++++------
>  6 files changed, 101 insertions(+), 69 deletions(-)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 33856943a787..08382548571e 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -53,7 +53,29 @@ struct resctrl_staged_config {
>  };
>  
>  /**
> - * struct rdt_domain - group of CPUs sharing a resctrl resource
> + * struct rdt_domain - group of CPUs sharing a resctrl control resource
> + * @list:		all instances of this resource
> + * @id:			unique id for this instance
> + * @cpu_mask:		which CPUs share this resource
> + * @plr:		pseudo-locked region (if any) associated with domain
> + * @staged_config:	parsed configuration to be applied
> + * @mbps_val:		When mba_sc is enabled, this holds the array of user
> + *			specified control values for mba_sc in MBps, indexed
> + *			by closid
> + */
> +struct rdt_domain {
> +	// First three fields must match struct rdt_mondomain below.

Please avoid comments within declarations. Even so, could you please
elaborate what the above means? Why do the first three fields have to
match? I understand there is common code, for example, __rdt_find_domain()
that operated on the same members of the two structs but does that
require the members be in the same position in the struct?
I understand that a comment may be required if position in the struct
is important but I cannot see that it is.

> +	struct list_head		list;
> +	int				id;
> +	struct cpumask			cpu_mask;
> +
> +	struct pseudo_lock_region	*plr;
> +	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
> +	u32				*mbps_val;
> +};
> +
> +/**
> + * struct rdt_mondomain - group of CPUs sharing a resctrl monitor resource
>   * @list:		all instances of this resource
>   * @id:			unique id for this instance
>   * @cpu_mask:		which CPUs share this resource
> @@ -64,16 +86,13 @@ struct resctrl_staged_config {
>   * @cqm_limbo:		worker to periodically read CQM h/w counters
>   * @mbm_work_cpu:	worker CPU for MBM h/w counters
>   * @cqm_work_cpu:	worker CPU for CQM h/w counters
> - * @plr:		pseudo-locked region (if any) associated with domain
> - * @staged_config:	parsed configuration to be applied
> - * @mbps_val:		When mba_sc is enabled, this holds the array of user
> - *			specified control values for mba_sc in MBps, indexed
> - *			by closid
>   */
> -struct rdt_domain {
> +struct rdt_mondomain {
> +	// First three fields must match struct rdt_domain above.

Same comment.

>  	struct list_head		list;
>  	int				id;
>  	struct cpumask			cpu_mask;
> +
>  	unsigned long			*rmid_busy_llc;
>  	struct mbm_state		*mbm_total;
>  	struct mbm_state		*mbm_local;
> @@ -81,9 +100,6 @@ struct rdt_domain {
>  	struct delayed_work		cqm_limbo;
>  	int				mbm_work_cpu;
>  	int				cqm_work_cpu;
> -	struct pseudo_lock_region	*plr;
> -	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
> -	u32				*mbps_val;
>  };
>  
>  /**

...

> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 468c1815edfd..5167ac9cbe98 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -521,7 +521,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
>  }
>  
>  void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
> -		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
> +		    struct rdt_mondomain *d, struct rdtgroup *rdtgrp,
>  		    int evtid, int first)
>  {
>  	/*
> @@ -544,7 +544,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  	struct rdtgroup *rdtgrp;
>  	struct rdt_resource *r;
>  	union mon_data_bits md;
> -	struct rdt_domain *d;
> +	struct rdt_mondomain *d;

Reverse fir order.

>  	struct rmid_read rr;
>  	int ret = 0;
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 66beca785535..42262d59ef9b 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -170,7 +170,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  	return 0;
>  }
>  
> -static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
> +static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_mondomain *hw_dom,
>  						 u32 rmid,
>  						 enum resctrl_event_id eventid)
>  {
> @@ -189,10 +189,10 @@ static struct arch_mbm_state *get_arch_mbm_state(struct rdt_hw_domain *hw_dom,
>  	return NULL;
>  }
>  
> -void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
> +void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mondomain *d,
>  			     u32 rmid, enum resctrl_event_id eventid)
>  {
> -	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> +	struct rdt_hw_mondomain *hw_dom = resctrl_to_arch_mondom(d);
>  	struct arch_mbm_state *am;
>  
>  	am = get_arch_mbm_state(hw_dom, rmid, eventid);
> @@ -208,9 +208,9 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>   * Assumes that hardware counters are also reset and thus that there is
>   * no need to record initial non-zero counts.
>   */
> -void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d)
> +void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mondomain *d)
>  {
> -	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> +	struct rdt_hw_mondomain *hw_dom = resctrl_to_arch_mondom(d);
>  
>  	if (is_mbm_total_enabled())
>  		memset(hw_dom->arch_mbm_total, 0,
> @@ -229,11 +229,11 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>  	return chunks >> shift;
>  }
>  
> -int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mondomain *d,
>  			   u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> -	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> +	struct rdt_hw_mondomain *hw_mondom = resctrl_to_arch_mondom(d);

Reverse fir.

>  	struct arch_mbm_state *am;
>  	u64 msr_val, chunks;
>  	int ret;
> @@ -245,7 +245,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>  	if (ret)
>  		return ret;
>  
> -	am = get_arch_mbm_state(hw_dom, rmid, eventid);
> +	am = get_arch_mbm_state(hw_mondom, rmid, eventid);
>  	if (am) {
>  		am->chunks += mbm_overflow_count(am->prev_msr, msr_val,
>  						 hw_res->mbm_width);
> @@ -266,7 +266,7 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>   * decrement the count. If the busy count gets to zero on an RMID, we
>   * free the RMID
>   */
> -void __check_limbo(struct rdt_domain *d, bool force_free)
> +void __check_limbo(struct rdt_mondomain *d, bool force_free)
>  {
>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>  	struct rmid_entry *entry;
> @@ -305,7 +305,7 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
>  	}
>  }
>  
> -bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
> +bool has_busy_rmid(struct rdt_resource *r, struct rdt_mondomain *d)
>  {
>  	return find_first_bit(d->rmid_busy_llc, r->num_rmid) != r->num_rmid;
>  }
> @@ -334,7 +334,7 @@ int alloc_rmid(void)
>  static void add_rmid_to_limbo(struct rmid_entry *entry)
>  {
>  	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> -	struct rdt_domain *d;
> +	struct rdt_mondomain *d;
>  	int cpu, err;
>  	u64 val = 0;
>  
> @@ -383,7 +383,7 @@ void free_rmid(u32 rmid)
>  		list_add_tail(&entry->list, &rmid_free_lru);
>  }
>  
> -static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 rmid,
> +static struct mbm_state *get_mbm_state(struct rdt_mondomain *d, u32 rmid,
>  				       enum resctrl_event_id evtid)
>  {
>  	switch (evtid) {
> @@ -516,7 +516,7 @@ void mon_event_count(void *info)
>   * throttle MSRs already have low percentage values.  To avoid
>   * unnecessarily restricting such rdtgroups, we also increase the bandwidth.
>   */
> -static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
> +static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mondomain *dom_mbm)
>  {
>  	u32 closid, rmid, cur_msr_val, new_msr_val;
>  	struct mbm_state *pmbm_data, *cmbm_data;
> @@ -600,7 +600,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>  	}
>  }
>  
> -static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
> +static void mbm_update(struct rdt_resource *r, struct rdt_mondomain *d, int rmid)
>  {
>  	struct rmid_read rr;
>  
> @@ -641,12 +641,12 @@ void cqm_handle_limbo(struct work_struct *work)
>  	unsigned long delay = msecs_to_jiffies(CQM_LIMBOCHECK_INTERVAL);
>  	int cpu = smp_processor_id();
>  	struct rdt_resource *r;
> -	struct rdt_domain *d;
> +	struct rdt_mondomain *d;

Reverse fir (Please check all code).

Reinette
