Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D827A8D63
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjITT7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjITT6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:58:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFE61B7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 12:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695239913; x=1726775913;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iO6mnWM0b35tAs1irt6VGTJiCTz6p9UbthkNae5P+tM=;
  b=fqVovMnDrbaJBS1LztDma6b+IISQshfLOfNyEEaUYUAwKhAngHz/Te5y
   pwa1crtaYXdHKXw/dLud0v4uedTdpMxx3lv9zwr6GC3mrn+PxWB3pHhUI
   BcWLsqYvkH5skUWT6dOjzZBy+48bmlbYjZS9rij/m/pRdS5ReDgJo0qkW
   qvZ1L3L5Li23jbOf94pR6O1yfWQBcrxM35aQ1qsPF64/ForfPGz00MA1i
   OOv9tpwri/f730KyJNvWcRoW5eqEmVnxadSaCjMHvkZ7mZGeerSJSX/me
   ukUwJQVbxkYpb031y/iz798rw4Ncj5IZWmQw6cXc7zyts8J1IymQsC2Xt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="380238737"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="380238737"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 12:58:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="696457257"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="696457257"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 12:58:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 12:58:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 12:58:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 12:58:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 12:58:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPRoxzeRe6/QF9F08eB2SPnG5bzOvxnNWWhp4NcbhgPIltX9kOaG8uG2PBgbEBE12wxLmYHXRt0ZCdDMlsa5cJukej2IWoMCgRWYbFlq9QPiyX/8DTH4fr1ixynB3djOsPaPYKbk0ZbsGR1yul+IwoTPTy7WOw7sAV8C8KFIPelNy2fyXl7w5UCKmEsXTGs07sgW9st8wZLTSWtVX8DlTt/qOPb7h6pgbkWs4uUuYvjcbQckYNgbS9pmkrRytMBx0Hl5iRFdDSxy/0RXXi97gyqU4+WxNQX9u5LvFUJnzyVB8pplREdZn9B3R5bufP7viFo1xcIOgV8ViSmHBIlDWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT30Mkirgykms2ubtopMuycnwbUZYHYO0Xo7H94CXQI=;
 b=ArziQVwLkkGZIdQ8pi8BxjsmpjrdzxkJdkT1sUYObSBDye9mg8abTih82FJbMFS3PwJ+Ft6p85b9ZaJ6st9kdht9D3D07plnljZ+OFJTgiZpjXlQtryjJTQ8ju35JgvybJq6Ie5cckv9RNcoIWnZZiAd/0K0eZGHSbeUgsBc6k7cKo576y7+ZrkAL/VWzPRyJNXwSaxALBHJHVKq0UhF7zLQK7GgVbcA6ATD2csoFsDIbpkV2x03eNecNuFkcudXdTHICduSmGxejsqGJY3/SpRCSm1FMVFOLwKER1sSUosUyu6XCGWlDVJZHLsnJ5qtewLsvqB2xgCy7SRr4A7LbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by IA1PR11MB6146.namprd11.prod.outlook.com (2603:10b6:208:3ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 19:58:07 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::6d0b:5bc6:8723:593]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::6d0b:5bc6:8723:593%6]) with mapi id 15.20.6792.022; Wed, 20 Sep 2023
 19:58:07 +0000
Date:   Wed, 20 Sep 2023 15:58:01 -0400
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        <linux-kernel@vger.kernel.org>,
        "Tomas Winkler" <tomas.winkler@intel.com>,
        <intel-xe@lists.freedesktop.org>
