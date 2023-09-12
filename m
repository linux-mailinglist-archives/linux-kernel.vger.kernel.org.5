Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5804479D654
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbjILQa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjILQay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:30:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934ED10EB;
        Tue, 12 Sep 2023 09:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694536250; x=1726072250;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FmJI1tMZFYetGMTPohzVeeWVIg6BR+xN+zXL8TedC08=;
  b=Q/4PRGmKPrV3ofuVPiZzC1bHe6gWFHqBb/wLnECA7x9yX4tCM85477XC
   ZjgeAel1FBorXVE0/Ab4Caj06dZMTFW6ifdrvsyV7R6EJHdBXPKvrNPpI
   NqMjWQVne3W7Rrg1/L5acPKr+WrDAFiQF5Lazz5uSEWsxfaTV5w58cIsT
   jUuLhzyWilW/2uQSK3RzI1vh7k0jnheHUV+Hv2oNzn3YnlU4hd8aB+BwZ
   Op1Mg2fbVU7KqI/HyG5OiqDeNW336noxFfet8QNkFSHh1YEoR5uTKac4v
   5jR1sJc1tDXzRpPNiFDMBqLP1XFCJd3Ui4JDbi2eXJWVbVXV/9wbki21L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464801691"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="464801691"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:22:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="746958824"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="746958824"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 09:22:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 09:22:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 09:22:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 09:22:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXVQNv4eleIbo9W5pCkpa2Kl/45ZCfXpc5x0jP4JYFhF7UVmR3nrKCcsqfhHFwOE33ePHgUL4RWLEXQymfKS/GaqOPUb8ieTL9+HOOacODwSVF34qbteGkepC8GoRAxuy7am76e2GfQIcfJtz6owHE3eo2C07yfC9InSanlx8y4OW1uAXq0Q2ffdoS+GQL6RVh53Bp+kIn/VOLCgupwp3p42RjdkwGVu5AkNgFb+aYrG1EfW7p3kZO3jNSXSt7e+cEIgeMsyfxsfF7JDsCWILtmRL/g2z97ABTbRbid868wV8GNMyKWalVHw2y6AgfJhfrsJS6tfFwCa1PcskaQqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYbkYIEkIBGOpFohQKfHaIypadzP0rqLQsh3Rdaob/w=;
 b=KmK1tueu1+V6MIWe6+YK9jRGdpqnPVJxWMg7hg9El0KTUYg3Sf68oqlomnLnQItWb44lPV9WGNLW4cAsCeNkg2EdhSsnRinKoNSrYRYBhXsBlvj8Dh3bTD0y0bGcGVs5FQ1Js2wsGa2Nf+cnp1ZiXoeY9poqv/TyLSz5jZgoJl/4SOXkBKFmTxM/ysFnmw6EhKk516xcW3gINfoSMbwGBcyIZK+ZsMn9MkVHSaBe299SxIG6lelPD761uNSbUI0CRigv2AbBNz3P1WwJvN/yYDvm+YUambBGgD9VkWTZnJe5HnNfSJAaTNAXGHIw+HETor0PV52SBaR0v71SgunHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB7365.namprd11.prod.outlook.com (2603:10b6:208:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Tue, 12 Sep
 2023 16:22:44 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 16:22:44 +0000
Message-ID: <9a1de9b3-b3cf-d26b-388e-c98294580bca@intel.com>
Date:   Tue, 12 Sep 2023 18:22:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911082016.3694700-1-yajun.deng@linux.dev>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230911082016.3694700-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::15) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: f620beb1-3356-4303-3d5e-08dbb3ac7ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+mYsysOOELn/m36EDA2hN+38409nxJRjRRPT6KHlADnP+8kXAYDCJKCHhIOGO/1Q+saPT/DPI6tNOG58qljLPRoKZcKEY9XMDXD0xUapTBvBogDqkLKBD4oMEBHuqn05XtBwo4g8m95R60EvaO4OiWy6kw+r/6u3yRLAMsJkY4ZNkjbY0nFHilWkDPyU16/kbT+npD5f7DhEEvYII0uqee1CrWzcmUn9vcusCjfvIO4DclnifqiJnR9jVwgKIoC/Oz5AywUhsdp3n726559rHGmmKUueNwT+db4R3/rJkhfdpyllsT0bT18uLtWT6PMpIrL75Gb6bmFYvtXi6x1LfCGPo1iX4aktPxJfYtXMOOy4SPK7iw0dCftJREfPxnkvg9kj6lw9i+HHxCOga2HBwKaKZw8EYoXlBrVzZQKAghmN2DRTcT/+2hNIotTQ2mgEmN5f2frFBeg5c6akxCakOKlv28GLNVdVEl/LfXXJT2ZwEMIkvQrV1/p41ZOB0+sqOEib4qLVyB/dPm9nFEt61rb4Kny5/+cMvMKD/tfVeNflGLTu3CnXCbEwkczG0wI+/HfopHv3tLbYeau2SrH9w1597YDyw+aIwAdFlTy/1MU4/CdLxV+S/qsUo6SxlCeY3W00pdK5ixMQAvKF2CX/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(186009)(1800799009)(451199024)(6506007)(6486002)(6512007)(6666004)(66899024)(38100700002)(31696002)(86362001)(82960400001)(36756003)(2616005)(26005)(31686004)(6916009)(41300700001)(316002)(4326008)(66946007)(66476007)(8936002)(8676002)(5660300002)(478600001)(66556008)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWZyVzBTaE0zRzRMU095b3lsZVRrU084YkJiUUlCa0JQNlNadDZLZW40L3U2?=
 =?utf-8?B?UjV0aXNjc2ZxOWQxbEZIM0FQZmYyZSszNHBMVzM0Q29JUS9TMDdoWCtTb1J0?=
 =?utf-8?B?VnFyVXNWcnprZFgza25rT2xMNitJVkIwa3o5bWVJeFVJaTVjNE1Nb24zam9r?=
 =?utf-8?B?a0I0MXZsTHVNNEVud3dNbjVRZWRWMU54bTBPalIyYTJsa1FCM2RRUFdzSXhM?=
 =?utf-8?B?RmpGZnB5MWtrZTVjRUZSYU83WHdmMi9UV3NCV2pTVWZtUUtDa1BBdjUzY25p?=
 =?utf-8?B?NXpZZGdrYzdkN2xOREFTaFZuOGhlYTE2UDJrQ3BCM2hQVS9FNzhCL1hrSUVS?=
 =?utf-8?B?azhiK1pJT1Njd3NjWG5qVzhxUytFekFYUStzS1B3cnFrRWZ1VmZwWjZ2anRS?=
 =?utf-8?B?MTdEWXZ5NDl0SGcvSm8ydE5sWVQyTGVrUElIcGRNVlFqcWoyM3o1aHRRYnM2?=
 =?utf-8?B?TkhIUUtmcmRBTFRLK0wwU0RpSm5SVFhCMTNVYi9SaFJ6VGdOWGlMbW96eFpl?=
 =?utf-8?B?Z24zeWJhWU13YUtFRDJBVEhtUHIvUUJmVHowR215dVR2cGFKZ2I5Y1B5NjZT?=
 =?utf-8?B?WFp5V1lkSnRndE5rUkNDQkN3K01oOWVIM0JHSGF3RGJYeXhLZ2ZrdTBydzhw?=
 =?utf-8?B?aHBybkhwNGtVR1dhQ2V1NEN0MGNLUUhPTnNJOUFqeGUraDFtd3k2dDVCbzRX?=
 =?utf-8?B?RjIweXZ3aXRDNTdMaGViTjc3UzJMSjF1dzY3OVIvbFRycFZ3V2lUN3o2U2Jy?=
 =?utf-8?B?eXVGcnQvcnZUMUpTbWc0SVh2cTZrVzhxSEtTSEQycm9HUmMwMVVtNTFTUHJs?=
 =?utf-8?B?TnBIcTUzcnFIam8va1IrUk16Q2h1RllrL3Btck1yYVplNldwZXhualFmRzRt?=
 =?utf-8?B?UjFkcEZSNGJ4Q2pDTCtLUlUxeDcwMkIrbnJvSGRDTnd3TGlKY1JCVVFVMTJY?=
 =?utf-8?B?QVZuR0x6bmllNkozWCsrc04zM3JqTDJsRW8wY2NHakxyL0tnaWNiR0FLS0VU?=
 =?utf-8?B?bE5DRG9rRGZCbzZhRmhCVllSZEhxUFNoWExVOUZzb252czZoQktoZ0I5emJ6?=
 =?utf-8?B?NFlreFhQeXFucWRnNndWSTVHTU5xMGZpZzdoZ2FzOVQ5dDZHUE1YZVpqQ0RT?=
 =?utf-8?B?TjBqT3JsUHoyK2VuSE9lTGh2dVRlaXVQeGw3OE5XY05NNTRMY3pVSHJvUUpE?=
 =?utf-8?B?NzJ6Zm4vSFpCcDA0dTdhWVJaTExFblVBdXgrclY1T2t5QUN5NDF3TUVvb0hv?=
 =?utf-8?B?TEE5NloxSWlPemo4R3ZkcDkzYk9yZlg2YjhWRk9tZllBNVB1Q1I5eG5rNnpo?=
 =?utf-8?B?enNhNDVEZnhBckprT2V1cWE3SHprV2Y1cXQ0cWN1NjdRRmN1aW5WT3RSdVZN?=
 =?utf-8?B?TitHQzJYdG1pWHhhUDlZTFcwMW0zcWZVK2RRSlVJMlh6V1dhVU9FWTZOWis4?=
 =?utf-8?B?QmZEdkl0bDdJS3lteG1vSUVsMkFwaWxiaUt2SCs1TFhOa3NodWp3MlB2YWhz?=
 =?utf-8?B?VlNmNFpzWDVrcHkxeVo4YU1wZEx6SXhLT015Yi9DbTJUdFV1eVA1Tm1jcHor?=
 =?utf-8?B?Kzc3L1RXYURkZ09pd1BEOHk3YUk0TDgzam9ZVDdZMUkwdHVxck4yVnVvU0lW?=
 =?utf-8?B?TENCWGkzVGVyeXV5WVpzelJ5aEJDek4rN2lheUEzN3Q2eFlMeDRJV3pVK1V2?=
 =?utf-8?B?OHVRWFJJb2dEZDhOdnlhWjJyN3UzZnNmVkp1RHQ3QmNidHIrWnlzczB0WXRq?=
 =?utf-8?B?Y25kcjBGc2IyaEdVdXRSeHBLbldKTFd3SzZZUkhjU0pJNmhxRExsOWVFVHJZ?=
 =?utf-8?B?V2VTcXBOV2dnc2FCNEZCZXlGU2gxbmltQ2c1Wk5ERFg3Q0xjOE9QOHFoOXps?=
 =?utf-8?B?M0JqTlY0L1RieUtkajFFV0RjVWgzRitvdHAvVnk4ekEvbkgzR0NvWTYvSkZz?=
 =?utf-8?B?bUVkL2Q2RGpZOHprNXptWVdrVk92SUxTWXRLOUY4bkVCT2hXY3VNOU92RUpu?=
 =?utf-8?B?ZVkxem9kUE9kcDEwdFFNdE43UGdvYUFObGpDQlJrcGNuSC9lMm82ZXc3em9M?=
 =?utf-8?B?Q0J2Y0Nhb2tIUTZjVzJuanRlN1RMZHduNXI3SkhqMnZSWUt6cDFoMUJxMXVS?=
 =?utf-8?B?Y1VoVi9hc3NKcTJhbktDWDNZZDl3UDVQdURwWU11VkdGT0dQZ0RYNVZ4NDF3?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f620beb1-3356-4303-3d5e-08dbb3ac7ebb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 16:22:44.7082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlZfC51Uc4kHjX/A4DJrYhr0V9LgPEPjMbdgVeFp9w7N9YhzNqbb2cHnhtNCtbp58+DDa7uGQ/ELVT8j2ioivRde9cYRXPvN8xnlioRqfgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7365
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yajun Deng <yajun.deng@linux.dev>
Date: Mon, 11 Sep 2023 16:20:16 +0800

