Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2BE7E6687
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjKIJVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjKIJVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:21:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541501FFB;
        Thu,  9 Nov 2023 01:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699521667; x=1731057667;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VhdgfXiyQyFyHSCXUfidZmrC83vrMt5DpbvgCvqjqmI=;
  b=EjXkmCvzuJlmwcBxNbKInAMXDfVJKfYzIm2K1p8GEyPf9gdFIoCcnB11
   h4EwuRvcRUeObIVMQRNHX1qb/VIWS8cR91K3mk8YIdtHhOZBrQ08T3JAM
   2NARU2xsFkd9c/WzFmK2a7XKb+/wMGCigLtPEGEVUFj2znTu6ZxhYIZiy
   D8IeksvdGyDs38r1Hefxn55Z3j7kVkzrYbmNYIVai/qgx6nHQM7nk8FzL
   E/4U9rNTv+MJXoGIuiE0//FKQYoDRVM96saK9NGIB8NMXy09gIOOwAV8y
   nmssmf7eVfxasoaTM+shMIFASd8B/bYuGLxjgNlePS+Ay3ce1U1EtRfct
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="476178151"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="476178151"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 01:21:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="713235236"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="713235236"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 01:21:05 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 01:21:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 01:21:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 01:21:04 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 01:21:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uc+1Akvewiug31mxdsS1zZvoNLlH6BsAho0wASJWy1NTExnPulFNLPPLfym60TCKXYi/iCP1PQaEWWzWs9Cr76n6+5daTfFPJiv5FZEJwBemBTTpg4nqI1Rvt4cKE02tXLzYernR4Q3MdjOFt8KUvL6YAFK7mPioc1mC9D+SNxd88AlGCy8o4ilBhEsCvHHdOE84X7xE4UMeHPSEdUgZu/bRdCYHz+Ew2dhECTOHDgJJerfniKp2Fmf8tM2UBxDuy2WIz04mFzFWpEJU7ZoNqohKVJjlnXW8GTkv6iUbGVaJrvZc9Iovpqq0Cf4+82hdSLmPxRU70pNaqPxxEXdn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bJ/Js5eU46iXAY//OWO9P7k/AHTIQTMfXNYwzBOY/A=;
 b=g/SANAGKMIY0qUUoLfRNwjOcnAB7S8jZSUMNQUBgNXTfGJGd8X0PSPOD64D1X3GYECc8wMFR9O1mZjCzrGBKwhKzMi6t9wsrWeA1H0o6Ykz7BaZN6ljbHqXUqMjlA9nBOIRAmdQ3/eo8412v9Pk/58+WoQuweOJOulrt6Xgz6/VQb6wfSgjsbqkoIbKqX1mKoGY9753u28PZRV86/zkxsa62arYNYPNC+vlBIw1NBXPOk21XdUGKrtkmy217O6rq5SgBrOelFDZloNfO/YLFSQwroM6Xbm1FavHZoKKVxp7To5XwEiEH3cPDuPDaqCGVpNBgOYXJAkciFLXJOP9sLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SJ0PR11MB6693.namprd11.prod.outlook.com (2603:10b6:a03:44b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 09:20:56 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 09:20:56 +0000
Message-ID: <076f1ccc-aa16-46e5-a3df-b8fac7dbc0ca@intel.com>
Date:   Thu, 9 Nov 2023 10:20:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] i40e: Fix waiting for queues of all VSIs to be
 disabled
To:     Ivan Vecera <ivecera@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>
CC:     Jacob Keller <jacob.e.keller@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>,
        Neerav Parikh <neerav.parikh@intel.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231108160104.86140-1-ivecera@redhat.com>
