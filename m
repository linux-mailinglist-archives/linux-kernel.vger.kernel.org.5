Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786BD7A0190
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbjINKXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjINKXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:23:05 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24B81BE9;
        Thu, 14 Sep 2023 03:23:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJoaMAScdB43tQPLfic3aclFrBVPtEWp+JOpDk64K8GarF/kdfBXGsb/uFuX7e/YE9cqGtzhnaUsjIqwQHSbz/AL6pYpGG/mzoofc5W18zp2RpREVPmm4KvLbhgnKbF+mQPF51gpVdb1P/kXWSWL0z2EGZK5as07u1lvN3BRJChGehD3eF2h39yjeb6ZlGU3h74dGiG18ljqh75hpeoxILBLGw3NZ0yiw/5Feo1YSo57uQMf5XTkX5KZvtbap/yEhGB0jWlIq4IEApaQ+XB0t/EKhTNVCmIhuHv4PJHr0DwkkCaG/CZEwI4sCNP2zcPL1RQAb8S9MKYzdPgBJdgUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86e6zB0JNzVLJMib9ZdlscZgSj1VvstHvc51jzK1Zz8=;
 b=B++NgnY87Q9jCId/LrIm5k2pNK4oZpAnQ2bmrz2CfpFYy4Ze+2ncUgqdzTMIWQDOqNtNbkI3yyRBsuv2RPTfvaJ0eiafc43BskUzDnGASAniGoRvyc2t9ibbqchbDy0NOaQHWO2OJ981beoTXfxoio1ulFo3Qi2fuL7FWy/4ZK82eI+vhwFCs0kS5VZs3c530+TPpk94MEmyz6mNJzD2zsfJ7GN2fVxl4JXfruyakyvKQ1ok7S6N73pOsKsv2lcuG9amlCe7OQXYi2NvLjFfh9NxFb24AsOVlGCuY7ObE9RbbVuMiv8Vqi66YAHYlTN0yuDZTBxcsgKLNvocvdqhXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86e6zB0JNzVLJMib9ZdlscZgSj1VvstHvc51jzK1Zz8=;
 b=jOyPf1iRuGNfbW27uUw6sHZPBc6Gr49yCiDdYj6XiAiU/fu/XbrrDe77a36dQP2C4HAQFmboE5wrnv/nhvmoj6p3hWFy5szH1b9Xyw2xR+6eeYKl8x3T8uk8KFqd4zsl9cCGZOM5BgfNROL0E7cVJT05HzGUYEpyEoOos4WRYM8=
