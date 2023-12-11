Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F390780D5B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345182AbjLKS1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjLKS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:27:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B662FB4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702319228; x=1733855228;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3+PWrFCo/pFgluwAde/452hPsWGO1fAfvCqEUuaVm3A=;
  b=H5kFn8uZH4AVbOIz/riOHriFa+667Z6aaBB/S0HQzmlBvWibsODQcssa
   FB664lNpv7KNIi2H5SUh4ONKQlKvymJaHb1RoHqwLPeKrPd6/Nddo6xvB
   meeV2sBLIZkQJRDxpyaXhe//vNsMDuSDiA/t0/fYll0JLcS4MgAeiTtAA
   XQH4nSIJ/gZx1RlUKXDN0iAuCONx8ALN+DX+pbDRx6DatQpk+LIHe1YFt
   AFn4eeJLzsJ47v9s7UgTynsUovQlKW3XDQrhGeaxxOOJOcuOJ7QEIvm9d
   I9Pp/ug/6Lxzvn3kYsLiK8s9BdSy0+vqaj4cHP6M7+WemQykZTPRNAUBN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="379686089"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="379686089"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:27:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="839123033"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="839123033"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 10:27:08 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 10:27:07 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 10:27:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 10:27:07 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 10:27:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akUE5n+e0N8TKqiz+Aq5Hnfkcv5i/r0Btknt2xiPAWvBoWa55V8wks4U1I2Y+ZdDaZurCSe+Tau80m+f/CujNPsaBl10xXg7J0MLwaiti6VcOaY0ex4bXtfkILUWuD9okHc9FYGuNRxLS1yPnK8pWHmiLLlJ11zi6RrICaVJUN5Nr4dafhWpmJm5JD1Io3qPShmA11MDh4M76u4lYFIogMt7oxDBcFuPifLRjnlIOim6waOMiOCQCJcZdX1f/J4cUFCdZb3zgERCfMAoxsxfqtIs/rZzjmMhockl+Jv/w3suQT/E39TvgBzARCS6NiOSTXgY3/PVdxUs9UDTQZMQQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1vtXYh+1uWdS0DvbDt5XPOGohYO3+oP2efUtMnxFBU=;
 b=O/U/bdafJqVv5jU0pwW1b66RrxZKqzdNE3zMAd7N2PHbH9jHKut6ZMDN3THhmLHBqqRhj0xvNqt0Hv6EJVlkZBzENxeO6KehzWT2ETga0P4tGGwHq4a22VrbtCri0sBLlEYlUj8KEqjRKKbwpQOeRAFzUocDxwdT8iRIXswrxBYaeqqtvwPIEw2Jebqx5m7FrONV9KA+iou9j8JmQcCZTd0zy0cOgJvssY9BlAmOG2gJ/xoXMXSzZCPp7/3wbPmeb9Uh1OIw5v8jSIX8/7md3FiSUbT0ojMlXsWCJnsTogKLf8cqoX+CWu0hvGH0fDAzaN9bDDKVIB3jMQdwwNMuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB5247.namprd11.prod.outlook.com (2603:10b6:5:38a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 18:27:03 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 18:27:01 +0000
Message-ID: <8716bf72-e4ca-4f83-8a30-327baf459dbb@intel.com>
Date:   Mon, 11 Dec 2023 11:26:56 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] nvdimm-btt: simplify code with the scope based resource
 management
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20231210102747.13545-1-dinghao.liu@zju.edu.cn>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231210102747.13545-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::18) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6754ab-5ea1-4003-4f97-08dbfa76c4b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VBarkC63qrYy2ot6fBeDHHVLJtd8cmTkrR+QAY2jABiCB2CzfsHOShXw4Mw4NbDHOUm7hIFWFXiULohYqiWfEmSPyXTzPObtMGWHetSFzPW0+9IJ+Nn8nVYJYAQelZpUBX8ysamkQE2wJwubvWBdacUCp0A0eVLRGri32ZjSPouTFjLsHloHFSc2Ro/d/3bsPMoLHOzs/BdGdyiNXmBk60wi73A8ZHELMG5rFMtJcCZHOysZHtCeWBtIJHXKRHqV2FIlH085NYYWS2/S/CkT+pW5ZyjRCKOFkbgyASjqMUPmxEC0uKlFfHJL5/+O9yOHbn3jdoUGTYQ6wXSZEJot5pJ5AlRt0F6bzxYodL9XpEdj2Tut9LNUpDv+EbToU/DpHLHv5Mud9zWglJhInHiHmpT6YCHy98/bZdg5UB6h1AproDjcjM1eHd0QeTcn8yWVaChuyxlRpN+Zlj0ez4tZu288zN1R8vmXLSN3GlINqP3CIlvMHaaY1KKIF/b2RWO0RK4n/vy4s5S8gp5gsNI9JDhC1lEbcPkKnnp0XwqB4+VO+0RO7Rd3iSHMSREIcMMrQ8kUnMl4BUZG0aHBi2KoNrBImZfNqnp7ov5+2soEVyTXSv/zRsqafzlebLh1NHys
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2906002)(41300700001)(478600001)(31686004)(82960400001)(6916009)(66556008)(66476007)(54906003)(6486002)(66946007)(316002)(38100700002)(6666004)(86362001)(31696002)(8676002)(8936002)(4326008)(53546011)(6506007)(6512007)(44832011)(36756003)(5660300002)(26005)(2616005)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGxLWHB5ZldwSlMrcGI5Vm15TU9EV2pESDZocDlHSklqT2YvWndkRFZxN0pk?=
 =?utf-8?B?UU50YzQ2c1hLbTgyUEl1enNmR3d4MXkzTkRlYm9kTWYvNTRmUVAwaEQ2YW5R?=
 =?utf-8?B?N3R4emtXSGlFVk94U0VaQ3VoeGJ0T092OEFaeXdnYlRmZFg5czlIS3VUYWxk?=
 =?utf-8?B?dldrNFZrV0ZhOEdlV1A3ejRSL2dURXpXVUM5L0VzSDlTNTFPRHJiQkNNZk9s?=
 =?utf-8?B?MUJTYjNOU0xhL2t0VnhYc0Fmb0dOV2V6M0FzWVlrMmcwRE9ESXd6bDV6RHFR?=
 =?utf-8?B?aHdpOWdSNDlIbGt0MDJOb2NUSUR1UXlVY2RzZmp0MTZDTW1EVkd5cFNuaWZh?=
 =?utf-8?B?ZG9YZkY3KzdOd3ZEOTR3Zmw4UG5LaS9zTlFFU3R1L0I4cDkrakpnL3hhZ1RK?=
 =?utf-8?B?bnpCdm5HSVkzY0l6MXpoa05qOUlWY29zVmRnWStjWDZqYWk2eEIrU2E4aDFO?=
 =?utf-8?B?Ry9RVGQwdUcrejU4Sk5HMStLMkdWSHBLMEZ4TGd3SSt6emRMUlc2ZkMzOGkz?=
 =?utf-8?B?VzMrM1NNdm9VdFE3VkMwV0FmbTh5NW1VQ25rTzJrd0Q2L2VGeUY3dDRSaU1B?=
 =?utf-8?B?L0Q0S093M0g4RTFSVzI0WnpkdlR4TGd6WW1OZVhlSEZ1cWVxUGRJSnM3RC9H?=
 =?utf-8?B?djNUbE5CdHR3QllDcTNGYlBSWWZITmZSUEFqenMxK3k2N0N1akdmSE9LWGhp?=
 =?utf-8?B?TzhGbTFhQkNNblNvdVQveSs4WVZEbWFoaE0vcHp0V1NUOHBNUmpsS0t5VWxN?=
 =?utf-8?B?T1BRQkFJQ0xOdUZVeHcwQzdrL2JwWW5VQnVvUUtuNGV5dE9yeXhUQ2FvS3Vi?=
 =?utf-8?B?bjY4blRMQ1BMTGdpNHlnZWNqTmFiRE5FUjcvQ0drVG9ya2d3TlllbDlUQk84?=
 =?utf-8?B?K0F3VjFHL001THdBYkZLb0d3SS94dEZWRHdhb3JsTDBsNnFxSytjcEFUQWJ5?=
 =?utf-8?B?ODZVSlNqQ3d1ekd5OGlKblc3aUx4L01rbFpzeTIwZGJsSXRSNVc1eDBJeDA2?=
 =?utf-8?B?SXFBQ2tVSG52dklpTU8yak8xUGVzd29tOXJRM3R4ZTkrRG5ibjJvSFpFOWQ4?=
 =?utf-8?B?eVVYZU9ocTRMSkY2eE5aZ0RXVGtpZWgxVzhTVWRuYXZnbDdXa1ZnWGY1Sitr?=
 =?utf-8?B?SThEdWdMbnV0a0xXSnloTXN3bm5TZi9zU0VMSDBGei9KZzlNd0dBQVZ5Q21L?=
 =?utf-8?B?a21Mc3AyTGNtQ3JMaDBTb0xKeEpoVVVPanJrN0xLcVRqSkRaMldrUHJtWlJV?=
 =?utf-8?B?MUxRc05RMk54dDF1SlV1a1F3U3dNRWhmOVZoSlF1R2VDYWZoM2NtNkFiMVZ1?=
 =?utf-8?B?NjNaUjUrdWtaelNWYzBraW9rdFR4SzArOWwrSXV0NVB3TlFyVHJ4aytDRFlh?=
 =?utf-8?B?VjAvRVh1c1k4Yi9HUzgzTDRLbGFOMy9OTUJKck00UVplMWJ3OEpFeHN1OWp0?=
 =?utf-8?B?OGphN0p4R1d4TkNua0pMZ2FKWDBNYXJnejZoZDRxb0UrWEIwWmVnUjQ3Tmlx?=
 =?utf-8?B?ZDkxWnhiMnhHbjF0TEtHbjh0cGlxMElJcFRjdG5FOXlFdHNYVjlPcHN1cTdN?=
 =?utf-8?B?ZlJNZ1c4QnlmL1VDUjg4MTJBYWVaQTBpdlpRamVnRU4xbWhHeVNaaDVzSkJJ?=
 =?utf-8?B?Z1Noa1BqZVdwQm9pUG1QM0Y4TmRCZTlQS2VDUkVZMkFNL1lybCtuL2U0a2RB?=
 =?utf-8?B?Vno4RE1CVjFYdmxjalpoZEp0TlIzeVYzVHpGWjE0VkpnYlpwU3FYWDRxajRt?=
 =?utf-8?B?eENyQjl3WmJ3T1k4Nk4wV09ESWNxd1B4NWhqTFpBTXNNVHZGQXhYQTlDcWRa?=
 =?utf-8?B?N3h3REVNc1dBdC9LL09wSUJRa0ZnN09VcDcwaTdTcFBrVk9EV1FTbE84eTdy?=
 =?utf-8?B?QzNFSTZJQ2g3ZmwwajR5eEhNTXZNSC8vbXRmNDNYTGRGYmJrd2pVbURQdDZT?=
 =?utf-8?B?NVl6SEFzTG9MNDRkSnpZYktaTThwNmRvT0tGN0lYU09Wc1V6VkhFRmlNWkIw?=
 =?utf-8?B?MFVRc1dRckRTTU5wUlBtMitWblIwVVlhZzNxVVVZYXk3bk1zRGU0WmVQdjk5?=
 =?utf-8?B?OXdkbGVpSk5lNzVhVmRodHdkaENFU0kzR0ZsRDVXMG5yemNwYmlDS2pTNmM0?=
 =?utf-8?Q?P9bauyIbpIkch4YhdBc+Lbuen?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6754ab-5ea1-4003-4f97-08dbfa76c4b9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:27:01.8540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQ2+kl+2mK5KWRs0UZqLIHTb8tXmuwstCZXK7U1sXw4YmG8EdbxjiaN613tySNFW+pYjTl7mn8bC7JUDURDubg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5247
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



