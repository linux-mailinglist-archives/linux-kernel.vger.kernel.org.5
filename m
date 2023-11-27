Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3597F9CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjK0JsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjK0JsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:48:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E8710F;
        Mon, 27 Nov 2023 01:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701078496; x=1732614496;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=9R730cMkBjPwSW0w0ejuJwleeGJ24Nr2HhnPlwTqgYg=;
  b=ReC+EevpSRlG4F6Py1XrtVaBNCZT42kX6N6Rq54rUSsr6tLe2843RLS9
   f1khbv9/A0gY16KZg0TJHc00ubozselq8BXEFOjTs7ajVZzmV3rU/dx7f
   Ao5Xa4ZT9XNDdVxpoXMzSouqOOhT4becWvrLamTJqBPEXaeiABOQG21dK
   jrjtV/sGPlG1UsfDvDvj7Fqo9PYWtshFYkiWJjGnwxg335pOviHrIie5d
   SKVH1wts/Gb27AthYaZKlfGbErtpWy7jIiZv7JPFnXEeHJQ68HOvs1ZuX
   fjOT+h410cXW9PaK+EPczFk+n0uw/8FIltK+JeQhOn0TW2lUJm8XPJQPI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="11368684"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="11368684"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 01:48:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="941511271"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="941511271"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 01:48:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 01:48:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 01:48:15 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 01:48:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFCRODuKTLztem/MyxqCxDpusU1CwyrJaZE/ekxj8XJlkosQWkeIf/QtCpMV6mLWjP6QNpi7Re7/LH+jChpCFN3yjYuJNwNOmImVpN7SXRvhdEQbIKOdBgsqFw0azO1YS0/lIn2Q+K0IOGZaBtAva546VjDdEAEBqgFc6av/LI8OZJyDmXeq0s9xR7Ajh2MuOUk9HTMtey9Sgjeiib66Yw/ExwyNubw6Y+yzfRXXMaTatRsTk955XlT7M6P8s0BGj3On82mS/XRmV1wEvsTqcTYnCA1NgoIxxRxBYVQSZXKbzbTDyF/BLGLIan5+iPS4ehRACbqT0Xr4XpfE7XcmcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSHGEGCILgjjhwHif0xLG+LiJDeLT8Sm01UBpSKiFq8=;
 b=MoP5n1qcEY/pinfUViyzVDxkcBxGIuaClSGoKGZtwL6NilAMR1WufwdPqt2WvhxMoDG6vkE7yQwoYMe8jTzwBtprH6JSI/9WYuD+k2lGrH2pnmkDN6mBBcTWTuBV2NMKCRSjT1/ZeGeB2XG0qJ8i2lTjsVwVDyhDTw2le4NZomv9gp0Z9nl3hWGn9kZ4gUA9NjGcul+QsMWqhB31PYuCS0OvG36h9NdOfxs7lOIuUzFkxqQR8OKre11SbcDmfvQISXJuFkOtgPKRo7sDrYb/jBjpiLOXsNMrjzEWZe80f0I/2gizDGdhItIzXjgjVleptZx4SA8WciCrSK+ss8/FrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by BL1PR11MB5543.namprd11.prod.outlook.com (2603:10b6:208:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 09:48:12 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::dfa4:95a8:ac5:bc37]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::dfa4:95a8:ac5:bc37%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 09:48:12 +0000
Message-ID: <54728d1f-2c57-4cb8-a1e2-de2bf0c8cd64@intel.com>
Date:   Mon, 27 Nov 2023 10:48:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 1/2] octeontx2-af: Add new mbox to support
 multicast/mirror offload
To:     Suman Ghosh <sumang@marvell.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <horms@kernel.org>
References: <20231126184315.3752243-1-sumang@marvell.com>
 <20231126184315.3752243-2-sumang@marvell.com>
