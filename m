Return-Path: <linux-kernel+bounces-34806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4608387B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9C61F24516
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC851C3F;
	Tue, 23 Jan 2024 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H0Vb5mTz"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9EA362;
	Tue, 23 Jan 2024 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705993232; cv=fail; b=mNTeoJmMqS3THIf6y9eC8p8OFabppZE9HNASWNol6MNmEavn9N8zl4uh6AR8EvajCZ1r3PlaMLwkdWjmXq1w+WHOogUPAN3/d/gC+omXnzEUKv4Cvl5sYKR0PczBoicn6P8k1aJApZZEnpgMiAu5loc5KROv/zNpXgcxLDO0zYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705993232; c=relaxed/simple;
	bh=pjDLIC2uSW2/mg3cFIINp5jumP8KBnn/hnpA5bywKDQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aPIR14K3C0j8N2xfye5gON/0sJJC8R9GU4UunjIW12ae2m+bl5O9LnTMT/BG6O0QamffnxDOOY9KC8FxzJkWUNseAgJLq8Hwf+xSEKPEVdn9Di2CU5tuaCOVkM4nMZnLKKeb6mcEOmPlZ5Q3M8KYQ3vOh/J1Kaz1X/a3u4L/Vh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H0Vb5mTz; arc=fail smtp.client-ip=40.107.22.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UL+1SNcwLmjw1yX/6bvlMtBPXjrVc7hj99Lcgn9Ce6069T1SmJG1999mcgWaUkLai8v2b6MoL51bQa7r1lZJRCPHrzL/Fm6GCKFrb09YvFKTGoDkl3GbpO2QMh3Rj0CQ6HlqVOPYPRYldlENr1yForpZMSwGA33/Va5SaW//nHt2znaU69nZkfCnr2500QqmIQIJ7kYT7odUSbl8nfMIRPg1OOqSj70qIYjS1vVx7ma26l3qHDFF//bRDPnIc9lU6io/BJMOIn8N8sXCpj+MWgLp2J0/s5/GIynSMePG3UU2nZM4FE/ZAZO970iIYdX6DRa+khGMPBcRMB3XdSAyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjDLIC2uSW2/mg3cFIINp5jumP8KBnn/hnpA5bywKDQ=;
 b=VkhW36DG8+vmEYFjpuvG0bAWiivCKA/IB4jbINmBMjkh+ciiKzA8gcFsQXJMaezg43XTXCtUETEkhCkEoXGRhrWARU26cXmUVicC8kKR94GLeReWwa6FZ0sfEOwXcaJvXbpf5MrBsvWgpgOkulzLDHAPaZMgH6xsWsgVrCxTt/Cx2NMXF//gR7+8yS0X7ZT7cXC27F8e1DqNB/fMz8YnFnIOBGwpSVa19zLhB6AInlQHg43OLNv2oa4ypJGYE3+EiqGqob0YP8/+ZeblHqItuwxve1T8TI2wLJQ3K6Qh7PTeVzRA7s0+LwbkSqNijCMOo2A6vuiPwFEZYOE6q4xXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjDLIC2uSW2/mg3cFIINp5jumP8KBnn/hnpA5bywKDQ=;
 b=H0Vb5mTzglfSU+32Hg3IWE/54ilfYozrkuTGQeKGzBMUBFJhNWm4x4eU9fdkiNRE9XTYeS+topm4BYFeU8PafnBKB76W11YgueqYDGUMT4EXeyP9GdCwg/1emDjdX0PLjSGngt9s+6CogR2GxEOxaYsQ9Z4WLPpabAl173/UiHQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8713.eurprd04.prod.outlook.com (2603:10a6:20b:43c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 07:00:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 07:00:28 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "wg@grandegger.com"
	<wg@grandegger.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95 compatible
 string
Thread-Topic: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95 compatible
 string
Thread-Index: AQHaTRM/wbiiEv9ixEO2u0SZ0nixIrDloMCAgACwDYCAAKhyIA==
Date: Tue, 23 Jan 2024 07:00:27 +0000
Message-ID:
 <DU0PR04MB941750744E86A1656009B7BE88742@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240122091738.2078746-1-peng.fan@oss.nxp.com>
	<20240122-skilled-wimp-4bc1769bf235-mkl@pengutronix.de>
 <20240122125631.4c54eba1@kernel.org>
In-Reply-To: <20240122125631.4c54eba1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8713:EE_
x-ms-office365-filtering-correlation-id: 441dc93b-f6b6-4eb7-eb5e-08dc1be0fb1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 scZdciPPzkj4iZif8lCp5fGmweYDp+kkbYhJJMQQTXG9BLNXG6QLYW8Q1Bnmz/7PwqCgc7j9lFhblgHDGzIydD/w1siaZFndRpSS1mar1/XNSbhpRCxxxk0DOnEqd4QrIwIZfSkCpF/zV8sqqYdQIhffN2zBDhNVNw7ufowLVvkjCLlDkE9M2RaStZ56nWI2DwfzrFft8iJvyyz6ftWLm6zHEzbfR6uchRvP67+jOyZBS2nBdbKTpaJjREV7zhPsUN8ESUOrVojD436Uue3xhz0nwAPB7K99k3E13zUN+q1gFCdOujDLvtzOVYh/SimAKS79OVpR7D5VEBXeW/qNIa21G+KjQ+p/X2zBJsQPtLNYQs6F+gLyGXgym/RMX9iGaO/1e8qVj77OiHp/qp6+tBa+GuqafVGRzDfakkH/wgPTYf8daJ7l8YrOQxxM1nhnPGbx+wpubXi0WlPiFQpnTXSJmqppb5jFLGOhzReBWRSrV38UBGGKOlywqCmSshocbiCyRsyGkve6y+7OBAk5eQG35RrI6jlS68VJKIHygAViR5D+8/KfgNkQaI34ljUgqBl8rq0kawNe4yaJT0ZwjzZXsIyqKij3GdcscpMB1R30/9aw6ofk6cLFZCu1LPgy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38070700009)(55016003)(8676002)(4326008)(9686003)(44832011)(8936002)(5660300002)(316002)(71200400001)(76116006)(110136005)(7696005)(66476007)(6506007)(64756008)(66946007)(54906003)(66556008)(66446008)(478600001)(26005)(52536014)(122000001)(38100700002)(4744005)(2906002)(7416002)(86362001)(41300700001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cM3UDx6eTpFA0zMpI2lBejiSbPUpC57E7kQnFltSyWlJ/JP5F2q81EUAV+6+?=
 =?us-ascii?Q?wJuLldOQFuqZCecSxHqenVLu1otqFnquB6zzGFJ8u2G5gDtD5JWOV4GAe421?=
 =?us-ascii?Q?u48z4tIr3WHfINSvIFLIl0TgUXysx9kdnFKuKuEJ58WPHZRnLuQKL7s0SP9N?=
 =?us-ascii?Q?vQuJTjVrWUJW2mldW21mux6rKYshCXqyNwepUMwEJmry+0hRUUiuJUsLHSVq?=
 =?us-ascii?Q?oS/K67tCAVI3K/Qi7S7wCFpv1J1LtVxvfJL+j5/L2bv4mIH+e6pQFiTB30JF?=
 =?us-ascii?Q?bSbg9fjeYkSUNFOMjzxdgj27m7zK5E1J+H0RA+HouLBp6Q4TvtxEvLbrhWoq?=
 =?us-ascii?Q?1Gexyo9Q72Ao5xBAf2PVHG3txL2I/M100zZDyn4SDK3OoWxBiytPgRUmKypO?=
 =?us-ascii?Q?DnuaotcaNZdJDtMm+3rBjFjENNc9xVBYy/AHA9SuesVjMeHv9JadqoRTYHx5?=
 =?us-ascii?Q?3RhDmhxN2AdHgNpf2RfBp1dp968zUVnYCNK314YQVyYCM0PGaNuNy2HVrB01?=
 =?us-ascii?Q?mnIxooZcnqbctaDp+IpSXU5MY0WoWJvEwGv1BnEEX6eF/3K9gHl7ganJeqHH?=
 =?us-ascii?Q?u4h+Rsm1DsOV4i2Zb0W2HYXmYvflnF9O3YZJlClSMRLQ0ddZbch1bWJ38jBk?=
 =?us-ascii?Q?xLeoxNWxRXlBS0Pwb6cxtzJEbZnudsd1IgS4HLHh1TO7f2ya9azxSI1bceT/?=
 =?us-ascii?Q?h3uOMyGq6OBKnKPGQj0BGEiRYO1jn3d+2knkJAXzFbh+qBRmjBYF70IAJ0nE?=
 =?us-ascii?Q?WpJfLGHHCOvo8VTVY07SbpE3KjOnL5ZwOLJURSqs5tGcMjHKhpC7+Cd4gGnt?=
 =?us-ascii?Q?SX1LvXPwOIawn0He797++WMyTRbt1xLxZewNvoTC8rM7oVolBz87k8/OdJ7s?=
 =?us-ascii?Q?mLdsc6S0eotPvcukZhSBCgjdx3SjLl07VisEeN3j5c8ovgdw/jJYqokJDAY+?=
 =?us-ascii?Q?q0mibU1mHmYCIi/jKsv5AS70YjujOVHVvwDmGiz1NjnLUcLuFcjB/pnIgFSw?=
 =?us-ascii?Q?l5vG9VJC4jt5aznLw7L94t72taJMU8KvzAqc+dpLOvC7AkgFUwjpkJ1s/DZB?=
 =?us-ascii?Q?GpwavQ94nfqJdDAl9MmycnzOqINayUkO6RzxPMRQe1DIydlQDOs2roCcoq+L?=
 =?us-ascii?Q?PHhHRpPeO7Yrr9DOOoR7UpWbIHWKBLAZXz6Geln1xbl6bBwBFsUIPqJUnNlD?=
 =?us-ascii?Q?wJU9xYzhzYnKXvpa8jzT7K3swasjjZjidNp3OAyyXeELxW0B2yntfK0bHkmy?=
 =?us-ascii?Q?trWcd7pkh7RYd1FKOM6nObFUNVEGrI7EacZNCRZeTU1tl2nF4gAJ0xv11ekO?=
 =?us-ascii?Q?CdNUDp8oC6xAZfAafZd7p2kwct5QS0QiuqA5sNndvsGQNBnL2I8EIrkncTSq?=
 =?us-ascii?Q?EJ9FiuAvJIGmi8eK6DjN1Enhw7JLATYZSiQKYzIeF0c7WfnAcFTLT/TrAr3y?=
 =?us-ascii?Q?7rJmAgNbFAqBxXjZilliIstJqfWLjYG6Rx2KeWwyi4q2/qkHOHf/2oXD6s4T?=
 =?us-ascii?Q?nw0zPohj3hUMpHwJTO1xYqnOlsXQkdGhJ3/egrRJ6rXz1wuFdOKxcvgfwZcb?=
 =?us-ascii?Q?7XUw6q+be2hX7FTYgcE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 441dc93b-f6b6-4eb7-eb5e-08dc1be0fb1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 07:00:27.8935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBqiuQ6FnqBpSKpAFLhQBSmxuDNhx17QfLYQKffdsLiaql9VvMQpbYCAEIqwpZPTweiLgyu4UiR5tiSP4RzHmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8713

> Subject: Re: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95 compatible
> string
>=20
> On Mon, 22 Jan 2024 11:26:25 +0100 Marc Kleine-Budde wrote:
> > > Add i.MX95 flexcan which is compatible i.MX93 flexcan
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >
> > Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> Hm, you don't apply CAN DTB patches?

Nope. I am preparing dt-binding first, then post the i.MX95 SoC
dtsi. The CAN will be in the i.MX95 SOC dtsi file, not a
single patch only for CAN node.

Thanks,
Peng.