> Although there is a kfree_skb_reason() helper function that can be used
> to find the reason for dropped packets, but most callers didn't increase
> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.

[...]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index ccff2b6ef958..32ba730405b4 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10475,7 +10475,7 @@ void netdev_stats_to_stats64(struct rtnl_link_stats64 *stats64,
>  }
>  EXPORT_SYMBOL(netdev_stats_to_stats64);
>  
> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
> +static struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
>  {
>  	struct net_device_core_stats __percpu *p;
>  
> @@ -10488,7 +10488,33 @@ struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device
>  	/* This READ_ONCE() pairs with the cmpxchg() above */
>  	return READ_ONCE(dev->core_stats);
>  }
> -EXPORT_SYMBOL(netdev_core_stats_alloc);
> +
> +static inline struct net_device_core_stats __percpu *dev_core_stats(struct net_device *dev)
> +{
> +	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
> +	struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
> +
> +	if (likely(p))
> +		return p;
> +
> +	return netdev_core_stats_alloc(dev);
> +}
> +
> +#define DEV_CORE_STATS_INC(FIELD)				\
> +void dev_core_stats_##FIELD##_inc(struct net_device *dev)	\
> +{								\
> +	struct net_device_core_stats __percpu *p;		\
> +								\
> +	p = dev_core_stats(dev);				\
> +	if (p)							\
> +		this_cpu_inc(p->FIELD);				\
> +}								\
> +EXPORT_SYMBOL(dev_core_stats_##FIELD##_inc)
> +
> +DEV_CORE_STATS_INC(rx_dropped);
> +DEV_CORE_STATS_INC(tx_dropped);
> +DEV_CORE_STATS_INC(rx_nohandler);
> +DEV_CORE_STATS_INC(rx_otherhost_dropped);

I realize you need to have an external function to be able to trace it,
but why don't you make it just 1 function instead of 4+ (will only be
increasing)?