Content-Language: en-US
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231126184315.3752243-2-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0034.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::7) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|BL1PR11MB5543:EE_
X-MS-Office365-Filtering-Correlation-Id: ca78f457-0f2c-402b-56dc-08dbef2df867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DvBZElctkQ4N7M5CDNjCn9o8zWjTwgq3aWnYBj2cx3SOfcYuFzyxck2IisrxkzFys0nNNHjo8i7MRHrUf2M+ejK2KoaEt7isqqIqHB/2UthBGujc0SvQKjgCJBqwi7ai/jP1wgdiKa82uF/+cmb7OcGQCBrjMCOy7PWW1fvj/oadq9m7F2lSqdn7qk7Gl9bjctCtXJYwwy7gqE1fkoa4iXmIwr187Ov8YkjQuIEq2GIZK9HjOp5g7r+8f5q2S/XuVhy2E7tIduN4cYnM4Xhh7QNxOv1d83m//te4UU3uAo71rXVIhe5YdyA9QvuIcmXFX0CI7ncsH86B4/uUzLWsyC7fRLEhWhoqsGUFwvGCVLy7ql4MXfgoHhOn+7+rSNLhYWMkRbGpHVwfI6az71O6FvHTQfR4eIi41BpjnrtFCfNGcW71COhC5VQs23dJ16Ul2RPfeuD4Om9dpBFRxXJmuACvFoPSYGb7MreIft77IrJvZ9M5X6Q/8DMkI+46M3J5abxVFzwA2M6TQdyxbFWiqf8IGUq8Cu+0pNVoUPUagPuJfPXa392/MtBIr0QatOjnu/CDygYH+o1VL2GwogOEXNUgwwxEMvEAmUMxVQJg6eF5BU4OOiH2wrzkmZgj13zLtmpvE7XgZL4x9JWKUXzDth52Eaz4mRGX4gOOye4itOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31696002)(86362001)(82960400001)(38100700002)(36756003)(921008)(478600001)(6486002)(66556008)(66476007)(316002)(66946007)(26005)(6506007)(6666004)(2616005)(53546011)(6512007)(5660300002)(44832011)(2906002)(7416002)(41300700001)(8936002)(8676002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWUrMWo3aE5waWlpYzVRdDBwS1k4QTBxR3AzL1k4bWFpaDhvZkg4RGNDb0Qx?=
 =?utf-8?B?RDBiL3pQRGhZY294cWFRdlFST3RUN2hCU2xRWUNpMDdlQ3FuZXcrdnJyOFl3?=
 =?utf-8?B?U3RWSzZkRm96UyswSnV5TDJMSFpYWW9hSG81M3NvU2N3OUp4a1ZmdE9uOXNZ?=
 =?utf-8?B?NGQvQ3MrWlI0ZzFKV3hocW93anBvN2V5YVNwaDQ2bXIrVjRJamRRUmRId3hv?=
 =?utf-8?B?RVQrTFNJcGJuQ2Z3MXpvR2Fmd2ZxTHhVTWNCRFRhMkUzcy96SVExeWFabVo2?=
 =?utf-8?B?ZFVZNVFKaVUyeG5jV25wU3I5SzNBTU1Wb1VYQ0czazhLSG9qSElDOThYeVl4?=
 =?utf-8?B?UCt2N2JQN1ZJWXgzLy9oeE9kSExNbm5aMzlXOWhiV0p1MHJJWTZzcXNCTERj?=
 =?utf-8?B?Smg1YXlHV2RsU1lEQTByU2p2SE1DNGIxaEtqQUxiY1VTaElQSklGd0tHTUhP?=
 =?utf-8?B?SXlsL0lBTVRoYUJNQnJ3YTVoRzVQSkdQY3h5elExaHJPUTBha0dmNHcreDZu?=
 =?utf-8?B?L2IyZlhtYUM2K3JxRHUvb1drWHNNM3d4TlNGdnpxbzlJUXkvOC9Md0xMU0N0?=
 =?utf-8?B?bkFzZ2NWMHNJRnpUcXNqZUdTRUpFWkpzeVpNV2Q2cTVPM1FoZFRhRmViZXdB?=
 =?utf-8?B?d0hoSTdFeU1abCtXcUhJYWo2aDJPOXVlMVlPVXA1Z1NvZEoyNkhOVUxQWkFT?=
 =?utf-8?B?N2pDVEk2Vno1YTI3ZW5PLzhsaTRFbzMyTGdEQklCWG85TFV2bnZPUzQ2YjV5?=
 =?utf-8?B?d2NKWjZpT2d1QUpKS2NyY1lySWF2a2V0MkRyVDlGWEFBMkFhT0QzYi9rT3lh?=
 =?utf-8?B?Z05jSjZNeUpmN0ZDMnlKYy9hZ1dEaFlmWlViQmZCUkM1TmNPRDNTQXVXZ202?=
 =?utf-8?B?SVRudENRSGxiR3lEcFo0VTEzaXNFNHNwK0N2eHRoSzFFelgxcWovTlZvYkJj?=
 =?utf-8?B?dE8rN2xrMytFWE0yN09Ma05aNDBuSjAwWmlaYzZQekNKZ2J2V1NDZnQzWGxi?=
 =?utf-8?B?MG9Vb0ZSM1Y3RnBNUFluUDB4SU1SZUdDK0VYRFB3eEhWbzRKTGtQcnVXK2ZG?=
 =?utf-8?B?bERXTUI0VjdMS0p1aXUydWUxSXRhRlhGTG5MVEpJRE9IcVlKMVM4UzlzUGUz?=
 =?utf-8?B?N3RycFowRkhLSnNIVFFOUnNrbDJXd2VaS1Npd1hrU0h4L2d6czk1MmtVUlND?=
 =?utf-8?B?MEMvYmhMd0hhOERsRUFuUWVHa0pTSHF5TzZ2Wlc3WHR4R1FrblJUbll4ZHpj?=
 =?utf-8?B?ejE0T0FKQTREOW85U2pPa0ZOaTgwb252RTExNWNPVC93R1ZNNGtqbXc4QzJl?=
 =?utf-8?B?OEVBdVl0c2pzcGtXMHJrejlSRk1YTlRha0hqZ1R4QUhtbEgvZHZsQ0FzUjV5?=
 =?utf-8?B?ZTcvS2RvK2t2ZDVhYUo2bXl4K1JaZldESjZ6WmVqWTdjZllMU2t0WTRZSGxt?=
 =?utf-8?B?T3c1VVZybzcySmNXZ3FyVElUa1l2bHJzYmRPckovNUlUclUyNUxGdWd1N2dT?=
 =?utf-8?B?UTRnUTl1T1ZBdG9UMThJOHV4NEdMQTVjZ0ZYeVI4V1Zmb0dBbWRjejYrMXZX?=
 =?utf-8?B?aCt3VENuYUZycTZsNVgwUVNyaGRvd1RtdFZhdDFkMTA1SGpyZW1jaG9CaWdl?=
 =?utf-8?B?eUVmallSRG1jT1VwQi85UHo4Mmw1bzlpWXFvWVBmUHVFVlRFdDZGRVNEMTdj?=
 =?utf-8?B?WnRHaEdNZlZUYUtvU0dwQWNlS2RGVFd0bjB1amtCWFZCNHZwODd0Rk5RU2Yx?=
 =?utf-8?B?bEkySjBxeXl6THRVVzM4VTZuL1JjRzZSRFZ6NGVzdU5LRFgwSWsreGNTZThi?=
 =?utf-8?B?STZWS0kybldsaTFKeXJLSlhGaXhGY2trazBGaDlTSWVJRHJGczlaMmJsMmpZ?=
 =?utf-8?B?RkhTc1lDb0d5SUh0ZXhJS0d0NEZNNDAyMmg5czI4amRMUmZpNmRYOEFoVnBi?=
 =?utf-8?B?Mk5HT0pjdEM1SGw5YlhZQ0pJeFVEOWZqWXB6ZGd5cjN6MTZFWUcrKzNUL3N4?=
 =?utf-8?B?Uk0ycFluL0k5c1hoSTZpcEJ2RzBUQ05oVERmWC8wazNyNHUvOUNhYXNaWlps?=
 =?utf-8?B?ejQrdzhMNys4cGlkL1hSVlZjdEhYekxzMHB0MUxERW5iSEkyYWR3VVpidTJL?=
 =?utf-8?B?dVFGRGlsUzJJTFNlQTZlTWk4TXJvSExwSkFYdnJBM0Y4cm5Yb1ZjdkhxRW82?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca78f457-0f2c-402b-56dc-08dbef2df867
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 09:48:12.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1HwnP/177CSJVSukgKlILCoBCqb5m+wlkyg6KaK1xgA6GOiTLMxMrQtXGpUU6rJFhKvWQgbTdHurhP0PO5jzWs4Bi3MfO3NSiCiXNi0/dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5543
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.11.2023 19:43, Suman Ghosh wrote:
> A new mailbox is added to support offloading of multicast/mirror
> functionality. The mailbox also supports dynamic updation of the
> multicast/mirror list.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |  72 ++
>  .../net/ethernet/marvell/octeontx2/af/rvu.c   |   6 +-
>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  39 +-
>  .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 701 +++++++++++++++++-
>  .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  14 +-
>  .../marvell/octeontx2/af/rvu_npc_fs.c         |  73 +-
>  6 files changed, 867 insertions(+), 38 deletions(-)
> 

