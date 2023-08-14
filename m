Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825FB77C22F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjHNVMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbjHNVMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:12:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CC2E65
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692047543; x=1723583543;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gaR75KD21r1MpBGDrCpiNMYM5tuF9B43o89dNG1groQ=;
  b=JJkmFsh7HJKnFGM7Yrv4xjU6MKljxQfbbkegw5nT5UBekNXz8t9G2Ss/
   YRHpOfgJHlgUapnW5lItEIOzyJuJjvkHy0NiF+5mN/Nq5X7Em9mum1kCQ
   exl6NpuPVLBW4u5doYfwUeYNIuBUCkhConJAIzTzoO1H5PPzKz2xciF6q
   hXbBqFvBd5YkojDXKahc7V4JJ6C9XAFpt+2xOvWhoskgLur9Mtmitu7id
   Nck+jIwAmLcAVwpc/61LwGvjIQFmwXqwVmoogfpkaRg4D0GXYeulOGHpS
   7ToIbqPCFsLRSLQbt/1oNiC8vJG0WpU0fP81FamEfW/fujT78paw4Hks1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="438476538"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="438476538"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 14:12:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="857198384"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="857198384"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 14 Aug 2023 14:12:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 14:12:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 14:12:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 14:12:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 14:12:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ea8tc0TtKTh4vOCMzXogifMw5aRDlLrEO9jZAwJaonN2kHnZtoQUE8gYqRYdhHGa7l0loTgmeDOxO7/U404+75udJmMF/ffmqdTVctQngc4d6Bha+ZIhJJ0NGfr4Jmi8uZ3xgti3qbyIST1YWoxP1nP/Y9wtCFBSI/8H+Wxn4Hnsq/5w4f2J4xm8KkdnqgfSamPRqsgk0N6TVL2RpYVu/xmWyHwqP9uhlbO98knR9RQo7iSxld23QAyfNB5SWYbz8saQCYOTHFfWhu/6FDnxKu0aSHlC+N1aOyHOtrmAlRyOpP7nE9gQyX75fQ8mSTyBUU9/+DQ7s+SDtnTXUiYx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IArT+WLBfveE7tAywLqgystZceN5/RaduDllvgkQuaI=;
 b=eJQYsrQ5xMp/0V7q9w2xNenSbr5XuYUDy4g5eeIbdYqKHraBkuhO2h0rhiQP59A3ZQWN6JR40K+tcBVZvFJ28Z6HZkKvRvWhaRwGoJX++PolHNuea0a0MWafRaaKwjYx6ifATAvWSJKIu3mO0akmBlyNGQ3ruspSm8Ma6QRXKvTMsojV8W0Z6KZ+yBlpUrV3WGOcGjNSF3qpqgOyM4TQpC62u28D15e0UPHgzJVgRcQlsTxzVCH1anYQagXIwGw1GM3zjKJRI8Q9r/yvAioJmGyxQDRoTzwVhIs163AeNoPLm6tMXX3xca7ambg1ZJcTgXNEIHwDoFdpHXAXUhAPOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH7PR11MB8549.namprd11.prod.outlook.com (2603:10b6:510:308::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 21:12:20 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 21:12:20 +0000
Message-ID: <841e08d9-ce97-e57a-3fc4-0fb87322903a@intel.com>
Date:   Mon, 14 Aug 2023 14:12:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/1] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options.
Content-Language: en-US
To:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        <linux-kernel@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>
CC:     <x86@kernel.org>, <bp@alien8.de>, <tglx@linutronix.de>,
        <hpa@zytor.com>
