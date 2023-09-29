Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7B47B3AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjI2TyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2TyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:54:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB23AB4;
        Fri, 29 Sep 2023 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696017244; x=1727553244;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=rjSZvs3ngr2m6TUhA7ZrOSv4ikMKjIah3fHrtcMR7s4=;
  b=VnCwO8C5cYghLlPIUBSe+Ppji6sCPw2ITdCtBBxFB45knaldHpEhtLVs
   UCGgYxcRJcTyGFI/bm2OfSLE5/3CEk6Fau/+or8+RpcXAnB/0nOlescO4
   t9ECKtmkeuM0/wpwiRdtBxx7m8dr2QDaJUY9kJQYE+Xy+lNHiIEV0tt9O
   abIyEiFei8ooFTERedkAodxKzmAXOX2zvBTmWmD68xJxRBp8WIUazGQfw
   7tneYWQJNmRlm2Y+wcRPZCi/ZcgPog9O3+uRUHWY9q6imV8W36sRsto30
   Y3bdoEe+3RSl7CiFj3ZIMpcSiHdg5EDKyvGMLRO+jBzEJr/96QbO58nIp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="372704623"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="372704623"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 10:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="1081007963"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="1081007963"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 10:54:17 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 10:54:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 10:54:16 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 10:54:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+nijyh3ntUKTU1j+LRqr2JqLzbjQkgbFyA5JVZo6BIWpkFUfHeVe9e6ks+EE3VgTowqjATgFaMRtsvV4bd1vuJhEMMM71JgUGwbpaDw6hPcu6kgNChMNepKl18x9lK6UzPkheDY8PrNVgPRIW/X26m5ziXhI2LzkOVS0qTGKsl+F75bepMwIbvGZBfitoV3g0pcZlOmxCzWanjYZhEb8OKzDA6UEtV1AWlPjYYjsDe+SBMQFDhKfpe/1msxCYJmIkwBTMmBdB5S+1U6GN0yjaiI9fNWHHGDSUVQfYOw4kpkTToIfZ9M6tR8rYFI+MezgutaEhxcH/TbXia3/IX/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqK2ZNb5bFtswy0NU/OB1JOXQzmhqGiCTfSFoUkK72c=;
 b=XX45jN9rJBzSvYSUxgUQMONHk5j0sTEwMNAhupNs29Kn5pftZkDLQNzgJD9mQ2nwrfU88XH7g5TSgXsKl2Dh/VlPyj7Y66S8b+PPI3LGHtkcX53vscSwSCbozG/Cw0EM6gFbUKZucmVyHKVOG5Ixfzg404LNNRxUZP0kX31QsVUK6aNgG2KpsHHYAbvOXgXikziZj+8K7m7NGswSkQl/qsSY56el8FRHgba7akbErCCeh/NtL14Aqs26/F4jK2bxZs0ZS8OknVNfhfP4PxOGjuDcALgDxB8M92YTvspplXUnlkQptCzlcV2/eGQvs/lOfmnu4BvbIwpZ9PeBJJ+/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB4984.namprd11.prod.outlook.com (2603:10b6:510:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 29 Sep
 2023 17:54:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 17:54:14 +0000
Message-ID: <278de035-67a7-19dc-c97e-ec2e0b80d3b4@intel.com>
Date:   Fri, 29 Sep 2023 10:54:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [net PATCH] octeontx2-af: Enable hardware timestamping for VFs
Content-Language: en-US
To:     Sai Krishna <saikrishnag@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>,
        <richardcochran@gmail.com>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <hkelam@marvell.com>, <sbhatta@marvell.com>
References: <20230929071621.853570-1-saikrishnag@marvell.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230929071621.853570-1-saikrishnag@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0310.namprd03.prod.outlook.com
 (2603:10b6:303:dd::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB4984:EE_
X-MS-Office365-Filtering-Correlation-Id: 967340b3-95f7-4534-dd77-08dbc11517a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 20rp8pm/3/oFhxVWKdd179rCDSrE/EDQCKMTrxr+3upJUaPv63doFYwzsFQ+zkp4cbpEsWrv4YnJZptzBv/3ZgmMn5U8i43hH8JshumGVYwsn+zhYrUH+dQgM9lqBJxKQKOFtZJLdRCkklT/Z4trZNc3+UQ45hGc/cjZrmf1K5bc2u9HE+gPTF6INYjHBowa/FA6gCXpTZzSIx0GS7nVH1z2l5qJYyN7OfCe5FRqLn64Yy5GiFEOyEN81xsQUr5lEmXB4wrAZ1yCQO3TIHCTxULa1oQFKNk+75+lsjmTRnrH7ioUqbCO4G91FtyCWLEgEiGPP7EzjjZ8Gq+LqIp7XjuI81q38cLKNG+AT+jnvQw66bk4X7tj/Et5j+8TAh/onBMdjefQpUyZ773CxXUIl+sOEenzBoAPF7jjNUcTEu6n4kiEDtExkCyGkM1qJTEJlAiX/LyPqk5mdw1/G6u23rF+Vy2X6VSiISDCZJxJhYn38so+ERxuzO+DU0l+NljjD28/RgUf5vr/xsMNH1MvyiWL2NCihXgystmUm6i3p9ShdZs+gatwLNufs7feNv/p5FZhK8dHxJmYzdFRn4QOwwfEHJmJh4Q6KlGm5Ce+AnbZSu/mv9V1PG8zcgmiJh8WaWwjL0j5F6vaB5ycIhptDynM1Lf831JgKFLAL89pYc0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(376002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(86362001)(66476007)(6486002)(82960400001)(6506007)(31696002)(478600001)(6666004)(53546011)(316002)(66946007)(66556008)(41300700001)(31686004)(6512007)(8676002)(2616005)(8936002)(921005)(26005)(5660300002)(7416002)(36756003)(38100700002)(83380400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXdvdnRXOTVraC8zTUJ5RjExZXRzNVAwUmt1MFNGUzYzaTgycnloOWl3dGti?=
 =?utf-8?B?aFhqa2ttd3lOVDg5ZnE3ZlY2ZWs2ZWh4VG5CMjBrSGtibjFUUnNQcU5tYWlL?=
 =?utf-8?B?bjcrYWRDOVpnMURWMUI3di9sTVpmblhyUHB6TGVkZzVxRUdHekdIVlhHdnBy?=
 =?utf-8?B?TnhUaDFQOWppOVozMTJwd1MrV2FJNm5xNlE1dHlxZThyclZRRm1sdU5WdHhj?=
 =?utf-8?B?enF2Ynp6Vm4wUWJDRDZRa1BOK0g1UUQ1OGxjR05MUkRlYmpyQjQ2VzVVaTkw?=
 =?utf-8?B?dVRSaTJOSVFYU1lyYWpuM0Znc2U5c1IrZkYzNFN0WE1XNjBLcGgvSHpXdzZa?=
 =?utf-8?B?T1FkQkpObWYrYVl0TFhRQWovRlJVTDY4ZDg0VkVBSisvZ05zNzk1bndJQ1Y2?=
 =?utf-8?B?Q2dSQXdicGxOUHVJYW1MWjF5cUdiZElveVpJMUFnSmp4dXIyTDQwNGlMdW52?=
 =?utf-8?B?WW4rZGZkcUNJc09lRTZMNDlwRkxhdUZDK0JPeGo3ZHg2bUMrcUIwQWRXVWVQ?=
 =?utf-8?B?UldxVWxBTXlyRXdpcXJ1OUVycE5Gc2ZNQjVsZ2pPSDhzZWtFcEQyM1Y1bWFJ?=
 =?utf-8?B?NzdsVTJTS0tKL2hsenNOTlZIYlYzUFhkUXVNZjBwbyt2THpuYnlNbC95cktq?=
 =?utf-8?B?N0dkSEY5Y2FvMW5jVGF2ZVF6WWs1OXJ2ZWFEbjFMbG5jSWxMdzA3M0NZWTdQ?=
 =?utf-8?B?Z1p3OTcwYUl5dE1BWGhGZEd2d1BnZkN4aUMyc1UzZ1l6eDl4ZGdmVTU2NHlK?=
 =?utf-8?B?TEhSVXBXS3M3SGR0WXRpZ2RyK1pRSnhmdFFWNGhsaDRYcDFDT3lCaExQOExw?=
 =?utf-8?B?U2I5blhOWVBjMitzQ3ZBK0lmMEMwc1ZUUjR2c1p2Qi8rSUt0SnJTR3UraHdV?=
 =?utf-8?B?ak9yVlVlbkpaK2t1VDVwU0s3SGQvckpXVzZ3cnhrRWNxVDVENDl5QWRTa3Bv?=
 =?utf-8?B?Tm9sMFdBSGFicGMwZnl0cUg2SWFBVWpaWjhyRzhVNWxLNlI5b3E4RW40N0Fr?=
 =?utf-8?B?MzdPa0JqMzNoMFVpYitqa0QvbnFFdkRwRkZVZkJvVGNzeThyUE9IVkh2ZGsw?=
 =?utf-8?B?b2xSNE8zeUREc1AxYUJ6OTE0Sm5iOGVaMlFEMHNhYk5qK3BsSVdnUmtIWTdm?=
 =?utf-8?B?MTRyeVhsZjkxWDQvbWcwajFJOGRZRytFNHN2Ly9XV0dRZEpzckhLcnB6Y1BT?=
 =?utf-8?B?Q1dDbldMK3B2YUpYdlhzR1NFM0FhTDF2bFZhZFVFUmNDNnZrU2FVV0ZlSlN5?=
 =?utf-8?B?dXpVbXB6WDZ2dHJZT3M1Y2F6TGgzbVBWM2x3OC9wQ3hyMWRtK0doc2REcERs?=
 =?utf-8?B?NGdvWTVZKzJkTDYwVC9rWUp2K3NHeFBSZjFaZmt3bzVBNHFGRlFUWmFOL0lk?=
 =?utf-8?B?SndHOWwwNVVwLy9KMXVJMlNuMEFBbENaZmNkZTkwWmlqTHN0ZkcrUlV3dFBi?=
 =?utf-8?B?cFlSbXd0VytMNVhpM2FHUnBMSTlJWXV4TnljWEZWZEhTc01iZlliQk43RjI4?=
 =?utf-8?B?QUFEMU1sVmlWOXVIOENhckRPS1dWMnUrVWtSR3dCbEVVQnZvVzE5SW1ER2ow?=
 =?utf-8?B?Ym5YMDM2dzNIdzBDNEpvNC9oZVY1MnlYbXh4RlZxRVhHUzF3WE8xckZsL0xY?=
 =?utf-8?B?Y3czUlREUUpET0I0NXh1NW9BbnpyNjdPem9wb3o0RUEzTVErbWc3ZFpxRDBX?=
 =?utf-8?B?cjdVMFkvcHo0S09CcEFtNEpVaHdCZEQ1cTU2c21aZmhFWHRNOWdUSWpuQWFh?=
 =?utf-8?B?SWxPdXdWQzdWOFFZcnp5STc4dVdzUGFxRDFjeWVST2YxaHhCZ2RMMFB4Ym9k?=
 =?utf-8?B?SG9Ka3BBcmV0NkwrKzAvblBOTEtxcE84eS9xb0t2YWNMcmZGMGNsUlo3YXpJ?=
 =?utf-8?B?eFVMY1EyWm1vRGo1UGdrTEZZeWxWWENKYnRGRU1wSkdCbmlQR3FoSklBVXBZ?=
 =?utf-8?B?YzM1YThUeldPanFZZXF4UzE0b2dSNFRvSVlGOG9FZ0dtV0YyVWRhQjF4VG5z?=
 =?utf-8?B?K0t6Q0orc2FrUDVPeHNxUytpTlRlK29sNTlKamdDVFMzaGJHRE5OVUFFS1VS?=
 =?utf-8?B?Rk5iMXp5dUZ6MkM3cVRJZDd6bE01VUQwSjlLcUNRYzB4dlRsS1ZlRHRQd3Vh?=
 =?utf-8?B?ZU9WbExTcE9yY2NMeFMrOEZ0dnUvZU5KMkRJc0Jra0RHakdZVkJCVUh3Q1FJ?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 967340b3-95f7-4534-dd77-08dbc11517a6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:54:14.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SguR5qjK1VNEVC4aIfan4Tu65K2GOeKn+OjPbhm8RJq4rYTswvXEIcsw8M7q0igIMUmHajYBroJDy225K+oG4RqNK6f8+6SeYwoxhj8y/+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4984
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/2023 12:16 AM, Sai Krishna wrote:
> Currently for VFs, mailbox returns error when hardware timestamping enable
> is requested. This patch fixes this issue.
> 

The subject title implies that this is implementing a new feature (and
thus not really a good candidate for net), but the content implies this
is a fix for an existing feature thats not working properly.

It could use a slightly improved commit message.

> Fixes: 421572175ba5 ("octeontx2-af: Support to enable/disable HW timestamping")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>

Typically the author signed-off-by should go first, and then other
signed-off-by are for people in the chain of patch delivery. If the
other two co-authored the patch they should have Co-developed-by tag or
something. Otherwise I would expect that Subbaraya Sundeepd would be the
patch author since that signed-off-by is first.

> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 

The fix itself seems straight forward, though the comment is confusing
to me. You also changed the return from -ENODEV to -EPERM which makes
sense enough I suppose, but thats not called out in the change.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> index f2b1edf1bb43..aba0c530160c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c
> @@ -756,12 +756,11 @@ static int rvu_cgx_ptp_rx_cfg(struct rvu *rvu, u16 pcifunc, bool enable)
>  	if (!is_mac_feature_supported(rvu, pf, RVU_LMAC_FEAT_PTP))
>  		return 0;
>  
> -	/* This msg is expected only from PFs that are mapped to CGX LMACs,
> +	/* This msg is expected only from PFs that are mapped to CGX/RPM LMACs,
>  	 * if received from other PF/VF simply ACK, nothing to do.
>  	 */

This comment implies to me that we wouldn't expect this message from a VF?

> -	if ((pcifunc & RVU_PFVF_FUNC_MASK) ||
> -	    !is_pf_cgxmapped(rvu, pf))
> -		return -ENODEV;
> +	if (!is_pf_cgxmapped(rvu, rvu_get_pf(pcifunc)))
> +		return -EPERM;
>  
>  	rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
>  	cgxd = rvu_cgx_pdata(cgx_id, rvu);
