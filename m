Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2247CE9F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjJRV3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRV3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:29:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458569B;
        Wed, 18 Oct 2023 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697664546; x=1729200546;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c3vZH+t+Ksy0i3FaLg+mu+1zqhSZWx4eXQQ3WBoffjg=;
  b=JN+6DP89KBKz5CdN57OZEUqc/jUIT9mgGOFHy4Rlw9DAFj7sndcN3hNi
   pCWB2//Hw9NvhvSbo8b5IJpjQ825vJMeqhXZ/s8zakXPH5kphZjmyrlxc
   YKKKpuqb6wyR3iasmnU7Q/Mkc8oiNzfatjlRXd8ZGPT7eFHUyq/kVAR6K
   5x4nuFPK68Z7Po0SNEQI6J9iYVdkacWg/EQzYSGoBrDIAy0jnNK6GV1qe
   0WUTXQHki0YT4B7mPJ90VqG8SmVxEZuKQp5llCjChOAIbRL7JQPo1BiiN
   FVV9y9YfonlnaIakPXHKCTiNtIhtVq1q3r9gWY4B5dXS/CBD7thNDtrcv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="4707590"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="4707590"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 14:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1003957479"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="1003957479"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 14:28:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 14:28:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 14:28:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 14:28:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 14:28:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldWqyEueWkY8GOv3ojrQeGF0xtth9HNUay+davxh1QuesnkATtTn00vs6VFOBpLv2FJ/s5rexllD0YFHyveNwcvJ56WP5Ib16TJLHgz0mArTOTE+10rWfNqcrbMhxzrFFIga2Miomo1NoHj2btjRtarzqsbSktk8m+G6eDu69BJcwsehfRE2u1c3YdUHh+UIMhzr8J7cBfxc0VvECmqJ9tm0/36dJv7Dom0/xbb21Ht7IqZAUL0mgl28ooweoIIXFEo9rOqkN1SwVATqZEdQdnzazqOS9XyGyL9dJaBvsjetWEd7Ow6KcRTh7VTdWPOgZPVTxRQf1UI1VehPT5CH/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcTWbPDOJkybGdaqgKlex/suzyD9GVVNimoJQiR940Q=;
 b=cW+lM0SHs3TzAwJWfX5x9cgIVh2eAM9M8/lWic8VLearPK4uOvnJrbRfR+tNbfYJe9WIM1VRklY2eWxh8wAjujBtI4ak1KfswBEwYa5yRFZjZotuaDmTmzAO3+J/tILHp4874iBM6qOs1Wy2hoz3mTP+96pxn4Z8AWREprjMh0N0+bPDSRJGK31De1BharsVTkfy773hSQwLnng3n7PAvhmROaAnSOZDPo0TyNAQZRzbylag09vR1yzcLxpvL7qpXBgKvHGg+bJ9PZ4hl4XrCwc7+Ou2rTmXsJihIiW+xgOT6Tz/pzWdSzEZy/qk7BCMKxM80hMYLgEtJCg5wzPgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB8298.namprd11.prod.outlook.com (2603:10b6:a03:545::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 21:28:53 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 21:28:53 +0000
Message-ID: <acf0b2db-c254-4537-97d3-14cce1ad4e39@intel.com>
Date:   Wed, 18 Oct 2023 14:28:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] i40e: Align devlink info versions with ice
 driver and add docs
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>
References: <20231018123558.552453-1-ivecera@redhat.com>
Content-Language: en-US
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231018123558.552453-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:907:1::38) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 007632fd-9c45-4ff1-bf19-08dbd0213a42
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+cAGuD5Q7Bn5NkCR/wJwFIEU3ZBGpQm4oZFNoScT5MYgJJVZS/sqlzxnL/WFek4cW/7ky9CW65wfyHYMxF0A55+u3a4jbF26TIz8G7IO36KqqWMJM/XBkv5b4ocuNd1SXGLpZmt6f7YAyFj85RNyS+ms6tirnTfLKLgR2fyUGetIkV5xZzmrySl0NUGznN6G3a6uCPQikkdgpmnyFoNVuVMU2f+g+phPM7xyNRISmglsLGlA7J2+nfeYxdQo3wLlz3dQsqOy8+3yPcN4brrxNBf07WunA+gJm8+TmFS1+nX6WTqeTIDiCr2rUhoRPCmfmooKLGWIb0KTLnJ9hXF/un7xhnzFXRmU4mycWxnHCPimEORMogH3gW5Sg38GTlrJ1+yBcSfig9mjBCtbUY8AyouKsmG0MDEpyDN9Ax8u1ARRqJBSPDBvmk+WbCnCaHJtJ6IXH3/HVv3HAppB2p434YeMwr0WNPoUEECDj1ITnnsdWhBVm8Eyt9SNObQa5MkOvLsDz9Q9SL8M6Y/eIXzQyHGwXRtj2F/8KdZ4T1VCiEdEjuMePCuwEwLusbCsSRafXr5c40DoVeAIm6ikJXT/Qr2GD6sgJl+bfEMA8xt731agEVQwKfUeA0BCt9kb4yV8iYPhQx6WEHPNqsc8I7cwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(54906003)(316002)(66946007)(478600001)(6486002)(66556008)(66476007)(82960400001)(83380400001)(5660300002)(38100700002)(6512007)(53546011)(6506007)(31696002)(36756003)(86362001)(2616005)(26005)(4326008)(7416002)(8936002)(41300700001)(8676002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2krT21tcnRuLy96d3ZlaWVkaXU5cStXaWRsSnd3S0lQMm5tR0o1WDh0YXA1?=
 =?utf-8?B?aDZzSGdmL2hVNGsvMldPQ1RjOC9pMUpYb1RFWVBvS2lKQkt2a0s0Qk0ydnF1?=
 =?utf-8?B?NlpubVYrNkVCWXMyQ2wxNVVFV0xpNmtjb2d4aGtwd0ZhSFowMXJVWDdYQzhI?=
 =?utf-8?B?SXR1WE10SkU5cWpRZTBqWmxUc3NBdC9WOGlsRGU1ei9XalkzVm9xOVgvd2hC?=
 =?utf-8?B?MUs3VGVWNjBCcXk2SFU5VkxmVHNlazg0TkxkQ1dWT2hhMUgxTWZ1OHRnQjU5?=
 =?utf-8?B?L0puZkRvR25GQ0p4M3dNa1gydHJhZitKazJCdTE2VEYzdS9EQWdCellhSi9I?=
 =?utf-8?B?UHpaN1VCY3A5dkJQK2NkWnZxdjZTZWZUOU1Zb2t2UVg4YjI2RnZVZHJrQWZJ?=
 =?utf-8?B?RHZhZXdCaVpmT0VUSDFLWmZldVhBNklYdlE4ZTVIdmE0YjZlNjRIR2hVcThE?=
 =?utf-8?B?NDd6YnRJWnd1N0VHOXcwV2tGU2pPYmNKRm03ZzU3d0FTMFFjU25CREJCQUZN?=
 =?utf-8?B?SmMzbnVOQlJBdFdvUWpVYThsZlZ4bWZqb2NhdERiK1hTWDBUZXFQM0h3bFQ2?=
 =?utf-8?B?aXlwVXFzaWJnbVg1NXNHdDdYaHhIbEsxa2RTeE50aEVORHdZUkc3L0Q1RGJw?=
 =?utf-8?B?eE9vRDM0Nk9XWEd6NVB0ZnlENkV4ZmtPSSt4ckFaVHd5c1cyME9adk5hbXFT?=
 =?utf-8?B?WW9oNlFKd25lc0dZTHVJcDYyMFpHRDlYS3NyTnpGVjM2MklQT1Y0WGVSZjNr?=
 =?utf-8?B?bE50Yy9ZMnpyV3c5Wm1Vdmh0R25XZTRjcVNzc0t6Z0FhRnJCM3pHNnNJMFJV?=
 =?utf-8?B?d3huaDNjWjE3dEFTUFhEcFhPb0tZQm5pUzFtempnYmlrcEd5TFZIakxNNmJB?=
 =?utf-8?B?YjFSSFNVNVdZaWR1TnMzMzY0SFBvSkcxeGNjYW1uS1A5K3hLR2pXWWEwSVV1?=
 =?utf-8?B?NW5BOTU1VEZ3THlUYW1TQVR2czJFSXJwTTduSEMwaVdWTW5lNUxIOFRZOGt0?=
 =?utf-8?B?b29udGtoaDdBWHpDR0d1QXplczhRRkJ4NXlsanRnUCtlb1Q3V0F4Q2srdFRp?=
 =?utf-8?B?dEI0VFZxVE5ucjZzWk9DUWxFcGxITnBjMVFBSm0wZkNNd3hUNWJ3dXNSSHpx?=
 =?utf-8?B?eml5UDVKdlRVeHRyZXhsOXNSZ21EUm9RaXJuRzVqS3p1NmpCOHF2cSt5OHE2?=
 =?utf-8?B?Z3d2aG51OEJoK2x2OVlzRTFtQ1p4cjhONnhncHdnOEowWDFYYWE2SUpyU1FP?=
 =?utf-8?B?K2JzNkhja2hJUm96UWR6L0ErOU5GQmN1UlNReTI3NTlyT2RUVjg5Q3ZXL1JL?=
 =?utf-8?B?cXd0L3o1YlR6bGJ5TjNZT1A4LzFaaGpZZUNpb0Ewb01UdG5QQ2F3bUw5Q1hx?=
 =?utf-8?B?Vk5PM2hHOWtBeVBPRTR3T1o3N3R2czdDMjJ3NkZib2dCZUlZaXhXMkZ4MHhS?=
 =?utf-8?B?blYyT0c5LytJR2FXMWM3b05IeC9NRktMbEFxNUFCbnlMK2Nkb2dmMDBPT3Jv?=
 =?utf-8?B?cHN4RFpnQXdPMXRFbW1YcndadUJ6aDk3a3ZFclJlSnRMVHVQQjZjTGpHMVM2?=
 =?utf-8?B?QWNlU3BiOHZqSEc1TDBvdlR4eFYyRVh3SldNcVdTa0RGT0xZazBIRk9pd2ZT?=
 =?utf-8?B?cjFMeWpQRFoxckpNdkFVdzdhLzBuZ3JDV2toeHd5RE42ZWFHL2YvZUlvK0o5?=
 =?utf-8?B?Rlp6WEg1WkFWanJNZDVHV0tFVFBwT2Qza2Iwb29KK1JzRE9FdWlIRGZodmtk?=
 =?utf-8?B?MEZKcXRXZ1pyNXRhMGt6NEV0bUR0UEJCSmtVRzlpcWUvZTNpdzVSYUIySldO?=
 =?utf-8?B?eW9GSFp4cDJDRGVXTVExaDF1V1JRQXV0eHI5TC84dEVTZFU0dXloRVFmaUhB?=
 =?utf-8?B?dDgxOU9MeWlrZGJLTUZJN1BxYVphOTJubUJYTk1pWHk0d0l0SG5NdXJpcDhy?=
 =?utf-8?B?RjE2b2IydmdDem85SGFnQlgrWEl0TjlESXJhRFcrNmQxN1VaYzRmSXFmQ3N4?=
 =?utf-8?B?eUw4ZGtSbjZnS1IrWGgvMWNxbXFONUc1YW4wVElhaGhId2ducEJFWGZMWlRL?=
 =?utf-8?B?bHhReGZoZUR6Z2FReDhaeXlYem9zZWkvMVJDMHpLNklZK0NkNWtKeUNYUjBW?=
 =?utf-8?B?WkZEbWM2MVpGdFQ3NHBTaitHL2hGRHNaaEJEZURIN0cyTmxlTHZrUjhRV205?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 007632fd-9c45-4ff1-bf19-08dbd0213a42
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:28:53.4354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPAW78Z5HMC5Rq98DeOgzlN9mh6WYmh6h0lXvPb4YhmZ2n3UVcEHXQD9D/2AE25cWsQF737ukiP+2w+0xDPTnUGvE/UygcWcOWrK7Ul+xyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8298
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/2023 5:35 AM, Ivan Vecera wrote:
> Align devlink info versions with ice driver so change 'fw.mgmt'
> version to be 2-digit version [major.minor], add 'fw.mgmt.build'
> that reports mgmt firmware build number and use '"fw.psid.api'
> for NVM format version instead of incorrect '"fw.psid'.
> Additionally add missing i40e devlink documentation.
> 
> Fixes: 5a423552e0d9 ("i40e: Add handler for devlink .info_get")
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

Great, thanks for cleaning this up.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

I'm happy for this to go straight to net-next without queuing in
iwl-next since the relevant i40e series also just merged there last
weekend :)

