Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A84778C801
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbjH2OwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237077AbjH2Ovh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:51:37 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104731A3;
        Tue, 29 Aug 2023 07:51:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0GJuZmfoZSncUrAQkJjWoLjSIZGgha+UDWeyK5FpgQj63EQMbLJrXhbTsrtRRmPjEwcTK2vHixr3yIL9aPSAb1TIKorMMXNVXv5gmUPrAUakBbLW8Rmi0e4sNdDFkMTiunYbpGQ3TohQztxGlwTII5uoYtA+wanQIRhP8NrM7SXCG9974w5yCRTuwIvZto4ZxDL4pYIM+P92Qn9LeewtmxUfHZpHX4l0aSvj1JMqNCu/8hec5QcTgSKiru61vKjFxeJ2fMIoelZCWmez6sUpMO0B1HXYxTwurBUg4mc+u2HuL5um7f2Xwvr5tKG4Gl4wyN5utW1vejqh2UPiLv8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+euhfP6/7mB08JAy/wz8BdRIlEvtSon2KvXf0XlWp0=;
 b=PuQz3xKk21J4U5r3wDkjYLtbmDikSoYDRsphXjv8rKOkbpLqKtA2p1cXpxKlo6ohFGdqkMAExivFbVJX/mXUh51HpIdLgoSObmECGZQrHyOcWKUBEf2tH3kXz/Euob27mS4AfNGB5pxKSrSEZMzEj1XQvcN4NHJj5eXSjSgkNdyoMr+zlU0OmJsYhgf7IRahxtjB8/daKI5R0QkzY1pmMKOeUL88/FW6gJgaxEQ3bYdIR3fYkZADUmc8O64aCYhSvB8Fp7vr32/HiDorfGxdeEQY2uQl2u9vmZtL3v+Vb8gfzVictjUM6XAmj0WDKMJVdYwtl3P8WI6YlsIb38w6oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+euhfP6/7mB08JAy/wz8BdRIlEvtSon2KvXf0XlWp0=;
 b=j+evGxr+bvolRHM49FatDTfb5uIraL9EE9O2KSAgQkC4kaQqoACuY0gEa+KySQY04Rp9Tb0e1i0Ti7QtSV2QN7B4tlCVK2ARJH71eqpXrkISHdQYZ5sLNtKssKXvatiIA3ZaqRPJ8mSEMZzAI+tglcRpC3sLnZfkvQdrS9DPxyo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB8539.jpnprd01.prod.outlook.com (2603:1096:604:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 14:51:30 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 14:51:30 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] mfd: palmas: Make similar OF and ID table
Thread-Topic: [PATCH v2 2/2] mfd: palmas: Make similar OF and ID table
Thread-Index: AQHZ2cTJkhjA2pJYZUWMs/kEqnV/j7ABW6AAgAABQMA=
Date:   Tue, 29 Aug 2023 14:51:30 +0000
Message-ID: <OS0PR01MB5922DC4C709B3A6AE891423A86E7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230828153144.75479-1-biju.das.jz@bp.renesas.com>
 <20230828153144.75479-3-biju.das.jz@bp.renesas.com>
 <ZO4EwAgDU0yefC/t@smile.fi.intel.com>