On 12/10/23 03:27, Dinghao Liu wrote:
> Use the scope based resource management (defined in
> linux/cleanup.h) to automate resource lifetime
> control on struct btt_sb *super in discover_arenas().
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/nvdimm/btt.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index d5593b0dc700..ff42778b51de 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -16,6 +16,7 @@
>  #include <linux/fs.h>
>  #include <linux/nd.h>
>  #include <linux/backing-dev.h>
> +#include <linux/cleanup.h>
>  #include "btt.h"
>  #include "nd.h"
>  
> @@ -847,7 +848,7 @@ static int discover_arenas(struct btt *btt)
>  {
>  	int ret = 0;
>  	struct arena_info *arena;
> -	struct btt_sb *super;
> +	struct btt_sb *super __free(kfree) = NULL;
>  	size_t remaining = btt->rawsize;
>  	u64 cur_nlba = 0;
>  	size_t cur_off = 0;
> @@ -860,10 +861,8 @@ static int discover_arenas(struct btt *btt)
>  	while (remaining) {
>  		/* Alloc memory for arena */
>  		arena = alloc_arena(btt, 0, 0, 0);
> -		if (!arena) {
> -			ret = -ENOMEM;
> -			goto out_super;
> -		}
> +		if (!arena)
> +			return -ENOMEM;
>  
>  		arena->infooff = cur_off;
>  		ret = btt_info_read(arena, super);
> @@ -919,14 +918,11 @@ static int discover_arenas(struct btt *btt)
>  	btt->nlba = cur_nlba;
>  	btt->init_state = INIT_READY;
>  
> -	kfree(super);
>  	return ret;
>  
>   out:
>  	kfree(arena);
>  	free_arenas(btt);
> - out_super:
> -	kfree(super);
>  	return ret;
>  }
>  

I would do the allocation like something below for the first chunk. Otherwise the rest LGTM. 

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index d5593b0dc700..143921e7f26c 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/nd.h>
 #include <linux/backing-dev.h>
+#include <linux/cleanup.h>
 #include "btt.h"
 #include "nd.h"
 
@@ -845,25 +846,23 @@ static void parse_arena_meta(struct arena_info *arena, struct btt_sb *super,
 
 static int discover_arenas(struct btt *btt)
 {
+       struct btt_sb *super __free(kfree) =
+               kzalloc(sizeof(*super), GFP_KERNEL);
        int ret = 0;
        struct arena_info *arena;
-       struct btt_sb *super;
        size_t remaining = btt->rawsize;
        u64 cur_nlba = 0;
        size_t cur_off = 0;
        int num_arenas = 0;
 
-       super = kzalloc(sizeof(*super), GFP_KERNEL);
        if (!super)
                return -ENOMEM;
 
        while (remaining) {
                /* Alloc memory for arena */
                arena = alloc_arena(btt, 0, 0, 0);
-               if (!arena) {
-                       ret = -ENOMEM;
-                       goto out_super;
-               }
+               if (!arena)
+                       return -ENOMEM;
 
                arena->infooff = cur_off;
                ret = btt_info_read(arena, super);

