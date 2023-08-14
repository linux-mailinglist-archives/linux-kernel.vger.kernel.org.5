Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1350377B1E5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjHNG6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjHNG6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:58:03 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2119.outbound.protection.outlook.com [40.107.113.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C3BE5F;
        Sun, 13 Aug 2023 23:58:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhPiy0/kNF3dqWUQawEQOkeH9k0tcUU2VrkucC1yATSMn3WjYy45jFddMKqSB03j73DhD8wTfp2+gPgVGXbB6rqEsBee2TG0WITVwDfJkybFSzxE/ijqebM+jvi2yt3Ip6FbIhH4HQajd37fDVmujwcDGnhlILG4AV1ZB6taYcI/JS9uRqYHplJCia2CR5d8PMNHF/aL6F44P9gsbcbhAasgqbcHl5orD/GEHGnpv9FhqArjxMFaBrCnFE0vXWQlMc3ghqfnkroaEZD4jSUxYCG2fU4QpNEZs5qLcPWcV76adnkUrg1nmzV8OYdAb4rJ+s9uN5r8O4PkQURAUIuwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrumwWy26P7cL9vj8HLTZ7mnIsh8FCz4Cd7WqO80cXU=;
 b=eOxcRlk+1VpPzSdKaogIP0aFssAuF+yc6KIox6S5uFEAZviqj12v65ZUnpeqxscwIuNalz7IRNslH2ALcwbiktBwqH4wUAU2+Cv36y2mTwJvuuoN+2y/ubvy0wVryGshgLRAJjfvjbFAoHr+0zNx2wNDkqtePXQBQpCbWF6tW7/m0DAuIONdkunfN8oPweTkgeoAu2dco7nellfFw4Ir13sedQpCjPI44Lnsz4maWV/klZtkr9IWl+l3U+gYGZA05TTPAIXxyPH36PwvbBsa7GVocoPEFwxwQ/M/jNY6KGqoXS40lxgbxiln0FWp3ziQ4I/SIQt2t3OSmR3mCFoR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrumwWy26P7cL9vj8HLTZ7mnIsh8FCz4Cd7WqO80cXU=;
 b=Pyns1Kxn2ofUOGuI5q1WAVwskZr8TYN68uH523kFp1eW1bQofK8s48qWd9h10DeIDLEQpoQRvQKfPEm4wpdjABgxGobX864cdMUMCJY8Ck2xbqzZxsvS+po8lEU4B9YY3tLpsjwhzrA5tOrrf0emv1CIa9cvUwe1YY4k2WqUKCA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 06:57:58 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 06:57:54 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: RE: [PATCH v2 2/3] iio: pressure: bmp280: Use i2c_get_match_data
Thread-Topic: [PATCH v2 2/3] iio: pressure: bmp280: Use i2c_get_match_data
Thread-Index: AQHZzhmqGbM3bOJHNkKqVyoGVC6rua/pXDPg
Date:   Mon, 14 Aug 2023 06:57:54 +0000
Message-ID: <OS0PR01MB5922EDF7759069CD4993FA468617A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <cover.1691952005.git.ang.iglesiasg@gmail.com>
         <55f8dc02de16a353f0449bc1c7cb487bd776dfaf.1691952005.git.ang.iglesiasg@gmail.com>
 <954c859835aed6c41a356fdd999a8be51469eb9e.camel@gmail.com>
In-Reply-To: <954c859835aed6c41a356fdd999a8be51469eb9e.camel@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB9796:EE_
x-ms-office365-filtering-correlation-id: bf993c9a-5c3b-4b4a-958c-08db9c93c8c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3jYHwQLLtk9mWNABZuBluwe9Z7u/se1h+o2QGt5imLfwgoeOtFLkFZOEjz1GKRWJA+Ju1ezpQKp2/XRquBexF+/xYpEpK9beQewSSdWMr3aS1FGgvs+7Th9v74YhPBX2lLhsH7YvNg/Q+qyXML4iXSCVA/g5KKQUHXlreP1TPM+OjpvKG8aGw8WL3cPb2kQutuCcml8bRJn36lq/4tzfMur4PTnmQ3Rc1XgzkQ5emM6AgSRH6GKYx165jcepRZmthZmC/unEQTtVRoMcCrpymuJsQHHHSdbVpbXh2KXusfZ1U16vtHVoZHKUWrgy6eviW16p+9S/AUoFifKOltiyYOZWiIruOmCjdjpGiulU+wZRGRjjiZRR9x6+MsGcOondc5sqtgLKOPxTNgVCodMEKMlrl9qHY9DNnIY/qzP4IU1jv24rY6XnuqH9omVnXkRH86ydbqom/DvMhOsgq4WHei8wYiVS28EhcXw0gkAgxZby3sgDZ3Qwi008Z4NpGcm8M7uUeTIVACPzRs8F5dCoB3yjI/cp0zWOTBMdruIK3ikLrzAbXSqi6A4rIGGS9UH/U3phD+FZrrF3sdKA8D2+0GYG6DbVbbbuzXwNpVAUS9M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(376002)(346002)(396003)(1800799006)(451199021)(186006)(83380400001)(26005)(6506007)(33656002)(55016003)(6916009)(66476007)(64756008)(66446008)(66556008)(66946007)(76116006)(316002)(4326008)(122000001)(38100700002)(7696005)(966005)(5660300002)(9686003)(41300700001)(71200400001)(8936002)(8676002)(38070700005)(52536014)(2906002)(86362001)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?23hEG7jke93IrAQ0Y7UFY0c/l3kXh2gWot8s0px+8+Hx1ZOf4LSVIS1VwJ?=
 =?iso-8859-1?Q?zXb8kvnMew0ykaIOWEXM+1xxwqphpd2QQGX1JG7R9v4f1RYEedKZWLWNoQ?=
 =?iso-8859-1?Q?dtxHAJF3zDewzIA6acPZlLAnkhDf+TSx2kynZB5P/fXaerqgeeRAhuuIxz?=
 =?iso-8859-1?Q?WksAbZ9vChPFHfh5EPvDSRQFevDpv4j5yJ7gpbd2VqUaGubzF88Dfyafzv?=
 =?iso-8859-1?Q?VBoYI+P+vnzjyJf5FCjqWjNHv6kpeBvDlkHMgHRCHJCgsB+gnQ6bJyVT3J?=
 =?iso-8859-1?Q?46CbR6ugxS3z+K0h8ggKLhHWTzehGDr1Uw6nPZPzE2VoJYRESjQz1GZVqb?=
 =?iso-8859-1?Q?O85ku47G7Dq4+oQUEnJVtgndPPIfeTRAfv7infsO8yLkesSGYSLFsPl1nT?=
 =?iso-8859-1?Q?P7rb49mADjvAuvq9FgRWU2AkOzj1IWuEB0yNNs8HgVsty2h6IkSHWY4V7Z?=
 =?iso-8859-1?Q?OPRQsGoc+eQiyHoee32JFQCpG0u8rGn25w2hKcu0TkrwBX6KXvPicRRtFr?=
 =?iso-8859-1?Q?XUIFQoKqAvESjzjoOqw4Ljn434qamI7IO4cUpKIh8xNmCUGpn9h1xG9ysu?=
 =?iso-8859-1?Q?uFjR4zUqQb6BzRCbMa6j6K3hGaGzR6V7JVjnqXxQnv99GFnKk4U4+IEzVx?=
 =?iso-8859-1?Q?OkYLV1Zqdd5yWoA03Kgqps2zH3NIH4oPZT6s0HwRrms7CaT9i/KKh9Axzo?=
 =?iso-8859-1?Q?fxa2FumshpO3oR99iCborALbrzUpXeTwiyf/2NnVuKSf8xOiNyjrxvETqg?=
 =?iso-8859-1?Q?7Rjk8xyj96BLHuO/NmshenMC/nSsZiedw9nniZniqxnkX0Ch+ueHl6rw6Q?=
 =?iso-8859-1?Q?iJCm45105IRrNoempNh7f+dF+l7z2xJWVBFDkxbzEc479x3y+WffchBVL4?=
 =?iso-8859-1?Q?vx1D+waGCu22t1UanIyvKgQZaBF41WlL4N/4X6BdC1g/E9Kn65gBQCYWNP?=
 =?iso-8859-1?Q?1LeKLRqVNGLLzww8m7CHKvr0www8ZzwGb9ztlfEC8Z9WeJ1IPrhV4ihZ2q?=
 =?iso-8859-1?Q?kDF+tAjvTEavQ3AX3L9Dgp3cOsdlZGH/hf1lG6e1i9cOkgS+nMTHIrBim+?=
 =?iso-8859-1?Q?a54klPywH4J6e725JlgzM8vOscEbzp4BwtdobezXeQCORo5BA6b5JJN6B+?=
 =?iso-8859-1?Q?KMrPgwLeZHusgV9gjH4LcAykzR6oVc4xwty2cU8foK0b6ji1G+158yL8cu?=
 =?iso-8859-1?Q?zmHbhJpIMA9AUlQ3GXZKwWaPY/dOUt8AdosnipwEqwUTp0DyjmXUR1DUr/?=
 =?iso-8859-1?Q?FRdYxRf9JZd3dZtYYyFiSeeIUjiYMdNDnz0MMKeUKA7arD74hgFCnx9nvH?=
 =?iso-8859-1?Q?PgaNjyC+vAb6u49EjqOucsAS72bxc+IZV3IG3flEtCdrDR/bO+5szelsEc?=
 =?iso-8859-1?Q?7UoH+umyy/RTpWIrd1n4FqNBQTA1xlbdUBFUUROshkxTNJ6jReOX7kAt7L?=
 =?iso-8859-1?Q?PqsyYRAO2KDNi9Bmr6hN4OiWClLvMJV0485hVz4l5CaI7F3p457rkmZ4GS?=
 =?iso-8859-1?Q?Y2IvWYGZKYctnbC9ikXB+2hLTDMX5yVrZDV43Hx1qk/10ITmj1GsMfGg9n?=
 =?iso-8859-1?Q?2NUZ2mI1rIILAEvUsCKtucJyg6/ZdZd4P7jw7SvI+Cxxitl5dz7LVWCkvZ?=
 =?iso-8859-1?Q?m32Dp+j8uwg0PYnmAlR+/ofboR5MBg+m1V?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf993c9a-5c3b-4b4a-958c-08db9c93c8c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 06:57:54.4963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZF6eEuJGlbGKQLLsbjAeDNPbk9LdbPtxdGA3yf8meb0F+RPx1xs2+ZJdzoaPQb8vdNWdpboMxt0JRIKy7dGU4Jk9CteC+7jZgEs9xarn9H4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angel Iglesias,


> Subject: Re: [PATCH v2 2/3] iio: pressure: bmp280: Use i2c_get_match_data
>=20
> On Sun, 2023-08-13 at 21:03 +0200, Angel Iglesias wrote:
> > Replaces device_get_match_data() and fallback match_id logic by new
> > unified helper function i2c_get_match_data().
> >
> > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> >
> > diff --git a/drivers/iio/pressure/bmp280-i2c.c
> > b/drivers/iio/pressure/bmp280- i2c.c index 693eb1975fdc..34e3bc758493
> > 100644
> > --- a/drivers/iio/pressure/bmp280-i2c.c
> > +++ b/drivers/iio/pressure/bmp280-i2c.c
> > @@ -11,9 +11,7 @@ static int bmp280_i2c_probe(struct i2c_client
> > *client)
> > =A0=A0=A0=A0=A0=A0=A0=A0const struct bmp280_chip_info *chip_info;
> > =A0=A0=A0=A0=A0=A0=A0=A0struct regmap *regmap;
> >
> > -=A0=A0=A0=A0=A0=A0=A0chip_info =3D device_get_match_data(&client->dev)=
;
> > -=A0=A0=A0=A0=A0=A0=A0if (!chip_info)
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0chip_info =3D (const stru=
ct bmp280_chip_info *)
> > id->driver_data;
> > +=A0=A0=A0=A0=A0=A0=A0chip_info =3D i2c_get_match_data(client);
> >
> > =A0=A0=A0=A0=A0=A0=A0=A0regmap =3D devm_regmap_init_i2c(client,
> > chip_info->regmap_config);
> > =A0=A0=A0=A0=A0=A0=A0=A0if (IS_ERR(regmap)) {
>=20
> Hi,
>=20
> I noticed I submitted this change that was also submitted by Biju Das on
> another
> patch:

> Should I drop this patch from the series?

I think it is ok. Andy is suggesting to use unified table for SPI/I2C

Is it something do able and testable in your environment? see [1],
If yes, please create another patch for using unified table for both i2c an=
d spi.

https://lore.kernel.org/linux-renesas-soc/CAHp75VeX+T=3DhAN+PgtHTdv4b6UtDVg=
veUUww1b1kuOngzDinFw@mail.gmail.com/T/#t

Cheers,
Biju
