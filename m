Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4A67A0973
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbjINPhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbjINPhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:37:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9904CC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694705850; x=1726241850;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/qcSGq4VCiHILjFvJI2dteKngJtw431TwELpgrQxJ1o=;
  b=GGyVd/ym8mZLGPZLtXMcxGJvUHqDan4I7Lks5B/7ZdMfX+tJQdxV6b8P
   BHx+AXvbTjYPwJNacVsSmH4sPiRp+bFJT9L2yK+hI+Kcr7tQGmEgnAGOJ
   h5DEWMW973Sx6kqBZvOSWiCnXRNMvCc65Fmz+F3JLwzAJuv8I36tok5mx
   aBP21hFL8LrHxiW1YcoY42ahibSFk7CyXgEebhnIKRLAWnKZFcdFGxISy
   mTdEGQQol1FnZkKROHtcqySEGCpOGR5tA7hxVGs8qHjGA30BJO4o8OWRb
   6/cYi+p5RR3bBHcMHEZbTqGlOF3larDZpF4FCW+8ZSCEJ5hL2qBgFUWGS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="376327110"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="376327110"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 08:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="779682879"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="779682879"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 08:31:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 08:31:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 08:31:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 08:31:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maOrr4oO+FQanLUVQz/57aymJ/Yk4Q2Oo23Qc2PS4TuM3De1etmWFr7MTGJMHi9snRGBmSg1+PiqEVayX5biARvXvkpU3IwbyslmFn0U1tptLC4KRf+vKEAtpv7N5F1u8IZiPm6b6mg+dzxxJfvrAgUNw46R0IXOKqco6JC6314BOnQ105TJfboAkE2adqUCS2eZ97hWwzrvgLT3wEaXUdJayR70T67N82Evv75lZOLTjSJcc6Ag9V7q9HVITV0IIRoatFk5HyDgBqS9MClAN5J7J5QAJwYnn4wCOu+SLCqAZ2waq1suHHLr08rlvBWATSQIgKBbBUtQ8rOBQ2fElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCrh7hfeGQDP6OdmTnPOISgZrMQF55KFpYTL0VoUqEM=;
 b=H8FGrFVShZjMiUGlAPQdk3DlMJ2eiOFJble/7lJDDYG+HwCYiFP+wtTwdC3qm2GAPFiAAmJVmBLNmWsC5cQAy9ueTFoO9ANSCxFC9Oc3rkZGdJIwevX1N+NwUxXE9QHF5AUlDUy/8jeinqJ4AkMHOpNJdEIS1OJAop7ryNhIpxRnFgdffhmnCCsIKLT2Opam2V/gpQ0P7tfYzqSsejoMq0V4u0V5N4U99sUntGvCcy5DforlUEgEwr4fhuZQVb6R2Te2ZabNdN64libIfzPwBHvR8inbuX28tRhQ/Kp/VwTDkW8WxfPJoGnirOXII8hxyAHEsCVJrq586gGBCuRmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB6519.namprd11.prod.outlook.com (2603:10b6:8:d1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.31; Thu, 14 Sep 2023 15:31:20 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 15:31:20 +0000
Message-ID: <8ff1ddf4-a3b7-2fed-5dfd-041aaaf981d2@intel.com>
Date:   Thu, 14 Sep 2023 08:31:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v3] libnvdimm/of_pmem: Use devm_kstrdup instead of kstrdup
 and check its return value
