Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8529E7E9D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjKMNWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjKMNWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:22:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D7A9D;
        Mon, 13 Nov 2023 05:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699881728; x=1731417728;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xZqlou5J8Sbr73vrHVflmt942T8Oz9x8fj+WLZsOL4E=;
  b=eYifopERA0SS+qkpTpU9XuWK80P5Q/74MjbhHYeAOvJy9C+ClBbYNMvC
   mYi2PUb72O//3r+vFBi84T0MCflnWk9iNRTgLhHcZFcX1cx5Ryu0QDYWZ
   Y7SiPatQyvnba8+vJf3AhYns58WN5z6LCEGjOzWr2KPWFJGil6VMCrgTn
   KVf37P18tYEzl/WOu+4S/ov9Qr63p+S38tKVbtOlBHbsLxndt6Bff/5xb
   gMpE7Le1irpzizbQy/3qfcgzRabq40fduE8KuIX3gOitwwpp0F1k+oZ3W
   STAouL3JwchdkzoU+9lA9cXBQIJCKcLxIWPpnN7M7oJdlHq5j4THbLkio
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="390238853"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="390238853"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 05:22:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="757798965"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="757798965"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 05:22:01 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 05:22:00 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 05:22:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 05:22:00 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 05:21:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1Rq/VdugKDHkzXiREE9sZBY3wbn5YxAGkMIQxRmpvv3ssWlqxz94HEZO8gCH/U/4QqxuKI+mxRpccxTFCVHxfQjtd1GYqo9wp6kaAwZ+x1LiLSnESSmoGpDHTwfPY+3yK0rWgO0z23BUJIQLuONELCEQ9rI3hVLYVKNPCzp9ShsH/PR5lWjqQ2XEw9TYCkmkaAc5ZP/pkGEgJu/XHMfYZY1cwoe8ADZIiUjI+hDP1Yix2RTqtUGWxkne5h8ROxsvJNYRdxSS9MlHsEL38GjOYEKRRvL3xxa7oGjreuEAUwUPt93YYh/xFiUKmE52Ya3Kv+AxG7u0oUfKt5a2uweFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeopZ2MJrGLcr4SxRVSi3WTiD9074gRPHYgdZEBtE/M=;
 b=ceWDyNBN6aXit7wRmBN44w1J/Lfw9DSbMwO/HOEyu3s+Mtzn8ZLytLHTBlh2cZKzCgVpIYV9MLJ8FjSD7RlBS6PK2zVld3MfOIdrZwATy8cCfpUE8imQ1pOq1V6k1rZCPpoLatYyRvuU1zkNRNJo4oxhXflld6cVdGhh0FNfQ3tem3scUZPTxC610iGdwqjlQiuyI32PhhM1xaQ87NvROYX7T8jnkNTnIOzpzp4OtVsqg71gOY/y7/EPDnvPLuH23HjHeS5i4qG32+6ms1Pv7wsxkVURGJECWQOB+/LZ0ZerBmJ2M6nqZct+RQx+e9XFUOLGUfhAxW/8Z3mtNIk4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MW4PR11MB6740.namprd11.prod.outlook.com (2603:10b6:303:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 13:21:22 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 13:21:22 +0000
Message-ID: <1616e146-66b6-4af6-8e23-1c243d79752c@intel.com>
Date:   Mon, 13 Nov 2023 14:21:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 2/5] i40e: Introduce and use macros for iterating
 VSIs and VEBs
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>, <mschmidt@redhat.com>
References: <20231113125856.346047-1-ivecera@redhat.com>
 <20231113125856.346047-3-ivecera@redhat.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231113125856.346047-3-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::13) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MW4PR11MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da7c0d8-c1c0-4949-42e3-08dbe44b6d14
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJ8cC+owc3paD4aCgssXvCv94slQxXUPsGVXp7TqhdXZwllhsfDyshex7H5YS+5kNGJ5IXawseyCmr3pwZe/Lqbzm5leKpbEtGSWclPuxBqypXzTByuSHjAmXIl0RWERUhBMQcuhAGXr08kPLnTG5v71WjYFkDKmTJe5BnVlHF8nXky/3urPzhY9sf6a2PqavP4JwJPxiWcFCSPcedugWthp4tZSgsAv6rkQa+evMaPyePDMD19kOgY/Ue9X87q9IOlyDq2zF0qAoPYSh01uiXgF3A9Mqrp1W+G0cMr+hkLvPGjtBxsPoDRab+YVeIZaibjNrHIbky+mw8Ew8k7Zt+I2x9opNmJwwV2qk6cl2HVsNZ9Xyr9nqw/wIhC4WgDb//NBTDXRACdX01gKO5y2xRMWBKiT9vkYgS6g0lTMLCmt05MKJyrKkh++aVnsGMphVGk0eEAnmV7Y3tEksSQPzsh3T9mPUouTxPh9u04ICXwQr0ODliIblBZYBOFGwURC9PBmw6twTAce364g1mWuo6UqeTSJv8iKxR/ritIJTI2jGGL1RTAW+WrsinEtjDq5RWaw2PHhkBod1psGi0DqbDWDbwRAGVzAGF9w/vH5sPLSUbTBpGRgzUDSefHTTWxhof3ACNa5c2Wo3tNeWMHiOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(396003)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(30864003)(2906002)(5660300002)(7416002)(41300700001)(38100700002)(36756003)(6506007)(82960400001)(6666004)(86362001)(31696002)(2616005)(478600001)(26005)(53546011)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(54906003)(316002)(66476007)(66946007)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDVlMTk5WnVmOVFPQWdGTGMrNEoxVWtjb2xXcFdiS1o5SjRSNm5hamdmTDhy?=
 =?utf-8?B?UHRWQzJ6WC9CQ3RSa2Q0Sm9IOGhmdHBXNzRaTCtwSnZqUlFGWUNSRGdrWDlQ?=
 =?utf-8?B?WE1RMnBGekZaWENsaUxaTVZ4cGRSd1MxUVhPL09KSzhyODIvdTAxd3poQ0Vm?=
 =?utf-8?B?SVFtUlZwWGtTTmk1SWNJQlQzYWpPNlZXUG1RTVZTamR6ZWJndUxNUVA2bWdZ?=
 =?utf-8?B?U3paNmdKQXpPaXQ5VVBrODRJMnQ5aElRZ0hYckl4NkFQclhjeWFSUzRqbzgx?=
 =?utf-8?B?a3JLN3JPNS85dFlSdERlbCsrNHE4dU9jOTFseTFqVTNxUkFMcUtaZnBiaVB2?=
 =?utf-8?B?Y0hnazJqeW9lV3hXUG1TRDcxOTFHbmxEc2FPSS84RUFJNHRFZXd6QVMwVHRu?=
 =?utf-8?B?MUc1dCtsNjR6OHhFZ3o2RzR0UFFTSEtOV1AyODloVlYyVlFiZnUyS1BvTU1R?=
 =?utf-8?B?SW9aeTlVN2FMNDlWeTgwbW9tdU93VVUxNnhvYmt0ZE04ZWVNaVluNEpkajV5?=
 =?utf-8?B?NEhTUGVFUHF5bHRZZ3hMcnhrbWROYXp4blNFbXpja2xQUUhOWGVVY01rbExE?=
 =?utf-8?B?bFdjMmc1ckdreHlyakVsVWZkZThHbkIvY2g0VXNvbUQ1bmgyQVRMK0hvT0lZ?=
 =?utf-8?B?d1RnTXpWbUZNVzJ3d3J1Z3AyUjBRZnpuOU05cGxYYkcrQ1Vna0UxOHg2ZnND?=
 =?utf-8?B?OWtPRUdyZG0xd0tDNVY1QjU1aU8rS2h6eno5Vis2WWhzdVBEK0Y1RXpLK2R1?=
 =?utf-8?B?MzU2c000NmpFNHlhQXAxZWNwcTdySHQwVmMzRTc2VVBYbThkRnlsTzFSZDda?=
 =?utf-8?B?eXZsamdSUjcrL21NRUhXSHVsM0kreU1kaTFQcHpWdVZ1SjE3em0wZDBEdk9Y?=
 =?utf-8?B?anN5S3draVBTTk41WUk5QkoyU1lvZW1nd0doYXgxTVFxSXN2SkEwb2Zicnp4?=
 =?utf-8?B?RThWRGJvZUdiZ0hON2lsd20zUnZYWUNFdFp4TS9SelpmUlhoeEphbTdFTFJC?=
 =?utf-8?B?eEhEWjBSMjAyalVOendBWUJaT1hhU3pYOUtNVE1haEg0SHVuN0I3Vm1DUStt?=
 =?utf-8?B?ZkNwNEI4MzdNUmlNdHk3aDJlUFNKeHJPM3dMd0hCbER3dy9qQUp3MlZSUjI4?=
 =?utf-8?B?ZVRXS2FqSUlZNVIrVUZFTklMTkJWa1NPVzFUUTl2V2ZPRWkycUZoQkpCbGlX?=
 =?utf-8?B?RFE0aGZWeS9Na0dyYklwUXBGZUN0RjlLc2ZMc05ONy9kYWxSczlwTjg3bFRQ?=
 =?utf-8?B?cEJCQ2tVN2ZXUFV6MER4VGIvRU1zZVFDMlo0aU5taGdRSkRHT2pEN2J5Y0xC?=
 =?utf-8?B?QnYrOVBpdmhBOFVyaUkzNjhpdCtKd2V1TUpCb25SWkMvc2NtSEV5dE0zd29U?=
 =?utf-8?B?RWY4SnMzeDJlaFRLZVE2T0hWdlZmcVdxUXJKL0pnV1h6akNDUHd5c0RkSnJQ?=
 =?utf-8?B?b05aTkg2SHhESDZEWXoxZHJ1bXJlUjIxSTg4QTd3cjVkSXRpTEF6a1J6dkJw?=
 =?utf-8?B?ZHZZSC9kSmJSMkJiQVY0WHZYMWh3SlAzb1lOMUh1cG1zLzRHRGx2YnFDeTRX?=
 =?utf-8?B?OGdWYzM5NnNleWt0UTFQOENmMnVQWUxuRElvalNKbmoxS2RIbDR1d0hqQlBL?=
 =?utf-8?B?elRwRVcxaFphQUNEeVcrMlpOcU9xRXRtWlZwclpDZG83M1ptUThtYW9jSGRm?=
 =?utf-8?B?eUQ0R0IvUm15TnIwU1Q0eWg2ellzRnRtRzN4L1l2UU9vNG9GTWZjUEtMbktU?=
 =?utf-8?B?c2JteHl6cjdEbHNQeFR3bm1SNlBLaCtKY1YwcWxZTWkvdWlFeGJiRnFDVUp6?=
 =?utf-8?B?T0pTMW13RXAvVFR2a0hva0FJbTlydE9tYzNNcG9NNEFRNG84V0FIVk1pUVFT?=
 =?utf-8?B?SGg4VVlJSXc0QWc4R3dnR1N1Tll2bWN5UU9GVEJUdWwyTTIwT05NdGYrcmh0?=
 =?utf-8?B?UjhSajQzaVFmRVlqQ01XbzdsTC8rUm9lanBjWWNpUHp0SXFha2IwR3BDbTZp?=
 =?utf-8?B?a2w0R3JCdnFBbmJMcHVIdElBOW1pUDUxSUFKajFDb0tqMHQwODRjWWxobDhM?=
 =?utf-8?B?a09RanlsSjlMcVJjVGxLVXFkNEh3Z0JKUkVza1RDYXZkbTBMRnprNi9Nb0Zy?=
 =?utf-8?B?V2VIc1UrdzVDcUZCaEMvMHo0UkVscEt5ell4KzZkNWRLYkUvYVQvdnRpZnUv?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da7c0d8-c1c0-4949-42e3-08dbe44b6d14
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 13:21:21.5374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bvg6QLVfnFcnWFgImADgy8jr0uBAcv0GP90VF/fQ+vhgG+mJ3u14a019qfSMZocKfIH3BV380plLRvzTR9BhY6XcueHf+XzHk99urVzf9as=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6740
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.11.2023 13:58, Ivan Vecera wrote:
> Introduce i40e_for_each_vsi() and i40e_for_each_veb() helper
> macros and use them to iterate relevant arrays.
> 
> Replace pattern:
> for (i = 0; i < pf->num_alloc_vsi; i++)
> by:
> i40e_for_each_vsi(pf, i, vsi)
> 
> and pattern:
> for (i = 0; i < I40E_MAX_VEB; i++)
> by
> i40e_for_each_veb(pf, i, veb)
> 
> These macros also check if array item pf->vsi[i] or pf->veb[i]
> are not NULL and skip such items so we can remove redundant
> checks from loop bodies.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

