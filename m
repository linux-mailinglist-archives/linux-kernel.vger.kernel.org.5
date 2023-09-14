Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191EF7A08FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbjINPXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239524AbjINPW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:22:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF67E1FCC;
        Thu, 14 Sep 2023 08:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694704974; x=1726240974;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7rFsLuEBoxf9fUXY8Vxlo9T2wrfd8qGmTly7EMJ0uLw=;
  b=Dc5WSeNXlekYPKrNqonND5HfI+rwzgYrz1kzIM6J+raNZkqHmFJ7zDLU
   Cg+WrIcsg1visbhnN8El+T4JeBT+3O8zhSXoZl0D2OGX8m7zswzWzdYdA
   eg75yjc/uXdxAcMEMI6vtjmg8iuBRilpIinxhZy3BDV/rrmgKwDKFmGkn
   P8CmO8Ddjs/Q9nzmJ5QGOGcRyRCeOK5Xw30ws7wjGlbdC0Hf7rvk22uW+
   3qPAofriP7HVnTG3BzlWxeyz3aoACFFucImAijBY36omr3MFWjQKRKM3j
   8IRP3wHcOeWRHMFsEPwzx7Q3IW3zXh/nVAxPn3/fVOFPrynLQrm2dGEIw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="443032258"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="443032258"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 08:22:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="744581167"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="744581167"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 08:22:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 08:22:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 08:22:53 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 08:22:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/F1+2JPlOAdT7XGwkb1BJuOJ0FtDnvdfvOmvsbj+YBqYpMVnpoILX0MTzh5J9Rbq7HDRnhyvbKQgAZkh0Uj/+ZICaggvNrmu2BzcRC2GT4RSL6nZuPZlqYcG8Cx2S3/sWtPmYZ/eEwya0yxgKnUotouNMaF9k6qYBDdkd1SxdADU6XkNvFMNbYIOsmSNIoMg54w4PTs/wzpGxDsKnVVjIPuvEuQ0dmLgebM3VBE9B5OjtokRRzXeok9ZLLjE03biO1aFCindSOhABAkJg/K0sbdCQpqH7Ku3sO99ay5O/5tm4++3Ry+ZqVbgKh0JszzYz/xUswqyyl84kmJnn/oSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SfaRNFa+Kcuc5aCRARwlDUo66HLC98tgeLDOqJT6g8=;
 b=bfBS945Mb2BCczwdcJJs0pMOKckM6szHItVK1+wy5HtQ3ece4Ytt3AtWrOkOcBHyHXcBuNtiWRhbysOMzD8rL5K1i15Chgga4DOawCEeqjRhsM8m0cZ6BLWS78YnWHCcLJ8h4KF28REARNcwkytQRJ3RiyAAGbUSmcF5tv6Jcwb95SwJRpFgBb/4rpFU9Zsy7cEi//YkPtiS0OJvGb4XMDilHyeVITP3HQNrZ9R4Lre4VKgzQCqpDwGV+Sjgw1jyXN6SZuA3Hpm1MScRr77H6phwPNfx6ZgPhhXAUDY29YUPs9LV7HJnrVZHsLhV+BwGpYkx8qY3pjeF5vFeYEXHaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DS0PR11MB7460.namprd11.prod.outlook.com (2603:10b6:8:142::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Thu, 14 Sep
 2023 15:22:51 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 15:22:51 +0000
