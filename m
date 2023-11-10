Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181997E82DF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbjKJTju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbjKJTjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:39:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1EDFC799;
        Fri, 10 Nov 2023 10:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699640527; x=1731176527;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qbQcOvG6du6rbdGEsMBcqhw/2eRXDmjj8fePltbf4gA=;
  b=KOAC5EX5z53EPKtVawKS3FrLjTPbFcLMwdETz9M8l9KOwkmCOTb1oYZV
   WFKA+MKrtnOZlkoJ/o1iuYEGAk2Q7qDcsP8nBvOC+L73DOxhr4NDMJ4w1
   xifnp8kua2fM3IG2DQHBqM+JATH9RuAPT6qPYmipyUJtE27KLrf+MaBlw
   8K/4rCh+R5zTEWxWRF6GytWY0+MEhPUjAOE3Ktl2JauJH/sPpcOrCRhMj
   yv5/fEZ4pE9IoiK7xOYa2dn0bJiKEwYfgdcZi05RlPK8h8/JyrQA+U9H1
   f8WNGInhF9b59xlvYXz7J50XLysVW456fdZfPCCIBLio0wbXJHQeKz5dK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="8868027"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="8868027"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 10:20:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="1095242974"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="1095242974"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2023 10:20:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 10:20:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 10:20:38 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 10:20:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbfsivO1pIoXBMP4837SXdryIWdWbnlHagd1K5UFgDrNbWqt6yoeYNdksf+StJS0/ZF/tMABhdTyxV0P5Rw6VXQgZHNtWOgfmJMlDAynKkszTD0FGhH4s5/uUn4x4MvbLFCifkzrPWM5L6AFcjxlH2Rvmo9TM636Aok22Dpkqdw7PIyg2Y1H+aKj3usbSCEFP2vreF6WZcEuwLFy4O/BFxRNaqtc787JYs1qpfJSv+/Y9X6FC0dWTsT8U6igfiOmlBQJQPKulscG4wqXywJXJQa7Vxbi8UYg2miHMxGpZ+3GOEPeocT/8H45JdeDmkPfhHyYB3I8ZsTCGGRsCMUw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBf4+jhg5MiwE5dfgQbxja+JLMyW1PBMvsr2S97FG2o=;
 b=bY100qVjrW7Wa+qlWPopfP3XtQDu0SqHAy37V6pj8nFv/yl273fqfAUU3pK393UjECaIYes9qfiTaFQt/r5nXoNzhY7Q6Z23/9dzLhC/wRW1iFj1MxuY3s9F4HDU8p+5ReV7FhzoQgTEixOjYadxnpe4d2rd3jcUiaS3SRcYclIkC/6RRuAow+B7eA/xhx0k/DV3q4Od0/HDt0EL+2577/yDeSnrQan8sGEz1wH5NflCrH3kteGcK1GXn7vmWRlUyUnV9JP+OWGKJt1XZIWVt3Z3Rupme2Es6HHi78EM9eW2l4AA6cf079wiQES7tZ9WqjA4RRxEIjOmJaYvnwVngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by MN0PR11MB6135.namprd11.prod.outlook.com (2603:10b6:208:3c9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Fri, 10 Nov
 2023 18:20:35 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::6da1:a4b7:4771:14e1]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::6da1:a4b7:4771:14e1%4]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 18:20:35 +0000
From:   "Chiu, Chasel" <chasel.chiu@intel.com>
To:     Simon Glass <sjg@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        "Tan, Lean Sheng" <sheng.tan@9elements.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        "Brune, Maximilian" <maximilian.brune@9elements.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        "Dong, Guo" <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>,
        ron minnich <rminnich@gmail.com>,
        "Guo, Gua" <gua.guo@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "U-Boot Mailing List" <u-boot@lists.denx.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Chiu, Chasel" <chasel.chiu@intel.com>
Subject: RE: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
Thread-Topic: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
Thread-Index: AQHZ8LGvpttG6mvEz0WlU57NBrVnTbB0GT1w
Date:   Fri, 10 Nov 2023 18:20:34 +0000
Message-ID: <BN9PR11MB5483FF3039913334C7EA83E1E6AEA@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20230926194242.2732127-1-sjg@chromium.org>
 <20230926194242.2732127-2-sjg@chromium.org>
