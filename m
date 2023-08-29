Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA2D78C80F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbjH2Oxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237129AbjH2OxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:53:25 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43A5CFF;
        Tue, 29 Aug 2023 07:52:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8gAoad4nItN22hiZf775NGMTySrMRRVuc/Mey1ZKPavs0GwfUWMuPDjpZCC3NgH0fZa+eFfsAXlBnk/6Wq8XsYLKWtnYxGCA57SV2D7Q6Qm0z4ZlM2ZXp5zv+1wumpY4Da1LI5Nr9QFgioBNsRX6vwR/MHjtC2pJ8cqbj6wU8ZPI+ilr7swWzV1/sJ77SSI71eeJBSGRNn//VHrkB7K3jcV1hkTpK5vYRImnDK0q1X6tRN15ArT+HncqcbYOIDMalVORsxrZvG6nAr5+OWjPsPF9DK+Vr1D/pQhW2E78kN+oyY/wqtU5fyq2B7jCwBihC8thvr0izU9bz71EETBEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYp8zYY8IEQyfr4Q4jpAnGPyGO/ymjbQd7uLPGNwJSI=;
 b=kKXycuYJsChShnfBnnGeajAik7hGRcWePgaQ9jJD2dqyE4IYRK+bGmpnpzQYdXzqq6a13iXPvORKKrVPTUOI8KKb8yTFBdin4gGO9ahRIhj1740WYExRBH1U6/Wu2PKKNJKwBALx1t34FxajKnYKxBzVM3aypPQ2jvZhIXVB8LXyopsavB/HkfrNXRfoeQgMxYCqlh1O6MjbRbeQGr8B/6kG6AOzILqMu6FDC8CnWaCjAlhV2hBJ//rYaw8p2wbmZejcM4+3PW7u/wlK0Ilj2DlXmnIaPdK17LlYN8OoTgmnQOcP03NwaMu0AscbNotnyW7WSsbtUxkF+trc+MzlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYp8zYY8IEQyfr4Q4jpAnGPyGO/ymjbQd7uLPGNwJSI=;
 b=RynttV3Q+VHlX1uX1FD7qLbFGwaHdeckisDwQmoapib+vNTDsrvJhR8Rce/Q+taWXb+sxDTf7/BuLVyucih+n8Jsafrn6jr9V7U0GJwuL1Z10817Dy4buNb2XW4aP5ue8ons1poRX6cPpIlma08ZxJV4dj0aHNAzLCYTOp99lFA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8520.jpnprd01.prod.outlook.com (2603:1096:400:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 14:52:53 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.015; Tue, 29 Aug 2023
 14:52:53 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] mfd: palmas: Constify .data in OF table and
 {palmas,tps65917}_irq_chip
Thread-Topic: [PATCH v2 1/2] mfd: palmas: Constify .data in OF table and
 {palmas,tps65917}_irq_chip
Thread-Index: AQHZ2cTEF5331d3KJU2wmqA2zA0JXbABW94AgAABQ4A=
Date:   Tue, 29 Aug 2023 14:52:53 +0000
Message-ID: <OS0PR01MB59227A745D1750BF1150092986E7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230828153144.75479-1-biju.das.jz@bp.renesas.com>
 <20230828153144.75479-2-biju.das.jz@bp.renesas.com>
 <ZO4E9MoARF3IMtvH@smile.fi.intel.com>
