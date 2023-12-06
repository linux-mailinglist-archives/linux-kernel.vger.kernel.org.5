Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BD48068F6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjLFHxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjLFHxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:53:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A03119B0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701848512; x=1733384512;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dPMMojQ9tjt0MYI0yiyXLJaYVDZqpDj7DjAVCoVeF7Q=;
  b=DYIarTKFxnJ7WL7CdsQsC7xCT4KdLGBwZbMAbom6Up9qwVOXMrV8s5vS
   iXpUQ47ymrqETe28HzE43tcfiLBmULZRC86ajPgAtCK1wavs2EAzHDPpe
   E1UcivT3a8NFOX0t8c/M7F8gZB0MLRnbnzep6bQnFKjG91woycyCPT111
   6xvXfGo+WOvaNrSqoWQ9Pn3dRDplwkTmiIHvLdKZM+P+NWyD2tneMjH+C
   E/aPrNF+BKBTbahA0dNYLdzjb3JfQkbf18WHOVqQ6HRYoSFQ+KDr+q7Bd
   A3rTFMMyzXn2wkaACCzHJJvlf+km+8j3JS8Jm5SJobZc6lU79N9q7Q1oK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="393750702"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="393750702"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 23:41:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="747511874"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="747511874"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 23:40:54 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 23:40:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 23:40:53 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Dec 2023 23:40:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeTxap2qB9i6Kcg6fyZfxWezKSEpY58Dsym0dQgn+R2z2i1ChPnv0sAKcfuEeysWWvsx8WBYJixaeE0mI0IjWt6IwgQBRydSt3NlqMfywhF0wbc38PXYkQiipQ0OaLl5XmowGdtMJ4qMA4kUXVj8+XGaseFoyP3TJY5orA1qH72u2eyB6bMmW94RDKWPB2BzCUyskEnPfB4QxCJi1pdenxC9+9wZb38EK/A1IZ5x5dn8DATJOdFGID3FsZX4v3vNE1m20sCfD4/cLkD+zwbC9ucaEIFAy+RVQ+BlZpzqpy4chvMZSLSK981PxkbxmtbqucuOmI+olwnZoXSg+Hrm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH9Xyk/TQmlaEP7KRo09tLA2cC7mmvm6SAumq6y6TrA=;
 b=AGDN27cw6UvFpT5y7PV18XEWYFcAYaKGaPiDVWjC+zkX5Pjyp+6qoaak3yaAd0Z2sFL2f7nLs591/ebdx4zvX8wcSEg/J++vleS2MnfiwcLDABlBCjvGZhR3mGcKUIGd0zTnje8K9Htp923Kc9FDnUVJf7kdPMjuI9bL9IpJI5hxExLid7Z896G+3u3XcTiEP2t0vRFW8Jh+xa6QTFhae0SizHOxFNxFJ+hcXR7m5yY1ww/oJ7lFJkvdQPMpHGtTapiROIpF+86d++p3JJSdv1pND7YqkGEmIijRkJkWAsMtVi+L0zwGaVYGdx2bRdqzVs0+vK1pzIlQEApEB+ZWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by SN7PR11MB6923.namprd11.prod.outlook.com (2603:10b6:806:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 07:40:50 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::bd0:9132:5b54:a118]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::bd0:9132:5b54:a118%7]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 07:40:49 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Wu, Wentong" <wentong.wu@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] mei: Add transport driver for IVSC device
Thread-Topic: [PATCH 1/2] mei: Add transport driver for IVSC device
Thread-Index: AQHaIfdcTbsyrxVvZ0q5bCAKu6yHkrCb6t8A
Date:   Wed, 6 Dec 2023 07:40:49 +0000
Message-ID: <MN2PR11MB4093DB0A9CD8C94BE428187AE584A@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <1701174846-16316-1-git-send-email-wentong.wu@intel.com>
 <1701174846-16316-2-git-send-email-wentong.wu@intel.com>
In-Reply-To: <1701174846-16316-2-git-send-email-wentong.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|SN7PR11MB6923:EE_
x-ms-office365-filtering-correlation-id: b23534c6-e78e-4631-7417-08dbf62eaacc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uYHY5TV6iktUQYoWRddRAzAD5C37HtuveI/wqEAfMEG5ARBNHhNs0x3c44uZUqxMpRoHFt6jf29Iz7JTRghILlc1iU/SIxpdsXTO3HMJltzaKlV7UafQEdH1/dWn3zjgnE3xl1momuGi2+DfzdEWiyVsUzbqEj/LSfezC3yT+/0ghR3FZzlDwxtW+mZgH/PQUcj+GuqIxfKvLTBB55fKdXJUj88Sj1cFW7ln2GqOx/xGYUdeXvSK7iAV1iARtsLnqRm5zKRp3FQU5TrMG/3zuLf/iKuxMABXY1eny38BmqTkfv3btSC8SFmLvkIN8D7an1ND4Ruu3hpbbSOwtjyTZQV7PWpoVp/yBBSo57tOlGk9I5XeD3YosciYMKc8yNzM+2P6HdsJCeF4Np06IfHnh+9hSFxDo8M0ODkiQgoRHl9ITYQolFyb8jOleljd1UN9DYhjokkDHY1cCaLLJupo9OOq3TVLpCG8VqJ0o/Fh9Umhy3LtCCmqRkaIko1SwMMsImmqjlJ3QlA9UvYvFTi1mwliHDZfuckXfMAwB11Z6yf0TaayR4Q8Bl7+XE0RqW0F4rhb9u8QjRBT6QDmKc7qRa0zxFrqcGi4RyqtvC3SdkiTP0Zej8EzIbUKTxvHPdFW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(52536014)(122000001)(41300700001)(86362001)(55016003)(33656002)(26005)(83380400001)(82960400001)(38070700009)(9686003)(4326008)(71200400001)(66946007)(2906002)(8936002)(6506007)(7696005)(8676002)(30864003)(478600001)(5660300002)(110136005)(66556008)(66446008)(66476007)(64756008)(54906003)(316002)(76116006)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FUjfhfgyAXW2WgvQhOLPU4WeU8E6KM4u4r2ZjlAeBeyTBGwSCD8ScJXQwsBs?=
 =?us-ascii?Q?fpY7+2uP2Nps9VG8KZWFxE0CqjeekZmUbSz8i+bbmPV3M0g/Mj/gpPfS6L2W?=
 =?us-ascii?Q?gWTSVMtE4FUNkau1/pberiGoIJghbYKHWodJFotz5MMrsnk1SzkEtf4YugJj?=
 =?us-ascii?Q?8y9sa22WmmFPVIVASMO2+M/N+pGSgOMx3L48AMkf3oUSXopRLVd+R1wSCSoA?=
 =?us-ascii?Q?mdVVsjVuj9TneWncAONuKAB966CRKJ0OgHl/mYyGYd/fltHoEOGdk3oLxd6N?=
 =?us-ascii?Q?7ZUtcThje8RtHx0wBeDYf51HE/IoiBgyJ4O/QAulQwkNR/pbbgJjoFqsgfPd?=
 =?us-ascii?Q?xBkmVfqX3zM5eQLEXYY/kIQDuu7MvXUon4owy3OU1mI5sUCT6N5berqbwurl?=
 =?us-ascii?Q?jia5Pr3XRGNWnW8YepxmqeOhnp2A1d02/6tHlfRe1ehAPMLInp/KLHntLcCw?=
 =?us-ascii?Q?ks1xFeVdyzMt6l2dwog4IY9RbtA8/z3D23lZQXW+9oQps0EKZEpgJHyv53I5?=
 =?us-ascii?Q?yYT2abd38XFoSghZAcGOnN1vNw/cYjxmk8HTL60AtdHoMiHauoI314asIUuZ?=
 =?us-ascii?Q?EOHoqiYhkKEn01ln6uYW31KlomZXymk2wJ35yRdp2VqOcLNtJ4cTcyA32Xyk?=
 =?us-ascii?Q?12DNvEccIKSnbsZSJvpdy0je2Lv4BTEvAifxaKyqtxwgsMRpoYVzrj7Jil+N?=
 =?us-ascii?Q?cN4difEsOVO/FcPQkG46EiBQqaL5DPZAZ4xAy5qTltkOLtAMmqCa3BAVDZKo?=
 =?us-ascii?Q?H8LFxZtRYXhWkO444oX1MloAmWUBOcYNkgyBpw6nENRnNYhD4JxgH+lze33r?=
 =?us-ascii?Q?giQ7pjbcxkpNP1r4igK4lXX/W3HenEgy9gVMUr+7ZohDRlz9AL7C6fDjB4Ct?=
 =?us-ascii?Q?wwWIufDEVdPdgN2cqDrYHTa33F9QtoY8GPzDQR84a2VjCB6vLUAM+ZHRFiuH?=
 =?us-ascii?Q?sXKLniCnC3rjee4T//xzyloy4/Zw66uQOMNViqNYr/Lkv6g4xX1xM3yyPgoV?=
 =?us-ascii?Q?fKvsDI1btsnDs88Q5Kjnek65YbFGwDRazR29bBWjHoE+RUxkt5CbD6vLdYFd?=
 =?us-ascii?Q?5YIzKV4u+hwLeJb5nQs4HcSMzHP1H19+YAvPsaQF7p0jzDCbwBAqhOFv9T5Y?=
 =?us-ascii?Q?fSRmKwpJ7aYjb1YyU3C3PqQffRJ5YlVXN51PIRSCsUSaMxzUL/bJQmeKoq5f?=
 =?us-ascii?Q?dTXPwTQhBclYFkCXakfq8foa8CFtebu6l1MPt3+bWhG3CbUDigGXK5M/z1l/?=
 =?us-ascii?Q?iovo8n6Atm2NFq0pFgu0rwiFLNZzNBDPUiAy9zZoM/vuL7g0+XlfBbsMDohj?=
 =?us-ascii?Q?gLJTI22wDp5Cee/vMAEeMuBUuN6RAz4l/RM+bL+jiawlPgyRh188Sqv40v9p?=
 =?us-ascii?Q?01CHjCJ2xMXRY1FD4D3hDpE9/IX0D/Olwe5g5hn4u5aUV9WWHEShlDEWjS2J?=
 =?us-ascii?Q?/6Wqz2zMn7FuyQez2VsqX0Mi3p/SqWeXdwT44lv+9IRL928F65w88rMXeXj7?=
 =?us-ascii?Q?UqKtyJ9WRADoVW4bH5NWqKvnGoGo+ogIhnwAq4CDNn8Fwjmx2/LNnLX5tGnS?=
 =?us-ascii?Q?6kpNvfx62hfy2xWlCdlXknbFiRF/zogfKCFhGi28?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23534c6-e78e-4631-7417-08dbf62eaacc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 07:40:49.7119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/TLQvm9OVz3E9MRDjtNELPsRwgyxom2LLKytwDCEUOsIa0sOqGLE3cdmAhHa5OtoveWx8dxE3wSJIDgzFLT0Q==
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



