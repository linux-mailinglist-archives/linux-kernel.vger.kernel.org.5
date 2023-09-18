Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06767A4EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjIRQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjIRQ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:28:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7474203
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695054325; x=1726590325;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eTb76sdH+lxbmyI7Zdvw74Tlvb8KwqDw0QMcERmJEG4=;
  b=LywZnh7FdWVkREaScT+uhHaX0HS1jetk0AjITjUGQD+euqnhcx2yDTUb
   mUJBCizrs3IjEkG34VOhpg/AKrykHaV0d4+fy3fcwc9Bq7bdSkNFxDyGP
   Z/50sDltw1zvzOmwdWnqVqOXwSdCLRXenYOtmTw1WiE2SFVCEN7kdH8Lg
   Xf5WuAF1iP9Fe+AsMguwtm2ZCwjRSeXxVPypBqAMZ8uIzN63DeMvhxr17
   +aTYyEVYVysgocznqG5qFemmxp9icg+Tl3D4Ab7IWajyYT2GRlgFdFq1d
   4+IYWiPX58rHtT8Hw9086z2OqMT7gbWmR1TIGFCJ+eVfD6kzqH6yN9A3X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="383528435"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="383528435"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 09:25:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="992793533"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="992793533"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 09:25:24 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 09:25:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 09:25:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 09:25:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfwQwbbayQSFsqX8xMZIt+zTJLy/VpSAtP5saQko0YDTdgAiI26qf4UWRFDgZjCUAcnfFi0ahT/vSXcdxpJXYjxd3JL++/xeiTqVJTgOmZmI2V01dfcvuCZ0B+0+5Gj5KP9qkHcD35fkKfeQcNMPkTpOQlNivj1M7w2aRcGprw6SM3fsFiouVYTvpaoIvCRwKjrALgkT6QxVK40T7VEPktCwxOwY4zeVN0qwpeuSaa/qLjUCqM3qJ7KrfBe9j7QjppQRiGAGNTChNRwujoJV06a75rkwX4nILCHQAjoSlahCZc2IVyyr4RFkO4jYsNFZWHjqQ7Emw8oxC15ZL8sF/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPxlHWlW5tHVVkbGUzMmbQiiPWyahryApxu9XhBf8Ec=;
 b=AI0KMQ1ZzofdVjtZ+d5MAcIz9zQoos85CjwaYhrWkKurd1q6g9m+rKbjU6rD7uz44XN+9LGKriPW1YrFsmX5+kokzy9Eu0PaSAVIKHzcYa6HJxdAYzZqMYX+WHDSu7AFzirbUi4/mFhdj7gnDATlc/pQv340dyyYDGWSe2o2bG5RJMtu8/ZDtpwVAiY/BgIWz/I+mPHqG2m9YmPf5s+E3rFTmS1bXe9M6yG2vlOq/P/YoGt7Ye2RfEG8MHwxWOdsMp6c+csCCQf7kN6n+28yxyvjETVVeCFpXomvwOk8J87DhsYkNE9nnUKCxeiodkRvCx1Dj2wsPzVO5BvhTaQPIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 16:25:19 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::6d0b:5bc6:8723:593]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::6d0b:5bc6:8723:593%6]) with mapi id 15.20.6792.022; Mon, 18 Sep 2023
 16:25:19 +0000
Date:   Mon, 18 Sep 2023 12:25:15 -0400
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        <linux-kernel@vger.kernel.org>,
        "Tomas Winkler" <tomas.winkler@intel.com>,
        <intel-xe@lists.freedesktop.org>
Subject: Re: [Intel-xe] [PATCH v2 3/4] drm/xe/gsc: add gsc device support
Message-ID: <ZQh5628W52y5JkZt@intel.com>
References: <20230914080138.4178295-1-alexander.usyskin@intel.com>
 <20230914080138.4178295-4-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230914080138.4178295-4-alexander.usyskin@intel.com>