Content-Language: en-US
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231108160104.86140-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0009.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::9)
 To MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SJ0PR11MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c38541-0846-49ff-ea45-08dbe1052df1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LA8s2BzgPnSB2BqPJ6JDvhfNX0Ao14q4ItxjjhH2PtPopliHhTJVFXgmRNZrayLlRDHR46gVJ9qsQAfShrDji5P19gusoarwvBh85mHTbxcqnE0dVDBxuxf7XcWw4Z4d9k19O7JwZeyLiO5tFQgORen4mZnP7zSSr1IqouXL/Di3jxEzQC9DoKYyHBEQil8PLNf8JkgG0xIQSxWeorSAAOmMaMnPh/a1/+EFAvTulK1rpdvFpdB7FC5LtBCvxK4kMAa38tvZ9KAcqUXwOG6efmOyxNSx2v8cswAgjthr/vV3MsiPh0SyeIePc9FEjSmOPHuU9CA6hwGgBzg79LJ/1Yx0Ymx0KwTm5r83vaMsWrOw7iEkcLyX3TUgJk9emRFMcnLqxcplFSW80cbbWu5PMtn8VqSdWaLkPfCAfg99FmqJuwDZwMFQAkoB9M+2zzMtKTp6DYsQYK7/NEQlTR0U77akIttakoH+tpKeW4L5b4ky+qj8GG4rKqvx9PxnQMd7WEQKVmLbQ1w+UMTkEXgrDQQ09IH2Mg9bAJPT4QATUmptk+zMn58+JY8ieTwIdRcBP0NEjxPdorqo2jlAfISeiLbOkrb5FhWzMyoZaEoz0pYVvWFtmDHea0ll94DSJ16c2yEVjHDsW+8Fkv5DzWIgTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(82960400001)(2616005)(66946007)(66556008)(83380400001)(26005)(478600001)(6506007)(6666004)(66476007)(53546011)(6486002)(6512007)(31686004)(41300700001)(54906003)(31696002)(4326008)(5660300002)(44832011)(38100700002)(2906002)(86362001)(316002)(8676002)(8936002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmZSY21BU0pkR0trZU03TmhaN0pwUkplalJ2aVBGUytZWC9tWHpTYUo3amtN?=
 =?utf-8?B?YzVpSDNjNXlZMVlYZkRGakZNNmc1dDAyWEplRktqd0NLYVgzcG8rTEZIOEFw?=
 =?utf-8?B?eXVGdjUvVGxwMVg1b2w1UVVmUEJ3WjZySXo1eWo0cnZCcnY3ZFVVWnNKTkYx?=
 =?utf-8?B?YXVzd3lQcE8yeUV0aDlWckdNZHZOWmZ5cEp6QWlRUll6ait4RFBUNnlqMkVs?=
 =?utf-8?B?OEF6dHlOWTEzZWZMZ2hSeDZ5YjlaTmFuZzhhNEVWbTRKVERxWlF5STA2c3h0?=
 =?utf-8?B?dzV6b0pYUzJlcUJITWdLcGIzYkpyMjNXMUVyQ2pJeVYrQzBRaGQra2VRa3Z0?=
 =?utf-8?B?THdzSFJMR0crNmZaNjZCbC8wRlJrOVVRYnd2bFpWaG5UTlRLdVlXWTBQUlEz?=
 =?utf-8?B?c1EzOUZCNnJWbmJQMVdxMkYvR2t5a3Qwa1JNVE1YcTVTV054NS9vRm84VE5C?=
 =?utf-8?B?d2trOE1tY3J5YmxzM1Y0RjJiNWN0bU1MWlBUTk95ZFA4QUdyWHE1bklxenZ5?=
 =?utf-8?B?cXUxbDdsZnBsY0NKR3pzOThqR1ZDME1nQjgxa1BNcEdmNHRvMUFlTk9JalRK?=
 =?utf-8?B?d2dTYjlZb0FLdmR3RHVFNitvVTNrSG5FOVFGUU5qRXBLcnpONlhDTTYxajhn?=
 =?utf-8?B?bmpYSHBuY1ZEY1VYN3NsaXAzQlFDL1pRemJMTXl6a09jdWtzNTFUa0FHemlx?=
 =?utf-8?B?RlR6akVlcnA0TmQrSDJ1N1Bub0N4UzJad1MvZ2hQKzJyUklVOGNxUTB2alRl?=
 =?utf-8?B?dEJpT3RuZVVHU3MwYVNGd2R6SitFVm5CbGhVaGtNenV0dXkrWGdCT3Q5eTZs?=
 =?utf-8?B?RlcyanhNd1hrWGtLVyt3MUFrOURUTVRhSEdUVm1JTnBTMDJPRHQ0Y29uaVNx?=
 =?utf-8?B?MTc5TzF2TjRUaUMvcXM4L2xZUmdyY0x0d1BOd3dib0EzT3NYdGZvbXYxemRN?=
 =?utf-8?B?WlYrQ1ZibEpKWVRPcldzZGlSSzN1NzFLSkhCdFg1M1k0dHBKWXZXNHVsbzVM?=
 =?utf-8?B?Z2dmU0UwV0s5bzdxc0dYdDJTbWo4ZE1pMGNkZnVjL2hzSlJKOGRrY2lxV2hW?=
 =?utf-8?B?eDJjeEU3a3ExUTR3dWJaS1JrZHF0Wkw5ZVJPMTgyRGFCQkxoV0c4SnFzN3hx?=
 =?utf-8?B?UkV0UG5wVFQwR0s4QU5EYUhENVpJM2FoSFFJeWJpUm84SjVKSWRuVnF4a0xL?=
 =?utf-8?B?VkpzSHI5bHFYMnJEdWE1bEVLK3ptU050Zy9COVRIb3VqcTgxQUQrZk1DODBB?=
 =?utf-8?B?NWdMTEJWb3Bnb3lCRkd1SlNHMklvSC9wbjdLNUJiYUFhZTBiMzh6QXM3TktQ?=
 =?utf-8?B?bmNvVXdweFBPZE5iYm8xS0JTdTk5TVhra3l2elJXbktVQjZGM3VneUV4RGhv?=
 =?utf-8?B?QlNITHRTb0lXditlUGNhdm1HZ1ZjQkVOM1ZKMXVKckxBRFcvbjlLQnJ1UjdM?=
 =?utf-8?B?THFJTGFWK095Zy9Kclg3T1RGTXV5NVJvY210eExZTEtibDJmQXdlMWtQcjRD?=
 =?utf-8?B?QzZVUWdaZitkSVplRlNVSStncDNacXMrVXdOSm1wTzBCSGxjbnRHSUFiVHBy?=
 =?utf-8?B?L3FCSkR4VTc4Nk1xY3NqaExhRDd0WkVLLzFlRE5XZHlteXcyRnd5MUxqaGtG?=
 =?utf-8?B?VHZ4NVBtZDdYNEFicGVZWVl5MVZFUTVkNzJZOUlpVGwwRi81N2s5OVlSdCtj?=
 =?utf-8?B?TDFZSE5hQy9CSi9pZ2RkaU00d25LTTZXTk1LdlI0VFZ1UUplNWxySXlsTU9H?=
 =?utf-8?B?WXRvS3E0d2lPRDZEdTgvVU1kRmQvc2NRTVAwYyt0OHA3V09IU3lzV2FhMWVZ?=
 =?utf-8?B?QjdOL0xLR1liZ3BnRnV4QzFGMjEreTBVSHczSWZnSXdRckIxQUdZOHVTcUhx?=
 =?utf-8?B?aFJTZlNtcm5tSHB5SUs2WGN4WjhqcDkxNFFxTCtMY2ZQTzQrV2FlQ2Q1T2lX?=
 =?utf-8?B?Q3VaV3BJQjhOOW91eTVmeC95ZWIrOEh3YUVNSjhNelI5MmRoM0ExN2NOaGsr?=
 =?utf-8?B?Q3ZtZ21vK2NOOXlsdm1NNS9uaDZYbkM3NWlVUnM3NkJSNTg4TVVWdDZNek93?=
 =?utf-8?B?RGdybjYzNDd0enBmQXhNTEVHZnBUYUUxNUFaemwyQ2g0SVNhWnljQXl6Q3cr?=
 =?utf-8?B?MHZCOVFVZWdvb1A2Y1JBWWJIVExnWm96bDk1MUZaZFBiN29EK3NDbEhkU3Nu?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c38541-0846-49ff-ea45-08dbe1052df1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 09:20:56.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNFmriPcY5nUeMEVmIgamrzpY/iCFmq7cvoZyj31rnoeXCO5doMdz4JP7xO6/SZuLNT3WIhH3PLfIa5D6rEyRS5jUbCOM8ZO62h71tnzsnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6693
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.11.2023 17:01, Ivan Vecera wrote:
> The function i40e_pf_wait_queues_disabled() iterates all PF's VSIs
> up to 'pf->hw.func_caps.num_vsis' but this is incorrect because
> the real number of VSIs can be up to 'pf->num_alloc_vsi' that
> can be higher. Fix this loop.
> 
> Fixes: 69129dc39fac ("i40e: Modify Tx disable wait flow in case of DCB reconfiguration")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks Ivan!
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 6a2907674583..de19d753ba83 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -5340,7 +5340,7 @@ static int i40e_pf_wait_queues_disabled(struct i40e_pf *pf)
>  {
>  	int v, ret = 0;
>  
> -	for (v = 0; v < pf->hw.func_caps.num_vsis; v++) {
> +	for (v = 0; v < pf->num_alloc_vsi; v++) {
>  		if (pf->vsi[v]) {
>  			ret = i40e_vsi_wait_queues_disabled(pf->vsi[v]);
>  			if (ret)
