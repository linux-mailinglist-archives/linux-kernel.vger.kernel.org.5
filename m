Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEBF7E0A4E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 21:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378305AbjKCU2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 16:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjKCU2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 16:28:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDDD18B;
        Fri,  3 Nov 2023 13:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699043320; x=1730579320;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ajw/secxOIwiz0sqaOqk6d2idiEvYVKK8HCv0Xpe70I=;
  b=YjP7Q+RAfB0PdC7neq/uw8vNYSjmOY9aBtOrjCuSXQhJDw/MhXR/1gO6
   dn1DR7pbkGySL6OdWbUEaA/PgW4ygoW18lJSsW4itlWaVGas1b+4oXkaa
   1cN07Ch2p9Tc/kVof+HWPJ7c15agKt0NC0S0ieYObg3o2O6/9kOVVvytK
   40+UKjVUfoTwM31KPIRRiD48oVjlAKogFf3d8gAwHloh5G80p0DVV2NMv
   XTPiHreAMN18m3v6tHVDsacpCKl7vCuhyVDFP6LuQKgRemSLdVud6GKTN
   xAqQYTb8/Bl0ptUmfjCvCN2D9fGrGcqSfn/rGuUtm/InF+xX4z7Ifmjed
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="392905832"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="392905832"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:28:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="755263427"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="755263427"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 13:28:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 13:28:35 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 13:28:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 13:28:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 13:28:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f63h9s/YLTT3XEXBQxuIQ01KL2zKV+5R2Z7sL3o/qKtBbIJaun7LRxjTmctgRtjVb3FHbubHsLwvpb573mgZIX8bbKWZrh9q8Fisp8kPpk1R1Q9Uj4x0cazMEq89uz3Y5q/HPAi9NFU2AVLg3wZzHxqSiRfpqweNay9xZMUJvPGk0BU2n3OSOqF5zSlrY6LfbthH7t2ksms6768isAAV/txbdG1UqbNatX1vjG0cMgIfvCM/g9/f8K1WIk1bwv5hxBzNnkNvPRcuRs7FcY3S53Q4olijToZUFiI6OHN0wNRfatPviCvh8RaUP4dLxlSzcRWsNwXurky8Bb4NDHOEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8he2BKmqm1aw+gYnsHOt1hDNgNiyqeWnB+5Lnbpw9g=;
 b=gfZRpXEn3Pgh+mV244Ax2zzpyW31DJqC0mxwgfOphwpdA11kUmvzVZG1vMS+xDGIix7XOk0nRs1YH63UXKjjUXz+r8p4eQN/PSKEQh9N5aZWNw3fE8iTsvfL9Uqtlh+g3bKLRFxGjeflMmFlj+JVxdGzTbnau0Hud5Cir7D+aR2/DmUUamWk+VvRIfhaYMFFOrftZvgRAlP+Hlj7kiqyHiLquM0cVDa+iBrwH6jPi1G/Jta2IqyMgSyI1cVjOfm4cS6M4y0xn+S6oWs0VoVnvxAio453Op0LO7vkooSlcmTPfyFjvIMpp077YmQnrSIEBXnjbEhD9nvyU9Lb9pFQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BN9PR11MB5228.namprd11.prod.outlook.com (2603:10b6:408:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 20:28:33 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e%6]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 20:28:33 +0000
Message-ID: <ad8ba5fe-5078-41a5-921f-4de4c71703e7@intel.com>
Date:   Fri, 3 Nov 2023 13:28:29 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl/region: fix x9 interleave typo
To:     Jim Harris <jim.harris@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20231103201835uscas1p29ca7f76ed5e4c829bfb022a040202d73@uscas1p2.samsung.com>
 <169904271254.204936.8580772404462743630.stgit@ubuntu>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <169904271254.204936.8580772404462743630.stgit@ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::23) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BN9PR11MB5228:EE_
