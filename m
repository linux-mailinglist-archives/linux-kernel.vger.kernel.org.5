Return-Path: <linux-kernel+bounces-28266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0D782FC47
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA89628FD33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3E950A70;
	Tue, 16 Jan 2024 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OV8rnlUk"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2055.outbound.protection.outlook.com [40.107.14.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98A7250E9;
	Tue, 16 Jan 2024 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437907; cv=fail; b=GpblYVx+C+LpyZC5NAbrqKjBFacghI9HtpRdaAeFUIzW+DMy1VGXJHQvKgn5xhqO5oEgbBkQvZFRGl6Bl4/9x+UiIBaqTM/2Vo0a/ceHREuys1Alp5NKEGFFy7lsYDnoMyAtys2isgaIQEFIEgp6fCWCzDOXkKiXKZYmCTFNOt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437907; c=relaxed/simple;
	bh=bJus85IRwPrO76/hoB9/u/FudUDp05L2vq5quo7tVAM=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=V931umpbfFb3ZepSKwnlqceKr/J6UTg2vYGuy9QyoSsLh0KFaJtm8zdjZS7Mv63EGcdvc1E+KceqZpoPq4GEGy5mRKgwEpK21Xin1+tTu7UbH8/fKdqnbNbvg/ZLoKeOyKtJvyEASOUbDmuMvZhmJJV7dQ3babCdLofDeqZw6ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OV8rnlUk; arc=fail smtp.client-ip=40.107.14.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtQxl7C2V6Xe11+SM13mt2fDNekCrxadjxwjCKk7Y6qr2qpQjmZb49/paZNU3SJgh/S6fvysRkZ8BSdTOEwydxUHJyb5RSfdV8b2rWzl83i7GdHknTXoOrx1KI52ZbsDqvmZB63qv0Hj8acNKa5zFIb3XwqieMtAqb60Sb8+kflzOvYf8cEYXHPBC+yHuYUhb44JM4D9bl9O8rtM+AU08T9leDOGXAodd6OEAI9ySyxt/nyKI7ndqgJdDolWteSmL4pbzdfRHlI/acc8qX5iXmcrKHZtX51u5vQiSPF7Jekz1LKjDsa8BmuMr9OWLrGQou+vNmW5DTemv4+1fwA94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lPWHhuIF1TLWWTV4K5IOmdjEOM+kBlZKMLeQFWYFhI=;
 b=IDObZhJ7aIBtjcEBgxrZzcDKA+YmfJrSCa65sCebnnoKZ/tHLFhkXxX9LdxcOstjmhf0sI6q59h4yEhQaZn3L0Kdv95gIdLmalcrttBOjrAZ1IQSzZHwn7wY2LOqzTJbctR7zrzdCq59sOXDwXAdI8HKp4JF/KZBy9vnilAp0Vb4Ed7mhRYfKnr3tRRjGUVCpgobQ416Ukl5OwrtuoConyzla/CWY8WYQQr4bCE5Z9lj2hko1NJ9GTNTF25K7ugajtiuVVoYM1oJzwnpThLbaHpZeSXPakdTAZKWSko76cCHA69HdFoqmm7ktb0GtMqVTpWaBwr4HrDlp/Y6lt2Sxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lPWHhuIF1TLWWTV4K5IOmdjEOM+kBlZKMLeQFWYFhI=;
 b=OV8rnlUk6IJjlFAK8hB0UjLk40pAf6EKJZw10yrT0ibTkVVatZAen8J+Vu3GHU9+FusMp2/vigzUi2eyrtXTtPt0i5+GPRwwfG98WYEQRQ01M2zJ/yZwNu1BD2LDIUkH500/Zb7TgcjvDT5uLRINUBN6Lnna5Cay20fQ5zMWfcU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8615.eurprd04.prod.outlook.com (2603:10a6:10:2da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 20:45:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Tue, 16 Jan 2024
 20:45:02 +0000
Date: Tue, 16 Jan 2024 15:44:52 -0500
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
Message-ID: <ZabqxHD4wtiPn6ep@lizhi-Precision-Tower-5810>
References: <1b628901-7f71-4c97-9a16-723912988417@linaro.org>
 <ZaXqCoCHPWER94Hh@lizhi-Precision-Tower-5810>
 <d45e31c4-914e-4cea-a145-9775b6f516ab@linaro.org>
 <20240116-bleach-herbicide-48d636967134@wendy>
 <3199c245-3d2d-49e8-951e-2b059de4d683@linaro.org>
 <20240116-achiness-thievish-10a12b3c08cd@wendy>
 <Zaa+cLGVVDSB5MYr@lizhi-Precision-Tower-5810>
 <20240116-retract-conclude-c47a7fc8cb21@spud>
 <ZabVSYgq1Mz3LPpC@lizhi-Precision-Tower-5810>
 <4a9ed1ca-cd13-4b61-af06-a3d7935aeeee@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a9ed1ca-cd13-4b61-af06-a3d7935aeeee@linaro.org>
X-ClientProxiedBy: BYAPR07CA0077.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: edcced84-767a-45c2-935e-08dc16d4033d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gsWuUWc7ftvlcZTY7NZM58ND/xbKurixHj4PVA2eZDUp2UWOc/9HAymsamhVZKOvThYL8syTQq3u9lsGOBwifC6f6ac55G9q55TtMfqb2CmYvrI2YEsIbWcrFRJA2E92Dua03HF9zrFwfROsBMaKVfdYBW4hneqH16+Uqw3HLtdBhVA6nz64SFpzTnmybEQVQNNzyGwUO47C47hjTqmYo+MJfLjHqZ2xqNKEUa34sw4XoYWAt64Hz6mXE9kjOQiT5L3GF7Zi3Nx1KqW88MLl4/0IR6XN3iHgpT3o5gru0I8EhkOQa8MXU5B0365EfIndn4YJ8qmoCm7zOvj+fGxpOa64Qq8afIvUZf037dv1w+PbzrShp4FuC4cvDoi6x4DMww/iQdabjC9lA88YrDp3EfomyP2TNSZJIPP94Bs1ZQ1b8akMFysjwXZ4gVAI3eOHOrqyK0etPSRVQyu+bMTRncLTmm56P6x97sWt3SwCZSUSPR+/I/tDEcEm6cjz4YwAuoNDbygKX7hlnTSDdCp+XqHHlx9EPpraFcU5pOJGSQQjIpIwYGZHJ222zf7dwT9jq8vX7lKhWsZonnfsP35fiEfL1oGnvnIY2tzUUZldUMI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(396003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6506007)(6512007)(9686003)(26005)(52116002)(53546011)(6666004)(38100700002)(86362001)(38350700005)(33716001)(41300700001)(4326008)(2906002)(478600001)(8676002)(6486002)(5660300002)(83380400001)(7416002)(966005)(66476007)(8936002)(316002)(66556008)(54906003)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BDbW1XNKzOztJoi0YLoz70MToet35gJwf9oPCG2a+atkZ08gPTZfNjgXCtCf?=
 =?us-ascii?Q?iQ3Ct/k9IrejKgEDvbkwsM7qJgv6p6KaN658BpgCQBSZ5WLteEOatksfxshL?=
 =?us-ascii?Q?RvyTxfQ0KP9E+aSYmXH3eshCKn6cNreN3asthaZ/ZxBynzTYr4+NKY1XUjUO?=
 =?us-ascii?Q?+UxsDfuuJTmR81CkgC6sWT819ubS/QUxV/vOPlL0qaqsiu6yM19MWk0rnf1c?=
 =?us-ascii?Q?P85riGT7O3L0eTBmFH5dBVYoZ2LbwUyuUI/Q99lbdrYTJd3+Qz/T7F/1BmX2?=
 =?us-ascii?Q?FPrsk/B0bVUkBdBRfm131lTCILaS2d2BBb9UjYHr8TFqPy/+hXcThUnRBLFg?=
 =?us-ascii?Q?Qbf4hj1nebnqwxL39GCTvoWypZCJvnTplFJchOScV2Zw227fjJpIHijmQuCU?=
 =?us-ascii?Q?dLa6rgGPwz8p9zbhaWDjvvu+j+x0iEI0rAuxX9d+h3UJ4bwtR9cECF4EbgUs?=
 =?us-ascii?Q?IYMS1AX36RoxZ1YiaQINbeIUgZQBmglveC6YoxNXSqH59qFnGYdUJi1xfkNC?=
 =?us-ascii?Q?3OcdAE5QTYRAfxj2zPVPcxdeogqzVKOpgbvFBRfhIOB502hwxMvi5J1GluVU?=
 =?us-ascii?Q?ajkEmcinl0F3yqK+nyD3kZiuOxEWB81+QC3ERhOoX2JAUIxgQAXEj+f5DSor?=
 =?us-ascii?Q?vX7EYvEkhoDXEo2VmzqK1/nhCcTUSxBq6wtMCEV/L/aXmUjgkESulRl1Dndk?=
 =?us-ascii?Q?+vEr/bwoh+1JDnnG7yfQe1U7SfyRlxQxKaGjw6nF9uUguRhwCX4ba39ugR/G?=
 =?us-ascii?Q?GeKk1VRjWV4a0J/bWVkYZuwjPqbH6OLrA8hczV917y+HIAWryHXmI0xYDCKB?=
 =?us-ascii?Q?FCSBaVfmmR5VKoT2Ko9EfP+pt3T7DBWlwfp8Yfy4e+IhM+/8JWpw+Dc3AR0w?=
 =?us-ascii?Q?lwAbnKLr16KDuVWcZdCI0tt7xIBkVwdFqWEorbuMcgLBZWoeviyleywmdhE2?=
 =?us-ascii?Q?e/SwZtqRuhJzIiIObLnpKyAx19p1vrAHiY3Qx8oQnQH4vvoFen4a2gsnNcqJ?=
 =?us-ascii?Q?syU0g5gYiXS/m8rfwc4a5O37C8P41Mb9uL7Fc14R8PAK0V98F8hnE2baS8M2?=
 =?us-ascii?Q?/JlvmVmpKxoTEgNpZaMp3h4y9Et0V6y7EOCeq1C7HigUjGRQpcOOUgMZBvpo?=
 =?us-ascii?Q?Szn6nzqWk+R8pAQPZPBU3avaDxZWLLP3Z9dfy8E+YSuvDmb1vOEX6S77tRFh?=
 =?us-ascii?Q?Rf+ufW1TOXp9u6mTgbyTRgvkdk9lizir6koUe5OF95faV+CNNkigZ7CmBn1B?=
 =?us-ascii?Q?Fp2pX4o9kkpIFUrnXrgjBQf6Q47JUosr56YappXhyxIh4iAPSpHMDFI2hmVg?=
 =?us-ascii?Q?Imb+mqI9i4VWphtxadaB2Rug6oa5aVYHFSTVHDBs86ivl+8mSSgk5KtpROGW?=
 =?us-ascii?Q?eQRl1SUVcmjKxZsFN+fA29IHpgdOfnP+dY/tSAG+WBNWJvgrmHeZEchdrsN/?=
 =?us-ascii?Q?k/z7/zGGDsaymInBlukK8Mj4XsbyMY5SEIMmeZ/l8NZ2kzcNJipl62nXX158?=
 =?us-ascii?Q?x00h/2Am/vQdH8JAVpZYEcYD3TFiXx/KP4YaxZogwfH2W0bTj5VR0QO8tubT?=
 =?us-ascii?Q?0LVphZnYJMR+duqAKsk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edcced84-767a-45c2-935e-08dc16d4033d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 20:45:02.4503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6V4LPcCE0tX5rUD42eDvxnf3PK74NDz4DeOVSBWeE40J3rYAs/5IsjFcnp4IMWPsorR/n3JMIyGE4gykupfWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8615

On Tue, Jan 16, 2024 at 09:30:24PM +0100, Krzysztof Kozlowski wrote:
> On 16/01/2024 20:13, Frank Li wrote:
> > On Tue, Jan 16, 2024 at 06:23:09PM +0000, Conor Dooley wrote:
> >> On Tue, Jan 16, 2024 at 12:35:44PM -0500, Frank Li wrote:
> >>> On Tue, Jan 16, 2024 at 09:48:08AM +0000, Conor Dooley wrote:
> >>>> On Tue, Jan 16, 2024 at 10:33:48AM +0100, Krzysztof Kozlowski wrote:
> >>>>> On 16/01/2024 10:30, Conor Dooley wrote:
> >>>>>> On Tue, Jan 16, 2024 at 08:24:20AM +0100, Krzysztof Kozlowski wrote:
> >>>>>>> On 16/01/2024 03:29, Frank Li wrote:
> >>>>>>>>>> 	Patches were accepted after discussion, what you ponit to. So I
> >>>>>>>>>> think everyone agree on the name 'silvaco,i3c-master-v1'.
> >>>>>>>>>> 	I plan send next version to fix auto build error. Any additional
> >>>>>>>>>> comments about this?
> >>>>>>>>>
> >>>>>>>>> I still do not see how did you address Rob's comment and his point is
> >>>>>>>>> valid. You just did not reply to it.
> >>>>>>>>
> >>>>>>>> See https://lore.kernel.org/imx/ZXCiaKfMYYShoiXK@lizhi-Precision-Tower-5810/
> >>>>>>>
> >>>>>>> First of all, that's not the answer to Rob's email, but some other
> >>>>>>> thread which is 99% ignored by Rob (unless he has filters for
> >>>>>>> "@Rob"...). Therefore no, it does not count as valid answer.
> >>>>>>>
> >>>>>>> Second, explanation does not make sense. There is no argument granting
> >>>>>>> you exception from SoC specific compatibles.
> >>>>>>
> >>>>>> The patch could have been applied two months ago had Frank done as
> >>>>>> was requested (multiple times). I don't understand the resistance
> >>>>>> towards doing so given the process has taken way way longer as a result.
> >>>>>
> >>>>> I think that Rob's comment was just skipped and original master binding
> >>>>> was merged without addressing it. I don't want to repeat the same
> >>>>> process for the "target". Indeed I could point this earlier... if I only
> >>>>> knew that Rob pointed out that issue.
> >>>>
> >>>> Oh I think I got confused here. The context for this mail led me to
> >>>> think that this was still trying to push the i3c-master-v1 stuff through
> >>>> and I was commenting on my frustration with the resistance to applying
> >>>> the feedback received. I didn't realise that this was for another
> >>>> patch adding a target.
> >>>>
> >>>> I think you already said it, but NAK to adding any more compatibles here
> >>>> until the soc-specific compatible that was asked for for the imx93 is
> >>>> added.
> >>>
> >>> Is it okay for 'silvaco,i3c-target-imx93'?
> 
> No, because imx93 is product of NXP, not Silvaco.
> 
> You need regular SoC-block compatibles, just like we have for all other
> snps, dwc and cdns.

"nxp,imx93-svc-i3c-target" ? Just little bit strange for binding file name
is silvaco,i3c-master.yaml.

look like "dwc,*" compatitble string's file name is "dwc,*".yaml.

Frank
> 
> 
> Best regards,
> Krzysztof
> 

