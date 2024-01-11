Return-Path: <linux-kernel+bounces-22904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F5382A52F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9268D2840DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9BF363;
	Thu, 11 Jan 2024 00:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TshI3M6K"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E2EC8;
	Thu, 11 Jan 2024 00:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPKwW401XAAI6ITJ3iPXHHj86nm2vr85pPD+yCGn8yyt7hQ6OOMA4d88EznhoKvc6XwUpjfw9fyxvQlPEviewlgFEUFgwIZ4hkMyIlozChrZYjEe8jlxquDdUXtKe/9ZjlCjtYx0jlUTeTAiI/az7jroY6Hts+Yv8bCUM3ctCcaYnYSbGwzwLGuxYWWsFQyjVAY9CfcPZ5kwQQI392/JcVNf0XS+j0U0jBuaXd0d+HFy4fdqK7UcvALFxOKwngtKm60IXQNjXUWZsoPHZQXMpehWDl0a+848HBw4g2Ly98VvTwKYB1ll0hO+MXOK9omPG3oMeDIyvqzMZH5atCX+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkIVsFwXqFn2W0jYQp+i3guKuV/P2Eseu7yVNB0ztlw=;
 b=H0pWJISGg2e1JAY8fnIGXZsNml4p3Y5+CSPUc17P6kE1NhXWTkUFx/sehPAX5bFy7QBQ589lYQYR7vPtO6rHCphNO6wXJjB0FcTLm736l6xBf4thIolFzw9xw+w+VdCMS97khNZHCrdif7MKG+k6DcDTDjjZbEkV/ji0TuNSNTBrtYnt9JPMpGs0aq4LXiIK0CPRDMmHHyinO3/m/SMB397wMXycifADTJDc7ag9J/D7BW40QYkPsKdHIn/j1W9mSHFkULOz8XrDzOkPfgl8zgbalodtYrAG+h5HsDCPvfW9cok0UZuP3DY6qEZWsnl0sauY4o17hF4KQXcyn20DKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkIVsFwXqFn2W0jYQp+i3guKuV/P2Eseu7yVNB0ztlw=;
 b=TshI3M6KKiW+kCZBrYzBrqMAg+o8b+C1xJifh4U4xLZLGCtgIKJYO3Mxq5wAkinB+c6yQjC4Tib9v7H1UdQ6d74bsTg6a2KMf0FX8o06j3T68OOLjsrexyabEeAaqFBH23kh8heerh8+9kHEDUmEZV2CeQ4L1AMZ6xOs6izyU+s=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8748.eurprd04.prod.outlook.com (2603:10a6:20b:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 00:07:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 00:07:30 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ranjani Vaidyanathan
	<ranjani.vaidyanathan@nxp.com>, Glen G Wienecke <glen.wienecke@nxp.com>,
	Nitin Garg <nitin.garg_3@nxp.com>, Chuck Cannon <chuck.cannon@nxp.com>
Subject: RE: [PATCH V2 2/2] clk: scmi: support state_ctrl_forbidden
Thread-Topic: [PATCH V2 2/2] clk: scmi: support state_ctrl_forbidden
Thread-Index: AQHaKO/hcegSzKiHwky3h5GWn2PoCLDTZMiAgACNREA=
Date: Thu, 11 Jan 2024 00:07:30 +0000
Message-ID:
 <DU0PR04MB941722B7265053B7F703A11B88682@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20231207093345.581048-1-peng.fan@oss.nxp.com>
 <20231207093345.581048-2-peng.fan@oss.nxp.com> <ZZ66adlVpON9zVbH@pluto>
In-Reply-To: <ZZ66adlVpON9zVbH@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8748:EE_
x-ms-office365-filtering-correlation-id: 248b39ea-0cd3-47a1-f56f-08dc12394d85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EFFpOkitGa6OLLO6iVynsUxMAU9ICPDACHxnLGaw8hQ66LBRSN4j7gR6pmeQasX7QxAe/f535NgfYCvHKvtS4vv+hsOM+0o0qr4TCtW1JEOEZ9xTwJ3XjDEW5QRRi1ypqqrok2cpkGW8qVAUZwA264XSbbTSaNgljQaiLFOtbmnK8LrpvIJ+k0s4Gk7Ghtajb+aQYr8sTdES80c+y6Cw1Jy8f0MZet7b/+JAjd8wqJL7+loCAAb/tBd+DflKEckKzdbsXXUYWLdluch/8IF5gmc+ni4UtkeX7mowN2JhHIeD9ggBMDtZ++0ohbG+Vl2CBLXQPYKQ4K3vRgStWtq227fsJK4Pi0Hp58HzC3C5vDuVn05+9GNF9ivt5a9LHmkniPwgp4sninuQDNf7JClNzsNqakHuFdJk5fSZymyy6V6TMKPZ+QLws6ShYOR0m4lM0e4KltM/SL1TT6jYu8sqThoxbSIODgd8GuCFcziPo6WTpwcGW6tMU7lBnqic6WvxYdUJ4ml4+0GdjU9EFUWPRxw6ICaAZtE92JY7Gxn0x7F+6YUWXRUmLQ05Pf6fZGHPmnVlsn5pL0xP2BFkdNa3wCzwX2+J6csxhcF7xb19+PsIA5tvd5GOSIepL6UqrPeGFNG9eSQKqJw6K+rTs+qIWw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(9686003)(8676002)(8936002)(478600001)(54906003)(71200400001)(316002)(6506007)(7696005)(66446008)(64756008)(66556008)(76116006)(66476007)(110136005)(66946007)(52536014)(83380400001)(55016003)(44832011)(4326008)(26005)(33656002)(38100700002)(2906002)(5660300002)(41300700001)(38070700009)(122000001)(86362001)(21443003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gaVZ2V1u7YQx0MOtzHCi2d2aa0cgH4W8E1nAAsmNXx9Gk5IQRBi3y6Xt95zs?=
 =?us-ascii?Q?p6BQDO8p3DY0S3vPsECApuqr4UGkgibKzCJQn8xV6d/UUJEmb+dMLXOtuKqn?=
 =?us-ascii?Q?XD27HVMupT0Y3FUML7iwY+lBpJkI9SbAefqR7/izCvLceinWdZaGUsNWtpaV?=
 =?us-ascii?Q?vx9tWEp5krk+gCx8xdrPJYh3lhgXAAB/rVKNbyWzleEUzydQj8oCST8AGT4o?=
 =?us-ascii?Q?s1tSz7Pk1w7YgaCYMD+jFvu/zduUHmgLFObvyLd5sFuCIUWSzFYqH9h0KDfJ?=
 =?us-ascii?Q?1lGOFEZ/KXPARkvT/B8ygniE/xd0Hg1tnM/UQBwDjH7m65Xoc4G72XyxFPHC?=
 =?us-ascii?Q?B510wHbUEJBZuF76RiaZ8TFcdkfb8m4wtsK+E3LC33hHykYrzpoIQF9iztHJ?=
 =?us-ascii?Q?xfIUjWlIZ8KRemG31jsl6FBgoQZyAZ+zuUQsv9XWB0bsY1JHjXI+NenEWcFg?=
 =?us-ascii?Q?FWI9ng84BpfPHGIAKjQM2BvAsQVTxqDTqUutHqWbAQESDKCTR5IBolAvZX6J?=
 =?us-ascii?Q?t4p24L4ccxq2QZqSDryYjkl6MnkG46OSGtp6RLPE8U1D3GGFfQ+YvwL1dpIx?=
 =?us-ascii?Q?4jU/zrx3Cs+meQeWNkLkh4S0uj5QN0cfe6eoA8a13E8RKa6q/ZgSZD17P8SD?=
 =?us-ascii?Q?4eXYtBhadQlc0EurJfjDedvLDlgGmiOuXGLwJ9if6fDrvFE6qh5VFoCdW2iy?=
 =?us-ascii?Q?/KXG7gCLjPx9YX/vTYCYNu4MwkobtgUaosbcQ0APAPCDL4v4WE73XFGMAq4o?=
 =?us-ascii?Q?PdCyvOXTKD/9FkSX/JYaeNLd6J8rKVV2kbTV5XmjUTxP8ME8eS+WQdnVNsWd?=
 =?us-ascii?Q?4rzuTH9GU4LCY2NOfC3Ic+dus9NRMAi6hD9sydzSpxXngTKZGdGh+wA7qef9?=
 =?us-ascii?Q?JiGto7U0onnTpBhzZVrU9vFdHZUe57l69UKU8XSzgZKXkdSjh00eyqcAadyz?=
 =?us-ascii?Q?FUlZU+Zee7VHfua7J4eSM7rOspIuLNju3qHQ7KAyC25qs2/uFN4Ma2EgRMsZ?=
 =?us-ascii?Q?2IbvDHWSIMY4ibeEdk3SW8PxCfXMXaQMptIp+eqY6CT2H95s01RtJoSa38iI?=
 =?us-ascii?Q?O7n5dP13l9fzwYiHefu9i+cwbDZqEeL3QPvKFesSuO8mGOk3Zi/NRHjan3gH?=
 =?us-ascii?Q?P1tJLWS7mkwtBUGf76wfKQU8p1HTyNEju2JSR0wVBOznAPJuAo7+Z2CVnGT1?=
 =?us-ascii?Q?cBE8GHFPnuU3BcoKJv1kYrh3z4iVUC/Sc9sccqr+WX1KayGvzSTnalO795bk?=
 =?us-ascii?Q?kGmB7JuXp81Iq016L+QvoLuw6M8vPWoD0ohLvwVAhn2WPNsqAbcOOjrBGCVZ?=
 =?us-ascii?Q?sbWycnQvjt2iUkbg6aM7CjmIyUwb1uFMNnoQbhDqVbr5o0Pj8sNTpJtyqB4a?=
 =?us-ascii?Q?e/mrlyOBTA/dCJhjvQLWziR6xUZUDvuPD+rBgCv+NX5hBBQ69ZoI1UGoMEbt?=
 =?us-ascii?Q?gPfFeGntEiwnbtOhWsQ6uRZhUgcm1BTiF5mZr9RTqGFKlv7SBCVKHUMtT2nC?=
 =?us-ascii?Q?GC6mltzJPWy3toN2dkZUmLHus8rB0VnE7l0JAqSpPZAXaZ38bZuHJrg62Jd5?=
 =?us-ascii?Q?7IRXNYeWLG/jtW0onyk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 248b39ea-0cd3-47a1-f56f-08dc12394d85
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 00:07:30.2680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WjE3tY4W1c7fAKeho1XumOhTsUjVhtGPIB4m5zCYQ24F7o/FpHLsSlDXQn7onEsQDAZxulutHQicX/2SXDZVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8748

> Subject: Re: [PATCH V2 2/2] clk: scmi: support state_ctrl_forbidden
>=20
> On Thu, Dec 07, 2023 at 05:33:45PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Some clocks may exported to linux, while those clocks are not allowed
> > to configure by Linux. For example:
> >
>=20
> Hi,
>=20
> > SYS_CLK1-----
> >              \
> > 	     --MUX--->MMC1_CLK
> >              /
> > SYS_CLK2-----
> >
> > MMC1 needs set parent, so SYS_CLK1 and SYS_CLK2 are exported to Linux,
> > then the clk propagation will touch SYS_CLK1 or SYS_CLK2.
> > So we need bypass the failure for SYS_CLK1 or SYS_CLK2 when enable the
> > clock of MMC1.
> >
>=20
>=20
> So I was puzzled a bit at first (as said) by the fact that here we silent=
ly swallow
> the failure if the SCMI Clock cannot be disabled, BUT then I spotted in
> include/linux/clk.h
>=20
> 	/**
> 	 * clk_enable - inform the system when the clock source should be
> running.
> 	 * @clk: clock source
> 	 *
> 	 * If the clock can not be enabled/disabled, this should return success.
>=20
> ...so I suppose it is fine for the CLK framework at the end.
>=20
> My next remaining question is why are you not doing the same when (ret =
=3D=3D -
> EACCES && clk->info->state_ctrl_forbidden) for atomic_ops ?
>=20
> I.e. in:
>=20
> 	clk-scmi.c::static int scmi_clk_atomic_enable(struct clk_hw *hw)
>=20
> Any particular reason (beside not needing it in your particular case...)

No particular reason, we not use atomic_ops in our case. So I am not able
to test it. I could add the same in atomic_ops in V3.

Thanks,
Peng.
>=20
> Thanks,
> Cristian


