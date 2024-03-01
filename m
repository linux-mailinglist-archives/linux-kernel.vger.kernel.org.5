Return-Path: <linux-kernel+bounces-88821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 745B286E72B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944DA1C2084E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B12F8F65;
	Fri,  1 Mar 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L1VpikdM"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E6525B;
	Fri,  1 Mar 2024 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313959; cv=fail; b=iHzrNibrmCvzB5pmtzsf1OBUdU18dSkHgOaRo+VQoB52LxJgdvmCoPJoB40aLTfsZ/uRlr8ToI5F9k66C8Miva+Cb05oe0RHZBn0+gDIPLeXo5aIsh0ZtDiNGsR9bIgN3QWHo0mewrFAJWZCsZjeT4Y/eQBJHa7pGkihSG0uuJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313959; c=relaxed/simple;
	bh=8e1MJyZHADCEqZhvP9vyEwhs55Ak6AiYC2dCgDot1DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p5X0/cZsNOUBWf+29axX56XwsGbMt0U2z5fW1W3ybGMb50hmxJRcjqB7LLGQT3sivmDuEc/cF8/3Fyq5sZrOyQmDyV9ZiUvsUAvMaRwzQLyUv9bmGg4SxjBl5OHDc8w/HPydEe3D1RtZBHNnp4zs+xy2HtQ+G74RxfWFqAGGOkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=L1VpikdM; arc=fail smtp.client-ip=40.107.8.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSLBnKMhi73+3wCfmUidAeBZQ3nBtDeNs/9/8DFlX7Ox2WTiYF6nYo+MMUN1/1PuBKXA8aSyYXPau6bp862/xs+QdCIhodIIhqtNTJSrQOhIpBRes1sFywZUwkLtt49oPxX+P0cRzrVEZeVlO4Z1K+N+gw4AT2sm9x3CGZZzDENstQ5xUr6jrU9jtBb0SEoT0iQhKJVIMoUfKcXRGAGGx6scqwH9XCQjZNebyeCNLv9XJsNuLPao3VyqZgz4qYwG+VUe/ysSScxZw5HL7T5oE9f/DJn7oz1qaHujJ2c+Hzq2xYZogknGbjwImb24ojNw01NE1vz8XzpIYQgjyJR5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2RBZa5Kf5zblRITxvKzThtCLv7DeRTVp+eaHYnj3PM=;
 b=ap5DvqHp2SRb834jVIzxzzB5mfSfv5M88Z/4HT5A9EJCGt23T9/VS1/DuN/xd+J3v5sct8jYzztEbyu3qiJe/mdmO8HVbTdfOcI10h9tgn0Y3bBepYk8Os4yM81LVIixY9Z/152oSCPq+XwofZgIfnmj0m+LL4ersDWjwjhaeTnTef5xfAPQLMPoEcJTXu9qKkvcoABW77smA2rwdd6Xyn+cXFypPAZ+MATemkOrB0TM+cbZYjP7hJYB418bgw7KbDFAo1nVVRMhbXXbu2zpRjtZfRe/EmTaOF/T16nhIlF0myPJ5ePYoDNNY4GBdggfaSHtaXPXaVU6Bs5rxB/1mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2RBZa5Kf5zblRITxvKzThtCLv7DeRTVp+eaHYnj3PM=;
 b=L1VpikdM9Sr/lwsGCHQFsg3ThPTxPQw+z6z0lTeAzrgX2w6IQUjnkPomt26CNrO563RT3DChltcExKgHUdWhmXOxU7kGy+IURyS2n9v3KCIge84Zw9liRj1Bs1KtfDEWOhpN7ruv+DYz76odPz84FuS8sPwBi6I3e6ttRjbIXGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9308.eurprd04.prod.outlook.com (2603:10a6:10:36c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 17:25:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 17:25:53 +0000
Date: Fri, 1 Mar 2024 12:25:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <ZeIPmGG7+5cKZkO3@lizhi-Precision-Tower-5810>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
 <20240227-asrc_8qxp-v2-3-521bcc7eb1c0@nxp.com>
 <20240229-husband-penalty-8c1ab0f57f55@spud>
 <20240229-rundown-isotope-954ba9ea4c57@spud>
 <ZeDdMJlxBL4SGkws@lizhi-Precision-Tower-5810>
 <20240301-crudeness-resale-3c0a1228850d@spud>
 <ZeIGXEJ3l4tgjmxT@lizhi-Precision-Tower-5810>
 <20240301-deluxe-tiptoeing-741af7d620b9@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-deluxe-tiptoeing-741af7d620b9@spud>
X-ClientProxiedBy: SJ0PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9308:EE_
X-MS-Office365-Filtering-Correlation-Id: 41265402-e84a-4579-0cbc-08dc3a14a5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ov4Qkf3vftCi44rf2ejRpJ5c92TVTYm7UkVYjsiIuQgkVeGK8sTKTzbOFX52oZ3qYNcSJ1iKX0dEqDE4xPlA3GTnC35qJEAEEqfMM4OOztoTW3ykm0m5HWQ7ZjL3yxNeEr6KvTGhRNzdNnsvYUU0Meh9ECnuq0YW1SxbRz514S84wFguVbYCPcxQbdIjl+jzawzGsvAFwGllcU8Ixuu6/jwVmGVET+rRW52BI/FUlIqEdjZvoepaVqDD2WEzlMJBXaTwOxn7mAfS66BTm+iDeq7qM+1AyNsc0mwCl27dri6Vfc2Nx6TTZrnnhh1S4+OtDxFY5eJiSObneeJBaxsy4dqiAdaXqR01YtLs1X8Q9KivOVlOeNLTgsAC3F6o/5LdEncyVar3oiY3igavhDJhuKDUt3Ravaj/TYoadxbCfMfzV1FjV/EyArOQfdg38C8du0or/R78hqV0OKehOQl9Mtud5toTDhEYdUIgk4scfq/6SbFh8T4woqqOT3N3evdZZLleNkC9Wp5M5rmgnMIZWQHztWSgd0oPjnEiBTc3rYvbRINUp897e3PTh/Vu4KWiEu4xfFf8nJDC8rqkFQzF6LCE9+DAZ6bIiml5cn9YT5vjhWQp6QYOhKpFfgq3CkHAnMf/a20EVp/1dZvUDlD7f4VfmqTLCVV7+FlntW7Hv5M1wzPztMLfUvpSe0UiQeWnUJJ0Kpn6kBk5ESIekh18Fd10dYMXpn7BmVY2cEU7Jg0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fWP4zpLsWifhf8lgclJrOAANBqPcujfxIUAb/F/HsYpUO5HrXZDfxCsSXyWd?=
 =?us-ascii?Q?g1rkxQVCalSBs9Y3EGtNqq+0MWrddVOqLvuDtO2Q9g3DnfvOyWYSP8QGoatc?=
 =?us-ascii?Q?MIKzkpWdD3mcTDkknti7LLxvoeOgg0xsOY8xtEX0rPR3jYJIHZJUFi9/c8PV?=
 =?us-ascii?Q?xsRfa2qakDxLEqzD5GEUIhhl5+zpoR94JDSQToc5VWdvG0zfGPkEG/CCQl3d?=
 =?us-ascii?Q?u6QwkKY2v4h1+FFZbPlJt2NJUZ++3S/sdgdxrLYuEsgspwZ0ADVYg0tere/E?=
 =?us-ascii?Q?g+CTWXiRmKuh51k2MtG5O1mIKz10FlIMKr4nICG1CRcqPmnJ6gQNzKidYglW?=
 =?us-ascii?Q?z2OVyHek4Cup1f9P+Q1Mm8qwOaujlZ/n2KlchXUCau1zvNTF4b4LY9S2QrPA?=
 =?us-ascii?Q?KwPcnD8IuowFvb1GPgNnxeIdudsWL+GNQej8PvFHry8yqPDiUYb4MN09KqeF?=
 =?us-ascii?Q?uEI/fdCT//PSOl/hobRMczAIceZh/B59yOYGq8QT0yIpH5t1+EPLyCIv6tKq?=
 =?us-ascii?Q?m9t7WBO9R/r/D/Es04ulGh+zpwJpO/q4wo4p5/Nc18FbUwz6LNTQoZFniBu0?=
 =?us-ascii?Q?YY8wNkrblXAD/VctGnBERuFsLI5/AhuwOmUf8t/F1vkxFHWSi2kcOfeOepdD?=
 =?us-ascii?Q?axS4ETVTvObrtSAdl+0CesCCPbBLqEXPhiNAYsTQdQzExaGFrxEJaTEwxH92?=
 =?us-ascii?Q?Irbk1UY10m4fQ04QGlV91QxOiQO1uqIQDodLtTpiBu5TjVVDzLbjiz9IbT6l?=
 =?us-ascii?Q?PMIr1UN1mhzP5onWtLBEcWC96E20ddghsIRj6pWjQ4nabmfn8j2/eIDakwxW?=
 =?us-ascii?Q?jie2TPF7m6XWWj9apbTuVgkO8BgtffanJNvZtlkqrgrGDOrEnlsJugoHkXRA?=
 =?us-ascii?Q?yA3uGdO7lqhEd+lfBiF5UD9G7FE0aKXR5Sv6c+D3iXTGd6lujY33dbpYZU39?=
 =?us-ascii?Q?iovws5lZwnkCAHzxQp+M+84qXtcKJjRKMH26dZpmCrPJE82rzzD4T61V3Qux?=
 =?us-ascii?Q?PFpkooey/YW4xQgPGCMR4RF6ylQbM+3x3o0QI+r3fW23ZwJj75LBQQ4hVERV?=
 =?us-ascii?Q?QpmQHO0d8mpUpj+vbJFHhB8S9087fVo4JnFteli4VO/TJghQY53Q4WRCoZZX?=
 =?us-ascii?Q?2yOh02QNrKUu+t6PWKod/b89quipRPRzILMsvhzvqhyO4KJfVGU7VgS2FWsZ?=
 =?us-ascii?Q?1j2de2Tu8JUAqXcy1k2Xh5lEwg5e6NWew7/cAqs8AdcOcOZRpvj2gQ9cnR+m?=
 =?us-ascii?Q?nhCdNTkpJ0Rj6zHeANj6BaLi/FN1Ldm/Mxi8IasnVBC7lIDufTSyOZcG5Xmz?=
 =?us-ascii?Q?RViHG8Tvle4UcPVd/4s2ok/slHlCxamUOTvB7UbFyskUO/F8iECi2pQ9DxI8?=
 =?us-ascii?Q?WCFyKvZ66ELC96B3LTj/TSLTjRmonFviWGfhNKuUEG39aSpshvg6if5Wj4x5?=
 =?us-ascii?Q?N0q/mv2bqAZJl1jFLWjTQG8UqjNge7ZkOgszxtda80SCr5qn/gXH267FSfjC?=
 =?us-ascii?Q?Gy+McL/Ipnuoyr+SxjER6cJQubz8+sirEua2wo3xcO/Xr6xaT/moCb7gykok?=
 =?us-ascii?Q?ncVqAAaHjiCZtVnWHtp8GQ5Rx4evM7TDiUeNALLO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41265402-e84a-4579-0cbc-08dc3a14a5aa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 17:25:53.3832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqHYtZbc1OzE1Fpin4Gtp8tcgNEmNGSMmKuEc62vyjjl64IQ0LSHUeS3qPLR0yUHbUTybdfxHr+qoy41QMS2Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9308

On Fri, Mar 01, 2024 at 05:07:07PM +0000, Conor Dooley wrote:
> On Fri, Mar 01, 2024 at 11:46:20AM -0500, Frank Li wrote:
> > On Fri, Mar 01, 2024 at 04:05:25PM +0000, Conor Dooley wrote:
> > > On Thu, Feb 29, 2024 at 02:38:24PM -0500, Frank Li wrote:
> > > > On Thu, Feb 29, 2024 at 06:57:29PM +0000, Conor Dooley wrote:
> > > > > On Thu, Feb 29, 2024 at 06:55:58PM +0000, Conor Dooley wrote:
> > > > > > On Tue, Feb 27, 2024 at 03:54:11PM -0500, Frank Li wrote:
> > > > > > > Some sai only connect one direction. So allow only "rx" or "tx" for
> > > > > > > dma-names.
> > > > > > 
> > > > > > Which sai? Can you restrict this per compatible please, so that someone
> > > > > > cannot add 2 dmas for ones where only the tx is supported.
> > > > > > 
> > > > > > |  dmas:
> > > > > > |    minItems: 1
> > > > > > |    items:
> > > > > > |      - description: DMA controller phandle and request line for RX
> > > > > > |      - description: DMA controller phandle and request line for TX
> > > > > > 
> > > > > > The binding already allows only one, but it documents that the first dma
> > > > > > is always the RX dma, and that doesn't change with this patch..
> > > > > 
> > > > > I said "doesn't change" - but I don't think you can change this
> > > > > trivially, as something could rely on the first dma being the rx one.
> > > > > You'd have to check that there is nothing using these using indices
> > > > > rather than names before making any changes here.
> > > > 
> > > > Linux driver and dts with tx only work well. Only issue is dtb_check will
> > > > report error. I want to eliminate these DTB_CHECK warning.
> > > 
> > > Linux is not the only user of these bindings, citing linux as your
> > > evidence here is only sufficient if no other users exist. Do they?
> > 
> > But, 'dmas' should be common property for all these bindings? I don't think
> > they use 'descriptions:' property, which should guide dts writer to write
> > dts file. actually words 'DMA controller phandle and request line' just
> > nonsense words. let 'regs', it'd better descript at 'reg-names' instead
> > of 'regs' if reg-names exist. Only meansful words is "RX" and "TX", which
> > already show at "dma-names".
> 
> None of this matters. If there's a documented order for these, which
> there is, software is not obligated to use the names and can rely on the
> order alone. You need to check that there are no other users which will
> be broken by your proposed change.

As my best knowledge, only linux use this binding.

Frank

> 
> > > > And it also reasonable, only rx or tx for a special SAI.
> > > > 
> > > > Can we remove 'description'? dmas should already descripted at common place
> > > > and 'RX' and 'TX' are listed at 'dma-names'
> > > 
> > > Removing the description has the same problem. The existing binding has
> > > set a fixed order that you now want to make flexible.
> > 
> > Actually original set minItems: is 1, which means allow 1 channel. but
> > set items to force two channel. 
> > 
> > Does it work
> > 
> > oneOf:
> >   items: 
> >   	- description: TX
> > 	- description: RX
> >   items:
> > 	- description: TX
> >   items:
> > 	- description: RX
> > 
> > > 
> > > Thanks,
> > > Conor.
> > 
> > 



