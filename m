Return-Path: <linux-kernel+bounces-129555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72072896C84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95AAD1C26C20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F6F143870;
	Wed,  3 Apr 2024 10:31:05 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2137.outbound.protection.partner.outlook.cn [139.219.146.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC201428F9;
	Wed,  3 Apr 2024 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140265; cv=fail; b=j+BM81DMVfPXwV8VIpzUtFUeGEPEmq8e4E9u+V4bM+nqRkX62mcpmjGBanUNSx3rrFJrIzn2J38ae+oXAQKueRu6zMuBg/pyqGYzSXK94u4a1V6UfWIcuMr+nO3Bcc5MftexPrfHU5VQ61eRn7Wjtqif0wHNcc9LvzUk96j0n6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140265; c=relaxed/simple;
	bh=4GGYiaL/40Mv0a7K4QFeerFQFiJEAKSZ7gHAeR/HdZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eQYsFeCMbM+3tBMoCvHtqvSs2UFV9X4hodO8C0zmOUL9GiW8HgTs/XYsiVqkLGOsEWJeWVVX74eA4tjsswkXeCXbptWOnFoCgMFeigKBxCmfc83o9B/YclF4vlKYACCP1/jWLUjrSYCqxNtly0pUG0Yc+M3aRTgI53GwU4zjwXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWC2poT4m8NXmY2vCa85/aYdXZ9XSKZJY00odYa6eHa8JV+hsTofYoZEUZWPKyE9mcNUxhv/D8STwUveWzDqo7oKKqajXhj8YIdLz9k/q+9mpgBjNA5eT4tzHmIXQPpk9jds3+mz2x0ZcVj4pqGJyDZKfw4siNR7M1eO7CF3g5vfzonxfBQWDEgkiGxbSNKwEoIZxzeQLhKzyEzXviXdjqs5Ytf1Ic/iqvVKULkb4fIsHwdSsNLDqAoEpNJYYVb0o+RjfQCa3FJn6ff7kDrTr2i2uNNEmwKyROAdFkF7tWZ7hhWb3xCkuUCXJPim6+raZn2+2vfZf9KEvipytIKUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifgLHMBZOIsOrud7Jvo67XumXX5yby5YhTh8ciM/sLo=;
 b=F3sd41xR54rSfkebB6IIrT9HMmjwSQZD3n/xa25WcpQgS5TTbkHDomMTR1pH0GqWugvYRHC2C2CvTGW5rbspI41UWcPUJYyjA8IkKW/G1RR1reON0kUsqBco1eSG7a/KHvn23hAmiTdbUYPN/pHjavdYX00SLGln/xsyyjKyxwu9rcxSmmxtAJA4gqniEQJU+EcJAcP4wo7j3q5j2HidVeZIrm71HpnORzQmc7Ndyx+e/co+i9ew6byNX1kZOhXJ1x64WSM8dUOzlA7gXEU/zPKpjiNfZRgVgXbqrvyhTGTuUa8mcUb4bkh7djg44C4N8iadBoaYEZvw2WUBIug+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0739.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 09:56:39 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.042; Wed, 3 Apr 2024 09:56:39 +0000
From: ChunHau Tan <chunhau.tan@starfivetech.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
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
Subject: RE: [PATCH v5 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add
 StarFive JH8100 support
Thread-Topic: [PATCH v5 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add
 StarFive JH8100 support
Thread-Index: AQHaf+o3L6L178d32UuN78fdZx4qAbFLOCoAgAJoxwCACLlvoA==
Date: Wed, 3 Apr 2024 09:56:39 +0000
Message-ID:
 <BJSPR01MB059512332AE8549A340BDC5E9E3DA@BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn>
References: <20240327015750.226349-1-chunhau.tan@starfivetech.com>
 <20240327015750.226349-2-chunhau.tan@starfivetech.com>
 <31ac366d-bfa6-4c99-a04d-ab9fb029da7e@linaro.org>
 <20240328204202.GA308290-robh@kernel.org>
In-Reply-To: <20240328204202.GA308290-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0595:EE_|BJSPR01MB0739:EE_
x-ms-office365-filtering-correlation-id: 43068e5c-8ad8-4113-5403-08dc53c45b7e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1PY91uaClo1IO0Wolz3C3AJxG2pcnQEdzI2F9RsIg3KzMVUQ4s8sx2XuOA7dNTe8MDKsZiglRneOzYUz8/QC9orGNaokYGTa6nOMe02/MBqTSO0JGZzCpv5UPkzGkBUr8Rc0N1vcZXCWpM37XxuyHssQcB37tZ0dYEaT4LoFP4w4qk686p9WJCJ6YA0oyMzUU9RQlfvXy26sEu8JTcaPPgC1uKrELsu3W/YKMp39P84c+/bOdz46b8lr/XlEN3MylIwRw8mzENnN6hGPmpC8b1gVygft+urwEnXaPqlnflD9xFDssZOr/U1VZa/SbHE2qBXDfwL/IdmdNuwE/eD32k6Pr87ECiG2vnWCiExYmcFXL+MkXJ5Q8G014Vk8BSahQ2TwfVJzRKcPHaWJTQ2eIv3wWZ+FhiW0/Eg5och2eWaLbe0lrss1roxU74c33sN3VeNNADuRpo4bDGNrnO5j23NTW2SNpPIMHrFJzSorv4DFyFjrzx68oXM3DShyH/jq+ity/Xil1qYTBiK7vIgNZFEq3/peOR0UFhuITd/3S+HIITjasDJd7QlDXHoDvbEKWkRHkDAAiFN0yaRAfwfaKP2dWoHq6QBWpIJd8dN7NMhptRixBPDRZdAUcVdUezVQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?o7HvMFLISCjX0cqwUy57qhVTQbY6hRo8MoTc+ki9hWdW/9gQMwUcD3m2bu?=
 =?iso-8859-1?Q?rpdzmOoHwp7yLcbjzLFPs5OXAGG1lCEuOO3jTqwiw1N/HBO3QpIEkbCz7l?=
 =?iso-8859-1?Q?SpMUDqCUV0ZCmmzXGeAOFob/CHxpXfO6MaQHFlLpirRpaQ1P6l50gRlNKc?=
 =?iso-8859-1?Q?4Wuvq+cq7wnCh7Qlr5vncDo879dQxhKc78R7nTiCgW4BpeMMyBcJQGTZfH?=
 =?iso-8859-1?Q?/jpbuGFJT/I+g9ROSvpa1loQN4KHAOvdI7p58xtPG94s8qxO2pQsfdhFuD?=
 =?iso-8859-1?Q?o9i815+xzgWvfnR7XLDEJflCnosPjG7vrCt+OzpP1eJcxR4SVQX++5D7V3?=
 =?iso-8859-1?Q?6WfdPhxyYw9pYCpvVYOGymDKjSqOepeogl2EqgWlPPVv9D15WkMoBRvjc/?=
 =?iso-8859-1?Q?MajUDXob/IUKE+WJ0mrYtC1HNNQj4RFeMEOZYuU62VThUaZaX2ausamDy2?=
 =?iso-8859-1?Q?D3iT6owKz670tWZ5bnQL8GVWZ45Od3QOaLITxwacS8c+9qD5vUjWUYGtI4?=
 =?iso-8859-1?Q?eKk5x/7ZnQjQzAOLtCeWYAWgFnxAVtVulSp4BDrY+autH6SqNZqirG28xt?=
 =?iso-8859-1?Q?M1i8w70xYLYlq+OxfKqNv/IxOV+XRhFeGCRo9WthOD5BqcOtExtmQqA9ev?=
 =?iso-8859-1?Q?Ei1PVoyCk/d7FyO/2HfsopQzOqheQ8J3Gthx57hbLh9z5JzjpFeXOuPTbY?=
 =?iso-8859-1?Q?gh+u/ed/X0yJDLxs+HbB4/io4t0crMtJprj3ZD4ZC8WgVIYMTqmUS7u4R2?=
 =?iso-8859-1?Q?9C7pnnmmbOA2O1BqUEeGQChd85Q9So03znWB7fa7dHb6ZXE2kRiEt8/Tby?=
 =?iso-8859-1?Q?zYJ9948MFTtzffmc3vrGA+JzhtosWfN/DGTYURG6b+xV0FFgBStd8HdRT9?=
 =?iso-8859-1?Q?AQuf0dRTrHICpTIFkHS7IsuuiIGZmgrz4swyiTBm/W92ijLSEB+kcxDnIF?=
 =?iso-8859-1?Q?frA0I2bhCb3VUt2eJqSnRvlT/SX9ro4eG1s0VNxlLi7+HoOGy16B1/mJDz?=
 =?iso-8859-1?Q?MRA2DACxKo5dOk85HOX5/3kJCz6jPfXudmUa5HwoHOuXoJeUfpjvs52g4G?=
 =?iso-8859-1?Q?nmY55WoLLsWXWu69iM55w2yW9WDCaNy0b1oBTeaRoj57rNFlNUF7QZ5vFZ?=
 =?iso-8859-1?Q?u+822XrRic6hhI2rs8cAQ61fP/HukHEq3nuVCKcp5IVgoqlQ/Jj2VVq3JV?=
 =?iso-8859-1?Q?g+fbd70k5/txRp+AuiR3GXuU88/L1i9RUaCCuYxTnGOAIYE0VJWnPFLhXg?=
 =?iso-8859-1?Q?E/e5gYuKrSu4qwQ10hGaZ6VogyWwEFgElkIW5IfWC+6sM/NEzhdm46HJYN?=
 =?iso-8859-1?Q?GUwzLJtptJ/m6q1s8fbW349LwNe1KpsR6tRZJQGrfGGWh1d1GXPSNaXAiJ?=
 =?iso-8859-1?Q?PSxvYPwJYUP+drn5qtFyrY6T9gCgBaHc+6Tk0JI10RAnX5MldRbFhaZinQ?=
 =?iso-8859-1?Q?VInae9mExQU1e1ha6XbWVo/r4iDfbmwg0QznYHzGXtwvIEnL5rzKZ098EJ?=
 =?iso-8859-1?Q?VYf9P6t+64c1b+tNtSbbKjny+cKjL2wEaSkOTCPqfMK7ZoCcL0pBSXTJxk?=
 =?iso-8859-1?Q?XAUrsO5xp8PgGAZwiXFA5XbaxbpaSWQ748FdXUT3LG5U2OAd0qFgvm5Avh?=
 =?iso-8859-1?Q?4zQ0xGBZXFNtSjue2aBhxXEISv/vz5JRx+0nFSf39wQHwuMaZiZ0YStg?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 43068e5c-8ad8-4113-5403-08dc53c45b7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 09:56:39.2977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: grOUmTuN0O0TXQ5jyd81BcUd/YfuxqNR4uq8dQztyvzzYRHw21v65FwsRt3wwbkKqJBNXq4zRyozG1ayTUIxLhthqh+i7sgU2jCDDUoUQYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0739



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, 29 March, 2024 4:42 AM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: ChunHau Tan <chunhau.tan@starfivetech.com>; David S . Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Emil Renner
> Berthing <kernel@esmil.dk>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Maxime Coquelin <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Simon Horman <horms@kernel.org>; Bartosz
> Golaszewski <bartosz.golaszewski@linaro.org>; Andrew Halaney
> <ahalaney@redhat.com>; Jisheng Zhang <jszhang@kernel.org>; Uwe
> Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>; Russell King
> <rmk+kernel@armlinux.org.uk>; Leyfoon Tan <leyfoon.tan@starfivetech.com>;
> JeeHeng Sia <jeeheng.sia@starfivetech.com>; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-stm32@st-md-mailman.stormreply.com;
> linux-arm-kernel@lists.infradead.org; linux-riscv@lists.infradead.org
> Subject: Re: [PATCH v5 1/1] dt-bindings: net: starfive,jh7110-dwmac: Add
> StarFive JH8100 support
>=20
> On Wed, Mar 27, 2024 at 08:54:30AM +0100, Krzysztof Kozlowski wrote:
> > On 27/03/2024 02:57, Tan Chun Hau wrote:
> > > Add StarFive JH8100 dwmac support.
> > > The JH8100 dwmac shares the same driver code as the JH7110 dwmac and
> > > has only one reset signal.
> > >
> > > Please refer to below:
> > >
> > >   JH8100: reset-names =3D "stmmaceth";
> > >   JH7110: reset-names =3D "stmmaceth", "ahb";
> > >   JH7100: reset-names =3D "ahb";
> > >
> > > Example usage of JH8100 in the device tree:
> > >
> > > gmac0: ethernet@16030000 {
> > >         compatible =3D "starfive,jh8100-dwmac",
> > >                      "starfive,jh7110-dwmac",
> > >                      "snps,dwmac-5.20";
> > >         ...
> > > };
> > >
> > > Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
> > > ---
> > >  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
> > >  .../bindings/net/starfive,jh7110-dwmac.yaml   | 29 +++++++++++++++--=
--
> > >  2 files changed, 25 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > index 6b0341a8e0ea..a6d596b7dcf4 100644
> > > --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> > > @@ -97,6 +97,7 @@ properties:
> > >          - snps,dwxgmac-2.10
> > >          - starfive,jh7100-dwmac
> > >          - starfive,jh7110-dwmac
> > > +        - starfive,jh8100-dwmac
> >
> > I think that's not needed. You have there already your fallback.

Okay, I will remove it.

> >
> > >
> > >    reg:
> > >      minItems: 1
> > > diff --git
> > > a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > > b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > > index 0d1962980f57..5805a58c55d1 100644
> > > ---
> > > a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> > > +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.ya
> > > +++ ml
> > > @@ -18,6 +18,7 @@ select:
> > >          enum:
> > >            - starfive,jh7100-dwmac
> > >            - starfive,jh7110-dwmac
> > > +          - starfive,jh8100-dwmac
> >
> > Same here, even more obvious.
>=20
> Agreed.

Okay, I will remove it.
>=20
> >
> > >    required:
> > >      - compatible
> > >
> > > @@ -30,6 +31,10 @@ properties:
> > >        - items:
> > >            - const: starfive,jh7110-dwmac
> > >            - const: snps,dwmac-5.20
> > > +      - items:
> > > +          - const: starfive,jh8100-dwmac
> > > +          - const: starfive,jh7110-dwmac
> > > +          - const: snps,dwmac-5.20
> > >
> > >    reg:
> > >      maxItems: 1
> > > @@ -116,11 +121,25 @@ allOf:
> > >            minItems: 3
> > >            maxItems: 3
> > >
> > > -        resets:
> > > -          minItems: 2
> > > -
> > > -        reset-names:
> > > -          minItems: 2
> > > +      if:
> >
> > I would personally avoid nesting if within if. It gets unreadable.
> > Although Rob did not comment on this one, so I guess it is fine.
>=20
> I normally agree, but here I suggested it as it looked to be the simplest=
 option.
>=20
> With the 2 other comments addressed,
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

