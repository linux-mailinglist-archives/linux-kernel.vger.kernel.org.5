Return-Path: <linux-kernel+bounces-28348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B912D82FD23
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03541C28BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D8624202;
	Tue, 16 Jan 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CgWoPaCX"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB63241F8;
	Tue, 16 Jan 2024 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443921; cv=fail; b=a0QcJ5N9NluopUhYhmY5H+H4LOQmqxIg/o03pRzscOabCSWr07o5A2CT0IYYt2Lt+YnyqAEdyvEjGP0347v/glK/SfahmERvlgidvYKCDqDy7bCuPx0pMm1UMcUqlcBP0VI5H0LmusAUQmuYvEgqnOoHBVZb/E2Xyox0l8nN27M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443921; c=relaxed/simple;
	bh=rpj83ICpB3Wwvn9UU2dElZQjZvuygNQsEzO6lLJJsUA=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=XrYhjnPURgft/rWN70thSEO+qCU/J7hyJoNtxU7Dwuw105LI35YRxfausyTrRV4TYgWPiZ/BSR+KUtLstz/47kAnzrbTBeYDYNgtEe6oPeefHZ6EyfqnL2HdGdf/qdB7kuNl1XS6lIemYPI1jVbC/WZ5+04LOdXCM/CePm7GtwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CgWoPaCX; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alLuFLn9hyq50LQ6DeNaG7CcqxzqrTzhl6BmB8nNBKJs2A/NfPKaxeY6JhLCtk2G9ANnlcmv3nStv/pCeAT3mT5n0ucMceZGzpoo0as4YKH30iE1mikVxNV14U3IyNfSlwx+yHAZF3FcBDFJRpMIwApBqDFxzRQwHeqtfvawgJ0UNfl4wSZtLrseAvV/E1z2q5I2rV6gj0m6tI/Ig6VewCXIPWLYEkeXXa9aTFoRjy2UFS/SoNo9t6b+nIHl3U55DQpg/FzpH22VQx5YWQ1JsDBynNI+JrOohXEflZCpQE2W7sYlMO40Hutbe7rn94c2AnE9f/IaQ8qFX5NchRhWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWMkry0bM8jVM85PtvxV44nPS/PBA2Wsp0+86Y4bcxQ=;
 b=JKHPhLoEwxoxsI+X2NWALWWM1h5ZnHMxhQxTyQ8JwO51mwaPJ7kRBibpqvSz0/+w0snOZgwQKk+6MjhOg2BRKJZj9ziQUH8+FO+ppWIFdZYVLQy/rZWbDEvcjgjtG0EbBFblrb5lBmBmwvohk3ERPm/XFy0h/GwnceBqf4z5HrL95XrayQM9gfAMeO/R+2SZvH05De5BHg/8nkDDZ0EeWl+RhSCrlSQ3J6seF9odVddnta2bvoKWsRkA+o+u1ZI751+nsZnTwkY3VGvorhyhRHhDTYBW3/OUJbf+jktlym0ObWytBKIJ3rcCzMwXnkGMPtDuGYK92+npSshLMDCc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWMkry0bM8jVM85PtvxV44nPS/PBA2Wsp0+86Y4bcxQ=;
 b=CgWoPaCX74/UNDn/k9MnEsr8SiE0ns/72Fr/lY8jEhxxt4I9VNZVwcAXA8+hxcBfbXOm2FlJCkOp51PXMdMhf1iKcwcPQz55XP51haDfwfzp385CeQyq4uPOBbcj5czqxXz0XmMLrBG/+5XDKQe6Y4dOfS9IUzGoi9uNHyjDM1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 22:25:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Tue, 16 Jan 2024
 22:25:16 +0000
Date: Tue, 16 Jan 2024 17:25:07 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>, robh@kernel.org,
	alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	jirislaby@kernel.org, joe@perches.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Message-ID: <ZacCQ1Eysqq5FnA4@lizhi-Precision-Tower-5810>
References: <20240116-bleach-herbicide-48d636967134@wendy>
 <3199c245-3d2d-49e8-951e-2b059de4d683@linaro.org>
 <20240116-achiness-thievish-10a12b3c08cd@wendy>
 <Zaa+cLGVVDSB5MYr@lizhi-Precision-Tower-5810>
 <20240116-retract-conclude-c47a7fc8cb21@spud>
 <ZabVSYgq1Mz3LPpC@lizhi-Precision-Tower-5810>
 <4a9ed1ca-cd13-4b61-af06-a3d7935aeeee@linaro.org>
 <ZabqxHD4wtiPn6ep@lizhi-Precision-Tower-5810>
 <c760b89c-efec-489e-8333-c60b38fb5a47@linaro.org>
 <e54e2b30-03e7-40e3-bb33-dc71de8511a4@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e54e2b30-03e7-40e3-bb33-dc71de8511a4@linaro.org>
X-ClientProxiedBy: SJ0PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8673:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d414ee8-307f-4d05-53c0-08dc16e203bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RtlmTTt4C+kXW9NUzuKslILVYlDaqW0jXeqzJg7/lhC6pjvN2tZJ33IGMiQ5wQ49oofJQHwMpNixQxBCNkM4LDNz0ZU4ESE//B/oDgjwxYdCqKHVtwy+Ey32LvV2DJUBRV/Lbs0fqKTJRM7GXhco2YuS11j/fsRIHNACzyGW1diBoCLgpslcLzPXR6usFEUqxPcUf+yN6RjFiPQp8nvBhClkrOgmYWHEAVxEJI26hj1O8typz4Izu9JdC2dR/+hFg4RxUGIKeTAC28JiUSdwlsaOgba8dIQLnvY51ukiN6PUIXivyA4XBJnbfe1+DzpJTQzxRhuKDSSxojmM1y6DD3P6Uy2Z6WoQIGVqNS8mY6szhreloHDObABWkmBpyf4A/81TpVpG+zeQ1yHkkr+mJyQLTcwb+iS18qilyysXlxzJ6dw/yIE7cRhPpFXdR1JXG3Rjc1EdzPt9UQ1F1/6gQV0tq61sER5TfUX78e+ADDwYN/3l+m9WzEUF2ODV3UeGItpfJrpT84kMjG3g87FjOW7GzMjMQwx7LqX4Ujo27t/Evo7iWdgfi3FYJTKcfCFpXIRyOST1r5qsuEA9jxiIF4OYQRaz0NYfrS4TkcmaXBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(26005)(66946007)(52116002)(9686003)(66476007)(8936002)(38100700002)(4326008)(6512007)(41300700001)(7416002)(53546011)(5660300002)(8676002)(478600001)(33716001)(6486002)(316002)(2906002)(966005)(6506007)(66556008)(6916009)(54906003)(86362001)(6666004)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uUAxZeKmoSdFYu2BV0bW79Uq0438RE4kYs+Scm9Eiz7JlU/JnXJDs2/jOCMP?=
 =?us-ascii?Q?SfuJ/baTW276OGT2Wsz68Ub4+w2XdlmkPpji0olsCt/Lr3Kl7sbGapMbOjIg?=
 =?us-ascii?Q?2+OGbuPUa0L2W/m+hVxsZOVg4abSvDwy9Xt4Jur5rTMjzTBb4lTscf/OOjHt?=
 =?us-ascii?Q?uhKpKhbeHyGRhTUDNUcL+lN6Fuu/MtECqsxkwCHe81fp9dDd9yNuxnMBsQmb?=
 =?us-ascii?Q?QGpoEe2ZCkuPVEAzweAaNhYy40C1wGwPosHjfgvl7Kt/d8eEb3eZbUxFzL0G?=
 =?us-ascii?Q?6LhzSF2fsgxJjF4wMCFOCxMhjbb2nd7aqJRCxs74UexbgUPa6qtX4ZOMQ5SI?=
 =?us-ascii?Q?Za1Z/JBQeLwQGaeNk0WMsMqLALAWDoOH5odcr3joFNqZ8VgXCgedP0wKcFhG?=
 =?us-ascii?Q?fIX7ps1dqHeKCR37ZtUDojmhecjDqgbQKnUTp31qmk3p0YaY1FAQV25PnCmt?=
 =?us-ascii?Q?Ru5rYCa2mjhoeCfrik5Ps/Yts0PzVrKixc1j2EfiFdFiVXgamzXNNCAZ3lMU?=
 =?us-ascii?Q?sIGu6PEBK/C1948yKhf67DCYgK54XqCBZxqiXtXr1auLYu1SRnsK4uVS+u2h?=
 =?us-ascii?Q?QAscQZmyQiTdiKQ9oC6Z49cUxurneLY2JN1m+ftJTBZ4RjAnV52u+HXlrCFS?=
 =?us-ascii?Q?fYGPBb27gjFITcxBAGUfhm4bROlQc3GpLadVYdOS5ibt24imFfbTPJ3s87bA?=
 =?us-ascii?Q?LdZSlPlLMFjQvvjOOXsFz3byss0GX6kBoIA3oMv3ONPOPk5FDL6RmgMe7zJf?=
 =?us-ascii?Q?DbR5DX2zUokGX0uBmOE7SdCYeg+1TIpwg2FeYfKWoHNLk0C1c49GgdF+VId2?=
 =?us-ascii?Q?9cv66QtMfwS4cegDJkL5PG/yy7WyGtcfpNt1oKBiiBik1mVSToatSvs9Egx3?=
 =?us-ascii?Q?yVHe5hZ81f3U5P0F91O+lpnHwLHZLvM9lyLjbYczN6Te/gQYeohB+C8RqGC8?=
 =?us-ascii?Q?4JLfz0uqzx7kUCRLymGdDqZKcUDPZFGzP02yu24COqN6z2zrFTS8Ljeuwdc9?=
 =?us-ascii?Q?nvmonvEAU2ofWIpfu0aIMw2OrNkuTc2vV5++KAdKQzav8i93bjYXjakasJpm?=
 =?us-ascii?Q?pUmickZcoBDWH3YpCD5bRGk2EosdwA3Ki2hKGyLRLzr/Nrwb8nr+gql/fRkf?=
 =?us-ascii?Q?q3myO3Gmswd2IgRbQLBamlFGm1ChcqBSOLlFjw2/hELJJahuPW3Bkj15wnDb?=
 =?us-ascii?Q?8uLi6euZ8wAQSAyatyqNWmmAPOA9Xbd1sVm925SVMnatwJsOAnvXud4JdYzm?=
 =?us-ascii?Q?BBg6tAaDNfeBQMGug9dx1I9PQcNUpQEy0jTkQvPfXZAi/MKHisIAbtwNswz3?=
 =?us-ascii?Q?f9uIlMXBsg1mEYBaHsrYV3COZI/bHZYbqI+60TjvlNT2eXiuxjfC7DqV8vM1?=
 =?us-ascii?Q?fUx+Su8RHfjB+ax0WJM5ZHIVPd8kS85vByNpIMEGkCVt9E7zprACDAwa0qVc?=
 =?us-ascii?Q?G5vmsqqUfBppIMgydhJ1kMBJ5pcsWtbtrYiayp6WvfX5tPKdKcv2ogas6PEJ?=
 =?us-ascii?Q?ohkucu4/Wj0W2uzegzY4SqED2TJHx3NdjYQ0OTuUUu5GPciZQbJSTj8Ntfpe?=
 =?us-ascii?Q?H1MD9gah1t/8H7yJzFk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d414ee8-307f-4d05-53c0-08dc16e203bc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 22:25:16.3404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrEe0UPHcCT7ewhZOyNYepePnp+zbgv3gPRJCUxRPP+nQ4TVuRIaRjaI+dwTkCt73ernMmbWvuDO2tH0MS2dQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8673

