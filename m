Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6AE75C1F2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjGUIrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjGUIrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:47:06 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2051.outbound.protection.outlook.com [40.107.13.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF402D72
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oANZQGOB6DbojgVANY0p3RYZFoCGkcRcaNcntP7ugY11WYXbNINqWuUK7pXV9HcctLCSZ9prks1VtlCVW3KuCc/eAMo3idjTSh0UduQKn7M8rrIuX6oVQ38cr7Y/WXAEKfT1IUDcCKCQXbck5WnMVnXQnTVLzRa5HJ3GeZB66BD9qLvR/cMWR0zmZ7VL4unHGl2xDFvM5pFjbFfeaQ1nE83Igte8qwVtl6L4JQiFq5hU0SIRknWFxOsTD7810oaUMPy+ASBzaAxyttTLvr5GnsnFCkmotxWoPeqhraXpoO7kWVZwNlbLBc7lTWlYk2I6SyW0b8jGjG3jQxHake9JyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feWmRxSrX+Jd86rfnqN4kUI6I4RA0J7byb+PrkHqCDw=;
 b=VcOfzEpD3dwYS/FF3EmU6ArKcHQfuDlyGg/bOcM9drHFiU0jkotyVvGeCdAgNjdcV3ywQUHczKJofsOUJaqGpbkFLY0av//c1w7Ihz72qmYWIQbnu8inxduagOQH2C6JU+wvrdcxjTTtUf0X5Zlo4rkPs33zsi6ug5wWtb7PUShEXXe2iz/IRl/Fw5vhqw7PZjkY3bZfDO885FCvrtNMIpT9SkQZpE3d/a0LAbPjm3J79odNVrbm2RvpfYsBFh7PHGJNBynJ20xTDshvqegHe7EFQ36jcGj8fcYXzWaCv+CoAjf3oSUgNWq7GiIJsVE06uJH7idKfHwpInAys/+N4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feWmRxSrX+Jd86rfnqN4kUI6I4RA0J7byb+PrkHqCDw=;
 b=PbUFR3pbNdOeG0dTON2CUt0nHc6iOnNXPe6HEoViJqLY59iW5QqtrUNljvZ9BgcGVOpyCgCHgjxLrHr327Gr/2alpgHzOW45o/3hG+8pXaR4kimkJ5zShAZxxzAOyMdggcku3QjoOgyFP64g5dPcg9rFhkh5iuYRgEYPe8Ocv6g=
Received: from PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14)
 by VI1PR04MB9833.eurprd04.prod.outlook.com (2603:10a6:800:1da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 08:46:55 +0000
Received: from PA4PR04MB9248.eurprd04.prod.outlook.com
 ([fe80::cf13:31a0:f65f:592b]) by PA4PR04MB9248.eurprd04.prod.outlook.com
 ([fe80::cf13:31a0:f65f:592b%4]) with mapi id 15.20.6609.022; Fri, 21 Jul 2023
 08:46:54 +0000
From:   "S.J. Wang" <shengjiu.wang@nxp.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8960: Add DAC filter characteristics selection
Thread-Topic: [PATCH] ASoC: wm8960: Add DAC filter characteristics selection
Thread-Index: Adm7r8fffULz+4vvRqebd1RnJuBMbQ==
Date:   Fri, 21 Jul 2023 08:46:54 +0000
Message-ID: <PA4PR04MB9248B7B1EB61D28C242A2F7FE33FA@PA4PR04MB9248.eurprd04.prod.outlook.com>
References: <1689925948-21001-1-git-send-email-shengjiu.wang@nxp.com>
 <20230721083400.GK103419@ediswmail.ad.cirrus.com>
In-Reply-To: <20230721083400.GK103419@ediswmail.ad.cirrus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9248:EE_|VI1PR04MB9833:EE_
x-ms-office365-filtering-correlation-id: a3856339-79ef-4337-4abd-08db89c7092f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dBHj+pVJ1siRSKx2OwMrgNPrskfFd2nu5qRHzeUD8n8Yc9Q4fWr4JqjYiyABRuGhXPO5QpQcAOKZ8r71qCNeyev3fkLBYSqrr3Le6dq6jfJukORWEZ2KKqOVz3XQMbRvnnMoJrTwZw3BxXFi01dEG5//VZ4P0xVzSVWcBV37CVk5eFqqq6kguazHTaXKrjsYkuHhk+NBHcFg+ILlpTE1OfFd0LgWs0dnp/b2qg6AXQ+TpAQJWbctpDKUtRaRDFnucyIUdcEXJ2upBfFrsIdmx8q9xr8btylXPy2fnrxqnCwbl7VelQGGveMjolk0LtImJ2jCg10y/ovDeElf/Dctkn0Pz5yAKhCvQ0Su+WGYKGFU73lwyr0eQ8y4u9PYZzqw/7f+3gRhHHJ0yqAZEp9n6nR1bZkP9tSEHqJ/LuNove9+UmdEXwroaT/UAmJjzVEivSHNZKHzMGNTv3YbFNJgARQ+YpUhJOXRbDyOf8trO6pAOES80O/KlaqPNMgCR0gfeUPHD3Admjk88PaPKVPPpw9Fb1ovVqJXYbkFZI89OY06FxK59quNk//bAS5CLq6ZlRJTBTckKx9cxmYt6W+PTXOR8COmMCUyp6ThgsPqdwY1F5Ybt5nzHNeCHPNPD/Dl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9248.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(76116006)(2906002)(66476007)(66556008)(66946007)(66446008)(6916009)(64756008)(7696005)(33656002)(4326008)(71200400001)(54906003)(83380400001)(478600001)(9686003)(186003)(86362001)(122000001)(26005)(6506007)(38070700005)(38100700002)(55016003)(8676002)(5660300002)(8936002)(52536014)(41300700001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p/ahN6lXoRYIca1Cgu65WDx/JyArSPwJQR1kkjsSLwJLjwYIAduvEacKLRvg?=
 =?us-ascii?Q?+P3R8kLCHZroP2/fU9QZgrFL6HFMlfPIuSp3WEiCUz8VA6Hk99zkK9ZYAF+G?=
 =?us-ascii?Q?+8flrERXDysmg6mYwb8IBqnBak+Hb6QY2SJk1bk64k7VWFovgSDYgybJbdrz?=
 =?us-ascii?Q?TfgTUGBYx6+hwcb3J0udxln9739w32WhBnolSrwwAsh7HxD5GywsWOYL9+IT?=
 =?us-ascii?Q?Qptpw7SJRuYUvJoQ9uv3bT2IZdLIU6fE484cNWFhxIxtvjLIm7xQCOA0d9yq?=
 =?us-ascii?Q?hYaXjbwUlxG5xgn3MF3rHqEwnB3MsFEcDErE7LBWEkBHLA0btxEgXCYPCEVE?=
 =?us-ascii?Q?NsfC7huBDxWLupS5ZTKGTbuAXLCkzp//pZ/izLEgT+U/amHz90n/A/RH5rr6?=
 =?us-ascii?Q?ouNafgFFzP5iyNDkEu3PObVQGiYuTmB2C7aQRZH9VQt224btGF0fdDqbwjic?=
 =?us-ascii?Q?pKK5e2bVTeYU0HylWjbDQ1l9b8JTJTeG4g692nUWFMaXOiSqitVOQOhX3+72?=
 =?us-ascii?Q?5IHMbegkVsnPv0tPTE4XrV+vJCslh+1fkaa0j7snuAkpNuhRg+MPTEL76dK9?=
 =?us-ascii?Q?2Ie3dfM01o/ywZSTKt4oztLxiIIc/ihWKZj8NtZnXMtbcV8BZ6PzqWz3Uj+r?=
 =?us-ascii?Q?ImlhNGST1Ziq5xpq3k2767MKy/AYjeasTQJ3CX2TWlpuvZXdzZl/8TgmAtfN?=
 =?us-ascii?Q?U4uXZCK4knfIXN1qgil0ETHqv8V9TnkFAB3PLLnhJD71unWBCxnrqL60z7Hw?=
 =?us-ascii?Q?bY8pgQXF/0B8g4qWbAuR5ljMig6WQ+6yESQQhwDnX1z517MdtNtIFRMzeBI4?=
 =?us-ascii?Q?HKMqtMgIPemiPiwBDI3FqgA6E84fJ3cIMYaeKEIWlwN0z8IbEdLuZT5x4hNn?=
 =?us-ascii?Q?x8W5Xn2nnbThPHvSqw/HoenaqkDexWd9ENEAuIRkP53ga5NGKvtiNYXluVEZ?=
 =?us-ascii?Q?UjDb4XNAcCNqfCv2l5aX1xWTqNz+Gv+KNHuAVEL5oxeINJugXuk/MsV3omye?=
 =?us-ascii?Q?XGhkOQE3/XgLZ576+dqY8QV9V/mLrmk5xfQE41ONHJoCfd2mBpgZ1WO3hPfm?=
 =?us-ascii?Q?DPS7f2o+7E8QfFDqV3Ts/cCdrWH4/N2ZzU28sAxD6sGpVu9+leA/ODIqIM4z?=
 =?us-ascii?Q?VuWwfrB6G9vyS5ofmqUJvdcWt4/WPrut8eDacszaGDYjSQPDMnFH5HXTBHHM?=
 =?us-ascii?Q?SXgGw/PDFFtQy9PnhsJZB/oI/c/DRJCjIfUnSftXHbPYa+nOxWSAFsvT0JzT?=
 =?us-ascii?Q?wHVV7yp62kGZTfgBTXbjOpNiTvAyDjLwaXLX8LZta77qx5jnFFwXA/IBiCOX?=
 =?us-ascii?Q?gIikXkNQWLRS3ewA7+E0MZ0pgphu2zGG79ZsHa6WreMXcN9Hm7FTSAQDOMdU?=
 =?us-ascii?Q?G015C2qWPhdYNVYUebEpRcQfa5xGyePDrx1lNXWY3hpKDDfGFVc1UyC+cQK7?=
 =?us-ascii?Q?HhBQxdsHg7PZFJuyYGGR2/LZIFMANqlnYRns0dYntjPSBE97Jpzhk27jtOEQ?=
 =?us-ascii?Q?YHCH0pSZoehOmgLVeE7zzcg+Q8/kPwT0b8mFFs87pAa6ngxir4LArNTU/MET?=
 =?us-ascii?Q?ushzNBOmW841cVO4cjTtyHCDmElF7zyLCwZkBObY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9248.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3856339-79ef-4337-4abd-08db89c7092f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 08:46:54.8305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IC9wyJcXzVofrdYUN0V7rkng6ueZ07Rvhg29TPUnIk7qLVXmsPpbA6vqxK1WGkiPpwl9chpWWQBRA9g25Rk0UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9833
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > Support DAC filter characteristics selection: Normal mode and Sloping
> > stopband. Sloping stopband may have better frequency response.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/codecs/wm8960.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
> > index 366f5d769d6d..ff1355306b43 100644
> > --- a/sound/soc/codecs/wm8960.c
> > +++ b/sound/soc/codecs/wm8960.c
> > @@ -155,6 +155,7 @@ static const char *wm8960_adc_data_output_sel[]
> =3D {
> >       "Left Data =3D Right ADC; Right Data =3D Left ADC",  };  static
> > const char *wm8960_dmonomix[] =3D {"Stereo", "Mono"};
> > +static const char *wm8960_dacslope[] =3D {"Normal", "Sloping"};
> >
> >  static const struct soc_enum wm8960_enum[] =3D {
> >       SOC_ENUM_SINGLE(WM8960_DACCTL1, 5, 4, wm8960_polarity), @@
> > -165,6 +166,7 @@ static const struct soc_enum wm8960_enum[] =3D {
> >       SOC_ENUM_SINGLE(WM8960_ALC3, 8, 2, wm8960_alcmode),
> >       SOC_ENUM_SINGLE(WM8960_ADDCTL1, 2, 4,
> wm8960_adc_data_output_sel),
> >       SOC_ENUM_SINGLE(WM8960_ADDCTL1, 4, 2, wm8960_dmonomix),
> > +     SOC_ENUM_SINGLE(WM8960_DACCTL2, 1, 2, wm8960_dacslope),
> >  };
> >
> >  static const int deemph_settings[] =3D { 0, 32000, 44100, 48000 }; @@
> > -307,6 +309,7 @@ SOC_SINGLE_TLV("Right Output Mixer RINPUT3 Volume",
> >
> >  SOC_ENUM("ADC Data Output Select", wm8960_enum[6]),
> SOC_ENUM("DAC
> > Mono Mix", wm8960_enum[7]),
> > +SOC_ENUM("DAC filter characteristics", wm8960_enum[8]),
>=20
> Be nice to capitalise, to match the other controls but otherwise looks go=
od to
> me:
>=20
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>=20

Ok, let me update it in v2.

Best regards
Wang shengjiu
