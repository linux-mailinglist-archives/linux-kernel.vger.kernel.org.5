Return-Path: <linux-kernel+bounces-27630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6205282F34C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15C31F23DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C81E1CABF;
	Tue, 16 Jan 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e8/BB7xk"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B4E1CA87;
	Tue, 16 Jan 2024 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426558; cv=fail; b=X+Z3Ap2vWG5NNi3tBNglfgDJXs8mGGWW1aVeVe2hVE59dDUdRJdtUYDCVSU36Kq9GBC51d85KGRDd0cm2arPmFTZouzv+DeETKkD+xixjZLuseGBjxeeOfHZBhCfQW8Z3Cc1V8Szg9/orBfeYf1dmOgFiot52zMRIo3OsOf4K7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426558; c=relaxed/simple;
	bh=HaPbqvpYYBlBYWkDWYnmGFqNJ5xc31c0nxzSpehpKJQ=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=WS5AWo0ozjgHPMnGp4ev/4lZG+Z6yLxX5GdP2riwGY25bbjcTYj3Ok1Uj7fNQAE4BKcS5/A2nM8Lae0T3teAp09XeC7KmSjm5fFrtHxd9PBHvxtzTm2g1jHMx2c7NBDDHuv/8eSmmgfUlStoi5gkxRgi+KS7BFP9V+bEeKInurc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=e8/BB7xk; arc=fail smtp.client-ip=40.107.249.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHnEtTw6cAY/mBih8cVVzHFWrNiYUky6oocbi9BQq0E4v2Hctqo5z+Cq38PUx54a6dqQ9N51MHBSvPvImVsZxpODTu8dbFaG6LYiJQPjR7k9f3TLAef5GN7UTJfbSGPvI5nA0C2zAAyfDIQU+65nM0t9l4GPD6CshmTjEdnSZunD/ob/aumoG9/NOZG+Y+4uENjL8HY8nDifIagy9lSOTCVS2SaQqzTJacSSwDP5va3CnOOa8O2h7Hptz/ehO68NdQtezg+IzLNMhXOrXr3DJRV0liLFyAdDvrqRbPAcgTkjNjtZOrA51dhAD2CvMcafBN6mulTy+wIcYqHctpw2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoB55nFJJ22tVRqlTkj3q8yBoFSfhXTtnKX01pIY2iI=;
 b=h2/XDwvWuqKzWQwNkysRrM9C37sbHhMhWxlN1ETiIokilQ7r94g6H9DhTYxM3K9AkBtC5DR+uXMZqSkbReZ5SFic/UodFm4vmbWJeLyARfBvsmojTP4AVUlBB4Tj8GEMai0VQmP/Vdjxk1Sf0Fzeyb90YZg0PYfgTJmUn7yTyFBVApn106Mk1BKf5WyHIQGvjNV7cONOakkBkwezjyGJAJxRC6+PV2mDNDhy3jtmh4GHdH2uZQ2bgsGOjyxGCh8mChclvcvj4nQBY18UtbWqkzyLQdxcKLEB+r3wXIgESM9CUa/GKzUp8qeucsskxdkSJe1SOCPrjiUKC6SAKHcBEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoB55nFJJ22tVRqlTkj3q8yBoFSfhXTtnKX01pIY2iI=;
 b=e8/BB7xkO3aaI/j32u2LMNrCP4i1YyMFxzoMhM8uQSS0PNDz905ra+ba3G7BaX/Or2Pc5CTQWpDaX+SsKmspsmWBOr2tgoHMM+tOzUi7rHVUh8sSmMSY3LJC9LhjhIfeCzipqWTa90sDPDuJGhUK6Dbu2X34f6m7de4k/PSWO9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9440.eurprd04.prod.outlook.com (2603:10a6:102:2ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Tue, 16 Jan
 2024 17:35:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7181.019; Tue, 16 Jan 2024
 17:35:52 +0000
Date: Tue, 16 Jan 2024 12:35:44 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, robh@kernel.org,
	alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	jirislaby@kernel.org, joe@perches.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Message-ID: <Zaa+cLGVVDSB5MYr@lizhi-Precision-Tower-5810>
References: <ZaFbbeQrC7o2dchO@lizhi-Precision-Tower-5810>
 <e3b9aa63-25a5-41cc-9eb7-6e7d1eacb136@linaro.org>
 <ZaFjaWCA6k+tiCSJ@lizhi-Precision-Tower-5810>
 <ZaWLCrWJEMtFx8cR@lizhi-Precision-Tower-5810>
 <1b628901-7f71-4c97-9a16-723912988417@linaro.org>
 <ZaXqCoCHPWER94Hh@lizhi-Precision-Tower-5810>
 <d45e31c4-914e-4cea-a145-9775b6f516ab@linaro.org>
 <20240116-bleach-herbicide-48d636967134@wendy>
 <3199c245-3d2d-49e8-951e-2b059de4d683@linaro.org>
 <20240116-achiness-thievish-10a12b3c08cd@wendy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-achiness-thievish-10a12b3c08cd@wendy>
X-ClientProxiedBy: BYAPR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a208ce-afd9-45bb-606a-08dc16b99658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nbt00daaLQYSsXNYweRdfyOrb6zcNMyXEZ5BShDIpNCsA8xUJDX/Maf3EUrmLHV+J3gfUlA679MRUqOI9Mf271Bq5YnSWj5JAcAf9aFFZTAec+jlSNX0Y/oFzm3WbAs8txyppUN9X+r0XqnLA2MBPqnaMi3UYhh3QWQ3R5r2OkjWsHgy/PrX6n7EUuoUJjzBq44h11KPD223ePLePxUnFqrinzbDd/ELpdSc+sLIwAA0uUYDznR0gzsbuOSwbMkOqDSwxBi8ZvgqAZajGlyVPfEShzFz4Befjlh43mW4Qr26USfMsv3/oYDpqIHDQsyb+yN+TIYkylK4Odv/i+cqv4tmwiJR4/aokbx5tGSzIUu9beMX6JMOl0o2idW1x/G4GBYQS/mRJ2cRe4Zd8Al9ynz7Fq50VXlkyKTTtRcuAL5R1vT2EpJVnJXnPxTrjYvxb6KMySjJWZeH5gtwiirKkj2MFdHXa0iPYc5Cr8s/VVv+OlKIoGxqLGyAHyXNjpIRRa9rrW/gzWHjIYTZ7UOnaarZZndWuKXaSeFi8mPghFU9nwyvO5bwuXawdGghNQ7tBfAC5txymx4yNQ2H2ZZE+zMJIpSikr70FqJLJ92YhWjAdGVLmRP98GdPmYcDgLl5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(38350700005)(33716001)(86362001)(41300700001)(6916009)(4326008)(8936002)(6506007)(8676002)(9686003)(316002)(66946007)(66476007)(26005)(66556008)(53546011)(6666004)(52116002)(6512007)(478600001)(5660300002)(7416002)(2906002)(83380400001)(966005)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DEm/g4SpXWWuHIVI6GGzDn7MWPNyhNpBLakn364C704TyCP7qpH5G8zPKHKd?=
 =?us-ascii?Q?PnWt3eTkpslbKsnYpt6YXmzI9PyhU0Q8k2PuUu6YOq7ycdDNjEnzDiSLKejZ?=
 =?us-ascii?Q?VSD52P7gBhGZ68kr+wq2rNFRWLZjO5X39tArn2I/V4gxT+7nlUMgkth1i0Ig?=
 =?us-ascii?Q?wf0wgeaQV5MrVPZLMr/cn14/0Mx9/ULR7J4GR2I+XG2/cvpXjd+JAMJvGhBv?=
 =?us-ascii?Q?vv+JnNH/TnCuMqe2T0O3lNqiTxdbH8V6lIca8mOVCOQKxcVO60UcBiAhedk0?=
 =?us-ascii?Q?Z23lY3Qbh8K3UXbVyaXZj4ijHQzqM6X1Z6YCJ05KndI4QAGINbxXY4Tcz1lw?=
 =?us-ascii?Q?r5/yvH5KYO58nTah3vxCFWs98dkiAfFufpv+bh7AlIC8qLfION5IsbxXURe2?=
 =?us-ascii?Q?nkYkS+McF1nz6JOvqetUw879kww7D+4XnwG13R/1KFbMUtYU3izfRDOFU3rB?=
 =?us-ascii?Q?ptG5OufaS9nEtYF7LgkIJHlPAKqgXk6EWSuDuo/aErQuJmlGYJmG5N6Xfgfm?=
 =?us-ascii?Q?ccD5u3ouCVIcl79U4q5vxmrinIkwVMBEhQ/ji5I5oKwES0j/38J1oDuAfp57?=
 =?us-ascii?Q?TrFGlxcxoC7Yp3I9ersFkTnfCfMJ1qFpDbxgnOcuZG2u4vGivG+wAX71aArs?=
 =?us-ascii?Q?bRRY7oHo6l2qW8onSONqlDwYYMx4rY1dnN61WjWmhoB3KFGX5hwsLUQO+ueG?=
 =?us-ascii?Q?zZ7YOrDE3C8SR+JluKxjsc6ivfeB+tBAYETT0GuzNCC6dpkOPRT6kpJH+nEp?=
 =?us-ascii?Q?zPIptn2N6M/xlwJVyXx3vOtid8sHlYjbK04pyqrySWL48jOT3OanAGAwsk0y?=
 =?us-ascii?Q?QqaH46Q+By8iq1aLqlmoEmdIeVXDHdwhEm8iOCOcS681fzU0HjQF14K/s65E?=
 =?us-ascii?Q?TbZyDV3pddf9VAjBC4UB978KByMwyK6sm3TiGVHMvmyOmR9W8usY+Qne8UMz?=
 =?us-ascii?Q?v0xaSQAMXrG08EdPMOHAsXYQCOOVyeMNVeBOLaEXyD+yCUbU1ukslGdZ8HOa?=
 =?us-ascii?Q?yYiOzvxLduseyk1WnbqdgXPQRxXzb3WoFRhPNR79BNPzkvakJJWVDaoYW43S?=
 =?us-ascii?Q?eRYw4sqTQnv8zNg9yrYBw3NPLsKFS5IGusjtU30T3ejcXM6e8GyTOoZsDJCC?=
 =?us-ascii?Q?nTnb2evkp5lHU1kYvDcmaM8vGX0iXo7k868KNIIxrbDdzVMKs2bS2K6EKjMP?=
 =?us-ascii?Q?ivNlmxH/0iEaJqFrQh2OFxw4997en5ulYpsIhmXWSRp/bdUOBzUTOeydy0QA?=
 =?us-ascii?Q?0EnGsfn8fCaDXLAqhzjOlh2YjHhDYAiUSigPUhRlHEHiQrIRf+9LH1IS8OUT?=
 =?us-ascii?Q?Kko1kpcWGrTUkakrqLkDNgkOt/c85LqaIxYM1yzV40P5f+Nyc8gnXPe/oaRc?=
 =?us-ascii?Q?rX2Qtne8KgWv5twh1xV3pr2F5CEX+sKVbP9RiMIp8Wo8spEVZsFysVWJuDc+?=
 =?us-ascii?Q?NB90Il+oNvQzmDobTGsLii/QCQQQ2knyUuGzLGOxXSP/OjfvceCUSQ2aFGP3?=
 =?us-ascii?Q?bTFGwPLkdt6ONsA7x20EGzzVOzreuEiDo1q0rHwJOloDCLoV2a9l2TQ4dF/O?=
 =?us-ascii?Q?rN0cerXEDHXB4tGjzig=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a208ce-afd9-45bb-606a-08dc16b99658
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 17:35:52.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgA3tmAY1BLQfiNAHrUNBgFcBict0iCFlJBxTTMtXsd9Zb5Y9jCEFPX/v5oD0QlGO6cgY5NyxhWWlyGeDGI2TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9440

On Tue, Jan 16, 2024 at 09:48:08AM +0000, Conor Dooley wrote:
> On Tue, Jan 16, 2024 at 10:33:48AM +0100, Krzysztof Kozlowski wrote:
> > On 16/01/2024 10:30, Conor Dooley wrote:
> > > On Tue, Jan 16, 2024 at 08:24:20AM +0100, Krzysztof Kozlowski wrote:
> > >> On 16/01/2024 03:29, Frank Li wrote:
> > >>>>> 	Patches were accepted after discussion, what you ponit to. So I
> > >>>>> think everyone agree on the name 'silvaco,i3c-master-v1'.
> > >>>>> 	I plan send next version to fix auto build error. Any additional
> > >>>>> comments about this?
> > >>>>
> > >>>> I still do not see how did you address Rob's comment and his point is
> > >>>> valid. You just did not reply to it.
> > >>>
> > >>> See https://lore.kernel.org/imx/ZXCiaKfMYYShoiXK@lizhi-Precision-Tower-5810/
> > >>
> > >> First of all, that's not the answer to Rob's email, but some other
> > >> thread which is 99% ignored by Rob (unless he has filters for
> > >> "@Rob"...). Therefore no, it does not count as valid answer.
> > >>
> > >> Second, explanation does not make sense. There is no argument granting
> > >> you exception from SoC specific compatibles.
> > > 
> > > The patch could have been applied two months ago had Frank done as
> > > was requested (multiple times). I don't understand the resistance
> > > towards doing so given the process has taken way way longer as a result.
> > 
> > I think that Rob's comment was just skipped and original master binding
> > was merged without addressing it. I don't want to repeat the same
> > process for the "target". Indeed I could point this earlier... if I only
> > knew that Rob pointed out that issue.
> 
> Oh I think I got confused here. The context for this mail led me to
> think that this was still trying to push the i3c-master-v1 stuff through
> and I was commenting on my frustration with the resistance to applying
> the feedback received. I didn't realise that this was for another
> patch adding a target.
> 
> I think you already said it, but NAK to adding any more compatibles here
> until the soc-specific compatible that was asked for for the imx93 is
> added.

Is it okay for 'silvaco,i3c-target-imx93'?

Frank

> 
> Thanks,
> Conor.