On Tue, Jan 16, 2024 at 10:01:42PM +0100, Krzysztof Kozlowski wrote:
> On 16/01/2024 21:56, Krzysztof Kozlowski wrote:
> > On 16/01/2024 21:44, Frank Li wrote:
> >> On Tue, Jan 16, 2024 at 09:30:24PM +0100, Krzysztof Kozlowski wrote:
> >>> On 16/01/2024 20:13, Frank Li wrote:
> >>>> On Tue, Jan 16, 2024 at 06:23:09PM +0000, Conor Dooley wrote:
> >>>>> On Tue, Jan 16, 2024 at 12:35:44PM -0500, Frank Li wrote:
> >>>>>> On Tue, Jan 16, 2024 at 09:48:08AM +0000, Conor Dooley wrote:
> >>>>>>> On Tue, Jan 16, 2024 at 10:33:48AM +0100, Krzysztof Kozlowski wrote:
> >>>>>>>> On 16/01/2024 10:30, Conor Dooley wrote:
> >>>>>>>>> On Tue, Jan 16, 2024 at 08:24:20AM +0100, Krzysztof Kozlowski wrote:
> >>>>>>>>>> On 16/01/2024 03:29, Frank Li wrote:
> >>>>>>>>>>>>> 	Patches were accepted after discussion, what you ponit to. So I
> >>>>>>>>>>>>> think everyone agree on the name 'silvaco,i3c-master-v1'.
> >>>>>>>>>>>>> 	I plan send next version to fix auto build error. Any additional
> >>>>>>>>>>>>> comments about this?
> >>>>>>>>>>>>
> >>>>>>>>>>>> I still do not see how did you address Rob's comment and his point is
> >>>>>>>>>>>> valid. You just did not reply to it.
> >>>>>>>>>>>
> >>>>>>>>>>> See https://lore.kernel.org/imx/ZXCiaKfMYYShoiXK@lizhi-Precision-Tower-5810/
> >>>>>>>>>>
> >>>>>>>>>> First of all, that's not the answer to Rob's email, but some other
> >>>>>>>>>> thread which is 99% ignored by Rob (unless he has filters for
> >>>>>>>>>> "@Rob"...). Therefore no, it does not count as valid answer.
> >>>>>>>>>>
> >>>>>>>>>> Second, explanation does not make sense. There is no argument granting
> >>>>>>>>>> you exception from SoC specific compatibles.
> >>>>>>>>>
> >>>>>>>>> The patch could have been applied two months ago had Frank done as
> >>>>>>>>> was requested (multiple times). I don't understand the resistance
> >>>>>>>>> towards doing so given the process has taken way way longer as a result.
> >>>>>>>>
> >>>>>>>> I think that Rob's comment was just skipped and original master binding
> >>>>>>>> was merged without addressing it. I don't want to repeat the same
> >>>>>>>> process for the "target". Indeed I could point this earlier... if I only
> >>>>>>>> knew that Rob pointed out that issue.
> >>>>>>>
> >>>>>>> Oh I think I got confused here. The context for this mail led me to
> >>>>>>> think that this was still trying to push the i3c-master-v1 stuff through
> >>>>>>> and I was commenting on my frustration with the resistance to applying
> >>>>>>> the feedback received. I didn't realise that this was for another
> >>>>>>> patch adding a target.
> >>>>>>>
> >>>>>>> I think you already said it, but NAK to adding any more compatibles here
> >>>>>>> until the soc-specific compatible that was asked for for the imx93 is
> >>>>>>> added.
> >>>>>>
> >>>>>> Is it okay for 'silvaco,i3c-target-imx93'?
> >>>
> >>> No, because imx93 is product of NXP, not Silvaco.
> >>>
> >>> You need regular SoC-block compatibles, just like we have for all other
> >>> snps, dwc and cdns.
> >>
> >> "nxp,imx93-svc-i3c-target" ? 
> > 
> > Could be, now please point me to patch adding such code to DTS. I would
> > like to see the real use case for it.
> 
> Probably I was not clear enough, so let's be more precise: I think you
> might have troubles pointing to such code, because it just does not
> exist. It is a bit contradicting to single hardware description, because
> you want to describe one hardware in two different ways, with two
> different compatibles.
> 
> Your commit msg is here empty - it says what  patch is does, which is
> obvious. Tells nothing about the hardware being described here, which
> does not help this discussion. This would need solving as well, but main
> point stays - don't add new compatibles for the same hardware, at least
> not without valid reason/explanation.

I can improve commt msg. It was similar PCI case (There are two work mode:
root complex and endpoint). So there are two kind compatible string for it.

If you think it is good for using two compatible string for two work mode
of the same hardware.

I can write git commit message like:

dt-bindings: i3c: svc: add compatible string nxp,imx93-svc-i3c-target

silvaco i3c controller is dual mode controller, which can work as master
and target mode. All clock, reg, irq are the same for both mode. Add
compatible string "nxp,imx93-svc-i3c-target" to let silivaco i3c
controller work as target mode.

Of course, alternate method to added a property "mode" to distingiush
master and target mode. but old "silvaco,i3c-master-v1" will actually work
as dual mode support. Driver structure will become complex.

Frank

> 
> Best regards,
> Krzysztof
> 

