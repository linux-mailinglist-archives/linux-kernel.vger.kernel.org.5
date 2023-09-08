Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD457983F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbjIHIZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjIHIZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:25:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB42B173B;
        Fri,  8 Sep 2023 01:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694161534; x=1725697534;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5iI1kUFr66H2Xl769bpHfJqoV0HHceK7olNWX6ByiNo=;
  b=Z8qJdj53e4ypO56ieQoIQ1VhIj4IkQXHgsYHgfxZBQ1EDOwOpq/afhxB
   xYjFbRO9SM/suxfI+CoNLLpMUZcHkfj6MhdyZbJFUMGRDFmmeTBBof5+w
   +rIJ9BYEO0S3egxVDVQj5aacDwFoo0PFGmzWOrhdzTS8nKtBK8BTI5Oif
   PcVtj4GvHtaa+FRBvGyyHC4n2Xlu4lKxaEbKefOCHwG3iSgrvnjMeHwan
   +LgkB87qpoUpIVaoLYQ+Exqh5uQUWS63P3hpNygJqqbheRY6/hkx4jPqx
   vH4DGtNDqHlEJlNdzcITvgJFPfRZKU0kKz2gk2dB8JfE75gDLqnkXDKRG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="441613452"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="441613452"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 01:25:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="916090896"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="916090896"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 01:25:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 01:25:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 01:25:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 01:25:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ6WWrpyJeBs3FX6+1ZNprk68+OWVgbaM0ThqVqIWTex9iY9Of0ywpal+1FhSZT6e99sxYMCbvo0Y1NECZ2jKNbrdBoDf3sct7knyFTe3fR1ZJ9OhH7fWovIMaSpTbu7QYQprhKOcsiuu0bV8/XgY3nXFKh5+zbx4CJ172FQOTSLpbC0E1D0bVnRoEVRq48RgHBSK/KewFm3hPo19wAmj2yOKvMx2/qpV0g6HIGHjTOk+bg0tilgB74vuB3E36/w7ghNQRMy7c1QbPmEdb72gNVAS/iXO6t+HZoBu2dyQ8Ct/S5eZdS5ztLtyTcaFqQMrzfLsPWq4oOKhtwCFDLhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10ShE00yDJQObaAtiIJYfzyHZAJEAlNw1ggtgpkIaQ8=;
 b=k2Fjgq8C53eX9/fuh0SwEPwKmcQSsaoAUhxHQMA1/UmqTr+WHkuRXMefdK79hBW6M/Twkzw0ENznDK3gBIczbd5PSuI8g6WeWOfdXmlbzI+nrFmGuTWgDaEKiOfK2Wg+8eEzuNlUtOKHHgSVfP0qzunpL6mhIJmomL3HmKQGZVPVtcpFhrcsgGEwtuhiuYyCtTtxueFxPZRG9xfOxdB0OFJ5HVpMHgrdom0xhxsiWDAhiVh+qGlh1toModKmgsRd97LCJNM9zQXDNvHGmN8TPecN1NkEElg5BAiPLFaCxRz2J1FF46Up+al34XGBwQ455BE7O5Y7RRJGjNHs+3bQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by IA1PR11MB8098.namprd11.prod.outlook.com (2603:10b6:208:44b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 08:25:26 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 08:25:26 +0000
Message-ID: <542d0b86-eb5d-cca5-3c8c-857976ca5adb@intel.com>
Date:   Fri, 8 Sep 2023 10:25:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1] thermal: Constify the trip argument of the
 .get_trend() zone callback
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
CC:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, <linux-omap@vger.kernel.org>,
        Amit Kucheria <amitk@kernel.org>, Keerthy <j-keerthy@ti.com>