In-Reply-To: <ZO4E9MoARF3IMtvH@smile.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8520:EE_
x-ms-office365-filtering-correlation-id: 6f5c9e05-6cf5-43d5-4e48-08dba89f9f9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dEYQa/ONvBPyo2ydwFwrFyGpGaDQ4h0gQ6Zcp84Qn0bdOuNARnMRw1NKHnMzRR1RPIFAQkSvykuN2Ip6Uj7GstifymvKEKt2bTEebWMmIWO0Wz+hx/aY4Oac7v855RPTwGNW31veRDxeq1HHso6xNXHRwgoaNwS7c3W17NZKiTYOUvev9veVlwo3DyuQ8E7Zg01UTqvCYDSerTBIPxfawCTSd9r+lNyCYRzm8XaD1sdcU3hnJQJh0p09HclaGAHbOB6aocwLeLxP3jVNUqKhGg+YIzhJkAsD6Cgl0tdXB+rES5Ekr2dk6pXTyL0CwtuPhWRGjELTPBvvJOTUy9CVDE+vE/nrkjWhg68V+c83pxWOlEuGUoPrWGEs8yxjov3RmFQlsR3XHbzk2VacyCHh2b7vpdxg51qP2RQNnW3uJcZGLaJpd1RFPthKtU4NBWOwNuohh8lUV8KXGSnmh68ld/124SI074eEEupsvqGxc7GbF/Zv436c2u37en0xKWbH6MpXGL6JAUZLyqahnXPscJ8++sjsy3GqYbTT7qmY+klAhWa6rsRgZpVTMH0tkt35i+Asyh967Gbl3VZvIY0GTxVEsx88C32LlXwmJX8odxMFJk7IiRZvF/QYrUmQd2uL9LZk789kRmE5pl5Wwu/z1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(186009)(451199024)(1800799009)(6506007)(9686003)(7696005)(71200400001)(478600001)(4744005)(76116006)(2906002)(316002)(54906003)(66446008)(6916009)(64756008)(66946007)(66476007)(66556008)(52536014)(41300700001)(5660300002)(8936002)(8676002)(4326008)(122000001)(33656002)(55016003)(38070700005)(38100700002)(86362001)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+U1M+PSvVbs7U0BBjt8nL+FdYv4+9tmkA8yZjfElhTsTuWMojYA4uqpYEwx+?=
 =?us-ascii?Q?4HMGko7H79I3S0DguJct2Icw4XUppVXjwYHrfNXnQQ4B5Nikjdz5nItc+kD8?=
 =?us-ascii?Q?IUTAS8MxXaS7aAMj3jnrBbEkunjUXSBzukq70XNLYHRU06CuiFFiVegZo/hV?=
 =?us-ascii?Q?FRWav1iM5DN6TPw/wFoG+JH9IsgH/AS6pyUukW0StnJDc6HhgtF0nlZVLQf/?=
 =?us-ascii?Q?dccmVyYz/+R/vf9z9ZjFl+92eaZEzGfaeY8Wey1H3Iaop62feKI3f5EO8FdR?=
 =?us-ascii?Q?1B+Be/SpxNn7Tk5P2kyyNIPssh2uQm2AL3x1nrLT1Bl72fXGpQJCFSkeRrFo?=
 =?us-ascii?Q?VsJYUDXpEAaysw14tHMF/5x0TVv5uXXCMAaWgWGMaUJeySgyDj30buXm6wlj?=
 =?us-ascii?Q?Iz/LwMnD1WpX4uPIBZDN/OdBp0/TaCkvBili+epdbFETHiH5KtUbO8MJoqdC?=
 =?us-ascii?Q?TPvRxKUr+VX9V4xJSoAcNgh3ys5oYHmJ/1/6FULoQ3fl+38qHfJmPVmDhW43?=
 =?us-ascii?Q?OtB/SOCVZVQBiFVDe5LPVLI0PZcSg0KG9quFDvgyxWwnETMWe6Y5pEYAhHQA?=
 =?us-ascii?Q?FITKMT6JnkS8YOuNgQkMTUkd2mWJBhaccOCop7voU9wmTUlmjWLz4zmTYI2b?=
 =?us-ascii?Q?U58K2Hfff8Da+fiGVj2Lu3K3AX1Ei5uPB1VQddZuElxiYs7LbGEpTMLx/5/5?=
 =?us-ascii?Q?bUkLVyMUMr9XUCr8fkLmoPQ4p1dAlX2nbxmobCojK8rGpbJPF5/qEnSky1e+?=
 =?us-ascii?Q?nLk5Ejfw4P1/DZ2vjC00171ypP2YOIKeQWn7N7WaZdtSTeHUli8sb8TnvN8f?=
 =?us-ascii?Q?suGMXCNdBdcQ4WvJbTwfl0nIfeC/KiljPC0yU4QsjAQR7gD3kdlbNvHNkGc7?=
 =?us-ascii?Q?6mypGRjQMDOxSOV9Zd7xN/w4R6aDA/FplMByZiQEYfzs0oE9xNnxPmzdo0aL?=
 =?us-ascii?Q?oK2nukSbCJsIdjXob7izYSQYCb94nHfaDw7swk/ULptz9bW66DENuPxWvnYQ?=
 =?us-ascii?Q?QOwccP3ZDIQWbdOF5eHUBpUVLNQiy2ghuScfFRXcI2jtwjnJBAS/unDXvHIL?=
 =?us-ascii?Q?MPoutr/jJxAgJ0P2Q1E3FDvNtgYZ3+biRuBi648AZQWunUdkPjjgv7XNZdXv?=
 =?us-ascii?Q?o72pDaWLHB4yQ7bFQZMQvnAqDuHOXSbIiDuScEcdPMO7seaSxmtYA946/aEb?=
 =?us-ascii?Q?q2AchFgRCj4xB0car7reW7KIuCoHGNGQPFwfWqY+nutbPAbcRGnli6MG3huP?=
 =?us-ascii?Q?msCLVI6z7HaZvHDaeGtgqCqXuNOIl/+5CeIsnVGl0S5RkBl8U6KSEMHnnVkw?=
 =?us-ascii?Q?sbXV3cOkNL944tn5wOah6h3sPDthQgMmrALyFbdoBGLw8IizD1yLtXrqyjzz?=
 =?us-ascii?Q?HOZ/rHFxmo5qERXr2GOHIm1mj76cYKWZNkJzmFectCInY+1pw4i7JjEmXU6F?=
 =?us-ascii?Q?+jn3ZaZYwENvyFIpqIn7Ozzxn5bnOuJ9sAgeHoVGATvtmDF6w4i32K1Ukjil?=
 =?us-ascii?Q?V2dPSynV0Amg1JBqgTYcklnx3agJKzMJyXlH3avkbuz/hEkmclNYWef/N9NC?=
 =?us-ascii?Q?2OkW9L+1J0KOzpWP3ak=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5c9e05-6cf5-43d5-4e48-08dba89f9f9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 14:52:53.3632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24zBXrLBpgFHEGb8uYn+2N55g/K8w/TUgIIc42p4V4ZYO84sdjpkl+s8cqp3790ohS4GIRYoCEOTGi4pU4gsjdTjxxcyp0AZLsL++mR72ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8520
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy Shevchenko,

> Subject: Re: [PATCH v2 1/2] mfd: palmas: Constify .data in OF table and
> {palmas,tps65917}_irq_chip
>=20
> On Mon, Aug 28, 2023 at 04:31:43PM +0100, Biju Das wrote:
> > Constify .data in OF table and {palmas,tps65917}_irq_chip and replace
> > the variable *features->features in struct palmas_driver_data and drop
> > the {palmas,tps659038}_features variables and use their values
> > directly in the named initialization.
>=20
> > While at it, drop the inner leading commas for OF match table.
>=20
> s/leading/trailing/

OK, will send v3, if there is no other comments.

Cheers,
Biju