To:     Chen Ni <nichen@iscas.ac.cn>, <oohall@gmail.com>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <aneesh.kumar@linux.ibm.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20230914070328.2121-1-nichen@iscas.ac.cn>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230914070328.2121-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:a03:80::30) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB6519:EE_
X-MS-Office365-Filtering-Correlation-Id: 402b7360-3c23-480f-7c45-08dbb537a4e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOcWam7SjABLcpUpg0m3OAKDPl8ExxlIU3giXwMVEctnhafvNR4A3HK8Ce0DJuV2U/L2vJL6oeFZdaM4glPJAATG1+uWstqu1jgm2s70PED1ROF8Uak5cw54q8H7dK/fmg4bPcxzXo3p9xo445nSMN76UNamuRzNuj9NW4WXCpoy+pVrYsXJqiVes9XE6d1QvyB/79UF/Deha3b69kEsbTTxGvV8s3mmQn6bWokuM5JvK8W+dSVOGB8IQ5le0eDRE9xtdDWFdxQXJCPLiNHFnxzvJXkx3N34fzBS7hY1aSh2VTzqY8wSTDB9gjHXl3qBEkyE976Mb2rt9/1zjgTxXimyMrawx+qahGcRw8CQNN5EwflU8a84Rfliuh9fBq0WgMcRizYtSEPWdyaQIFyqRmE7/oOUSXLnf//Mywe57fdQbck7cqGCWhrosedDKhhFoaThRRqKUYy+yQ3xfMBTwJqE8A2QHn82Q4gJsfNGu3NOwqba33mF8Qaj9TH3fBVH+jqZwLlivHaJ80Z05m4BXxh/ALIIiPymTnf5flDSJmfdLeXQUzFa8y09qUaodghAcT7RpX+IlAyNfAqFvHjXvu0OLXjMI4zJfUR8G3fYn2Xh4BgPfj5a0AipuTLe6jIMEVJpHIc+yY/A5XMFPyap/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(186009)(451199024)(1800799009)(41300700001)(31686004)(6506007)(6486002)(53546011)(6666004)(38100700002)(26005)(36756003)(86362001)(6512007)(82960400001)(31696002)(2616005)(2906002)(83380400001)(66556008)(4326008)(8936002)(8676002)(478600001)(5660300002)(66946007)(44832011)(66476007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3gwaThodzE4V1l1YXdOUmpUTldtbGQwWmd0UDRMKzJBR0k4dXNKUTlUYU84?=
 =?utf-8?B?bEhjcXplNVJDRkVUMmtPZytIM1pZR2R2RG0rL3RkS0JRLzVESWZxVWl0czlR?=
 =?utf-8?B?R0JpQzIzQy9nWUxpamF3dHVJV1VwYXRBMXFYUzU2eEdUQnRlVk1wZGFhQTJX?=
 =?utf-8?B?VXRQVjE5Q0NLYktFQk5KKzhvRnU3elFQS0pxQUdlSmlianozSkRudEsxdHFz?=
 =?utf-8?B?TC9EOFErRGRlREloTHUzYmhUWWhpMEt2MzFFQnpkZGw0UVY1YldiUGNrUWo0?=
 =?utf-8?B?NDJvRDd5cXdFVGIvU1dIa2FBd2tYUG9NVi9GeFJSdG9yR0ZWaktsSm9EQ1dH?=
 =?utf-8?B?UnVHK08vTWVtVkhTSG9Nc01HYzl6UHdGc1VzakFjQmdKOG1SMDUrM0hQUWNy?=
 =?utf-8?B?dXlGVFhGWDhLb08yUnZWbFJHaGJoa0lCbStSWnpZWU9lWVdDWlJ3L1hQRkFU?=
 =?utf-8?B?c1Nad01vYWtydzRJeE9qWHZYQ0RyaENQNjZTSm55UDlYQmNsTWpQT3ZPMVc2?=
 =?utf-8?B?MEJrVlo0Vk1HdFI0WXRUVnpXYTZhTWFXSHNVMXVLQlFxOVkrSUgxcmV3UXRX?=
 =?utf-8?B?RllaWVJKWDdHTHNtaThidE1XN1BqRStZKytNL25ueGdBNGxZSEZnKzFGTE9G?=
 =?utf-8?B?K2JDRW1CUWJTbFZJRWQ2Wm9hOUNJVUdTblpFNTlWbDBTa0hPSVliVlc4UXdT?=
 =?utf-8?B?VHg3YWdxKzkrWTVYeGhRdjdjUGt1ZFBEMDVicmdselBpckpPRmEwUUJHcFJ4?=
 =?utf-8?B?TVoxQ092WkZOWFNkbVRqeFk3dEhVNmIwRWdUMlN1ckpJNGRtVmg1RUJMRG1y?=
 =?utf-8?B?MmFMcDNEeXpyVnowTFA4RlNvSFlzOU5jdVJtMEc3cDQycnJMMDRCZmEvTEZ3?=
 =?utf-8?B?VE1mVS9SdTBNNmprQThSM1U3Y08wOUpjRGZoOFZKMkNsU25zSi9PTWVlckor?=
 =?utf-8?B?bnh6cHA0U3VSa1pTWW1ZWHVZcFQvUStCOEVvN2dRUEo1SFlHSnV4UDR3OWVo?=
 =?utf-8?B?ZEp0Nml6VkoySWFxUFB2d3BxZ0RzdXlDWUFDb2I0ZzZIMW15WkFjd29IL0d6?=
 =?utf-8?B?b0kvOUhhYThSeGVvc0FHeSs0bnFwYUVGcmkwdVhNODZYZG05T3E2U292YURz?=
 =?utf-8?B?MG1BQ3Qva3l5eDR0akxpb3BFTGF0NGd4bVJXUFZZODBBWldOa2hhL0ovckxR?=
 =?utf-8?B?VWpWN1ZtLzk4MTdFb3ZSb1dHTHRMUzRzZ3BwdWZYNytKOE1WVUhLVnU4aUpM?=
 =?utf-8?B?ckdZVENPamlLU1JMZS9NMlpLdU5FaVlMRlMvYXo0R2p1akFkYXBhbnVmcEha?=
 =?utf-8?B?RGRNcHpsb3VDbXZ1QjVQbzZjUktaZnI5ZGplbkhJNWNINnNadHQ0cXd0czA1?=
 =?utf-8?B?Y3NwTmdYblpoQlhWcEVkRHFHV2FNdDUzNm55WStHZExGWkpacTJ1RFpkdUtZ?=
 =?utf-8?B?YUlHc0hRM2tuWkJKYkgvd3NpUU84MWU4VnBra0VUSGo2NnlzcHowWXFSZVJk?=
 =?utf-8?B?ei85Q1EzR3RnaVZHS0V6SlRsQXo1T2xtN2pML2tGZnZFYkdkWXdCRlgycjF6?=
 =?utf-8?B?a1l2SmVTdmF5dWY1WWxvNmxSbDhZVFFURE1CZWdrUnpxcFZ3N29Qemg1eWlX?=
 =?utf-8?B?djI4MHp2cjNCVFp3bFplRVliaWRYYmozVEFmY1lpSEFPbmpHNzFTR2RpbVd6?=
 =?utf-8?B?ZkpBZC8zZUlWTlVkVUhiS1M3dDBoeVd4c2xpM1hLNTZ5U2NhNzNINWk3YmhT?=
 =?utf-8?B?NmszS0dnVlFZMDdzMlFlY0NJQXp5VC8wcGh2c1l1ZzJmWVZqeitZdTJEY2hr?=
 =?utf-8?B?VTA5T2NUOVZKMTRZSTBUWHE5cW5BR24wNUhSUWVmcGwzUlk0bTFxdVFDL0pN?=
 =?utf-8?B?eGdyZFRhczZzS3VadHVYWkEzYXdQQjc0cVJtbVhTb25VeW04ZUxJUTZPRURW?=
 =?utf-8?B?aWx2aHlhZmRwa3c4V21ybG5HNjc3d2NGMnZZbU5KUGpVZ1VwaG1zTWI3QVAr?=
 =?utf-8?B?MlQwSlRaYlNhWWJiN3dqdHI5WWFzK0lEbEQwSFRkTTc3SWJrZVBmNGcxN3Bn?=
 =?utf-8?B?WFhTOEtVLzRYUDJ5MjFNMGsyL3NMNlpSRnBaRmdQdHFVODJjaHdxWXdRQ2xt?=
 =?utf-8?Q?G6QOoeufOTHyIGxqJ1X2DX4kU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 402b7360-3c23-480f-7c45-08dbb537a4e7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 15:31:20.0023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QV++OSLRMotaF3+TUFCgmcF/W5tgMroSFuVV8F0Dv5LNzg5JVzF2Q+6Xh/gwHHo6nYKrLHLs/4cPlsrYgT8F5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6519
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/23 00:03, Chen Ni wrote:
> Use devm_kstrdup() instead of kstrdup() and check its return value to
> avoid memory leak.
> 
> Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>


Reviewed-by: Dave Jiang <dave.jiang@intel.com>

One unrelated comment below.

> ---
> Changelog:
> 
> v2 -> v3:
> 
> 1. Use devm_kstrdup() instead of kstrdup()
> 
> v1 -> v2:
> 
> 1. Add a fixes tag.
> 2. Update commit message.
> ---
>  drivers/nvdimm/of_pmem.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 1b9f5b8a6167..5765674b36f2 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -30,7 +30,13 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
> +	priv->bus_desc.provider_name = devm_kstrdup(&pdev->dev, pdev->name,
> +							GFP_KERNEL);
> +	if (!priv->bus_desc.provider_name) {
> +		kfree(priv);

I wonder if priv should be allocated with devm_kzalloc() instead to reduce the resource management burden. 

> +		return -ENOMEM;
> +	}
> +
>  	priv->bus_desc.module = THIS_MODULE;
>  	priv->bus_desc.of_node = np;
>  
