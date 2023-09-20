Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB307A7083
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 04:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjITCaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 22:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjITCaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:30:02 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBD8CC3;
        Tue, 19 Sep 2023 19:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joV0qco8IZ23OlixzTuBRNemNiesB2YhCzXgKzZtxhhiLplhxmMLuIFFwU2hW7F3ShpUGufNHNtjsOeP2pLBNFX637r9rNL2s3XgvTq9FmSutLupNwhd3TjQ67l135j7gO28UuCu2o/4bYY1XG5RoP1PlFJLBtA2ewW9n21wAALYfgyaa5u/asiKVrfR0/xV5rNu53idYyiNjYSt8jzHX2hbgGFJGzSjpFTFy4zNsZypC/ZqqZIiULJoN5yuCM8vuSAzEvf8KwQ959iR1C0pULsG9yCkbfxL0fSVBAu196Ag6cVRqGH+g+927M+b4GW/J5V2hycfr4FuYOVZkpYvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZcQgO2OMs5v3Bp/USZKI3gUV/e/GN3FfNlyQUYwB/s=;
 b=BEKbB+RJSniks2+4rfkgbuk+4Yy1BRRz5Fau54fYLSlJevcgWcFcxWdg3ejsMFE7LtnkpJ8s3665c8gpz0tCtQov7TaRVfaoqF3aLvU5ygQVzTtxsHQmIMgpz/zp0rQn42Q6n5VzrRLiEFVHNfDlVp5He6Ah/hTzuRdDvXxwNhiJxJNjb4oBCDqy++kC4hj+ZY5D9ZhqpXWLHJCqhExxJGunqZeJDZAIKlfAHz1XIPIXQPLZENOLAl0pGV9JTxDBCyYHv2ZVIbyXypf05va7I3SsKz7qz8yaqpvgRd2jIuQrqdtjlyq/8x2FPEjXuDAAntQQvMDBLjUc3i0oOL7CqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZcQgO2OMs5v3Bp/USZKI3gUV/e/GN3FfNlyQUYwB/s=;
 b=ePw9lGUHentxFId0LlbHUpKQDcT7Qz2a3jefPVa/xe6m2IYdjDFkVTnItvdgzNKsyIKrQNK5tXK/oZcFnPMYSU0Girnv7sd2lYoq699OhsUk1QK4Hc8ESWDM8j+3wpO7xd8KpKWqFZchKYyG7u4NukzbKmuOP3hpxe2SAhkL9W8=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAWPR04MB9957.eurprd04.prod.outlook.com (2603:10a6:102:385::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Wed, 20 Sep
 2023 02:29:30 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%3]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 02:29:30 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] arm64: dts: imx8-ss-img: Assign slot for imx
 jpeg encoder/decoder
Thread-Topic: [EXT] Re: [PATCH] arm64: dts: imx8-ss-img: Assign slot for imx
 jpeg encoder/decoder
Thread-Index: AQHZlDIs7ffrb9GV+0SWLdJrOGd4kbAiwISAgADrB2A=
Date:   Wed, 20 Sep 2023 02:29:30 +0000
Message-ID: <AM6PR04MB6341AF5F905DAB0EFFEB3B81E7F9A@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <20230601023801.25229-1-ming.qian@nxp.com>
 <20230919122602.GC11740@T480>
