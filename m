Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E8177F773
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351348AbjHQNNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351401AbjHQNNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:13:41 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2058.outbound.protection.outlook.com [40.107.105.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC4735AE;
        Thu, 17 Aug 2023 06:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJcWVMsBy5fTEYLypbfSi0/JIbgudapoOYBlJRJRzYrL5aOokrZHAZKgln/FSqKnyCnWeHIle1AhicS/uoRkgomIDVvcNfNk3LQwECDSfoulnV5nONoLjYfYKiThrkri08wN+WN8HbqkowwWoqOhWfAfZ8aS6+IopXETyrvNaDaHwCHWjn6ozupCGI3Z5H1OkspUlUDtDvK57WycPxBN24o3njw0Tscy6JPCv+dTMJoUbqsYJBqcNJUqUmbMDhl1cUszAC6vmbUxAn8s4EZpVfGQ/1GuGjnhnVsZc/qzlxI8sXXFssk5ShChZTntj33S7PrPbP5t8TL0zdQEjeda4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwy0SZMLDl8zuKaMMQzKYaF22fRKBR1EUTqWZK0bVTw=;
 b=GAkdWUflomhb0A2gQsu/iipw66vfM04IX9I1U1VXN0YDbXPTzKGdchk9N0YO9HokwBvJysdzcNdPIBrdYyW4CQhVR2nYlbkecC0yFRGaFuCqa3mScb5vjOdnF6JSVXVJlJRumlxpoZYxCQKHillbs1NQ1FdHLHvWlPMg0jb6FBch0PLfBgVowLNTp4Xloa26ab7Ub8cd8ox2GvZrcCG/PO9dYZ3L8sFYZ65SuCV6buKFmd520ZxEGZQ81mHyi6yjwJ098BWGUcI73XHa0WKDrWD/zH9rJuwABosupdq3T8GsTKYLLYP9mkJ3H7ywyoVkIkmypaVPG0Hg85xrODHR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwy0SZMLDl8zuKaMMQzKYaF22fRKBR1EUTqWZK0bVTw=;
 b=kncPREulhIj+ocNJ4xWLxJHuFH0R17xCfyth2R0sauZoa/N5Vpx5Dveyrr/y/sTSoJlad4yYjPvVfynBwJ3ali/5CJb+ARBo5bf6QxltBdVYVIfEA4x/qTNxT0hmk2TSe6tHYxcNxo+2qEXuXzjL2pB0CcrJef2cSP+OReBWB/M=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB10040.eurprd04.prod.outlook.com (2603:10a6:10:4dd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 13:13:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 13:13:01 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] of/platform: increase refcount of fwnode
Thread-Topic: [PATCH] of/platform: increase refcount of fwnode
Thread-Index: AQHZzRc8Wntpzb78S0+PWGV18SgfTa/uWRiAgAABeICAACOpAA==
Date:   Thu, 17 Aug 2023 13:13:01 +0000
Message-ID: <DU0PR04MB9417B3FE767FA06FFFEE018A881AA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230812122411.3410399-1-peng.fan@oss.nxp.com>
 <ZN39I7w4ARc0WLnI@smile.fi.intel.com> <ZN3+XzfK00vXPiHO@smile.fi.intel.com>
In-Reply-To: <ZN3+XzfK00vXPiHO@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DUZPR04MB10040:EE_
x-ms-office365-filtering-correlation-id: 00efc176-295b-4a80-0072-08db9f23af40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cT9ma//QvFH6gob5+Spzyw7YANH1otkToUh0aOUUxqitHxeGUvU4dnK4g3Ony1PyCuD4/Hos7BNfTecplmAkwa0dWyJuM5m8lb9YxGWecxnu89uxEiLXyFh7/Qjgdj9ZRtHzT99UNhEPyxX4VsYbbuYo516x2UkWDnKn5MLB63zJ+WQRlnuL7JldwywLmO0qWlg6i1PuGxnt+lGHRJS/Xvf1TzUS04BOXYPFFL0SdtOtKGHUIuLtKoWC7DiNRLrawRvfcZaB7ZRtNePJvAKiUBtV23JhH2LOdHyTnONOq8n8M1rInxaPBq3tZc0HIzESvMCUiAepkpgoJHOnB2ObgpTYUx9XXMM5YGAkCAeZalcWTc9qv44V2+WzOqfUwj0EsXad4INJ5VvF30YqmPaI+uxamuLqZmT7J+RFofEVMEvfU3Hr2c1L3LuGzyncbUPVExgHaPqeT4wGq8YJYbjqSGC7BOkT6JpirxNd9o1FQIPYjiodlhFJYwg1S7jXY5nW34rc3SR56CMGak3M+tu9UtLfdgqbpN45SFRYmnd8r7Ky5mcUAj5KwNeBeYl7jq7DDeVqw2IsDGRiZwqvDc4+Ow2R5xKrjWcBVllfI6pBggy5b8gf3rZa1BXagInVmDUi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199024)(1800799009)(186009)(86362001)(33656002)(38070700005)(38100700002)(122000001)(55016003)(478600001)(5660300002)(52536014)(44832011)(7696005)(110136005)(66946007)(76116006)(66446008)(66476007)(66556008)(71200400001)(64756008)(316002)(54906003)(6506007)(9686003)(26005)(41300700001)(8936002)(4326008)(8676002)(2906002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W9k3afsadgN2F9H0a3FkGQLU8tDncxB/tb6f2GURHccH0DuzcCwdYuefGheO?=
 =?us-ascii?Q?SUrKEOVUGT3ugZM82D9QSLQNmLocjsKAlegZxrZ7CS+yhVZ4iiPav45jZjcj?=
 =?us-ascii?Q?9R2J+cz4NXc3cLfedHX1C6LD7wNODH+zbiD6JlOFyoP9vwztSZZ7D/Qqk3v3?=
 =?us-ascii?Q?F23i5INjFs6ZgrrpKJym1944N53PF0PxoftGwc0OPb2ySyQeM7lPrYXahOUF?=
 =?us-ascii?Q?Bi6TuZZttNLDw+vA7GgiZQP2HycqK2U/ZkZHsaQe0+f0ewVCILt88nLA091q?=
 =?us-ascii?Q?ghgpYuA2PL7GUR8bEbRMm4iETvljvLbK5iJKfV9lXqIRzNeNS5+A31YR2tsR?=
 =?us-ascii?Q?e34XM3RVdFMnucAJhl3em68SuUmNvZXGdrc9oRU8qVnX8uS6FiuFFK4Qx2jd?=
 =?us-ascii?Q?lAqJWcbLirxS0dJ+gEgRciDuOpZqwtk9YIWdTK6Ryt4MURF1jbWHqLKs4uly?=
 =?us-ascii?Q?G5P6VIYYfBM8mPhhnIXEb3f3P1v416DLPoAprvdHq5iBoHqdOJqZsVWv4u0t?=
 =?us-ascii?Q?5Bf2tzafsxWhWhFs9huxyTCTgsQ4nJ02O0YXuRGumlfndrD3jxsW0VVjJ15S?=
 =?us-ascii?Q?P7sStAvk8U4fxDwSJLm23Y0aUd7bwVfr9Vf8m3Il9pGMH0L/mUTDMxly0Cio?=
 =?us-ascii?Q?A5HDhK3b+bt3ykEt1GefuGRs6++S0cGNWvOrbMZbAl//p9t88x7q0IueKr39?=
 =?us-ascii?Q?yg4cTTOxkDguHyxphBphmvNgZxG0N+kSJ44z1JoElSuuYA6bnrGCoioxkMOk?=
 =?us-ascii?Q?I4NzT6iwgRL+PROZX6Uoi+l3tY03+i3cfXFV78b9Bmw0MaAkI9Axoid7jCw1?=
 =?us-ascii?Q?JMY5z1TflCD1CIktGZtjvcoEgjNa1aPldjqQjx65nMe587Qf0r93hgyO/VVG?=
 =?us-ascii?Q?+wymvpJLNKvTQd7zipxdxVd8UOoikObObyWVsvwBkncca5NXlUxKLuRHDzWj?=
 =?us-ascii?Q?mJFziP0QmASFxgV2XUJarccTn1Xu45ZEOadWQSS1CoLLWU8Aa7obAK667bT6?=
 =?us-ascii?Q?uyANcVKqtVWLKrDXSw07cN6PtRE9JgCmfZOec3H7QaN0JoMC/uMmyIy1uGfT?=
 =?us-ascii?Q?AZSU7kLhK/AdZGpOIE4Jmwj9FSJ62+M5RycwxeLK34bEjw9Tka5HMlLEt9V3?=
 =?us-ascii?Q?pyvywcI0mzSgL8SOqSlsouB51U2DKYDHCljHeRO5PV7L/oi1ghHIwgQ+bBHM?=
 =?us-ascii?Q?vUNuXC79tjxQHobkTZN8GPlSluqSmaxtL6I31mYHIVTgVUkbZCSC/uEABaJC?=
 =?us-ascii?Q?zrbz7t1Sv8Xvz28U7Bbcr4nMvw6XxK3FlkDvTEmQO3kEqap+8xjGfkELm0Py?=
 =?us-ascii?Q?hO6RSdUpte8QdTteH2rqp9Au/LKbSNfsexoamn56YtLlYZRIQ/3Mhb9WBZTS?=
 =?us-ascii?Q?+v1yMr+XDsVKBeGQUda0hUcNy5VwyVs4HfSK1AHC95Be3HW0z9/mxBgFRQPf?=
 =?us-ascii?Q?AxCvFmGJB59gYjaWtBjOShF0Pg74bay+uyzWHi9kZsxMALnvGtf1qWpBd81N?=
 =?us-ascii?Q?uHcsRl9ogqp1Dp/6X2xnMN2itGEsTeljYGwpkI2CE1tb135dk6hjpcOTcc/f?=
 =?us-ascii?Q?UwrEEBTNZY4yhg8Ktsk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00efc176-295b-4a80-0072-08db9f23af40
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 13:13:01.5495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ToZlTqnt6I7STb2szBE/z0/25hi6I6/WLMsEm1WyrrYsFmMwew4q3PM5UfVqALDE1blIykxy0FU5WokrKN4m0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10040
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] of/platform: increase refcount of fwnode
>=20
> On Thu, Aug 17, 2023 at 01:57:39PM +0300, Andy Shevchenko wrote:
> > On Sat, Aug 12, 2023 at 08:24:11PM +0800, Peng Fan (OSS) wrote:
>=20
> ...
>=20
> > > -	device_set_node(&dev->dev, of_fwnode_handle(node));
> > > +	device_set_node(&dev->dev, fwnode_handle_get(fwnode));
> >
> > Ditto.
>=20
> Actually no, amba_device_alloc() does not use platform_device_alloc() and
> defines it's own .release method. There is no reference count drop there
> AFAICS.

My test only covers platform device, so ..

But I have a general question here. Since of_amba_device_create will use
the of_node or fwnode, shouldn't the refcount_t be increased and released
in amba device release?

Thanks,
Peng.

>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