In-Reply-To: <20230926194242.2732127-2-sjg@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5483:EE_|MN0PR11MB6135:EE_
x-ms-office365-filtering-correlation-id: aa3f4fee-8ef4-4ab8-7db0-08dbe219bb1c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 99WWrKQlkV+LGcBF+clpRsSpTf79OtvxNVlzC+Uxjt9wktGaLZT3154BgDrcjnTYjo7imoQbv6z6RqZXcqaCgqMWRn/wQVtBjqTLTi5oN5xDUv5Om7HsM5q8fNG2KmvL0THV4z2+3LehYVknZHA9i7++l8oWi5hnnA8+d4C2DC7agW6DNzlgixrea3nmdqd58WeuUkygF7qB08LDWLeQW1tOOKQ3lsHY/uQzREU6t1kUjgUCsWkqUwo1f5anYvDl4sYOjWx1AT4oni8cjZAT1V5xwELGF9r/y1GhB8OglHCoO7AZ+CjdVweqrIsIPsKwtbHQO0CRn4UwPVjbYs6dlDH9jKVGqHkWTTXdiP9tvAytS+hvbchkfTueHkjfMfaRscK/sJkZDv/tkSiDv2yx6Xc4KY/IdIZi4mfokyST50sWaQZK7/cHcF2jSsUxsxBKoVeyP6qHHJktX/goA5658JDhL7N4HXF9NL6/izJ3nwSAp8RUDhLaVJMK/45g09miOoRTFlP186zgMNFsa1NpyHaotWmK83Ndf4FCangiqptGRpWJdMBLFMTtc66SQfkS+kQ+PuWkhq2ygw1iobABm+tsigiEirjgTqchhnzbDC0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(8676002)(2906002)(7416002)(4326008)(5660300002)(55016003)(966005)(9686003)(122000001)(76116006)(86362001)(66446008)(316002)(71200400001)(54906003)(66476007)(66556008)(26005)(64756008)(33656002)(66946007)(110136005)(82960400001)(478600001)(6506007)(38100700002)(107886003)(7696005)(53546011)(52536014)(41300700001)(38070700009)(83380400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b8Q641gmCJlMn7VweMmTWI0lTSjNOvb8MyY+PrGQ0ZUVVt6Mo+gGNFseubhA?=
 =?us-ascii?Q?Yp0d0C7f6SlyXWxA5rTQfpiytjKFIiEppUY6HwILJRJ3l3a/0OxQRXqLCguT?=
 =?us-ascii?Q?PP/cLrf1mQV7WAKKG92hZ6LKmoF44K9EIR56N1ZRjrgR9dCWfNBJnR9gCBGI?=
 =?us-ascii?Q?afzY1EttrD/jZCYRT/yatSzWYkxc6nesKCxPyHCcIFJBazkGztdhkEi8xJRN?=
 =?us-ascii?Q?+lUkAa2kh9TAU6eYwcmz5CPtJvGd/ZPZ4TvIm0eYcprWenIkUealPL9MOjxL?=
 =?us-ascii?Q?rdliaU7diuTq4sqSu+7dzYIYnMESYHxpkqyOILJgfTu+Urblc+F1/ym8LV3y?=
 =?us-ascii?Q?zHwJLN28undaONPLXEsrBwWFpEShSkygq410a4WQweJZeYsyevpm+q0iKDAm?=
 =?us-ascii?Q?ks06KYhMqLZQXqlq4dWoCGrw8XmbV+s9+a5os2/UshEWKwOXhr6+hbP4H+YD?=
 =?us-ascii?Q?Zx/+qochTVghl6B6qkZ9NZn4nfFiaQITDVx0NtgMz/6RXTAVOsF25xzK5tYc?=
 =?us-ascii?Q?LJVAcEjWPvdYhWmkraqOHQWMEb/i6I/DS/BRtHerTxCJJYUKQnkvq2bEwFlZ?=
 =?us-ascii?Q?9pzMrV5YCJOdz4jxMi2CPefzULueltBRsUMpxFsEzX1wyOuz0MjJDcKeF7i5?=
 =?us-ascii?Q?h2+WUIWq5AULaVN5yWCJX7dxDrvEtHf6qghaSPzenHBeGZ81g9MweNTXO0L1?=
 =?us-ascii?Q?WtyhSFgz0XIt10cV5LCnVbuvEnKuQsFAP/wRkiKUlYLdZMHD0DnFmpKrKicT?=
 =?us-ascii?Q?TlArc1o4nUzTfvOKDolFieVfZQdd3CWrsBA/TFFuPkxOj8ABaavzHIjHtx0E?=
 =?us-ascii?Q?n8HJjDZxjDlP4M3h2nvthIfM8yqwclqtv38TsyCWe6yinUYp3PPSm7dIQAaC?=
 =?us-ascii?Q?eqX7rZ51PMFYpDVFi4biLnEFlrFe8rmKcmKLGxmx83wCwxrxg/qsTTVvGumO?=
 =?us-ascii?Q?Xr88x/1XXihS2v18zArjCobnF/vxxS154ViUlN+PJdMFzkTLz7Ir83W03jMc?=
 =?us-ascii?Q?jOTpoX1YSCJqBg9IesBo4rmnUB/qPUfTaBfBaVWdjfQXtcAzS+tBx0c3fgfX?=
 =?us-ascii?Q?KdAZdLnxk5Je0kMjrJKzYv+t6E8JCav5gAeP3AL1iJpeOq69yww7bnfL7BOg?=
 =?us-ascii?Q?MD+bTdRCKxbg6gHZ9aReXVakhXRzWLxBB1weZiD81O0SiL1UrNjIj+bvZXVB?=
 =?us-ascii?Q?l0cMnwC/b1EIffJHsSunB5iPoUgZFmSshqp9L8Mp/K/muEfztj5+0NO9Ukib?=
 =?us-ascii?Q?m/ZKUN19KY2qf8oRI0GuRRRY4XV3M3D6RtAkGkRDPeje9WdrtU6NfVsvaJOo?=
 =?us-ascii?Q?11h21ZqZg42TTY1HRIU1Wbecv3dnJ0fc0ROHdO3j+dTiUyHsjVTTXAwBh3oW?=
 =?us-ascii?Q?YeoPNpaa7z7cyuPc420YwwOV0d8j0oQngd4yjkD408royOR1vFcei3O2jJ7l?=
 =?us-ascii?Q?ew0K0LcTiJDWvosOL4YxQ/+jjkQ+dgk+TVLQ4qNngoZxzHKrMKlMr6Kt8KYG?=
 =?us-ascii?Q?lorwBkB6wsCQnIuzbb56jtm5lyKtQl/myd+roqg4az25bgtUE/me8pTCA6Zk?=
 =?us-ascii?Q?FUna2Pextr8s8c4HIA6+I/aQLMv+1yWV29UlStCV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3f4fee-8ef4-4ab8-7db0-08dbe219bb1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 18:20:34.4034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dBKSPdh+ZadnY7Q341XcCYMg7xm9bNgUospFem9C1i85KfcVHfK0ffhKHlCRCY1mplBzp0MAG+ecc98LzLUiEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6135
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


Just sharing some usage examples from UEFI/EDK2 scenario.
To support ACPI S4/Hibernation, memory map must be consistent before enteri=
ng and after resuming from S4, in this case payload may need to know previo=
us memory map from bootloader (currently generic payload cannot access plat=
form/bootloader specific non-volatile data, thus could not save/restore mem=
ory map information)
Another usage is to support binary model which generic payload is a prebuil=
t binary compatible for all platforms/configurations, however the payload d=
efault memory map might not always work for all the configurations and we w=
ant to allow bootloader to override payload default memory map without reco=
mpiling.

Under below assumption:
	FDT OS impact has been evaluated and taken care by relevant experts/stakeh=
olders.
Reviewed-by: Chasel Chiu <chasel.chiu@intel.com>

Thanks,
Chasel


> -----Original Message-----
> From: Simon Glass <sjg@chromium.org>
> Sent: Tuesday, September 26, 2023 12:43 PM
> To: devicetree@vger.kernel.org
> Cc: Mark Rutland <mark.rutland@arm.com>; Rob Herring <robh@kernel.org>;
> Tan, Lean Sheng <sheng.tan@9elements.com>; lkml <linux-
> kernel@vger.kernel.org>; Dhaval Sharma <dhaval@rivosinc.com>; Brune,
> Maximilian <maximilian.brune@9elements.com>; Yunhui Cui
> <cuiyunhui@bytedance.com>; Dong, Guo <guo.dong@intel.com>; Tom Rini
> <trini@konsulko.com>; ron minnich <rminnich@gmail.com>; Guo, Gua
> <gua.guo@intel.com>; Chiu, Chasel <chasel.chiu@intel.com>; linux-
> acpi@vger.kernel.org; U-Boot Mailing List <u-boot@lists.denx.de>; Ard
> Biesheuvel <ardb@kernel.org>; Simon Glass <sjg@chromium.org>
> Subject: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
>=20
> It is common to split firmware into 'Platform Init', which does the initi=
al hardware
> setup and a "Payload" which selects the OS to be booted.
> Thus an handover interface is required between these two pieces.
>=20
> Where UEFI boot-time services are not available, but UEFI firmware is pre=
sent on
> either side of this interface, information about memory usage and attribu=
tes must
> be presented to the "Payload" in some form.
>=20
> This aims to provide an small schema addition for the memory mapping need=
ed
> to keep these two pieces working together well.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v7:
> - Rename acpi-reclaim to acpi
> - Drop individual mention of when memory can be reclaimed
> - Rewrite the item descriptions
> - Add back the UEFI text (with trepidation)
>=20
> Changes in v6:
> - Drop mention of UEFI
> - Use compatible strings instead of node names
>=20
> Changes in v5:
> - Drop the memory-map node (should have done that in v4)
> - Tidy up schema a bit
>=20
> Changes in v4:
> - Make use of the reserved-memory node instead of creating a new one
>=20
> Changes in v3:
> - Reword commit message again
> - cc a lot more people, from the FFI patch
> - Split out the attributes into the /memory nodes
>=20
> Changes in v2:
> - Reword commit message
>=20
>  .../reserved-memory/common-reserved.yaml      | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 dtschema/schemas/reserved-memory/common-
> reserved.yaml
>=20
> diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml
> b/dtschema/schemas/reserved-memory/common-reserved.yaml
> new file mode 100644
> index 0000000..f7fbdfd
> --- /dev/null
> +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> +---
> +$id:
> +http://devicetree.org/schemas/reserved-memory/common-reserved.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common memory reservations
> +
> +description: |
> +  Specifies that the reserved memory region can be used for the purpose
> +  indicated by its compatible string.
> +
> +  Clients may reuse this reserved memory if they understand what it is
> + for,  subject to the notes below.
> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +allOf:
> +  - $ref: reserved-memory.yaml
> +
> +properties:
> +  compatible:
> +    description: |
> +      This describes some common memory reservations, with the compatibl=
e
> +      string indicating what it is used for:
> +
> +         acpi: Advanced Configuration and Power Interface (ACPI) tables
> +         acpi-nvs: ACPI Non-Volatile-Sleeping Memory (NVS). This is rese=
rved by
> +           the firmware for its use and is required to be saved and rest=
ored
> +           across an NVS sleep
> +         boot-code: Contains code used for booting which is not needed b=
y the OS
> +         boot-code: Contains data used for booting which is not needed b=
y the OS
> +         runtime-code: Contains code used for interacting with the syste=
m when
> +           running the OS
> +         runtime-data: Contains data used for interacting with the syste=
m when
> +           running the OS
> +
> +    enum:
> +      - acpi
> +      - acpi-nvs
> +      - boot-code
> +      - boot-data
> +      - runtime-code
> +      - runtime-data
> +
> +  reg:
> +    description: region of memory that is reserved for the purpose indic=
ated
> +      by the compatible string.
> +
> +required:
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    reserved-memory {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +
> +        reserved@12340000 {
> +            compatible =3D "boot-code";
> +            reg =3D <0x12340000 0x00800000>;
> +        };
> +
> +        reserved@43210000 {
> +            compatible =3D "boot-data";
> +            reg =3D <0x43210000 0x00800000>;
> +        };
> +    };
> --
> 2.42.0.515.g380fc7ccd1-goog