Define 1 function

void dev_core_stats_inc(struct net_device *dev, u32 offset)
{
	struct net_device_core_stats __percpu *p;

	p = dev_core_stats(dev);
	if (p)
		this_cpu_inc(*(unsigned long *)(void *)p + offset);
}
EXPORT_SYMBOL_GPL(dev_core_stats_inc); // Why not GPL BTW?

And then build inlines:

#define DEV_CORE_STATS_INC(FIELD)				\
static inline void						\
dev_core_stats_##FIELD##_inc(struct net_device *dev)		\
{								\
	dev_core_stats_inc(dev,					\
		offsetof(struct net_device_core_stats, FIELD));	\
}

DEV_CORE_STATS_INC(rx_dropped);
...

OR even just make them macros

#define __DEV_CORE_STATS_INC(dev, field)			\
	dev_core_stats_inc(dev,					\
		offsetof(struct net_device_core_stats, field))

#define dev_core_stats_rx_dropped_inc(dev)			\
	__DEV_CORE_STATS_INC(dev, rx_dropped)
...

Just don't copy that awful Thunderbird's line wrap and don't assume this
code builds and works and that is something finished/polished.

You'll be able to trace functions and you'll be able to understand which
counter has been incremented by checking the second argument, i.e. the
field offset (IIRC tracing shows you arguments).
And that way you wouldn't geometrically increase the number of symbol
exports and deal with its consequences.

>  
>  /**
>   *	dev_get_stats	- get network device statistics

Thanks,
Olek
