Return-Path: <linux-kernel+bounces-73767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 649DD85CAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43079B22438
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88F7154423;
	Tue, 20 Feb 2024 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T3u4CE0/"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F31152DE9;
	Tue, 20 Feb 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468636; cv=fail; b=cT9AjJ0gPDngc2ZurQuoe3pSDqvuoiLG2EejNH3AA40DQ+0CVWXwQt0JV/ksOu6jyp5qJanOOPFmNLYqDF2KwhJ7eNSNdpirzJYjDi+5Lf9WULYvt11Fi5HJMc24jPnwsfYs5sBTI3VaQg5ER+a2WoWwbZwZOzLoq4gWiDBLCt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468636; c=relaxed/simple;
	bh=7H/YQbq1xtVLGd3B0qRzWw5xGUTitjUEZ4qGF5Zazak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jxQ2XUcyDUqeDvGaPlldpJZQFH1hH0xgPgnsCyQC2Ptb8rTV9jGDd66472HSRUJwOcSoaUbmi14NVmDH3nQ/O44V0lw3tGT4hjRVf1zibdShzcy2QFVX5ro3UKkfqLOv6+FSEbz0vjkYsKURcwpaPDGDKGADsupcWYmIt1/JZtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=T3u4CE0/; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uic3m1v8l5R5xyGUkLNH21VUpiOvwsciYmY8Se1joKyqIcP6/2PQNIosApbuovV9Oj+asIcMiy8tnDPFO882rEGTk4fz4frCfJ/Ra/iKoY1K8T5UPkXWjK2HRIADWyF4U8S9SElKKq6lfY/PZNcPL/nQe1U8f/CLp7xBMXfrNYczunSmgx6ujRr7rx+f9QdjztbqwbqasCDor1FZZdtcYOw5SbK18S7w5GyqTaRHmQzkFvKqLh6kH8W1UWABKpkxLG8wYCL1poDGoTuD3tacJPw84P118kEIAM+NvkuKw0aTVvZOOSUd8E5hun1qPKWmZn1LJf+g+CnPJlgF2rcN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RpyR2SrSGzuZI8/fAyfo7YCEvhJ9sUfrUOWj5ZQaXI=;
 b=MpnVIlDNX4ODhsd6/TlGC+NDXDwJnkvrZp7uKO5m4kF2YJwr9U6vSNITFNuQj7wY6LduuNKzw62TABNUNxWExzJVyiU9fpware4IVNEAICM6UWCF6YYBcJ5rWbSdssbpnUkw7dWohC9ZKjswLVl11eja+1GGjWCl70zrVyjMYf6GpDu7ftOHiLS/XGwGR2D3uVNcfI13dULuV8Iil7bOqbb1i5umb5S3kJZUgcqm0kWNsjEkoDr2NKdFlV7FaNi5c54MmtQn9QCVjh6tEHfB4ftqFZASgPnvatOzUmFLBt3F1Gz1jfUyggpp7Zr1UgcOsP9TRjKcmRngjJrVLPbslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RpyR2SrSGzuZI8/fAyfo7YCEvhJ9sUfrUOWj5ZQaXI=;
 b=T3u4CE0/wOdo3gyZ8oEb3ZahKinvL6uUTMBJLlb8QNqzU7g+UQKvU2VE3lLxtH+iiQS5AwzKmGORRLZy1NQbY7Uz2uYvlmI3IrMhhogvPbI5CLc+dB5bblK4xB5C1/jpFkuDE4m94ynau3M+kMD8tx0LmI5ftwPYvF4i8PQR7H4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PA4PR04MB9639.eurprd04.prod.outlook.com (2603:10a6:102:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 22:37:11 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%7]) with mapi id 15.20.7292.029; Tue, 20 Feb 2024
 22:37:11 +0000
Date: Wed, 21 Feb 2024 00:37:06 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: zachary.goldstein@concurrent-rt.com, Shawn Guo <shawnguo@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] arm64: ls1046ardb: Replace XGMII with 10GBASE-R phy mode
Message-ID: <20240220223706.o7wc5r57omkmgtgh@skbuf>
References: <20240220145037.kf3avnykjif24kkr@skbuf>
 <191b4477-7b4b-47eb-bb3e-0e4d08b3b32e@seco.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191b4477-7b4b-47eb-bb3e-0e4d08b3b32e@seco.com>
