Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C12F799CE1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 09:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346365AbjIJHDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 03:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjIJHDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 03:03:19 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2127.outbound.protection.outlook.com [40.107.113.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4861CC8;
        Sun, 10 Sep 2023 00:03:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGBOtEiEWkzerNLNkLxTFdP5vpMlA3ElEmmFoHTUSqUFhue4QLmDzyutw4Tln7yLjXonDy+GgTCFqBcsOtXgqELSEULenom0DdDSue9uGyN6w73+P0nrRCiUwnhzf5fT7xhGthiXOfiST+sO9qX7g1yLwpgwT7zs432NLh1V9Oh8z9YsfyVqw6l6ZTHp8CK+2Qcm+7Z9OvwwU8ZS7+Pn71TDih8e8jjz998HDo4g5GC46jxgSv0EnLR5fwme6ioYEeyIVbiW59mXbDLnl23viqnn8gwiFq7VQWktwGDqfeAP+qdYkijVtrfxI26DUjbr/cYrXavq1LpMXoSgVuX1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0plBLVQbvb17JOWiEMbHFHSXz837TxpAxBtyYROXq1Q=;
 b=V7IIbhDYtbllX+qdb12I2UsFyemaGbN4YeKlmxL2/iCl1evjcnMdMry41M3uBHOyL/xUcPvF3/kad5EnNEt+Y9njCzzLwxG56j55CmlNusLuzdH5UJxMkoC1Mzv/l8f5lyrX3J2ueNLzh9VwCzqjC5Lr+yRwoiIBJlcana07TY1Hff05mKnpXy/2jmlDcWD4vZrGUg2eqo9Wa3B6YIN+4q4zQzplJ2On0w0o/jXkUHjw44X9lFd0SOOx9AvDCxjpz9rjlboti3XehdAgUHNWAQU00zP/ufYDukwCOvaFLsdGw2l4EoEItfSpBRtGxdCRqXZLIH/F76vlC670sGfQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0plBLVQbvb17JOWiEMbHFHSXz837TxpAxBtyYROXq1Q=;
 b=InamO7D6JksAGDoE/NHf3MzI6bTS44c5sGVKc6pNsntTgdr4mHOpR9icejJhtfQfXRjF4fBVg862fPvVziwGUkDl2TTMy33J2UKKtTeQgc5eUUazK/qp3sx5NOHCN+poztmV2vpBQo4S+6yAheDZXvoqWMZmjVEx5gTvXtMx1qg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB5917.jpnprd01.prod.outlook.com (2603:1096:400:47::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Sun, 10 Sep
 2023 07:03:10 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6768.029; Sun, 10 Sep 2023
 07:03:06 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Sebastian Reichel <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>
Subject: RE: [PATCH 1/2] power: supply: bq2515x: Simpilfy
 bq2515x_read_properties() and probe()
Thread-Topic: [PATCH 1/2] power: supply: bq2515x: Simpilfy
 bq2515x_read_properties() and probe()
Thread-Index: AQHZ3djR/q7nIwJphEqZKCraJ2Znl7AKdOGAgAk4b2A=
Date:   Sun, 10 Sep 2023 07:03:05 +0000
Message-ID: <OS0PR01MB5922163C432F340877CF2A5A86F3A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230902200518.91585-1-biju.das.jz@bp.renesas.com>
 <20230902200518.91585-2-biju.das.jz@bp.renesas.com>
 <ZPWtg5VU4S7InmmL@smile.fi.intel.com>
In-Reply-To: <ZPWtg5VU4S7InmmL@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB5917:EE_
x-ms-office365-filtering-correlation-id: da423b7c-8753-4b8a-2caa-08dbb1cbfb6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PcAo0S7n2+dpdh/F/qZ8Om71JU7DFK96XwTNRjWnzT4YJlz57lDXcrx5Lfndg8ozBlQKLCTkepQqUUCXF+2tRTLn+X0PChQi3wccfpXs4NviZ1xvpGy4+oISJqqS/DS6PFRbW5vFLtTWrDOcXXk3b4/5ZVTOqzOzRo4F6CqaFUdPjPXcMVemlF1k2Q+zZ9p4zNniv0bRSrA6Eo7YBGzh8I179nNXVxacNlQadTGhDEnF/PPEg1Zbe67vI1JuYszjr52mxw0VzfUFtRdpdFg35S0yq6sfGagnhgJ3PR4eqcQwji101DYYLgK3A92hY7ocGT8/fxfbUUWcJ78PhoXao0ZB1qLjP6RPTtUT/nZtKkQYbbCe0JJAGf2Hy2L00VEBfoDpl/g5qbajnpE0jSM3UrmndiQonqlknwm1t3v2CnhrYkb0PXQYMmcST6/ZPTG3PLXqx/3V6T8D161iup7nNsid7CTooMw7waXDCm5ZZs1ke8pnXdx6A714s6RdUZzJ5RaBk5B5C8QaxaYwYjnoxHnR5FKRgDerSU5rzpJyTQ6fGzOiSo2yDFEw9BiRE2C7WX6P68fVZB/DCcVH/DYOOkLlICo/LYdFsmjZ6F8uDul79SKb4wUSQ4p+qKTAerdR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(1800799009)(186009)(451199024)(6506007)(7696005)(71200400001)(9686003)(478600001)(26005)(4744005)(2906002)(66446008)(54906003)(64756008)(66476007)(66556008)(66946007)(6916009)(316002)(76116006)(52536014)(41300700001)(5660300002)(4326008)(8676002)(8936002)(86362001)(33656002)(55016003)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G3vCmXyjeQ4QLv4fFKhvs3Tk85Z9BLmBWvEHAAwvLL79PwjbEMHrQ/hxTuNg?=
 =?us-ascii?Q?TDLvGPU7l2WFFu0uQqimWcut8OwlilPSEI0x5kkKA4lRAmF3I3Z98/tT6DWF?=
 =?us-ascii?Q?xN2yXUstoRMb52uMUgxu6OQ/XH7yStoYXc/uYqtWa4N5IlZVRyJOQBgNY50z?=
 =?us-ascii?Q?QFPlZ0Z2aHLhO+bhT2tNJkDVQ0cgPRXS7D4/RY2Y4o3FJAXtz9GsDOsdetf4?=
 =?us-ascii?Q?ZQwDFEyusOq1STsPofVQV5xHcu5TXMnQlzcjRg8kzRlPkGC9RhMLLVFZSG5k?=
 =?us-ascii?Q?gU2bB/ahc8BSOGKQvbgUwm/BrGlDC1BK5OQxcudCBeKcjVjLoCABVGH4jDAP?=
 =?us-ascii?Q?nrsYCTHZwpua17DgnFBWHvTVVbYiwrobBMRxuxBg6CRk1KcaAF0tsqNaLxrX?=
 =?us-ascii?Q?pvzgIMjEmOnaQRuw4sGAu8Qk05J/0DBglqlV/EOrwEd9woYYmcfp1i24Pl/r?=
 =?us-ascii?Q?/3A/VV0lSbhYhFp9wyJ5AsjFlpVgA33Ia5kB3+7WK4z18XBhuYIsuKbRAbS+?=
 =?us-ascii?Q?mkpJ231o1Pj3F42yQoo+uzeMnPftiOowBIUnfjtdKiw1v8yj6sI8tiCcAQka?=
 =?us-ascii?Q?C8yzOaNpWOrb6mBv+tCcNGiI2Ez43LQmKsaemxKYBrJeP9TiGVJZ5io3fkJX?=
 =?us-ascii?Q?jW3/6ob0VSBZk4t+3H1BumGtQtlptIvCHfKrcd9TGFo5skeADWIn/SC0Yfl/?=
 =?us-ascii?Q?YDJkCAeghl3o+ZSLfrAd3aRJ+Gb8InrYnwWyiV4+KEYmOIpq1a8duc9Hm/QS?=
 =?us-ascii?Q?hf3sUiUzK6V2ur5dDFgE/35AfJRPSU0sUbnXZ7kyA8K/+GuutMpbNz+I2wky?=
 =?us-ascii?Q?1EChISn4KWkH+pi7z6ugmZIexWVaXl3k9LhNeI6RmBxMOpOqWBcVqmKQmCNN?=
 =?us-ascii?Q?JKzwhrmhzVKrUqWAzdRm1n77AzTAjjokMOChSsDu1Z5KsCQjCbMysYGj4V+O?=
 =?us-ascii?Q?qHlJWDrCrJDDfqEiRGeAZctwgvOrMWmeRYj+pBf0zL6BpTDNjhJoxDoVUKTB?=
 =?us-ascii?Q?wm7sHb/OsKCk0dP7wtuXC8u1qdeM5f8xUXUXDVP+RwjLlOlJbJQTodoGGPJB?=
 =?us-ascii?Q?9ziwUEX7pHAgq2SD3DfhPFDwmGf4SR1rc29ZrVg1XcHDvDfPAkdq/OfeVhiK?=
 =?us-ascii?Q?rOsXdC4KoqFLHFNEc3AOfrhjhVHTFOJVQP2GIXf97myjZ06kNNsKyoBmBe9E?=
 =?us-ascii?Q?E78xTwmkhkvA2Jr/KddgU5SvEi2lbLhEWgyRCt46RJoYCcJZW/wh+bHetguD?=
 =?us-ascii?Q?Z3oS1YH3LHcUaZeMEEXYTUNw2bTDwIdA2ZxnjMuaB/SzVCQlqb8I7MapMH7/?=
 =?us-ascii?Q?1SohRIaD4b2wo9pJ3iW3JKwS6w35pc8+6CJlLQH471xIOh3VBJMSByYEGAth?=
 =?us-ascii?Q?UfLAu1zPpvjUr9NwjqBLGuw4S+VctdXdoKew02O/XmdNWPLE+NDo2vSoVVF3?=
 =?us-ascii?Q?JDpEondwor3adHx7G9vqHcv4VbL6o2Uxbyq13/hwxqbGzfiLIELqav/by4Rq?=
 =?us-ascii?Q?eFXCXtDkaryX2ru3kqBOiAdUigV95CX+rawDN4a9pLSg0pX4xe2SHXaWniWN?=
 =?us-ascii?Q?6R0Ur3J0q1j+3878m/5IFUxfSIgwFVXlg5HE/a2qerA8XRuzGJFyig+Sogku?=
 =?us-ascii?Q?ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da423b7c-8753-4b8a-2caa-08dbb1cbfb6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2023 07:03:05.7863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MuAYTf3uy6hfb40L7wfP5zMXnwRJ3oQNdkvFj0hqzAey3XqQNt0L6P8nb9dovBPXzL2MUdLP2NUB/Rm/Xf9vwlx+ppFgtfTCeRNuRwUGpgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5917
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy Shevchenko,

> Subject: Re: [PATCH 1/2] power: supply: bq2515x: Simpilfy
> bq2515x_read_properties() and probe()
>=20
> On Sat, Sep 02, 2023 at 09:05:17PM +0100, Biju Das wrote:
> > Add struct bq2515x_info and replace device_id->info in struct
> > bq2515x_device.
> >
> > Simpilfy bq2515x_read_properties() and probe() by adding struct
> > bq2425x_chip_info as match data for OF/ID tables and use
> > i2c_get_match_data for retrieving match data instead of ID lookup.
> >
> > Drop enum bq2515x_id as there is no user.
>=20
> ...
>=20
> > +/**
> > + * struct bq2515x_info -
>=20
> Missing description.
I checked this and unfortunately other structures
in this driver are not adding description. So, for consistency, I am not do=
ing it here.

Cheers,
Biju