References: <5709115.DvuYhMxLoT@kreacher>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <5709115.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::10) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|IA1PR11MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 54116634-80da-46db-a814-08dbb0452779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBEieutCL4YT+TYi78GYLuohT/VBMfqT4x/LkMZ+T8xLu/FYPMAQYqT1SFba13iKFOPrLN7r4G0SpScOhk2rS5g/WP64vozRiZQ05vviZpH28UvmIkdIiD9RE/YOazFuhznDGZHdqrCi7gsDIFnUzhoOCCE9/4mRJy7rHBc8V0IjyzxuCdsInouePk/tnqIh5apVcaWEGxJ3mlM19zJH0y//dnfGOP+hfWIOrO904/unsJdjiNjqxIwhXcMnbLyD+onEDyisPizz+7G8TKPzP+wH52A2hFac0Eew2OyMMbtT9r1sj4KHMabniQvBXVQox3WamFNw6ZPwc3otHuwzhxXAcmLNDyBNazhs3ea0oI9dY+Enpc1Busv97b1VPsUkEHVdCp5+/Apx03GCh3kgLit8YT5yLNSBg+8iFgZCKT5bZFY6axwi1N89lXHeVCR/z8kvlyCWKm9gxz5HqC+w2c1JVpl6gkE8E1CX0OdhT9Z43APfyMx/VFbbAl2+lXLbdbepfL7pbDfF4KeNGFlsspPJKoimUIZ3vebAAkBINEaXoSlWr/mS2c9d6lv2qOSRrnaZ9lj9BS4dBbV4F7UfA2naA8aym47vRFYXLUWWSvnXikuJvsKgIuzxOIbOUss8HOARy4ojyER/3xcV9PBrtUGD7utT+z+2HVaJEWaz+k96jYNEIipu2mjlDGrAdnyRaFBFTuZxT0/p4G/VuufLOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199024)(1800799009)(186009)(53546011)(31696002)(6486002)(6506007)(6666004)(478600001)(6512007)(83380400001)(2616005)(26005)(2906002)(316002)(8676002)(54906003)(110136005)(66556008)(66946007)(66476007)(41300700001)(5660300002)(8936002)(4326008)(38100700002)(36756003)(86362001)(82960400001)(84970400001)(31686004)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFllRDFIa1YyOGtkMUZGRnFuc0VZTldHUVUraUl2Z29rOXRzeTc1MHQraWgx?=
 =?utf-8?B?cEhUMWRSaE12L2xod3k5aEFBT2l6YUdPWkN1ZEF1OEFDM3o5S2lzRWd4dnlN?=
 =?utf-8?B?UUZZeDErVE5KaFBCUkdvQXlXOGltNUt4dmlzMndRdGc5aW9mYStEbXI4aXZY?=
 =?utf-8?B?UjRjbm5vY2tnb2QwdjRHWDBDM0FEREFTUFI3cGNBWkRjR2FEQ0FiNHZoaVF4?=
 =?utf-8?B?NEFubE1NcUFYZFhKZFRNdnB3clBLem93dmRwTG93dm1OeVp5NXlpc2V2dmVR?=
 =?utf-8?B?M0MwOTJtcDhIYngvbGtmdEtGMExuc3ViQjZySDVrWDR3MmVuSkk1eFp6NUpL?=
 =?utf-8?B?ejFoS1QyZE93N1BqZGEvTENGZGRNMXg1c2FXVUI1aDZLeHpFVDhtdHk5OVVE?=
 =?utf-8?B?aTlpeklLUGR1RG5HbHdQa0Yza3FET0U1KzBlWjFlM1BDSFJDMDZqZGpLZUtX?=
 =?utf-8?B?aGJsZEFaRTNFTVJvTEdMNGlENGYxdVdtcmdTNUcwRmJJUzc4Uk5lWEJReWl6?=
 =?utf-8?B?Z0hDR0thaDlCMkQ2TDVRN0RodEI2eXowLzkvQVpFWG1ZUHk5b20wek5iZVIr?=
 =?utf-8?B?RHMyVmZ0UUJRYnVpQXNvQzNDZ3M3N0FvdkdTYUI0OG5xTEF4TEE3dzNNYXhE?=
 =?utf-8?B?UE5lK0JYeVliV2pPWVRrQ1Bvc0dMNlRCMkpJUEFCQkg3cjdNb1ZOVXF2NG5J?=
 =?utf-8?B?dG9Ec3ZlT0E0QnZmZDZJaDNXMk9iZ2NTdWxUV0hCS0tTSGQwQnRsQUp4NW9U?=
 =?utf-8?B?SjhiMStGM0tsd0d4S0RlejBGbjQ2UFlJVDZhTWtVdmg3ZFZNRFJaeTNVVlc1?=
 =?utf-8?B?Q1FSSHZDRXh4Z3dBS2pHYUxuSmJXVzNWN25aYWI3NTcwbWppeHhaNEtsQkhy?=
 =?utf-8?B?T3BPSkdvM1ZzNzNVN3RoeVJwZyt0eDNKaGxPUWVaSXdSSlJFdlZDREZHMTZo?=
 =?utf-8?B?T1NGcW0rRjdVSDIzeFQ3WjNxd0RIeEV0NjU2Q2VMUWdkVkpYVE9yL3RkSlFl?=
 =?utf-8?B?K3J0ME5ZSWdHRXVnRE1mQWNwRjNsdmpwS05CcUM1YmhmU0V3UThnczBNd2hN?=
 =?utf-8?B?NnZGejhjd2dLMlF5d29DZE04Rm5vdUd0ZllyZHRaSlZXaDRWTmdYQ0xuZ2NE?=
 =?utf-8?B?cDR4aXp5Q1d5VGxqb2doTFJ2bEZCNXFBbkl0emxVL0thNklLR0lxS0Ywam5R?=
 =?utf-8?B?WmVsK1JrR0hrMkV5VDRLVk1KcWppcFNHeDRjQXVPUHhRb2U3T2RjM0l4eGYy?=
 =?utf-8?B?YkhMMTN1aXFxMSs4amVXRE55TDlDUVpoNFpIL1JsaVoxcWI1WVpJbmw3MzBE?=
 =?utf-8?B?LzhNQ0dsaUlxVTRmRFdWUGZSTVFuRUVoSnliSFpzNFJDRDc3MzRNTnZQMjhK?=
 =?utf-8?B?TEd4RDVvamtkdnI2Vk80WWdjM3dWakRZbjk3WVFZSVB3L2hnSkdiOTJ1SjBN?=
 =?utf-8?B?RjA4VUE3dCtsQ0J1NmdHdHRHYisyY0FrTWNaTlYzcFk3S3grd010VDY1VXdm?=
 =?utf-8?B?ZEQxVzlETmx3eVpPT2FjNHB5NkwrS0Z4MkpCL1FqbVBXbVg0STdEYXV2LzQw?=
 =?utf-8?B?QkhSb3hBaUdtL0VnSXlwYkYyLzdiTDQvL0hNOTlnV0IyaStGZUVvZzlhYWhE?=
 =?utf-8?B?aVhrVTlPOGJOMTdkYWxVU0ZhUGxPNGJYM1BtczJnb29zMzlYQnVpWkZzcG5z?=
 =?utf-8?B?T2NrcDQzalFhdHF5VlQ1NnJncWZ5aHBjNUMxRlBzOGxKbkRFb1dSRituVjFa?=
 =?utf-8?B?OTFIL2FXZDcvQkVVdjdZamdnREVpUUEzT0VObktkWmNXWHBYSHlvMmJxRnpj?=
 =?utf-8?B?K2xOUUNYZnBKM0h2M3J3b3IvZDZhQzAwbTlrKytubDdaMnI3bjFUMFQwbXFZ?=
 =?utf-8?B?V1U3VUxBajdmdTNCSy9PWm5UL2JBNnFhMVpuREwrb2w0ZmdZSjUxTTRXeGpx?=
 =?utf-8?B?TTZsYVZmcDJYSjFVU29MaUl4eWIrRzdSSjNRbTIwNFExRFAyM1AvQlRGWWl2?=
 =?utf-8?B?UzYwMk5PcmJNVHVCZGRLbERQd0ZaeUlqemM3UUsrck80Rm1seHRDbzZXTXRr?=
 =?utf-8?B?MXVoWGZFTVRRaUtCSkxOdW9pU1RBQ2pjR25EcjNjZGlEek1ZbytZMEtEV1lS?=
 =?utf-8?B?SUx4UUV4MFNmVkxsanduRk9GSkN3ZEp2SGVhTzVTWUFoWEJjNmMyb0NVYTRs?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54116634-80da-46db-a814-08dbb0452779
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 08:25:26.7285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyfM7tvtI++CfeQ3lvPYxViQGZ5rW3DJshHvKoqJM5oPM9eUJf3w3ixfZ1Z42rzNEd8XChx1cuKNDLNBEuZ3C+1cMGC2u4uFylxOrHbpT8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8098
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2023 8:18 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Add 'const' to the definition of the 'trip' argument of the
> .get_trend() thermal zone callback to indicate that the trip point
> passed to it should not be modified by it and adjust the
> callback functions implementing it, thermal_get_trend() in the
> ACPI thermal driver and __ti_thermal_get_trend(), accordingly.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/thermal.c                             |    2 +-
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |    3 ++-
>  include/linux/thermal.h                            |    4 ++--
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> Index: linux-pm/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ linux-pm/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -110,7 +110,8 @@ static inline int __ti_thermal_get_temp(
>  }
>  
>  static int __ti_thermal_get_trend(struct thermal_zone_device *tz,
> -				  struct thermal_trip *trip, enum thermal_trend *trend)
> +				  const struct thermal_trip *trip,
> +				  enum thermal_trend *trend)
>  {
>  	struct ti_thermal_data *data = thermal_zone_device_priv(tz);
>  	struct ti_bandgap *bgp;
> Index: linux-pm/include/linux/thermal.h
> ===================================================================
> --- linux-pm.orig/include/linux/thermal.h
> +++ linux-pm/include/linux/thermal.h
> @@ -80,8 +80,8 @@ struct thermal_zone_device_ops {
>  	int (*set_trip_hyst) (struct thermal_zone_device *, int, int);
>  	int (*get_crit_temp) (struct thermal_zone_device *, int *);
>  	int (*set_emul_temp) (struct thermal_zone_device *, int);
> -	int (*get_trend) (struct thermal_zone_device *, struct thermal_trip *,
> -			  enum thermal_trend *);
> +	int (*get_trend) (struct thermal_zone_device *,
> +			  const struct thermal_trip *, enum thermal_trend *);
>  	void (*hot)(struct thermal_zone_device *);
>  	void (*critical)(struct thermal_zone_device *);
>  };
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -531,7 +531,7 @@ static int thermal_get_temp(struct therm
>  }
>  
>  static int thermal_get_trend(struct thermal_zone_device *thermal,
> -			     struct thermal_trip *trip,
> +			     const struct thermal_trip *trip,
>  			     enum thermal_trend *trend)
>  {
>  	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
>

Looks good to me,
Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>

>

