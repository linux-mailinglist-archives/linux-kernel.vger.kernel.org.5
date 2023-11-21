Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405537F2E27
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjKUNSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjKUNSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:18:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03531ED;
        Tue, 21 Nov 2023 05:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700572688; x=1732108688;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qYRgoTj/glXNHAjtuK8LVcnahGP3vKuio9MbiHcpa0w=;
  b=c51LYPTYAcVbHokj+dr3Ld24XXr57DeStK7uzNmYCsb5W09jedU0f91o
   3rQq3S0V3TNMYb1uIY6x3nmJHmW/iNg5ZzDKAjvkEWIYpeG+WnScQkMPy
   gnZ5TIf4eqaGdoWGOKsRTzEBk6bh5DLaq8EasruKGcDAHqe5pUxHHLEvv
   1AK9ToSwwo+CTZ3BpiUgNjwSm+JGnPvLhezbYMu9gPWrGWkGIESg4JLTu
   bfDrasi2Hh6ZuJAj1jlUA3CF22Ki9Qt5zs4YYP+cKQQfuMYj2hTorafmW
   m3u+7fpaN4X1AECviuFP1G0mjpXNcMXE3/TzZUeR1XrIp75Lv7Ejdpuv9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="372011417"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="372011417"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 05:18:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="8085670"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Nov 2023 05:18:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 05:18:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 05:18:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 05:18:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeizjIbATPcpN4DabpMHNP80p0iPteAAZa2So1NNVFYDHtZxfo151vNA0JYdgfQ9W7S9KLwk0ijSR7TmeQpt46AA0uHeIgvaFA30bsIl4pzDN9RDSqfjnbGj8thdhfKixpEMyd6E8yCGi/MfL/NshajeLYSIG4EHDyB+KggbNedEu6j9g4UNHr5lM3xc88MOHxet+PTCAmy3WYfA/rPkOIzj60fAmIb3/i3ehOkvBdUGi1ykGW8Sxzq+POu7xVFPcGNj6ctzokxI3H8mAl0ekFndTt2CTisZyHozN5OlblB/H+p2zQQiCvc3IOtEAIpqHso67cPU1XoXlx02dOl35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fp5juG6zsQNTEfsu25xHI8awFkhogAPyBv2UuosJO2Q=;
 b=FBwlyr0kwMU6P93eq0hinje1A15aBiIyuN3AUEYobCoeyG2yGcTt/KJMqrWvB2F28h1wo71MupqzDrRkXyL+Tsvu0DLxMdsLAULrgotlUvxlvMQXoiCViqPuWnN5zQXNvOCvzi5/3nUiRZZ3vVR+AFzaVt+fBfUczBGpM02n+BMs6avNCtlPE+cNtPisdMabldAmjuXbVHQJACCI+umL/lB8QcyMmohsiXY/p1Or5w5/S+sdJj2X2SsBMdG51hhHBxLdelOXA0X9r7h9TgEZSaZ2IkNxPXwZUdK/QozA6KSYz1h9Q5nCvPBHhlaInB8/fbEyunSJGE6VQ/5OUqBRPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by PH0PR11MB4968.namprd11.prod.outlook.com (2603:10b6:510:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 13:18:02 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::6a88:3d6c:99ec:d988]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::6a88:3d6c:99ec:d988%5]) with mapi id 15.20.7025.017; Tue, 21 Nov 2023
 13:18:02 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Subject: RE: [PATCH v2 2/4] EDAC, pnd2: Apply bit macros and helpers where it
 makes sense
Thread-Topic: [PATCH v2 2/4] EDAC, pnd2: Apply bit macros and helpers where it
 makes sense
Thread-Index: AQHaG7u6SBbasVNXBUqIn+4B8D7nIbCEwkuQ
Date:   Tue, 21 Nov 2023 13:18:02 +0000
Message-ID: <CY8PR11MB71345F54D7C29A6B14BC702089BBA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20231120141231.1638240-1-andriy.shevchenko@linux.intel.com>
 <20231120141231.1638240-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231120141231.1638240-2-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|PH0PR11MB4968:EE_
