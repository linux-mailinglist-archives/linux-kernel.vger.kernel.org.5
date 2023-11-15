Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A967EC707
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbjKOPTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344329AbjKOPTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:19:30 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2094.outbound.protection.outlook.com [40.92.18.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11B4CC;
        Wed, 15 Nov 2023 07:19:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXqXJqo097Y45Gus6cDkYmmlbo0LIX73+Sdd3zQUxsXZDcZ9FTlNKAwz7DVSW7voXQotzc0GwmMH+aeg82dL8a+cJgJ4hkZURq7qBsFzyELFo4v/0pf1G3UbTDhKzQcYh9Dx22OFUm/zTW4c8U3t26FEiswvw0Oauq6Vb4IGx0z9s+MC83CbA31Zv4hW7nJngIB2Nn+M9RZARwSibZWbd0FZRjQi5xZyvtRha58TyPiYhmyxEXG9i0kjxE8HlJMkk5eocmioAZxcrICCZrpoId8l+3NsFZaUHs57nPgI3CtQUCnvLnpueTmhsiv3IgXZAUpv9vau95VXNDqiEIGz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buy9GDqqwmUflnAEFSnTJwPvZk6pIQLjHQGGYBp0+yY=;
 b=TO/bWofyYZw7wM5/BLu0NI4avs5UV4/deQniUMJQr5s0AFsHc6F/yyIoTS4+Q3MLZje/WwaVt9TzkggyPuIC/n0d1Yf7NNDduuCOmPvF1QS7SON0SUelRD6tjVH62xbC5bkNx6KoLZBEdyXs0/K9p9/8VApAe3CGeMrb7P0XrBGoabWo7hZ1GgGcThPkf7von40gkpOLrENof+kTeY+X64xfrnUq8gqttToOjU1JeY8ljzm0pKYxTkhHPYZPNdxruzHwI+Qa3E47VafDgXwvCiwST52YcFQXfxUNiTjqyGxIbkHJiOPi7c/t3946AXbGxIBUrsogeSOg6fpEjzU8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buy9GDqqwmUflnAEFSnTJwPvZk6pIQLjHQGGYBp0+yY=;
 b=RvWAx4gWXrjFZqUdTAde0bNAhplqvXewVxf6JP1IZHIPw2G+H+DtasjI0gFq4jo08wOo+DvYTg3Q9FcO90ODH9y8U5PC9/bzk4x573l3yUjhoE84WlRJcsMgwtFLS3MZMq21lJtwhOvdEVtMEYSVXg66aw9l3JZ6zju7QW0ZRK3CaNwI/ACds72qNOWhGDziw7R15WVbH/zbCy69mQIvd53aDELw88ir0+RjRP+oVJ4355dRirpSn6lxw4A51W+fJaT7DUwlrms6sWlXUOMFRUxwVgbFofxq9XwtyuNF8CzsXv541CEyYv2N2xTvokunpO3UNg0ToBc55hBj8JrsGw==
Received: from MW5PR03MB6932.namprd03.prod.outlook.com (2603:10b6:303:1cd::22)
 by DM4PR03MB6077.namprd03.prod.outlook.com (2603:10b6:5:390::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 15:19:24 +0000
Received: from MW5PR03MB6932.namprd03.prod.outlook.com
 ([fe80::e204:782d:2249:36d8]) by MW5PR03MB6932.namprd03.prod.outlook.com
 ([fe80::e204:782d:2249:36d8%7]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 15:19:24 +0000
From:   Min Li <lnimi@hotmail.com>
To:     Simon Horman <horms@kernel.org>
CC:     "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Min Li <min.li.xe@renesas.com>
Subject: RE: [PATCH net-next v3 1/1] ptp: clockmatrix: support 32-bit address
 space
Thread-Topic: [PATCH net-next v3 1/1] ptp: clockmatrix: support 32-bit address
 space
Thread-Index: AQHaFkkzTRCkSSk4cE6gdlVZB7GkDbB6NqSAgAFIxyA=
Date:   Wed, 15 Nov 2023 15:19:24 +0000
Message-ID: <MW5PR03MB693283342F5013279FCA8FECA0B1A@MW5PR03MB6932.namprd03.prod.outlook.com>
References: <MW5PR03MB69324AE8F4C54FE03BD93A55A0B3A@MW5PR03MB6932.namprd03.prod.outlook.com>
 <20231114193439.GF74656@kernel.org>
In-Reply-To: <20231114193439.GF74656@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [VEgrxMG+tlk6d7Ek6sDpZx+/NDr8Z6JUF2vJkmc8+Ao=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR03MB6932:EE_|DM4PR03MB6077:EE_
x-ms-office365-filtering-correlation-id: c5894643-a560-4049-d535-08dbe5ee4041
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qv4maWwbm3KUdx/IeUjmXk3RJb6ppM2pT0dCkMpPD5a9LUhgcsLbwJCs4pXo1bWB/aLiBYMqgHJKCtfoqKBWn/wyikPF5v/h/VCUeC1gnKE3akMqNT4c0aLtTV5sSjJuKDQyl1FUQ1+iGwTvnKHSKnqVrTxiK6KBkcFvlogA9OePF67O5tG4wEbd2ywByHrDDMOZ+PRVFE2H2OMErEqwweXyo8g6KjidZuFdByZ/vqNgSzL2ZQyRzqN+mvsuiprrr4xaAls62PzDQucJZJOtrvBYVEznEk08JopEZR0L7eiCX3oMFiMw6eDBAgidq0Fba/kcPis/JbNWuFWN1HhdhRvaO94Y7KZCQWE16LHZlPyFa8heJOV4nEpWqD9OVNkItDpkYQ2ygte4AQBBa2nhLG3+5oQrguoqa02hProkkAz4SOQmBDEG5Gaf6gbnxS7PI/gFiiDFGcNr+WHWtI6vPfHxu4wrVLwk7g4osSbclJPWMr1mw42t2PG+s2hG7Y3TQTdPddyEXdnztfaMQUIqTA4vslO1iY/G8Mdepee6Fml6NlHwllMCJB5ohKujIo+T
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LW1j6VWaHk4ggC+zwYXPOb2GEwNFnNdwMhOwzC7YilIVIGBeMQ5k259093Ti?=
 =?us-ascii?Q?2JtAbqfYkaXnbJzz8nFLERZEsYwZ5C0XjER+LvUHwnw6CqgSVfIuM8+cninQ?=
 =?us-ascii?Q?7x4pIG6HVr3aDBusqxrxJ2RErGC+dQATe7loIARCcsREPcsGcO10o45yzb7/?=
 =?us-ascii?Q?U5/A477lngZaQILtE6eHeI5IaKRPqi59KzO3uX/3yeLbyD3PDVf+5fuwtiM8?=
 =?us-ascii?Q?XsKk9IN7HY4WzA1dVERstUupHd2gyKPJ+qlaNZIjDLf2J+lFN901LrJLHpD2?=
 =?us-ascii?Q?TCKNkimwNfn/5qXIMfuqAWQ9ECocuCnrgxU5wl2V7DofyRV5X9n/i3YP6/CP?=
 =?us-ascii?Q?HG16fHtacQyaG4sR0Xjk/4tD33p3T0Gfrc7Bk4d1Pq8jtHVnc/epzrJbnfQw?=
 =?us-ascii?Q?CtlI6DvuceetH7CQKCiYzoLx4NNojJZXRlAvC1SY3AY8dd4qHZZqw/cRRryW?=
 =?us-ascii?Q?G0jYDHMKYWz1Axsh5bl80hZr2qpVCVWD+WlYhu5QpGejpVLgSDxrRUWaUIaS?=
 =?us-ascii?Q?/UxUYJN+nn/qunL09zW+7qDX0o3ZNXURDSzpmkQDm8pU9mNxK0Xpq/mClXPL?=
 =?us-ascii?Q?1J4Ztucdos8ZF21jHGIcI6NIVlA/P6zsKHpJTp4+3XASCTcKAm8C0NvGhXIa?=
 =?us-ascii?Q?J+Mo0Rvghb3tsC9QTdhyX7Gt83bRLWyZychDduuUNethhJgoNsXFixtAhiqp?=
 =?us-ascii?Q?Bp8YVfFCiZ2h7OymoXDRwvnWpkfFvLI2pxVP6mFd5ZLOmB0NGM4B+xpvihLd?=
 =?us-ascii?Q?sOd36V7R/KJpAFmMkhhFZseaa/8NjUv85Y4vywMFssaE/SzChMa1vyb2wWny?=
 =?us-ascii?Q?e0tJkLKWAoX5fowpbhI9OgIqstSFAGTXDNTugL8GUhYjxTi8PnGOGvJXh/ZF?=
 =?us-ascii?Q?qH2XM+5olmdMiGaT9/8xFpZd73oe1KSKixGWklgiDbTfRgQgbrjjMFdsQGYI?=
 =?us-ascii?Q?wwAGMyENdwnwQXrMJsACjuCb9F6ds4yN8vka4yk0I8ACNQ4h5Ix4IUqdSccD?=
 =?us-ascii?Q?momxNjpOtVahrS2NQi+JqZaQ39Og7pangH6bjA7rZ3pepSsmvUfoJSCDRjEO?=
 =?us-ascii?Q?b6a1dGyEunCNe77RnrpZ7CKYoKaxzhEb8os4zIbQIS+rsBcCp5ji1aU/Rjsp?=
 =?us-ascii?Q?bc3yQmW3U6qT4G2D5K/xBJ9d023XHkjocLDsrC3K0MtHpr78k12icc0BtOUZ?=
 =?us-ascii?Q?gpZ2PSYt8+7FMfMAgHAIZ97/QKfXSGUbW+1fxw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR03MB6932.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c5894643-a560-4049-d535-08dbe5ee4041
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 15:19:24.5530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 1. idtcm_output_enable() still seems to pass a 16-bit value as the module
>    parameter to idtcm_read() and idtcm_write(), which seems inconsistent
>    with this patch.
>=20
> 2. Related to 1., get_output_base_addr() returns an int which either
>    encodes a negative error value (good) or a 32bit address (maybe not so
>    good).

Hi Simon

Thanks for pointing out those errors. I fixed them and sent another patch.=
=20
For the int value returned by get_output_base_addr, it still works because
The expected addresses are 0x2010xxxx so they are still positive for an int=
.
=20
>=20
> Removing IDTCM_MAX_WRITE_COUNT seems nice, if it is unused.
> But this doesn't seem related to the rest of this patch, so perhaps it sh=
ould
> be a separate patch.
>=20

These minor changes came with one patch from our side and it is related to =
the change due to
the code that is not seen here in the official Linux repo. So I am hoping t=
o push them all together.
For easier maintenance from our side :)

>=20
> > diff --git a/include/linux/mfd/idt8a340_reg.h
> > b/include/linux/mfd/idt8a340_reg.h
> > index 0c706085c205..b680a0eb5f68 100644
> > --- a/include/linux/mfd/idt8a340_reg.h
> > +++ b/include/linux/mfd/idt8a340_reg.h
> > @@ -7,20 +7,20 @@
> >  #ifndef HAVE_IDT8A340_REG
> >  #define HAVE_IDT8A340_REG
> >
> > -#define PAGE_ADDR_BASE                    0x0000
> > -#define PAGE_ADDR                         0x00fc
>=20
> Likewise, cleaning up PAGE_ADDR_BASE and PAGE_ADDR doesn't seem
> strictly related to this patch. Though perhaps I am missing something obv=
ious.
>=20
> ...

The same reason as above.

