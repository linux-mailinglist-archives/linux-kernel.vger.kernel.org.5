Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CD78068D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377012AbjLFHoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbjLFHnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:43:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908652109
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701848580; x=1733384580;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=//J/VlPn9IqWmS9nbhJL674UCO5o1Fkkf2RckL87GYI=;
  b=PlilQYcX3Fy8tqZ/EpZKBPtWhZVkvdLo1SIlZ6FoWb61MT0PQxoFfDwj
   IPbML28137P7BhvHpAoIxRlQiRkh/tnXljz71G/eD5wAb9gHKbMZSEXl0
   s8hbW+PON91pgF+NKL+vpU1msH6p9EKy+mYqP1jKoVOx3eIvNeA4LEtVm
   uEgWhNxEY5Az039SVIpc+RAgZ/DpTA5WEigNP9z43vVjIj3xUbEOjGeLi
   cHRDcWl5OtdJxNDI/vGzCjCj7glHYlX+4qXBH7UD6v08YBw7ZHymg2FWx
   hRu4D248DDNRnrZXFJ+XdoBfd2yb20Kl6+lzX0QyFpr7uJSkPpBNdUbGL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="393750853"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="393750853"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 23:42:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="747512088"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="747512088"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 23:42:24 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 23:42:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 23:42:23 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 23:42:23 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Dec 2023 23:42:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RA6OoqBTcs9SAqyDULpaRlp6RAG9dgK843ljxPlxU5gyTCDzPmIbrFMFvyXXgKAVhQOwqLcZlBFzfx+GO3Ewv07KvhNXBwESv6OutbnPtbNo1rOUxgh2ufkwkZ8upmNBX/kwa+hAEt9yVrY6Cvt/S5nC+QQGiI1wdmo0NYKvfSAgEELXechgKTFsbKgkMmNX5bDe5qUQmayMV04kCKOCYi2Ao4wt0WQdXcl2d8cjUzLSHg5G7IvgLD72Wf81dTzKEgYUFgCqUEwHx5AyCFsnir7AmJ4k+jf+vnvYvOPpatw+oGV5UZH53Wq5vyQOQHA1zUqDujqvcLP0audG1o8T3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEzzKAZOQ3h/uEf2vE2kCfQmEuiUi7nSFb85WdQAha8=;
 b=LhR7uw3A4KVS6Jr4DK/IZd5QdsZwlfmHHvjNzHG/G4swpp6FMHW/kUg6svts1hwBHEV8P1Ye/Fu3cQO+/02CRGAXg3n9mK99lEC5+smmSRyS8/icsfdrNm6+hh41LDo+Ta99Xj3SV1HwfBpEr++NflDnqCUCipoSVugngX6B2PhguUsaZijR2OGcJ9mNuCQXu+d34MD5nuv7FBZ2UZ1IIAEIm3yWQIVZ3GwBC++6PdAgoOmdE04LDJX3TihZLLyGNSZZDM+l0MBvtnjRGDC5rhlArecFLxTP2uOLPdiR6U/Udjba2PmgdQyz80r8vrHTLhhlVQodzA2kJA07V2RC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by SN7PR11MB6923.namprd11.prod.outlook.com (2603:10b6:806:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 07:42:20 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::bd0:9132:5b54:a118]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::bd0:9132:5b54:a118%7]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 07:42:20 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Wu, Wentong" <wentong.wu@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "krzk@kernel.org" <krzk@kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] mei: Add MEI hardware support for IVSC device
Thread-Topic: [PATCH v2 2/2] mei: Add MEI hardware support for IVSC device
Thread-Index: AQHaJkyzhLCeFdyIB0+sohFfrjvC5LCb4rdw
Date:   Wed, 6 Dec 2023 07:42:20 +0000
Message-ID: <MN2PR11MB4093A745EC3C1605E6B66B81E584A@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <1701651344-20723-1-git-send-email-wentong.wu@intel.com>
 <1701651344-20723-3-git-send-email-wentong.wu@intel.com>
