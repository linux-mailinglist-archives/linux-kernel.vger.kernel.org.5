Return-Path: <linux-kernel+bounces-27740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D929882F51B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645601F24BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FA71CFBE;
	Tue, 16 Jan 2024 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DID37BQm"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2052.outbound.protection.outlook.com [40.107.15.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3717D1CF9A;
	Tue, 16 Jan 2024 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432406; cv=fail; b=eVMXRW7CL9zguLZwV592S3ipoLiKSiWFvGVABurOtyoNgyiocMBDGDObSRNg23fMugQABYedjrRG3oD2YUFAjWBz+r1g0ES7G0YMGNkN8viGLlJXMEnibEUaxGb2L3Wa6wb95BUMhNj/p0B8IH1vxAQC5JoROXziUKklhK6518U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432406; c=relaxed/simple;
	bh=qhQBUkm5l9Sx7jN/57Jm4ZWDSCSivya9vf539G66kU0=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=O/ihE5Wptpv0A4GsZlJY1WDEc60oYdzgu+493Q07B401clZdYwrlbZ1TjdXKwj6gUdcGGnY1l51pFVAvUFWGLap0wKU/W34Z90zcL+t2BnAxpnUx8t46SygtbI3jnyRFEDvO/neZTj6gvUrxK+Kg4qLZLi8ohpkAad7IIvXVXsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DID37BQm; arc=fail smtp.client-ip=40.107.15.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+Vc7BmQbVdibSP8SafHF1nLDrxFtUngKStm8wXtFKSZKefCA9mRQaeH5pHqmjWOZDfqqdeRNk4BkijTFa1fEFPc2Ba9gIYIoV4p0WxCtcqjHr1lc3GJ0Y59VusnnyzRrr6ZXz41TDoMPfM9DyuanJY7Fih0miqtzZL5fZCur6VQ+oZRqQ27AfOY2Ow/A1Xw7R4Ado4axwbupKO9DIlA6J/Ltsei12vuntCZlVoV1tF2YNbxl5JsDL5cS/T6KtVLj4PrvYCiFPzsv10FVMqyVOCnFDZAxUTIrNkTVSCy4FWkIPKALdWpt9Ux/Mkf7EJzBVgxQB5UjPIXV8UcpcgBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hscwQPnzanfawWUQ1idnOxTZif98tzG75FpjToKqGFU=;
 b=CKK8FkrmNFIKwci4h9O0d5j3t22vvo5qp3aSdO8HrezHZCy7Yx875r0vVUESUgV2ZLHeo5k0jZj4XWBKisKYsZbVwpEfHnQFLG2B0ayEBoyuY9MN42lHJuKrrLNzsv2VVcuW4F+81+4Avwc9bHMGYYFoKNLIDqHzeYaDlm8K+vSjUwyofAK+aP69xQE2f8zB4l4DmuQ5o+Nuh8VXTLlfkc3jyzs89IjKqiROUlgo0uUjwxraSbbFmYsIUugBa/HWEAEbAvlkZt/XJrWJ13uaq50ozQAZKaQFd5B9reT5Uuh8eikUv1/FANIbnW3c5iogX93uQaBd+XoWJmVsdVLXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hscwQPnzanfawWUQ1idnOxTZif98tzG75FpjToKqGFU=;
 b=DID37BQmvDnOVHrfHStex7hmsW4cVUwyiuO1MtDL5rmleXw6fxJer9p4KkWVQueAi0HE6j254bZ33VuqO3idEGOHSllKGhMhRYEQnDOlHqot6hrWc0eheS+HhwHlv/tn97DdcLjSyqUwtgrJfIYAqs43NZaB0RHJYkJCGjuujU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8187.eurprd04.prod.outlook.com (2603:10a6:10:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Tue, 16 Jan
 2024 19:13:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7181.019; Tue, 16 Jan 2024
 19:13:21 +0000
Date: Tue, 16 Jan 2024 14:13:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	robh@kernel.org, alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Message-ID: <ZabVSYgq1Mz3LPpC@lizhi-Precision-Tower-5810>
References: <ZaFjaWCA6k+tiCSJ@lizhi-Precision-Tower-5810>
 <ZaWLCrWJEMtFx8cR@lizhi-Precision-Tower-5810>
 <1b628901-7f71-4c97-9a16-723912988417@linaro.org>
 <ZaXqCoCHPWER94Hh@lizhi-Precision-Tower-5810>
 <d45e31c4-914e-4cea-a145-9775b6f516ab@linaro.org>
 <20240116-bleach-herbicide-48d636967134@wendy>
 <3199c245-3d2d-49e8-951e-2b059de4d683@linaro.org>
 <20240116-achiness-thievish-10a12b3c08cd@wendy>
 <Zaa+cLGVVDSB5MYr@lizhi-Precision-Tower-5810>
 <20240116-retract-conclude-c47a7fc8cb21@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-retract-conclude-c47a7fc8cb21@spud>
X-ClientProxiedBy: BYAPR07CA0097.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 2086281f-923a-4db1-887f-08dc16c73452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f/wI9WJ75p8eTuPqLE3vB2s+St5gNVkm9O14JqBfCazho7XKD8jil+S4QRj4zsGBU45k4ctgRbNnniBsraKtwF3mbUrUHU2IbGmgx7NDRZHHelWhZceWOWYGqEgj7sfgk0vZ55FVBJM9bAcQRAfQ08nthIvRqhZUUMQDeWULbMjsqLILV9jJubAKFUhiElkoKxm4OYc0DTpEPSQ3LUkxWkK2rDSKSGuQRcza2Awz1YkojwFbPJpCABsN3CHVLzX4gI+H0Gzf7LFfpxvHgYuHBeAVlFWPbon9NmwGZ1rctejEmLfdGOlve5P/jFV42IYY6pzW5OU0ZHE4GQEXWu7Y1CV89pYL8YLthXdU6NRWrIt2kY9yYBVoPpZ5vibVOJDruXPtsjZ0GbGOpr0gT0Pe0IQRTJm5LETpepEYT+uSkR4g/kUbRW9CEmydw5ti6zVWeVDREUEyy002ljmJXGulbJd/pqmNaGFFmqIfNeSGNBbZhPuUq3VfPE9A9jQbGcwhTelo//jRcGI4aWxJyETxBStPE9xYv/bJfpBiqGWo/F5FYojxdbIA9tp76Yru7owaPPOiMy2p+tc/3QCunk7Kc0HCmmuyCiwfMG3OCNqxu9g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6666004)(6512007)(6506007)(9686003)(26005)(52116002)(53546011)(38100700002)(86362001)(38350700005)(33716001)(41300700001)(4326008)(966005)(6486002)(2906002)(7416002)(83380400001)(5660300002)(316002)(478600001)(66946007)(6916009)(8936002)(8676002)(54906003)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SbOedI5yVPtztAK6fKo6U8DdtKtjXkckGZgRFcdgIbL+txTdI5DGqBSRtcpP?=
 =?us-ascii?Q?eJ5eOs59VI8pZ6F48lLUT/fY0bUZHq0YnJ6lSELffmX3Xzf0ggYpLI+AfUZO?=
 =?us-ascii?Q?U5IjPfDTb9Btya/bGXYNQhx8Nemt4NQGoD+z8K6PGqyXRf/sAcpNiQS0EdNN?=
 =?us-ascii?Q?zGVT3pAbFg7kTsWpGId3n0rUDvL/ivjquzur7cdUOsnL3NsdwvjNTC/Hn8DY?=
 =?us-ascii?Q?3f1CjZpEjrJlSzdGphskQNUALY9vfZLaPD3aio6wJaAto+IfVdqfZtHobCVj?=
 =?us-ascii?Q?6RHNEBnMUGtHatn4ooWmPY5jyXwOcCcLvY/7xBY8pxxYHrhwEqDSfXk4WVUu?=
 =?us-ascii?Q?M0JfYH/stbgcxpePpI6o6HVJr5dj6vmdq/VdAC0AAzpMC3fzudS4DDZ91gjt?=
 =?us-ascii?Q?i1C7YsBdGMPhPz2nD0yVQB6X7j917IpihlrraMaTzUzDGGg75U16DjGmsPFs?=
 =?us-ascii?Q?bPCr165KykU9f8AckMD/zZkrijDqp6mjNVBkk5W2FpZRxMFCMvXT8zDiHRbu?=
 =?us-ascii?Q?YF3QrEGy0nAFnzVe8UMrz3FLrC5gLrTJPPU8DBX02J1KLPNQh5ZgxsuWqP89?=
 =?us-ascii?Q?QvnlW4OrWiZQvs8qGIphpO0+V1QJHcizbXMUa+oZkEvbNcnqDGxX0p27kNrw?=
 =?us-ascii?Q?T1VLR61Xas709kLCLDK+DArEtSZgOSKw45syvAkFGVMSlvcUKvrJZLMYlZDm?=
 =?us-ascii?Q?vkuwV14P1oyJujD72jJ+8vxfQztO12fCdbsgI8YWOb6MJSSQ6flqYwZ6LVum?=
 =?us-ascii?Q?z378PDp3Fvy0aw0WIPNz5Tcgk2jjhdMd7zVsgQA/F8Sp7KKrReoxB2QZucnZ?=
 =?us-ascii?Q?nWSmCCqfXk0nBA/6I/UW9A7SBMYLWD8B53yic0drHANFiGsrqc0FB+qAN3Dt?=
 =?us-ascii?Q?R/qmaFrYOziiveMimvOOgO1b5NFndNYOJiyVTykJGgUoNT8Vgkn3JnEASTK3?=
 =?us-ascii?Q?SUD9gJPux3a3d+TtrRMsa5Gb1WYQbLlnZC9INnNtB7GUT8RKscc+534uf09z?=
 =?us-ascii?Q?j4ENLdoJYAWQRmukYgb+jaSCrFt94Z4OwCeEtE4rV7CxJz1QF+p+4qnWQ0pq?=
 =?us-ascii?Q?FrJvvazHA5SlTAthoumV2wnMof5ovySP4la7DCFRum4lzkzKtrxTe1JU5IdV?=
 =?us-ascii?Q?H3SYVI3B1GcctErfgHnj8Y6H3b3JH0YgKgnMawthbEBR3b+YkUnJb/ScB66H?=
 =?us-ascii?Q?+1jY2SiDWw/zgC5OmHlo0q6jTP3eH5/+ln/FA2q72gMI6+6PGgB1gRm9LynD?=
 =?us-ascii?Q?5aXueNANUA9ekm4PprCzSSvcpKWhbJoBEmnNa77EmvH+qF2hzkiZs2/s50Fc?=
 =?us-ascii?Q?MM0JKTY+8p/vATAMAX+gmnhykYXlhnHsu5wHU1qZkOEXXu/u9oYL0WF/pfi1?=
 =?us-ascii?Q?U0iJol8vLfe61Wd8eNN+0Gpri7e9VTlQmFoWcxJS5+iUqkoTohSGLnjxpNra?=
 =?us-ascii?Q?+VGBKRKadi8jwMD08pD5FhTythZd3dE20+IaFWar82ZLxyjJhTdax3s7jY/2?=
 =?us-ascii?Q?vQSE2C6tQGHpF4UW9tE3+dcw/R/S3CdXfFemU8oKz6+wtjMN8UBAnDp3u+sl?=
 =?us-ascii?Q?blzTXZtZhQtv8OME1ZU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2086281f-923a-4db1-887f-08dc16c73452
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 19:13:21.3572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVhymfpk3XwGFObXtcdi94/E30j6ZNI3IgX0NsXIBC6lHBxNWpyJgim2TBqHXUGvdDDtBbwMxnPXryMiWcH9mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8187

On Tue, Jan 16, 2024 at 06:23:09PM +0000, Conor Dooley wrote:
> On Tue, Jan 16, 2024 at 12:35:44PM -0500, Frank Li wrote:
> > On Tue, Jan 16, 2024 at 09:48:08AM +0000, Conor Dooley wrote:
> > > On Tue, Jan 16, 2024 at 10:33:48AM +0100, Krzysztof Kozlowski wrote:
> > > > On 16/01/2024 10:30, Conor Dooley wrote:
> > > > > On Tue, Jan 16, 2024 at 08:24:20AM +0100, Krzysztof Kozlowski wrote:
> > > > >> On 16/01/2024 03:29, Frank Li wrote:
> > > > >>>>> 	Patches were accepted after discussion, what you ponit to. So I
> > > > >>>>> think everyone agree on the name 'silvaco,i3c-master-v1'.
> > > > >>>>> 	I plan send next version to fix auto build error. Any additional
> > > > >>>>> comments about this?
> > > > >>>>
> > > > >>>> I still do not see how did you address Rob's comment and his point is
> > > > >>>> valid. You just did not reply to it.
> > > > >>>
> > > > >>> See https://lore.kernel.org/imx/ZXCiaKfMYYShoiXK@lizhi-Precision-Tower-5810/
> > > > >>
> > > > >> First of all, that's not the answer to Rob's email, but some other
> > > > >> thread which is 99% ignored by Rob (unless he has filters for
> > > > >> "@Rob"...). Therefore no, it does not count as valid answer.
> > > > >>
> > > > >> Second, explanation does not make sense. There is no argument granting
> > > > >> you exception from SoC specific compatibles.
> > > > > 
> > > > > The patch could have been applied two months ago had Frank done as
> > > > > was requested (multiple times). I don't understand the resistance
> > > > > towards doing so given the process has taken way way longer as a result.
> > > > 
> > > > I think that Rob's comment was just skipped and original master binding
> > > > was merged without addressing it. I don't want to repeat the same
> > > > process for the "target". Indeed I could point this earlier... if I only
> > > > knew that Rob pointed out that issue.
> > > 
> > > Oh I think I got confused here. The context for this mail led me to
> > > think that this was still trying to push the i3c-master-v1 stuff through
> > > and I was commenting on my frustration with the resistance to applying
> > > the feedback received. I didn't realise that this was for another
> > > patch adding a target.
> > > 
> > > I think you already said it, but NAK to adding any more compatibles here
> > > until the soc-specific compatible that was asked for for the imx93 is
> > > added.
> > 
> > Is it okay for 'silvaco,i3c-target-imx93'?
> 
> I don't know. Is the device in question capable of also operating in
> master mode? I have no idea from the commit message since it contains
> zero information on the hardware.

Yes, it is dual mode controller.

> If the exact same controller can operate in master and target mode,
> having two compatibles for the same device does not seem okay to me.
> 

what's your suggestion? create a total new yaml file for target mode (like
PCI ep)?
All target information(interrupt, reg, clock) are the same as master.

Or added "mode" property instead of using difference compatible string?
It may cause kconfig become complex to handle difference mode at the same
drivers.

> Also, "silvaco" does not make the imx93 so that is not a suitable vendor
> prefix. If the imx93 only supports i3c IPs in target mode, I would call
> it "<vendorofimx>,imx93-i3c" with "silvaco,i3c-target-v1" as a fallback.
> 

Look like Rob and krysztof don't likes 'silvaco,i3c-target-v1'. 

> Thanks,
> Conor.



