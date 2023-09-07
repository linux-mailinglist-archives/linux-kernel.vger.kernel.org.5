Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37447797410
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344758AbjIGPdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243257AbjIGPb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:31:59 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2072e.outbound.protection.outlook.com [IPv6:2a01:111:f403:700c::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF996184;
        Thu,  7 Sep 2023 08:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdyJpt+ShYjCs1ET2GEJq/3S1fFcn6/naTfwpobjltqQy9p6WKEbch2mRNVPxdyj4ObIcflrWLCYR1m7IibN6v2joWV6PL6tu7Ol3+xJ7aOb+c8WoZJnFzNsJo58+Exp+bM3X4LiIxAa3q36s8axoua9Ude9KiyG2rYzoTjaDBQIbYnRZFS0YH+ZqkIqbYinVwfkAQF9awqD9qJddTsPUIZwrIy4s/cVlqkUXEgF79b1SnRkFFZQ/iX/vqHZOD3ayVGYYT/14b5LWR+cKnQ2RbDxGc3Fdmk7VWyfqNg6oQcuZaC+mpwM1Rk8gJlNx2ap0fxbbyVhwjkpbrntpW23jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vy8M43cTTAhgjJlYkTRB8XFzgx12uNLeVkdmGj072QA=;
 b=i8GL0TMiCfIlX2Y7/mS1Uf0F3ghhRdOEXgrn+8sC4czWiOXM9A42wiJZ1aWTfDp+lQzODJoLz1Nec+OkNmmiIrrXn66tGWDl3ZngDJWg2H8E+1dCMRJa/MgUl4qG3qdTTj1QDX3vxwtjxmcdNggAdGtwCwqonic0Yg8v5A9mTT5v8oi3GeAMlkJH58/bmNAlishxclZ41ZGWwSNwNY9kUpgDc9MqKolxz5Uixy1CIkuWkOkZS4Y6PhqJqh3SRgNO+Ko165/bd7FyWLhq1O42fs7CpTi9u/kSkc53cAw+liwIvTRu40funQjjomUE98NvGtRhrKa43ewv14niMmkbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy8M43cTTAhgjJlYkTRB8XFzgx12uNLeVkdmGj072QA=;
 b=l+Y2lMkjD3j4Cb+zFzNeF/XYwiU92egwbABpy4hBnUQ4ptJTpBy62INTWqnjj/jv8yBaoKTfu3rowTHZprOHq/AwVk5wtUy174tZHMTPHtRBHLVgSha0EM94E00zRIiZxAp9NkV9QNcpEBhs5qkFad2Cuad4+sEXMHjC0kpmKqM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB9532.jpnprd01.prod.outlook.com (2603:1096:604:1d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 07:11:23 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 07:11:23 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: RE: [PATCH v2 2/3] iio: pressure: bmp280: Use i2c_get_match_data
Thread-Topic: [PATCH v2 2/3] iio: pressure: bmp280: Use i2c_get_match_data
Thread-Index: AQHZzhmqGbM3bOJHNkKqVyoGVC6rua/pXDPggACkmYCAJRdrdoAAACIA
Date:   Thu, 7 Sep 2023 07:11:23 +0000
Message-ID: <OS0PR01MB592270FB205349A3548D242E86EEA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <cover.1691952005.git.ang.iglesiasg@gmail.com>
         <55f8dc02de16a353f0449bc1c7cb487bd776dfaf.1691952005.git.ang.iglesiasg@gmail.com>
         <954c859835aed6c41a356fdd999a8be51469eb9e.camel@gmail.com>
         <OS0PR01MB5922EDF7759069CD4993FA468617A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
         <a83bde5079b769950220c0f1f3b8d374db39cfc7.camel@gmail.com>
         <20230828123937.2bff2d92@jic23-huawei>
 <8c206c8079d363d961f8f1f40c8346e872143f83.camel@gmail.com>
In-Reply-To: <8c206c8079d363d961f8f1f40c8346e872143f83.camel@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB9532:EE_
x-ms-office365-filtering-correlation-id: 74d92c4d-4be1-454a-565c-08dbaf71a4aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mrCTFdGdBJ4nZSKLiTiAHaisqoCfEeSR0K6t2n28dDGSk7KjVu1qtbWfNlYCw5Mrl0ZKkT+YwYDvljypu7Gl1OlBY/rnsSo5Qb9iR/Xv6wRY4dB3mABXm4AgS8E+58hbS8K8aRg/qg4aCBBDmvKmRQrSUAUi+3RUXUUga2FRzJaGfw5rKRfsup5Bq0tR4wl9XL/cOVV7JiQflK8zjPin2aD7WKVsicwaIDF6wLHxSlnkiscjPhb6xoLH/aBylGFhrm7OsvRoE2PpDasPDHfQxVQSLw+FA9gnLC1NzLy1UOiAQxtA93UvbmBQwTt7uf1uAAXOJS12jafUT8UE4qrJura2CgnKTNY8rgc33iSrzdtyCXtz0dmq9u5aEdPxMDSTeUdnjpQEn+2ydk5n5hKiUoHwQgOY2hHLNFY3bInPu+J6y7BlT94bO7ZYp4v1+iPGE2BX4Pfg3IDEBsf+bR/D+mv7UZNWVc1Tg08ya3X7ewqv7wcZZyd2+4CCDIJdUpk2fSEHSLELRwCjUYv8VDgWota4qklI/TWszFHtnDFX8B7wylAUQwg3NIL+Y9iPaF6OBlTEhArCtKEGSMAD3DX0T5EFjm5oVWh1EbX8u8qoM5Ehm3o5N5VRR9LvqixN2iE5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199024)(1800799009)(186009)(66476007)(64756008)(54906003)(316002)(66446008)(122000001)(33656002)(71200400001)(86362001)(110136005)(66946007)(76116006)(66556008)(2906002)(8676002)(41300700001)(52536014)(8936002)(4326008)(5660300002)(55016003)(38100700002)(38070700005)(478600001)(9686003)(26005)(6506007)(7696005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Nc2PLbeTqTiz6NkU/ZDcsPny1At79blJgdRd2dzYeVXDlAkBdnHG5625ws?=
 =?iso-8859-1?Q?gpr3SFVZvNEEbdmuS83yDdLtj4bRZrGTw+G6l8u7EcyjFdr5/EKZr+V3pm?=
 =?iso-8859-1?Q?hJW7EKNd2hhhv8d/BfY8yZao0hsmOch1eKstPg9uAtAQdp+BojFORKt2//?=
 =?iso-8859-1?Q?Tu/iTXT6HHgG6PlfaGFGtlU9Epn4924nYG1c+gLYYW0Xv7HAeFZ1xqIW7R?=
 =?iso-8859-1?Q?m8QXR8D1CAGEa5Gsc4FZhTXVS5EakyCceK89+Nas3yF7A/J+ZBR3NsN3q8?=
 =?iso-8859-1?Q?SlL1Wi8JkIxaqexXFMHdRA0zMfUbD+WYK3WlQD2fhHIxDoBmjOTG05fCDR?=
 =?iso-8859-1?Q?GFxRoHphL9e/mj3ql8I+CKlMvwyt3rd7OBCn93/voeswjIrS44hxD2sbfh?=
 =?iso-8859-1?Q?4IiSH2S3JZVUTqklHkHYXZDibZKGO++oKWAo81XvkojjsRhzyqZfv++jrV?=
 =?iso-8859-1?Q?oZ2Fr97tfEI87awimThaNbEsbQyna4ivfgW5rk7pklubNp9hL2XnzpSzVu?=
 =?iso-8859-1?Q?73F7m5EQ6wfgFfYDhG4rvHpWdhoWpI48fNTHlJ5OPgq32zflBB4YMAe1Nm?=
 =?iso-8859-1?Q?bvMYnS/GgVHZzrvV7uw8z+E90UpRSg+NhvhxR+ITACgtcAivQfaBoXAMjg?=
 =?iso-8859-1?Q?eoTAE1twMgGN4J1pgkmSWHqPvUqj1vaIAT7kbvBnLJI9syTrwykwWGDNhG?=
 =?iso-8859-1?Q?+AZ6M4IDOnWJX2PmGDedrY2X5uD04+p42FakQ7g77x3C/IULnFBy67u8er?=
 =?iso-8859-1?Q?b+lNqnERz3Ld0WMkvInvhrh0eFg8gagrTbxMWR+6XxQ9WTw3kZIa8LP0qz?=
 =?iso-8859-1?Q?+M/XVrxwooN4hmFs56fzxD9TBoYmD6Lxukqo9iRco/fZvaP9pi/k4TQdaZ?=
 =?iso-8859-1?Q?rkmqP1igfmCWZMKLaNE6cWvTFXqv0B+/Ny2RjGKIT7VpqgnIjR/Qo7/HFi?=
 =?iso-8859-1?Q?nONOrWc70n3adc6WlKmcLkkp3DtgIO5PcxpA1kYT8pEh8Fwfeq+u9IQhs3?=
 =?iso-8859-1?Q?l4u8pb5j+iSeR3Ky0sRlWB4SkUFgQ8qM/5VDCr0e60cQrNcpFVQClaYOKx?=
 =?iso-8859-1?Q?tpzpVjJcpxRHQoAkReeL/+ufoj7CdNuXWvbIXkoj6l7n2/XmgHRuq5iTxD?=
 =?iso-8859-1?Q?0rf8ObtybH4ec8L+X6IHycTVtde0hwwBxx+KVFrwp9rMqjM4USLAbJOdyi?=
 =?iso-8859-1?Q?rvml81kJfsNuv/zuXeGwBZBuf613UQf9qifGKssEIo1UbjgRVTDogFq9PB?=
 =?iso-8859-1?Q?7kk4Kt+rmWUlFcT/b4EizhCqETXM/+mYONFFgYv0BGPyagw415ElE5BD6i?=
 =?iso-8859-1?Q?hD48QtfzsUTqfUHbDNAXtbMwT0QqYUUIgwJ/DYkSv5fh8wwYiOvIEPLQfo?=
 =?iso-8859-1?Q?5pqb1U9/ieMWAPdI7SumVZ9bRLg7P6QmQaM1thA+2+BrMIqgVbTHkjlBQw?=
 =?iso-8859-1?Q?xVonX4vYwB8g5Tx0gMN0alBZD215GoMmbiqhUgs2sEy2ZAPgbL123XC4o1?=
 =?iso-8859-1?Q?/SLW+pmihhkiYtdNR29Gcpy8oaYmhhwKIRMZi41BQj3Sn2HvenNudmnSkq?=
 =?iso-8859-1?Q?2gRLeRRTDOjAQ3P7ToR4RbmotyYc4CEbpQh946idpYart5wPvT4BJagbkd?=
 =?iso-8859-1?Q?Ud5MEqzgY9tW3QwvE/z5ZLQdZbbfU2O/CXgxeyml2UrWu12W2u/+Ic9Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d92c4d-4be1-454a-565c-08dbaf71a4aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 07:11:23.1368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjXoO8SziN0c5Cb/m2NnNlvNLwIykCpAEwYlbbTiwJNJXxrOO9VG4Tj5vkJFdjLVHCsFSSUTx9cPNTasQ2M9d2nNuWfN2+jEVHL0mHqnqQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9532
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angel Iglesias,

> Subject: Re: [PATCH v2 2/3] iio: pressure: bmp280: Use i2c_get_match_data
>=20
> On Mon, 2023-08-28 at 12:39 +0100, Jonathan Cameron wrote:
> > On Mon, 14 Aug 2023 18:43:49 +0200
> > Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> >
> > > On Mon, 2023-08-14 at 06:57 +0000, Biju Das wrote:
> > > > Hi Angel Iglesias,
> > > >
> > > >
> > > > > Subject: Re: [PATCH v2 2/3] iio: pressure: bmp280: Use
> > > > > i2c_get_match_data
> > > > >
> > > > > On Sun, 2023-08-13 at 21:03 +0200, Angel Iglesias wrote:
> > > > > > Replaces device_get_match_data() and fallback match_id logic
> > > > > > by new unified helper function i2c_get_match_data().
> > > > > >
> > > > > > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > > > > >
> > > > > > diff --git a/drivers/iio/pressure/bmp280-i2c.c
> > > > > > b/drivers/iio/pressure/bmp280- i2c.c index
> > > > > > 693eb1975fdc..34e3bc758493
> > > > > > 100644
> > > > > > --- a/drivers/iio/pressure/bmp280-i2c.c
> > > > > > +++ b/drivers/iio/pressure/bmp280-i2c.c
> > > > > > @@ -11,9 +11,7 @@ static int bmp280_i2c_probe(struct
> > > > > > i2c_client
> > > > > > *client)
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0const struct bmp280_chip_info *chip_inf=
o;
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0struct regmap *regmap;
> > > > > >
> > > > > > -=A0=A0=A0=A0=A0=A0=A0chip_info =3D device_get_match_data(&clie=
nt->dev);
> > > > > > -=A0=A0=A0=A0=A0=A0=A0if (!chip_info)
> > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0chip_info =3D (co=
nst struct bmp280_chip_info *)
> > > > > > id->driver_data;
> > > > > > +=A0=A0=A0=A0=A0=A0=A0chip_info =3D i2c_get_match_data(client);
> > > > > >
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0regmap =3D devm_regmap_init_i2c(client,
> > > > > > chip_info->regmap_config);
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0if (IS_ERR(regmap)) {
> > > > >
> > > > > Hi,
> > > > >
> > > > > I noticed I submitted this change that was also submitted by
> > > > > Biju Das on another
> > > > > patch:
> > > >
> > > > > Should I drop this patch from the series?
> > > >
> > > > I think it is ok. Andy is suggesting to use unified table for
> > > > SPI/I2C
> > > >
> > > > Is it something do able and testable in your environment? see [1],
> > > > If yes, please create another patch for using unified table for
> > > > both i2c and spi.
> > >
> > > I have around a BMP390 with the SPI pins available to test it out.
> > > In the case of the bmp280 we could unify the of_match table as
> > > they're almost the same.
> > > In
> > > the case of the spi_device_id and i2c_device_id tables, as they're
> > > different structs I'm not sure if they can be unified.
> > >
> > > Regarding Andy's comment, I think he's referring to the duplicated
> > > chip infos.
> > > In the case of the bmp280, the chip_infos are defined on the common
> > > driver code and used for both SPI and I2C match tables.
> > Hi,
> >
> > I'm loosing track of where we are with this driver as multiple people
> > are working on it.
> >
> > Angel, as most of the work is yours, please could you manage the flow
> > of patches for this one so I get series with clear statement of what
> > they are dependent on.
>=20
> Sure. If Biju is okay with it, maybe I should squash toghether this two
> series of mine:

I am ok with it, as I don't have bandwidth as well as board for testing it.=
 Please feel free to post.

Cheers,
Biju