Thanks,
Jake

>  Documentation/networking/devlink/i40e.rst     | 59 +++++++++++++++++++
>  Documentation/networking/devlink/index.rst    |  1 +
>  .../net/ethernet/intel/i40e/i40e_devlink.c    | 18 +++++-
>  3 files changed, 75 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/networking/devlink/i40e.rst
> 
> diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
> new file mode 100644
> index 000000000000..d3cb5bb5197e
> --- /dev/null
> +++ b/Documentation/networking/devlink/i40e.rst
> @@ -0,0 +1,59 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================
> +i40e devlink support
> +====================
> +
> +This document describes the devlink features implemented by the ``i40e``
> +device driver.
> +
> +Info versions
> +=============
> +
> +The ``i40e`` driver reports the following versions
> +
> +.. list-table:: devlink info versions implemented
> +    :widths: 5 5 5 90
> +
> +    * - Name
> +      - Type
> +      - Example
> +      - Description
> +    * - ``board.id``
> +      - fixed
> +      - K15190-000
> +      - The Product Board Assembly (PBA) identifier of the board.
> +    * - ``fw.mgmt``
> +      - running
> +      - 9.130
> +      - 2-digit version number of the management firmware that controls the
> +        PHY, link, etc.
> +    * - ``fw.mgmt.api``
> +      - running
> +      - 1.15
> +      - 2-digit version number of the API exported over the AdminQ by the
> +        management firmware. Used by the driver to identify what commands
> +        are supported.
> +    * - ``fw.mgmt.build``
> +      - running
> +      - 73618
> +      - Build number of the source for the management firmware.
> +    * - ``fw.undi``
> +      - running
> +      - 1.3429.0
> +      - Version of the Option ROM containing the UEFI driver. The version is
> +        reported in ``major.minor.patch`` format. The major version is
> +        incremented whenever a major breaking change occurs, or when the
> +        minor version would overflow. The minor version is incremented for
> +        non-breaking changes and reset to 1 when the major version is
> +        incremented. The patch version is normally 0 but is incremented when
> +        a fix is delivered as a patch against an older base Option ROM.
> +    * - ``fw.psid.api``
> +      - running
> +      - 9.30
> +      - Version defining the format of the flash contents.
> +    * - ``fw.bundle_id``
> +      - running
> +      - 0x8000e5f3
> +      - Unique identifier of the firmware image file that was loaded onto
> +        the device. Also referred to as the EETRACK identifier of the NVM.
> diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
> index b49749e2b9a6..2b78060aaa58 100644
> --- a/Documentation/networking/devlink/index.rst
> +++ b/Documentation/networking/devlink/index.rst
> @@ -52,6 +52,7 @@ parameters, info versions, and other features it supports.
>     bnxt
>     etas_es58x
>     hns3
> +   i40e
>     ionic
>     ice
>     mlx4
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> index 9168ade8da47..74bc111b4849 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
> @@ -18,8 +18,14 @@ static void i40e_info_fw_mgmt(struct i40e_hw *hw, char *buf, size_t len)
>  {
>  	struct i40e_adminq_info *aq = &hw->aq;
>  
> -	snprintf(buf, len, "%u.%u.%05d",
> -		 aq->fw_maj_ver, aq->fw_min_ver, aq->fw_build);
> +	snprintf(buf, len, "%u.%u", aq->fw_maj_ver, aq->fw_min_ver);
> +}
> +
> +static void i40e_info_fw_mgmt_build(struct i40e_hw *hw, char *buf, size_t len)
> +{
> +	struct i40e_adminq_info *aq = &hw->aq;
> +
> +	snprintf(buf, len, "%05d", aq->fw_build);
>  }
>  
>  static void i40e_info_fw_api(struct i40e_hw *hw, char *buf, size_t len)
> @@ -77,6 +83,12 @@ static int i40e_devlink_info_get(struct devlink *dl,
>  	if (err)
>  		return err;
>  
> +	i40e_info_fw_mgmt_build(hw, buf, sizeof(buf));
> +	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
> +				    "fw.mgmt.build", buf);
> +	if (err)
> +		return err;
> +
>  	i40e_info_fw_api(hw, buf, sizeof(buf));
>  	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
>  				    DEVLINK_INFO_VERSION_GENERIC_FW_MGMT_API,
> @@ -86,7 +98,7 @@ static int i40e_devlink_info_get(struct devlink *dl,
>  
>  	i40e_info_nvm_ver(hw, buf, sizeof(buf));
>  	err = i40e_devlink_info_put(req, I40E_DL_VERSION_RUNNING,
> -				    DEVLINK_INFO_VERSION_GENERIC_FW_PSID, buf);
> +				    "fw.psid.api", buf);
>  	if (err)
>  		return err;
>  