In-Reply-To: <20230919122602.GC11740@T480>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|PAWPR04MB9957:EE_
x-ms-office365-filtering-correlation-id: ad1d7f79-8384-4c95-5b50-08dbb9816b22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dd1bKpnquPbAkxYrPzPa6dpkteVgOR8HfZMZeuOyK4unMj2ENDxkPeiGudImx1PhpfZtk5WZODgcOgNGSZzs3GlaNTH7TE5ysvv4Eaupr3SRzq0gwUBXMga/fSkiNr5KRBgm5yZNHQE+EK3LPzzRB23lfraz+0fafrnRp67w1PpoanMCQ5WKAcHguTHjvcWUg8wniW9PExnj0TjcWrlu4HmwdDHKhTzmWCWKn1iZQX/MClt7OtHNT0Rw5rpuMCOXrfkUfam73zS+zowN4qMuKhgkfoHPFJ6JkVS5CQ48f1hxUWC32juYOOI6LyzM1m5c2HbN9nqNj+2BxBB7+6K7xhhe7U3raPzF8kfYd+op9pDFx8jcZE18G3X7AdiG7iRngUBqAv+Kzuu+w7S2iHeSsIAW0xfxYhujrR50hxbEz/J4JEgg9klteyHoF/fP+52IJTNBZTfYLRuUN07x9I4ga3thgXMOe6CEKRcaVBE2LIxhnTWbwpCFxvd+3qul+4ZDx3qS3xCN8jiRrhXyzOW2f6hyGz3Hriz1PfAZfh4DM64XYs/fagJfETGfDeYyNqloJbNeKHO2ByTjeSd7dLmWECrkVVI3s4QLTOOn8/3V8QZUAnuVT2FzVYZTYZ0Nw146
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(1800799009)(451199024)(186009)(8936002)(7696005)(55016003)(71200400001)(6506007)(478600001)(83380400001)(5660300002)(54906003)(9686003)(66946007)(76116006)(6916009)(66476007)(44832011)(66446008)(316002)(64756008)(2906002)(41300700001)(4326008)(8676002)(66556008)(33656002)(122000001)(38100700002)(52536014)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FNDkzertxGNyRWLsbHFgV7LXtFY3xMSOI635c9HZd7fLlJ9dvgIh1DNjgLkP?=
 =?us-ascii?Q?+bvzp7ou9HLNt4Ba8Z8cZoPQedP2lQp1BL5WgwK94zBhyKdx5b/eLC2KyEg4?=
 =?us-ascii?Q?NbgveKmUEqXjoTcr/ZkBDoV7eNw3DFSolI3zZNbXm0K6Ogjyx+l9v4ePUc5A?=
 =?us-ascii?Q?o9rfR7QE4zWLu2eNcAxBHZTd2+HjObN8aQAgqj8IgVn86cEbCGXjsdPnH013?=
 =?us-ascii?Q?nK14kxNGbpwQQl0aIOJkFuxOkE2XOh1SZkbg5TnuA+hYy0hQ8HaRo9906HXs?=
 =?us-ascii?Q?Orfl1oTyqvHI8IYY6ZEsRK63HKqfBdmeyVeNPUc9qAu34u5ZkCY0yLWXcPeG?=
 =?us-ascii?Q?JTF5v8DEE7mm5Se2aCVEkIltlD5fGdAz5W29OrGef0e4D/eMek/LG2IVtP60?=
 =?us-ascii?Q?Zo/qJySmXdWOweWpcmxONcXAtutN30fFWPSQ2jmanXgmDxpmUrsK7RYwIXoY?=
 =?us-ascii?Q?0Oy32Rp0UGR/GfsoGHHGSr5e5pj2P2741d8+XEbJzEEzArW3sGVnfi78MKYl?=
 =?us-ascii?Q?sa1Ct7YVMvgqmVoQBr8Q1lquJBv6e3xSu1Db8iLN9PFJ8XppG7y8KpOLk+fD?=
 =?us-ascii?Q?mEYehJ6Z/eEM7Zstr1DiDrfXJ3e8/C3L0NV9svxdAhTRfo3faFDdByJ+KVZR?=
 =?us-ascii?Q?pIxg31o9FFjfqtwkRA8i83XdSFNTYhA6GoR/3PVCxPP0ElYwquYkewgd4Q2x?=
 =?us-ascii?Q?ZlIeqDB8uUtdycelEd9Gvj7yLZcN3HzHL/EPE9UYPtCsJG/r4a7rJbYbKbgZ?=
 =?us-ascii?Q?KPdZmPk8VZtFjxzb8OMjuZTQtPQ6IO8MxswH5SuXgaddq3DBHCi4QUYGIb9I?=
 =?us-ascii?Q?Z20s8JmuUu1T1ntDSffaU4bg4Ck/0+kzt/DZT8Onf/i3NsfrrVJh+jrPkXh3?=
 =?us-ascii?Q?YdY4r5MJIukZefM4ncVSRySlzkcVTfLfkVLTK1snniK7uvj6T13MVx6DrOab?=
 =?us-ascii?Q?svpVlXom6HHfZS4QmmT4p5FzOWcAS3Jxe+WMDnhIovGhfkhtSPYyWjR9I60Y?=
 =?us-ascii?Q?zy3Tr9aKJTkam2pDA9+vs3dvI2l4twnZVREaVIj48JoHPLibv69RBVWNUXlv?=
 =?us-ascii?Q?xegA0bNDjnWEW69z6kQyzgvbuBHFDBqjwn/CcIZEuBIDI4xBLM3Csl5r5IHd?=
 =?us-ascii?Q?f3HUJiVJyPUs1JPM/0zOXcxxv39tAJ2o99dTalfwJjQt1d0LkPVwZ8WKcLVs?=
 =?us-ascii?Q?6CzhsLZEpVsy/ub1HrXV/3m8ytz/PrUJWUBsGH/KwVE26F2BSqWM04QEw6Ia?=
 =?us-ascii?Q?hv30PqYQk7YYhebHCtPHn35pC6cG/85mOgaPX8dNdMo2oQ7SROkZui6TcYXa?=
 =?us-ascii?Q?OaAMCyBjGvAYnI1Vbdp73xNYf6F7n1I10wDf+K45wjADjZnXzniknmgwNlaD?=
 =?us-ascii?Q?yZbjoXl5zrcEpuwwBNQJjRE15+NObLXZzll7F68wAbeFEH455pXbnfpUBTGe?=
 =?us-ascii?Q?NlE+FO9+ICcZUO4MxFHUZjdqumA8wGkzgMtamQFKH3YbfF73C9MWpnk5lCCc?=
 =?us-ascii?Q?TajNAj/td/JOYsnh3Z9OezZvxBYV+jAKPZcvuOsNItQMqY3/1zJAZEw7Xw?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1d7f79-8384-4c95-5b50-08dbb9816b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 02:29:30.2083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IqFqI0lqkjZFq78ynNpjhto7CPcBHFkzuPmJ9UrpIWZN2R2kBYsMzwnE/yFsIt1GQ7Ujua1WYfywVkIHgEFVog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9957
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> assign a single slot,
>> configure interrupt and power domain only for 1 slot, not for the all
>> 4 slots.
>>
>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>> ---
>>  .../arm64/boot/dts/freescale/imx8-ss-img.dtsi | 22
>> +++++--------------
>>  1 file changed, 6 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
>> b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
>> index a90654155a88..176dcce24b64 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
>> @@ -18,10 +18,7 @@ img_ipg_clk: clock-img-ipg {
>>
>>       jpegdec: jpegdec@58400000 {
>>               reg =3D <0x58400000 0x00050000>;
>> -             interrupts =3D <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
>> -                          <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
>> -                          <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
>> -                          <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
>> +             interrupts =3D <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
>>               clocks =3D <&img_jpeg_dec_lpcg IMX_LPCG_CLK_0>,
>>                        <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
>>               clock-names =3D "per", "ipg"; @@ -29,18 +26,13 @@ jpegdec:
>> jpegdec@58400000 {
>>                                 <&img_jpeg_dec_lpcg IMX_LPCG_CLK_4>;
>>               assigned-clock-rates =3D <200000000>, <200000000>;
>>               power-domains =3D <&pd IMX_SC_R_MJPEG_DEC_MP>,
>> -                             <&pd IMX_SC_R_MJPEG_DEC_S0>,
>> -                             <&pd IMX_SC_R_MJPEG_DEC_S1>,
>> -                             <&pd IMX_SC_R_MJPEG_DEC_S2>,
>> -                             <&pd IMX_SC_R_MJPEG_DEC_S3>;
>> +                             <&pd IMX_SC_R_MJPEG_DEC_S0>;
>> +             slot =3D <0>;
>
>I do not find this 'slot' property in bindings doc.

I'll add it in v2

>
>Shawn
>
>>       };
>>
>>       jpegenc: jpegenc@58450000 {
>>               reg =3D <0x58450000 0x00050000>;
>> -             interrupts =3D <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
>> -                          <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
>> -                          <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
>> -                          <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
>> +             interrupts =3D <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
>>               clocks =3D <&img_jpeg_enc_lpcg IMX_LPCG_CLK_0>,
>>                        <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
>>               clock-names =3D "per", "ipg"; @@ -48,10 +40,8 @@ jpegenc:
>> jpegenc@58450000 {
>>                                 <&img_jpeg_enc_lpcg IMX_LPCG_CLK_4>;
>>               assigned-clock-rates =3D <200000000>, <200000000>;
>>               power-domains =3D <&pd IMX_SC_R_MJPEG_ENC_MP>,
>> -                             <&pd IMX_SC_R_MJPEG_ENC_S0>,
>> -                             <&pd IMX_SC_R_MJPEG_ENC_S1>,
>> -                             <&pd IMX_SC_R_MJPEG_ENC_S2>,
>> -                             <&pd IMX_SC_R_MJPEG_ENC_S3>;
>> +                             <&pd IMX_SC_R_MJPEG_ENC_S0>;
>> +             slot =3D <0>;
>>       };
>>
>>       img_jpeg_dec_lpcg: clock-controller@585d0000 {
>> --
>> 2.38.1
>>
