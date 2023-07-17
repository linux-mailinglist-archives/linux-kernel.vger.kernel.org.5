Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA627568F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjGQQTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjGQQT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:19:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAA1E56
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689610768; x=1721146768;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jjPs/jx1lQpbB9BipQxofH/WIflq1w24RNBVXq5PWp0=;
  b=BgQcvCcApFTW3NEbnGK1VN9niFQGUr3bj+ToccAPDVhWITtO7FaHzdMP
   pZBywUmjX3F5p7nyoTJ20q6kK97yW7u5X5OLbgqn6YH7GoeHw7KJjiPiJ
   j6UBKuaBk9tWLXjGRferu+cVi4sl8he/L+uyqtWi+/804vHcP6aySlV8I
   6VHhG74jEfSyxep27+6S/x8lZSZtFCauZFoHv1a3PD2TjxQRF4EsRneTd
   H8hR86LoZeuiZVYgq4g7J8myz7gwt6iIPhAyjbn23TYVir65eeV00OgVb
   kenFUeOhZIpV4cHkVUekUwnNloic2OcO1G7mhmX+/3xyY2hGmIJYzi9ht
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="346277325"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="346277325"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 09:19:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="788711353"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="788711353"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2023 09:19:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 09:19:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 09:19:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 09:19:18 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 09:19:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpJVQkFGk9YMpWS2u1LarkTOvCS1NeCbYQMCsHxB/eq1seUb5+xrJU87lx7b188Mt34eGj22HxHQS0eKyJr9JQsXxPjoBCiaO5+ibfNP66vnnX2fG7p42YdFHbzNRbeX5fZBFfrleUeFlb5Bghjldsn1r+EjIjWEEvLoqabJNzy75yiT7R3hoTKx92fje0a2isIFL3oDpRMd7KxDqJIA2JIUv7Fe1Z3Io9OO06tDc7VJtz/6wrEDjta+hQvFeB8IEq38+XoqQt/cCiEPOLXaXGS3XUynzXwPpMwDiU1RKHvT7XTBJB4R0be+qWoJ4/Sqn3JSWiYR+4gqfjdWGs7fqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j50xF3zFPeA9JnHkUlqVDDJUyCruWpIMIzkXP7Q2Nr4=;
 b=gOvSI521hP8Wx1lmp11XWJXakDx/q4SFA351n9U9sFAlCVW0LwKvc1gJLh3w4RIp/2tltOde4V3x+cHPDtt9z/6vnI/EmYvDtvmSrITCLNTq7mz6xq9YkSW95OOeBXQZb0G7EUGRC8rKZZYEtmNSnPnQkooEaue8SwPupj/Gd9ElqEGDFm+h63Q2Lc6wmDLpAfDeMavnQUngUZHTmmWABs2TEYNcLCWhCvT2VsddUC9W0mW5o2Sui2ru4+AeaWXWvp7EDfcM12r2jF10HH4VI7V0nck59uyl0XO1/qImyJO6aHYxx9ShwlNj0r544i6UhxlAL7DUytDdXfVx6OWJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB7066.namprd11.prod.outlook.com (2603:10b6:806:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 16:19:16 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:19:16 +0000
Message-ID: <5a854236-0ddf-cecb-a86f-d81bc5fa4f4c@intel.com>
Date:   Mon, 17 Jul 2023 09:19:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] cxl: Fix memory leak bug in alloc_mock_res()
To:     Chenyuan Mi <michenyuan@huawei.com>, <dan.j.williams@intel.com>
CC:     <Jonathan.Cameron@huawei.com>, <rrichter@amd.com>,
        <alison.schofield@intel.com>, <linux-kernel@vger.kernel.org>