In-Reply-To: <1701651344-20723-3-git-send-email-wentong.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|SN7PR11MB6923:EE_
x-ms-office365-filtering-correlation-id: 81de6aa7-0b6a-4178-d543-08dbf62ee0ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TnL0NlmdkDMWG57ufbrtDRDgRMg7fn5LAlSnvqJIEBz7p4IaZCLxhV+j0ydz6AKo6EWzTW9FERvLrxcUMrEbSXBCMXNYEA62QzXmkwj/xSSYwCX73ZkejborOYMewBMfcPbuNO1J/bevDU8cwV12vMSVtrUanyMMz8hs96fyI2j35tU3zeRzkAUP2TgvASTPmg31+AZ9WUy1ytXqeTEMl0oFezIfwBTncbstYTSRvEbRQnH+xMQ13j6OLx4ucNLgVNFKiTkNvTckbEzxHr2xAL2esPcl13LSinQ+1dlPLaIA/H/xoeQH1rXq46dQkYZpmSAFs0PW7nit9/9rvNOgbpbDDW4BECjxeXQ7hbLJKLvEAN+DWJReQycQyNF0JGeA9kU+xTrJUWI/iiQZsrZfJ1pjmUFSCjdGu/1b0uGyDeTuTndU4hq+8KdPp+fDsmhT/xB18R89zmqEqqENGru2pVtDSgTsEdKnV8zmtq9+0iyWIZEQhIegLekANUNm3Y+LPCG4UAdYiGvmlC/5AOq1KS2Q8cXtWmbouWVfYg2wNgpeP3/o+jQnO0uXyVT8BuBXbh8dG702vso1jLmaVxLrnGNqmqbD0WMeFRRAqo9AMRafYnqSLatPtyhBLdfmd5aF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(52536014)(122000001)(41300700001)(86362001)(55016003)(33656002)(26005)(83380400001)(82960400001)(38070700009)(9686003)(4326008)(71200400001)(66946007)(2906002)(8936002)(6506007)(7696005)(8676002)(30864003)(478600001)(5660300002)(110136005)(66556008)(66446008)(66476007)(64756008)(54906003)(316002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?16bCzB+6txsUhA2AHZLZVFLvfaGDTzYseD3n3GijP8/vNZzfAB4RrlMjrk6g?=
 =?us-ascii?Q?IHsdiSmZJdb45OLFK/C5GqfIwQ9afPsH/K97t6Yjd0t9SpzFsmyuvrKB8afL?=
 =?us-ascii?Q?jl43NidbswmfBB9YnUef/99cOG1pACGjf1zwFr/5EMl4KGvJ1e3kM9V2ilUH?=
 =?us-ascii?Q?rZ5+xznsB+rE0vlhBXvC3uE4P4mHb8ldDeWr5mNpYCm5zHFfI0n8xI5dc/L9?=
 =?us-ascii?Q?9LmyoU7NRPu1W8o1uuh1oNDSxFu0wb8+AzbRWf1oSeehx3u5E8iZixxK0tP0?=
 =?us-ascii?Q?KAmuNyGiWU9IP/YZCrxRreDARVsRDVrhs1/nCZUzNnhTARe3ZzZcTxmOz+/F?=
 =?us-ascii?Q?120Q1ykSsxYh1IDCL+dEBqXNzU81sxO0alH5uepXQxSpfOTLuTJKsR0JBIJV?=
 =?us-ascii?Q?ucNa34xFznYTwsC1qYiDrnXBTjQ+D4oHdZ8Yb2209MXWTQ/a+PBopuJJ0dTP?=
 =?us-ascii?Q?E4zUeSfbZDrLRwDoK5zJPljE03H9ZTDPgJBYCaso8hWv1+aMLttAAU9Ni4H9?=
 =?us-ascii?Q?1Xyr5Y66qyHyqdXWAx2cOSh3UWfHNRWNm+de3UJwk0rZ4sEG/IVk5rzmbCg/?=
 =?us-ascii?Q?ELHhyD0//MbpKdNailSETtdn22n3oYFPqvZGgI9V+MsiY6eNtoykzHChtDdP?=
 =?us-ascii?Q?cDc2FjAhCSepfFJvU2VkZePcHJmcAwI/vWcE4WG7GqjfSDybU4V4BdR0cUf1?=
 =?us-ascii?Q?CLSupaaXafVV6D5m6TigsqplfBIVaX085sCiynN70F42vydfzkcc/3dKA5a0?=
 =?us-ascii?Q?8jkY1RNL3k5ISJxQRBfx1qFQ9DdTQOf7eHqEhI4Vy3/uuKmy28Cz6yMAO8lN?=
 =?us-ascii?Q?xnvHvg7aArizHS9wmwvH8PmQg5yeE7qVxbYQrXFwPPdyWOA9jAHuuVGGSiGB?=
 =?us-ascii?Q?C4kpvoF0rNkhFMYHQsc/jvJ1vqQWtPAe73BnwxmjCPeETocTgPkRHzbCxNde?=
 =?us-ascii?Q?w6AdYtYDp7j6yTjEraj58DgyhxWCdgE/0efXt4EIWFNi6ZqgBnFGkA/m+3eF?=
 =?us-ascii?Q?HmJEHQrmQUXqXU8dlRryTqQrbwb9KMvFjL5Rh3B4j0A96jX4Inltk0CJHNRc?=
 =?us-ascii?Q?jJmiSF4+iC2tlX6JEzW8Wh2iTrNosCpZm/RohILz8TEfHAPNJatBuGLIBqHU?=
 =?us-ascii?Q?b0ZbbJ0li+0nYjRnbC1FRiHJ/0liLeK2nYdXhEoAeeFhEPfr6ErPFoIloSWz?=
 =?us-ascii?Q?FFe/x3qVh/xs79Ishvi57kZuRgln5Zay79erxTVODeB/pckaCvWeVOHjqrkt?=
 =?us-ascii?Q?DoacIFMUjUdLTO4+wQwagRlxdxxc9VJMOstz8Q7egmEo0AiqNNSfwSL8lgHL?=
 =?us-ascii?Q?z14zeaErwWb1zbLW3Rt4Pswm6cjARxhXzzskiaCfyld80lFNlOSEap++47KM?=
 =?us-ascii?Q?B9Z6QpMBs6uLZnkIAfd1buTP0jKQajtHr24ihcvDAaK1tY0u2TtV6bQD19zI?=
 =?us-ascii?Q?+iyBhBsCXA+ZvqvVkbQZp4OnHFTcCPXqaCw7hfX974raNBCb0EjT2Kzp7en1?=
 =?us-ascii?Q?EorkCDqXFRTBrVXEn0q477uhDiuEmoBOkga/mln4vOcOF7LZ9QG9p5Kdzzgn?=
 =?us-ascii?Q?8vkcnvXAOi7cm5zOGuU2jIZEyu46L6xElj/1vEya?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81de6aa7-0b6a-4178-d543-08dbf62ee0ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 07:42:20.5619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwnA+DZm1eXjDYRX2RdRXIucLTO/bdcjwDC2tZAyAB/G0JbADM/E6VRPdcirm8AxE8smXfljFDpl4cIEjsogww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6923
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



>=20
> The protocol used for the IVSC device to communicate with HOST is MEI.
> The MEI hardware interfaces for the IVSC device are implemented.
>=20
> The APIs are exposed by MEI framework to mei clients, e.g. mei_csi and
> mei_ace.
>=20
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Reviewed-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>


Acked-by: Tomas Winkler <tomas.winkler@intel.com>

> ---
>  drivers/misc/mei/Kconfig        |  13 ++
>  drivers/misc/mei/Makefile       |   3 +
>  drivers/misc/mei/platform-vsc.c | 450
> ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 466 insertions(+)
>  create mode 100644 drivers/misc/mei/platform-vsc.c
>=20
> diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig index
> 470957a..858bd70 100644
> --- a/drivers/misc/mei/Kconfig
> +++ b/drivers/misc/mei/Kconfig
> @@ -71,6 +71,19 @@ config INTEL_MEI_VSC_HW
>  	  This driver can also be built as a module. If so, the module
>  	  will be called mei-vsc-hw.
>=20
> +config INTEL_MEI_VSC
> +	tristate "Intel visual sensing controller device with ME interface"
> +	depends on INTEL_MEI_VSC_HW
> +	depends on INTEL_MEI
> +	help
> +	  Intel MEI over SPI driver for Intel visual sensing controller
> +	  (IVSC) device embedded in IA platform. It supports camera sharing
> +	  between IVSC for context sensing and IPU for typical media usage.
> +	  Select this config should enable transport layer for IVSC device.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called mei-vsc.
> +
>  source "drivers/misc/mei/hdcp/Kconfig"
>  source "drivers/misc/mei/pxp/Kconfig"
>  source "drivers/misc/mei/gsc_proxy/Kconfig"
> diff --git a/drivers/misc/mei/Makefile b/drivers/misc/mei/Makefile index
> 3d0da19..6f9fdbf 100644
> --- a/drivers/misc/mei/Makefile
> +++ b/drivers/misc/mei/Makefile
> @@ -35,3 +35,6 @@ obj-$(CONFIG_INTEL_MEI_GSC_PROXY) +=3D gsc_proxy/
>  obj-$(CONFIG_INTEL_MEI_VSC_HW) +=3D mei-vsc-hw.o  mei-vsc-hw-y :=3D vsc-
> tp.o  mei-vsc-hw-y +=3D vsc-fw-loader.o
> +
> +obj-$(CONFIG_INTEL_MEI_VSC) +=3D mei-vsc.o mei-vsc-y :=3D platform-vsc.o
> diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-
> vsc.c new file mode 100644 index 0000000..8d303c6
> --- /dev/null
> +++ b/drivers/misc/mei/platform-vsc.c
> @@ -0,0 +1,450 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Intel Corporation.
> + * Intel Visual Sensing Controller Interface Linux driver  */
> +
> +#include <linux/align.h>
> +#include <linux/cache.h>
> +#include <linux/cleanup.h>
> +#include <linux/iopoll.h>
> +#include <linux/list.h>
> +#include <linux/mei.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/overflow.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/timekeeping.h>
> +#include <linux/types.h>
> +
> +#include <asm-generic/bug.h>
> +#include <asm-generic/unaligned.h>
> +
> +#include "mei_dev.h"
> +#include "vsc-tp.h"
> +
> +#define MEI_VSC_DRV_NAME		"intel_vsc"
> +
> +#define MEI_VSC_MAX_MSG_SIZE		512
> +
> +#define MEI_VSC_POLL_DELAY_US		(50 * USEC_PER_MSEC)
> +#define MEI_VSC_POLL_TIMEOUT_US		(200 * USEC_PER_MSEC)
> +
> +#define mei_dev_to_vsc_hw(dev)		((struct mei_vsc_hw *)((dev)-
> >hw))
> +
> +struct mei_vsc_host_timestamp {
> +	u64 realtime;
> +	u64 boottime;
> +};
> +
> +struct mei_vsc_hw {
> +	struct vsc_tp *tp;
> +
> +	bool fw_ready;
> +	bool host_ready;
> +
> +	atomic_t write_lock_cnt;
> +
> +	u32 rx_len;
> +	u32 rx_hdr;
> +
> +	/* buffer for tx */
> +	char tx_buf[MEI_VSC_MAX_MSG_SIZE + sizeof(struct mei_msg_hdr)]
> ____cacheline_aligned;
> +	/* buffer for rx */
> +	char rx_buf[MEI_VSC_MAX_MSG_SIZE + sizeof(struct mei_msg_hdr)]
> +____cacheline_aligned; };
> +
> +static int mei_vsc_read_helper(struct mei_vsc_hw *hw, u8 *buf,
> +			       u32 max_len)
> +{
> +	struct mei_vsc_host_timestamp ts =3D {
> +		.realtime =3D ktime_to_ns(ktime_get_real()),
> +		.boottime =3D ktime_to_ns(ktime_get_boottime()),
> +	};
> +
> +	return vsc_tp_xfer(hw->tp, VSC_TP_CMD_READ, &ts, sizeof(ts),
> +			   buf, max_len);
> +}
> +
> +static int mei_vsc_write_helper(struct mei_vsc_hw *hw, u8 *buf, u32
> +len) {
> +	u8 status;
> +
> +	return vsc_tp_xfer(hw->tp, VSC_TP_CMD_WRITE, buf, len, &status,
> +			   sizeof(status));
> +}
> +
> +static int mei_vsc_fw_status(struct mei_device *mei_dev,
> +			     struct mei_fw_status *fw_status) {
> +	if (!fw_status)
> +		return -EINVAL;
> +
> +	fw_status->count =3D 0;
> +
> +	return 0;
> +}
> +
> +static inline enum mei_pg_state mei_vsc_pg_state(struct mei_device
> +*mei_dev) {
> +	return MEI_PG_OFF;
> +}
> +
> +static void mei_vsc_intr_enable(struct mei_device *mei_dev) {
> +	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> +
> +	vsc_tp_intr_enable(hw->tp);
> +}
> +
> +static void mei_vsc_intr_disable(struct mei_device *mei_dev) {
> +	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> +
> +	vsc_tp_intr_disable(hw->tp);
> +}
> +
> +/* mei framework requires this ops */
> +static void mei_vsc_intr_clear(struct mei_device *mei_dev) { }
> +
> +/* wait for pending irq handler */
> +static void mei_vsc_synchronize_irq(struct mei_device *mei_dev) {
> +	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> +
> +	vsc_tp_intr_synchronize(hw->tp);
> +}
> +
> +static int mei_vsc_hw_config(struct mei_device *mei_dev) {
> +	return 0;
> +}
> +
> +static bool mei_vsc_host_is_ready(struct mei_device *mei_dev) {
> +	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> +
> +	return hw->host_ready;
> +}
> +
> +static bool mei_vsc_hw_is_ready(struct mei_device *mei_dev) {
> +	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> +
> +	return hw->fw_ready;
> +}
> +
> +static int mei_vsc_hw_start(struct mei_device *mei_dev) {
> +	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> +	int ret, rlen;
> +	u8 buf;
> +
> +	hw->host_ready =3D true;
> +
> +	vsc_tp_intr_enable(hw->tp);
> +
> +	ret =3D read_poll_timeout(mei_vsc_read_helper, rlen,
> +				rlen >=3D 0, MEI_VSC_POLL_DELAY_US,
> +				MEI_VSC_POLL_TIMEOUT_US, true,
> +				hw, &buf, sizeof(buf));
> +	if (ret) {
> +		dev_err(mei_dev->dev, "wait fw ready failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	hw->fw_ready =3D true;
> +
> +	return 0;
> +}
> +
> +static bool mei_vsc_hbuf_is_ready(struct mei_device *mei_dev) {
> +	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> +
> +	return atomic_read(&hw->write_lock_cnt) =3D=3D 0; }
> +
> +static int mei_vsc_hbuf_empty_slots(struct mei_device *mei_dev) {
> +	return MEI_VSC_MAX_MSG_SIZE / MEI_SLOT_SIZE; }
> +
> +static u32 mei_vsc_hbuf_depth(const struct mei_device *mei_dev) {
> +	return MEI_VSC_MAX_MSG_SIZE / MEI_SLOT_SIZE; }
> +
> +static int mei_vsc_write(struct mei_device *mei_dev,
> +			 const void *hdr, size_t hdr_len,
> +			 const void *data, size_t data_len)
> +{
> +	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> +	char *buf =3D hw->tx_buf;
> +	int ret;
> +
> +	if (WARN_ON(!hdr || !IS_ALIGNED(hdr_len, 4)))
> +		return -EINVAL;
> +
> +	if (!data || data_len > MEI_VSC_MAX_MSG_SIZE)
> +		return -EINVAL;
> +
> +	atomic_inc(&hw->write_lock_cnt);
> +
> +	memcpy(buf, hdr, hdr_len);
> +	memcpy(buf + hdr_len, data, data_len);
> +
> +	ret =3D mei_vsc_write_helper(hw, buf, hdr_len + data_len);
> +
> +	atomic_dec_if_positive(&hw->write_lock_cnt);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static inline u32 mei_vsc_read(const struct mei_device *mei_dev) {
> +	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> +	int ret;
> +
> +	ret =3D mei_vsc_read_helper(hw, hw->rx_buf, sizeof(hw->rx_buf));
> +	if (ret < 0 || ret < sizeof(u32))
> +		return 0;
> +	hw->rx_len =3D ret;
> +
> +	hw->rx_hdr =3D get_unaligned_le32(hw->rx_buf);
> +
> +	return hw->rx_hdr;
> +}
> +
> +static int mei_vsc_count_full_read_slots(struct mei_device *mei_dev) {
> +	return MEI_VSC_MAX_MSG_SIZE / MEI_SLOT_SIZE; }
> +
> +static int mei_vsc_read_slots(struct mei_device *mei_dev, unsigned char
> *buf,
> +			      unsigned long len)
> +{
> +	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> +	struct mei_msg_hdr *hdr;
> +
> +	hdr =3D (struct mei_msg_hdr *)&hw->rx_hdr;
> +	if (len !=3D hdr->length || hdr->length + sizeof(*hdr) !=3D hw->rx_len)
> +		return -EINVAL;
> +
> +	memcpy(buf, hw->rx_buf + sizeof(*hdr), len);
> +
> +	return 0;
> +}
> +
> +static bool mei_vsc_pg_in_transition(struct mei_device *mei_dev) {
> +	return mei_dev->pg_event >=3D MEI_PG_EVENT_WAIT &&
> +	       mei_dev->pg_event <=3D MEI_PG_EVENT_INTR_WAIT; }
> +
> +static bool mei_vsc_pg_is_enabled(struct mei_device *mei_dev) {
> +	return false;
> +}
> +
> +static int mei_vsc_hw_reset(struct mei_device *mei_dev, bool
> +intr_enable) {
> +	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> +
> +	vsc_tp_reset(hw->tp);
> +
> +	vsc_tp_intr_disable(hw->tp);
> +
> +	return vsc_tp_init(hw->tp, mei_dev->dev); }
> +
> +static const struct mei_hw_ops mei_vsc_hw_ops =3D {
> +	.fw_status =3D mei_vsc_fw_status,
> +	.pg_state =3D mei_vsc_pg_state,
> +
> +	.host_is_ready =3D mei_vsc_host_is_ready,
> +	.hw_is_ready =3D mei_vsc_hw_is_ready,
> +	.hw_reset =3D mei_vsc_hw_reset,
> +	.hw_config =3D mei_vsc_hw_config,
> +	.hw_start =3D mei_vsc_hw_start,
> +
> +	.pg_in_transition =3D mei_vsc_pg_in_transition,
> +	.pg_is_enabled =3D mei_vsc_pg_is_enabled,
> +
> +	.intr_clear =3D mei_vsc_intr_clear,
> +	.intr_enable =3D mei_vsc_intr_enable,
> +	.intr_disable =3D mei_vsc_intr_disable,
> +	.synchronize_irq =3D mei_vsc_synchronize_irq,
> +
> +	.hbuf_free_slots =3D mei_vsc_hbuf_empty_slots,
> +	.hbuf_is_ready =3D mei_vsc_hbuf_is_ready,
> +	.hbuf_depth =3D mei_vsc_hbuf_depth,
> +	.write =3D mei_vsc_write,
> +
> +	.rdbuf_full_slots =3D mei_vsc_count_full_read_slots,
> +	.read_hdr =3D mei_vsc_read,
> +	.read =3D mei_vsc_read_slots,
> +};
> +
> +static void mei_vsc_event_cb(void *context) {
> +	struct mei_device *mei_dev =3D context;
> +	struct mei_vsc_hw *hw =3D mei_dev_to_vsc_hw(mei_dev);
> +	struct list_head cmpl_list;
> +	s32 slots;
> +	int ret;
> +
> +	if (mei_dev->dev_state =3D=3D MEI_DEV_RESETTING ||
> +	    mei_dev->dev_state =3D=3D MEI_DEV_INITIALIZING)
> +		return;
> +
> +	INIT_LIST_HEAD(&cmpl_list);
> +
> +	guard(mutex)(&mei_dev->device_lock);
> +
> +	while (vsc_tp_need_read(hw->tp)) {
> +		/* check slots available for reading */
> +		slots =3D mei_count_full_read_slots(mei_dev);
> +
> +		ret =3D mei_irq_read_handler(mei_dev, &cmpl_list, &slots);
> +		if (ret) {
> +			if (ret !=3D -ENODATA) {
> +				if (mei_dev->dev_state !=3D
> MEI_DEV_RESETTING &&
> +				    mei_dev->dev_state !=3D
> MEI_DEV_POWER_DOWN)
> +					schedule_work(&mei_dev-
> >reset_work);
> +			}
> +
> +			return;
> +		}
> +	}
> +
> +	mei_dev->hbuf_is_ready =3D mei_hbuf_is_ready(mei_dev);
> +	ret =3D mei_irq_write_handler(mei_dev, &cmpl_list);
> +	if (ret)
> +		dev_err(mei_dev->dev, "dispatch write request failed:
> %d\n", ret);
> +
> +	mei_dev->hbuf_is_ready =3D mei_hbuf_is_ready(mei_dev);
> +	mei_irq_compl_handler(mei_dev, &cmpl_list); }
> +
> +static int mei_vsc_probe(struct platform_device *pdev) {
> +	struct device *dev =3D &pdev->dev;
> +	struct mei_device *mei_dev;
> +	struct mei_vsc_hw *hw;
> +	struct vsc_tp *tp;
> +	int ret;
> +
> +	tp =3D *(struct vsc_tp **)dev_get_platdata(dev);
> +	if (!tp)
> +		return dev_err_probe(dev, -ENODEV, "no platform data\n");
> +
> +	mei_dev =3D devm_kzalloc(dev, size_add(sizeof(*mei_dev),
> sizeof(*hw)),
> +			       GFP_KERNEL);
> +	if (!mei_dev)
> +		return -ENOMEM;
> +
> +	mei_device_init(mei_dev, dev, false, &mei_vsc_hw_ops);
> +	mei_dev->fw_f_fw_ver_supported =3D 0;
> +	mei_dev->kind =3D "ivsc";
> +
> +	hw =3D mei_dev_to_vsc_hw(mei_dev);
> +	atomic_set(&hw->write_lock_cnt, 0);
> +	hw->tp =3D tp;
> +
> +	platform_set_drvdata(pdev, mei_dev);
> +
> +	vsc_tp_register_event_cb(tp, mei_vsc_event_cb, mei_dev);
> +
> +	ret =3D mei_start(mei_dev);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "init hw failed\n");
> +		goto err_cancel;
> +	}
> +
> +	ret =3D mei_register(mei_dev, dev);
> +	if (ret)
> +		goto err_stop;
> +
> +	pm_runtime_enable(mei_dev->dev);
> +
> +	return 0;
> +
> +err_stop:
> +	mei_stop(mei_dev);
> +
> +err_cancel:
> +	mei_cancel_work(mei_dev);
> +
> +	mei_disable_interrupts(mei_dev);
> +
> +	return ret;
> +}
> +
> +static int mei_vsc_remove(struct platform_device *pdev) {
> +	struct mei_device *mei_dev =3D platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(mei_dev->dev);
> +
> +	mei_stop(mei_dev);
> +
> +	mei_disable_interrupts(mei_dev);
> +
> +	mei_deregister(mei_dev);
> +
> +	return 0;
> +}
> +
> +static int mei_vsc_suspend(struct device *dev) {
> +	struct mei_device *mei_dev =3D dev_get_drvdata(dev);
> +
> +	mei_stop(mei_dev);
> +
> +	return 0;
> +}
> +
> +static int mei_vsc_resume(struct device *dev) {
> +	struct mei_device *mei_dev =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D mei_restart(mei_dev);
> +	if (ret)
> +		return ret;
> +
> +	/* start timer if stopped in suspend */
> +	schedule_delayed_work(&mei_dev->timer_work, HZ);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(mei_vsc_pm_ops, mei_vsc_suspend,
> +mei_vsc_resume);
> +
> +static const struct platform_device_id mei_vsc_id_table[] =3D {
> +	{ MEI_VSC_DRV_NAME },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, mei_vsc_id_table);
> +
> +static struct platform_driver mei_vsc_drv =3D {
> +	.probe =3D mei_vsc_probe,
> +	.remove =3D mei_vsc_remove,
> +	.id_table =3D mei_vsc_id_table,
> +	.driver =3D {
> +		.name =3D MEI_VSC_DRV_NAME,
> +		.pm =3D &mei_vsc_pm_ops,
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +module_platform_driver(mei_vsc_drv);
> +
> +MODULE_AUTHOR("Wentong Wu <wentong.wu@intel.com>");
> +MODULE_AUTHOR("Zhifeng Wang <zhifeng.wang@intel.com>");
> +MODULE_DESCRIPTION("Intel Visual Sensing Controller Interface");
> +MODULE_LICENSE("GPL"); MODULE_IMPORT_NS(VSC_TP);
> --
> 2.7.4