X-ClientProxiedBy: BYAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::36) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|CY8PR11MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 541b1ecb-0933-4cf8-35a0-08dbb863d97d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pv41yDlKcP0T7Z3mPBtwTg8YpOxgRDMrkRpKnpwaKuKyHMr1A8QXs1S/iYKP3lycDIuQGXaKsE3+L0bC0apDTqW2Ye3DCTeAPXegIwvgepZ5cVeWiWTj4LlyoFlJMDwBs91KniGO1OhMB0+UMxO7DBAOigc1JUClJRPWPJj7jlk9HFj9xrtVYncyItY7EPzC75Y+1l5owUY3A5z7oUpOnEmf8KfztHkMNv3w9yNBQ//sFAd2GB8XMBbm0HjODU91qFXO2jAzZKV9fCQyq0i3qHHS2CjAaI1Zcxl8yZ9prq9X+5FmYyMi9yTm5zVARM0qe5kSe3y2ECobDSSidWBEql3rNycqPijLTZ/QdeInnmegxtImm5Co8xUC09m8SX/w9AAJgsfrcF5WlJNKxtpCJ6+KebdTC6okSTDjt4/B6COCiSGfF3O1PEO7RpbKfimZv49CUHpn5zqI09wMKM+NXtqPY51pCPu785lYR/62Dc3de0XDZIQy0lP+yK0jIj+qv1YDXxxBTHXordr7PsmQFEEFosWC4HcCqnQOMdIZLa4hWtq/bgdcYVrLB/ciDntC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(4326008)(6862004)(5660300002)(44832011)(6506007)(6486002)(8676002)(8936002)(316002)(41300700001)(6636002)(66946007)(37006003)(54906003)(66476007)(66556008)(478600001)(6666004)(30864003)(2906002)(6512007)(83380400001)(26005)(2616005)(36756003)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+EtnnOHfhZ/aDPIkk2mf5NMJ6wgi/49I5sa5VSVybUX2umqwommluxmEj8n1?=
 =?us-ascii?Q?mfy7/NnTv2ZW2FRmQw12AQlvLGcVXUQdvRhbWpHJPYjDZR0lIsfDkzA+xuW/?=
 =?us-ascii?Q?TVHt66py1PraL3cdms+y2Sw3MOcVhF2OQQHtrfV1FLPHUv5lZSTfJXxjkobk?=
 =?us-ascii?Q?D9omB2vMUcK2NXcLns8O3HSNjnnZ1JALvQVbvQwfNt59seRbJozWOfrws4UZ?=
 =?us-ascii?Q?wuim/NKhl7aKKikAhQQmwU1cqvM6xxUTr1qji31Q957ubIJHsdC35DEYqZMD?=
 =?us-ascii?Q?qUpWgXeVT+t9XHU4dF9Kz3ZuwmCFn97ktAjKTGVz0GjlAO4rHJQWmcv9lou2?=
 =?us-ascii?Q?wNNeDLoGpJ+xz3IUZS8OR3PeukCRfPiM2k6nuqMCRe76StdhfhJ62m3x0zl3?=
 =?us-ascii?Q?cFy9XmnXfpYJeet2FrLrHw0TQGlcgAt/7EI8lPOBLWx8J7ly30IoHX2r/V7+?=
 =?us-ascii?Q?CXxX/l3VWiCFLHXnHRYiHctfhNYEFsR8s5VAlBdBfdO+y7WMx0srHkrG63vG?=
 =?us-ascii?Q?ufvpeQ8dDKpB1w7YhXoGvritQib45mWMJSAxCVMCBQYGM5ZTzU7F3iOZeWPZ?=
 =?us-ascii?Q?8LPek9k9SR1gyQB3hWXR3rl9PODY+/70A8n1ZNjPskrYSxrnO8IAHqfmb3c1?=
 =?us-ascii?Q?ZSmBiw5/LpudJOZqs1oZGkVjngNkvOSEhkX88YL+D7hw/gqFVuTAn7PtFBi9?=
 =?us-ascii?Q?58vaI+xrD/P1AtCf6EF4j+5CvWS+zL6li3JTpTi6UBZ09VScK9hTRIUt9j3N?=
 =?us-ascii?Q?mT97hZGIAuo8Cc+OwBr0g7DdZ8mWgrwiTAhwfIOdT/Bhwc2bl9vBBAePCtZl?=
 =?us-ascii?Q?2Odl+v33NKW5LvsdDM08Vd9xVBw5QZJ8I5koyIJbxIWhLBQGZa7p2/p8F0EM?=
 =?us-ascii?Q?727RMXwHdeYWQXpWn7fPN6p4isiI2lpvksLS/dlvyrKCXyRMvUm/tHw2CTHb?=
 =?us-ascii?Q?NJ3UeIuCAYi3OWXa6Z5fqZMzPCFRyLk6UJUyawOubmioSlY4jySHE1I5DECi?=
 =?us-ascii?Q?z4IwI2iw6bDngx7kSgh5fa+T7Fej94WSgzImhXmQJdYHvF3Q41RveHO9FGsp?=
 =?us-ascii?Q?n4Nt33rLjmnsVEYs8+CvG8D36xC6ehyal8zjWum7CFUwcZDQ5V4iDZGLFiXw?=
 =?us-ascii?Q?ATfJgZNbwU79GMlIGHE26IY0b36sr2T8oO7txxVUR5+Z6aARPbuOl2roU4wb?=
 =?us-ascii?Q?t+L2SlY3fpGG6QqyY0YEmzkG7eESVgiZQdgfoedEKcPve3ULDpjfuhgRK0ym?=
 =?us-ascii?Q?/ZXs96folqSZl2jVWCDUCoc9riWxcaZ9plFwZpl/Wx5al/Zx4sBAXAUe6GV3?=
 =?us-ascii?Q?HwTbhNAvLqkSXT4CDyh0vtw6Bf1aKA/p3joC8oeEPmR8F5HIcBBwotLMNbbb?=
 =?us-ascii?Q?8j7owp0YevQBSVQ4Rc4TgFpNyZpAinfhOWxI0RL3U4tXqCmpZDr9kLvBynUd?=
 =?us-ascii?Q?wiA0oMaQ1N/FHQiPGogm/KQkJ/4g6JC18oNYtfz0p9pMlbHZrgHVYPte56L1?=
 =?us-ascii?Q?/Hsi3NTMByM31P8lDp2A9o4eYJPtgFeU4wrGMtyURqf2Es0ml9eZ0OKdinlF?=
 =?us-ascii?Q?QOjChe5bsNbiDLUDtCuL6fXG3rra4kwh0ZY8FGu3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 541b1ecb-0933-4cf8-35a0-08dbb863d97d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 16:25:19.5575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpzr/SzUzlWgzfqMlJxJk2K4sp4KrKvKTLeFA8V7eHoQJwf6HrQYK3vVCDH4at+0U2Fwy9YNipiihILvILSVUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
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

