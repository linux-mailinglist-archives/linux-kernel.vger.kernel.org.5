Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5BF7BC705
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343874AbjJGLOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 07:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343859AbjJGLOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 07:14:01 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287439E;
        Sat,  7 Oct 2023 04:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5yePDE58qBRUAmODOQz8+JYzskhEZt3syRVF3TktLGEbfNC6lX2xf/hRgGEGEzFtz9s0BFtC+v/5oX7xWRDfLIMt+mWelnU3IrJHtKC1tmzGHFeu5YGpGfFHtqY6deLTzXP08CVaZ6uAZ9w9UZvTGy31hulchNxWF2LhhwzcF+VuanTtRabc7Sq/fxF9DdFCDbkOqIzQGKQVnkyoQLEVzxtB/HsRvmBAj7mFrfTJJGSaOqMZ8uhwhS8gyrkzfPcY2jI+fEBYMeeVF0qzzrAX8DzeizTM/iHNAg5mu50gtpVXLhtXWVQducYBm232bec42fbU1mqPxpjB9A2aOyZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYm2J+pBu9O362b1FEAfVVn8FNdROVS4UQ5ZtnkGuPc=;
 b=kKP13n6uJfqUhgXc8JA4Byqzz7KI0Hrg67VtmDKe1jyQr5QbR3zgpiXPH4dzRwKNW/Pe0hfzi16nFo8H7Uz7zXouj78hF0+vhAo7MRBFbVX4BirsS3fJJvb/khmOYPMhdt4UlMapkGZRfD/7zm5GpNxnBxZtdPp/D/F27MWrmgb/SPoTGBs1VgXDAlY8rLFW8THwH5slHHf7BHvBxLtKqmqn5BMIJhFWV1ejBzyZeT9orqVJKkbKPQVf46icKQmOsppySxzsY5QWx3j7rQLovcIMmnB+1JjWXV4mdq5dJeDUVXD9+nAfm3GC2XGuLYGh3ZRPrOvewLkjqeZxuyYZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYm2J+pBu9O362b1FEAfVVn8FNdROVS4UQ5ZtnkGuPc=;
 b=CxLOfwORpJiZ3AUrrqL3UU53fwiuj0CuDJFvRhoKn/RlhSomnaqX53sSmrGOy9u93aNbhb3SaIJjM8R3qR8W8Q7njfSqkM3zIt+09nEZDxG57+kKVbN2Wzn8syKnf/orl5iZRG5Bw6lmF/8E/Xsa5FRyD5+JJd/cDlKTzejCDtk=
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 11:13:50 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f%6]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 11:13:50 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: Re: [PATCH v2 1/2] ASoC: dt-bindings: fsl_rpmsg: List
 DAPM endpoints ignoring system suspend
Thread-Topic: [EXT] Re: Re: [PATCH v2 1/2] ASoC: dt-bindings: fsl_rpmsg: List
 DAPM endpoints ignoring system suspend
Thread-Index: AQHZ8O/MzWXts0FyqkyLsnXLlx8p+7AuaGaAgA/TavA=
Date:   Sat, 7 Oct 2023 11:13:49 +0000
Message-ID: <DB9PR04MB9498352BC1763048B8358D97E3C8A@DB9PR04MB9498.eurprd04.prod.outlook.com>
References: <20230925110946.3156100-1-chancel.liu@nxp.com>
 <ZRF8KI11IVf6NzpL@finisterre.sirena.org.uk>
 <DB9PR04MB94987AC750B4AB02DCBC44C8E3C2A@DB9PR04MB9498.eurprd04.prod.outlook.com>
 <ZRP2A1hvuB8ZymBK@finisterre.sirena.org.uk>
