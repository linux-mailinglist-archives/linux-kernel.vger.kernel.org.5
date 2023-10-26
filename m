Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BE27D7F60
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbjJZJOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:14:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05807184;
        Thu, 26 Oct 2023 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698311681; x=1729847681;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=amH7lFbcmRZfSozhFNT1mIWs7Koj5kgUMvv3TQm+BA0=;
  b=gfqquhtuCpw8MHQiqjkmntC8uYjbqSajoG3sPJJePxlbICjK7LbcI6cj
   OeKZjz+ulcWS5vit7PkpGKsz7TprrrCPeP5G7FJuaEIJM+FgrvhlRZecl
   +CpLzI9/tkmwDDaEuhNFGVVNIGiMc7615KaJ/+UoQoJ6XeAYWJmR1ltfT
   QuVu9JPfc8wOVMajRjQ8x+TjMWXkLPLCQghJeZD3IZ7823j+72dLfCSde
   5B3uuAWEsq+jtH7IxSUdcdGzhB7obVJIejPe4pj3rpuD/ZRMpsS2laLpC
   /EhOITpIifZzSQQczXzwPHmFRbiY63OOoFz717ilsZeHfcL1tfwkJP20D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="307377"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="307377"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="794129241"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="794129241"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 02:14:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:14:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 02:14:39 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 02:14:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UsU7jXpPiOsAeSCI4VJffUIf2LXNJQFvMaI+pxmquqGLjtnRYT+alvCHJ3b0FDr7YmyWzz6CpJXGNB9owdSTTF0QH4wwzVQrZijnkEgoaHfY8K7gOYTOiIvV5KqLW+uGBUZE3uVB2WV4cMBM9ldxp5BADNLGUhcDq6nSZorUzFs8ThIcUsLzlUAbLRlBvExzR64EtbW6a62T0nzHvm1nDeR7GO2naiF/VIMlzQxbQYZBBehPuu5mqakjNi/GkD+C5SvE0pEXSn7AbIEilOso3au6O/M9KFIRK1ee4U2xZquoXQ5O00RSC6ZzjO9VRG0QyO2QZmbdqfpDROOAZ0jl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHuect+8ojKmcgzXw7PvnmafNsJkRtM8/rgX/sHe0xk=;
 b=AJGItS1ZvJUrWIO0O05FZ73P4gvZ4kSoVtFHXTDInL7C9qySSDfKaRRTbjAumxjAOXC15v8+/sliQerC6HAaYLdbnNpxbcCtcbPQqjk2nYOlBdRrbYkyD4C1JRGGRFKjRQnHIxWYj6W3R4jRjYwwPcw+I+VIVrYWkXgg9aMhINH99ca6DR/hnFB7Y3dNUmVhNdoEdsFkI3cvQCrwXNTLa890HdPYYUVIGF6kiAM3viWCVkaWh4PubCujlKS23XNw1V9jkKgwIZ3gF8AOEMDXYGKSepsqnrprd2hAyk1FTinVrkOzwl3XY6ul/HCdx3cnEJQYitlLMoE4pdXLAGzVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CH0PR11MB5396.namprd11.prod.outlook.com (2603:10b6:610:bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 09:14:36 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Thu, 26 Oct 2023
 09:14:36 +0000
Message-ID: <090b1631-6baf-96b8-3039-0e769c261cab@intel.com>
Date:   Thu, 26 Oct 2023 11:14:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH iwl-next] i40e: Remove queue tracking fields from
 i40e_adminq_ring
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        <netdev@vger.kernel.org>
References: <20231026083852.2623216-1-ivecera@redhat.com>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231026083852.2623216-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::20) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CH0PR11MB5396:EE_
X-MS-Office365-Filtering-Correlation-Id: 16226824-595b-45f8-9ff2-08dbd603f96c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nq+McLjCoeLar8Xpnn3tr8/4pb7RCgBcNNDIv6NSF+ixj9biYh0LBF3tUtQFpHCnGZYEddbM/M+ezWNGBB9V17baQKA5DEWbumYYk7ICu274QC6NwDJ8i0EDSXy3qqfNEVKANS6hcFZblr0hNhPj2aMROwQk7YTlOD0dxutNk8RVX6pJ3QehaKaHjwVgrd0jkz5e1qnZs4nsK2QoP0QbYwslkOS7fGyV7rbaf9MFT9u5UX3BMvJgPA7mlB82fDEbzjx5+o74XRNfyHnDTrWkPK236fiO9Z6XEj28/X+4itZxoDWrPmiFqROdi8WZJQcMiH44ZYBx7iMeA8oPVZh9KIqdx97tFtBK5sHNXmZKjJQFVc4+EFQWi8040T87v/9IJu7u7v5i1J0DAD4DQKTRIxie7AZUzkbZzqjxENo5ZSU9StOptW0H4HqIqYPV0yE4sfakem+aws24ysvOB7cCwFwSgNFnl2uro2NdC0Z9F5+TczTTID0EbUMpysPNq+RG6crF5MWlwF+3jmAkCIukd7PJBnfkeKyo1eYbI4e2VBX5lmn1LS49FhDJIlSSFKm0k59KzrTrESu3wOPVsF1f02ylkIcqKaAQpPJukgvriO7mDM4O3Ytx9CJiCMkhHq0+xrwAOjJNRVkHO29dQXRSQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31696002)(6486002)(8936002)(8676002)(31686004)(66946007)(66476007)(54906003)(66556008)(110136005)(86362001)(478600001)(5660300002)(41300700001)(316002)(4326008)(6666004)(2906002)(6636002)(6512007)(6506007)(53546011)(36756003)(38100700002)(2616005)(26005)(82960400001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0lvbm0wcDlzK0lsTW5ZdVpINFA3RkJCMThEUU5CeVZzUEdXQzRzTFFQZlVL?=
 =?utf-8?B?SVk4Uk00bDh5bUxNVEVGY0ptdldHQWhaWnQ0eGFFK1NhR1NGQ2E3YzJxbzI0?=
 =?utf-8?B?ekRua01JMFR5V0VnUTZIdlpyTUFPb1pFYmhOYTQxZmhwa21LbGt3RVcwWUlz?=
 =?utf-8?B?ZVkrck40WmNqc1lFYlY3U3lERHR1a3FqZEtNbWJ0eGw4TXZxeEpBa1FOYTUz?=
 =?utf-8?B?Rm1VeXNpQXdjLzlocjZQazkzcVBLS3YwdTJrenNHdmVCNm1abmp3YmZ6dTVt?=
 =?utf-8?B?MU1vd042bW43bUtTanNtb0V3clNsL1dwWUNKNVpDSmZIZmJhK0Y5NHNpS0hl?=
 =?utf-8?B?WmlQNjAzU1VheHQzblhVSEcyR1hMSEJwOUxzc2FwQmtwalFtbmFSUjBIUFVH?=
 =?utf-8?B?QWZtVmRSeWlTbTdnNCs3dzM4UHVtT2VVWHFVSmg1dUpzdE04K0lTb0hFMHZa?=
 =?utf-8?B?MlVVaDl0SFlsM3BRdmNwenNZVXd1UWdUQ1h0N0NzQWNGYzRXUVd6c253SjJq?=
 =?utf-8?B?N09vandzekdxSm1Ub2gzV3B0Witlck5lNWs5NzVVeDFwS0xNRmQra3RvN3F2?=
 =?utf-8?B?dXRVR3ZCNDJFR3VxbEhLTjUzc1M0MUNDSzdKQy83dGQ1NUhJQ3c4K2R1L2Er?=
 =?utf-8?B?Z3A1Q2FIL0xjRHBoRi9sdjBKTUtlSkZNeFVIUjhzSTdWWGc1VXpyWUF4TGM2?=
 =?utf-8?B?OFNpaFhvc2ltdzVSblVaUGFxdXhOalArU3JYSVRSRnZYNlFvMGthS09makk2?=
 =?utf-8?B?OHR4NitOTlBzTmxId1EzektuNUFoNW4vNzVPemR3eDNOOUZJL1BKcFV3bGdP?=
 =?utf-8?B?S2hObGdYeVNxNHh6NDB1SzZQbjM5TktPN2lydFZUblJHTWVZcDQrdmc0T0hh?=
 =?utf-8?B?S2kxdytsWVZIVmY4MFFPeGFQZk1iMXhGZi9VdkRyVUl6ZGpSb1Y5Z3RqdVZQ?=
 =?utf-8?B?bHc2dmRpSUIwWnBCUlcrTWhlb3JDQlh1bEI3NHM5YTl2RzBFTmpGNGtNTTNy?=
 =?utf-8?B?QjRPS08wd1U1RjBhWGFJMmNnbW4zRFU1Vm1mY2V3aTVlUFJMd2JkN2ZETVpj?=
 =?utf-8?B?SW1hbjhmUWFYMFlqcGhZa1FrSmMzUVdWSkluaTBpNzR0T0J0MWl5aytxbG92?=
 =?utf-8?B?NjhQVU9UaUxXWGYwcnFKL1ZuWjM4TXBSYUdlRzdkNnJxV1RQUFk2cXRUTTJT?=
 =?utf-8?B?d05vaC9hL2EvcjU3d1BYMXJBbGZibWl0VGhLa0xNa1UwVFY1aGtpUTArVll6?=
 =?utf-8?B?Zm03UE9PazVEVHRiN3VNTjNPZjVyQnkzUUxVblFTV0VJM2Q5N2JyWWhmMlZR?=
 =?utf-8?B?Q21veU9ESzYrZTJNQTc4b0ZKandwYzl4UjJDanBLU2FNdnRacy9oNU92V0py?=
 =?utf-8?B?NktIeFBUeVhzZHB4bHdsMnovU1FUWnR6czRqMmQ5b0Y3Qzltb0RNUWVaQTUy?=
 =?utf-8?B?TzJ0V1lUWjBwLzJ6amJ3TjZUa3ozSU94MGxKRDZETGdaWnNxOEdXMDdqVnp2?=
 =?utf-8?B?Z0srSGJRMGZzb1Q5MDZEUmYrR1l2MUJ3MGdqTTBQelliU3Y5ZDlJbDUxWDJN?=
 =?utf-8?B?U01adnFsVGRKS3plV1JWV3VDcjJMajVEZ0psZmZ3bmo5UE9XSG1jOFpXTEhS?=
 =?utf-8?B?clVTaUNUd20rVjNhVVBhU1FoVGoxclNrR055RGNYVERDakQ1eUdyTmgvV3Z4?=
 =?utf-8?B?ckc4c1NtaGg1WnFPdGo2Q3BmRGRQbEpDYnN6ZHF1M3dqcE8yd0dIWVhHZkFJ?=
 =?utf-8?B?L0tLdXgzbHNaMWtQQWNySjM2dWx6ai9WN2dObnFpK2g0ekY1amRPN08yV0Vh?=
 =?utf-8?B?cEtZWHNROXVkbG5lN2J3UDRXNjVZSENPODFiSGtBa0xvOW9FMGNyQ3QvSkVG?=
 =?utf-8?B?SkpxK3lmdTJzQW82RjNDU2UrUEtiRVl3Z2NBMXZkUmM1aG9MTDdNclFzV1FK?=
 =?utf-8?B?YTlsWnJmdGQ3SnVERFZZUGNQYjkzVU5zL3BlNVdDbGdXenF5RVEyNU1XelZu?=
 =?utf-8?B?b05nQ2FoM3ZWL3FwdHQzRG5SZEZ2b0lvenU3aGVWOU44RjFySFR5MG44eG1M?=
 =?utf-8?B?Q2FvdWFzL1BmRzFVSnIxcWVVdlRqUmJ5VVRkUHpzV3hQaHN1eGpHMDEzeGxM?=
 =?utf-8?B?d3VYMU5iTXdlVVQybHNxVmZMMFNzWFdETDdDT0YvQmRaeFl2Qk5GMzhYb0VL?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16226824-595b-45f8-9ff2-08dbd603f96c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:14:36.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fF6KV1sfHpKPDdDVXCcWsr730Os7HbLOXunpIrCwv12taSMMYcMwBz2gsAz4MGktZpeqI/69hNJ65M3VkdQj3uBOnypuZ3o4iGGSPy3IWAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5396
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 10:38, Ivan Vecera wrote:
> Fields 'head', 'tail', 'len', 'bah' and 'bal' in i40e_adminq_ring
> are used to store register offsets. These offsets are initialized
> and remains constant so there is no need to store them in the
> i40e_adminq_ring structure.
> 
> Remove these fields from i40e_adminq_ring and use register offset
> constants instead. Remove i40e_adminq_init_regs() that originally
> stores these constants into these fields.
> 
> Finally improve i40e_check_asq_alive() that assumes that
> non-zero value of hw->aq.asq.len indicates fully initialized
> AdminQ send queue. Replace it by check for non-zero value
> of field hw->aq.asq.count that is non-zero when the sending
> queue is initialized and is zeroed during shutdown of
> the queue.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_adminq.c | 86 +++++++------------
>   drivers/net/ethernet/intel/i40e/i40e_adminq.h |  7 --
>   drivers/net/ethernet/intel/i40e/i40e_common.c |  8 +-
>   drivers/net/ethernet/intel/i40e/i40e_main.c   |  8 +-
>   4 files changed, 39 insertions(+), 70 deletions(-)

Huh, our code is so self similar :F

as with iavf, asq change is semantically different from the rest,
anyway:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

BTW,
unless you want this applied directly by netdev maintainers (so skipping
intel), you should use "iwl-next" tag and set to: IWL, cc: netdev