In-Reply-To: <ZO4EwAgDU0yefC/t@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB8539:EE_
x-ms-office365-filtering-correlation-id: 2bc34ef3-9c58-4b02-b2f5-08dba89f6e49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: duI78sEVqkfVZJmB+BGAKzPuLGlyhfxDf0jzbpN5qhoj9WOZz6D8QlPt8mXGtG85+Mr6D0EG4Hr1OS+X2ihNsmRAQVnG+4DZ9T0bfq8VoNB2UsX90WaDGoM3V0crKIij3mZfdbg5MAFp8JKdrGMZobKHPWuboUyHeB+A8p30uifS3G5vhPryT9Ch43OE8KehnpgJmm1jCmr04aKlWUZO54d2jEmSWwhmLLyG8hVUVmnkb4g6EG39EfHiKWoWJ0tYL1QfbxlxQEjSNwb3pTWx0rieZSVbRXiNDuaybRd7Av8NG1lwkCH7u+QzygIv5x3aLMBREPb5HntKvI3A3zvMnFhEMT9/cgoJoWxhTzuxSqYXZk/HADemMPRQE2a/z9+9zjuDJOZkz89FS2hJJoT2hh5HCEaR1IXgRx6qTniamAQYaIG3EdnFgh0jm9/HkHwXvnqxQKdUXhKqcaTMbud8O4xQhDFNvE0mwtiEipbmc/LowvDuIgz9xmcgJiUPrr1fsaRjfiTwPLYD0Qt6g+r4Qo+RGoTKKYripwNr33WfpK4sba97jomvTu5aHmkq3kFY4eMB96YyOjMNnm6NuX/FPbPR0C73qb/3o5Ec/H7GaraVqeJTt9MDHL26KepZo1Zo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(186009)(451199024)(1800799009)(6506007)(9686003)(7696005)(71200400001)(478600001)(4744005)(2906002)(76116006)(54906003)(64756008)(66446008)(6916009)(316002)(66476007)(8936002)(66946007)(41300700001)(52536014)(66556008)(5660300002)(8676002)(4326008)(86362001)(33656002)(55016003)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U6cC9Z1A1PLzYj2k/89Y18oItcam7QZdyWliBLP8VE3GcLlXK4EU3H+KR/hu?=
 =?us-ascii?Q?nnmf4s4NW+xe8YSXwcpP0rdEj//27aEdIlwlzC5REZzAC9K17CzZUWyqY5py?=
 =?us-ascii?Q?Mm7eLKD5bRixRFSRSp5FH61G5vkBODUHSsrVslfPaZt6RwbmCh45v4L1Kyhu?=
 =?us-ascii?Q?xCGwrrH2QJ86XV/cVXZ8gRlX6V7rWVyY/kv5zfGl0Th1kpfGujAkngyTw6ZL?=
 =?us-ascii?Q?2hiSmrRw/92vCQdECir1nKCfCG01kI5En9NDZ4ljhskO+gQENP3I1+1VCaEs?=
 =?us-ascii?Q?oFuTQ4Nut5pTZjqenzJnKuyZK1SMQWutUg8E/96ki1cJWZZO07pgPlCUbZHd?=
 =?us-ascii?Q?4+CyF/0UWg1Caxrx0/dzERLAKMHG9tBz7dxF/h57cSCtg22QM3jkcpod41s6?=
 =?us-ascii?Q?LPfsBRCutBy7IrK02oTUeHtoaCimbGbaY8JJpgdy9ynnx2eGn9PDr/owT+ho?=
 =?us-ascii?Q?YmSL4Z68bQ+Kio7uleUvpdfVW9GSaHo/Ze5iy9VO9oeatFtEIf2o+acHVXd8?=
 =?us-ascii?Q?sfJ4oKwNpyJycoJGOlOOK2NVxbBWFXHn5aL6+G5CGseVlb4G1N2harNpdwaj?=
 =?us-ascii?Q?ijojEUXndQbENhHjlKUcJd88PCT7xK/gLiHF1QaJwW4aU9FQLjknYLIuPjgY?=
 =?us-ascii?Q?Ft4/Oyk8X2hhTxD+LH46OgA//rf+sFXLJTLFaXs44RDZpAzfrTN/F3Nat6yq?=
 =?us-ascii?Q?Mkt0C4GrVoW9fHzC6yaHw0QGlb2G2TTOK4EQ0rPm5FPyLh6czO64JJHk6/yQ?=
 =?us-ascii?Q?YWGoGy8UhhUQhKUSvomI3njDuBxYXzqjSw2t77lUGnl5rNz8M1nYYTxbDnnw?=
 =?us-ascii?Q?p3nu4VpSM+f9qdt9WguaC5sRpSY3WMtjnKFaXsBfBDvG1zR+bLVi/a1OCdJx?=
 =?us-ascii?Q?vrnRRVwx+epzYS36rl8RS9psDsD50U4afObg80KYJw7RC2qJyaqhpw8RhvY9?=
 =?us-ascii?Q?B1kaF6LiXBr/aCgmzs1O3Fd+XRITEArhbGsC0cC4AIGqxmSLGyfLr6b2Mv/X?=
 =?us-ascii?Q?HZPfAYlGhBu6pjIEdG9k9d/5dPjECcAEe8Fn9BepIOfSlOg+FZZLacKjpV2H?=
 =?us-ascii?Q?Xa0HxTPVorxf9LpCClOFiT17iMClrcVlVnAKa5DS3UEKCHRSF4d1uuDXTG9a?=
 =?us-ascii?Q?NycoGKD3XUzCtwRulnRodxGgqy2TfuDIKIBBI636aFFyKrSd87NL0hykK+qI?=
 =?us-ascii?Q?WylOBG0/D4lerlJZxi+99mslZNRVpHDvFrA1AT3wAnbjM0E+aFg5n4OmiZTy?=
 =?us-ascii?Q?7qVxuk+cRBgaH0F9Z6AdhbMWnPM++C8IeDPzMtJ9bELR3PDSt3HVuUuRwH19?=
 =?us-ascii?Q?pS2JpFAxMoY2M1JNTX6bDOusMIxgID03TJXzMc+nlpYaui2VTE8FvHfOQK7A?=
 =?us-ascii?Q?NUyuWUJSE3D8C5Zd5EyQPrdZa/G0NctvrMXFivLX2Xhsd747R1/9Z4RjHF5O?=
 =?us-ascii?Q?gD7lupCnlD3fEuXleDtO3l2VoSUUdG5BLEUW05+Nr8qA6/pRN+8OuUxkwLf8?=
 =?us-ascii?Q?tfBWD7IckDLawJJ9pnK6bQnTDEZVhFHwcOC7/Wc5r2D+xN1sNqucOe9ApvF2?=
 =?us-ascii?Q?3IQjSgfLnp+Mqw/iGkg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc34ef3-9c58-4b02-b2f5-08dba89f6e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 14:51:30.6623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r/8pOYPeJuP5fm8zr3OeaAvtI0OOUwy4nxcBRz74Aaaz/8G1UDZesoK5vi9JdtXkuFqQwQpFDEAqL3Bq3Q0+6TUMo6Z/IM5GxzFTsLrRqGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8539
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy Shevchenko,

> Subject: Re: [PATCH v2 2/2] mfd: palmas: Make similar OF and ID table
>=20
> On Mon, Aug 28, 2023 at 04:31:44PM +0100, Biju Das wrote:
> > Make similar OF and ID table to extend support for ID match using
> > i2c_match_data(). Currently it works only for OF match tables as the
> > driver_data is wrong for ID match.
>=20
> ...
>=20
> > While at it, drop the inner leading commas for ID  table.
>=20
> Are you sure?

Oops. Will drop it.

Cheers,
Biju

>=20
> ------------------v
> > -	{ "palmas", },
> > -	{ "twl6035", },
> > -	{ "twl6037", },
> > -	{ "tps65913", },
> > +	{ "palmas", (kernel_ulong_t)&palmas_data },
> > +	{ "twl6035", (kernel_ulong_t)&palmas_data },
> > +	{ "twl6037", (kernel_ulong_t)&palmas_data },
> > +	{ "tps65913", (kernel_ulong_t)&palmas_data },
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

