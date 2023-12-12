Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D20A80E05C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbjLLAkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345433AbjLLAkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:40:20 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE152A6;
        Mon, 11 Dec 2023 16:40:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTIWzsafZRO92bH7GEs5z/YXxTKYm3mcGTyqCWutBHEmYl86WavWIeZC1yXOK4sZFTQ72R+srxeVTaZvdFotHZvuq5NjaJrCTm1DuS/2uXjbAR1lmHgLigXQ6hva4mufqDFqKzf7iLj9fGKIJkwDVA9cB3ZRURkbFWmobae/ma/BCVuzVdHEHk33TLiD+jClx6e0BK9PNZ7d+nzZc+R4B9bzsqiCE2kXJnrNpBn9TnGHyQWrQ6zgfFc9Uc+8ipa8Sc6C2Fz6v4EA8k08aAcKmGS57pxjrtPGU2PbCbNEiJj1uemuxta0sGlhRIrdKJKnX3zOtIsX8N+WCb9JAIcwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TgezX8kB95wMh7QtiyQKZLD5Odp3G2oX1bPHRtwmGY=;
 b=gvWIw/EEw+QAlZytUn8YWINggPiAA/c1TtoBOeWANqzfolu81Gfb8+ANuYiBupeRJ/X+jmysjLOcpMHLMY02Sy+nFNY+CLJg6qVxJIEcJUVT9tcNbWlgH8l9VnSqOYV6CstW9Y0CPZBke2T56Ohuf95PlsZlKaGblgAy7cw4HluZ7DOrZT97zIc0gkhNdkWtkONbnBZMCz7AFc2MVxpAonwqYSn44YC7GPGOyr0hsfGPgAKtFiqrdPjjOZy9TLS27zx8O6goiJh0DJbiUPrkoSZd+W9hY9AQXaCw6PAZP0/Zj+VTWnUKrWjRXHoLQmTSH5lQ5+FistdLgGzYnZh/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TgezX8kB95wMh7QtiyQKZLD5Odp3G2oX1bPHRtwmGY=;
 b=jo/5y/o2zFFw5NtRLwC/868kXnmov1F9/Ylj443FNZ4/ZRXxpIRw/4PeSRRwCpsHe8nYYXAZSWjUzFWL8b61DWsbKQ3JKenF2reQJg3xPNrptRAYVyYe7wz4YZbvnuFi/l0Ut3lu5TqAjOwAywSKD0jakdaxD40+A/FSo2PMT1g=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8956.eurprd04.prod.outlook.com (2603:10a6:20b:40b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 00:40:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7046.015; Tue, 12 Dec 2023
 00:40:24 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Kuan-Wei Chiu <visitorckw@gmail.com>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: scu: Fix memory leak in __imx_clk_gpr_scu()
Thread-Topic: [PATCH] clk: imx: scu: Fix memory leak in __imx_clk_gpr_scu()
Thread-Index: AQHaK40Eq3qRKXwHhEOi0TlJexr4/rCk0GPg
Date:   Tue, 12 Dec 2023 00:40:24 +0000
Message-ID: <DU0PR04MB9417FB5A373326F954EB7CC3888EA@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231210171907.3410922-1-visitorckw@gmail.com>
In-Reply-To: <20231210171907.3410922-1-visitorckw@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8956:EE_
x-ms-office365-filtering-correlation-id: a38e68b8-806d-4924-df58-08dbfaaaedcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hC3nHvctdIz0gN2xTJiT0TH9K5IMIW/ND6wrtQ4UPLKGCRA2XFekDlQjD33xoeVH9ufddB9NwQ1XQ6Lftkqr68eSiYfnW6jlRuNlfV6uVKP6EOPyqGskQGgMIUFSo5SGrv601mdsPt2+2nmvIfxR25CSQcKo/b+b73DjF1fClRLjgvG6hkFL8yL9DsY5Z1TF8fWBrsOtIXyNQMbWzlbbFbQuuEl0cROcbtkxzRk4uBbKDWnqtqYbXXkj9Wu7DTGY6j8C0cdov57ifi8kA5u10YuzSvLgnw6SFe3o64BbC7mrN7vrYPhhi6TkPM5cuywzwL6plaanB+Z+WjuoDl0BVPjdoHMr4H/oDtkWKDFiRlCj/Y0ssP4HQkfZSGYD7hKb36QwsADiCFeVTHWDOenOznlvEYhc6gMIimiPa/D32nBi5vdcYMGVQPKHQ0ADzt2X0y1pdyufTT+xlb9HCVCl6AnpUb+jF+2omFXCmTy8V+owLe4hp3wZW52ykAKv/TWaOBxDUkl1cv0kTbhnPdDMHd584T90SAOIBETBUvsxPebatbUpEEYIW7FQ4GBA9Gu45AoHiSMiNsfws2hUMZGC1XAchIeyS/1RLvxe/glXS4MQYOPHUyFWadTO/+zIj19q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(7696005)(6506007)(9686003)(122000001)(8936002)(44832011)(5660300002)(4326008)(52536014)(7416002)(8676002)(41300700001)(2906002)(4744005)(316002)(478600001)(71200400001)(110136005)(66476007)(66446008)(76116006)(66556008)(66946007)(38100700002)(86362001)(33656002)(54906003)(64756008)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OxWS0AzsKVackWPNU9bhAVmQ/fTx0DdkPyidJovEBQRgqaNLFmpmW5lGqtz5?=
 =?us-ascii?Q?PoSa5z+tCERShlHw6pmd2RqmxqXbqNlD9CBs0VwSH+L48qGSNzvKW0mKzcuf?=
 =?us-ascii?Q?aY60aG3ezaDxOg5dloeyXnOTqHP2fcwM9cuxVREtaHxr+NfmtdjuobzZXX8h?=
 =?us-ascii?Q?jMl7HjSAK5RhVEDNNI9XHi7PS9CPzN7c6Yf1qKKHwBaBrHajswsYR+PmX3Vx?=
 =?us-ascii?Q?zvUurMsZR2qYiwnetJWI5gc+A1tvb1dT2ESMlqU59I4U6sc3McVD+7ybsPQW?=
 =?us-ascii?Q?14R371IpKoG26JhlTz0c0EXhTEJ7UTDh7OAYGfIzs4E6woPbCylffM/yqttt?=
 =?us-ascii?Q?WZdcMwvZW/ZsKrUFxRDR6XQB5QqJ5WJA6P2SiT92h1Yx6kJmIBYrPVNnLSsf?=
 =?us-ascii?Q?oOq8rXzPJ7tB2pSUTpZpQZUpRunqQxuHDYIPPTqKRMxaPxGPJCX9i/y7+mOg?=
 =?us-ascii?Q?cL2apFUuiT7IbchyYB0PaRoScAzvn+IOOI/eYHpxMV4GHpfUETvcxkulOZbS?=
 =?us-ascii?Q?rkm8OceKADSKBjGbX3vVdwba7vvqXgIBK2iv2gDDdTiQYX47yWAQvY8kL8f/?=
 =?us-ascii?Q?c1qYOgRXgVQNLu7slZgTFSHkcnXZwn01YJpSUxaJSMt9S5rX9JciB/bAeKrt?=
 =?us-ascii?Q?VMlaohM2emDt3B34mAlyuQS8P/ynsHxKoQVj4QlZyiTL5mHeZroHGNV8nH1m?=
 =?us-ascii?Q?Qd8MEWhBZ1+o4NTUjUSyjQpzUHyiam6h17w92s1OAxOWhh+jh5+ubm83ANMs?=
 =?us-ascii?Q?tJXoFjTWNNFnKBZdAxSJKkrnWDAJFdfXZlm8LimS6tpFlgFp3AzcyXh+RvfC?=
 =?us-ascii?Q?vMQpT6FkWPw7wnHimozcjVJdpGTJcQyg7rS8PdTXt1AYFZxLW1szBz7OZPMc?=
 =?us-ascii?Q?5cAnLydRiMTKVGOaaOnsRLtSrQLh/aEoxlQT56U6CK5rWFX20EiCWOYJkhfa?=
 =?us-ascii?Q?SppEGZXRRSlSUzFwIcjiMapCV5ZfeGdplqS6URrym+YxxoUYk7QpL9ktKgz/?=
 =?us-ascii?Q?DzOTOthyyEepkzXCWu9Wv9iwjqbN+jtCXD1yFneGm9sruh3Ky4FeJBjbPqCO?=
 =?us-ascii?Q?/MtwsDG8DXWM1XosQtV248ai/24bsUIXNFXKt67BAdDE7AG6fu5rbabWONHf?=
 =?us-ascii?Q?uO31TJVuWaC8Mut5oicVYDOZXHdLd23E/FwQHHnhZ6CrwmPp+uxC4ku3cde4?=
 =?us-ascii?Q?bJ8hvl3zn9EYymMYwWt4gpJ70mEFGorLUEsVg8KSM+kMqHtsi6OR3xfd9wi1?=
 =?us-ascii?Q?iOkS0IyVguwXjFaA57iJonxCmRIZHxiC0KLDWinrzJcTTuyy32AsN+KwGiGx?=
 =?us-ascii?Q?Gydp2ni4XFNHtXw2UaK+ysSu8nEmrw/5lZRPt9iSn1HSmzcvzVZ5LOTi5x6A?=
 =?us-ascii?Q?ZJavlfv1tLrn41K2fJ+NTZUUT06GndkP5OrjOa6Mv9kYL6FfxU1NE10MAyow?=
 =?us-ascii?Q?jhgI4HzCG9gOAEortLkYT4ZnzPftQhu8zacszKNGO7qrDIdhIJgo5vi2bHsD?=
 =?us-ascii?Q?z9D/wZJQgzBH8VzUQVYnt9qtPrvlmvGLpBDPfUD4pbf7aH+13SH3UGTjKOkL?=
 =?us-ascii?Q?gBDWcLDxVSVYr+imoJ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38e68b8-806d-4924-df58-08dbfaaaedcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 00:40:24.3895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eu8YeBb23i67Xf06HxaJMRI+XJ40H6W1+GahLbpLzLRWm1tEDNANOsiKYPkMlJxtLeR46ujCCt+UpSST980tmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8956
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] clk: imx: scu: Fix memory leak in __imx_clk_gpr_scu()
>=20
> In cases where imx_clk_is_resource_owned() returns false, the code path d=
oes
> not handle the failure gracefully, potentially leading to a memory leak. =
This
> fix ensures proper cleanup by freeing the allocated memory for 'clk_node'
> before returning.
>=20
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
