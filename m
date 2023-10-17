Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B437CC9A9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbjJQRSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjJQRSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:18:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E72A4;
        Tue, 17 Oct 2023 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697563080; x=1729099080;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LVWmmf0l0MIaWz5iSwuxt1IOzsO1KyEhyEKQyYVfX/E=;
  b=IBvH5428zZms9V38miaEvoHu2kafgsrY9Di74PkvOXWI1JEBfPSyVWC3
   n7cMRjYNrX7IX+u3cU1NctooQSFSH25IrLqdL40S8VrmfLV+dOiWTZJNe
   OZcOx+X3fqz9lb8Y/afoAknGwCBudfUS9quU1VIlRoqNSpevauIEIMSHu
   5dUvfm/+rUiykzXXoOdF/SSDZNPMlQFsBNSo7M9s3nqMXSI7AEjqO7Cot
   oDqAgQ1RX49IIJFAA9AdCZjrMMysd8gg82n0MzNdqA21aTO7Ft8Mn/YmD
   oDgp9EEGbFcTq4WMFeXb63fXS/pVr0r+iC6DYWqWi012+R1ejQ5lFa2xj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="389706355"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="389706355"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 10:17:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="4009134"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 10:16:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 10:17:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 10:17:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 10:17:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0Le+l9z7ST8/CuFXua4aqoJjhv07VPF5P99rPYX0+19GjTWZyLDPsCPIzrJGSYv+x71I5JRxVEBdowOzfOvikUf4BN6i6WmthpHmOoEUU0dsqMNUohLYWeZxPRmodOMEtlHjDp3cw1yRlYMSpO0fLWNeKTho62k7cySsZMK+XfOvSdL8BnDJ4899iWGKRyWKm4eAdpl6Yd9QW95AM/KKlkptB7tLVs7jGQ7+EOYDhVnH0lFaoSpkZtvRVwaZUSZLLGKs61QJfkvfSOQKa+JZ4RP4doA08hQOlFyPw3J3k4PfgzpUGebwSl0xR1j6WTetJ37pyzpayW2DE/eD5Ym8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejL9GZCsSrbcpEb0dQrP7bUWf54OcbWS3xPTbdZEWag=;
 b=WfkV2JNgRgqAA9NTel2gJvbGiEIJCslSFwyn69OU2i8XjOvdOeSD3tnUeEcrIxkmoY0wvfG3g5lB92kNFi+Ew0bssE9sBFMZESjrDRU1HM3IQFArk135c5WobaW4vYC3zMlPapjLTKPVNdf6WNI1IdaloVN+QVCLQmYNzD6Q1/wW+0RCw1TWF2/E1yFRLJZllB9va3VjMnxegMmcyGns3XCI2Gf+GPqxmK67XFfHOepIi5kQnvoc58LEfmvdTX93EIosFPUPDl52ebfGG/nQPIyiKwTqp7kAIUmcQKGvACrvKFsseB57/Jl/MBtddMETFyWd1DDB3/p5QhHHedOdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 17:17:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 17:17:44 +0000
