Return-Path: <linux-kernel+bounces-47757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0280845269
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB0F2931D3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2012415B0E9;
	Thu,  1 Feb 2024 08:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="st/PS34M"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2058.outbound.protection.outlook.com [40.107.13.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3A915AADF;
	Thu,  1 Feb 2024 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774877; cv=fail; b=YJPQaJxUGgcI2X3rSHanX46+GDZmPtjBtDzLQqoEqcJZBJ1jJJEei/3fOGwFk9uYaGFNTUW2vRXnLdgJVvMvVP7eLodILVMY9kphuuZF1oVng/h3O3xt+oaxbbiCoafT00JjBLC8VcLnZUyYI72gefRYBbPl+tbcSHVie5dM8VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774877; c=relaxed/simple;
	bh=ZRyTPWlVwo7mPBSPWx/RNJX4YLAeho0YclTfa8v5EOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nkmp/thYTsm3vxjJqf39J2k3OZMP7GUEfHH1jx4vhtjINy2/Gc6/lxkvk0JaoIKsxsJmPBXx2k1Bd54X4LCGdYkXOq8nT6lOKo47u/tu3Y2Ub/r+px/wa2h8hcI0jjgJcUfN93+IiZc7ONT+uH0PpEydDoJLI7xWSot/Je9zpY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=st/PS34M; arc=fail smtp.client-ip=40.107.13.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJdS30rc6Ngodb56e04NgYTlE71+sNf2GR07hNy2etNUQ7lWUdOcQfqnMRrSKoUq+TXqtCuTnrTfnPwSOaHe7T+a1RSOLedXwmYrKvI+UHsMHzdggoa7lTbruvv6kajP9JaeHueIm70sUW2EzbB0NXIXoAmU/NlLlwiWvyBsX+ugqoT7PJZPfv3uJ6xWnaiLOs0B4RPiKeVRMbxX6LHL/lkv6dlHd/UknG56LP6f1SyNh+9M0cA08v6CMeb+7HSNrf6AFFAGD5M5Ueq/BCjMDH4C4ot9XPhVAgfVOHJ3EZ/6SqOcketun5XNTqJsidju3U3eQOAZXYlzkXrmdF6Fmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRyTPWlVwo7mPBSPWx/RNJX4YLAeho0YclTfa8v5EOY=;
 b=BBAYlQvXclwN7wbiWGoT8bLt1lDj3aKkX1C4a919WZYtougqe0qIWItKULJHg/EZKyF0dUyH+l4Lvs5LUwnGB8tOidiv0nQ6qLFNVkVkqj4kD1dUzEgwwNwlRm7I020nqIuTqFNQUQErQnROcHpK13cUdfvUkqzRCdPAJfLpp5jIvevMrlUF9ENLikl40P256Ev8AWj0Y7IiOuQ+3qngwjN3XdeRd/kRuzI2zy5yyh/xLMKt3YlmVBIVgr2NR/qcn2hchM8jSKzf5e33G4Wt2oxcLmYgQ/iunCAEzFlZeOPzunR4Da7Sitr92dU3khGMR0lTUVo88nGMtZuqRvfWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRyTPWlVwo7mPBSPWx/RNJX4YLAeho0YclTfa8v5EOY=;
 b=st/PS34Ml19aoBL47ANiHcPYOc4sh5ko1WsGWD3rU9UYz5FG9Xfwjsa+tyHqQOF8rL57NnyL7/VNX21ja/fdxm6Kik2Ftyids9XQO4z5HwjNhq0w8UQ0I5sRcMfg0z4T1mEx4OigkSnzYGMHujRwMemW6kzgB9xld4YiRPuOKxw=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.27; Thu, 1 Feb
 2024 08:07:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 08:07:51 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, "cristian.marussi@arm.com" <cristian.marussi@arm.com>
CC: Cristian Marussi <cristian.marussi@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Linus Walleij
	<linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHaTFMXfSW/KLMkFECgD1P261LWWrDwxwIAgABBWYCABBu3YA==
Date: Thu, 1 Feb 2024 08:07:51 +0000
Message-ID:
 <DU0PR04MB94178FAC347A4500E9449ECB88432@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
 <f88d07ef-83b2-4d14-976a-6dbbd71e036f@oss.nxp.com>
 <20240129163043.if5jj4kyacqfe2n5@bogus>
In-Reply-To: <20240129163043.if5jj4kyacqfe2n5@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB8461:EE_
x-ms-office365-filtering-correlation-id: 26cf52ae-a158-4536-f17e-08dc22fce2cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OChOf3wnOAhEHYaYvaEgUoT0tTnMz39vbZSoBL8LPAbGube4pT8NC2bH5+bEhhTAjtZySgkFpyKdY/MaV14YFhVydnjTYzNEh2hUxWZyAOjmn8uOTJEbbGB9vRyB9z0e45O6xEgKEl70YvJ4td0N+bXnsryy3tmOKL5BJzuupxKA0DI45LoxpYj/FbDab/pNOSB1719q3aQ6TWiM2BgisTL1sXMju1ksAgzkKNdGwaK6cL2zE9JTmbzm7tqHIX3nPeGUH5CohZv2YP1fiHM93jjUHvuSz4DcavoH1RAvG4RBHXJdVSxZ99ULaTdzpKucncyu8GNECsStUxoeny87zhFGzeetVFi9DYi3ij6LRk1zSxwpL9vIicx+nyPNH7X6NosfUvP2tjdeVoNf4AAV86eLbhXnAHg+yH2ASfAm5LG02Cxy6C40XM5GBNr09MZAcE3cwIUTsr+RsVOTFiSWLHLGeM65h+SynYyrvLqYVY0b/SiBvxhfF+aSeKy0PLypvYq5ulXsFtM/lifF9EIQhfynobTgGKzDHUFxkt8o3SA+yBzaYpVLRpi9GGJYlFrBaCjZyubbwtKuiDfJPP3/3VPPDNJJgfoCVKOb+hNgAA2VhQ3oyP1BdnTlhJJfrPJW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(64756008)(110136005)(76116006)(66946007)(55016003)(2906002)(54906003)(7416002)(5660300002)(44832011)(316002)(52536014)(66556008)(66446008)(66476007)(4326008)(8676002)(8936002)(478600001)(41300700001)(38100700002)(33656002)(86362001)(26005)(71200400001)(9686003)(122000001)(38070700009)(6506007)(7696005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MKknItNHlYCSCydzCjFJJfezivWHPzLmHN3ElrL+l9LGa23jrmRBMYCSgDw3?=
 =?us-ascii?Q?OqjZIlILToYTS0vLLyxP+N7NSrtq6WApGYi7Nq/Zek4JXH8ynpDuuT3OO3bt?=
 =?us-ascii?Q?ufRbZfJJ0VT6A5h+p6eF/32ttKPtRpxVDRIaCEKC6PjmAJLteloxPOIZ/goH?=
 =?us-ascii?Q?JIWoRIVOjD71VRykHwWHeieO+HVLGtApH+OT5cHIofSoNLuSO/iFyRx3MSsR?=
 =?us-ascii?Q?d7fcDtAcR4TC38JcJ7eFJD8IkzcHdvLqw8Xz3jHJjNkW3/IhevrGCHJK5ZM4?=
 =?us-ascii?Q?kfXvh7/+srs/P9tOiF8trOoQLU/nAEK11SWOSpSSnwNocx6tZQDHsZqdWNxR?=
 =?us-ascii?Q?DY5jPkKExWi915kMB9KF7nPXQhVcPhzBG7SDgwPWX2o98Yv9YnApRutmIIaL?=
 =?us-ascii?Q?MBVO6Vc51J/d5QArtBFQSilWvsCZ8jRcpLWMHrt2bWgyE9fJvWC6KI/2bQXX?=
 =?us-ascii?Q?AEAdTGS06zWPki4R0bwYYiAXTGZBFwPkDz+Fgdw70HT3svvPx36Qdg+f9DgQ?=
 =?us-ascii?Q?r45o5Lgevb2IGWKxVRqbyfIQ4GNuBw7XuKHysY0C5rqtcQNZA93tKJc0DvMz?=
 =?us-ascii?Q?JYtiLdOtNlFs94mQbIQdf122Cnv91oSDj4mLWDmsbOIy4An9HuHaNLyIOSZO?=
 =?us-ascii?Q?QxlqUiDOq1CvKn+kg1/YpbHlLhctJM3CBMmHnFw1DttX8RU0SEp+Pl98Dp+O?=
 =?us-ascii?Q?LFayiJG2lrbmFbqoLg7O361jv7VjEHu7jpcSBENie3s6dS0K/EkrbVPb1uYv?=
 =?us-ascii?Q?sDRrYiV3ag1MCuLKRubpwdsiskcla33ZEg9UPloVsygzVppogNTZ2VBxnjN1?=
 =?us-ascii?Q?CRskFl7LIfzTNEYS2PUu/SmJbArCdkBneldfl8T78zYQcC/xGVyLY9u8xC2r?=
 =?us-ascii?Q?+lpwAKWg1dCAYYuNQircd9yihz2kQJNCqQN3z909gQ4auDv6scPMwxtlmWEN?=
 =?us-ascii?Q?YUJkayiT5FAI4UVvxzg4uOOlK/MQQRLWYTso0H0UE3bu1UPkJB0hJN5LfF0X?=
 =?us-ascii?Q?LXU8rqSBiMyeDb/9j7+OGk+7Vs9sMKhvrMXYIzBmX11+spocQWK1TEtAhMsj?=
 =?us-ascii?Q?lElkNihz9OMuLytRBREZM8p8/AesOHAIcbIavDQAkTx54M+LmRCrArFH+Y7t?=
 =?us-ascii?Q?4ii+5if/AeGYqrOpNk1ryzdUcOLPcD6xu5iHQG0+H1XmZMgTDljipE+CrGkT?=
 =?us-ascii?Q?PSBDilL+YY7X7xMfrkZNIeCdQ87fWm3qafGVkY8kaZMZy8G8g3AwR+f9HLNY?=
 =?us-ascii?Q?a4QYA9xg/YAqHxc1mBTJBUAdxHFJ5r39o2wNF+8ZZUQNSjrhJ52yHlGpRa2e?=
 =?us-ascii?Q?3wDUfljj+8jnPgAC+ue8oSqwRPF7/P/RH54jWRzm9smCCQWUPjqD8G9qTRuQ?=
 =?us-ascii?Q?f/m9wBv0HtW+IzdL7dAxmYdEasgyCVS0r7iqp1N2Eg0njIQdZ4AOrKpeWvN9?=
 =?us-ascii?Q?PbPt4+ibblPl2oukx8Om2GAILBt9K5D8tTz8ehyIfwXd1u8WI7Z8AINedb4B?=
 =?us-ascii?Q?ewdBEZLq4kt0fpj+dFpU+fOKV8gz8kH/fV5uOOB1nOfcRaKyP7GYgkWW2ZJC?=
 =?us-ascii?Q?7huvKqrCrhnEUswXGUQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cf52ae-a158-4536-f17e-08dc22fce2cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 08:07:51.2057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IGbpZZGl2qZtLHpi8yAWo6TMZZThKI0oBuXL3ctu2mvhM7sAmAIeaUgsILAeMmZj/ea/qip60hXTXconoYWWAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8461

> Subject: Re: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
> protocol basic support
>=20
> On Mon, Jan 29, 2024 at 08:36:50PM +0800, Peng Fan wrote:
> > Hi Sudeep, Cristian
> >
> > Would you pick up patch 1-4?
>=20
> I will for v6.9 sometime.
>=20
> > And for i.MX95 OEM extenstion, do you have any suggestions?
> > I have two points:
> > 1. use vendor compatible. This would also benefit when supporting
> > vendor protocol.
>=20
> May be, but that was never on plate for standard protocols. So I don't li=
ke
> that approach either.
>=20
> > 2. Introduce a property saying supporting-generic-pinconf
> >
>=20
> I am not sure what you mean by that. But that doesn't sound right especia=
l in
> context of SCMI. So I would say no.
>=20
> > How do you think?
> >
>=20
> I don't have any other suggestions than fix your driver to use the pinmux
> properly with features in the upstream pinmux subsystem.

So for OEM specific units in Pin Configuration Type and Enumerations,
Any ideas how to support them if not talking about i.MX?

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep

