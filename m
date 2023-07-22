Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B1375DBF1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGVLgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjGVLgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:36:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF05D269F;
        Sat, 22 Jul 2023 04:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690025801; x=1721561801;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FCtoDloO5mMsX6LNCv6INRMg0UoGEu4BD7p9SU4oB4I=;
  b=UjbEEAGiKRMXKYsLJi56Tn1FhJyEOvHUMBx9M9wWPQsXCm0IcddT6vyp
   iTaIpfE7VuHhwcg28sotI/JWvoGxgXD4A0YUU35A7wq4fT5pNBasYCQl1
   osZSKVJGGgBN0eX9w49sLmBJKE3ZoMOhcH6naWMcxw6wRc/nUNRJI7/hp
   3czfb4A8k5hQHz0/COpmk8Wldamnbsu83LzDWAZ9cQeQ/Zy+DNCd5ZtbD
   B3eUHRkHm2iDSYmK9FPaJvK/7rPwPUfp0vX7Cwb3arj/VpMbWbmcMFyv7
   FhqOic/PCP8hFvoDkYdsIXWi+3+jYBA8KNUnQ+5Mh/KXJ+dXojbFhb0pw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="367215455"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="367215455"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 04:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="971735774"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="971735774"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jul 2023 04:36:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 22 Jul 2023 04:36:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sat, 22 Jul 2023 04:36:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sat, 22 Jul 2023 04:36:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoQKvF+88IKpAomecSXlxrxZudIAKLchZ25wmai5lqUFoDSRtQCFhQ9CfFMe6Dof4YGJx4igXNVOJ63SxOaBdb+uzyVKyT9u6JWE2ncLH+3E8eqdWhEA4TUbgbEJweIly3KPB3HmSeWvYQlB5HEB61LXAZIsZ02HkZN9vCUIYuIONqD3picHTPmvAKc+xVkw5L5CYlk4D7CLqkjJj6Ct8hqlMyqJzcIG0p2r1qkR2N0Vi3hemlyqXMsVWEQIWrujCtO02dk7ZSYnYTi7Yd2G5fwJmg5FcMJv+rEyciKWKscdpCl9yjifwiUnd+OfARyb+kkxFK8+EZBSsByyz0KLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HipWZ1+4WgFXRfwIjY5/ef/SpS6LOyzhGoDuQQxHThI=;
 b=oK8RlQIaugsTknu3TGwVnGEZChdGXihHYhXTymnN7chmMJNwPK9ozqajC1WLdoycLwMQ+tJzvOxPgSEjScezn/XXgYCRfJXR2SPptQXuud7ErQgxWrAEP3QiTRnjwMQJz6IgOs32nJMo+sMXfHwSSQ18bU/5Gbs1+dmdjzALGFMn6Vx2qEDfBAh07dLaN9CMjlG4AakQ7jPPPeLqogoiyTj7o69kDHFdoTIsUj3aBGC3aQRJ9dVbRIhmt5caQEpCeQ1S7lYBLTjM87SrWb1+7cHUb9e6YIL2AwuGtNLiYAZDECGzZaHMBQk7c0ZPYyIfg2MqwFMxc/oCLV0fhkAS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by MN2PR11MB4518.namprd11.prod.outlook.com (2603:10b6:208:24f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 11:36:38 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::63d1:e2f7:dd1f:c047]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::63d1:e2f7:dd1f:c047%7]) with mapi id 15.20.6609.029; Sat, 22 Jul 2023
 11:36:38 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] mei: pxp: Keep a const qualifier when calling
 mei_cldev_send()
Thread-Topic: [PATCH] mei: pxp: Keep a const qualifier when calling
 mei_cldev_send()
Thread-Index: AQHZvBGvZjtj3VkwdUiNlTF7DBAvu6/FqTdg
Date:   Sat, 22 Jul 2023 11:36:37 +0000
Message-ID: <MN2PR11MB4093A613B1EE0F1B4611B439E53CA@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <23c078181575e65ff660f993bc6eb38753b3d5e7.1689971167.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <23c078181575e65ff660f993bc6eb38753b3d5e7.1689971167.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|MN2PR11MB4518:EE_
x-ms-office365-filtering-correlation-id: 09b03d78-f244-4a13-a2c5-08db8aa7e8fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xk/St3ENeR6ttqS9YKr3G9HKV2VArgMB/yzNw5zaDFohegQzidB8IZa+TGklj4yHa4eY0z94y6D/H29bo8B0yg/lStG1/EtFklE/9et8pD6qsbxbyGAK18kxAQINVKCupeTGy2hU6kodizjyqZv7e4V9pe8u7JlikdnD6Ssrx99OpHaS17Tg3e1nHBl9qB7R5lMtAn6AY80Kb+7CFQVZxcLjj9iqs8uQYkyBPT3jP15Qrm6pqdOWLoAf4MPkTusC8K9Z2zQi6I5vBpqUB+5HnAizBZ5Sg3Eezd5VNa2JBQkIxnql9NuRm62ANFH1vYS6HiqV/IKFpKe5Ir2mCPILG8v49tGoOvnk1KtghKKgz5W32+kkCEk1bv2VsfFHrZ6X5XZJ31UFS2UtNz34pRTEFtBOnRTp3qCkzTgVnodLyPmF9BzbELy1YzJq/LPw3KDihuhBAIV90nOvNQZ4ypu1nsNve2OxYZKqU0UM5z+7GRXqQSFrGDzy3zJ35m22JF78mwqh+6v5K0S+PmrNdbndjYqLSFOmgi+mExVrI+Wd7qw0oPah5mZzBh+xKkz30AmkGoy9Rsld5WKzY+k8mcwz93sFieaSOUkOQzLOIIzOHXdkhnAGIlntSKRwrUpSGtpO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(38100700002)(122000001)(55016003)(83380400001)(8676002)(5660300002)(52536014)(8936002)(110136005)(478600001)(54906003)(66476007)(66446008)(64756008)(66556008)(316002)(4326008)(66946007)(76116006)(41300700001)(26005)(186003)(6506007)(71200400001)(7696005)(9686003)(4744005)(2906002)(33656002)(38070700005)(86362001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T+C1dWkKoeX0lZILWryGlOleZmKrmrpR6mQfuapUMdOTsAvWoK7yT3416XgY?=
 =?us-ascii?Q?3FCUPcyvBgyjM0CpS/xvV3wwOM+Q22hMSkeA9WJZRB/xY0CXcKHjaDdvlIJw?=
 =?us-ascii?Q?/2ddagkPqpTdGxTV5BWeKJVrLwMG116NaTuBBVN9WZpCZmIN4piWmJeuZ3XN?=
 =?us-ascii?Q?U3cKYXudGP1pio+XUX1QYq28PJ8F3gwVV3FG8jbt4mqtn2bfoqleQngborzj?=
 =?us-ascii?Q?MFgVidF2nK6MtINzaO1ZYJaPQJKnp3pVKJ619nMUO+UifhpDFDGMmq2Op49L?=
 =?us-ascii?Q?pTN+S5etIx0xF2FyhuCgTeQmfbmXBnbM7xUyvX+m4KvqW/YOnc9H1ngzxP06?=
 =?us-ascii?Q?ZaBMjTuF/XtX5N6oYK098WBlh3ULqOJua7SAfm+dhi5pJS7T9tRDzYo0SEx0?=
 =?us-ascii?Q?8yYhk14gyXvdyUhGy20dOECgY3f3022Yr8J/yjoz2OfwlsiGKbi7DxD1P2Kw?=
 =?us-ascii?Q?F0pOSbvCylFOx8/3aGmJVs4+MO1ZNoLhdbQQX1ZC3R9nZIhUlPqP/jmgMG0g?=
 =?us-ascii?Q?nIlWEzg6l/yT0n76HvZzk33W1URJ1ILqh64FnJY9Lj/VkqdbrbXmxHiD9lOa?=
 =?us-ascii?Q?nvLMmAnmuoa6Ms5dPkOHdhUhaB9+0CkOcaTGwmy1gJ7+u7NonQh5OukARRYX?=
 =?us-ascii?Q?z23KT5jbDhkqqGXwAxW6EDWMcTcN2JJL7BQ2C1goOzec8EZVcM/geh8kVlO6?=
 =?us-ascii?Q?OfJoSeIa830rfw5P36EXiqnUYmcbzn77bkxupOWD3H0ecyv6X2XtQY1Yghjb?=
 =?us-ascii?Q?56YtpJsRCxPWTzlVe1jTLoJwAwj+ogDdHN6kSQxGV1b4kpQvifKs7R+iAdJM?=
 =?us-ascii?Q?ZqJz9h1M5d9Ux7KkvRxoo8ZKWjW0qs8SgUeBom3WmZkWVVquCUT4RjYNrYGQ?=
 =?us-ascii?Q?JMMKv73eSbm5TSaPUd8ny6WVPgd81zDk3URYmCJWeNK2B2u57iFP5V4eFFbb?=
 =?us-ascii?Q?99BCf/mPeWRigORiJirW7aHi0MIW1/GZXC7biqKfiBmlCGwXciPWaQ4UNNCC?=
 =?us-ascii?Q?3ryl/ESvmFeWTH8GSmT3daPkzOQ9iZ1hF2NrqtMpNeo2166jyDvcNbeNxfHQ?=
 =?us-ascii?Q?opRqMVbjoDQkSC+2wu981WVByBlvkptH1XwKPuOAQp1f1rJu3Omj2vvVjKMY?=
 =?us-ascii?Q?XVgAoOTWZFMQ/U4jaBo9m/FqM4vVpRCRmXeoyy/xooLno2mYvH31KM89A27D?=
 =?us-ascii?Q?nuBc8DxpxxRKamSpKzinUYtKLmUUN2YueMopqrk6IyuaMq1VRwNoY/9njjGX?=
 =?us-ascii?Q?4zXzvJKU8DCRTPXOBJYW+ONskQiyDrwvQcUc0WdasYYOQ2gQ4LaaejifwSUu?=
 =?us-ascii?Q?SMUSO5dXTP1HS53dmbPonjRqsqlpJPt+IYCXKaEZytajewSaZ+r8NmPK8Agj?=
 =?us-ascii?Q?kQNmtIZ1g7X1tVI63RifywwdCJY13CacTzFdaGVbyV1mBW0ahJxmVGht5Ia7?=
 =?us-ascii?Q?iGjAs38YfLs+nCIq6JyHdDga5lMrFrp8jysLs/jX8RtaaBfMn0zvmEgtteeW?=
 =?us-ascii?Q?SqGOvv399fVGuenp8xUC2tHYVhrB+GF6vccja/VAaoNW2Mxhpqn2b5+8nsl4?=
 =?us-ascii?Q?EGZPl2x6IyX8uNuR0gT9Pq88vDpzEbr8q5LU+54e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b03d78-f244-4a13-a2c5-08db8aa7e8fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2023 11:36:37.5930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSSUP0lwuXE0+hsJZAJiauDj68+56WYTwSaX6Hi0+9L6cJ/9oJOdqkzbZbBDtCCLi3HAeS0Zd+AfPU31hKcpPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4518
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The API has been fixed in commit 0912ef4855e8 ("mei: constify passed
> buffers and structures"), so there is no more need to drop the const qual=
ifier
> and the comment can be removed as-well.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by Tomas Winkler <tomas.winkler@intel.com>

> ---
>  drivers/misc/mei/pxp/mei_pxp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/misc/mei/pxp/mei_pxp.c
> b/drivers/misc/mei/pxp/mei_pxp.c index 3bf560bbdee0..2dcb9169e404
> 100644
> --- a/drivers/misc/mei/pxp/mei_pxp.c
> +++ b/drivers/misc/mei/pxp/mei_pxp.c
> @@ -40,8 +40,7 @@ mei_pxp_send_message(struct device *dev, const void
> *message, size_t size)
>=20
>  	cldev =3D to_mei_cl_device(dev);
>=20
> -	/* temporary drop const qualifier till the API is fixed */
> -	byte =3D mei_cldev_send(cldev, (u8 *)message, size);
> +	byte =3D mei_cldev_send(cldev, message, size);
>  	if (byte < 0) {
>  		dev_dbg(dev, "mei_cldev_send failed. %zd\n", byte);
>  		return byte;
> --
> 2.34.1