x-ms-office365-filtering-correlation-id: 63d1f280-121c-4509-240d-08dbea944a30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N11NKFksGqu5JEogRImhQ2mJmx9QyWC/EpYIdjF+1+PnIA+D0rMZfBDg30HSi1NTTj1pO+Fu4RiQnqJeUzN3M06Op460SJe3VmFoaKnJ4WN2SlAX6MoCk71JD/DHjU4Hl0OO9LP9dyk1WeTIEO4ZC3samW3Ul/P+eoqS6amuxRYKq6JYR3yBOrO53ljs0gL1PuCS+tj0Z/dhqMvNvUy6LYlLX+DPIJZu1FyxUVY72/Me67hkicHE0yvMUSOQc7Icp7+wQ3HBHWvRiAyfWUp5dnlq/PyHuH/4I4O0BYo8j6COnm7dAVho23+qpJe3wjUQOVNiRzqqgFBdTVb1wxIeoJ6UdyUo/II3f2UmISHp/C50a/p1OZtzw0OMTRH4Md7KNdveb2/OLctBpAN7Nlg4P9R7sJTBTFI5ONtXiMsiYH7H5UBtn+7NZ2XPADZm+WLuI94yZ6/6/lV9soVj4X3hKWQPuSz+nldnk+Iu/2q3oK6AUCF/OzWAJnw7Qnt117avlAJmwyiSYmYPYAGlq/54D7QrGSYgVc180Z1T0CorONnBuvFtswe59pBaPSd54I3ghUSbYwZGF3Ujb2iYaKRkQX4oFkcs1igZ+BBcceufWUpJj7nIhIt57qRvRDZMvNXj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(4744005)(2906002)(52536014)(86362001)(5660300002)(33656002)(38070700009)(7696005)(26005)(478600001)(9686003)(83380400001)(55016003)(122000001)(82960400001)(71200400001)(8676002)(8936002)(4326008)(38100700002)(316002)(66476007)(66556008)(66446008)(66946007)(64756008)(54906003)(110136005)(76116006)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jF2GhaDBV0mFsuMhjgY9Ac9fI83vC3lpW0/WFpXKgStpQGObYs0Z17nRBPQ4?=
 =?us-ascii?Q?fXuoulOEWlPFYmF42Vq5NhkT4hy1cNfl+I0n7Hf8izK6oYdjoN+idyms9Y6l?=
 =?us-ascii?Q?fagtEKJy9wR6qPWwmc672WxzVbkeXSu2Bw9bLh8Y98GW4nvH8I2yw02rAyvA?=
 =?us-ascii?Q?093SH1iTn5VQTcLPfmuNg5d3i+VtDvd/s5EJpNTHz7l3UYv492mBLezLgpIz?=
 =?us-ascii?Q?ulE2ju9AWjjuZe/NLgwSVmIWLucRn17dCPQybRWuBiYyPQzHvUV1WhNuzwRZ?=
 =?us-ascii?Q?OkTqfYnFy2dpMgb/dejG0zTkPT+ADDYGMJtwWGvhd3sJPHyrf13uSFertnFh?=
 =?us-ascii?Q?mmPkiQ3Q0nrCoGpmJ8bub+Nl8MSyvtyWljrSqK200waIpkGRb17aNSPWeXWB?=
 =?us-ascii?Q?IsECszlO4ovG9Kt5JrXP72Mz5MXu6uApOXAdOiAqptxf6csuH0+cT2uHYRLW?=
 =?us-ascii?Q?s73y4k7u4G4xVyvcpIYS5JFFyD9bgq+ruax8Za31vH3HIGu/EUMREnhUiVvs?=
 =?us-ascii?Q?g3S3X7ZmcEgzYoamY3Gn5a2WSQAG2dujjo2cJerq2o68VTmz29sk9X+/s5Ka?=
 =?us-ascii?Q?vNqvqX8xo5jE9wGAHUpe8btJmSv+NpvjLBmbAx3atBzLo5ovmd+Js/PxzR+M?=
 =?us-ascii?Q?7bUliVXXf7/plN1BfzGK1IcitXUVSaEEVxNTcQTWdowwDK/VMfAELjLZHEC/?=
 =?us-ascii?Q?4jUpzVOyS68BexJUFgcRHXzd0wXeZ8xGnGF7LFkVhMyp+8/kgEmlrHTA7I/Q?=
 =?us-ascii?Q?uODxDflBzjTa8i+QlXtXhdYd4IwcbD146IAtbbZRQDUzk0+eR+pTwoglbHe8?=
 =?us-ascii?Q?YgjMZBtfsJiG2iMuVeafkbtjQBq9FV5onC74sMJnnOZOz9YZbkY86Hn8nd4S?=
 =?us-ascii?Q?BzrFFP0EpQpbEvuWecckOymk9tMErIcBNgsRqwiVZ3+6R1MA6uc0NK0TqkeJ?=
 =?us-ascii?Q?RgL6H5PuyiDkKijkdJExXdA1vXLIVSohM6eOcSE0HPxpElsnRr07M5P2+hkg?=
 =?us-ascii?Q?zFn/1kDEhhvsgJtChlmFo2+d5Ro+Swaq3YDShqEB0NAHlxim2HBQXTl0nxDS?=
 =?us-ascii?Q?kypdNMmMljFoEWPHV5IjnVHgV5GrAhRmi/FlIBrIJVEby2587nPz1O2VRnki?=
 =?us-ascii?Q?oUz4ufkXzeYGd9pJ2OBQwPH1AtcmczlKru85ufjb+9PK1HaazuD+RYjY317d?=
 =?us-ascii?Q?E5nKtL0LrnWhq7lPvZ16Z9UBbggbrH8z5BaIoLgcyeCHoa5Mm5T4MXk5v8vS?=
 =?us-ascii?Q?CRLzkm+QG+B7iFb7o+rGkn4W6JoG+ytHOz2KJgF70IZKUxCHXAdTQTcwswao?=
 =?us-ascii?Q?hRzZppVThZDSLeF/lDYowNKrd/J1wfdfRmOCccaN0d1CxqzoiFCB0LPrZvWm?=
 =?us-ascii?Q?FXQWkcyNz2Zhs6cODMTcCOpmjCsXXrYRDwGtXA7o7060NYT9rrXlyWhLDhZv?=
 =?us-ascii?Q?9MOg02zBU7sO9gDq5RdcE1TLu5L+5ZOc8QrPXQEICNsHSGojm9tUgi9eO2OF?=
 =?us-ascii?Q?EzJyo8SIoWA07uBSBSouqJRnTDhEbFlHrW4LIZJN33xi4l62y4W5vBslSF3W?=
 =?us-ascii?Q?8QhFOU8aGwKngyTzdsr9mwZ1ZQLt9YT4/i/kRI6q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d1f280-121c-4509-240d-08dbea944a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 13:18:02.3166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZLhT1+ztkhj4zsNEHlVe8IlQ1EotSiGhSvNNbT049nxRozT4slGYHp5MQIOHN6p8wxtMd9mf6z0WfN/hPQyyGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4968
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ...
> Subject: [PATCH v2 2/4] EDAC, pnd2: Apply bit macros and helpers where it
> makes sense
>=20
> Apply bit macros (BIT()/BIT_ULL()/GENMASK()/etc) and helpers
> (for_each_set_bit()/etc) where it makes sense.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: fixed uninitialized variable (lkp, Qiuxu), dropped mask check change
> (Qiuxu)
>=20
>  drivers/edac/pnd2_edac.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> ...

This patch LGTM. Thanks!
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