Message-ID: <93fa7e66-a4fc-47f5-84c8-e26551eb3204@intel.com>
Date:   Tue, 17 Oct 2023 10:17:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] i40e: Add handler for devlink .info_get
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>
References: <20231013170755.2367410-1-ivecera@redhat.com>
 <20231013170755.2367410-4-ivecera@redhat.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231013170755.2367410-4-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:303:85::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 113ade41-996b-4673-9ab6-08dbcf34fa30
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QwWjspXEezcRT6JCJI79z0OUt6IEbRc2i7e1o6SDXR/9tX/3lQLyeA9Lb6XP+o8pO8SB9T5wei5rnt18NSkAs0iBz2qVijgdogkL0/wSKS2lMIQ6FUrjxeqAr3ostk9aqCIDt/Eyxb1C3WwNQrVDJMikfjtddo3csZqeBegfc9KeC9V0LkJ+N357kIucSDLKWAroRQiLFZayPlFOKfQ/d0m72Yims/fXoptkzLAJO2v5V32Wd9+Ina+oNIGgf8JW8v70OSlayeWieb4Wjc/k3iNuG1VQByhwt0AKiX1q00hFeK23M3dYFGhBzD0v+aZfLvnFXEbyFa5TN1m1n3oaB5uYZiK2Eg2P/sEua07DChFJAFbVjDDpzifrAxy9Sp0UVSTZi2W/1IPA7aPbz+ZCRtHV+tCRNhGuHZVG66wzfKC5yps8nbEqwuXusI/s6/2hykKip3FPXjPVOf0HqIiL7eaeYM6VhJSwJAaJ449AWLJkZh6UY4+bszRUoiyxqgIWXs8AYrPJlaKzmDDL8DTKorK9rkwXa6jZGd4Khi4NUeqbzOQ7opPwBjcyOTOG1ExoXZjlsX5L4eZpdvq4+i0DcF6bBVQ7O1Pnh2pXJdtCQ5Mdz+Uc56cAxXzdVacVE4FHgctr3s5gC7ySogmNjNsKKb86Gcf0CZnI/+t3nRQZO/ALLwCRB4+eJuzoawzC2tk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6486002)(478600001)(2616005)(316002)(66946007)(31696002)(66476007)(6506007)(66556008)(54906003)(2906002)(8676002)(4326008)(5660300002)(41300700001)(8936002)(6512007)(86362001)(26005)(83380400001)(38100700002)(36756003)(82960400001)(53546011)(31686004)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEJUbTA1cmZDTWtZUjZ6VC9zSU5YUE90RDNyRG5naGdKdmJzNDB6K1FuTi9U?=
 =?utf-8?B?TlNEd1lpclY1a1p2OVlFaGF4ODQwdzhXRnEyQWIwQTh3b2JFam83YWxrNERU?=
 =?utf-8?B?NmF2aGZzaU4yd25KcVIzeG12VlpnZ0VDeWFLMnU2bERYcU5DSnQyMkEzeUs3?=
 =?utf-8?B?RnpWK2krbzgxUkUvMjNIYk1sNUZmblZOdFdGNFRZbFArTjVEQjAyQm12c29T?=
 =?utf-8?B?ZnorRlllRHc2akR4RUZhdzZpSTByYU1IUURmWkRvZW9iaUJ1M2NsayttTXNP?=
 =?utf-8?B?d3ZsSGxhdDlwL2xhNzJXMG53UGdYS29PNzREZXdVZjRjMzI3aFY2ckFaTGZ1?=
 =?utf-8?B?aVpuZEpiSlIzUTMxbnBWRFJodndrMWJUMXlLdEhkZVYvMXM4b1EzWTdmeUVS?=
 =?utf-8?B?bGVvY2dhbyttUGFIa0hEL1ZrYTJrZmhxT2RCZUhlL3MxUEtoQzYwL3hqcVZm?=
 =?utf-8?B?bUhNVmFLWjJHUTZIVUw3RU1KSUxlMm9adHo2OS80THBubzFWdm1ramcyOVIy?=
 =?utf-8?B?aEJldnBtcURZSjhHMDJyY3VjS0pKWXFIb0JIQVNVVnJOTWZoMk10emM0cDlN?=
 =?utf-8?B?SkhXVWZVR08wcUVRSGhnM2JGS3RxeTBtemk1M0xHRzg0aTc0THZyVzhTQlRt?=
 =?utf-8?B?MWxmaVlsOHBpWVFGZjZhUzN4WmxYTW1RakhmWU5RSTNUdk4xTjNiYnVMMHh2?=
 =?utf-8?B?OHR3TTUyQ0ZhOHNibUlkT3pQQlNyTU43aWMrbXptRTJLTU56RVBHd3lIdnI1?=
 =?utf-8?B?b1NzSkNQM25hVHk5MjhQZWJzUy9zTS9zMXdXTWVHY2ZqMk1yeTR0SFJzeE1C?=
 =?utf-8?B?eDRUWllFSTZ5NS9pOFVXNFpSTHJCN0FIOUJzbmRpSVVhRTNoMHNRc2ptSjZW?=
 =?utf-8?B?clpvWnEyWTZQQ1VmbUtBUXZFTTNMUFJPcmFQQkZTVEEwNHcvMG5hamZjWDBB?=
 =?utf-8?B?MDhYRVdJVFpvd3RwbWNwZjJYcGlYZURuSTQrRWd3R3pxa1k1VXpta0tUcnkr?=
 =?utf-8?B?NGxxY0dBRTY1Zi8zeFc2d0RzR2h6ZVc3cVdKK205ZUh1VEZhQW5yWXl4L0N6?=
 =?utf-8?B?MEhDTTRQVVBPcFBCdGxuZWNRcGsvVWNNQi9UQUZxVUFwZ0VzaUNFOTVLOTlk?=
 =?utf-8?B?Y0tCSDBIaEJwbm43SDlCQ0dlSjRCV0FOTnQ3VUU0SGF0Tk1ldDZoK0Qwb1kr?=
 =?utf-8?B?c2t6NStVTHNOQnBqSExMOE5ka09iUDQ2TUpmT0NvZ0o3WnhOeTQwTHN2MnNW?=
 =?utf-8?B?ZVlnZkptQlJnNlZVcXBQZ2R6eXBNeWFKcGIyejBNTEpnSEJnL3dLdDYzYnNj?=
 =?utf-8?B?R0d5ZmNPVWoxK2xLUUNDTWxMZlVWcklnYkQxTTdIUVpUYmZPbVBCbmdqcU9p?=
 =?utf-8?B?cHhqQ1Q4OXhXbmloMVBmREdkanNreTc2UENhSFl5dVRvWU9LL1BmbmI3Rmd1?=
 =?utf-8?B?UG95WGE0MjNRQWxQVFd0NUJhSm1qbFIzNzJHNExFSGxFTlhVc2UwVm9hR0ly?=
 =?utf-8?B?a1N0dCtMSkMwOTh2SFp2a2NuQVpnWHlIekd1S2Fta2RUZDJDU2lST2RMUTFm?=
 =?utf-8?B?bE9GaklTTmFjbmlnTWJ6TlNrdjZqcmh1Y1E4dmxnYWM0Tm1ldGJRaFBiM1d0?=
 =?utf-8?B?ejZkQU9aeXF6TytmTGRxTDZaL0xBamI5UG1pdVF0VFlPcmNuMFhVY1pzM2FZ?=
 =?utf-8?B?eUNiN21iVit6VFBFYVM5MmFPdG5nMS9WWkVZcWpOcVZHaW5SMUpjbWhWNkMw?=
 =?utf-8?B?K3M2TmNpQ3ptR3UvV2Zzd2NJMXA0WUY3WTlnZFVxbDJHb255T1d2SDRkUndz?=
 =?utf-8?B?OEkyRmtUVjh0YzlIMXpkS1d1L1JhZ3VKa3RpQlNlTGx5YnFZSU9jazVEcVNV?=
 =?utf-8?B?ME12MjZFNDdjRE5WSm80bU9oSFlrN3I4RHducHJzS3dOemJ6aWRtTlp3UkNn?=
 =?utf-8?B?OEsydXpBMmtkeVVpaUFtanZyWUJXR1JvbkVLdWFTUEdIUk9ZM3FIaU5NODZk?=
 =?utf-8?B?bVFnb3dxNFZhVzZLYVFzK1duaGFWdllTQm93RGEzU21uWjdzbWVCejN6TEg2?=
 =?utf-8?B?TTNOQ3JIWFNyR2l4eVRWQU1mdXNYcHRmeGlpak5NazAyVU9NMDRhZ1R2Z1lI?=
 =?utf-8?B?eTZDYVdobWlXaHh3M2VWTFNLRFdHdzVHVnN5ZWdXaXMvOGtJbmJRSlZzQjZK?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 113ade41-996b-4673-9ab6-08dbcf34fa30
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 17:17:44.6774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGS9HbgFo8z5PyIC3YHiKPsJq1Sb1TMk9Wor0JaK3fmINuC8M2sXl429rfzAg31zVCd72zNBM2rXr73cZeFgy+Cxg4GpM/BGlCLWtj5E2+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5902
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2023 10:07 AM, Ivan Vecera wrote:
> Provide devlink .info_get callback to allow the driver to report
> detailed version information. The following info is reported:
> 
>  "serial_number" -> The PCI DSN of the adapter
>  "fw.mgmt" -> The version of the firmware
>  "fw.mgmt.api" -> The API version of interface exposed over the AdminQ
>  "fw.psid" -> The version of the NVM image
>  "fw.bundle_id" -> Unique identifier for the combined flash image
>  "fw.undi" -> The combo image version
> 
> With this, 'devlink dev info' provides at least the same amount
> information as is reported by ETHTOOL_GDRVINFO:
> 
> $ ethtool -i enp2s0f0 | egrep '(driver|firmware)'
> driver: i40e
> firmware-version: 9.30 0x8000e5f3 1.3429.0
> 
> $ devlink dev info pci/0000:02:00.0
> pci/0000:02:00.0:
>   driver i40e
>   serial_number c0-de-b7-ff-ff-ef-ec-3c
>   versions:
>       running:
>         fw.mgmt 9.130.73618