In-Reply-To: <ZRP2A1hvuB8ZymBK@finisterre.sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9498:EE_|AS8PR04MB8436:EE_
x-ms-office365-filtering-correlation-id: 2df06b64-4375-4025-970e-08dbc7267ba4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +xboHoQueQd/qwj6xrgOh8Yc3fITGyrh+CxoRniPgbNahADDfiqA1tA8EfkUsoiTtauZI3q6AtJMtGF4bonXjVdmvGA+lAdi20zgikHLrPXCuerGF8/OubN2koRez58DgeVLzEAEtjoJTN3Lz1vGTMiry3MWZC1gdcw4SaryGPk9UJm/wCWK3lAMGrYmxdrejxo4eNoy0LpERMXT6DXPLlvnw2HNox2CEdnCKT/U6nus9OrE63N8SY+YftIlPNeWJ1ODUzIjhgJn4s9ALXlPAzWZlmV1eFXhQk+ys1Dbg7emVzjXNGC08dKEh0J7NkWw70Cmf7BMNhKox8mReKGiY+vIU7SJR2WU7Uo6DIH34ZzRlGWr6V70l0smCAlJ3KL5nHeIthnNl/ZZiaL+9FWpXv0MEv2FJB9DppVTfVTjEQ9l0WB02Z+hqXInZlUwlO+g7qZ7glvKabrGWSg8WdFURea3vL/EX/g2w0L+AZI4h9Xe+crJvJ+NJ2j8GCsrLWhz2K6JaWc5L4LynIMb5V7JG2NGsH5Mp4WKuqFZvv8yb0ef1Dxgkhjqq193vSjHMt9QNwrmCH+1dd98CgcQOHpDRqb/t/kSg2DHXjad1vZBoa4W6DzNnCrk3le/lQJCTj5F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(41300700001)(55016003)(316002)(6916009)(76116006)(66556008)(66946007)(54906003)(64756008)(66446008)(66476007)(52536014)(5660300002)(33656002)(44832011)(83380400001)(122000001)(38070700005)(38100700002)(15650500001)(86362001)(7416002)(2906002)(26005)(8676002)(8936002)(4326008)(478600001)(6506007)(71200400001)(7696005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7wuxaxHyOO2t0CQ39SjnVMgQAV07vl9k2uTEON5MiSnnkU9Ji75Gn92yNK4B?=
 =?us-ascii?Q?HgNF9MkWziWaGHO7RfGONVKUk3UG2OZGLbDPiZJgX9CNqwxJOuG7KsBTVd2r?=
 =?us-ascii?Q?EjWn1kzpLh6wuUF7gyn/S9oxENqKickF5NE/Qv40EQlTQYHfQdKxWWl59V8M?=
 =?us-ascii?Q?pSS45iIgo7Bx89uvuBlubrIgyXsQxhcjRocSnrVoLrpdwCzi4R1mcUJVASJo?=
 =?us-ascii?Q?yJJ2RU7fcEuRPPaGb1Cn8PdaKFMxLqHjF2+sA7bU11iMqC6javKGf5RW2FMJ?=
 =?us-ascii?Q?AFaOHqb+lvyul/N9kDVL7Ni/f3+I5nPBbUY5LLVso58vVbf+iYZiCxmq5emC?=
 =?us-ascii?Q?At2iylkDon5+RZOHILpBVw8ri/iUZp+8Uzbu+lZpIYRDZaayxBAqGy4tJM7b?=
 =?us-ascii?Q?AoaaDXijQ6vDiswcn62klDKxj+XbFcvNBZmMTDCnOZ7mmRg8JRCJ9bZZx+fb?=
 =?us-ascii?Q?QCSOWHIweHKgprF3GBjyFME+zxsv25L+y2srYoCbxfTWdlku/bJh/A6TLrYp?=
 =?us-ascii?Q?Jrk8Masltm0CmIkfq6eMsldL73seq8P6A2kEzjopDEW+SokBuoyGrdObffbY?=
 =?us-ascii?Q?gnCL8evks6evofQfc86xS9Yv7RD1lb33fPqVKS1Ck/1I7jG0bjsjeVq6cFNv?=
 =?us-ascii?Q?Tr5xK4v8NPqJm6m/UloubwSBMfTKi3GZq5sar9pNOlM+qx+MHc+Qi+l8tR1o?=
 =?us-ascii?Q?/wNRUhfsJR0fZwfat4NP2eob8p/+SFIim62l3uvV+zEmFWmSKXySqF6AfkVX?=
 =?us-ascii?Q?PJIhH1QvvBtr+dEJkdxWoYfyWz/mA+6BoR/4h2EBsiltRoGaV7/3b32FVt14?=
 =?us-ascii?Q?mYp18YLT8MqxW0bZaG9KXSCefE3FDrG6ogy+t10JSninqqiK/YCQho0l/LC9?=
 =?us-ascii?Q?NFp3MJ5Ui+wDyH9N42UcLYXrltgzXrvvhVwagzZ3nLUqdJ4jaxxhRdzxi1iF?=
 =?us-ascii?Q?eIcT3atqm0elv/o5djJ8pYwyv0+QWymKjngMITBmGzxGvIa6REUOIdIT5Hu9?=
 =?us-ascii?Q?hQ8kcC6yARImL5Y7mr0SJCs6WNs/kxpNfLTPCSQkVAAucuq3QltKJWKLbl8q?=
 =?us-ascii?Q?d0KR3HWYYEtmA5UQaF3bvjXNCNTKQiv4/pHHfWMVgQ975cdYsE6HgxXKHzw4?=
 =?us-ascii?Q?mXOkxpC0luokd2wj2WgQP2CFtD2SCNQBj2UtHqhKm2aSNBcBHDISk3kNLz7M?=
 =?us-ascii?Q?+y3jJ2FSf632EQcoTWLCVUZJqRnBWdVht7uLnRHvnZDa+nBiGGyttZRRdefc?=
 =?us-ascii?Q?YYlGS2v1nwPXOHyBT9W1EuHry9JjW+6w4bkZJweaO0Aq8ArbMc1JdjoOp6KK?=
 =?us-ascii?Q?EIJPSoyLp18iiCQ+lLobsI2CgMfDbz+iLTSfNiImJC7T+HmekH/n4PexD15j?=
 =?us-ascii?Q?46cJTpKbQnb51Eh8YDydLrg/9toE7du0DPugxwpzcKebKuR28Ni7kvNs4HEZ?=
 =?us-ascii?Q?9eh1PD/lpATUjGGIzy2N7gBdmPfj/nlVaChw9pWLCA27QmdhIsSRfqryBr0o?=
 =?us-ascii?Q?k1hRqwitdjTSmuxUDR0C2F8s8RyXtEAivydlM77EXqKE9PjZ2GTY8ye4qXFx?=
 =?us-ascii?Q?BDHHHFEy3Diql1cZGDA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df06b64-4375-4025-970e-08dbc7267ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 11:13:49.9628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcZlNCaMb550dBz0v3/KBMoGEp193d+aY1G+8QzGTZyNMChrCUnKM8IAJsVmmWifY9AK6ABZ06J+h7kT0mxGSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8436
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > This is a fairly standard DSP playback case as far as I can see so
> > > it should work with DAPM without needing this obviously use case
> > > specific stuff peering into the Linux implementation.  Generally
> > > this is done by tagging endpoint widgets and DAIs as ignore_suspend,
> > > DAPM will then figure out the rest of the widgets in the path.
>=20
> > Yes, indeed I meant to let driver get DAPM endpoints from the
> "fsl,lpa-widgets"
> > property and then set these endpoints as ignore_suspend if the sound
> > card is running in this use case. Do you think the description for the
> > use case can be simplified since it's a common use case?
>=20
> This is a card problem - the driver for rpmsg shouldn't need to worry abo=
ut it.
> Any bindings extensions should be at the card level rather than in a spec=
ific
> driver, we could probably use something in the generic properties that th=
ey're
> all using.

Instead of "fsl,lpa-widgets", I would like to add a common property=20
"ignore-suspend-widgets" in sound-card-common.yaml file. So not only rpmsg
sound cards but also other sound cards which have such feature can use this
property to define wanted widgets ignoring suspend.
What do you think about that?

Regards,=20
Chancel Liu