Received: from AS1PR04MB9264.eurprd04.prod.outlook.com (2603:10a6:20b:4c4::14)
 by GVXPR04MB9803.eurprd04.prod.outlook.com (2603:10a6:150:111::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 10:22:57 +0000
Received: from AS1PR04MB9264.eurprd04.prod.outlook.com
 ([fe80::22ec:b7f4:780a:ac16]) by AS1PR04MB9264.eurprd04.prod.outlook.com
 ([fe80::22ec:b7f4:780a:ac16%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 10:22:57 +0000
From:   "S.J. Wang" <shengjiu.wang@nxp.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 0/5] clk: imx: imx8: Fix some error handling paths
Thread-Topic: [PATCH 0/5] clk: imx: imx8: Fix some error handling paths
Thread-Index: AQHZ5vVuJ1bkWufps0KPYlMW4So/JQ==
Date:   Thu, 14 Sep 2023 10:22:57 +0000
Message-ID: <AS1PR04MB92641B7B3944C2CF9F3DA3B3E3F7A@AS1PR04MB9264.eurprd04.prod.outlook.com>
References: <cover.1693126687.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1693126687.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9264:EE_|GVXPR04MB9803:EE_
x-ms-office365-filtering-correlation-id: 4d004c07-64ce-497c-bc94-08dbb50c90d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6gVAkmZXr9dFDwjEHNfGNm2jJ1Ew+sLKLTwBhP7iyrBC4BkHi4oVqujovK/PgnPpz6fidJqAjMXKGa6g0eDWuB6/FZ+nOi7NfOVvUdCpvHJfe9CdGq03lmTd3/QjF6l2ZkI2Gsl55cVYRLzuSV84YaEsV5itxapD3Tw7AlMVUjT+PYWnPouq2hZBYNhXLFeWR1LWQOm3uKZCbE++/wyNsrfMvukeTxKcGweTgdXkSYUCkC+vqUdpGFSAOhf7w2aTqt0lh25TZIhvKISQRwwqF53WFxoQhuVHmLoFHdcnwMq5XcRAwYhBz5RNJbrrfIPEG04IO53Jhpudkj0Nc2/Ox8cq42s/mw5prFLjliqVLTSZGPZxOuVIZUDdOOwJvI7WzkatVD1QdpZdQY3cLtQTTRxR9G6l1HOg3dg3q48SmPQ6CXSWpfrNM+A27QMSmoOGopB5hQrno4DBHoT2kYaFv1tSIYdtx8Z5Bd9yVu8mFcaJ7rGschBO4S52DYa5xBrLGkJd8mDYgwEApKMXJmC7aQWwYwkEIyfeNzH6MD/AnXYbVQYkNR7q9dhLm0kPXxBO8iEUTIc2gP61ya/N8fZsHlDlTg6KrxDgHm+Y0737GvctF2pdp0xF7KBg8jl0JP4q9iFGH4PoOxj/dnSuKsxWvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9264.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(1800799009)(451199024)(186009)(83380400001)(71200400001)(55016003)(26005)(66556008)(33656002)(110136005)(66946007)(76116006)(64756008)(5660300002)(4326008)(52536014)(8676002)(8936002)(2906002)(7416002)(41300700001)(54906003)(6636002)(66446008)(66476007)(316002)(6506007)(7696005)(9686003)(478600001)(122000001)(86362001)(921005)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Gf6n21D12/hTdrfi2VS7XmildQMzXyLBfwzCi4RsA/jYQx95fRy0bH3MhW5?=
 =?us-ascii?Q?Spyb/k/aXHLoimFUdYPmCRH7vMu/vpXzFofADAPtaPzbVPTf4Da6STYUYJjH?=
 =?us-ascii?Q?KFH10NX20CbgVhU/HPFpUP53TpBwxvFE8WZr+PRdlVQG+aehbjTwNw15uBYC?=
 =?us-ascii?Q?w1GzxI48DJ0KSXeti7a6vbi53BZrOUZsXDsuc48Yn0Yowpw7Qo6gU1UiimK9?=
 =?us-ascii?Q?gpuyYiT6AY2aJAdqSFeydvdsMpgT5inTZvIwk/+b2IEM6+dFsKrQoeuUt/Nx?=
 =?us-ascii?Q?PCg0HX0CH5yGDW8JNvZhi3tWvGY7egFaMmda+y0JfVvYqyNrXtsIBXWkxktt?=
 =?us-ascii?Q?rtkrnZyNil2MU4TsR7hW03gA8+u7N5XW8UeYk60WLNx+IL0P6eCZq3fwDio+?=
 =?us-ascii?Q?yc8nBoac8YlOftVTws0vDkAUiNVOSKtV34i9DsVByAUASeJuP+I+i4Svgw5Z?=
 =?us-ascii?Q?dZnWaIkefvC4n9zZ8a0YvUUU1Ka7PVznBHDFGsfXFdcTxTAhNFpZSKjyYtRj?=
 =?us-ascii?Q?/jOlxy2ZHW8w+bIDfrIcyFBD4Wfv4IVE6kfqbCrZ51wfs7dii+C+rOPlXqwR?=
 =?us-ascii?Q?nbqI4KZunhW9anRMTDG2PmKH0E41l/7b63Klyv7iaJMw4cCMuP5w2tcQQIu+?=
 =?us-ascii?Q?lyk+J6rl9OOwSEroW3kxGJhd/r9cOnRud3/l0CCzjqrOlq/ILCg89OYo4b/r?=
 =?us-ascii?Q?/CCfiHy+MY+cxcLYBveC/LrQ/lug3lcw+BZTkU9uBHuiMZnUQQ7vkTZWEwUU?=
 =?us-ascii?Q?Jq7uZ0JUW4lafhrXUZ1j5ido6xfI+2Fn9HQ3BA0q5ax1RxFjhHaxlve5gxWm?=
 =?us-ascii?Q?1wyG4PFrcca4ASKu78SQ0fDEAtO6hXMbIqc6TLOJjgwJ50Al2SWtdy1JKf3c?=
 =?us-ascii?Q?mRry7TCU0N0BnEMZ1bsy5VNiMJlNdbtnad8idQdHaedYxfJpT4vriXGmhVWQ?=
 =?us-ascii?Q?A5YFeo2QUbcjjGMU8lD4vKi7oroqEk8m9sCHqSpbgCfGsgwhD5A9ZQU5jK8l?=
 =?us-ascii?Q?PpBaoXukbtvKn7F4DnWVAflpKyEMT+g5b1voH0scD7QRmGWD6CvfrL1LNPbn?=
 =?us-ascii?Q?phkamSsGUc0/Bc74J3fwLgNU5VUMekE3t+f5t0Wknh95ORPU7UfHJS1UQbgp?=
 =?us-ascii?Q?OHp2FZ3fL2BRFrqskY93rOCt1a/dgFkI8atPWcMksycw/J+tEVSwInPwASmm?=
 =?us-ascii?Q?b/2/PGqXS2pRt1pFXbllX9g0pR0Xl/miL/isuQHTzpTOAOINp74KlUSondY7?=
 =?us-ascii?Q?Q2rE1uFGdcMrZNAJnTFdoK84CHCyju2tRKlKfVC+wJD/Wv6dP9a3GSS8PU0L?=
 =?us-ascii?Q?XqrAtXoCaCvLayCMrpyC498sYh3pohAPFwN0FAGVua9cozvUm+c+jWyNgJgE?=
 =?us-ascii?Q?kMjSm1XVv5H8cgS7STY/rZPJ1oj6pcHduqNqoaUTD5fQBi8PNvOoEv+ASC6b?=
 =?us-ascii?Q?3fnXHisEhIVU8g20I6TWN21ovwF7ZWYqH3HoEuLheKsT5gRKmmTF7R/zymQI?=
 =?us-ascii?Q?V6p5sWYAclWWXMr4Q4qOpYepMuI3yDYjTH76ob1aN4SfFO+HYmCBIXNh21Wp?=
 =?us-ascii?Q?XcvTOOvhgKh/1WHcQGr/cvHYVztXnNqxKUg+bdQb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9264.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d004c07-64ce-497c-bc94-08dbb50c90d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 10:22:57.7163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uE5PnIvHCXUh3hp0MRrkQ5fcPmt2Hixlqo1ILQFyK9Ct8H78BJysg3jkBzRAplsONqCRdDf38BJZduHYIhjcew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9803
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> This serie fix some error handling paths. It is split in different patche=
s to ease
> review because the issues are unrelated and the proposed fixes are maybe
> wrong (I don't have the hardware to test anything)
>=20
> Patch 2 and 3 are more speculative than the 3 oher ones. Review with care=
.
>=20
>=20
> Finally, I got some problem when generating the serie, and some patches
> have been hand-modified afterwards.
> They look good to me, but I hope have not screwed up things...


From the 3rd patch,  it can't be applied, maybe there is generating issue.

Best regards
Wang Shengjiu

>=20
> Christophe JAILLET (5):
>   clk: imx: imx8: Fix an error handling path in
>     clk_imx_acm_attach_pm_domains()
>   clk: imx: imx8: Fix an error handling path if
>     devm_clk_hw_register_mux_parent_data_table() fails
>   clk: imx: imx8: Fix an error handling path in imx8_acm_clk_probe()
>   clk: imx: imx8: Add a message in case of
>     devm_clk_hw_register_mux_parent_data_table() error
>   clk: imx: imx8: Simplify clk_imx_acm_detach_pm_domains()
>=20
>  drivers/clk/imx/clk-imx8-acm.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>=20
> --
> 2.34.1