References: <20230812155448.8865-1-jo.vanbulck@cs.kuleuven.be>
 <20230812155448.8865-2-jo.vanbulck@cs.kuleuven.be>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230812155448.8865-2-jo.vanbulck@cs.kuleuven.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::20) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH7PR11MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c919e6-91f7-4011-3d46-08db9d0b24bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjKCSLXiy2Mk2NmqymNBoFX5o/V/4Uf9qESLHeyUDokcjm17leCQnBbIWxIYUlcW+370MtjnSRKPJbY/+f0fMPvPvjl97jUisrNU18S2sxHU6rBBVwpDPjWjvfUBqPrDJNFmdgvRHW/7QFiF8jYp9XTlcC5VkCpmtqE1uXcFFnxzzkoOvblZdF+f/0Qr6buqewrOmG8zh0zqKTqtSniMZSXfyzhTtqJfgB4OHvX8cAHGKC8vWMXdaxXh7+/FTdtnyeLjjiGGr+Q6knlCjJdPjwV4Xh9yP8bzSTa5ZqOBvZih/Dz3bw5agauZ5A+7hL1OQQv7T36L4kDRp9MkAGsXKAjetWapY+llkjE+iMb8PRMSDW1XQli64C/M6Z+oRdvmcE4hj8QyANeGtElEPxqtS0KbTaVV9CAhVlPUZ+o0DxZwjN1S3+cb+rZ2Np3n9ovqLx/YPYE5uBVmBYEzcUmdlL1u6t+mS6zWCW25Q5fboFZe6E29YW9ywRx6DSLQv7dpVfKsiTNMevQToJF3z/dsXEREEx5Wir+BjhY3224kp926omgwthWlFPoqjS05Q+rOVRMHoRJ5tDtSCGYkfb6Ux2TBG6OUb2IOaSzI7O2ZTQbvbZYFnsWi8HElrle+KyTiGnHjURMB7pvCvWmVlxUG6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(1800799006)(186006)(31686004)(6666004)(6486002)(6506007)(478600001)(82960400001)(86362001)(36756003)(31696002)(83380400001)(2906002)(7416002)(6512007)(26005)(66946007)(2616005)(53546011)(38100700002)(4326008)(316002)(66476007)(8676002)(66556008)(5660300002)(41300700001)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0YrZ2dDU3QyNDErajJKVlhJUlpGR0NQNmtoR1RaZFlkZlNKbHp2SzBpRDcy?=
 =?utf-8?B?UGRSb3JhdGI4VksyMXRLZUx4RTFVRkFHUDlyYkJPTHh0ZHlUMXhoRUViQ1Zm?=
 =?utf-8?B?VUNEMWtwditNaHNvQ2phS1VsdG56eTJTQ012c2h3MVhIRTExWjFuTGRZSGhY?=
 =?utf-8?B?a1NBZjBDTjN2SGdnZEFvTHNzUWpMaXp0Z3ZHSXg2dXF0T3hTTDltWDIrTVRp?=
 =?utf-8?B?N2J3TUZuWW4yS1FyamxNOE4ySEwrVnlhdGh0U0Y2ckRNN3JzNUdENmpkYUlq?=
 =?utf-8?B?ODZVK3B2VEhjQk9kMHJmWElkRVVJMXdXVjlydUdVRzI0L2VYUXd4RmphUVRV?=
 =?utf-8?B?VmtiU09XUElPUGpQZjVOVHYwVGRsWXoxVlliYmk5VVFkL1VQN0hWekt4a1RY?=
 =?utf-8?B?MklTWGZlYWZoZW9Hem9Ub2ZsV2NIelhvQkt0L0FVT3ZFbTVYNXY4VGlCYlBw?=
 =?utf-8?B?ZmJLakUyRUFoZUgzWHM5a0Npbkwzcks1Qm9oL0Zicm54R29OalF1cmlqd1dC?=
 =?utf-8?B?cW5qaFNnRGRrZ096Sm1uL0RqL0FoWEEwSFVSZ2tsdUc1eU8rN3ZtZjU2NXNH?=
 =?utf-8?B?aUlOME5yZzREN0lNRmx4QjdJRHd2WFN4SXNibEZ2ZkZGRG9WbHdkZlJOVUJ3?=
 =?utf-8?B?VWxGaGd3NStBZDNQNHo3c0x2WkdkbnkyVFp1OWJpSm9qRWFNK216alcxM1Na?=
 =?utf-8?B?ZytFdjZjTGFpTG9qN0M2U0QrbEZPSEE3b1krK2d5OVFwaTBFVmFXSENIWS9D?=
 =?utf-8?B?K3cySE5kWmtJcGdZaDlLME9paFJON096b2hQZy8wamh4b1NEQmk3d3ZTdHE1?=
 =?utf-8?B?bEhiTmY4N0Vid0gvNGJKbFVIOU9GZDNpcFdNTmlCb3Q0Q2NmS1NaMXpESmFK?=
 =?utf-8?B?Y0pGaEE5WTQ2QmNHQnZpRnc5bU5uTVhaM3FIckFILzBhSHh4R1BpenRYbnB4?=
 =?utf-8?B?M2d0YWRYV3RWdkV4aGZGa3orcjJ0YUtjZzZYWlhYNEFwdnJ4Vnp3NFg3ZEFC?=
 =?utf-8?B?amRMZmlwcnhGNFJ1UGVwY2htWmlOTzRQNkJmM1R5dXVia1p6UVROYVdWbTgw?=
 =?utf-8?B?cVR1N21SQXBNQ3VudlBtaTM1UnhoNnBPS3pvS2N5eEIyOTFVWE4rVzJmK3pH?=
 =?utf-8?B?bWNDcnVUejMvRldXbHg0MzlrOXB2WVVGeEN4YUt2QVpGR3V2d2NGaG1RQUJN?=
 =?utf-8?B?RFpVTjBSU1V2UHUxRVUzdDJZanhwVHRYRG1ZTisyQ2pNcEE0d1pzbkRjeUZu?=
 =?utf-8?B?d0crL1BBYjczV1FOYWx1a0tPVkFxWWlHR3dlQnVJN0UzSENIbHJsd3pWVEtK?=
 =?utf-8?B?WTgvdjIrKzJsYlVqWjREZmNMNDJwakQvQ2FpRFJMQUh3a2JocFNHZDhHMHVs?=
 =?utf-8?B?cVduQVhmbTlFTHhFY1RBb2RYaWcxUWM3TXhqVWJPeXNwTndtczZZSXRJVUsz?=
 =?utf-8?B?UzNESEMzUVZwZDE0RkFjT1hyT0ZaeTBxVWRlaHluZTlKeGFIaU5uWW1ERzFB?=
 =?utf-8?B?QjQxSFpTSlF4d2MyWHJaS2xwRjdBSWRGZldSdXc2QXFRdTJUZThVUUZOZUFE?=
 =?utf-8?B?OWcwTUdYQU0rSElKMGMrZGNXWlA2MWFGdDVKM0JRRFFpYUxYQUJGTE4yRG9R?=
 =?utf-8?B?NDJLVFVqVlVtdGptMXZkbGQxQWlFUXZuQXJsWm1JYlJ5ejVzM3dOeWpNSzdX?=
 =?utf-8?B?cEltRnA0K1BQRHhHQ3pscGJkZk0vL3BHSm9BKzY3MkNsMTFFSXJkYS9aUk5U?=
 =?utf-8?B?aVcrOGVEc0FXRzZ4NjN2eXAyQU12d1hNU0hRUVFpR0U4L1IyZlMvcnNzQkp0?=
 =?utf-8?B?blZ6YW1rU0hEb3RvdWtCQ3IvT2dDZ0NpQ2toVjhoVGtxSnAyWUV5TVhxSEdR?=
 =?utf-8?B?S2Z1VEozQTZGRFNGdk0wNFJ6NlpmcW5tZkFKeWNNUnRGZzhWV3kvNVpzQi9E?=
 =?utf-8?B?NTVVZlBOdVk4L096ZFR1QjBheWZzbkZXUVc4amhDS2xjRE8wS1d4YlZLT3Rm?=
 =?utf-8?B?R0lwOTVKam5HOEdRREhTN25tTldqNlNTYUdZanlVYnlJMmVvZmg2OWltQjBP?=
 =?utf-8?B?YlpaWHdpcEpHeGxnMG1PelpRVG9vSVRqQkdhYmY5MEF4TTFPVUx1WDFzWnJP?=
 =?utf-8?Q?/50R8N1xCHF7ksczcDOVpAoHi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c919e6-91f7-4011-3d46-08db9d0b24bc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 21:12:20.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hdy5YjQ2AC1YVVQjfroXjGvgbIMA7AAiZF9wCp9UfbITMNdh8UciQcMrXFMZC4mMKl0l39XloINK0g4P7MnpIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8549
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/2023 8:54 AM, Jo Van Bulck wrote:
>  arch/x86/mm/pti.c | 55 ++++++++++++++++++++++++-----------------------
>  1 file changed, 28 insertions(+), 27 deletions(-)
> 

This version is very similar to the original patch and much simpler.
Sorry about the unnecessary churn.

Apart from the minor nits below,
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>


> +	if (cpu_mitigations_off())
>  		pti_mode = PTI_FORCE_OFF;
> +	if (pti_mode == PTI_FORCE_OFF) {
>  		pti_print_if_insecure("disabled on command line.");
>  		return;
>  	}

A new line here would be useful.

> +	if (pti_mode == PTI_FORCE_ON) {
> +		pti_print_if_secure("force enabled on command line.");
> +		goto enable;
> +	}
>  
> -autosel:
>  	if (!boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
>  		return;
>  enable:
>  	setup_force_cpu_cap(X86_FEATURE_PTI);
>  }
>  

Was there an issue with the flow you had in the original patch? It was
avoiding the goto label and flow was a bit more linear.

> if (pti_mode == PTI_AUTO && !boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
>  		return;
> 
> if (pti_mode == PTI_FORCE_ON)
> 	pti_print_if_secure("force enabled on command line.");
> 
> setup_force_cpu_cap(X86_FEATURE_PTI);

Sohil


