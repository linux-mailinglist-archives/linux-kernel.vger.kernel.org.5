Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2556E7F5D12
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjKWK6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjKWK6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:58:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52B1D44;
        Thu, 23 Nov 2023 02:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700737090; x=1732273090;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5+WH8YQamGc7Uju7P24kfUpSpYuO1ehXUk9QYkzsOXs=;
  b=V2IcHHQmnlnJf0dK7+MzWnqY1VFb97rkb6Xeh6Nil/ivZrs6Rk9jgQgq
   WeOVmmcU2VdtZ2rxAgrs6NcCazjyDA/qxchekKrrYHAE2TqP4HLJv2cgp
   JJPv+4JRb1cDaibC01TrqdsmKQc4EVwgPrKsakPvJjqt8uLYhq9Gc89nB
   gvbQa6bf3w65C4HGEcVqbitA5lWCBa+UFcK6xbaiC5F49rpUN8uvyg4Bp
   e7HZVOoP4J/JVlSVyrwbtXggmRHvXL5HFrcRXgX7S7H6st7yOfKYcb1h1
   lxdfnFyF1sD1O278hyF6tCpPR+uFn/pLq0K1QCuE3EPKY5B+O5dq3I0Ww
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="372406268"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="372406268"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:58:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="1014582887"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="1014582887"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 02:58:10 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 02:58:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 02:58:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 02:58:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLH/w6f+7Gchza+rvgAnT61dFUaONc5U0lcpZJGtE7SRXntZM+pT1aKoiq7J0LDLirmX4pUWeAdRVfa+000PFnGhjgSINDql4CU0BViI7MC8ZbtI2FakmfRuNq4a0mjF5tfo3FwNh20HgHWSL2UbwByoM7KkplUM1BAR+nVThyPAYWm3Oy2ki6Q23toJUM8xde+b/nW+hfZBlWjWI2vmJgiZWUkNNAj53v10s5+IQFAm50OrU5LxGOAzh6jnIkqWtGx0HrsM0B2H7SbosvvcqwJBhBM6E7qfideHYe++9qBca7vyqjLhCi2SyPTlNIr6BX2Pnz5jSOaa5ySCvP/pdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdEFYk7DrfhYzd0QRMP9pQXxXGMvFbaBpKoQDEt+2ag=;
 b=JEKnF3ivG1rHMmgXUZ6+3YSelhm/1v/DWB2zrgATBMTGKemf1m67uJr+n1ws7Ag2u9AKs7xger67UMTRi8GT0aPdynDg5UDqH2K4o06t6HyUuHHQxveGY3rK2H+qNRJlmrofAcwTcdc3ZZmXVX9z9fKpRdUz/E0VqDhDONBTvuEMHjOBbL/dQ/IRCW/ZrGxzJ7uCdi0+/1781n5j02uaDDrQo/Qhy4SMtlNadPcJZIBO0fuN9W+gIg0evtzR9QOZG4b6/K/pTmcZsFMOn94Q6VzyrIoQp1QyO3qvJOblxmAu/eckw6NG17rWUvU8NVnpyq6BZA0AVv42qwxrzvFrKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA2PR11MB5019.namprd11.prod.outlook.com (2603:10b6:806:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 10:58:02 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 10:58:02 +0000
Message-ID: <bf6874cc-9604-408e-abee-8c26cf680b11@intel.com>
Date:   Thu, 23 Nov 2023 11:57:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH 5/5] octeontx2-af: Update Tx link register range
Content-Language: en-US
To:     Geetha sowjanya <gakula@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
References: <20231123055941.19430-1-gakula@marvell.com>
 <20231123055941.19430-6-gakula@marvell.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231123055941.19430-6-gakula@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::7) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA2PR11MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: dc28ab3c-db2b-4eaa-b4d7-08dbec131008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpKbkvAYFWd1l0SSb6/zAkHwyc8AawlCX/nv0f8lcxQXjQ0wRk8LebK3yFwchjao+uD11bwgAzy2fdIDqXTbZQY7KxXV+jwanSmx8HWZTUygqLBGqjcFdzjqAMhbTSTbsz9zUY/BZ4TW1oz/pMyhpY3Pe0xacsK/sSp1YEpH6trjYoDuhz2fiNsfDvlGaySruT+8NZvB0jC1b+1icvge6liT5AnjEIvV30gqQP/rOvhPM2ji7DASe1ekylvj7RTlbEKJwzw+g5PBDs4BzVpThjYL2tReJ4ejPKrtfI4SJF0wUc5BZvveNo/Hxsn4CFmtuOpALCp/O3RtcTi1GF3J+0yARHoHB85p2NTHXR5axlkW3f3s5TPE6EISUr31ReHfmAE8KR1PifCnG506hfA2h6vuQybnlSS398JP6hZxooyFiD71CPxOIBK2+N0aNHSO0eaCoceaHZUKOuA+ubX0CW2lCEHg7r+5F4VR6XZXJesYp0ehrZpGmIP+cZVZM0YX2GWp5hj5DmRvOdlM7XRmF2sYM/wK5S1w7u1KdLzAyFmiaMLFAA/qk+SUIxFSarU4liUM81O+dCuADien5n2HR3ZAz8Od9dg249ZX6unwjl+YroNaMWqyuzjQu3uZFSSl3fOhp/qdBAjFl3EmkGKuvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(53546011)(7416002)(6666004)(2906002)(6506007)(6486002)(478600001)(4326008)(8676002)(8936002)(44832011)(31696002)(66476007)(66556008)(66946007)(316002)(86362001)(41300700001)(83380400001)(26005)(82960400001)(38100700002)(36756003)(31686004)(2616005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHBKemJjVEJ5NWtETnp4eWxtZlpNOUgvbVZFVDFkRnl4TkxNd1k4b3F3ckJp?=
 =?utf-8?B?OEQ3amt4MUtQMU9xM3BYY0JrZ0l5NjU0Tm4yYlYrUkpEamxOWFRXUFFBZm4y?=
 =?utf-8?B?TmJVRFJrbzZ6YWErVnlnZGdIMEhwTFR2UHkvWUMySWk4OGovcjJnaXVHR3hY?=
 =?utf-8?B?dmxBYmZqU3Vza1hCUEdnRzl4Z2tZWTlGRnZIeDdMclJyN2s4eXVtdW9mWWx5?=
 =?utf-8?B?Mk5mMU5ZeEcydWIxYTE3aTdUbEozY0ZHY0J4SjhqNTREOEF5UnlOMzdHdUxC?=
 =?utf-8?B?V1VpcGhMZFdqQzhxdnp1eDlaQnBoRW93ZWdObDhGazJZaUYzVkNrNzQwN0xw?=
 =?utf-8?B?bGdtRjQ1aGRmNXU2Y29DSVdPei9jNmIxUHBzM1ptQTNwYWFMUjh1b2ZpUDRQ?=
 =?utf-8?B?OFdlVU9iRm5qcE03WmVSeXhscGVKVjFEdVloZkNxa015bzdzQXZ3d0d4Y3NV?=
 =?utf-8?B?N2ZDdUZ5REQza2pMd3hqRG5rOFdlZ0hYSERFZnpPa2h2NmFtV29qaVoxSmg1?=
 =?utf-8?B?T3Jpb3VpUyt3VjhxQWV0RUFWcUowSUFLWEJhdlFaK3N5SER6TWdiRUR0TENm?=
 =?utf-8?B?c1VJdDkzS29CUnM1KzFRVjRKZXJ6d0c2RWdYLzZFY3RMT0RRS2tPd1RiWmhz?=
 =?utf-8?B?cktEQksvbW9EOWdzSG9VYWpheXJJak9QUSswbTd1am5CL09vVkI4ZVRoWjBW?=
 =?utf-8?B?OS9LaGozNDZqTHlrVEU0MWdhTE1XVHhUc00zK3I1bWUxb25ETkRMazVQa3Ey?=
 =?utf-8?B?Z1F3YVBBKyt6UHRXQWZzN3RmT1hBcWpENU1DaHhDUnBUZEcvN2ZBU1dLVzZB?=
 =?utf-8?B?cldlNzBqNkw2d3ZxYlFURFNOUzNvSHZQSStGWW1UQ21yZXR3UDlFOHI5eENP?=
 =?utf-8?B?UG5UVlJaWTkwZ3A1K0lzYkJUemF6bEo1MnpmZUdKZVd3dkUwY2FlVCttbU5Z?=
 =?utf-8?B?dTVKeitLYnhqZHEvcWRoeGdWbkhWVXgvWGwxODRrWGFXbENleEpYVC9hMlo5?=
 =?utf-8?B?c0lmbTBCdjkrQlMwQkorditxMHpPN3NIdVErTHNyN2Y4Zk00VVdmaUI0aXNM?=
 =?utf-8?B?RDlLaWc2LzhoOUFYQVRqcWxLQUVZM1RtVmZsRy90TURCQWtHV2Zjbm5tclkx?=
 =?utf-8?B?RHF6VVg0UVlUaFFGLzJxazVLSjc0UzFneVhLWCtSSUM4WmFXTlEwd1ZteEJV?=
 =?utf-8?B?ZHhsaHFxKy9NemEyQTk1T1JyOUpjQW0rUmgxUDhidDJSeUJKUGZja3p1NWVh?=
 =?utf-8?B?bzhKK1JTeUhyTXhPc3d0eXNqcVFOck9uZFNHZkdKVXE5c2JJM3k2UXJzNDd4?=
 =?utf-8?B?TzRpN2J6QmJ0VjQwVmFaZUpuYU9sNmR4eThxSDZtWmFBZVZFVzJ5aFY4Z0Z1?=
 =?utf-8?B?ZWhZdkdBU2t5RlpkcEpQY29NSHNFK3orOXBrcGhWWm45M1MrMnBibStmbHUz?=
 =?utf-8?B?RGRPLzNKRzA0Wm1yaTlmWC9DaW8zYXRLWnpNSno5VGFUNWNZbktjYzR2d0xW?=
 =?utf-8?B?QnZyVUR4WmFkNTBYYk91Wm9MaUVEK3FuYUxwdFZDS25Ka1VhNEFJL2ZHSmdK?=
 =?utf-8?B?SndhL1dyN2NqSVZYczFjOUYzUUt6UDZwaThTK1hFaTVHL21YcG9lYWtZU2Nq?=
 =?utf-8?B?emQ1TEx1NC95c1plZ1JqNFdDTEVsNndzbVhXNU9McnJad2c1RUlGMzg1bXNG?=
 =?utf-8?B?aEhTMlNXeXQyQlhZUGNrTEpscWRkVkFxR09acUZYaW9kVlI1UmJiQ0dZNkpN?=
 =?utf-8?B?elNRMVNuNzNkcVRRVkJxakZ2VnZNWFgzRjVKSThRM0JWemNDcDdleHZXTkRN?=
 =?utf-8?B?dW1XeEVTMEdpM0ZiOFE0eGltTy90WGViV2IzaEFNR2tFM0VKOFNYaTljZmYv?=
 =?utf-8?B?YlFtRFhKN01sQyszUC9jRWcvVk5xOXNoMW96QjF4S2h0N3A1dnhLOG1WeW10?=
 =?utf-8?B?c0xrSG1MUnArREpuWlRWdVV2aW5XUkRIbEtiRk5IRmdsSDZCM251SXhmQWly?=
 =?utf-8?B?Ny9MMVVFdllnL3NqaU5xRXU5T2RUUENrMDVIdUM2RDRiWEpmYWMraTVJZ0hV?=
 =?utf-8?B?SzQybDNjdzV3ckQvNElFekp4SC93cVp1SlFYUk4zeU90QUlXUHNDSlBML3BZ?=
 =?utf-8?B?S1NpQjBoalRDeWtGSVl6RzVTN0FiSXQ4d3cvRGFhbkJDb0QyTkROZVp6eG0w?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc28ab3c-db2b-4eaa-b4d7-08dbec131008
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 10:58:02.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVoVLjG+JjZ48vDWLzvsM9IRO1ptMwRzg3v0TUXFV+E0VNHOQeq+XJXLcUfIeNHJgHgpnF+bXNqquwv3KQ9apkVge3jofMPzH1ezIKuMpLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5019
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.11.2023 06:59, Geetha sowjanya wrote:
> On new silicons the TX channels for transmit level has increased.

Will it still work with older silicon?

> This patch fixes the respective register offset range to
> configure the newly added channels.
> 
> Fixes: b279bbb3314e ("octeontx2-af: NIX Tx scheduler queue config support")
> Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>

What Rahul's signed-off stands for?

> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
> index b3150f053291..d46ac29adb96 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
> @@ -31,8 +31,8 @@ static struct hw_reg_map txsch_reg_map[NIX_TXSCH_LVL_CNT] = {
>  	{NIX_TXSCH_LVL_TL4, 3, 0xFFFF, {{0x0B00, 0x0B08}, {0x0B10, 0x0B18},
>  			      {0x1200, 0x12E0} } },
>  	{NIX_TXSCH_LVL_TL3, 4, 0xFFFF, {{0x1000, 0x10E0}, {0x1600, 0x1608},
> -			      {0x1610, 0x1618}, {0x1700, 0x17B0} } },
> -	{NIX_TXSCH_LVL_TL2, 2, 0xFFFF, {{0x0E00, 0x0EE0}, {0x1700, 0x17B0} } },
> +			      {0x1610, 0x1618}, {0x1700, 0x17C8} } },
> +	{NIX_TXSCH_LVL_TL2, 2, 0xFFFF, {{0x0E00, 0x0EE0}, {0x1700, 0x17C8} } },
>  	{NIX_TXSCH_LVL_TL1, 1, 0xFFFF, {{0x0C00, 0x0D98} } },
>  };
>  