On Thu, Sep 14, 2023 at 11:01:37AM +0300, Alexander Usyskin wrote:
> From: Vitaly Lubart <vitaly.lubart@intel.com>
> 
> Create mei-gscfi auxiliary device and configure interrupts
> to be consumed by mei-gsc device driver.
> 
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>  drivers/gpu/drm/xe/Kconfig           |   1 +
>  drivers/gpu/drm/xe/Makefile          |   1 +
>  drivers/gpu/drm/xe/xe_device.c       |   4 +
>  drivers/gpu/drm/xe/xe_device_types.h |   4 +
>  drivers/gpu/drm/xe/xe_heci_gsc.c     | 205 +++++++++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_heci_gsc.h     |  35 +++++
>  drivers/gpu/drm/xe/xe_irq.c          |  14 +-
>  7 files changed, 262 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.c
>  create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.h
> 
> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index 096bd066afa8..da82084fe236 100644
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
> index 9d2311f8141f..fbdb28fa5ace 100644
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
> index d6fc06d4c9dc..4d6e2f2b281f 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -323,6 +323,8 @@ int xe_device_probe(struct xe_device *xe)
>  			goto err_irq_shutdown;
>  	}
>  
> +	xe_heci_gsc_init(xe);
> +

could we place this call earlier in the flow? maybe right after setting up mmio?
or maybe after pcode init where we confirmed the boot can proceed on discrete?