Again, nice cleanup.
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/intel/i40e/i40e.h        |  56 ++-
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  10 +-
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |  54 +--
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 389 ++++++++----------
>  4 files changed, 264 insertions(+), 245 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index f1627ab211cd..1e9266de270b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -686,6 +686,54 @@ struct i40e_pf {
>  	struct list_head ddp_old_prof;
>  };
>  
> +/**
> + * __i40e_pf_next_vsi - get next valid VSI
> + * @pf: pointer to the PF struct
> + * @idx: pointer to start position number
> + *
> + * Find and return next non-NULL VSI pointer in pf->vsi array and
> + * updates idx position. Returns NULL if no VSI is found.
> + **/
> +static __always_inline struct i40e_vsi *
> +__i40e_pf_next_vsi(struct i40e_pf *pf, int *idx)
> +{
> +	while (*idx < pf->num_alloc_vsi) {
> +		if (pf->vsi[*idx])
> +			return pf->vsi[(*idx)++];
> +		(*idx)++;
> +	}
> +	return NULL;
> +}
> +
> +#define i40e_pf_for_each_vsi(_pf, _i, _vsi)			\
> +	for (_i = 0, _vsi = __i40e_pf_next_vsi(_pf, &_i);	\
> +	     _vsi;						\
> +	     _vsi = __i40e_pf_next_vsi(_pf, &_i))
> +
> +/**
> + * __i40e_pf_next_veb - get next valid VEB
> + * @pf: pointer to the PF struct
> + * @idx: pointer to start position number
> + *
> + * Find and return next non-NULL VEB pointer in pf->veb array and
> + * updates idx position. Returns NULL if no VEB is found.
> + **/
> +static __always_inline struct i40e_veb *
> +__i40e_pf_next_veb(struct i40e_pf *pf, int *idx)
> +{
> +	while (*idx < I40E_MAX_VEB) {
> +		if (pf->veb[*idx])
> +			return pf->veb[(*idx)++];
> +		(*idx)++;
> +	}
> +	return NULL;
> +}
> +
> +#define i40e_pf_for_each_veb(_pf, _i, _veb)			\
> +	for (_i = 0, _veb = __i40e_pf_next_veb(_pf, &_i);	\
> +	     _veb;						\
> +	     _veb = __i40e_pf_next_veb(_pf, &_i))
> +
>  /**
>   * i40e_mac_to_hkey - Convert a 6-byte MAC Address to a u64 hash key
>   * @macaddr: the MAC Address as the base key
> @@ -1120,14 +1168,12 @@ struct i40e_vsi *i40e_find_vsi_from_id(struct i40e_pf *pf, u16 id);
>  static inline struct i40e_vsi *
>  i40e_find_vsi_by_type(struct i40e_pf *pf, u16 type)
>  {
> +	struct i40e_vsi *vsi;
>  	int i;
>  
> -	for (i = 0; i < pf->num_alloc_vsi; i++) {
> -		struct i40e_vsi *vsi = pf->vsi[i];
> -
> -		if (vsi && vsi->type == type)
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->type == type)
>  			return vsi;
> -	}
>  
>  	return NULL;
>  }
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
> index 4721845fda6e..57020effd2c7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
> @@ -948,16 +948,16 @@ static int i40e_dcbnl_vsi_del_app(struct i40e_vsi *vsi,
>  static void i40e_dcbnl_del_app(struct i40e_pf *pf,
>  			       struct i40e_dcb_app_priority_table *app)
>  {
> +	struct i40e_vsi *vsi;
>  	int v, err;
>  
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (pf->vsi[v] && pf->vsi[v]->netdev) {
> -			err = i40e_dcbnl_vsi_del_app(pf->vsi[v], app);
> +	i40e_pf_for_each_vsi(pf, v, vsi)
> +		if (vsi->netdev) {
> +			err = i40e_dcbnl_vsi_del_app(vsi, app);
>  			dev_dbg(&pf->pdev->dev, "Deleting app for VSI seid=%d err=%d sel=%d proto=0x%x prio=%d\n",
> -				pf->vsi[v]->seid, err, app->selector,
> +				vsi->seid, err, app->selector,
>  				app->protocolid, app->priority);
>  		}
> -	}
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index ef70ddbe9c2f..b236b0f93202 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -24,14 +24,18 @@ enum ring_type {
>   **/
>  static struct i40e_vsi *i40e_dbg_find_vsi(struct i40e_pf *pf, int seid)
>  {
> +	struct i40e_vsi *vsi;
>  	int i;
>  
> -	if (seid < 0)
> +	if (seid < 0) {
>  		dev_info(&pf->pdev->dev, "%d: bad seid\n", seid);
> -	else
> -		for (i = 0; i < pf->num_alloc_vsi; i++)
> -			if (pf->vsi[i] && (pf->vsi[i]->seid == seid))
> -				return pf->vsi[i];
> +
> +		return NULL;
> +	}
> +
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->seid == seid)
> +			return vsi;
>  
>  	return NULL;
>  }
> @@ -43,11 +47,13 @@ static struct i40e_vsi *i40e_dbg_find_vsi(struct i40e_pf *pf, int seid)
>   **/
>  static struct i40e_veb *i40e_dbg_find_veb(struct i40e_pf *pf, int seid)
>  {
> +	struct i40e_veb *veb;
>  	int i;
>  
> -	for (i = 0; i < I40E_MAX_VEB; i++)
> -		if (pf->veb[i] && pf->veb[i]->seid == seid)
> -			return pf->veb[i];
> +	i40e_pf_for_each_veb(pf, i, veb)
> +		if (veb->seid == seid)
> +			return veb;
> +
>  	return NULL;
>  }
>  
> @@ -653,12 +659,11 @@ static void i40e_dbg_dump_desc(int cnt, int vsi_seid, int ring_id, int desc_n,
>   **/
>  static void i40e_dbg_dump_vsi_no_seid(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
>  	int i;
>  
> -	for (i = 0; i < pf->num_alloc_vsi; i++)
> -		if (pf->vsi[i])
> -			dev_info(&pf->pdev->dev, "dump vsi[%d]: %d\n",
> -				 i, pf->vsi[i]->seid);
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		dev_info(&pf->pdev->dev, "dump vsi[%d]: %d\n", i, vsi->seid);
>  }
>  
>  /**
> @@ -718,11 +723,8 @@ static void i40e_dbg_dump_veb_all(struct i40e_pf *pf)
>  	struct i40e_veb *veb;
>  	int i;
>  
> -	for (i = 0; i < I40E_MAX_VEB; i++) {
> -		veb = pf->veb[i];
> -		if (veb)
> -			i40e_dbg_dump_veb_seid(pf, veb->seid);
> -	}
> +	i40e_pf_for_each_veb(pf, i, veb)
> +		i40e_dbg_dump_veb_seid(pf, veb->seid);
>  }
>  
>  /**
> @@ -873,9 +875,10 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  			goto command_write_done;
>  		}
>  
> -		for (i = 0; i < I40E_MAX_VEB; i++)
> -			if (pf->veb[i] && pf->veb[i]->seid == uplink_seid)
> +		i40e_pf_for_each_veb(pf, i, veb)
> +			if (veb->seid == uplink_seid)
>  				break;
> +
>  		if (i >= I40E_MAX_VEB && uplink_seid != 0 &&
>  		    uplink_seid != pf->mac_seid) {
>  			dev_info(&pf->pdev->dev,
> @@ -892,7 +895,9 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  			dev_info(&pf->pdev->dev, "add relay failed\n");
>  
>  	} else if (strncmp(cmd_buf, "del relay", 9) == 0) {
> +		struct i40e_veb *veb;
>  		int i;
> +
>  		cnt = sscanf(&cmd_buf[9], "%i", &veb_seid);
>  		if (cnt != 1) {
>  			dev_info(&pf->pdev->dev,
> @@ -906,9 +911,10 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  		}
>  
>  		/* find the veb */
> -		for (i = 0; i < I40E_MAX_VEB; i++)
> -			if (pf->veb[i] && pf->veb[i]->seid == veb_seid)
> +		i40e_pf_for_each_veb(pf, i, veb)
> +			if (veb->seid == veb_seid)
>  				break;
> +
>  		if (i >= I40E_MAX_VEB) {
>  			dev_info(&pf->pdev->dev,
>  				 "del relay: relay %d not found\n", veb_seid);
> @@ -916,7 +922,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  		}
>  
>  		dev_info(&pf->pdev->dev, "deleting relay %d\n", veb_seid);
> -		i40e_veb_release(pf->veb[i]);
> +		i40e_veb_release(veb);
>  	} else if (strncmp(cmd_buf, "add pvid", 8) == 0) {
>  		unsigned int v;
>  		int ret;
> @@ -1251,8 +1257,8 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  			if (cnt == 0) {
>  				int i;
>  
> -				for (i = 0; i < pf->num_alloc_vsi; i++)
> -					i40e_vsi_reset_stats(pf->vsi[i]);
> +				i40e_pf_for_each_vsi(pf, i, vsi)
> +					i40e_vsi_reset_stats(vsi);
>  				dev_info(&pf->pdev->dev, "vsi clear stats called for all vsi's\n");
>  			} else if (cnt == 1) {
>  				vsi = i40e_dbg_find_vsi(pf, vsi_seid);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 90966878333c..c410fc31a051 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -304,11 +304,12 @@ static int i40e_put_lump(struct i40e_lump_tracking *pile, u16 index, u16 id)
>   **/
>  struct i40e_vsi *i40e_find_vsi_from_id(struct i40e_pf *pf, u16 id)
>  {
> +	struct i40e_vsi *vsi;
>  	int i;
>  
> -	for (i = 0; i < pf->num_alloc_vsi; i++)
> -		if (pf->vsi[i] && (pf->vsi[i]->id == id))
> -			return pf->vsi[i];
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->id == id)
> +			return vsi;
>  
>  	return NULL;
>  }
> @@ -546,24 +547,19 @@ void i40e_vsi_reset_stats(struct i40e_vsi *vsi)
>   **/
>  void i40e_pf_reset_stats(struct i40e_pf *pf)
>  {
> +	struct i40e_veb *veb;
>  	int i;
>  
>  	memset(&pf->stats, 0, sizeof(pf->stats));
>  	memset(&pf->stats_offsets, 0, sizeof(pf->stats_offsets));
>  	pf->stat_offsets_loaded = false;
>  
> -	for (i = 0; i < I40E_MAX_VEB; i++) {
> -		if (pf->veb[i]) {
> -			memset(&pf->veb[i]->stats, 0,
> -			       sizeof(pf->veb[i]->stats));
> -			memset(&pf->veb[i]->stats_offsets, 0,
> -			       sizeof(pf->veb[i]->stats_offsets));
> -			memset(&pf->veb[i]->tc_stats, 0,
> -			       sizeof(pf->veb[i]->tc_stats));
> -			memset(&pf->veb[i]->tc_stats_offsets, 0,
> -			       sizeof(pf->veb[i]->tc_stats_offsets));
> -			pf->veb[i]->stat_offsets_loaded = false;
> -		}
> +	i40e_pf_for_each_veb(pf, i, veb) {
> +		memset(&veb->stats, 0, sizeof(veb->stats));
> +		memset(&veb->stats_offsets, 0, sizeof(veb->stats_offsets));
> +		memset(&veb->tc_stats, 0, sizeof(veb->tc_stats));
> +		memset(&veb->tc_stats_offsets, 0, sizeof(veb->tc_stats_offsets));
> +		veb->stat_offsets_loaded = false;
>  	}
>  	pf->hw_csum_rx_error = 0;
>  }
> @@ -2875,6 +2871,7 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
>   **/
>  static void i40e_sync_filters_subtask(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
>  	int v;
>  
>  	if (!pf)
> @@ -2886,11 +2883,10 @@ static void i40e_sync_filters_subtask(struct i40e_pf *pf)
>  		return;
>  	}
>  
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (pf->vsi[v] &&
> -		    (pf->vsi[v]->flags & I40E_VSI_FLAG_FILTER_CHANGED) &&
> -		    !test_bit(__I40E_VSI_RELEASING, pf->vsi[v]->state)) {
> -			int ret = i40e_sync_vsi_filters(pf->vsi[v]);
> +	i40e_pf_for_each_vsi(pf, v, vsi) {
> +		if ((vsi->flags & I40E_VSI_FLAG_FILTER_CHANGED) &&
> +		    !test_bit(__I40E_VSI_RELEASING, vsi->state)) {
> +			int ret = i40e_sync_vsi_filters(vsi);
>  
>  			if (ret) {
>  				/* come back and try again later */
> @@ -5162,6 +5158,7 @@ static void i40e_reset_interrupt_capability(struct i40e_pf *pf)
>   **/
>  static void i40e_clear_interrupt_scheme(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
>  	int i;
>  
>  	if (test_bit(__I40E_MISC_IRQ_REQUESTED, pf->state))
> @@ -5171,9 +5168,10 @@ static void i40e_clear_interrupt_scheme(struct i40e_pf *pf)
>  		      I40E_IWARP_IRQ_PILE_ID);
>  
>  	i40e_put_lump(pf->irq_pile, 0, I40E_PILE_VALID_BIT-1);
> -	for (i = 0; i < pf->num_alloc_vsi; i++)
> -		if (pf->vsi[i])
> -			i40e_vsi_free_q_vectors(pf->vsi[i]);
> +
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		i40e_vsi_free_q_vectors(vsi);
> +
>  	i40e_reset_interrupt_capability(pf);
>  }
>  
> @@ -5270,12 +5268,11 @@ static void i40e_unquiesce_vsi(struct i40e_vsi *vsi)
>   **/
>  static void i40e_pf_quiesce_all_vsi(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
>  	int v;
>  
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (pf->vsi[v])
> -			i40e_quiesce_vsi(pf->vsi[v]);
> -	}
> +	i40e_pf_for_each_vsi(pf, v, vsi)
> +		i40e_quiesce_vsi(vsi);
>  }
>  
>  /**
> @@ -5284,12 +5281,11 @@ static void i40e_pf_quiesce_all_vsi(struct i40e_pf *pf)
>   **/
>  static void i40e_pf_unquiesce_all_vsi(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
>  	int v;
>  
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (pf->vsi[v])
> -			i40e_unquiesce_vsi(pf->vsi[v]);
> -	}
> +	i40e_pf_for_each_vsi(pf, v, vsi)
> +		i40e_unquiesce_vsi(vsi);
>  }
>  
>  /**
> @@ -5350,14 +5346,13 @@ int i40e_vsi_wait_queues_disabled(struct i40e_vsi *vsi)
>   **/
>  static int i40e_pf_wait_queues_disabled(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
>  	int v, ret = 0;
>  
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (pf->vsi[v]) {
> -			ret = i40e_vsi_wait_queues_disabled(pf->vsi[v]);
> -			if (ret)
> -				break;
> -		}
> +	i40e_pf_for_each_vsi(pf, v, vsi) {
> +		ret = i40e_vsi_wait_queues_disabled(pf->vsi[v]);
> +		if (ret)
> +			break;
>  	}
>  
>  	return ret;
> @@ -6774,32 +6769,29 @@ int i40e_veb_config_tc(struct i40e_veb *veb, u8 enabled_tc)
>   **/
>  static void i40e_dcb_reconfigure(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
> +	struct i40e_veb *veb;
>  	u8 tc_map = 0;
>  	int ret;
> -	u8 v;
> +	int v;
>  
>  	/* Enable the TCs available on PF to all VEBs */
>  	tc_map = i40e_pf_get_tc_map(pf);
>  	if (tc_map == I40E_DEFAULT_TRAFFIC_CLASS)
>  		return;
>  
> -	for (v = 0; v < I40E_MAX_VEB; v++) {
> -		if (!pf->veb[v])
> -			continue;
> -		ret = i40e_veb_config_tc(pf->veb[v], tc_map);
> +	i40e_pf_for_each_veb(pf, v, veb) {
> +		ret = i40e_veb_config_tc(veb, tc_map);
>  		if (ret) {
>  			dev_info(&pf->pdev->dev,
>  				 "Failed configuring TC for VEB seid=%d\n",
> -				 pf->veb[v]->seid);
> +				 veb->seid);
>  			/* Will try to configure as many components */
>  		}
>  	}
>  
>  	/* Update each VSI */
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (!pf->vsi[v])
> -			continue;
> -
> +	i40e_pf_for_each_vsi(pf, v, vsi) {
>  		/* - Enable all TCs for the LAN VSI
>  		 * - For all others keep them at TC0 for now
>  		 */
> @@ -6808,17 +6800,17 @@ static void i40e_dcb_reconfigure(struct i40e_pf *pf)
>  		else
>  			tc_map = I40E_DEFAULT_TRAFFIC_CLASS;
>  
> -		ret = i40e_vsi_config_tc(pf->vsi[v], tc_map);
> +		ret = i40e_vsi_config_tc(vsi, tc_map);
>  		if (ret) {
>  			dev_info(&pf->pdev->dev,
>  				 "Failed configuring TC for VSI seid=%d\n",
> -				 pf->vsi[v]->seid);
> +				 vsi->seid);
>  			/* Will try to configure as many components */
>  		} else {
>  			/* Re-configure VSI vectors based on updated TC map */
> -			i40e_vsi_map_rings_to_vectors(pf->vsi[v]);
> -			if (pf->vsi[v]->netdev)
> -				i40e_dcbnl_set_all(pf->vsi[v]);
> +			i40e_vsi_map_rings_to_vectors(vsi);
> +			if (vsi->netdev)
> +				i40e_dcbnl_set_all(vsi);
>  		}
>  	}
>  }
> @@ -9253,7 +9245,9 @@ int i40e_close(struct net_device *netdev)
>   **/
>  void i40e_do_reset(struct i40e_pf *pf, u32 reset_flags, bool lock_acquired)
>  {
> +	struct i40e_vsi *vsi;
>  	u32 val;
> +	int i;
>  
>  	/* do the biggest reset indicated */
>  	if (reset_flags & BIT_ULL(__I40E_GLOBAL_RESET_REQUESTED)) {
> @@ -9309,29 +9303,20 @@ void i40e_do_reset(struct i40e_pf *pf, u32 reset_flags, bool lock_acquired)
>  			 "FW LLDP is enabled\n");
>  
>  	} else if (reset_flags & BIT_ULL(__I40E_REINIT_REQUESTED)) {
> -		int v;
> -
>  		/* Find the VSI(s) that requested a re-init */
> -		dev_info(&pf->pdev->dev,
> -			 "VSI reinit requested\n");
> -		for (v = 0; v < pf->num_alloc_vsi; v++) {
> -			struct i40e_vsi *vsi = pf->vsi[v];
> +		dev_info(&pf->pdev->dev, "VSI reinit requested\n");
>  
> -			if (vsi != NULL &&
> -			    test_and_clear_bit(__I40E_VSI_REINIT_REQUESTED,
> +		i40e_pf_for_each_vsi(pf, i, vsi) {
> +			if (test_and_clear_bit(__I40E_VSI_REINIT_REQUESTED,
>  					       vsi->state))
> -				i40e_vsi_reinit_locked(pf->vsi[v]);
> +				i40e_vsi_reinit_locked(vsi);
>  		}
>  	} else if (reset_flags & BIT_ULL(__I40E_DOWN_REQUESTED)) {
> -		int v;
> -
>  		/* Find the VSI(s) that needs to be brought down */
>  		dev_info(&pf->pdev->dev, "VSI down requested\n");
> -		for (v = 0; v < pf->num_alloc_vsi; v++) {
> -			struct i40e_vsi *vsi = pf->vsi[v];
>  
> -			if (vsi != NULL &&
> -			    test_and_clear_bit(__I40E_VSI_DOWN_REQUESTED,
> +		i40e_pf_for_each_vsi(pf, i, vsi) {
> +			if (test_and_clear_bit(__I40E_VSI_DOWN_REQUESTED,
>  					       vsi->state)) {
>  				set_bit(__I40E_VSI_DOWN, vsi->state);
>  				i40e_down(vsi);
> @@ -9886,6 +9871,8 @@ static void i40e_vsi_link_event(struct i40e_vsi *vsi, bool link_up)
>   **/
>  static void i40e_veb_link_event(struct i40e_veb *veb, bool link_up)
>  {
> +	struct i40e_veb *veb_it;
> +	struct i40e_vsi *vsi;
>  	struct i40e_pf *pf;
>  	int i;
>  
> @@ -9894,14 +9881,14 @@ static void i40e_veb_link_event(struct i40e_veb *veb, bool link_up)
>  	pf = veb->pf;
>  
>  	/* depth first... */
> -	for (i = 0; i < I40E_MAX_VEB; i++)
> -		if (pf->veb[i] && (pf->veb[i]->uplink_seid == veb->seid))
> -			i40e_veb_link_event(pf->veb[i], link_up);
> +	i40e_pf_for_each_veb(pf, i, veb_it)
> +		if (veb_it->uplink_seid == veb->seid)
> +			i40e_veb_link_event(veb_it, link_up);
>  
>  	/* ... now the local VSIs */
> -	for (i = 0; i < pf->num_alloc_vsi; i++)
> -		if (pf->vsi[i] && (pf->vsi[i]->uplink_seid == veb->seid))
> -			i40e_vsi_link_event(pf->vsi[i], link_up);
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->uplink_seid == veb->seid)
> +			i40e_vsi_link_event(vsi, link_up);
>  }
>  
>  /**
> @@ -9995,6 +9982,8 @@ static void i40e_link_event(struct i40e_pf *pf)
>   **/
>  static void i40e_watchdog_subtask(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
> +	struct i40e_veb *veb;
>  	int i;
>  
>  	/* if interface is down do nothing */
> @@ -10016,15 +10005,14 @@ static void i40e_watchdog_subtask(struct i40e_pf *pf)
>  	/* Update the stats for active netdevs so the network stack
>  	 * can look at updated numbers whenever it cares to
>  	 */
> -	for (i = 0; i < pf->num_alloc_vsi; i++)
> -		if (pf->vsi[i] && pf->vsi[i]->netdev)
> -			i40e_update_stats(pf->vsi[i]);
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->netdev)
> +			i40e_update_stats(vsi);
>  
>  	if (test_bit(I40E_FLAG_VEB_STATS_ENA, pf->flags)) {
>  		/* Update the stats for the active switching components */
> -		for (i = 0; i < I40E_MAX_VEB; i++)
> -			if (pf->veb[i])
> -				i40e_update_veb_stats(pf->veb[i]);
> +		i40e_pf_for_each_veb(pf, i, veb)
> +			i40e_update_veb_stats(veb);
>  	}
>  
>  	i40e_ptp_rx_hang(pf);
> @@ -10387,18 +10375,18 @@ static int i40e_reconstitute_veb(struct i40e_veb *veb)
>  {
>  	struct i40e_vsi *ctl_vsi = NULL;
>  	struct i40e_pf *pf = veb->pf;
> -	int v, veb_idx;
> -	int ret;
> +	struct i40e_veb *veb_it;
> +	struct i40e_vsi *vsi;
> +	int v, ret;
>  
>  	/* build VSI that owns this VEB, temporarily attached to base VEB */
> -	for (v = 0; v < pf->num_alloc_vsi && !ctl_vsi; v++) {
> -		if (pf->vsi[v] &&
> -		    pf->vsi[v]->veb_idx == veb->idx &&
> -		    pf->vsi[v]->flags & I40E_VSI_FLAG_VEB_OWNER) {
> -			ctl_vsi = pf->vsi[v];
> +	i40e_pf_for_each_vsi(pf, v, vsi)
> +		if (vsi->veb_idx == veb->idx &&
> +		    vsi->flags & I40E_VSI_FLAG_VEB_OWNER) {
> +			ctl_vsi = vsi;
>  			break;
>  		}
> -	}
> +
>  	if (!ctl_vsi) {
>  		dev_info(&pf->pdev->dev,
>  			 "missing owner VSI for veb_idx %d\n", veb->idx);
> @@ -10428,13 +10416,11 @@ static int i40e_reconstitute_veb(struct i40e_veb *veb)
>  	i40e_config_bridge_mode(veb);
>  
>  	/* create the remaining VSIs attached to this VEB */
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (!pf->vsi[v] || pf->vsi[v] == ctl_vsi)
> +	i40e_pf_for_each_vsi(pf, v, vsi) {
> +		if (vsi == ctl_vsi)
>  			continue;
>  
> -		if (pf->vsi[v]->veb_idx == veb->idx) {
> -			struct i40e_vsi *vsi = pf->vsi[v];
> -
> +		if (vsi->veb_idx == veb->idx) {
>  			vsi->uplink_seid = veb->seid;
>  			ret = i40e_add_vsi(vsi);
>  			if (ret) {
> @@ -10448,10 +10434,10 @@ static int i40e_reconstitute_veb(struct i40e_veb *veb)
>  	}
>  
>  	/* create any VEBs attached to this VEB - RECURSION */
> -	for (veb_idx = 0; veb_idx < I40E_MAX_VEB; veb_idx++) {
> -		if (pf->veb[veb_idx] && pf->veb[veb_idx]->veb_idx == veb->idx) {
> -			pf->veb[veb_idx]->uplink_seid = veb->seid;
> -			ret = i40e_reconstitute_veb(pf->veb[veb_idx]);
> +	i40e_pf_for_each_veb(pf, v, veb_it) {
> +		if (veb_it->veb_idx == veb->idx) {
> +			veb_it->uplink_seid = veb->seid;
> +			ret = i40e_reconstitute_veb(veb_it);
>  			if (ret)
>  				break;
>  		}
> @@ -10725,6 +10711,7 @@ static void i40e_clean_xps_state(struct i40e_vsi *vsi)
>  static void i40e_prep_for_reset(struct i40e_pf *pf)
>  {
>  	struct i40e_hw *hw = &pf->hw;
> +	struct i40e_vsi *vsi;
>  	int ret = 0;
>  	u32 v;
>  
> @@ -10738,11 +10725,9 @@ static void i40e_prep_for_reset(struct i40e_pf *pf)
>  	/* quiesce the VSIs and their queues that are not already DOWN */
>  	i40e_pf_quiesce_all_vsi(pf);
>  
> -	for (v = 0; v < pf->num_alloc_vsi; v++) {
> -		if (pf->vsi[v]) {
> -			i40e_clean_xps_state(pf->vsi[v]);
> -			pf->vsi[v]->seid = 0;
> -		}
> +	i40e_pf_for_each_vsi(pf, v, vsi) {
> +		i40e_clean_xps_state(vsi);
> +		vsi->seid = 0;
>  	}
>  
>  	i40e_shutdown_adminq(&pf->hw);
> @@ -10856,6 +10841,7 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
>  	const bool is_recovery_mode_reported = i40e_check_recovery_mode(pf);
>  	struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
>  	struct i40e_hw *hw = &pf->hw;
> +	struct i40e_veb *veb;
>  	int ret = EBADE;
>  	u32 val;
>  	int v;
> @@ -10998,14 +10984,10 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
>  	if (vsi->uplink_seid != pf->mac_seid) {
>  		dev_dbg(&pf->pdev->dev, "attempting to rebuild switch\n");
>  		/* find the one VEB connected to the MAC, and find orphans */
> -		for (v = 0; v < I40E_MAX_VEB; v++) {
> -			if (!pf->veb[v])
> -				continue;
> -
> -			if (pf->veb[v]->uplink_seid == pf->mac_seid ||
> -			    pf->veb[v]->uplink_seid == 0) {
> -				ret = i40e_reconstitute_veb(pf->veb[v]);
> -
> +		i40e_pf_for_each_veb(pf, v, veb) {
> +			if (veb->uplink_seid == pf->mac_seid ||
> +			    veb->uplink_seid == 0) {
> +				ret = i40e_reconstitute_veb(veb);
>  				if (!ret)
>  					continue;
>  
> @@ -11015,13 +10997,13 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
>  				 * If orphan failed, we'll report the error
>  				 * but try to keep going.
>  				 */
> -				if (pf->veb[v]->uplink_seid == pf->mac_seid) {
> +				if (veb->uplink_seid == pf->mac_seid) {
>  					dev_info(&pf->pdev->dev,
>  						 "rebuild of switch failed: %d, will try to set up simple PF connection\n",
>  						 ret);
>  					vsi->uplink_seid = pf->mac_seid;
>  					break;
> -				} else if (pf->veb[v]->uplink_seid == 0) {
> +				} else if (veb->uplink_seid == 0) {
>  					dev_info(&pf->pdev->dev,
>  						 "rebuild of orphan VEB failed: %d\n",
>  						 ret);
> @@ -12112,6 +12094,7 @@ static int i40e_init_interrupt_scheme(struct i40e_pf *pf)
>   */
>  static int i40e_restore_interrupt_scheme(struct i40e_pf *pf)
>  {
> +	struct i40e_vsi *vsi;
>  	int err, i;
>  
>  	/* We cleared the MSI and MSI-X flags when disabling the old interrupt
> @@ -12128,13 +12111,12 @@ static int i40e_restore_interrupt_scheme(struct i40e_pf *pf)
>  	/* Now that we've re-acquired IRQs, we need to remap the vectors and
>  	 * rings together again.
>  	 */
> -	for (i = 0; i < pf->num_alloc_vsi; i++) {
> -		if (pf->vsi[i]) {
> -			err = i40e_vsi_alloc_q_vectors(pf->vsi[i]);
> -			if (err)
> -				goto err_unwind;
> -			i40e_vsi_map_rings_to_vectors(pf->vsi[i]);
> -		}
> +	i40e_pf_for_each_vsi(pf, i, vsi) {
> +		err = i40e_vsi_alloc_q_vectors(vsi);
> +		if (err)
> +			goto err_unwind;
> +
> +		i40e_vsi_map_rings_to_vectors(vsi);
>  	}
>  
>  	err = i40e_setup_misc_vector(pf);
> @@ -13136,8 +13118,8 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
>  	struct i40e_netdev_priv *np = netdev_priv(dev);
>  	struct i40e_vsi *vsi = np->vsi;
>  	struct i40e_pf *pf = vsi->back;
> -	struct i40e_veb *veb = NULL;
>  	struct nlattr *attr, *br_spec;
> +	struct i40e_veb *veb;
>  	int i, rem;
>  
>  	/* Only for PF VSI for now */
> @@ -13145,10 +13127,11 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
>  		return -EOPNOTSUPP;
>  
>  	/* Find the HW bridge for PF VSI */
> -	for (i = 0; i < I40E_MAX_VEB && !veb; i++) {
> -		if (pf->veb[i] && pf->veb[i]->seid == vsi->uplink_seid)
> -			veb = pf->veb[i];
> -	}
> +	i40e_pf_for_each_veb(pf, i, veb)
> +		if (veb->seid == vsi->uplink_seid)
> +			break;
> +	if (i == I40E_MAX_VEB)
> +		veb = NULL; /* No VEB found */
>  
>  	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
>  	if (!br_spec)
> @@ -13221,12 +13204,10 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>  		return -EOPNOTSUPP;
>  
>  	/* Find the HW bridge for the PF VSI */
> -	for (i = 0; i < I40E_MAX_VEB && !veb; i++) {
> -		if (pf->veb[i] && pf->veb[i]->seid == vsi->uplink_seid)
> -			veb = pf->veb[i];
> -	}
> -
> -	if (!veb)
> +	i40e_pf_for_each_veb(pf, i, veb)
> +		if (veb->seid == vsi->uplink_seid)
> +			break;
> +	if (i == I40E_MAX_VEB)
>  		return 0;
>  
>  	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, veb->bridge_mode,
> @@ -14157,9 +14138,9 @@ static int i40e_add_vsi(struct i40e_vsi *vsi)
>   **/
>  int i40e_vsi_release(struct i40e_vsi *vsi)
>  {
> +	struct i40e_veb *veb, *veb_it;
>  	struct i40e_mac_filter *f;
>  	struct hlist_node *h;
> -	struct i40e_veb *veb = NULL;
>  	struct i40e_pf *pf;
>  	u16 uplink_seid;
>  	int i, n, bkt;
> @@ -14229,20 +14210,18 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
>  	 * the orphan VEBs yet.  We'll wait for an explicit remove request
>  	 * from up the network stack.
>  	 */
> -	for (n = 0, i = 0; i < pf->num_alloc_vsi; i++) {
> -		if (pf->vsi[i] &&
> -		    pf->vsi[i]->uplink_seid == uplink_seid &&
> -		    (pf->vsi[i]->flags & I40E_VSI_FLAG_VEB_OWNER) == 0) {
> +	n = 0;
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->uplink_seid == uplink_seid &&
> +		    (vsi->flags & I40E_VSI_FLAG_VEB_OWNER) == 0)
>  			n++;      /* count the VSIs */
> -		}
> -	}
> -	for (i = 0; i < I40E_MAX_VEB; i++) {
> -		if (!pf->veb[i])
> -			continue;
> -		if (pf->veb[i]->uplink_seid == uplink_seid)
> +
> +	veb = NULL;
> +	i40e_pf_for_each_veb(pf, i, veb_it) {
> +		if (veb_it->uplink_seid == uplink_seid)
>  			n++;     /* count the VEBs */
> -		if (pf->veb[i]->seid == uplink_seid)
> -			veb = pf->veb[i];
> +		if (veb_it->seid == uplink_seid)
> +			veb = veb_it;
>  	}
>  	if (n == 0 && veb && veb->uplink_seid != 0)
>  		i40e_veb_release(veb);
> @@ -14419,22 +14398,18 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>  	 *
>  	 * Find which uplink_seid we were given and create a new VEB if needed
>  	 */
> -	for (i = 0; i < I40E_MAX_VEB; i++) {
> -		if (pf->veb[i] && pf->veb[i]->seid == uplink_seid) {
> -			veb = pf->veb[i];
> +	i40e_pf_for_each_veb(pf, i, veb)
> +		if (veb->seid == uplink_seid)
>  			break;
> -		}
> -	}
> +	if (i == I40E_MAX_VEB)
> +		veb = NULL;
>  
>  	if (!veb && uplink_seid != pf->mac_seid) {
> -
> -		for (i = 0; i < pf->num_alloc_vsi; i++) {
> -			if (pf->vsi[i] && pf->vsi[i]->seid == uplink_seid) {
> -				vsi = pf->vsi[i];
> +		i40e_pf_for_each_vsi(pf, i, vsi)
> +			if (vsi->seid == uplink_seid)
>  				break;
> -			}
> -		}
> -		if (!vsi) {
> +
> +		if (i == pf->num_alloc_vsi) {
>  			dev_info(&pf->pdev->dev, "no such uplink_seid %d\n",
>  				 uplink_seid);
>  			return NULL;
> @@ -14462,11 +14437,10 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>  			}
>  			i40e_config_bridge_mode(veb);
>  		}
> -		for (i = 0; i < I40E_MAX_VEB && !veb; i++) {
> -			if (pf->veb[i] && pf->veb[i]->seid == vsi->uplink_seid)
> -				veb = pf->veb[i];
> -		}
> -		if (!veb) {
> +		i40e_pf_for_each_veb(pf, i, veb)
> +			if (veb->seid == vsi->uplink_seid)
> +				break;
> +		if (i == I40E_MAX_VEB) {
>  			dev_info(&pf->pdev->dev, "couldn't add VEB\n");
>  			return NULL;
>  		}
> @@ -14695,29 +14669,24 @@ static void i40e_switch_branch_release(struct i40e_veb *branch)
>  	struct i40e_pf *pf = branch->pf;
>  	u16 branch_seid = branch->seid;
>  	u16 veb_idx = branch->idx;
> +	struct i40e_vsi *vsi;
> +	struct i40e_veb *veb;
>  	int i;
>  
>  	/* release any VEBs on this VEB - RECURSION */
> -	for (i = 0; i < I40E_MAX_VEB; i++) {
> -		if (!pf->veb[i])
> -			continue;
> -		if (pf->veb[i]->uplink_seid == branch->seid)
> -			i40e_switch_branch_release(pf->veb[i]);
> -	}
> +	i40e_pf_for_each_veb(pf, i, veb)
> +		if (veb->uplink_seid == branch->seid)
> +			i40e_switch_branch_release(veb);
>  
>  	/* Release the VSIs on this VEB, but not the owner VSI.
>  	 *
>  	 * NOTE: Removing the last VSI on a VEB has the SIDE EFFECT of removing
>  	 *       the VEB itself, so don't use (*branch) after this loop.
>  	 */
> -	for (i = 0; i < pf->num_alloc_vsi; i++) {
> -		if (!pf->vsi[i])
> -			continue;
> -		if (pf->vsi[i]->uplink_seid == branch_seid &&
> -		   (pf->vsi[i]->flags & I40E_VSI_FLAG_VEB_OWNER) == 0) {
> -			i40e_vsi_release(pf->vsi[i]);
> -		}
> -	}
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->uplink_seid == branch_seid &&
> +		    (vsi->flags & I40E_VSI_FLAG_VEB_OWNER) == 0)
> +			i40e_vsi_release(vsi);
>  
>  	/* There's one corner case where the VEB might not have been
>  	 * removed, so double check it here and remove it if needed.
> @@ -14755,19 +14724,19 @@ static void i40e_veb_clear(struct i40e_veb *veb)
>   **/
>  void i40e_veb_release(struct i40e_veb *veb)
>  {
> -	struct i40e_vsi *vsi = NULL;
> +	struct i40e_vsi *vsi, *vsi_it;
>  	struct i40e_pf *pf;
>  	int i, n = 0;
>  
>  	pf = veb->pf;
>  
>  	/* find the remaining VSI and check for extras */
> -	for (i = 0; i < pf->num_alloc_vsi; i++) {
> -		if (pf->vsi[i] && pf->vsi[i]->uplink_seid == veb->seid) {
> +	i40e_pf_for_each_vsi(pf, i, vsi_it)
> +		if (vsi_it->uplink_seid == veb->seid) {
> +			vsi = vsi_it;
>  			n++;
> -			vsi = pf->vsi[i];
>  		}
> -	}
> +
>  	if (n != 1) {
>  		dev_info(&pf->pdev->dev,
>  			 "can't remove VEB %d with %d VSIs left\n",
> @@ -14865,6 +14834,7 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  				u8 enabled_tc)
>  {
>  	struct i40e_veb *veb, *uplink_veb = NULL;
> +	struct i40e_vsi *vsi;
>  	int vsi_idx, veb_idx;
>  	int ret;
>  
> @@ -14878,9 +14848,10 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  	}
>  
>  	/* make sure there is such a vsi and uplink */
> -	for (vsi_idx = 0; vsi_idx < pf->num_alloc_vsi; vsi_idx++)
> -		if (pf->vsi[vsi_idx] && pf->vsi[vsi_idx]->seid == vsi_seid)
> +	i40e_pf_for_each_vsi(pf, vsi_idx, vsi)
> +		if (vsi->seid == vsi_seid)
>  			break;
> +
>  	if (vsi_idx == pf->num_alloc_vsi && vsi_seid != 0) {
>  		dev_info(&pf->pdev->dev, "vsi seid %d not found\n",
>  			 vsi_seid);
> @@ -14888,10 +14859,9 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  	}
>  
>  	if (uplink_seid && uplink_seid != pf->mac_seid) {
> -		for (veb_idx = 0; veb_idx < I40E_MAX_VEB; veb_idx++) {
> -			if (pf->veb[veb_idx] &&
> -			    pf->veb[veb_idx]->seid == uplink_seid) {
> -				uplink_veb = pf->veb[veb_idx];
> +		i40e_pf_for_each_veb(pf, veb_idx, veb) {
> +			if (veb->seid == uplink_seid) {
> +				uplink_veb = veb;
>  				break;
>  			}
>  		}
> @@ -14913,7 +14883,7 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  	veb->enabled_tc = (enabled_tc ? enabled_tc : 0x1);
>  
>  	/* create the VEB in the switch */
> -	ret = i40e_add_veb(veb, pf->vsi[vsi_idx]);
> +	ret = i40e_add_veb(veb, vsi);
>  	if (ret)
>  		goto err_veb;
>  	if (vsi_idx == pf->lan_vsi)
> @@ -14944,6 +14914,7 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
>  	u16 uplink_seid = le16_to_cpu(ele->uplink_seid);
>  	u8 element_type = ele->element_type;
>  	u16 seid = le16_to_cpu(ele->seid);
> +	struct i40e_veb *veb;
>  
>  	if (printconfig)
>  		dev_info(&pf->pdev->dev,
> @@ -14962,12 +14933,12 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
>  			int v;
>  
>  			/* find existing or else empty VEB */
> -			for (v = 0; v < I40E_MAX_VEB; v++) {
> -				if (pf->veb[v] && (pf->veb[v]->seid == seid)) {
> +			i40e_pf_for_each_veb(pf, v, veb)
> +				if (veb->seid == seid) {
>  					pf->lan_veb = v;
>  					break;
>  				}
> -			}
> +
>  			if (pf->lan_veb >= I40E_MAX_VEB) {
>  				v = i40e_veb_mem_alloc(pf);
>  				if (v < 0)
> @@ -16253,6 +16224,8 @@ static void i40e_remove(struct pci_dev *pdev)
>  {
>  	struct i40e_pf *pf = pci_get_drvdata(pdev);
>  	struct i40e_hw *hw = &pf->hw;
> +	struct i40e_vsi *vsi;
> +	struct i40e_veb *veb;
>  	int ret_code;
>  	int i;
>  
> @@ -16310,24 +16283,19 @@ static void i40e_remove(struct pci_dev *pdev)
>  	/* If there is a switch structure or any orphans, remove them.
>  	 * This will leave only the PF's VSI remaining.
>  	 */
> -	for (i = 0; i < I40E_MAX_VEB; i++) {
> -		if (!pf->veb[i])
> -			continue;
> -
> -		if (pf->veb[i]->uplink_seid == pf->mac_seid ||
> -		    pf->veb[i]->uplink_seid == 0)
> -			i40e_switch_branch_release(pf->veb[i]);
> -	}
> +	i40e_pf_for_each_veb(pf, i, veb)
> +		if (veb->uplink_seid == pf->mac_seid ||
> +		    veb->uplink_seid == 0)
> +			i40e_switch_branch_release(veb);
>  
>  	/* Now we can shutdown the PF's VSIs, just before we kill
>  	 * adminq and hmc.
>  	 */
> -	for (i = pf->num_alloc_vsi; i--;)
> -		if (pf->vsi[i]) {
> -			i40e_vsi_close(pf->vsi[i]);
> -			i40e_vsi_release(pf->vsi[i]);
> -			pf->vsi[i] = NULL;
> -		}
> +	i40e_pf_for_each_vsi(pf, i, vsi) {
> +		i40e_vsi_close(vsi);
> +		i40e_vsi_release(vsi);
> +		pf->vsi[i] = NULL;
> +	}
>  
>  	i40e_cloud_filter_exit(pf);
>  
> @@ -16364,18 +16332,17 @@ static void i40e_remove(struct pci_dev *pdev)
>  	/* Clear all dynamic memory lists of rings, q_vectors, and VSIs */
>  	rtnl_lock();
>  	i40e_clear_interrupt_scheme(pf);
> -	for (i = 0; i < pf->num_alloc_vsi; i++) {
> -		if (pf->vsi[i]) {
> -			if (!test_bit(__I40E_RECOVERY_MODE, pf->state))
> -				i40e_vsi_clear_rings(pf->vsi[i]);
> -			i40e_vsi_clear(pf->vsi[i]);
> -			pf->vsi[i] = NULL;
> -		}
> +	i40e_pf_for_each_vsi(pf, i, vsi) {
> +		if (!test_bit(__I40E_RECOVERY_MODE, pf->state))
> +			i40e_vsi_clear_rings(vsi);
> +
> +		i40e_vsi_clear(vsi);
> +		pf->vsi[i] = NULL;
>  	}
>  	rtnl_unlock();
>  
> -	for (i = 0; i < I40E_MAX_VEB; i++) {
> -		kfree(pf->veb[i]);
> +	i40e_pf_for_each_veb(pf, i, veb) {
> +		kfree(veb);
>  		pf->veb[i] = NULL;
>  	}
>  