References: <20230717041609.1162445-1-michenyuan@huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230717041609.1162445-1-michenyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0045.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::22) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB7066:EE_
X-MS-Office365-Filtering-Correlation-Id: 1051ddbf-3e66-4404-1a06-08db86e190c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p/NdS7eOQjE7iqQ6DY95lFrbrOsMbfdq+nhmErFSLePW+cDVFk+odw/5uHDfQdXtnCKMC4QyiCsW8mZBPOzmfsC4A1u2li9uP69JAHpv6DPIC0YwO54RL0xM1etA+X1WxtSTB7qdPF0MUEdWj5sKmFEKnNo9+toLGGd8+0qIGAJWuDQL945m+LcJB/lI6U2FMKGrZtrPNMeWTipYqsRl2WDgXAisGKfCgq77SdSv9g2i70bi8unL2J8pDqrxs0Z0vTaSqO3K+l/Feo+lnCO89E7n4shdApFiYiJi2I/cTHcVH23vzv10V0yPvLYtPo9SZhoFCbKixBMS/QqGJ/jGN9YHEiIRNN6z3OXLtrwE193EflmgjVq6zHlJwOTmk9mz3D1sl9bJpAzXVZU8pL2GJiKMtVxPD5ArafVP/BHWZsf4A07kSkdjqj8uBsMJ967wmzCb3VhLezQS7+GtmVIyBwBHZdbLLwG4NtCwnK6b9ckHooOu254HzO8ABIR34GcrOhqA0E9wAp8a4xFyvyxSAi5oXYKf96MqEfYkCsDi59W1fy/l1mKeHKAQSTvVaNASrbjCiOhii5tGpRG1bZmo5bFwe59x1+LbTifhA3usA319CttKDfIALi4pIonArOUSCtGQbFT14Ty7Z/73mKoXZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(66556008)(31686004)(316002)(6636002)(66476007)(41300700001)(66946007)(4326008)(2906002)(4744005)(82960400001)(8936002)(478600001)(86362001)(8676002)(31696002)(38100700002)(44832011)(53546011)(186003)(6506007)(26005)(5660300002)(6666004)(36756003)(6512007)(6486002)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGxlQkJ6Y2o2ckllVHNPSytJSGlBOXVyUmFVUXdZVUpNMkdwOGVZMHRiRVlL?=
 =?utf-8?B?ZUVyeFdnR0ZPMFJRQ2txTkh0QXF2NmhxZGZRVjVwK1E0MitpQ2FOWkdaTmFI?=
 =?utf-8?B?QytBV1JJaG5sSFdDQzB2ckhDR0VYdmlnTWhvOWxtYkZmQzdUOTdWQklBeVI3?=
 =?utf-8?B?UEh4TG1SdHJqWGowWW5OUE5QeEI1WkFWaXB3dmJPU1M1WWtTY3ZiNGg2aCth?=
 =?utf-8?B?WWF3aHJpK2xsSVRrd3BBUDVHTXN1ejhFVFEvZy83cEhwQnp2ZFhGbFRlT2o2?=
 =?utf-8?B?a3JzcHN6SDg0V2JRUUVNQnZuYmF1SDd5cXFWT2Rqb0pYQi9tMW1aRklHdlBE?=
 =?utf-8?B?dmhPT1h5U3kxV3hBOUNPbDdIelRIT1RQV0ZGVzdiL1RPaGgzQUZQOWk5YWI4?=
 =?utf-8?B?VWFVSVNZc25VNUdtUWsvQjl4TnlHZTBDd2RMdWhzK2JYMythYzdpNUFDK1dT?=
 =?utf-8?B?TG1HeTRxT2FpRzBMaUt3S2tMK2FCRnB2ZHI2V3p3WWdWVmpRMUVhMWZKUEZU?=
 =?utf-8?B?MUR6bmM0SzdGU01Nbit2QWRtQWp1cVBrWEpaKzBGSkVVckFybDR1NU4wVHhJ?=
 =?utf-8?B?OG5BRzVZS3JUSXU2S0FHa1ZySkt0MmIxSmRIeGNUMVJ4ZXhobkQ1S1Bhb3Jj?=
 =?utf-8?B?OW5qN0xDY2FDY3NxcVVmMU82cU0ydS9WTVAxWlB3RHJlcDd4SUJGdUZ3M1J2?=
 =?utf-8?B?VDE3a1ZHZ2tVRWp0bURoOE9XZG5iRmdVR09iL3lRS01IbktUVTNETnJoME5I?=
 =?utf-8?B?SnpCWTBNalFEbUtwdllvTC9KcHlMNENhU0FaeS9QK1hMb0dQaEVEamJMRXh4?=
 =?utf-8?B?a2thU2NjRVpLeXBiVDB4RktKQU9aUTZQbURnamVuU1BrMkE0NGl1d0xsNlFx?=
 =?utf-8?B?eEQzci91Ukl3TnFZb2wvbGFXcmFhRE5DRFRtalhEZU9sczI4YmZKT04vZXA0?=
 =?utf-8?B?U2JsSEo4T3hsMElUY1BEMmxtcGo2Rmh6NWFKeEZWbGpFK3JZZHQvVk9YaTlm?=
 =?utf-8?B?K3k5UkZRVDVGYnV3b25zdG0vd3dPWWk2UnE3cXhRc2ZBZm42c2Y1ZHVyVTda?=
 =?utf-8?B?Z1RxaWpYR1JlZmgxU3NFc0g0WVF3L21UeWtac1lCcXkyV1VObmppU2Y3NnYz?=
 =?utf-8?B?OW55WnlsRDdTYWZwak9xczgzT1F1UHhOWTRGbzJPclR4MHh5cGxiL2JWbDBE?=
 =?utf-8?B?Rk5FbkRkSE5XL05TSlJmWFY2YzE5RTdDSll5Umd1cDkzQ1NQOC91N3FBY296?=
 =?utf-8?B?My91UGhJNExtb2dOWkRlV1doTEVxZ1pZZkUzbmdTY1pGS3lVSDhmYnJGM1Fm?=
 =?utf-8?B?UkcyalpGNlgvd2dSYkJMYzNIRFplN0FCY0Z0UFViT0NFcDYxR1dSZ0dKRjYw?=
 =?utf-8?B?azhTMXh6VzJMdkExa016L05LSVBaOXh6U3NZcU5UeTZ3cWJvWlBuU3pPV1BH?=
 =?utf-8?B?bFY0WTVTc3pCYWpTT1lFNG5EVWRuQS9waEdPc2p4VWVlM3BwU0VoTkJWWW1p?=
 =?utf-8?B?Q09BYTU2L1Y1eC9ia2JDZ0NiUGRhQUE1T29tdThlVUFqYmxZamxpM0ZqNlFG?=
 =?utf-8?B?WldpYW1WSWdSQjduMjZQUld6cGlNb3RwL1IzUEcvaVYzOWFoZFNoSjA3eU5P?=
 =?utf-8?B?Y0Jyc0k3TjdkOUp0ZHRIK0JxYm9EdndzZDJ1WUkweGpZMFJZekJhRFdEc3d1?=
 =?utf-8?B?TWVGWnBvbjhKN3VLV3QvT2o1UE13UmpmV3ZQQS8rSW81MGt6Z2s1eUhCTUtU?=
 =?utf-8?B?VkpGcTlJNzBaQ2szK3RXdC9KNEtDbTQ1TEZ4akhGVHgvTUo2a2l3UnBlNmR6?=
 =?utf-8?B?aStjcVA4dUJtci9XTTNyaGZlbW5EeTRleDExWFduMDUxcWdwR1NJUTRSeUJU?=
 =?utf-8?B?MHdHRCtrNlkxQVQzY0lxV01PZlFzU3F6TUVYVDRWRmlVVUhFOW9uQXFsV3h2?=
 =?utf-8?B?NG40MzRkUWo2bGtOb1ltTHV2QzJBdHZmREt6eHhkN3hkdkZDa0FkK0NGcy95?=
 =?utf-8?B?YzJ6SThvUzVvdHdhVzc5a0V2b0hQV2ZsRTZLV1dFSnAzMVpLOWVYZXY3VDQx?=
 =?utf-8?B?bWxneHBiNkFIa25DM3RHeStINnJZSDBwbVJQdVRWZUJFTWo5RW4rSXJBNTZy?=
 =?utf-8?Q?GxeKNAkGNSbDFLWN9P9CFnhHo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1051ddbf-3e66-4404-1a06-08db86e190c2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:19:15.9081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKFZtJ+ATo7WuZRRq+KNSxcTrRabdkJBg2Xf3iPg4MOqawojwPCujYC1IQf9+mkHzTBPdxtyf7xUak5AvudbmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7066
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/23 21:16, Chenyuan Mi wrote:
> When gen_pool_alloc_algo() fails, the error handling path
> forgets to free 'res'. It would cause a memory leak bug.
> 
> Fix it by add kfree() in error handling path.
> 
> Signed-off-by: Chenyuan Mi <michenyuan@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   tools/testing/cxl/test/cxl.c |   4 +++-
>   1 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 0e78d8e19895..250ffd147067 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -405,8 +405,10 @@ static struct cxl_mock_res *alloc_mock_res(resource_size_t size, int align)
>   	INIT_LIST_HEAD(&res->list);
>   	phys = gen_pool_alloc_algo(cxl_mock_pool, size,
>   				   gen_pool_first_fit_align, &data);
> -	if (!phys)
> +	if (!phys) {
> +		kfree(res);
>   		return NULL;
> +	}
>   
>   	res->range = (struct range) {
>   		.start = phys,
