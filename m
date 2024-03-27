Return-Path: <linux-kernel+bounces-120207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C5188D476
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FCC2A853D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE06E208A8;
	Wed, 27 Mar 2024 02:12:11 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2099.outbound.protection.partner.outlook.cn [139.219.17.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7BF219E1;
	Wed, 27 Mar 2024 02:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711505531; cv=fail; b=YqY3Ka6odZKW+uFnXyt/fYPyYWagunqOdeUHu6/JI/AkZd3fJSRHNUncShATtAkU6tlqjQ7pmcyXKtzHUh+Sqzehq0yiUBGrSPLsqf9K+AFtRg2WrwcBTZUWdGtNjva5q2PDV3F3avQnV+vM2Ev+XdQNMfW0hFKbnu7uYc7blcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711505531; c=relaxed/simple;
	bh=iSHZ0gl8GI14TDFXjhCWa/w8IFAFFM56Yl6eU4AWct4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kl3dilu/tWimjoqa0y+GngK/AG0acOrRcVyrXvNnR0Nr+NBo2RjgJBfnsBmqoW8n5DrspASRsi8woe89iNHMyPVjXWdCaTv6fysPu/dBlJ8l1/aCI5DtW+XWnfWDoGZXTZ+w+j99l0/CRgW87NcZKYj7x3swysnrnlTZQuQs9eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8effEXKuk/9SZEgRZMoxD7tcoXmT9GXldqKStYlScjw4Fp7u9uyMZQHbLTCGmCB0zo6JouEZX4H98Ior2OEdojwtO2KRwuinhiI0b61DLPxJW11gjdai7EplJ6H/ZWZUcd+7/XIb4+mCDcgoGF/JK06VL9lHyMiJU3LbtBEcjfErHpwCEga+XstcyvLRAlKWqZ8LCBqZ7J+DA2ZcOILA7Jj2Sd6SGFQUmO463ofsMFOr8jkDBR4W+vJF62oZZqNI7jUYny73BCUcbjVxW3wjPyWI0i7rMyNQdYeyOHM+ELEPUqjeJxO1SurnaIjJPfBvzeKEHqQOhRvD1Pz2JwdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E75TAnZBxrI4GdI19YGxN/ZvAI2cCiCG6/8xwoU0nWo=;
 b=k3KWIFfRLRmX8w0Ts3TnIz/xbtz4GwsD35SoELjz7FJ1kTCvRa96Lt1IFiKnOXprGzkQruPYpMD8bQqt0zEhEVKBXhGM8YjTd43/6gvYlc9IG0eCOZJP++r1gIukHOry6JR4vbtQ7KZTMWuP5588lKGU1VuPyE2EccwZUFKBWSbFYBcLLDSgsa0zRQsy7LZ0Y6n3R283bZEDZY6oiLySkuJjPvcrJbKOoRO9OKCRLDMGy4Y4HSWkLcg+98mYg94QSL7vFJRBwP9kbRQsmyDhrtbNfVjYA37qMKG9NjY2OB4XUq8IAVFzOfv/Z8J9k+YxuQynbrxJ3FMPyx0w1H8jZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0689.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 01:56:41 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.031; Wed, 27 Mar 2024 01:56:41 +0000
From: ChunHau Tan <chunhau.tan@starfivetech.com>
To: Rob Herring <robh@kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Emil Renner Berthing <kernel@esmil.dk>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Simon Horman <horms@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Andrew Halaney
	<ahalaney@redhat.com>, Jisheng Zhang <jszhang@kernel.org>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Russell
 King <rmk+kernel@armlinux.org.uk>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>, JeeHeng Sia <jeeheng.sia@starfivetech.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v4 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add
 StarFive JH8100 support
Thread-Topic: [PATCH v4 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add
 StarFive JH8100 support
Thread-Index: AQHafz4Bhb1ilZVhQ0OXi/9lqLBM17FKjEQAgABI9XA=
Date: Wed, 27 Mar 2024 01:56:41 +0000
Message-ID:
 <BJSPR01MB0595B79139C8B428C7563A139E34A@BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn>
References: <20240326052505.197408-1-chunhau.tan@starfivetech.com>
 <20240326052505.197408-2-chunhau.tan@starfivetech.com>
 <20240326213426.GA3667606-robh@kernel.org>
In-Reply-To: <20240326213426.GA3667606-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0595:EE_|BJSPR01MB0689:EE_
x-ms-office365-filtering-correlation-id: 44908b28-0c83-48bb-8522-08dc4e0125df
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ntyf5My5U8kYjdIcpu1T9lGGScIOVC1oBZtbi7GkjCpavJhEjCK5OZxrCFP1DVdGJ37n85jJorTy0Xd2I02sSGeUNj2DjihdizZryfR/PrYSeo6I+rEPEfk4oPgLLrocJ2NuhKkqh9Qmu580cjj+/rmVFh3a91Ha/iSKI12wYso++L8fAUD/7NUPxE75n2FCFquIpH1EAYO5xPMPBpNTtE6sGjTL7cQ/D0MTmUEsnNkExutjgg4UVKnkWwlu6YCc1Cttcg/WV5MlnqNWArJl8o/iC7GLuQKFprrU8IkO8ZwxQSg4l+90LPQrMhuKsqxjVGJPye/koEFFEF1W25glP8ijXFDdZ24jV1b1cn/LB0UDkGS+iUPkKd075mG7SdEtJCQ721tCQ6ZYv98Zzxq12fUhA8Jdh/WWkL6bXuUiOFjRWxGBebqfPQK8LMfRbQouUXS0h6qEXk7OfS0cYmPdpDRfeYqzvwTm7v5v43qFl+eXr5Bjt65Se6aNrqHN3eVIGW9ISXqsqqxVyVqqDJsC+exTmSmkgsQf4muyaKz0/RNh5bLXVEt+FJjKhO/VyTq5cAtVjniZLQ/hIa5gK4P66kqWnQ9riQumac/NguTiaOzvdNjRHng5eWCOtHaydORu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KkTaKwNZVJw6hhs/hYkKWD8k3dtXkwtiG9MZQvSbF3hUm08bY6L3Uyasht?=
 =?iso-8859-1?Q?DJcAywkELEeKlU140vms0tNdrSXzjSXzooig6cO1dnb7N2sIAmVGLuy8Dp?=
 =?iso-8859-1?Q?+ox2aS9/XAol2eQgvzJtl5pUmIKr0O3jWAgMal5vMXoPC5nmfpqMtiR4yN?=
 =?iso-8859-1?Q?in/prOlQiQVgwZwrfb3xbtewmZWG9JypErYdlK/s8WMj9JqOH5SyHyQMfs?=
 =?iso-8859-1?Q?9A8qcKd+LaG6ZmiAB380xXq0HzWj7RwXFYiMESFZfcdlSZ+vOjDI5nq0OB?=
 =?iso-8859-1?Q?tZRT6Zp24DsBz7Bi4MKds5poSWYEgPeRIduC4LXeBST6ibxhIFQwZxWwfL?=
 =?iso-8859-1?Q?Ti56toXT/2beddk+UcOcL4C5d6TxEZ76gqNkm1vcLxvgTMlHBpv1snLI/B?=
 =?iso-8859-1?Q?pKzkigt7XociLhMi+Z7RFIyB0oq4dxjVE1HkrOpQVd0ZjxBtR3u0eDqlFA?=
 =?iso-8859-1?Q?kTaoDn8osEHk69WqLaes0M5BcDj3FjGfj/mWw7ftgwB+Penv9hpX+E6LZQ?=
 =?iso-8859-1?Q?2+aw82NUuPew2nsJnVHjkXugXuKeMgEPIEBHtUicihW0YTul/F2w4KSnmf?=
 =?iso-8859-1?Q?pE5oLPCfYNhs5JW8rWD5vnisoubVIrIQ6hu8Ob4DwXfpJ/U9FQqzb8NMsy?=
 =?iso-8859-1?Q?jDaeqbn0F8YgBIHr/8/kJUR0ULpWl1S2u8oaQq3p4pWEXio8K9BBwK1z3E?=
 =?iso-8859-1?Q?3lTak5gC0DeZCgoYk9P59LVPebYtgaYDEX3o7364qTkW6Aff3BjnkQJrvr?=
 =?iso-8859-1?Q?IDzD8sEFZHk2uT2Z0szErNTdPFSUQcMG4wGETUOfq3SOUPXgcXoFHAGNSt?=
 =?iso-8859-1?Q?1JwDiAgZ9L+KES3xPdqm8nnt3vl4/m7vGi/8zXouIg9fqXw9DLJveL3V7q?=
 =?iso-8859-1?Q?ikh7FwpVKdFmDECrUs4N5bPREktc/uhgZt7DMwMS00aKxYnF5ibcJAdrU/?=
 =?iso-8859-1?Q?ibMPi330LLcQEEKgPemidOcRFWG6EMxl0N1r1OeJm9Q50d39wZZZ9BwJQS?=
 =?iso-8859-1?Q?D+ItOiaCv2wbOvvK+xKE044rkY6I05A2iGFsSAqeKxMC3x4r8Svvm9XCTR?=
 =?iso-8859-1?Q?mbGlnB56Ql8uo+UaiX4C5DCj1enj77DdFiNq6IIJkWNN3fjybotsMS6E+p?=
 =?iso-8859-1?Q?SaYmivzEhbA8F24JzrVABXnnRxAOdkPE5x0brxfBWGD8mh6Sjix4gsxbKL?=
 =?iso-8859-1?Q?EVP/CodAooGa5QV/rW3zyWQvox1OHmEtn8FXSQ/Dumlg/UzPaJSZwLp/kr?=
 =?iso-8859-1?Q?TLX8GnGyjMQQJ2xCPIGCTxhydoJlzhwufrkHGUSpypa3+lvUarfIV/YrDM?=
 =?iso-8859-1?Q?TQ9HBlX+OqywKJ/P/jGU2wxx7QuqbnF21xuCLZnovGrdNFkrzw8bTAIJwF?=
 =?iso-8859-1?Q?hARgiXcvTVaX9OzoDfymSGjCUI1Z9I+GBO3ckHh/v3PcvHnVlFvUwtx118?=
 =?iso-8859-1?Q?SpuhTrrEoRT/la5O4x1ginL+YVFd5aSNlvqzN7scBNBSMFdGynZAlZxDAM?=
 =?iso-8859-1?Q?KmkRCSSDCSnl4Dl29pDm1T71hJokGHv7HPLjeoL/6hdTNN4cK7iHXQNgsA?=
 =?iso-8859-1?Q?1Oc4ih4gGPxHRzDNlycEqbDJuSdvk/6aZVDskUVRb1IJbkT8L5CpGtTOIC?=
 =?iso-8859-1?Q?9afy05MGrbLNHyVJaSR/JOCvmiPHo5wZaOfP5Ktl+fcWgF0P/OOtO5Gb8Z?=
 =?iso-8859-1?Q?JtFNslxExDv69Dc0PBexTihp/EPlZoL/87LjagweOT6qG6ZUAzSoN6VV2k?=
 =?iso-8859-1?Q?4Png=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 44908b28-0c83-48bb-8522-08dc4e0125df
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 01:56:41.7000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bInHg7D5dH6flo2cvuaELtz/eIlW20qKrikihleDeHa2ptM6xfDH51amS/SApqRt4dqM4S9xOsOoPUZNyYn5SasTLZIp1kQQCTdcHneeD6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0689



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, 27 March, 2024 5:34 AM
> To: ChunHau Tan <chunhau.tan@starfivetech.com>
> Cc: David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Emil Renner Berthing <kernel@esmil.dk>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
> Alexandre Torgue <alexandre.torgue@foss.st.com>; Simon Horman
> <horms@kernel.org>; Bartosz Golaszewski <bartosz.golaszewski@linaro.org>;
> Andrew Halaney <ahalaney@redhat.com>; Jisheng Zhang <jszhang@kernel.org>;
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>; Russell King
> <rmk+kernel@armlinux.org.uk>; Leyfoon Tan <leyfoon.tan@starfivetech.com>;
> JeeHeng Sia <jeeheng.sia@starfivetech.com>; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-stm32@st-md-mailman.stormreply.com;
> linux-arm-kernel@lists.infradead.org; linux-riscv@lists.infradead.org
> Subject: Re: [PATCH v4 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add
> StarFive JH8100 support
>=20
> On Mon, Mar 25, 2024 at 10:25:05PM -0700, Tan Chun Hau wrote:
> > Add StarFive JH8100 dwmac support.
> > The JH8100 dwmac shares the same driver code as the JH7110 dwmac and
> > has only one reset signal.
> >
> > Please refer to below:
> >
> >   JH8100: reset-names =3D "stmmaceth";
> >   JH7110: reset-names =3D "stmmaceth", "ahb";
> >   JH7100: reset-names =3D "ahb";
> >
> > Example usage of JH8100 in the device tree:
> >
> > gmac0: ethernet@16030000 {
> >         compatible =3D "starfive,jh8100-dwmac",
> >                      "starfive,jh7110-dwmac",
> >                      "snps,dwmac-5.20";
> >         ...
> > };
> >
> > Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
> > ---
> >  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
> >  .../bindings/net/starfive,jh7110-dwmac.yaml   | 54 ++++++++++++++-----
> >  2 files changed, 41 insertions(+), 14 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > index 6b0341a8e0ea..a6d596b7dcf4 100644
> > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > @@ -97,6 +97,7 @@ properties:
> >          - snps,dwxgmac-2.10
> >          - starfive,jh7100-dwmac
> >          - starfive,jh7110-dwmac
> > +        - starfive,jh8100-dwmac
> >
> >    reg:
> >      minItems: 1
> > diff --git
> > a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > index 0d1962980f57..ce018e9768d2 100644
> > --- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > @@ -18,6 +18,7 @@ select:
> >          enum:
> >            - starfive,jh7100-dwmac
> >            - starfive,jh7110-dwmac
> > +          - starfive,jh8100-dwmac
> >    required:
> >      - compatible
> >
> > @@ -30,6 +31,10 @@ properties:
> >        - items:
> >            - const: starfive,jh7110-dwmac
> >            - const: snps,dwmac-5.20
> > +      - items:
> > +          - const: starfive,jh8100-dwmac
> > +          - const: starfive,jh7110-dwmac
> > +          - const: snps,dwmac-5.20
> >
> >    reg:
> >      maxItems: 1
> > @@ -107,20 +112,41 @@ allOf:
> >            contains:
> >              const: starfive,jh7110-dwmac
> >      then:
> > -      properties:
> > -        interrupts:
> > -          minItems: 3
> > -          maxItems: 3
> > -
> > -        interrupt-names:
> > -          minItems: 3
> > -          maxItems: 3
>=20
> interrupts and interrupt-names are the same, so you can leave them here i=
nstead
> of duplicating them as you have.

Okay, thank you for the feedback.
>=20
> > -
> > -        resets:
> > -          minItems: 2
> > -
> > -        reset-names:
> > -          minItems: 2
> > +      if:
> > +        properties:
> > +          compatible:
> > +            contains:
> > +              const: starfive,jh8100-dwmac
> > +      then:
> > +        properties:
> > +          interrupts:
> > +            minItems: 3
> > +            maxItems: 3
> > +
> > +          interrupt-names:
> > +            minItems: 3
> > +            maxItems: 3
> > +
> > +          resets:
> > +            maxItems: 1
> > +
> > +          reset-names:
> > +            const: stmmaceth
> > +      else:
> > +        properties:
> > +          interrupts:
> > +            minItems: 3
> > +            maxItems: 3
> > +
> > +          interrupt-names:
> > +            minItems: 3
> > +            maxItems: 3
> > +
> > +          resets:
> > +            minItems: 2
> > +
> > +          reset-names:
> > +            minItems: 2
> >
> >  unevaluatedProperties: false
> >
> > --
> > 2.25.1
> >