The ice driver used fw.mgmt.build for the fw_build value, rather than
combining it into the fw.mgmt value.

>         fw.mgmt.api 1.15
>         fw.psid 9.30

As discussed in the other thread, ice used fw.psid.api

>         fw.bundle_id 0x8000e5f3
>         fw.undi 1.3429.0
> 

Does i40e have a netlist? The ice driver reports netlist versions as
well. It also reports the DDP version information, but I don't think
i40e supports that either if I recall..

> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_devlink.c    | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> index 66b7f5be45ae..fb6144d74c98 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> @@ -5,7 +5,97 @@
>  #include "i40e.h"
>  #include "i40e_devlink.h"
>  
> +static void i40e_info_get_dsn(struct i40e_pf *pf, char *buf, size_t len)
> +{
> +	u8 dsn[8];
> +
> +	put_unaligned_be64(pci_get_dsn(pf->pdev), dsn);
> +
> +	snprintf(buf, len, "%8phD", dsn);
> +}
> +
> +static void i40e_info_fw_mgmt(struct i40e_hw *hw, char *buf, size_t len)
> +{
> +	struct i40e_adminq_info *aq = &hw->aq;
> +
> +	snprintf(buf, len, "%u.%u.%05d",
> +		 aq->fw_maj_ver, aq->fw_min_ver, aq->fw_build);
> +}
> +
> +static void i40e_info_fw_api(struct i40e_hw *hw, char *buf, size_t len)
> +{
> +	struct i40e_adminq_info *aq = &hw->aq;
> +
> +	snprintf(buf, len, "%u.%u", aq->api_maj_ver, aq->api_min_ver);
> +}
> +
> +enum i40e_devlink_version_type {
> +	I40E_DL_VERSION_RUNNING,
> +};
> +
> +static int i40e_devlink_info_put(struct devlink_info_req *req,
> +				 enum i40e_devlink_version_type type,
> +				 const char *key, const char *value)
> +{
> +	if (!strlen(value))
> +		return 0;
> +
> +	switch (type) {
> +	case I40E_DL_VERSION_RUNNING:
> +		return devlink_info_version_running_put(req, key, value);
> +	}
> +	return 0;
> +}
> +
> +static int i40e_devlink_info_get(struct devlink *dl,
> +				 struct devlink_info_req *req,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct i40e_pf *pf = devlink_priv(dl);
> +	struct i40e_hw *hw = &pf->hw;
> +	char buf[32];
> +	int err;
> +
> +	i40e_info_get_dsn(pf, buf, sizeof(buf));
> +	err = devlink_info_serial_number_put(req, buf);
> +	if (err)
> +		return err;
> +
> +	i40e_info_fw_mgmt(hw, buf, sizeof(buf));
> +	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
> +				    DEVLINK_INFO_VERSION_GENERIC_FW_MGMT, buf);
> +	if (err)
> +		return err;
> +
> +	i40e_info_fw_api(hw, buf, sizeof(buf));
> +	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
> +				    DEVLINK_INFO_VERSION_GENERIC_FW_MGMT_API,
> +				    buf);
> +	if (err)
> +		return err;
> +
> +	i40e_info_nvm_ver(hw, buf, sizeof(buf));
> +	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
> +				    DEVLINK_INFO_VERSION_GENERIC_FW_PSID, buf);
> +	if (err)
> +		return err;
> +
> +	i40e_info_eetrack(hw, buf, sizeof(buf));
> +	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
> +				    DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID,
> +				    buf);
> +	if (err)
> +		return err;
> +
> +	i40e_info_civd_ver(hw, buf, sizeof(buf));
> +	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
> +				    DEVLINK_INFO_VERSION_GENERIC_FW_UNDI, buf);
> +
> +	return err;
> +}

The ice driver created a struct list and loop flow to iterate this. I'm
wondering if it could make sense to extract that logic into devlink
core, so that drivers just need to implement a map between version names
and functions which extract the name.

It seems like it would be straight forward to implement with a setup,
the list mapping info names to version getters, and a teardown.

Hmm...

> +
>  static const struct devlink_ops i40e_devlink_ops = {
> +	.info_get = i40e_devlink_info_get,
>  };
>  
>  /**