X-MS-Office365-Filtering-Correlation-Id: da0fef57-c206-4882-f962-08dbdcab730e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +arHuAJLMB4CHay08ri+5JHQbKGZIYCwUOkdj78Lfx1jPPrcBZlJecagRDlRBoC4ykA3m48E94UFGQU+6GZBaDyZE6oFKO3Jo0i0cCbM02NR+V9YfDWXsOrUMvYOqJwex0ulK73ivh1y6CSXCdQau9ye0hGzgin7LtUpb9995O8o8MkcGGSmK2+T7IkpDJZZKpOLwBKtmYDqcZS0cCDzaJNrBbOkTYdX36wOq7jNxI8F8m68rM/oEqUp8dpPW6yG4AEO9bYGa8Sji7G2eXWB7yqx5ASRKqAR7A2NM0V1/d5lOSsu+uz3dHTwkjmubm6S2QdqtNEluvPhbLqL1mtBm4cjLk08K5vMXWUv6Ym+bfktz392HLMuvYoXsC1CcZp9JKLVysLbYGPyjXwAbOl6OplMgaXTUV5siDJ7Am5fl3cBehV4TzXTJPXYjSHp76g9AbaN0BwaruRSG/q9AHILxUq72X/ZAni8pFiwFeYRfxkVmydMqbRpct1Lpg+2k0XwV3xLG8KnQ6YeHZ8peisAfSzSDmLptTlpbEAZ6XHqSp+OD0aJSHbskDQh7jE9KPImEMcbIo1JU3fovWvmdRTjPhEd2NqaAnC65kmCj+k2tyyQNx+wiAgNiUfP/et2YmmuAZ5mDOpP7jqQ98OEiGyy4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(31686004)(5660300002)(2906002)(44832011)(8676002)(8936002)(6506007)(66946007)(66476007)(6512007)(2616005)(316002)(110136005)(66556008)(6486002)(478600001)(6666004)(36756003)(26005)(921008)(83380400001)(86362001)(31696002)(82960400001)(38100700002)(53546011)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVoxSnNTMUN3LzlNM1lKblRlVGRRemh0djEzeXVsNGkxRHhMeElDRW90eCtq?=
 =?utf-8?B?QlYrT1c2NDBUcXkwWWFvUm9BaG5OR0pCcVFaTnJuWExEZ2NpOUlweEhTZ0tn?=
 =?utf-8?B?Ykptc0dRMXo2MXNJR3RLTUJ5MVpxSEhWMjFsZkVQakFKNnVvc0hwVml3aDVu?=
 =?utf-8?B?L3dwS3dqeHJpbCtTVEJkaWwxTE56aFRQNVRURFdhUzk1UVFkLy9lMm5YNkcw?=
 =?utf-8?B?d1RPM05kSUJEWENIK1I5aWpjeFBZYzRiR0cxaHNmVVFWUzVjaXFXWDNzelBV?=
 =?utf-8?B?c0N4cHVMK3ZmRjNrZk1rUXZkTXFhWE9UMVRWSVF4OVNyYmQ5eUx3Y1RjR0xl?=
 =?utf-8?B?SGtEVGN6M3EySFd4cVBRU0ZsZ3BlWk9panJzVlFmNlFxYWFUU2VkSFZWZUcr?=
 =?utf-8?B?VWk3bTVacVFwNkNsdmNaeUtjbHAvdGxCUWI4TEtzRkt2a3VvYlBieWluTFN3?=
 =?utf-8?B?ZjY3YlVxWGhIdDhDVDIwTG1xcDhkUEkwb1I4M2ZOeFU0UElQUjJ0WWJkVUNr?=
 =?utf-8?B?clMvYXB6TVJ6K1oxejRHcUNjZFBWSWxkNWJJcitvZkZrVXQrTFl1K1pGN3BD?=
 =?utf-8?B?Zk9teTVkeWE2QVBzRjlLT29rc28rTURwK0paa2pzT0ErSFI3TTlZWVA3NTZP?=
 =?utf-8?B?U2xrYXdDZWk4ZklFZysxRVlnK08rQkZleUUzdEgyamtUREsvbC91b2o1ZXlY?=
 =?utf-8?B?SU1Fbzgxell3MkJtVHMyaTFpS2I4azdKc09IZGhWN0RETTJqTzFzTERVbjFP?=
 =?utf-8?B?OWFNcTRBeWp3aS9MNDRaOXRFamsrUDl5Q3JQVU1MVTB6MFdNSXRJcmNhNEd6?=
 =?utf-8?B?TEZ3K05UYkdvQzFQV1dpeTNJODlPcGVMbVhEdFRYZ1BmZ1E0K3VHTEFxQWdB?=
 =?utf-8?B?VnNPRks2MUxlVHpQVm9YNlBDZ1dYTDdyM2dOQkhzVVBnUlJNUksvOFdXUEZX?=
 =?utf-8?B?RHEyUlk4M3d2b0I2eGZicjU4ODF5b01tV0RCd2ZDemZROWJqTlY2TUQxbzk3?=
 =?utf-8?B?b09GcW40ZGhNT2FwcmpsTkR6Ti8yRTNuWXg5S2VVdU1kS3FHWWJLZDltaS9a?=
 =?utf-8?B?Q25xTkQ0SnROM2tDelBUZDhiSVVoWnVOSTU1YXdhb1BhRmd4ZTg2Zk02YWFn?=
 =?utf-8?B?ZVNsbFhwc1lZbGs5L0dtSG9zZjN4dytRbmNjODZ6M1ordExUR0NUQnZWL000?=
 =?utf-8?B?M2doREN4ZU9LcXNXL3dRS1A3WXNodjZPRU82RVZRbm1uOEhrZ3g4Ulk4UjhK?=
 =?utf-8?B?SHZCMTN2L0FqNHQzNnpsYmxYOEVocWE2WENsa2I1QWozWlcrNGQzZWh3MFhZ?=
 =?utf-8?B?MGNIK3ZaeTA3U2taSW1YME5tYTcxYnZsbUdBZy9pWDM3d3g4YWorUi9qWHJj?=
 =?utf-8?B?UEh5ZkpnTWs4bXFsSVg3ejA2bUY3L3FhMmZaRHlBRmlyVUZDSmV1VUFKc3Ry?=
 =?utf-8?B?WWUzaG5MMXc3WGpNa3NGNjBrcy9zQ0t6cExjN1cxeTFPMkRlUGRrRkJZZHJ5?=
 =?utf-8?B?b0lTdzJuOTNBYUVOU2ZwNnlwWklJS1hzV3k4Y3BQSVJicm5zWUJ3ejB2bmJI?=
 =?utf-8?B?T3lmTVh6UDNOWUNsc3hwZy9Sdnk5L3hBbURmeHVxMFFmNjFaVWZCREVCNTI5?=
 =?utf-8?B?NmcraUU5S0JMTkhzb2FsdzFJTVpoMFZud0pTcUtEektXSHVOV3VlcTBpemx2?=
 =?utf-8?B?TTlSUm5LNG9yTC8rc1VoeitNNEUyU1RzYVYraFBQVUNQek04R1BwVldzWXlN?=
 =?utf-8?B?WE10L0JlbHJFNUFlcjJwK0cyNHRTQzdxRWpuU1dIZ1B6MExkaWFtcEdkeVVZ?=
 =?utf-8?B?b1dJSUFLQ1hSdVluUXdpdUZqQzJ0VTdwT3RkQkZBSDd2TDVUd0xvOEszb0dR?=
 =?utf-8?B?Unh3dFpPWDNwMUMybUREZzRhZXdVT3JScDlJZDlPelljeVV2TXpPbERWUWxo?=
 =?utf-8?B?d0Rwem5IcW44RnUxK0FrbEsxb3dIa1RwRjlXeUwrcU1kNUZidmZjWTRteUpD?=
 =?utf-8?B?SmsvTGlpZEo3cVpxMzJVbXdXUjJoS3ByRzJSNHljUUsrWU1OUjVRdzU1WEtl?=
 =?utf-8?B?WGlrLzgyb3dja2Q0SStrUlY3MVRYQUttNHU5SWhmYkFsQXVCcnlpc1MvaTBF?=
 =?utf-8?Q?SJGJyPaHpFQ01f1lVnpirmGaQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da0fef57-c206-4882-f962-08dbdcab730e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 20:28:33.3526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hn83WLJl2d4xjXNAx+ufqx0z5HE6EIx9K/NIY14Mf/0q2+QG7r034dQXu2Vh4gmrekaesYUxS+nL3gqym1zU4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5228
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/23 13:18, Jim Harris wrote:
> CXL supports x3, x6 and x12 - not x9.
> 
> Fixes: 80d10a6cee050 ("cxl/region: Add interleave geometry attributes")
> Signed-off-by: Jim Harris <jim.harris@samsung.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Given it's a fix to a comment, the fixes tag is probably not necessary since it's not a code bug to backport to stable. 

> ---
>  drivers/cxl/core/region.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d63b8798c29..d295b3488e4a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -403,7 +403,7 @@ static ssize_t interleave_ways_store(struct device *dev,
>  		return rc;
>  
>  	/*
> -	 * Even for x3, x9, and x12 interleaves the region interleave must be a
> +	 * Even for x3, x6, and x12 interleaves the region interleave must be a
>  	 * power of 2 multiple of the host bridge interleave.
>  	 */
>  	if (!is_power_of_2(val / cxld->interleave_ways) ||
> 