Message-ID: <ef9d4ca5-35e4-ff8c-c1aa-f77a4b04d0a2@intel.com>
Date:   Thu, 14 Sep 2023 17:22:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v3] net/core: Export dev_core_stats_*_inc()
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230914023718.3854545-1-yajun.deng@linux.dev>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230914023718.3854545-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::17) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DS0PR11MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6aaff2-5e57-479a-dc7a-08dbb536756a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6KPdQpg5h9W1KfmGHXmUXU/xC0lW91eayxOJAp78mYjZ0WRBX0vYT0sLbicvdznpvnyDGb31xahCj3FkDm0HJfMDLQztkwShwA4yIzeYzu+81ed53eYsyxSucJvYNPVxYo/y2KXhrwDem/uxEyZFCJts1k5Htzel9/ojUzk2+YMz6ZZB2PuWP8T2K2snefXhLYgy+qYxftycWFrl4BckhMjdEMKguFXN77BiJTPL4Htmc+/ds+MLYZ+A5edjK+KoODi2TW7QfOEP0Mx8BWUysVNwTpIvFCMrLWY3ymVcrON2Sl883e2RLyDQiM3NxDsu4X0vGIMEcoIxnLIHrCUm6VdSB88wJ3yz9SKIo/Z/CzNBgCj8heQXcprQdEtlGJ3LYx8D+jAUAO1gKAlDcPtHX48OsVhGYQdNsx3o7wThZAOBRCkeS8qi6tT72SBrIhyufyxaTgBnjZQMQNyxFVZf2H9QW0QNEjAoTJyXsiMhBIF060aF/gBwYw3a3neFY6e7Y/ef2BytISp5XLqXWRUlgoermEVFshskXNtuuMqrfugosicOtlFAZ7nHQAEtdVVzHs3qceBibfbQi5NOO3CzKaXDO6jjLub2N45tQwSAf6V/WN1DFcgm2z5iN0repe/ff1PZmf8zrWwwvIjJ6R1IJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(186009)(1800799009)(451199024)(36756003)(31686004)(41300700001)(8676002)(4326008)(8936002)(66946007)(5660300002)(316002)(31696002)(66476007)(86362001)(6916009)(66556008)(38100700002)(2906002)(6506007)(6666004)(2616005)(478600001)(966005)(82960400001)(6512007)(83380400001)(6486002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3QwUHNqRFZwcGJBQkhsVG5FOFgvVVR5ZWRDMjN0eHY5empuMVF3TWxxMk1X?=
 =?utf-8?B?TWtTNXZRbDBkVVAwTUk3dFRlVHJyTW43SHVVVm5MSUtGaDlxb0lxM2VndU54?=
 =?utf-8?B?akRNY0RaeU9rUGxjUWlpTnVZcEdhL1J4YzhrRWdmU1UyaWUvNlpPL1N5eVpG?=
 =?utf-8?B?SjZaYUxvb3R4VkhiLzA5SlpjN2pJT3d5dVdqTWVnK1pRSEVTRm1sei9DWDhL?=
 =?utf-8?B?ZmE2cWtkRWRuL3M3Q0ptRC84S3Jxck9rbUNkOUNYcVYrZFR1NzkwQnRjRUor?=
 =?utf-8?B?TTZ4cXVZTTVxdFdoNWNsTlVPOU1TcGF1UUdlNUxvdldDWTdTZlU4YkhNZUg4?=
 =?utf-8?B?ZFZrSUhEZHNsZnpzMlk5TjBYdVUvL0N3SDJDYTU0RzJyREVodWhwTGcvRkFr?=
 =?utf-8?B?ZnE3Mk9YRW9SZjBqSU9IZkhnbVJsWjdoc2VuekpaZkVIaEJTQTZxU25EVytE?=
 =?utf-8?B?eVlYNFhEVGpiWHVLcEQvS0Z4UUp0aThrZDVyUnk2UzBGNDh6ZFVTRTNFekor?=
 =?utf-8?B?bkhDb3REU0pncyt1aXVsbE9wcTVabHNMQ1U4UUZXUk8xcVFSc1QrcEZhQTVK?=
 =?utf-8?B?NVFlTmZxaW5IRDBzd2JaNTExWGRmMys3K3NWcWxRWHB5a0E1bHJ2cUxIcHJm?=
 =?utf-8?B?RFZFN0VUa1JEdC9FME96bnJudW0yejdpaE9wb1ZKV0ZtOEd5UkZCTTMrVisv?=
 =?utf-8?B?czIxSzMyZS85dzBiVlVNNlpDVmtqSmJ0L1U4MkZIekJrWE45S3BEQ0hXazVh?=
 =?utf-8?B?Vm1wbWVaVFA0N2Q2MUdGMWkwbU1Oc1IrWW1sK3JHWk5NUVBmZWVZWC9JWnQ3?=
 =?utf-8?B?Q0t2NTJHSjU4bDlnQ1NRZU95ZTBaUUVBV2F6dENwUWYxK1B3VTZKSjVveGlG?=
 =?utf-8?B?UkdES2JYZ0phT05HNzN5REpINXU5ZzR4ZHdRSTdtdndJYmpKYnZZOS9Xalhx?=
 =?utf-8?B?UjQ5LzB3by9walVXM2paVmMyRFZFV2dhdmRzaEllTkora2NxU25pM2ZlZXFk?=
 =?utf-8?B?ZVJ5QVNZVnIzTzJOWkRoSlg0eVhySlNhZm4xVVYyanV0MURiNWNyRlNsQ0p5?=
 =?utf-8?B?Rkp3aXFQM2g4a3lRcERYQVN1QW5RVExzZmw2L2hPK3FCeTVEbC9yWEpXMzFw?=
 =?utf-8?B?NVYyOEYrc3hvck1wYnF4T29jTGc0YmJOUjJZYlp4bDQ0Q3FxckVaNHJGNEdX?=
 =?utf-8?B?eTdNeFNFa1RROS9pSFRTbno4cE1scWUyaExiWDlrZElmbjU4VFJNN0tkak1s?=
 =?utf-8?B?SkUyeW9pVGQ3VThPTUZIVkpWL3VjWnBPUExlUHUwdWFFOFJlT1NVcWJ1WmNX?=
 =?utf-8?B?ZldNQi83K2p6OE8zRGhPTi9UNC9LZGs1M28yZ2lqTElDNng2ajJOd2xPVm83?=
 =?utf-8?B?eW5RYlAzNXdPV010Vy8vQVFzcTNqNzlxc2t6RXBob05QdDFOM1d4WTNubFo2?=
 =?utf-8?B?ZzFwQXdHNmw3TjdQcVhmYTVDVElBamw4OTJHREc5TS9KeVRySkoyTUkrSnlZ?=
 =?utf-8?B?QnUwVGVubll4eXZCNHpqbU5LcjJqS0RZbDNwQVhmL0w2UDNWeWdtRFJCek9G?=
 =?utf-8?B?N0NaL25PVEpWcHpCNkY0S1U0a2Jmb1NHV0hwYlBLeGY2eWRhYXl1b25iWXJ2?=
 =?utf-8?B?U21oV3d4ZFl3M1lsTGQ4T1crRmsvZndsWWZuZFhvRlo4dE1lelpxMDEyOHY5?=
 =?utf-8?B?d2hkNnJBdlRiNVlPODhaUTlJZDEzWHRFRXgycmhUbWJDM2R5SU1qZmN6Wkgw?=
 =?utf-8?B?TDNoMzZXL3Njb05EQlQxZWhSeko2eFlLUllmSEZ5YjB4UmFIZUs5RmMwSzIx?=
 =?utf-8?B?Tlg5MHpDV0JnSHQ1cUhCNG43WVBkUkxNMVVsblJoK0Y1RDJlVXpyeXp5RGlq?=
 =?utf-8?B?dXZNKzFSbmFKV0dnaG9XSVJrNDJJZnRFSzVHY25MdWVsQlJwU0JxK043YTJW?=
 =?utf-8?B?UnRlKzJtMTRKY2M0MzR4cld2Q256eXRCOVZVd0twaDZzeG9VYzQyS25xNFRy?=
 =?utf-8?B?dFlaQjV3bWpzN0hXdXF6TmxvN3JBV0p1cUlPSllzY21rVFl1RFBYdmR0NjJI?=
 =?utf-8?B?RjdYRWk2cWJNYTRJbEhEaHNXc25KNVhZQTdvU2JxRzdYU1VlOU9tN3BXNnd3?=
 =?utf-8?B?ZTB5RFB3Nm9VL0UvYzlmQ1ZJZ0VjSGxFZjdXUEEyMi80Qm5YK3B3ejNnaHpT?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6aaff2-5e57-479a-dc7a-08dbb536756a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 15:22:50.8327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMqBb1Ekktrq+IVnnzQzy1lNxv1BspPEiqZqDHlGK4mOFcQRz/nL8KpWHNm/+uW80k74pUyvJzz68jwsuZ0dXrfqqPvFwyxlDnvwdVr6ZHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7460
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yajun Deng <yajun.deng@linux.dev>
Date: Thu, 14 Sep 2023 10:37:18 +0800

> Although there is a kfree_skb_reason() helper function that can be used to
> find the reason why this skb is dropped, but most callers didn't increase
> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
> 
> For the users, people are more concerned about why the dropped in ip
> is increasing. So we can export dev_core_stats_rx_dropped_inc sets,
> which users would trace them know why rx_dropped is increasing.
> 
> Export dev_core_stats_{rx_dropped, tx_dropped, rx_nohandler,
> rx_otherhost_dropped}_inc for trace. Also, move dev_core_stats()
> and netdev_core_stats_alloc() to dev.c, as they are not called
> externally.

I'd like to hear some arguments against having them static inlines + one
external that I proposed earlier.

> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
> v3: __cold should be added to the netdev_core_stats_alloc().
> v2: use __cold instead of inline in dev_core_stats().
> v1: https://lore.kernel.org/netdev/20230911082016.3694700-1-yajun.deng@linux.dev/

...as it's not at least mentioned here in the changelog.

[...]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index ccff2b6ef958..98592e4c1df0 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10475,7 +10475,7 @@ void netdev_stats_to_stats64(struct rtnl_link_stats64 *stats64,
>  }
>  EXPORT_SYMBOL(netdev_stats_to_stats64);
>  
> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
> +static __cold struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)

This is way over 79/80 chars, break the line before "netdev_".

>  {
>  	struct net_device_core_stats __percpu *p;
>  
> @@ -10488,7 +10488,35 @@ struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device
>  	/* This READ_ONCE() pairs with the cmpxchg() above */
>  	return READ_ONCE(dev->core_stats);
>  }
> -EXPORT_SYMBOL(netdev_core_stats_alloc);
> +
> +static inline struct net_device_core_stats __percpu *dev_core_stats(struct net_device *dev)

Same for the line length.
Also notice that now some of the functions you touch have "dev_" prefix,
others have "netdev_", I'd probably take a look into unifying this.

(note for the maintainers that it would be probably better to leave
 explicit "inline" here, but no bloat-o-meter was provided by the
 author, so I can't say anything for sure)

> +{
> +	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
> +	struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
> +
> +	if (likely(p))
> +		return p;
> +
> +	return netdev_core_stats_alloc(dev);
> +}

[...]

Thanks,
Olek
