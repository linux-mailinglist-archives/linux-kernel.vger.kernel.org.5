Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1357F7BDA41
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjJILs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346311AbjJILsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:48:55 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2075.outbound.protection.outlook.com [40.107.247.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1901494;
        Mon,  9 Oct 2023 04:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCFWpML8oGXFiEKyZnqXW7RHovFW56k0wihSl5VwaHmTkDVbDuBcM9vcqKr4wY1H/HoQMO3CshsXhJHYEPXdbtrY09HrL6niKHdjIaMQcEf3YyQhqg6QAxTJArDJ488Fb6WJ6VLGD6+7IJaCC6KQwtpsD5Rn7rREnSvzoKX8u7HCHN9eUlyvKme7LbzP8GQU37ilzsXSetJIvw36PhT+JdUnFQsX/IV5U64EJitoCKLR5X0yZigOFlCeoSzs9+70mEXy6ffgqJhXSCpzwbnNkbCd+SuDEyYpXPif9LVka3pPf7nsf4/dJHVf02JwGUhnIR1WsxUZOgmaOMWn7Nlo8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lL2MRkUflYtAtBtpdll5DroaHEFG6Zw8lvFh0oSApc=;
 b=hygegMdAxI2XXCcAe07rhyF0NCNdkSjZeBscs8gOrntosgZQ700sRG3fnkv6byQ1MYBeKLSuWh3WgZHyuagSMsSbdau7bHFBtnQa7gpgqA0+YyaS6wqoHjwHqy4wcvpBGOEfVDOhaO00ae6cIp8CqVcrTZ5ASeyVlKaS6FUZ/gCWemNP2u8kO6mVVhsuigikOUlA/iiOJRX9Nx5frzUUbcoHodrowZJe/4fKaIWJo152nXNXd+y2L8ECEq4fRk9JmXB7xyyTVAPTbHW960k60ryqfsvZWQHCBN1zl0naqzBuz6HTQWL2K6e2//p7EW+lUhjJdfhln28mNI3u/ITMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lL2MRkUflYtAtBtpdll5DroaHEFG6Zw8lvFh0oSApc=;
 b=gAceE8QO+rtlon8G28k3eTLZVmDiFVLv29fU4XQ4FFgfiWfQRul9AJ6vQlCsIbCUOQineQgHB4SuRk3zhezMnk89tJsJvA5rmbukax2ys19uwyptL1iZAnm9vp+f92kC/5GPUC4ThXaywjWOE3NZBVqjK7CukFAt1KryHOb6eaE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 11:48:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 11:48:48 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Arnd Bergmann <arnd@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: imx8: build base support for scu clk
Thread-Topic: [PATCH] clk: imx: imx8: build base support for scu clk
Thread-Index: AQHZ+qYYW6M1ut1XWEe91KC44G4N5LBBV6/A
Date:   Mon, 9 Oct 2023 11:48:48 +0000
Message-ID: <DU0PR04MB9417E3D962D7ED203E2ED21988CEA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231009114514.120130-1-arnd@kernel.org>
In-Reply-To: <20231009114514.120130-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU0PR04MB9276:EE_
x-ms-office365-filtering-correlation-id: 634e62be-74e5-4e28-131e-08dbc8bdb384
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MYWxDN7bYCDJG6W6N6h5fF2vxBhajpri/XJ4ebRgz0xpGdg7dA/ELxzTDXjxFwczpp75+iemqnEXgmVEH0oULvmlnpzMsy1RLabBK+z2Jo3ZF7sFNVOMhTUMNy74ta4LlBdS1vQL1CWkYs5EUujanYj3PDQO8wPyBySg9iY8L/Is4awVF4/81IoR8DO598Kn9qNYprfvLGiQgVViO6eib8d0uhbzZjKknUJXor+A91d6BZ4WL1lnUN23zBmd+6zCZiRsbmkR8fHwncmD9pWXRFZYODDKDEEp9SQOtyV3JBligHfa2SpNK7EFDe1SGO6XgyCI4yN9Cuxd0VSnrFKmicSRLFLSTFOOn6/o6ECiy9hMjBvCjoz37QSh1AJhfJkcBIFIW7PQrAB//YFuoFhjkVnvg+R0I/EJMVVsVVdGD6YLUdnYisbzK2HYWNrOIKvcoSLuhoKMofP4rEsQ5i9IyC/SXx6hkiqZ9BaCFljqqJyWJ6EmoIkjJ9q63TMUlysS+Wb/PioAvMgDgZTGIdhLJkI8W6IofTK90yk1+mmWU0/+98CG4pn4Z093UpM+eISJBgEvtPNfY94z25Cw3IuZxah5y+eqLKLFWspr8UJA8KZazdtGOwcuMpkpUAPHOuz/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6506007)(7696005)(9686003)(55016003)(38070700005)(33656002)(122000001)(86362001)(38100700002)(26005)(83380400001)(44832011)(4744005)(7416002)(2906002)(71200400001)(478600001)(41300700001)(8676002)(4326008)(52536014)(316002)(8936002)(66476007)(66446008)(5660300002)(66556008)(110136005)(76116006)(64756008)(66946007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xZFrTD+Z385AxElgVYcHBaxxON8lSXh2jTQkSBpoFQZmz472h9WX0xZ7iMvl?=
 =?us-ascii?Q?ta3qB8B5CxGPoOzMd12vJI4aI2bb4t2HcloBLYz3HHSmtxJFD8Db7B717R4l?=
 =?us-ascii?Q?ul/1dXMF/Si+14r2YQE4vVkDUeWDxXPBXCbqePyAUFPSBlLF6tT+2XLRBT0J?=
 =?us-ascii?Q?FRJyx2JojBVfl78MsANWdFg4SqnE7CB6yznC8SXiz0g8G1gDrVVz6KgbeFv5?=
 =?us-ascii?Q?wL25UX+Z906QX4s6q+3n8agPcuPy5dO8Dxe/tgXvnMA7IChTHWcGwNHKb3RV?=
 =?us-ascii?Q?9OrfGmBc+AGGWlqKpk7Eug6wlfRlWDpeTde8FiXQLez6wChB/QJS352tjX/7?=
 =?us-ascii?Q?G/gRU2wdlkVt2N5HmX44PrGjnCXpPsZ6EoyeI1MieDV841oGpAiu6xo1RIgt?=
 =?us-ascii?Q?sf/hajZ0Fe2mNGNY593sqwTTzbPBiHQgWHcN/n4t/RyZ9wh7SQHRe7F/6LGv?=
 =?us-ascii?Q?xCr6+NFklazaD5sRm3Pghno0zAgo+itQ5QOqoiXoUHulVa9tLKxBdw8KZ2tw?=
 =?us-ascii?Q?SYxA4FJT/4asLE2Dcj/6yzDUlLVvdZuHmrG6D4g45ooegx+lD76+eFWzNuuK?=
 =?us-ascii?Q?XiP62f7dE2Yb9RhNpj5grCDOxXJfcsHEShmvMhPGFekGpptYLKp37jfJjPww?=
 =?us-ascii?Q?lxyRMAaymHj6oysJFpkbKtMSBgNH3x21ktPOTPNRV3PyU8kEiHIoTMrHiKxR?=
 =?us-ascii?Q?X8yNKbJTY7RWJG4F6TwXl8KaxHhFiEABg4ASCP1GXP/DevroB9d5UEgXDBoP?=
 =?us-ascii?Q?nf4CYZenGvT3wYT7+Sv7sfNR5i/pXzYOuYYpAP4y1V/9viECoS5dN00RPeZ7?=
 =?us-ascii?Q?O405thJrPQVBwPlG/ksM6a39gbWP+GKeRMtQgBrGj90RpN8vdc9O+Gis64x/?=
 =?us-ascii?Q?/3TeJ+btLywuL7nALlP2VP0I2J4Yesd5LympciA8QDUlUk/82sihNE81tGOe?=
 =?us-ascii?Q?Wg2EvNLUtxoV8uXOwiLhQHJkAyWRgpJSxhLwVZkP0iYbeeW6Z7XebPwPDXNh?=
 =?us-ascii?Q?VooP/PjZ5r7GtXXUJ0GeBegEKmLGi3Hy0O0Qlhl3FGJ/HPSCl/JBYwXHII5M?=
 =?us-ascii?Q?aKJHMnL5GdLHY6H+q75TnwsYG95M6T/7c+qdBdAFPUvdaxYcsq1aM80TXcAu?=
 =?us-ascii?Q?QPGzSpGHkbHYvkKMfEL8NFOSkQVkVmkoJRBV1KRSFkFvbhj1D/pY2rchDRtU?=
 =?us-ascii?Q?aBKX7lGq8dTWn9htuCjT5ozFgHnOf/C0ZxHdcCuLFbGQlcL8f+Y4zH881RuG?=
 =?us-ascii?Q?s336ZFCTlcyuPF4sVGUm47IetCXrW2flp6JmFVpodcnI11z/Ziqniub4NvIS?=
 =?us-ascii?Q?oWV9eMqo2kVpWbSPmbchEhq5BEUPhzda9MktRiQ90ZPDuG8cNOHlRLBXs6yk?=
 =?us-ascii?Q?l0b26z0kTQDIQ/NwkCMLGpFt/Y9TAayV/KmgaIpWMHajOX7GQVTEyaQpwbz/?=
 =?us-ascii?Q?soxMqyPZ+Gw9xQQdYaFAnFcTuTOTovu3aMu/WTnGk60KIH3xavrg/RSwoqqE?=
 =?us-ascii?Q?LYNMHB1hNKrpBm4zq19yUoP+GcbhW/AEkIFflhNtk63NpjGb5Eo5o97uFNkT?=
 =?us-ascii?Q?kBF8/35hP81oWiiJhiQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 634e62be-74e5-4e28-131e-08dbc8bdb384
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 11:48:48.8927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfzxBcUSQCLuSsPvG2rtuTMIPQMh/bJQrVQixMY4BAtEkaQrNHfeS6SE6agWhbytblxYRW/LM54Hwgmp7HsdmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] clk: imx: imx8: build base support for scu clk
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> There is now a dependency on a function from the clk.c file, so this also=
 needs
> to be built:
>=20
> aarch64-linux-ld: Unexpected GOT/PLT entries detected!
> aarch64-linux-ld: Unexpected run-time procedure linkages detected!
> aarch64-linux-ld: drivers/clk/imx/clk-imx8-acm.o: in function
> `imx8_acm_clk_probe':
> clk-imx8-acm.c:(.text+0xbf0): undefined reference to `imx_check_clk_hws'
>=20
> Fixes: d3a0946d7ac9a ("clk: imx: imx8: add audio clock mux driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Peng Fan <peng.fan@nxp.com>