X-ClientProxiedBy: AS4P190CA0033.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::13) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PA4PR04MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: b11cccf0-252f-4c42-0a9e-08dc32647a4f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 Cu/bBQ5+Z23Zgo9bRgkVuDEyjz1cIeufElteyqbKsDO+pRUAZNWrV7+vrey2Z4CJpDOmCNVo7SnLRfcNnNh+VbRs/1s8f64lZiEynvcKMa1YCc5q0emkB1G8cQnx6OGtBD0zyTgJGIe5VWgnlA9wasA2hk6fvpD5WR7UqNylS/SLZQ2dwMsOUvOCYvohIPwEsYNkuPp5xPQFljb6BU8PgIdP5YhTnMQ7ZA8d3uwK9poClHLAYz9NR9e502oGyw7N8x3fD+Xo/IOUXEg2YhFWjv7lRkaNUeMANfmyXOmgH9Jp7fQj/pYZiU6NrPb8IuNyTw0X5okPQJLpvkY+zr/2oLHmVm5naatd3Col1ZUWY63uq5kjIGc5U5GkjAxirVf1gvW6dkBHx30ZThVkPVUBXWSdssPbc4xr0FADBzwp8Sexpi2DQa+z8n5BVU3a55U0c7gqwI6x0Kyt8kZM1rAj59SXz6d7DHGvWzFgaTt1igTU5FtEvvgPlZxCkZ2WA5rV48TK/K9iznzqpm9V4DVPuA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?NNpbrND+dpEhINGVdaoDPnR534Frk9H3om0BYH99bZ2tuL7ByYs746UkOH96?=
 =?us-ascii?Q?jdDRFZ0h6oQPy7wvZxGWHthoqNe3rYirkbGwaHj0Eiy0bCmS/t9CZwcLDwCd?=
 =?us-ascii?Q?wQ2cHAOG4uOWrJKvYZLmQbJ3PbM8XQYer/3WSeWfei4X1oWnKP3uesE3pdEw?=
 =?us-ascii?Q?jmIquR11ukE3+oCuV8wf5+mdPZDSKDw4YB+wFRRN5t5vd6F7XTuylDsWK4tN?=
 =?us-ascii?Q?glr2J4CYRwQ0k+vZ3MqL6hyguOqltTKZFogJXzwA5u1uYEWSsaCfvQrbbLBJ?=
 =?us-ascii?Q?if1dNFVdk4UGvJKxKbwkL4fon/eNHt2+jDv9tGapSJjOGqAcYwQG/329F80V?=
 =?us-ascii?Q?a1YIB0BTx5fWBbdYzF/KpvBx9x3epTZsI8GfHCUU3QP32OT90FLv7ovkRCHb?=
 =?us-ascii?Q?veIPLSIfLWp0YSj4uDInexshxJ6y7exw1q+dhm28g+onjPyEAUzfaO6MGkB9?=
 =?us-ascii?Q?5YS+ZJzxEnLarNPxzAbKbBPOjgr26kM6V86ET/UrFx1BeLPj0QT2QlbE6C7N?=
 =?us-ascii?Q?kNkMaZC1Y2+4gq4Y1k90mDf9F5gE7+M/9U0OIybxAt3V7fLq5Iugi4YjMEu3?=
 =?us-ascii?Q?3Z0BYFO+fT4qDFs/v0/+LHVx3gTe2hrmscdurke8F0v4PHbesOrSz9yi6FqC?=
 =?us-ascii?Q?M8SG9rePowjobu1UrNBrSt3l2urFA3ci+e+vSimTGbNU2Dc3WETFrtdhz221?=
 =?us-ascii?Q?0Dpacog/OMyVQmKUToEypfUgFgxcafxzBDZIqPonWetd6juiFNJlXIsMA3vB?=
 =?us-ascii?Q?I6JPjxixLXc69uUQ/bpg8m0jzA2fIWZ/NvCnE6GufJvhxxgzAE2UpGk86LYE?=
 =?us-ascii?Q?MkEevX2GHBWQv5978/5eBOmiplti0y5Z5+JO5MUo79N1FEyrKpTtC4Rncpcd?=
 =?us-ascii?Q?WuqGT6bd671qdGJMJg5GMpSMj6/hTH7GdH07nXqntRs8OPq5u60PKodfJV8m?=
 =?us-ascii?Q?N7FPjhPxOxbUK0jgugo9iBYRlR8futyDbyItcBbW/8a7WExVJOgi5F0CB2xR?=
 =?us-ascii?Q?v16G5C8Yp4KEtxXKgPUvKIZ3+cSdsLznAvd65f8NOsupm1U54d4Pu+/48I6x?=
 =?us-ascii?Q?67DZH0ugCSfYRsyeuY0/sg1Zo23Xprltynkdwj/uws0lSsNLxRmS/wWz1NJi?=
 =?us-ascii?Q?BckPmLTP7q1soyaMjSSqKF3DTwadFYLx/blcsmGCRlnbPnEPJtWr18Z3v4Ht?=
 =?us-ascii?Q?Iv5fw9QnM/4oXhWRZSim3jhe77f0FVWDvZpCKdv4ssXkIRoShEm6md+hn31B?=
 =?us-ascii?Q?/vZpeCXq+LadvFTiTC7E3cbXhtgzUqW72CMpY3l0PqM6pZDL6OkwtKg9L6DU?=
 =?us-ascii?Q?Vm3cdKs2DC608M8QHfhuldJhPWbyGGpWfiTVPSiwsiHbjhboyf8CtPYT089I?=
 =?us-ascii?Q?uHBWV4XsTjEy4JTqT6JMLiz51TalyPfmroeRYmUXnO077etJJnj47a97wlNB?=
 =?us-ascii?Q?mzc6jcwi+n/9br3GUCFH36vDZRgHk5kaGqDRnN/fFcZ+l4TUeNo2gyRyDB3C?=
 =?us-ascii?Q?lG9WPzPHWii9/jbdLsKl6BJSen69Ssucj2725Q2M98z5HAVfOnCQqC9W7Vpv?=
 =?us-ascii?Q?6zjA8ULwq5Zqu/1NAZZJYPRE0lCTQbU+gvvyT/W9F48/gD+0jHezdeQQwsr9?=
 =?us-ascii?Q?ShoiUhSnexqO0+4fiXQsxZU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11cccf0-252f-4c42-0a9e-08dc32647a4f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:37:11.1907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YtLN8ZZToXAbbTZPpkVaq8VAFL3F2GQ8vzFqw5SSniqC0v0g1krOH/zHYPaLkPuQvtlIPAogJ8GdftK11o6cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9639