>  	err = xe_display_init(xe);
>  	if (err)
>  		goto err_irq_shutdown;
> @@ -365,6 +367,8 @@ void xe_device_remove(struct xe_device *xe)
>  
>  	xe_display_fini(xe);
>  
> +	xe_heci_gsc_fini(xe);
> +
>  	xe_irq_shutdown(xe);
>  }
>  
> diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> index 1d1fe53fc30d..80233c2f0d81 100644
> --- a/drivers/gpu/drm/xe/xe_device_types.h
> +++ b/drivers/gpu/drm/xe/xe_device_types.h
> @@ -13,6 +13,7 @@
>  #include <drm/ttm/ttm_device.h>
>  
>  #include "xe_devcoredump_types.h"
> +#include "xe_heci_gsc.h"
>  #include "xe_gt_types.h"
>  #include "xe_platform_types.h"
>  #include "xe_step_types.h"
> @@ -364,6 +365,9 @@ struct xe_device {
>  	 */
>  	struct task_struct *pm_callback_task;
>  
> +	/** @gsc: graphics security controller */
> +	struct xe_heci_gsc heci_gsc;

documentation doesn't match variable name.

> +
>  	/* private: */
>  
>  #if IS_ENABLED(CONFIG_DRM_XE_DISPLAY)
> diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.c b/drivers/gpu/drm/xe/xe_heci_gsc.c
> new file mode 100644
> index 000000000000..1eca1c46f257
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_heci_gsc.c
> @@ -0,0 +1,205 @@
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

will we need the lmem_size here?

or what's the difference on the mei-gsc and mei-gscfi exactly?

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
> +void xe_heci_gsc_init(struct xe_device *xe)
> +{
> +	struct xe_heci_gsc *heci_gsc = &xe->heci_gsc;
> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> +	struct mei_aux_device *adev;
> +	struct auxiliary_device *aux_dev;
> +	const struct heci_gsc_def *def;
> +	int ret;
> +
> +	if (!HAS_HECI_GSCFI(xe))
> +		return;
> +
> +	heci_gsc->irq = -1;
> +
> +	if (xe->info.platform == XE_DG1) {
> +		def = &heci_gsc_def_dg1;
> +	} else if (xe->info.platform == XE_DG2) {
> +		def = &heci_gsc_def_dg2;

in general it is better to add the most recent on top of the oldest.

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
> +	/* skip irq initialization */
> +	if (def->use_polling)
> +		goto add_device;

what about creating a function
heci_gsc_irq_setup(...)

and then
if (!def->use_polling) {
   ret = heci_gsc_irq_setup(...)
   if (ret)
      goto fail;

> +
> +	heci_gsc->irq = irq_alloc_desc(0);
> +	if (heci_gsc->irq < 0) {
> +		drm_err(&xe->drm, "gsc irq error %d\n", heci_gsc->irq);
> +		goto fail;
> +	}
> +
> +	ret = heci_gsc_irq_init(heci_gsc->irq);
> +	if (ret < 0) {
> +		drm_err(&xe->drm, "gsc irq init failed %d\n", ret);
> +		goto fail;
> +	}
> +
> +add_device:

it looks like this add_device always deserve a dedicated function.

> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		goto fail;
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
> +		goto fail;
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
> +		goto fail;
> +	}
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
> index 1dee3e832eb5..d297e9b8a3be 100644
> --- a/drivers/gpu/drm/xe/xe_irq.c
> +++ b/drivers/gpu/drm/xe/xe_irq.c
> @@ -128,6 +128,7 @@ void xe_irq_enable_hwe(struct xe_gt *gt)
>  	struct xe_device *xe = gt_to_xe(gt);
>  	u32 ccs_mask, bcs_mask;
>  	u32 irqs, dmask, smask;
> +	u32 gsc_mask = GSC_IRQ_INTF(1);
>  
>  	if (xe_device_guc_submission_enabled(xe)) {
>  		irqs = GT_RENDER_USER_INTERRUPT |
> @@ -180,6 +181,9 @@ void xe_irq_enable_hwe(struct xe_gt *gt)
>  		if (xe_hw_engine_mask_per_class(gt, XE_ENGINE_CLASS_OTHER)) {
>  			xe_mmio_write32(gt, GUNIT_GSC_INTR_ENABLE, irqs);
>  			xe_mmio_write32(gt, GUNIT_GSC_INTR_MASK, ~irqs);
> +		} else if (HAS_HECI_GSCFI(xe)) {
> +			xe_mmio_write32(gt, GUNIT_GSC_INTR_ENABLE, gsc_mask);
> +			xe_mmio_write32(gt, GUNIT_GSC_INTR_MASK, ~gsc_mask);

is there any way we could combine this with the upper calls to the same register?
I believe i915 is combining them for instance...

>  		}
>  	}
>  }
> @@ -284,6 +288,11 @@ static void gt_irq_handler(struct xe_tile *tile,
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
> @@ -470,8 +479,9 @@ static void gt_irq_reset(struct xe_tile *tile)
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