<...>

> +
> +static int nix_add_mce_list_entry(struct rvu *rvu,
> +				  struct nix_hw *nix_hw,
> +				  struct nix_mcast_grp_elem *elem,
> +				  struct nix_mcast_grp_update_req *req)
> +{
> +	u32 num_entry = req->num_mce_entry;
> +	struct nix_mce_list *mce_list;
> +	struct mce *mce;
> +	int i;
> +
> +	mce_list = &elem->mcast_mce_list;
> +	for (i = 0; i < num_entry; i++) {
> +		mce = kzalloc(sizeof(*mce), GFP_KERNEL);
> +		if (!mce)
> +			goto free_mce;
> +
> +		mce->pcifunc = req->pcifunc[i];
> +		mce->channel = req->channel[i];
> +		mce->rq_rss_index = req->rq_rss_index[i];
> +		mce->dest_type = req->dest_type[i];
> +		mce->is_active = 1;
> +		hlist_add_head(&mce->node, &mce_list->head);
> +		mce_list->count++;
> +	}
> +
> +	mce_list->max += num_entry;
> +
> +	/* Dump the updated list to HW */
> +	if (elem->dir == NIX_MCAST_INGRESS)
> +		return nix_update_ingress_mce_list_hw(rvu, nix_hw, elem);
> +
> +	nix_update_egress_mce_list_hw(rvu, nix_hw, elem);
> +	return 0;
> +
> +free_mce:
> +	hlist_for_each_entry(mce, &mce_list->head, node) {

I belive that hlist_for_each_entry_safe should be used when deleting list entries.

> +		hlist_del(&mce->node);
> +		kfree(mce);
> +		mce_list->count--;
> +	}
> +
> +	return -ENOMEM;
> +}
> +
>  static int nix_update_mce_list_entry(struct nix_mce_list *mce_list,
>  				     u16 pcifunc, bool add)
>  {
> @@ -3079,6 +3301,7 @@ int nix_update_mce_list(struct rvu *rvu, u16 pcifunc,
>  		/* EOL should be set in last MCE */
>  		err = nix_blk_setup_mce(rvu, nix_hw, idx, NIX_AQ_INSTOP_WRITE,
>  					mce->pcifunc, next_idx,
> +					0, 1,
>  					(next_idx > last_idx) ? true : false);
>  		if (err)
>  			goto end;

<...>