On Tue, Feb 20, 2024 at 02:12:52PM -0500, Sean Anderson wrote:
> On 2/20/24 09:50, Vladimir Oltean wrote:
> > Notice that unlike fm1-mac10 (node "ethernet@f2000"), there is no
> > pcs-handle-names property (fm1-mac10 has it defined in fsl-ls1046-post.dtsi,
> > whereas fm1-mac9 doesn't. Don't ask me why, I don't know....)
> 
> I think this is just because this ethernet is always XFI and never (Q)SGMII.

Is that so? With SerDes protocol 0x3333, won't the PCS that's connected
to fm1-mac9 use SGMII/1000BASE-X (thus not 10GBASE-R)?

And as for QSGMII, what's the relevance of that? You can't have one
device tree good for all SerDes protocols and RCW pinmuxing options.
Either there are 4 MACs aggregated onto a single lane, or there is one
MAC per lane, but I've never encountered any use case for alternating
between these 2 configurations at runtime, or with same device tree for
that matter, have you? QSGMII seems to have been the original motivation
for listing all possible PCSes of a MAC in pcs-handle-names, but again, why?

> Can you please submit this patch? I noticed this but never had the chance to go
> back and debug it.

https://lore.kernel.org/netdev/20240220223442.1275946-1-vladimir.oltean@nxp.com/