> -----Original Message-----
>=20
> The Intel visual sensing controller (IVSC) device is designed to control =
the
> camera sharing between host IPU for media usage and IVSC for context
> sensing (face detection).
>=20
> IVSC is exposed to HOST as an SPI device and the message protocol over th=
e
> SPI BUS for communicating with the IVSC device is implemented. This is th=
e
> backend of mei framework for IVSC device, which usually handles the
> hardware data transfer. The mei_csi and mei_ace are the clients of IVSC m=
ei
> framework.
>=20
> The firmware downloading for the IVSC device is implemented as well.
>=20
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>

> ---
>  drivers/misc/mei/Kconfig         |  11 +
>  drivers/misc/mei/Makefile        |   4 +
>  drivers/misc/mei/vsc-fw-loader.c | 822
> +++++++++++++++++++++++++++++++++++++++
>  drivers/misc/mei/vsc-tp.c        | 555 ++++++++++++++++++++++++++
>  drivers/misc/mei/vsc-tp.h        |  50 +++
>  5 files changed, 1442 insertions(+)
>  create mode 100644 drivers/misc/mei/vsc-fw-loader.c  create mode 100644
> drivers/misc/mei/vsc-tp.c  create mode 100644 drivers/misc/mei/vsc-tp.h
>=20
> diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig index
> 37db142..470957a 100644
> --- a/drivers/misc/mei/Kconfig
> +++ b/drivers/misc/mei/Kconfig
> @@ -60,6 +60,17 @@ config INTEL_MEI_GSC
>  	  tasks such as graphics card firmware update and security
>  	  tasks.
>=20
> +config INTEL_MEI_VSC_HW
> +	tristate "Intel visual sensing controller device transport driver"
> +	depends on ACPI && SPI
> +	depends on GPIOLIB || COMPILE_TEST
> +	help
> +	  Intel SPI transport driver between host and Intel visual sensing
> +	  controller (IVSC) device.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called mei-vsc-hw.
> +
>  source "drivers/misc/mei/hdcp/Kconfig"
>  source "drivers/misc/mei/pxp/Kconfig"
>  source "drivers/misc/mei/gsc_proxy/Kconfig"
> diff --git a/drivers/misc/mei/Makefile b/drivers/misc/mei/Makefile index
> 14aee25..3d0da19 100644
> --- a/drivers/misc/mei/Makefile
> +++ b/drivers/misc/mei/Makefile
> @@ -31,3 +31,7 @@ CFLAGS_mei-trace.o =3D -I$(src)
>  obj-$(CONFIG_INTEL_MEI_HDCP) +=3D hdcp/
>  obj-$(CONFIG_INTEL_MEI_PXP) +=3D pxp/
>  obj-$(CONFIG_INTEL_MEI_GSC_PROXY) +=3D gsc_proxy/
> +
> +obj-$(CONFIG_INTEL_MEI_VSC_HW) +=3D mei-vsc-hw.o mei-vsc-hw-y :=3D vsc-
> tp.o
> +mei-vsc-hw-y +=3D vsc-fw-loader.o
> diff --git a/drivers/misc/mei/vsc-fw-loader.c b/drivers/misc/mei/vsc-fw-
> loader.c
> new file mode 100644
> index 0000000..3e151f0
> --- /dev/null
> +++ b/drivers/misc/mei/vsc-fw-loader.c
> @@ -0,0 +1,822 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Intel Corporation.
> + * Intel Visual Sensing Controller Transport Layer Linux driver  */
> +
> +#include <linux/acpi.h>
> +#include <linux/align.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/firmware.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
> +#include <linux/string_helpers.h>
> +#include <linux/types.h>
> +
> +#include <asm-generic/unaligned.h>
> +
> +#include "vsc-tp.h"
> +
> +#define VSC_MAGIC_NUM			0x49505343 /* IPSC */
> +#define VSC_MAGIC_FW			0x49574653 /* IWFS */
> +#define VSC_MAGIC_FILE			0x46564353 /* FVCS */
> +
> +#define VSC_ADDR_BASE			0xE0030000
> +#define VSC_EFUSE_ADDR			(VSC_ADDR_BASE + 0x038)
> +#define VSC_STRAP_ADDR			(VSC_ADDR_BASE + 0x100)
> +
> +#define VSC_STRAP_KEY_SRC_MASK		BIT(0)
> +#define VSC_STRAP_KEY_SRC_PRODUCT	1
> +
> +#define VSC_MAINSTEPPING_VERSION_MASK	GENMASK(7, 4)
> +#define VSC_MAINSTEPPING_VERSION_A	0
> +
> +#define VSC_SUBSTEPPING_VERSION_MASK	GENMASK(3, 0)
> +#define VSC_SUBSTEPPING_VERSION_0	0
> +#define VSC_SUBSTEPPING_VERSION_1	2
> +
> +#define VSC_BOOT_IMG_OPTION_MASK	GENMASK(15, 0)
> +
> +#define VSC_SKU_CFG_LOCATION		0x5001A000
> +#define VSC_SKU_MAX_SIZE		4100u
> +
> +#define VSC_ACE_IMG_CNT			2
> +#define VSC_CSI_IMG_CNT			4
> +#define VSC_IMG_CNT_MAX			6
> +
> +#define VSC_ROM_PKG_SIZE		256u
> +#define VSC_FW_PKG_SIZE			512u
> +
> +#define VSC_CSI_IMAGE_NAME_FMT		"ivsc_fw_a1.bin"
> +#define VSC_CSI_IMAGE_NAME_FMT_PROD	"ivsc_fw_a1_%s.bin"
> +#define VSC_ACE_IMAGE_NAME_FMT
> 	"ivsc_pkg_%s_0_a1.bin"
> +#define VSC_ACE_IMAGE_NAME_FMT_PROD	"ivsc_pkg_%s_0_a1_%s.bin"
> +#define VSC_CFG_IMAGE_NAME_FMT
> 	"ivsc_skucfg_%s_0_1_a1.bin"
> +#define VSC_CFG_IMAGE_NAME_FMT_PROD
> 	"ivsc_skucfg_%s_0_1_a1_%s.bin"
> +
> +#define VSC_IMAGE_FOLDER_FMT		"vsc/soc_a1"
> +#define VSC_IMAGE_FOLDER_FMT_PROD	"vsc/soc_a1_%s"
> +
> +#define VSC_IMAGE_NAME_MAX_LEN		64
> +#define VSC_IMAGE_PATH_MAX_LEN		128
> +
> +#define VSC_SENSOR_NAME_MAX_LEN		16
> +#define VSC_IMAGE_FOLDER_NAME_MAX_LEN	32
> +#define VSC_IMAGE_NAME_SUFFIX_MAX_LEN	8
> +
> +/* command id */
> +enum {
> +	VSC_CMD_QUERY =3D 0,
> +	VSC_CMD_DL_SET =3D 1,
> +	VSC_CMD_DL_START =3D 2,
> +	VSC_CMD_DL_CONT =3D 3,
> +	VSC_CMD_DUMP_MEM =3D 4,
> +	VSC_CMD_GET_CONT =3D 8,
> +	VSC_CMD_CAM_BOOT =3D 10,
> +};
> +
> +/* command ack token */
> +enum {
> +	VSC_TOKEN_BOOTLOADER_REQ =3D 1,
> +	VSC_TOKEN_DUMP_RESP =3D 4,
> +	VSC_TOKEN_ERROR =3D 7,
> +};
> +
> +/* image type */
> +enum {
> +	VSC_IMG_BOOTLOADER_TYPE =3D 1,
> +	VSC_IMG_CSI_EM7D_TYPE,
> +	VSC_IMG_CSI_SEM_TYPE,
> +	VSC_IMG_CSI_RUNTIME_TYPE,
> +	VSC_IMG_ACE_VISION_TYPE,
> +	VSC_IMG_ACE_CFG_TYPE,
> +	VSC_IMG_SKU_CFG_TYPE,
> +};
> +
> +/* image fragments */
> +enum {
> +	VSC_IMG_BOOTLOADER_FRAG,
> +	VSC_IMG_CSI_SEM_FRAG,
> +	VSC_IMG_CSI_RUNTIME_FRAG,
> +	VSC_IMG_ACE_VISION_FRAG,
> +	VSC_IMG_ACE_CFG_FRAG,
> +	VSC_IMG_CSI_EM7D_FRAG,
> +	VSC_IMG_SKU_CFG_FRAG,
> +	VSC_IMG_FRAG_MAX
> +};
> +
> +struct vsc_rom_cmd {
> +	__le32 magic;
> +	__u8 cmd_id;
> +	union {
> +		/* download start */
> +		struct {
> +			__u8 img_type;
> +			__le16 option;
> +			__le32 img_len;
> +			__le32 img_loc;
> +			__le32 crc;
> +			DECLARE_FLEX_ARRAY(__u8, res);
> +		} __packed dl_start;
> +		/* download set */
> +		struct {
> +			__u8 option;
> +			__le16 img_cnt;
> +			DECLARE_FLEX_ARRAY(__le32, payload);
> +		} __packed dl_set;
> +		/* download continue */
> +		struct {
> +			__u8 end_flag;
> +			__le16 len;
> +			/* 8 is the offset of payload */
> +			__u8 payload[VSC_ROM_PKG_SIZE - 8];
> +		} __packed dl_cont;
> +		/* dump memory */
> +		struct {
> +			__u8 res;
> +			__le16 len;
> +			__le32 addr;
> +			DECLARE_FLEX_ARRAY(__u8, payload);
> +		} __packed dump_mem;
> +		/* 5 is the offset of padding */
> +		__u8 padding[VSC_ROM_PKG_SIZE - 5];
> +	} data;
> +};
> +
> +struct vsc_rom_cmd_ack {
> +	__le32 magic;
> +	__u8 token;
> +	__u8 type;
> +	__u8 res[2];
> +	__u8 payload[];
> +};
> +
> +struct vsc_fw_cmd {
> +	__le32 magic;
> +	__u8 cmd_id;
> +	union {
> +		struct {
> +			__le16 option;
> +			__u8 img_type;
> +			__le32 img_len;
> +			__le32 img_loc;
> +			__le32 crc;
> +			DECLARE_FLEX_ARRAY(__u8, res);
> +		} __packed dl_start;
> +		struct {
> +			__le16 option;
> +			__u8 img_cnt;
> +			DECLARE_FLEX_ARRAY(__le32, payload);
> +		} __packed dl_set;
> +		struct {
> +			__le32 addr;
> +			__u8 len;
> +			DECLARE_FLEX_ARRAY(__u8, payload);
> +		} __packed dump_mem;
> +		struct {
> +			__u8 resv[3];
> +			__le32 crc;
> +			DECLARE_FLEX_ARRAY(__u8, payload);
> +		} __packed boot;
> +		/* 5 is the offset of padding */
> +		__u8 padding[VSC_FW_PKG_SIZE - 5];
> +	} data;
> +};
> +
> +struct vsc_img {
> +	__le32 magic;
> +	__le32 option;
> +	__le32 image_count;
> +	__le32 image_location[VSC_IMG_CNT_MAX]; };
> +
> +struct vsc_fw_sign {
> +	__le32 magic;
> +	__le32 image_size;
> +	__u8 image[];
> +};
> +
> +struct vsc_image_code_data {
> +	/* fragment index */
> +	u8 frag_index;
> +	/* image type */
> +	u8 image_type;
> +};
> +
> +struct vsc_img_frag {
> +	u8 type;
> +	u32 location;
> +	const u8 *data;
> +	u32 size;
> +};
> +
> +/**
> + * struct vsc_fw_loader - represent vsc firmware loader
> + * @dev: device used to request fimware
> + * @tp: transport layer used with the firmware loader
> + * @csi: CSI image
> + * @ace: ACE image
> + * @cfg: config image
> + * @tx_buf: tx buffer
> + * @rx_buf: rx buffer
> + * @option: command option
> + * @count: total image count
> + * @key_src: key source
> + * @folder: image folder
> + * @sensor_name: camera sensor name
> + * @suffix: image name suffix
> + * @frags: image fragments
> + */
> +struct vsc_fw_loader {
> +	struct device *dev;
> +	struct vsc_tp *tp;
> +
> +	const struct firmware *csi;
> +	const struct firmware *ace;
> +	const struct firmware *cfg;
> +
> +	void *tx_buf;
> +	void *rx_buf;
> +
> +	u16 option;
> +	u16 count;
> +	u32 key_src;
> +
> +	char folder[VSC_IMAGE_FOLDER_NAME_MAX_LEN];
> +	char sensor_name[VSC_SENSOR_NAME_MAX_LEN];
> +	char suffix[VSC_IMAGE_NAME_SUFFIX_MAX_LEN];
> +
> +	struct vsc_img_frag frags[VSC_IMG_FRAG_MAX]; };
> +
> +static inline u32 vsc_sum_crc(void *data, size_t size) {
> +	u32 crc =3D 0;
> +	size_t i;
> +
> +	for (i =3D 0; i < size; i++)
> +		crc +=3D *((u8 *)data + i);
> +
> +	return crc;
> +}
> +
> +/* get sensor name to construct image name */ static int
> +vsc_get_sensor_name(struct vsc_fw_loader *fw_loader,
> +			       struct device *dev)
> +{
> +	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER };
> +	union acpi_object obj =3D {
> +		.type =3D ACPI_TYPE_INTEGER,
> +		.integer.value =3D 1,
> +	};
> +	struct acpi_object_list arg_list =3D {
> +		.count =3D 1,
> +		.pointer =3D &obj,
> +	};
> +	union acpi_object *ret_obj;
> +	acpi_handle handle;
> +	acpi_status status;
> +	int ret =3D 0;
> +
> +	handle =3D ACPI_HANDLE(dev);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	status =3D acpi_evaluate_object(handle, "SID", &arg_list, &buffer);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(dev, "can't evaluate SID method: %d\n", status);
> +		return -ENODEV;
> +	}
> +
> +	ret_obj =3D buffer.pointer;
> +	if (!ret_obj) {
> +		dev_err(dev, "can't locate ACPI buffer\n");
> +		return -ENODEV;
> +	}
> +
> +	if (ret_obj->type !=3D ACPI_TYPE_STRING) {
> +		dev_err(dev, "found non-string entry\n");
> +		ret =3D -ENODEV;
> +		goto out_free_buff;
> +	}
> +
> +	/* string length excludes trailing NUL */
> +	if (ret_obj->string.length >=3D sizeof(fw_loader->sensor_name)) {
> +		dev_err(dev, "sensor name buffer too small\n");
> +		ret =3D -EINVAL;
> +		goto out_free_buff;
> +	}
> +
> +	memcpy(fw_loader->sensor_name, ret_obj->string.pointer,
> +	       ret_obj->string.length);
> +
> +	string_lower(fw_loader->sensor_name, fw_loader->sensor_name);
> +
> +out_free_buff:
> +	ACPI_FREE(buffer.pointer);
> +
> +	return ret;
> +}
> +
> +static int vsc_identify_silicon(struct vsc_fw_loader *fw_loader) {
> +	struct vsc_rom_cmd_ack *ack =3D fw_loader->rx_buf;
> +	struct vsc_rom_cmd *cmd =3D fw_loader->tx_buf;
> +	u8 version, sub_version;
> +	int ret;
> +
> +	/* identify stepping information */
> +	cmd->magic =3D cpu_to_le32(VSC_MAGIC_NUM);
> +	cmd->cmd_id =3D VSC_CMD_DUMP_MEM;
> +	cmd->data.dump_mem.addr =3D cpu_to_le32(VSC_EFUSE_ADDR);
> +	cmd->data.dump_mem.len =3D cpu_to_le16(sizeof(__le32));
> +	ret =3D vsc_tp_rom_xfer(fw_loader->tp, cmd, ack,
> VSC_ROM_PKG_SIZE);
> +	if (ret)
> +		return ret;
> +	if (ack->token =3D=3D VSC_TOKEN_ERROR)
> +		return -EINVAL;
> +
> +	cmd->magic =3D cpu_to_le32(VSC_MAGIC_NUM);
> +	cmd->cmd_id =3D VSC_CMD_GET_CONT;
> +	ret =3D vsc_tp_rom_xfer(fw_loader->tp, cmd, ack,
> VSC_ROM_PKG_SIZE);
> +	if (ret)
> +		return ret;
> +	if (ack->token !=3D VSC_TOKEN_DUMP_RESP)
> +		return -EINVAL;
> +
> +	version =3D FIELD_GET(VSC_MAINSTEPPING_VERSION_MASK, ack-
> >payload[0]);
> +	sub_version =3D FIELD_GET(VSC_SUBSTEPPING_VERSION_MASK,
> +ack->payload[0]);
> +
> +	if (version !=3D VSC_MAINSTEPPING_VERSION_A)
> +		return -EINVAL;
> +
> +	if (sub_version !=3D VSC_SUBSTEPPING_VERSION_0 &&
> +	    sub_version !=3D VSC_SUBSTEPPING_VERSION_1)
> +		return -EINVAL;
> +
> +	dev_info(fw_loader->dev, "silicon stepping version is %u:%u\n",
> +		 version, sub_version);
> +
> +	/* identify strap information */
> +	cmd->magic =3D cpu_to_le32(VSC_MAGIC_NUM);
> +	cmd->cmd_id =3D VSC_CMD_DUMP_MEM;
> +	cmd->data.dump_mem.addr =3D cpu_to_le32(VSC_STRAP_ADDR);
> +	cmd->data.dump_mem.len =3D cpu_to_le16(sizeof(__le32));
> +	ret =3D vsc_tp_rom_xfer(fw_loader->tp, cmd, ack,
> VSC_ROM_PKG_SIZE);
> +	if (ret)
> +		return ret;
> +	if (ack->token =3D=3D VSC_TOKEN_ERROR)
> +		return -EINVAL;
> +
> +	cmd->magic =3D cpu_to_le32(VSC_MAGIC_NUM);
> +	cmd->cmd_id =3D VSC_CMD_GET_CONT;
> +	ret =3D vsc_tp_rom_xfer(fw_loader->tp, cmd, ack,
> VSC_ROM_PKG_SIZE);
> +	if (ret)
> +		return ret;
> +	if (ack->token !=3D VSC_TOKEN_DUMP_RESP)
> +		return -EINVAL;
> +
> +	fw_loader->key_src =3D FIELD_GET(VSC_STRAP_KEY_SRC_MASK,
> +ack->payload[2]);
> +
> +	if (fw_loader->key_src =3D=3D VSC_STRAP_KEY_SRC_PRODUCT)
> +		strscpy(fw_loader->suffix, "prod", sizeof(fw_loader->suffix));
> +
> +	return 0;
> +}
> +
> +static int vsc_identify_csi_image(struct vsc_fw_loader *fw_loader) {
> +	char path[VSC_IMAGE_PATH_MAX_LEN];
> +	char name[VSC_IMAGE_NAME_MAX_LEN];
> +	const struct firmware *image;
> +	struct vsc_fw_sign *sign;
> +	struct vsc_img *img;
> +	unsigned int i;
> +	int ret;
> +
> +	if (fw_loader->key_src =3D=3D VSC_STRAP_KEY_SRC_PRODUCT)
> +		snprintf(name, sizeof(name),
> VSC_CSI_IMAGE_NAME_FMT_PROD,
> +			 fw_loader->suffix);
> +	else
> +		snprintf(name, sizeof(name), VSC_CSI_IMAGE_NAME_FMT);
> +
> +	snprintf(path, sizeof(path), "%s/%s", fw_loader->folder, name);
> +
> +	ret =3D request_firmware(&image, path, fw_loader->dev);
> +	if (ret)
> +		return ret;
> +
> +	img =3D (struct vsc_img *)image->data;
> +	if (!img) {
> +		ret =3D -ENOENT;
> +		goto err_release_image;
> +	}
> +
> +	if (le32_to_cpu(img->magic) !=3D VSC_MAGIC_FILE) {
> +		ret =3D -EINVAL;
> +		goto err_release_image;
> +	}
> +
> +	if (le32_to_cpu(img->image_count) !=3D VSC_CSI_IMG_CNT) {
> +		ret =3D -EINVAL;
> +		goto err_release_image;
> +	}
> +	fw_loader->count +=3D le32_to_cpu(img->image_count) - 1;
> +
> +	fw_loader->option =3D
> +		FIELD_GET(VSC_BOOT_IMG_OPTION_MASK,
> le32_to_cpu(img->option));
> +
> +	sign =3D (struct vsc_fw_sign *)
> +		(img->image_location + le32_to_cpu(img->image_count));
> +
> +	for (i =3D 0; i < VSC_CSI_IMG_CNT; i++) {
> +		/* mapping from CSI image index to image code data */
> +		static const struct vsc_image_code_data csi_image_map[] =3D {
> +			{ VSC_IMG_BOOTLOADER_FRAG,
> VSC_IMG_BOOTLOADER_TYPE },
> +			{ VSC_IMG_CSI_SEM_FRAG, VSC_IMG_CSI_SEM_TYPE
> },
> +			{ VSC_IMG_CSI_RUNTIME_FRAG,
> VSC_IMG_CSI_RUNTIME_TYPE },
> +			{ VSC_IMG_CSI_EM7D_FRAG,
> VSC_IMG_CSI_EM7D_TYPE },
> +		};
> +		struct vsc_img_frag *frag;
> +
> +		if ((u8 *)sign + sizeof(*sign) > image->data + image->size) {
> +			ret =3D -EINVAL;
> +			goto err_release_image;
> +		}
> +
> +		if (le32_to_cpu(sign->magic) !=3D VSC_MAGIC_FW) {
> +			ret =3D -EINVAL;
> +			goto err_release_image;
> +		}
> +
> +		if (!le32_to_cpu(img->image_location[i])) {
> +			ret =3D -EINVAL;
> +			goto err_release_image;
> +		}
> +
> +		frag =3D &fw_loader->frags[csi_image_map[i].frag_index];
> +
> +		frag->data =3D sign->image;
> +		frag->size =3D le32_to_cpu(sign->image_size);
> +		frag->location =3D le32_to_cpu(img->image_location[i]);
> +		frag->type =3D csi_image_map[i].image_type;
> +
> +		sign =3D (struct vsc_fw_sign *)
> +			(sign->image + le32_to_cpu(sign->image_size));
> +	}
> +
> +	fw_loader->csi =3D image;
> +
> +	return 0;
> +
> +err_release_image:
> +	release_firmware(image);
> +
> +	return ret;
> +}
> +
> +static int vsc_identify_ace_image(struct vsc_fw_loader *fw_loader) {
> +	char path[VSC_IMAGE_PATH_MAX_LEN];
> +	char name[VSC_IMAGE_NAME_MAX_LEN];
> +	const struct firmware *image;
> +	struct vsc_fw_sign *sign;
> +	struct vsc_img *img;
> +	unsigned int i;
> +	int ret;
> +
> +	if (fw_loader->key_src =3D=3D VSC_STRAP_KEY_SRC_PRODUCT)
> +		snprintf(name, sizeof(name),
> VSC_ACE_IMAGE_NAME_FMT_PROD,
> +			 fw_loader->sensor_name, fw_loader->suffix);
> +	else
> +		snprintf(name, sizeof(name), VSC_ACE_IMAGE_NAME_FMT,
> +			 fw_loader->sensor_name);
> +
> +	snprintf(path, sizeof(path), "%s/%s", fw_loader->folder, name);
> +
> +	ret =3D request_firmware(&image, path, fw_loader->dev);
> +	if (ret)
> +		return ret;
> +
> +	img =3D (struct vsc_img *)image->data;
> +	if (!img) {
> +		ret =3D -ENOENT;
> +		goto err_release_image;
> +	}
> +
> +	if (le32_to_cpu(img->magic) !=3D VSC_MAGIC_FILE) {
> +		ret =3D -EINVAL;
> +		goto err_release_image;
> +	}
> +
> +	if (le32_to_cpu(img->image_count) !=3D VSC_ACE_IMG_CNT) {
> +		ret =3D -EINVAL;
> +		goto err_release_image;
> +	}
> +	fw_loader->count +=3D le32_to_cpu(img->image_count);
> +
> +	sign =3D (struct vsc_fw_sign *)
> +		(img->image_location + le32_to_cpu(img->image_count));
> +
> +	for (i =3D 0; i < VSC_ACE_IMG_CNT; i++) {
> +		/* mapping from ACE image index to image code data */
> +		static const struct vsc_image_code_data ace_image_map[] =3D {
> +			{ VSC_IMG_ACE_VISION_FRAG,
> VSC_IMG_ACE_VISION_TYPE },
> +			{ VSC_IMG_ACE_CFG_FRAG,
> VSC_IMG_ACE_CFG_TYPE },
> +		};
> +		struct vsc_img_frag *frag, *last_frag;
> +		u8 frag_index;
> +
> +		if ((u8 *)sign + sizeof(*sign) > image->data + image->size) {
> +			ret =3D -EINVAL;
> +			goto err_release_image;
> +		}
> +
> +		if (le32_to_cpu(sign->magic) !=3D VSC_MAGIC_FW) {
> +			ret =3D -EINVAL;
> +			goto err_release_image;
> +		}
> +
> +		frag_index =3D ace_image_map[i].frag_index;
> +		frag =3D &fw_loader->frags[frag_index];
> +
> +		frag->data =3D sign->image;
> +		frag->size =3D le32_to_cpu(sign->image_size);
> +		frag->location =3D le32_to_cpu(img->image_location[i]);
> +		frag->type =3D ace_image_map[i].image_type;
> +
> +		if (!frag->location) {
> +			last_frag =3D &fw_loader->frags[frag_index - 1];
> +			frag->location =3D
> +				ALIGN(last_frag->location + last_frag->size,
> SZ_4K);
> +		}
> +
> +		sign =3D (struct vsc_fw_sign *)
> +			(sign->image + le32_to_cpu(sign->image_size));
> +	}
> +
> +	fw_loader->ace =3D image;
> +
> +	return 0;
> +
> +err_release_image:
> +	release_firmware(image);
> +
> +	return ret;
> +}
> +
> +static int vsc_identify_cfg_image(struct vsc_fw_loader *fw_loader) {
> +	struct vsc_img_frag *frag =3D &fw_loader-
> >frags[VSC_IMG_SKU_CFG_FRAG];
> +	char path[VSC_IMAGE_PATH_MAX_LEN];
> +	char name[VSC_IMAGE_NAME_MAX_LEN];
> +	const struct firmware *image;
> +	u32 size;
> +	int ret;
> +
> +	if (fw_loader->key_src =3D=3D VSC_STRAP_KEY_SRC_PRODUCT)
> +		snprintf(name, sizeof(name),
> VSC_CFG_IMAGE_NAME_FMT_PROD,
> +			 fw_loader->sensor_name, fw_loader->suffix);
> +	else
> +		snprintf(name, sizeof(name), VSC_CFG_IMAGE_NAME_FMT,
> +			 fw_loader->sensor_name);
> +
> +	snprintf(path, sizeof(path), "%s/%s", fw_loader->folder, name);
> +
> +	ret =3D request_firmware(&image, path, fw_loader->dev);
> +	if (ret)
> +		return ret;
> +
> +	/* identify image size */
> +	if (image->size <=3D sizeof(u32) || image->size > VSC_SKU_MAX_SIZE) {
> +		ret =3D -EINVAL;
> +		goto err_release_image;
> +	}
> +
> +	size =3D le32_to_cpu(*((__le32 *)image->data)) + sizeof(u32);
> +	if (image->size !=3D size) {
> +		ret =3D -EINVAL;
> +		goto err_release_image;
> +	}
> +
> +	frag->data =3D image->data;
> +	frag->size =3D image->size;
> +	frag->type =3D VSC_IMG_SKU_CFG_TYPE;
> +	frag->location =3D VSC_SKU_CFG_LOCATION;
> +
> +	fw_loader->cfg =3D image;
> +
> +	return 0;
> +
> +err_release_image:
> +	release_firmware(image);
> +
> +	return ret;
> +}
> +
> +static int vsc_download_bootloader(struct vsc_fw_loader *fw_loader) {
> +	struct vsc_img_frag *frag =3D &fw_loader-
> >frags[VSC_IMG_BOOTLOADER_FRAG];
> +	struct vsc_rom_cmd_ack *ack =3D fw_loader->rx_buf;
> +	struct vsc_rom_cmd *cmd =3D fw_loader->tx_buf;
> +	u32 len, c_len;
> +	size_t remain;
> +	const u8 *p;
> +	int ret;
> +
> +	cmd->magic =3D cpu_to_le32(VSC_MAGIC_NUM);
> +	cmd->cmd_id =3D VSC_CMD_QUERY;
> +	ret =3D vsc_tp_rom_xfer(fw_loader->tp, cmd, ack,
> VSC_ROM_PKG_SIZE);
> +	if (ret)
> +		return ret;
> +	if (ack->token !=3D VSC_TOKEN_DUMP_RESP &&
> +	    ack->token !=3D VSC_TOKEN_BOOTLOADER_REQ)
> +		return -EINVAL;
> +
> +	cmd->magic =3D cpu_to_le32(VSC_MAGIC_NUM);
> +	cmd->cmd_id =3D VSC_CMD_DL_START;
> +	cmd->data.dl_start.option =3D cpu_to_le16(fw_loader->option);
> +	cmd->data.dl_start.img_type =3D frag->type;
> +	cmd->data.dl_start.img_len =3D cpu_to_le32(frag->size);
> +	cmd->data.dl_start.img_loc =3D cpu_to_le32(frag->location);
> +
> +	c_len =3D offsetof(struct vsc_rom_cmd, data.dl_start.crc);
> +	cmd->data.dl_start.crc =3D cpu_to_le32(vsc_sum_crc(cmd, c_len));
> +
> +	ret =3D vsc_tp_rom_xfer(fw_loader->tp, cmd, NULL,
> VSC_ROM_PKG_SIZE);
> +	if (ret)
> +		return ret;
> +
> +	p =3D frag->data;
> +	remain =3D frag->size;
> +
> +	/* download image data */
> +	while (remain > 0) {
> +		len =3D min(remain, sizeof(cmd->data.dl_cont.payload));
> +
> +		cmd->magic =3D cpu_to_le32(VSC_MAGIC_NUM);
> +		cmd->cmd_id =3D VSC_CMD_DL_CONT;
> +		cmd->data.dl_cont.len =3D cpu_to_le16(len);
> +		cmd->data.dl_cont.end_flag =3D remain =3D=3D len;
> +		memcpy(cmd->data.dl_cont.payload, p, len);
> +
> +		ret =3D vsc_tp_rom_xfer(fw_loader->tp, cmd, NULL,
> VSC_ROM_PKG_SIZE);
> +		if (ret)
> +			return ret;
> +
> +		p +=3D len;
> +		remain -=3D len;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vsc_download_firmware(struct vsc_fw_loader *fw_loader) {
> +	struct vsc_fw_cmd *cmd =3D fw_loader->tx_buf;
> +	unsigned int i, index =3D 0;
> +	u32 c_len;
> +	int ret;
> +
> +	cmd->magic =3D cpu_to_le32(VSC_MAGIC_NUM);
> +	cmd->cmd_id =3D VSC_CMD_DL_SET;
> +	cmd->data.dl_set.img_cnt =3D cpu_to_le16(fw_loader->count);
> +	put_unaligned_le16(fw_loader->option, &cmd->data.dl_set.option);
> +
> +	for (i =3D VSC_IMG_CSI_SEM_FRAG; i <=3D VSC_IMG_CSI_EM7D_FRAG;
> i++) {
> +		struct vsc_img_frag *frag =3D &fw_loader->frags[i];
> +
> +		cmd->data.dl_set.payload[index++] =3D cpu_to_le32(frag-
> >location);
> +		cmd->data.dl_set.payload[index++] =3D cpu_to_le32(frag-
> >size);
> +	}
> +
> +	c_len =3D offsetof(struct vsc_fw_cmd, data.dl_set.payload[index]);
> +	cmd->data.dl_set.payload[index] =3D cpu_to_le32(vsc_sum_crc(cmd,
> +c_len));
> +
> +	ret =3D vsc_tp_rom_xfer(fw_loader->tp, cmd, NULL,
> VSC_FW_PKG_SIZE);
> +	if (ret)
> +		return ret;
> +
> +	for (i =3D VSC_IMG_CSI_SEM_FRAG; i < VSC_IMG_FRAG_MAX; i++) {
> +		struct vsc_img_frag *frag =3D &fw_loader->frags[i];
> +		const u8 *p;
> +		u32 remain;
> +
> +		cmd->magic =3D cpu_to_le32(VSC_MAGIC_NUM);
> +		cmd->cmd_id =3D VSC_CMD_DL_START;
> +		cmd->data.dl_start.img_type =3D frag->type;
> +		cmd->data.dl_start.img_len =3D cpu_to_le32(frag->size);
> +		cmd->data.dl_start.img_loc =3D cpu_to_le32(frag->location);
> +		put_unaligned_le16(fw_loader->option, &cmd-
> >data.dl_start.option);
> +
> +		c_len =3D offsetof(struct vsc_fw_cmd, data.dl_start.crc);
> +		cmd->data.dl_start.crc =3D cpu_to_le32(vsc_sum_crc(cmd,
> c_len));
> +
> +		ret =3D vsc_tp_rom_xfer(fw_loader->tp, cmd, NULL,
> VSC_FW_PKG_SIZE);
> +		if (ret)
> +			return ret;
> +
> +		p =3D frag->data;
> +		remain =3D frag->size;
> +
> +		/* download image data */
> +		while (remain > 0) {
> +			u32 len =3D min(remain, VSC_FW_PKG_SIZE);
> +
> +			memcpy(fw_loader->tx_buf, p, len);
> +			memset(fw_loader->tx_buf + len, 0,
> VSC_FW_PKG_SIZE - len);
> +
> +			ret =3D vsc_tp_rom_xfer(fw_loader->tp, fw_loader-
> >tx_buf,
> +					      NULL, VSC_FW_PKG_SIZE);
> +			if (ret)
> +				break;
> +
> +			p +=3D len;
> +			remain -=3D len;
> +		}
> +	}
> +
> +	cmd->magic =3D cpu_to_le32(VSC_MAGIC_NUM);
> +	cmd->cmd_id =3D VSC_CMD_CAM_BOOT;
> +
> +	c_len =3D offsetof(struct vsc_fw_cmd, data.dl_start.crc);
> +	cmd->data.boot.crc =3D cpu_to_le32(vsc_sum_crc(cmd, c_len));
> +
> +	return vsc_tp_rom_xfer(fw_loader->tp, cmd, NULL,
> VSC_FW_PKG_SIZE); }
> +
> +/**
> + * vsc_tp_init - init vsc_tp
> + * @tp: vsc_tp device handle
> + * @dev: device node for mei vsc device
> + * Return: 0 in case of success, negative value in case of error  */
> +int vsc_tp_init(struct vsc_tp *tp, struct device *dev) {
> +	struct vsc_fw_loader *fw_loader __free(kfree) =3D NULL;
> +	void *tx_buf __free(kfree) =3D NULL;
> +	void *rx_buf __free(kfree) =3D NULL;
> +	int ret;
> +
> +	fw_loader =3D kzalloc(sizeof(*fw_loader), GFP_KERNEL);
> +	if (!fw_loader)
> +		return -ENOMEM;
> +
> +	tx_buf =3D kzalloc(VSC_FW_PKG_SIZE, GFP_KERNEL);
> +	if (!tx_buf)
> +		return -ENOMEM;
> +
> +	rx_buf =3D kzalloc(VSC_FW_PKG_SIZE, GFP_KERNEL);
> +	if (!rx_buf)
> +		return -ENOMEM;
> +
> +	fw_loader->tx_buf =3D tx_buf;
> +	fw_loader->rx_buf =3D rx_buf;
> +
> +	fw_loader->tp =3D tp;
> +	fw_loader->dev =3D dev;
> +
> +	ret =3D vsc_get_sensor_name(fw_loader, dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D vsc_identify_silicon(fw_loader);
> +	if (ret)
> +		return ret;
> +
> +	if (fw_loader->key_src =3D=3D VSC_STRAP_KEY_SRC_PRODUCT)
> +		snprintf(fw_loader->folder, sizeof(fw_loader->folder),
> +			 VSC_IMAGE_FOLDER_FMT_PROD, fw_loader-
> >suffix);
> +	else
> +		snprintf(fw_loader->folder, sizeof(fw_loader->folder),
> +			 VSC_IMAGE_FOLDER_FMT);
> +
> +	ret =3D vsc_identify_csi_image(fw_loader);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D vsc_identify_ace_image(fw_loader);
> +	if (ret)
> +		goto err_release_csi;
> +
> +	ret =3D vsc_identify_cfg_image(fw_loader);
> +	if (ret)
> +		goto err_release_ace;
> +
> +	ret =3D vsc_download_bootloader(fw_loader);
> +	if (!ret)
> +		ret =3D vsc_download_firmware(fw_loader);
> +
> +	release_firmware(fw_loader->cfg);
> +
> +err_release_ace:
> +	release_firmware(fw_loader->ace);
> +
> +err_release_csi:
> +	release_firmware(fw_loader->csi);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(vsc_tp_init, VSC_TP);
> diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c new fi=
le
> mode 100644 index 0000000..6f4a4be
> --- /dev/null
> +++ b/drivers/misc/mei/vsc-tp.c
> @@ -0,0 +1,555 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Intel Corporation.
> + * Intel Visual Sensing Controller Transport Layer Linux driver  */
> +
> +#include <linux/acpi.h>
> +#include <linux/cleanup.h>
> +#include <linux/crc32.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/irq.h>
> +#include <linux/irqreturn.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +
> +#include "vsc-tp.h"
> +
> +#define VSC_TP_RESET_PIN_TOGGLE_INTERVAL_MS	20
> +#define VSC_TP_ROM_BOOTUP_DELAY_MS		10
> +#define VSC_TP_ROM_XFER_POLL_TIMEOUT_US		(500 *
> USEC_PER_MSEC)
> +#define VSC_TP_ROM_XFER_POLL_DELAY_US		(20 *
> USEC_PER_MSEC)
> +#define VSC_TP_WAIT_FW_ASSERTED_TIMEOUT		(2 * HZ)
> +#define VSC_TP_MAX_XFER_COUNT			5
> +
> +#define VSC_TP_PACKET_SYNC			0x31
> +#define VSC_TP_CRC_SIZE				sizeof(u32)
> +#define VSC_TP_MAX_MSG_SIZE			2048
> +/* SPI xfer timeout size */
> +#define VSC_TP_XFER_TIMEOUT_BYTES		700
> +#define VSC_TP_PACKET_PADDING_SIZE		1
> +#define VSC_TP_PACKET_SIZE(pkt) \
> +	(sizeof(struct vsc_tp_packet) + le16_to_cpu((pkt)->len) +
> +VSC_TP_CRC_SIZE) #define VSC_TP_MAX_PACKET_SIZE \
> +	(sizeof(struct vsc_tp_packet) + VSC_TP_MAX_MSG_SIZE +
> VSC_TP_CRC_SIZE)
> +#define VSC_TP_MAX_XFER_SIZE \
> +	(VSC_TP_MAX_PACKET_SIZE + VSC_TP_XFER_TIMEOUT_BYTES)
> #define
> +VSC_TP_NEXT_XFER_LEN(len, offset) \
> +	(len + sizeof(struct vsc_tp_packet) + VSC_TP_CRC_SIZE - offset +
> +VSC_TP_PACKET_PADDING_SIZE)
> +
> +struct vsc_tp_packet {
> +	__u8 sync;
> +	__u8 cmd;
> +	__le16 len;
> +	__le32 seq;
> +	__u8 buf[] __counted_by(len);
> +};
> +
> +struct vsc_tp {
> +	/* do the actual data transfer */
> +	struct spi_device *spi;
> +
> +	/* bind with mei framework */
> +	struct platform_device *pdev;
> +
> +	struct gpio_desc *wakeuphost;
> +	struct gpio_desc *resetfw;
> +	struct gpio_desc *wakeupfw;
> +
> +	/* command sequence number */
> +	u32 seq;
> +
> +	/* command buffer */
> +	void *tx_buf;
> +	void *rx_buf;
> +
> +	atomic_t assert_cnt;
> +	wait_queue_head_t xfer_wait;
> +
> +	vsc_tp_event_cb_t event_notify;
> +	void *event_notify_context;
> +
> +	/* used to protect command download */
> +	struct mutex mutex;
> +};
> +
> +/* GPIO resources */
> +static const struct acpi_gpio_params wakeuphost_gpio =3D { 0, 0, false }=
;
> +static const struct acpi_gpio_params wakeuphostint_gpio =3D { 1, 0, fals=
e
> +}; static const struct acpi_gpio_params resetfw_gpio =3D { 2, 0, false }=
;
> +static const struct acpi_gpio_params wakeupfw =3D { 3, 0, false };
> +
> +static const struct acpi_gpio_mapping vsc_tp_acpi_gpios[] =3D {
> +	{ "wakeuphost-gpios", &wakeuphost_gpio, 1 },
> +	{ "wakeuphostint-gpios", &wakeuphostint_gpio, 1 },
> +	{ "resetfw-gpios", &resetfw_gpio, 1 },
> +	{ "wakeupfw-gpios", &wakeupfw, 1 },
> +	{}
> +};
> +
> +/* wakeup firmware and wait for response */ static int
> +vsc_tp_wakeup_request(struct vsc_tp *tp) {
> +	int ret;
> +
> +	gpiod_set_value_cansleep(tp->wakeupfw, 0);
> +
> +	ret =3D wait_event_timeout(tp->xfer_wait,
> +				 atomic_read(&tp->assert_cnt) &&
> +				 gpiod_get_value_cansleep(tp->wakeuphost),
> +				 VSC_TP_WAIT_FW_ASSERTED_TIMEOUT);
> +	if (!ret)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static void vsc_tp_wakeup_release(struct vsc_tp *tp) {
> +	atomic_dec_if_positive(&tp->assert_cnt);
> +
> +	gpiod_set_value_cansleep(tp->wakeupfw, 1); }
> +
> +static int vsc_tp_dev_xfer(struct vsc_tp *tp, void *obuf, void *ibuf,
> +size_t len) {
> +	struct spi_message msg =3D { 0 };
> +	struct spi_transfer xfer =3D {
> +		.tx_buf =3D obuf,
> +		.rx_buf =3D ibuf,
> +		.len =3D len,
> +	};
> +
> +	spi_message_init_with_transfers(&msg, &xfer, 1);
> +
> +	return spi_sync_locked(tp->spi, &msg); }
> +
> +static int vsc_tp_xfer_helper(struct vsc_tp *tp, struct vsc_tp_packet *p=
kt,
> +			      void *ibuf, u16 ilen)
> +{
> +	int ret, offset =3D 0, cpy_len, src_len, dst_len =3D sizeof(struct
> vsc_tp_packet);
> +	int next_xfer_len =3D VSC_TP_PACKET_SIZE(pkt) +
> VSC_TP_XFER_TIMEOUT_BYTES;
> +	u8 *src, *crc_src, *rx_buf =3D tp->rx_buf;
> +	int count_down =3D VSC_TP_MAX_XFER_COUNT;
> +	u32 recv_crc =3D 0, crc =3D ~0;
> +	struct vsc_tp_packet ack;
> +	u8 *dst =3D (u8 *)&ack;
> +	bool synced =3D false;
> +
> +	do {
> +		ret =3D vsc_tp_dev_xfer(tp, pkt, rx_buf, next_xfer_len);
> +		if (ret)
> +			return ret;
> +		memset(pkt, 0, VSC_TP_MAX_XFER_SIZE);
> +
> +		if (synced) {
> +			src =3D rx_buf;
> +			src_len =3D next_xfer_len;
> +		} else {
> +			src =3D memchr(rx_buf, VSC_TP_PACKET_SYNC,
> next_xfer_len);
> +			if (!src)
> +				continue;
> +			synced =3D true;
> +			src_len =3D next_xfer_len - (src - rx_buf);
> +		}
> +
> +		/* traverse received data */
> +		while (src_len > 0) {
> +			cpy_len =3D min(src_len, dst_len);
> +			memcpy(dst, src, cpy_len);
> +			crc_src =3D src;
> +			src +=3D cpy_len;
> +			src_len -=3D cpy_len;
> +			dst +=3D cpy_len;
> +			dst_len -=3D cpy_len;
> +
> +			if (offset < sizeof(ack)) {
> +				offset +=3D cpy_len;
> +				crc =3D crc32(crc, crc_src, cpy_len);
> +
> +				if (!src_len)
> +					continue;
> +
> +				if (le16_to_cpu(ack.len)) {
> +					dst =3D ibuf;
> +					dst_len =3D min(ilen,
> le16_to_cpu(ack.len));
> +				} else {
> +					dst =3D (u8 *)&recv_crc;
> +					dst_len =3D sizeof(recv_crc);
> +				}
> +			} else if (offset < sizeof(ack) + le16_to_cpu(ack.len)) {
> +				offset +=3D cpy_len;
> +				crc =3D crc32(crc, crc_src, cpy_len);
> +
> +				if (src_len) {
> +					int remain =3D sizeof(ack) +
> le16_to_cpu(ack.len) - offset;
> +
> +					cpy_len =3D min(src_len, remain);
> +					offset +=3D cpy_len;
> +					crc =3D crc32(crc, src, cpy_len);
> +					src +=3D cpy_len;
> +					src_len -=3D cpy_len;
> +					if (src_len) {
> +						dst =3D (u8 *)&recv_crc;
> +						dst_len =3D sizeof(recv_crc);
> +						continue;
> +					}
> +				}
> +				next_xfer_len =3D
> VSC_TP_NEXT_XFER_LEN(le16_to_cpu(ack.len), offset);
> +			} else if (offset < sizeof(ack) + le16_to_cpu(ack.len) +
> VSC_TP_CRC_SIZE) {
> +				offset +=3D cpy_len;
> +
> +				if (src_len) {
> +					/* terminate the traverse */
> +					next_xfer_len =3D 0;
> +					break;
> +				}
> +				next_xfer_len =3D
> VSC_TP_NEXT_XFER_LEN(le16_to_cpu(ack.len), offset);
> +			}
> +		}
> +	} while (next_xfer_len > 0 && --count_down);
> +
> +	if (next_xfer_len > 0)
> +		return -EAGAIN;
> +
> +	if (~recv_crc !=3D crc || le32_to_cpu(ack.seq) !=3D tp->seq) {
> +		dev_err(&tp->spi->dev, "recv crc or seq error\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ack.cmd =3D=3D VSC_TP_CMD_ACK || ack.cmd =3D=3D VSC_TP_CMD_NACK
> ||
> +	    ack.cmd =3D=3D VSC_TP_CMD_BUSY) {
> +		dev_err(&tp->spi->dev, "recv cmd ack error\n");
> +		return -EAGAIN;
> +	}
> +
> +	return min(le16_to_cpu(ack.len), ilen); }
> +
> +/**
> + * vsc_tp_xfer - transfer data to firmware
> + * @tp: vsc_tp device handle
> + * @cmd: the command to be sent to the device
> + * @obuf: the tx buffer to be sent to the device
> + * @olen: the length of tx buffer
> + * @ibuf: the rx buffer to receive from the device
> + * @ilen: the length of rx buffer
> + * Return: the length of received data in case of success,
> + *	otherwise negative value
> + */
> +int vsc_tp_xfer(struct vsc_tp *tp, u8 cmd, const void *obuf, size_t olen=
,
> +		void *ibuf, size_t ilen)
> +{
> +	struct vsc_tp_packet *pkt =3D tp->tx_buf;
> +	u32 crc;
> +	int ret;
> +
> +	if (!obuf || !ibuf || olen > VSC_TP_MAX_MSG_SIZE)
> +		return -EINVAL;
> +
> +	guard(mutex)(&tp->mutex);
> +
> +	pkt->sync =3D VSC_TP_PACKET_SYNC;
> +	pkt->cmd =3D cmd;
> +	pkt->len =3D cpu_to_le16(olen);
> +	pkt->seq =3D cpu_to_le32(++tp->seq);
> +	memcpy(pkt->buf, obuf, olen);
> +
> +	crc =3D ~crc32(~0, (u8 *)pkt, sizeof(pkt) + olen);
> +	memcpy(pkt->buf + olen, &crc, sizeof(crc));
> +
> +	ret =3D vsc_tp_wakeup_request(tp);
> +	if (unlikely(ret))
> +		dev_err(&tp->spi->dev, "wakeup firmware failed ret: %d\n",
> ret);
> +	else
> +		ret =3D vsc_tp_xfer_helper(tp, pkt, ibuf, ilen);
> +
> +	vsc_tp_wakeup_release(tp);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(vsc_tp_xfer, VSC_TP);
> +
> +/**
> + * vsc_tp_rom_xfer - transfer data to rom code
> + * @tp: vsc_tp device handle
> + * @obuf: the data buffer to be sent to the device
> + * @ibuf: the buffer to receive data from the device
> + * @len: the length of tx buffer and rx buffer
> + * Return: 0 in case of success, negative value in case of error  */
> +int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf,
> +size_t len) {
> +	size_t words =3D len / sizeof(__be32);
> +	int ret;
> +
> +	if (len % sizeof(__be32) || len > VSC_TP_MAX_MSG_SIZE)
> +		return -EINVAL;
> +
> +	guard(mutex)(&tp->mutex);
> +
> +	/* rom xfer is big endian */
> +	cpu_to_be32_array(tp->tx_buf, obuf, words);
> +
> +	ret =3D read_poll_timeout(gpiod_get_value_cansleep, ret,
> +				!ret, VSC_TP_ROM_XFER_POLL_DELAY_US,
> +				VSC_TP_ROM_XFER_POLL_TIMEOUT_US,
> false,
> +				tp->wakeuphost);
> +	if (ret) {
> +		dev_err(&tp->spi->dev, "wait rom failed ret: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D vsc_tp_dev_xfer(tp, tp->tx_buf, tp->rx_buf, len);
> +	if (ret)
> +		return ret;
> +
> +	if (ibuf)
> +		cpu_to_be32_array(ibuf, tp->rx_buf, words);
> +
> +	return ret;
> +}
> +
> +/**
> + * vsc_tp_reset - reset vsc transport layer
> + * @tp: vsc_tp device handle
> + */
> +void vsc_tp_reset(struct vsc_tp *tp)
> +{
> +	disable_irq(tp->spi->irq);
> +
> +	/* toggle reset pin */
> +	gpiod_set_value_cansleep(tp->resetfw, 0);
> +	msleep(VSC_TP_RESET_PIN_TOGGLE_INTERVAL_MS);
> +	gpiod_set_value_cansleep(tp->resetfw, 1);
> +
> +	/* wait for ROM */
> +	msleep(VSC_TP_ROM_BOOTUP_DELAY_MS);
> +
> +	/*
> +	 * Set default host wakeup pin to non-active
> +	 * to avoid unexpected host irq interrupt.
> +	 */
> +	gpiod_set_value_cansleep(tp->wakeupfw, 1);
> +
> +	atomic_set(&tp->assert_cnt, 0);
> +
> +	enable_irq(tp->spi->irq);
> +}
> +EXPORT_SYMBOL_NS_GPL(vsc_tp_reset, VSC_TP);
> +
> +/**
> + * vsc_tp_need_read - check if device has data to sent
> + * @tp: vsc_tp device handle
> + * Return: true if device has data to sent, otherwise false  */ bool
> +vsc_tp_need_read(struct vsc_tp *tp) {
> +	if (!atomic_read(&tp->assert_cnt))
> +		return false;
> +	if (!gpiod_get_value_cansleep(tp->wakeuphost))
> +		return false;
> +	if (!gpiod_get_value_cansleep(tp->wakeupfw))
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_NS_GPL(vsc_tp_need_read, VSC_TP);
> +
> +/**
> + * vsc_tp_register_event_cb - register a callback function to receive
> +event
> + * @tp: vsc_tp device handle
> + * @event_cb: callback function
> + * @context: execution context of event callback
> + * Return: 0 in case of success, negative value in case of error  */
> +int vsc_tp_register_event_cb(struct vsc_tp *tp, vsc_tp_event_cb_t event_=
cb,
> +			    void *context)
> +{
> +	tp->event_notify =3D event_cb;
> +	tp->event_notify_context =3D context;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(vsc_tp_register_event_cb, VSC_TP);
> +
> +/**
> + * vsc_tp_intr_synchronize - synchronize vsc_tp interrupt
> + * @tp: vsc_tp device handle
> + */
> +void vsc_tp_intr_synchronize(struct vsc_tp *tp) {
> +	synchronize_irq(tp->spi->irq);
> +}
> +EXPORT_SYMBOL_NS_GPL(vsc_tp_intr_synchronize, VSC_TP);
> +
> +/**
> + * vsc_tp_intr_enable - enable vsc_tp interrupt
> + * @tp: vsc_tp device handle
> + */
> +void vsc_tp_intr_enable(struct vsc_tp *tp) {
> +	enable_irq(tp->spi->irq);
> +}
> +EXPORT_SYMBOL_NS_GPL(vsc_tp_intr_enable, VSC_TP);
> +
> +/**
> + * vsc_tp_intr_disable - disable vsc_tp interrupt
> + * @tp: vsc_tp device handle
> + */
> +void vsc_tp_intr_disable(struct vsc_tp *tp) {
> +	disable_irq(tp->spi->irq);
> +}
> +EXPORT_SYMBOL_NS_GPL(vsc_tp_intr_disable, VSC_TP);
> +
> +static irqreturn_t vsc_tp_isr(int irq, void *data) {
> +	struct vsc_tp *tp =3D data;
> +
> +	atomic_inc(&tp->assert_cnt);
> +
> +	wake_up(&tp->xfer_wait);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t vsc_tp_thread_isr(int irq, void *data) {
> +	struct vsc_tp *tp =3D data;
> +
> +	if (tp->event_notify)
> +		tp->event_notify(tp->event_notify_context);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int vsc_tp_match_any(struct acpi_device *adev, void *data) {
> +	struct acpi_device **__adev =3D data;
> +
> +	*__adev =3D adev;
> +
> +	return 1;
> +}
> +
> +static int vsc_tp_probe(struct spi_device *spi) {
> +	struct platform_device_info pinfo =3D { 0 };
> +	struct device *dev =3D &spi->dev;
> +	struct platform_device *pdev;
> +	struct acpi_device *adev;
> +	struct vsc_tp *tp;
> +	int ret;
> +
> +	tp =3D devm_kzalloc(dev, sizeof(*tp), GFP_KERNEL);
> +	if (!tp)
> +		return -ENOMEM;
> +
> +	tp->tx_buf =3D devm_kzalloc(dev, VSC_TP_MAX_XFER_SIZE,
> GFP_KERNEL);
> +	if (!tp->tx_buf)
> +		return -ENOMEM;
> +
> +	tp->rx_buf =3D devm_kzalloc(dev, VSC_TP_MAX_XFER_SIZE,
> GFP_KERNEL);
> +	if (!tp->rx_buf)
> +		return -ENOMEM;
> +
> +	ret =3D devm_acpi_dev_add_driver_gpios(dev, vsc_tp_acpi_gpios);
> +	if (ret)
> +		return ret;
> +
> +	tp->wakeuphost =3D devm_gpiod_get(dev, "wakeuphost", GPIOD_IN);
> +	if (IS_ERR(tp->wakeuphost))
> +		return PTR_ERR(tp->wakeuphost);
> +
> +	tp->resetfw =3D devm_gpiod_get(dev, "resetfw", GPIOD_OUT_HIGH);
> +	if (IS_ERR(tp->resetfw))
> +		return PTR_ERR(tp->resetfw);
> +
> +	tp->wakeupfw =3D devm_gpiod_get(dev, "wakeupfw",
> GPIOD_OUT_HIGH);
> +	if (IS_ERR(tp->wakeupfw))
> +		return PTR_ERR(tp->wakeupfw);
> +
> +	atomic_set(&tp->assert_cnt, 0);
> +	init_waitqueue_head(&tp->xfer_wait);
> +	tp->spi =3D spi;
> +
> +	irq_set_status_flags(spi->irq, IRQ_DISABLE_UNLAZY);
> +	ret =3D devm_request_threaded_irq(dev, spi->irq, vsc_tp_isr,
> +					vsc_tp_thread_isr,
> +					IRQF_TRIGGER_FALLING |
> IRQF_ONESHOT,
> +					dev_name(dev), tp);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&tp->mutex);
> +
> +	/* only one child acpi device */
> +	ret =3D acpi_dev_for_each_child(ACPI_COMPANION(dev),
> +				      vsc_tp_match_any, &adev);
> +	if (!ret) {
> +		ret =3D -ENODEV;
> +		goto err_destroy_lock;
> +	}
> +	pinfo.fwnode =3D acpi_fwnode_handle(adev);
> +
> +	pinfo.name =3D "intel_vsc";
> +	pinfo.data =3D &tp;
> +	pinfo.size_data =3D sizeof(tp);
> +	pinfo.id =3D PLATFORM_DEVID_NONE;
> +
> +	pdev =3D platform_device_register_full(&pinfo);
> +	if (IS_ERR(pdev)) {
> +		ret =3D PTR_ERR(pdev);
> +		goto err_destroy_lock;
> +	}
> +
> +	tp->pdev =3D pdev;
> +	spi_set_drvdata(spi, tp);
> +
> +	return 0;
> +
> +err_destroy_lock:
> +	mutex_destroy(&tp->mutex);
> +
> +	return ret;
> +}
> +
> +static void vsc_tp_remove(struct spi_device *spi) {
> +	struct vsc_tp *tp =3D spi_get_drvdata(spi);
> +
> +	platform_device_unregister(tp->pdev);
> +
> +	mutex_destroy(&tp->mutex);
> +}
> +
> +static const struct acpi_device_id vsc_tp_acpi_ids[] =3D {
> +	{ "INTC1009" }, /* Raptor Lake */
> +	{ "INTC1058" }, /* Tiger Lake */
> +	{ "INTC1094" }, /* Alder Lake */
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, vsc_tp_acpi_ids);
> +
> +static struct spi_driver vsc_tp_driver =3D {
> +	.probe =3D vsc_tp_probe,
> +	.remove =3D vsc_tp_remove,
> +	.driver =3D {
> +		.name =3D "vsc-tp",
> +		.acpi_match_table =3D vsc_tp_acpi_ids,
> +	},
> +};
> +module_spi_driver(vsc_tp_driver);
> +
> +MODULE_AUTHOR("Wentong Wu <wentong.wu@intel.com>");
> +MODULE_AUTHOR("Zhifeng Wang <zhifeng.wang@intel.com>");
> +MODULE_DESCRIPTION("Intel Visual Sensing Controller Transport Layer");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/misc/mei/vsc-tp.h b/drivers/misc/mei/vsc-tp.h new fi=
le
> mode 100644 index 0000000..f9513dd
> --- /dev/null
> +++ b/drivers/misc/mei/vsc-tp.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2023, Intel Corporation.
> + * Intel Visual Sensing Controller Transport Layer Linux driver  */
> +
> +#ifndef _VSC_TP_H_
> +#define _VSC_TP_H_
> +
> +#include <linux/types.h>
> +
> +#define VSC_TP_CMD_WRITE	0x01
> +#define VSC_TP_CMD_READ		0x02
> +
> +#define VSC_TP_CMD_ACK		0x10
> +#define VSC_TP_CMD_NACK		0x11
> +#define VSC_TP_CMD_BUSY		0x12
> +
> +struct vsc_tp;
> +
> +/**
> + * typedef vsc_event_cb_t - event callback function signature
> + * @context: the execution context of who registered this callback
> + *
> + * The callback function is called in interrupt context and the data
> + * payload is only valid during the call. If the user needs access
> + * the data payload later, it must copy the payload.
> + */
> +typedef void (*vsc_tp_event_cb_t)(void *context);
> +
> +int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf,
> +		    size_t len);
> +
> +int vsc_tp_xfer(struct vsc_tp *tp, u8 cmd, const void *obuf, size_t olen=
,
> +		void *ibuf, size_t ilen);
> +
> +int vsc_tp_register_event_cb(struct vsc_tp *tp, vsc_tp_event_cb_t event_=
cb,
> +			     void *context);
> +
> +void vsc_tp_intr_enable(struct vsc_tp *tp); void
> +vsc_tp_intr_disable(struct vsc_tp *tp); void
> +vsc_tp_intr_synchronize(struct vsc_tp *tp);
> +
> +void vsc_tp_reset(struct vsc_tp *tp);
> +
> +bool vsc_tp_need_read(struct vsc_tp *tp);
> +
> +int vsc_tp_init(struct vsc_tp *tp, struct device *dev);
> +
> +#endif
> --
> 2.7.4