Subject: Re: [Intel-xe] [PATCH v4 3/4] drm/xe/gsc: add gsc device support
Message-ID: <ZQtOybldQD1g0lMJ@intel.com>
References: <20230920094151.1593505-1-alexander.usyskin@intel.com>
 <20230920094151.1593505-4-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230920094151.1593505-4-alexander.usyskin@intel.com>
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|IA1PR11MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d8c51b-ff1d-4839-7075-08dbba13e8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ufAThrT+YyQuc0XFRZpYqtoQkj7H0AikzsdS+UA+NwlVwfhVzyeA0UKtKl8emUoAI+mcXrUebXiK+ijJ9mn4YZNwbHYUC0P9g3QL4n3bnt2cMQzVk5B49QksVNUINWoltgO3aKfkF60OljN847J2WpYJbuzKMpoQoP5Hvj5N/tHmF93kmVtR+0hS5Tj0N7HHjMTxFkVGwsVdNVAOE/1azHXZt5jPITymtFxl7ZgcsGj2pmrlwiJR6n6/PDKxaj5K0+caQvC39YDIJbJIjWd57gcoT4O65VWgmwRDHJ+MD2NCcMtTcMpCKDLvxpm5tXwO1F2/MMnP+j2oou3rC6Gqnqcg5+LTe89NHfSiReSgs47qWzpsMKNbg1kaWxAeN/08l3nRhH8wEujDU7um9lrxx6uWS5q4uuGmVbbwTPBiRHKm4mpqyKzQ4IuL9bSlWkd3SHFVFovmQgY+6DD2yoPQKbUuiqaCfqmNL4dmAK8QSp+s0IuenMuVbY/KYokxjaRc+QpC9jGDNnXawjaFfqlE2KbXB6imxelLjTFg5V9dXwi/kOFkBnHfWGg1wRRDCKBF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39860400002)(186009)(451199024)(1800799009)(41300700001)(38100700002)(6666004)(6506007)(6636002)(8936002)(316002)(8676002)(4326008)(6862004)(82960400001)(478600001)(6486002)(83380400001)(36756003)(6512007)(2616005)(26005)(66946007)(66556008)(54906003)(66476007)(37006003)(2906002)(30864003)(5660300002)(44832011)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SXN6Sy0yKkDSgvTo2OmIktQF/iegXkObgIDoiQhlAVY4TjpnEe6zXbViVWiK?=
 =?us-ascii?Q?+RYoSFHWmm29oolG7jaHz37ufAnOO3GcwXbl/qzDen+32IuMtKudrjc5KezF?=
 =?us-ascii?Q?/b4XURQTwjAhCiEhdl4oCoezul5XbLadc60/Xvkh7qRPPe6F1CJSs102rcXu?=
 =?us-ascii?Q?1o71+53UFyOXaKPMcCLm1FF/eD4PVVKkhQQOG6biXjqtu2jI3eplrYqNULG7?=
 =?us-ascii?Q?W++7sSQni5jjjTt1vbyEKCP5rlfl+UhQ1V9rEzRwqRmlFR/tEvG8yUCxf1W7?=
 =?us-ascii?Q?E8QS9W24/quZqvPmi6aU5wDBEfXx6ZIoLIxUseFGbWI2L/813WPRGq5x72R6?=
 =?us-ascii?Q?fpQqhfSbcMwEOCpYp3lVcUodbZghQ5Na8DpQoMjzy31o1CiWWtvnelkywpCb?=
 =?us-ascii?Q?lsCr/ziTpQu1OHSz1egfXkhyM38jUpFfLlnfNp0e7twyiqTyX7HKEGAEKin6?=
 =?us-ascii?Q?29uGpJWVjbjwYc/C9vOlmgMtPEgW02E3VoAAEXPVGaHy3IfSBNzjNFdX6wAO?=
 =?us-ascii?Q?Lyd4EVl//ePPpqfN8oov9rKDCrPhavTRcloK0yVLYgs+ddEwLtU9wuJ3WpQ8?=
 =?us-ascii?Q?6abMemxBh2XFpgv1xo31RkCr81HT9S2VkrA6ihFBFNzTbvdpAKUcakp+5VKp?=
 =?us-ascii?Q?h3pTC6WwWLOCNcUr3R+5gRqXIzPeFC1PXzci2b7j3bAho+HNQ+x7x96uXUG0?=
 =?us-ascii?Q?bsXq7xktuzWNZMnPOrfICQ08A2kkzC/rzE/mVMviTDA1dyw3DODcsh9bEJrt?=
 =?us-ascii?Q?yhGQI9KWyPWHPm0fNz+rxvqYfDKwypqYuaX/s7Kt87VNsJq1XkdPcVAsF6D0?=
 =?us-ascii?Q?5DEQEKKxGpihMbuKiwaXUtkm4xG0+cr1mALSzmx/e3HSwzHEJrlJmbaDXPZ5?=
 =?us-ascii?Q?2o5nxOWTM5eGr24uEG1an37lwYd4cC6rN+Cf596g4vk065BGSbp+cL8P6ewy?=
 =?us-ascii?Q?IKzrDx3hcOmnjNClJfkskaILq5c3xm7OIC+RMWMg95iNGPCh/I/l2+NDfY/4?=
 =?us-ascii?Q?gZ7rOmBZcGsC8iFOgIRn5x1TGtloHBygESojynT2YicQ70gCo9fjL+t8ZVoT?=
 =?us-ascii?Q?1G0eHuBwUC1ZjeguxFWZ4yxCRlDTQI1GNVWlC9ZjPNvC6xwqrFUuaiPF6Cur?=
 =?us-ascii?Q?bZXZkuX9RtlDDBtQCtkjXv7Dm2BLNkgVPjPtmT2gDL1ln1I7uIyb8tKofifS?=
 =?us-ascii?Q?hByLniaoHAucVGLDavARjUv47DysadRzWFQ67g8VAjnNLzzJ5eCsaWv+6FG3?=
 =?us-ascii?Q?xosqZAMRzaPEydOfmz6VF0kN9Yw17yr1BwupjmJYTAebK+n2H7pY99j7SkOQ?=
 =?us-ascii?Q?/7yrJ7MQYRLdpDTE3BhB01EfVmyncamcY+6gnnGEBbR9WHz+M2MJ4jVa9d7y?=
 =?us-ascii?Q?bJZQ17Tlp7Zr6O/V8GnWsKuoJnhK8Ogezy4Dde9OlX340+xULIAWA6Fm9/1s?=
 =?us-ascii?Q?vmdRiHKHE9ucE+FxhVvh0sBSOyyBvK66ZczrTCq/+aTLuqdddRrfWxIJVPhu?=
 =?us-ascii?Q?HrTCIcT28CbDi7JfoHvLy+L1avJkCgXevPeQVaB7l29iiXzTo6b8WvBp6DgT?=
 =?us-ascii?Q?/uZ+EOXhQfrri/R5+VMF+jKokmLUDtxxIq+/B6RStXzwu1kHVJK9rTodEGEx?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d8c51b-ff1d-4839-7075-08dbba13e8ba
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 19:58:07.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akR7a9aCCpcNMpRHBPh1/mlwFjAei5yGVCiQVHsSJWrLX0NRDExtIWh7FTmz2gwQSFOvrFQLDhIT1I0aVTkxGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 12:41:50PM +0300, Alexander Usyskin wrote:
> From: Vitaly Lubart <vitaly.lubart@intel.com>
> 
> Create mei-gscfi auxiliary device and configure interrupts
> to be consumed by mei-gsc device driver.
> 
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Thanks for addressing my previous comments.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> ---
>  drivers/gpu/drm/xe/Kconfig           |   1 +
>  drivers/gpu/drm/xe/Makefile          |   1 +
>  drivers/gpu/drm/xe/xe_device.c       |   4 +
>  drivers/gpu/drm/xe/xe_device_types.h |   4 +
>  drivers/gpu/drm/xe/xe_heci_gsc.c     | 222 +++++++++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_heci_gsc.h     |  35 +++++
>  drivers/gpu/drm/xe/xe_irq.c          |  21 ++-
>  7 files changed, 283 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.c
>  create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.h
> 
> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index d57181ff47e6..7df49b12a724 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -37,6 +37,7 @@ config DRM_XE
>  	select DRM_SCHED
>  	select MMU_NOTIFIER
>  	select WANT_DEV_COREDUMP
> +	select AUXILIARY_BUS
>  	help
>  	  Experimental driver for Intel Xe series GPUs
>  
> diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
> index cc95a46b5e4d..379bd977a0a6 100644
> --- a/drivers/gpu/drm/xe/Makefile
> +++ b/drivers/gpu/drm/xe/Makefile
> @@ -73,6 +73,7 @@ xe-y += xe_bb.o \
>  	xe_guc_log.o \
>  	xe_guc_pc.o \
>  	xe_guc_submit.o \
> +	xe_heci_gsc.o \
>  	xe_hw_engine.o \
>  	xe_hw_engine_class_sysfs.o \
>  	xe_hw_fence.o \
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index b6bcb6c3482e..5c32da629baf 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -292,6 +292,8 @@ int xe_device_probe(struct xe_device *xe)
>  			goto err_irq_shutdown;
>  	}
>  
> +	xe_heci_gsc_init(xe);
> +
>  	err = xe_mmio_probe_vram(xe);
>  	if (err)
>  		goto err_irq_shutdown;
> @@ -367,6 +369,8 @@ void xe_device_remove(struct xe_device *xe)
>  
>  	xe_display_fini(xe);
>  
> +	xe_heci_gsc_fini(xe);
> +
>  	xe_irq_shutdown(xe);
>  }
>  
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index 696416afa7d1..3c2315c80ac2 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -13,6 +13,7 @@
>  #include <drm/ttm/ttm_device.h>
>  
>  #include "xe_devcoredump_types.h"
> +#include "xe_heci_gsc.h"
>  #include "xe_gt_types.h"
>  #include "xe_platform_types.h"
>  #include "xe_pmu.h"
> @@ -368,6 +369,9 @@ struct xe_device {
>  	/** @pmu: performance monitoring unit */
>  	struct xe_pmu pmu;
>  
> +	/** @heci_gsc: graphics security controller */
> +	struct xe_heci_gsc heci_gsc;
> +
>  	/* private: */
>  
>  #if IS_ENABLED(CONFIG_DRM_XE_DISPLAY)
> diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.c b/drivers/gpu/drm/xe/xe_heci_gsc.c
> new file mode 100644
> index 000000000000..3328ddca42d0
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_heci_gsc.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright(c) 2023, Intel Corporation. All rights reserved.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/mei_aux.h>
> +#include <linux/pci.h>
> +#include <linux/sizes.h>
> +
> +#include "regs/xe_regs.h"
> +#include "xe_device_types.h"
> +#include "xe_drv.h"
> +#include "xe_heci_gsc.h"
> +#include "xe_platform_types.h"
> +
> +#define GSC_BAR_LENGTH  0x00000FFC
> +
> +static void heci_gsc_irq_mask(struct irq_data *d)
> +{
> +	/* generic irq handling */
> +}
> +
> +static void heci_gsc_irq_unmask(struct irq_data *d)
> +{
> +	/* generic irq handling */
> +}
> +
> +static struct irq_chip heci_gsc_irq_chip = {
> +	.name = "gsc_irq_chip",
> +	.irq_mask = heci_gsc_irq_mask,
> +	.irq_unmask = heci_gsc_irq_unmask,
> +};
> +
> +static int heci_gsc_irq_init(int irq)
> +{
> +	irq_set_chip_and_handler_name(irq, &heci_gsc_irq_chip,
> +				      handle_simple_irq, "heci_gsc_irq_handler");
> +
> +	return irq_set_chip_data(irq, NULL);
> +}
> +
> +/**
> + * struct heci_gsc_def - graphics security controller heci interface definitions
> + *
> + * @name: name of the heci device
> + * @bar: address of the mmio bar
> + * @bar_size: size of the mmio bar
> + * @use_polling: indication of using polling mode for the device
> + * @slow_firmware: indication of whether the device is slow (needs longer timeouts)
> + */
> +struct heci_gsc_def {
> +	const char *name;
> +	unsigned long bar;
> +	size_t bar_size;
> +	bool use_polling;
> +	bool slow_firmware;
> +};
> +
> +/* gsc resources and definitions */
> +static const struct heci_gsc_def heci_gsc_def_dg1 = {
> +	.name = "mei-gscfi",
> +	.bar = DG1_GSC_HECI2_BASE,
> +	.bar_size = GSC_BAR_LENGTH,
> +};
> +
> +static const struct heci_gsc_def heci_gsc_def_dg2 = {
> +	.name = "mei-gscfi",
> +	.bar = DG2_GSC_HECI2_BASE,
> +	.bar_size = GSC_BAR_LENGTH,
> +};
> +
> +static void heci_gsc_release_dev(struct device *dev)
> +{
> +	struct auxiliary_device *aux_dev = to_auxiliary_dev(dev);
> +	struct mei_aux_device *adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
> +
> +	kfree(adev);
> +}
> +
> +void xe_heci_gsc_fini(struct xe_device *xe)
> +{
> +	struct xe_heci_gsc *heci_gsc = &xe->heci_gsc;
> +
> +	if (!HAS_HECI_GSCFI(xe))
> +		return;
> +
> +	if (heci_gsc->adev) {
> +		struct auxiliary_device *aux_dev = &heci_gsc->adev->aux_dev;
> +
> +		auxiliary_device_delete(aux_dev);
> +		auxiliary_device_uninit(aux_dev);
> +		heci_gsc->adev = NULL;
> +	}
> +
> +	if (heci_gsc->irq >= 0)
> +		irq_free_desc(heci_gsc->irq);
> +	heci_gsc->irq = -1;
> +}
> +
> +static int heci_gsc_irq_setup(struct xe_device *xe)
> +{
> +	struct xe_heci_gsc *heci_gsc = &xe->heci_gsc;
> +	int ret;
> +
> +	heci_gsc->irq = irq_alloc_desc(0);
> +	if (heci_gsc->irq < 0) {
> +		drm_err(&xe->drm, "gsc irq error %d\n", heci_gsc->irq);
> +		return heci_gsc->irq;
> +	}
> +
> +	ret = heci_gsc_irq_init(heci_gsc->irq);
> +	if (ret < 0)
> +		drm_err(&xe->drm, "gsc irq init failed %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int heci_gsc_add_device(struct xe_device *xe, const struct heci_gsc_def *def)
> +{
> +	struct xe_heci_gsc *heci_gsc = &xe->heci_gsc;
> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> +	struct auxiliary_device *aux_dev;
> +	struct mei_aux_device *adev;
> +	int ret;
> +
> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		return -ENOMEM;
> +	adev->irq = heci_gsc->irq;
> +	adev->bar.parent = &pdev->resource[0];
> +	adev->bar.start = def->bar + pdev->resource[0].start;
> +	adev->bar.end = adev->bar.start + def->bar_size - 1;
> +	adev->bar.flags = IORESOURCE_MEM;
> +	adev->bar.desc = IORES_DESC_NONE;
> +	adev->slow_firmware = def->slow_firmware;
> +
> +	aux_dev = &adev->aux_dev;
> +	aux_dev->name = def->name;
> +	aux_dev->id = (pci_domain_nr(pdev->bus) << 16) |
> +		      PCI_DEVID(pdev->bus->number, pdev->devfn);
> +	aux_dev->dev.parent = &pdev->dev;
> +	aux_dev->dev.release = heci_gsc_release_dev;
> +
> +	ret = auxiliary_device_init(aux_dev);
> +	if (ret < 0) {
> +		drm_err(&xe->drm, "gsc aux init failed %d\n", ret);
> +		kfree(adev);
> +		return ret;
> +	}
> +
> +	heci_gsc->adev = adev; /* needed by the notifier */
> +	ret = auxiliary_device_add(aux_dev);
> +	if (ret < 0) {
> +		drm_err(&xe->drm, "gsc aux add failed %d\n", ret);
> +		heci_gsc->adev = NULL;
> +
> +		/* adev will be freed with the put_device() and .release sequence */
> +		auxiliary_device_uninit(aux_dev);
> +	}
> +	return ret;
> +}
> +
> +void xe_heci_gsc_init(struct xe_device *xe)
> +{
> +	struct xe_heci_gsc *heci_gsc = &xe->heci_gsc;
> +	const struct heci_gsc_def *def;
> +	int ret;
> +
> +	if (!HAS_HECI_GSCFI(xe))
> +		return;
> +
> +	heci_gsc->irq = -1;
> +
> +	if (xe->info.platform == XE_DG2) {
> +		def = &heci_gsc_def_dg2;
> +	} else if (xe->info.platform == XE_DG1) {
> +		def = &heci_gsc_def_dg1;
> +	} else {
> +		drm_warn_once(&xe->drm, "Unknown platform\n");
> +		return;
> +	}
> +
> +	if (!def->name) {
> +		drm_warn_once(&xe->drm, "HECI is not implemented!\n");
> +		return;
> +	}
> +
> +	if (!def->use_polling) {
> +		ret = heci_gsc_irq_setup(xe);
> +		if (ret)
> +			goto fail;
> +	}
> +
> +	ret = heci_gsc_add_device(xe, def);
> +	if (ret)
> +		goto fail;
> +
> +	return;
> +fail:
> +	xe_heci_gsc_fini(xe);
> +}
> +
> +void xe_heci_gsc_irq_handler(struct xe_device *xe, u32 iir)
> +{
> +	int ret;
> +
> +	if ((iir & GSC_IRQ_INTF(1)) == 0)
> +		return;
> +
> +	if (!HAS_HECI_GSCFI(xe)) {
> +		drm_warn_once(&xe->drm, "GSC irq: not supported");
> +		return;
> +	}
> +
> +	if (xe->heci_gsc.irq < 0)
> +		return;
> +
> +	ret = generic_handle_irq(xe->heci_gsc.irq);
> +	if (ret)
> +		drm_err_ratelimited(&xe->drm, "error handling GSC irq: %d\n", ret);
> +}
> diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.h b/drivers/gpu/drm/xe/xe_heci_gsc.h
> new file mode 100644
> index 000000000000..9db454478fae
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_heci_gsc.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright(c) 2023, Intel Corporation. All rights reserved.
> + */
> +#ifndef __XE_HECI_GSC_DEV_H__
> +#define __XE_HECI_GSC_DEV_H__
> +
> +#include <linux/types.h>
> +
> +struct xe_device;
> +struct mei_aux_device;
> +
> +/*
> + * The HECI1 bit corresponds to bit15 and HECI2 to bit14.
> + * The reason for this is to allow growth for more interfaces in the future.
> + */
> +#define GSC_IRQ_INTF(_x)  BIT(15 - (_x))
> +
> +/**
> + * struct xe_heci_gsc - graphics security controller for xe, HECI interface
> + *
> + * @adev : pointer to mei auxiliary device structure
> + * @irq : irq number
> + *
> + */
> +struct xe_heci_gsc {
> +	struct mei_aux_device *adev;
> +	int irq;
> +};
> +
> +void xe_heci_gsc_init(struct xe_device *xe);
> +void xe_heci_gsc_fini(struct xe_device *xe);
> +void xe_heci_gsc_irq_handler(struct xe_device *xe, u32 iir);
> +
> +#endif /* __XE_HECI_GSC_DEV_H__ */
> diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
> index ccb934f8fa34..ea53d34fd745 100644
> --- a/drivers/gpu/drm/xe/xe_irq.c
> +++ b/drivers/gpu/drm/xe/xe_irq.c
> @@ -142,6 +142,7 @@ void xe_irq_enable_hwe(struct xe_gt *gt)
>  	struct xe_device *xe = gt_to_xe(gt);
>  	u32 ccs_mask, bcs_mask;
>  	u32 irqs, dmask, smask;
> +	u32 gsc_mask;
>  
>  	if (xe_device_uc_enabled(xe)) {
>  		irqs = GT_RENDER_USER_INTERRUPT |
> @@ -191,9 +192,13 @@ void xe_irq_enable_hwe(struct xe_gt *gt)
>  		xe_mmio_write32(gt, VCS2_VCS3_INTR_MASK, ~dmask);
>  		xe_mmio_write32(gt, VECS0_VECS1_INTR_MASK, ~dmask);
>  
> -		if (xe_hw_engine_mask_per_class(gt, XE_ENGINE_CLASS_OTHER)) {
> -			xe_mmio_write32(gt, GUNIT_GSC_INTR_ENABLE, irqs);
> -			xe_mmio_write32(gt, GUNIT_GSC_INTR_MASK, ~irqs);
> +		if (xe_hw_engine_mask_per_class(gt, XE_ENGINE_CLASS_OTHER))
> +			gsc_mask = irqs;
> +		else if (HAS_HECI_GSCFI(xe))
> +			gsc_mask = GSC_IRQ_INTF(1);
> +		if (gsc_mask) {
> +			xe_mmio_write32(gt, GUNIT_GSC_INTR_ENABLE, gsc_mask);
> +			xe_mmio_write32(gt, GUNIT_GSC_INTR_MASK, ~gsc_mask);
>  		}
>  	}
>  }
> @@ -298,6 +303,11 @@ static void gt_irq_handler(struct xe_tile *tile,
>  			instance = INTR_ENGINE_INSTANCE(identity[bit]);
>  			intr_vec = INTR_ENGINE_INTR(identity[bit]);
>  
> +			if (class == XE_ENGINE_CLASS_OTHER && instance == OTHER_GSC_INSTANCE) {
> +				xe_heci_gsc_irq_handler(xe, intr_vec);
> +				continue;
> +			}
> +
>  			engine_gt = pick_engine_gt(tile, class, instance);
>  
>  			hwe = xe_gt_hw_engine(engine_gt, class, instance, false);
> @@ -488,8 +498,9 @@ static void gt_irq_reset(struct xe_tile *tile)
>  	if (ccs_mask & (BIT(2)|BIT(3)))
>  		xe_mmio_write32(mmio,  CCS2_CCS3_INTR_MASK, ~0);
>  
> -	if (tile->media_gt &&
> -	    xe_hw_engine_mask_per_class(tile->media_gt, XE_ENGINE_CLASS_OTHER)) {
> +	if ((tile->media_gt &&
> +	     xe_hw_engine_mask_per_class(tile->media_gt, XE_ENGINE_CLASS_OTHER)) ||
> +	    HAS_HECI_GSCFI(tile_to_xe(tile))) {
>  		xe_mmio_write32(mmio, GUNIT_GSC_INTR_ENABLE, 0);
>  		xe_mmio_write32(mmio, GUNIT_GSC_INTR_MASK, ~0);
>  	}
> -- 
> 2.34.1
> 
