Return-Path: <linux-kernel+bounces-26928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E01F82E7ED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 03:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754A3B22998
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A883C611F;
	Tue, 16 Jan 2024 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TiQMnuhi"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9619617CE;
	Tue, 16 Jan 2024 02:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR9AcPCIctv+iZt1i38qPPFK4JDkIgnMeEE4x7soo9Cr+HxVFvTkB4e71AyUNj5GqlvdbslYQFzeLMb1bi26v1pbA9///ri/wwoPc6dkH7ttChLnZQ3wFWZpfTYRTsNWetCCNEhVNcGcqhbeI4ljsiaU0LJxM+8Wl4utKKeHpO1rPIc7UB7Ed12no0fUlyzkILqMufOQk1jX1wwPGJnG4VHabEMYjdMdfuCR736GlmukSVbKLxqGnXvCHZJeMNRzg+9khtFC43gFPuuW0bxh8BJfn4j6cNYC315gRL41b/OdXQHqv3ycBEaTpQIczH7FJ/AJ4MU081jcy+pyHg1LZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jX4jC3/9yQ8Wxw87AzPi7eoXKdbsFWIv1tY7l2ILugY=;
 b=JTiNKZdsoBfRNVENBR0h5C1UmFUrjz/0nOcS5CFdqkcCi4b9/dC6mG8zgH0xVqozaItTIc1IFT/xg6jee64WrfPwEUm9IlUoU8m6myv1E8X75FXqCg+o5JrImkL3Lo9KBqYYbOKxSwf74wgStYzMPsiKmjbKTg1ODt14nbXdFPkBWj5J7b5bC5F65FYOdRBOwCrw+yRL7TGsHvhaWbt3galA5sLMEn0a+UfVPoUpA09XbM8e03q+8AhJESbN6oQvGDUNWa71xw8XySpxniXIevceoJqgvHVWD/D3LgpIGdPcIGBcCS+d7RblISqXi2mBXpTgt9/hFpzAg910JTLpiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jX4jC3/9yQ8Wxw87AzPi7eoXKdbsFWIv1tY7l2ILugY=;
 b=TiQMnuhiNC0iXUJTKYxohJeux+tkAgB1Dmig2LAUEQOArsvTxiZMrKvbE59jdCe7tHPCPPdbq1WbTGqjgFciDyV/uzqvTpqXPFckZ2OGG+2DgtxGeEZIVXpTqoAerElEnl9v81MJe5YX3xDUrYyjqEcQh5RDibzF5kmhdP4QD/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9418.eurprd04.prod.outlook.com (2603:10a6:10:359::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 02:29:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7181.019; Tue, 16 Jan 2024
 02:29:38 +0000
Date: Mon, 15 Jan 2024 21:29:30 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: robh@kernel.org, alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 2/7] dt-bindings: i3c: svc: add compatible string i3c:
 silvaco,i3c-target-v1
Message-ID: <ZaXqCoCHPWER94Hh@lizhi-Precision-Tower-5810>
References: <20240110175221.2335480-1-Frank.Li@nxp.com>
 <20240110175221.2335480-3-Frank.Li@nxp.com>
 <3c0be658-e7a6-4231-b206-86ffb47e0cb2@linaro.org>
 <ZaFbbeQrC7o2dchO@lizhi-Precision-Tower-5810>
 <e3b9aa63-25a5-41cc-9eb7-6e7d1eacb136@linaro.org>
 <ZaFjaWCA6k+tiCSJ@lizhi-Precision-Tower-5810>
 <ZaWLCrWJEMtFx8cR@lizhi-Precision-Tower-5810>
 <1b628901-7f71-4c97-9a16-723912988417@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b628901-7f71-4c97-9a16-723912988417@linaro.org>
X-ClientProxiedBy: BYAPR07CA0058.namprd07.prod.outlook.com
 (2603:10b6:a03:60::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 7936bdae-6a03-4e5d-5b14-08dc163afcc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K4eBhh84ce673aJX4B3SM6lE06Fs7GuAeHh8hRD3euBxSYx35OA6WiQJCBMIZMPBABsqz7ayzt0iRE/Eup6YMnyOLw0+6eGdm+a3ZXYGa8MiulexSJnqLvMC3RIgeVYp+dZO/2yVf6CvYVZ4bm+AMjf+bUylrztI+qe3S4JMUF7H7KenmEv7Oc+zHuLfZ2eRqcms3QbsqpLdkzit0yxRNnMoR67VWDRhsXMmIOvtuU0AxLE5xlt2CgmC3FtX9iw0PbeAD8TcJgIA6fvmakc2jKeArB58wtdU/cEIa/Uwcb7LcVlOo2yv65JVhQLrBMiWxkF07jmvGz7BLIqtnrPCxoSUTulG/3KOKTbH9dK+uXP7vdzohwPVzeEA3jQ2B2vDkVILlt33XuALTcpjMi758hF0BqMXN+bmtZgj9Yq3vRTb349DASWkTf9/38CXfS+sNHuNgqrwxlDqto+FaK5jt1CfErlmPJ19PUZ0EoyPu+sS1UB/lylY6a9VqpFNNx9k9i0y3U+rdxxpiEJMTAgLkLaLIuezPETDWdCBYmOCeN0WuaV+4RF8pYe0DJn4XTJ290TyzLJQb4QNQ1X9kB/1S6cHd716krt1AgFnHGQWVg4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(366004)(346002)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(53546011)(26005)(9686003)(52116002)(6666004)(6512007)(86362001)(38350700005)(38100700002)(4326008)(5660300002)(7416002)(66946007)(66556008)(6506007)(6916009)(8676002)(316002)(8936002)(66476007)(2906002)(478600001)(6486002)(41300700001)(966005)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v+dg8t4Kze0OtPR/n4PnPnCmSJUMeQirDgNtouUMpJY0Lc5Jru/ok7/fa44V?=
 =?us-ascii?Q?/xujYBNXWKU6Y/nIBkKirCENFW+Z56GhvlKfifScFGOekpc1YMsgvJ54C8F9?=
 =?us-ascii?Q?2ZoT7SPN9SbUo3GlFXxhJvUNxQsUUczmjR3Cj2vPrDDO61QmsHDlOkf9bSW6?=
 =?us-ascii?Q?GNAb5vaZSQMEk3EVIh+JbjLYnavHwbbmqi8S2qNHSOMkFpwQZ3cmUPkA2YRB?=
 =?us-ascii?Q?X+QmcuEnI2DfUuVMWQ7ILpfC7d6kBh0qA5z2vrj4TaCjAIwUAzPjfrE36j6o?=
 =?us-ascii?Q?4O8CxGOCklTINa4X6OcZHEc1WaDrQaSqNC0VLKmLVEAipPG9qHDFysuimwbP?=
 =?us-ascii?Q?iLcKc+WpbIr/EYjboj3wlV/NLq4TU8jFCweYDMW+WDraLnXGsdMnJXOui3Ix?=
 =?us-ascii?Q?SGZDGZFZz/6DRQtRZsk99Df5wGl8ZpsXkocVOhYUvgzcozWbxJppTEGXf4tF?=
 =?us-ascii?Q?fpG5e9hyhAXB6dgeDO+qkV2Vl/JJyIGI5CxN58FfD0bVog84QaBwAbwQIDuv?=
 =?us-ascii?Q?YUVRHMKSrz/EZ+CsnDnC1MSY5513gUc2Q3lzSz0c+3eM9tVj8wuDAnpEJltQ?=
 =?us-ascii?Q?9zRmgfSQcaO1KF16dYupXBQaHS4+BAzkK1utrKtubFXdmk2ctESxX2IWP6um?=
 =?us-ascii?Q?qDKG6BDx2PraDzcL5Edq5Rmf+IsVwwnq32WViVVqkVQx3R5aOd1CILl99BZg?=
 =?us-ascii?Q?2UQK6yTPXLlFc02okyI7MgwVru9Xy4moFZqGMi4EO9JQ3BOcv+07Y9VbqaWc?=
 =?us-ascii?Q?ehLVLST62kxlnPGOSfq+oT9TNZmSCw3SYKxIrCnTKmemOe5vuTeb43NbFKvr?=
 =?us-ascii?Q?SZVvom9kQEKTndQ+6S0i41Pe4WXtqMP37mWo4jOVmZwLRpwX7RMXAKAVZfTt?=
 =?us-ascii?Q?tpG0wnqs3J9kt12BpLU4akgWTxxKaX06b+CHFR+MwfeSQOaQsXla4RwzybHQ?=
 =?us-ascii?Q?2XJD8mM4TPTOqxudFXNEF/iJxcdMVP9A2tOS7l00eUOH5jv/x/7kQx5jOqpk?=
 =?us-ascii?Q?0BQ5LWuw4+uIFJPAYNK8jxDxZR6S1u7EGE/dXlBLV47LW0PgF3thSfnz3zvh?=
 =?us-ascii?Q?qjOPeWS4b3u7kCjx6A0zYzK2HrpazFks/MbOLpFzo/3gROo2VoxtT0RhhOQ2?=
 =?us-ascii?Q?LtPfAr2E+2zTAxqoXYpNXTTLrpQsG1tpflMSHzQ2bYed2bERnSeO0mI6qVYI?=
 =?us-ascii?Q?rsS3hH0O9WrufLn3CJTOtX4sXVLVB6GYZoAHjEr+YIUzp+wHfQ5fltaP7isV?=
 =?us-ascii?Q?VTA5K7R3VW/R6eczAj9yNN/WXhJ3YoEiYes4XIyJc+a1f93njbcJ0pIJZ5G3?=
 =?us-ascii?Q?cpJoB1eq1SWdjFEnl5QcRfKxp5RF3EFa74VtyowEIXtsi9fV7S1GvweX6v1j?=
 =?us-ascii?Q?JztNYAGJGoze5VqhcjqyUPHsP79bGRSlvlKzA3no1pb1D16g7GlqcxheIzmP?=
 =?us-ascii?Q?ni9XvEAqBAA/q5jPKNz1HDzYhUdaxYdF3n9RGM8Fnzdhuu/fd6iRzGmm6E1s?=
 =?us-ascii?Q?2X04ZVRfhRhUG7ACDubsRqTDJxA0fEnxL7eOex/eEW3kZNcJFonBQ0mz+vrJ?=
 =?us-ascii?Q?yFwbVoiC4UHXAyNSPIA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7936bdae-6a03-4e5d-5b14-08dc163afcc6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 02:29:38.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxwbgTsNmMvOxZh2gGrSvCYynThZfPSyd7XQjPvPv4EfGDc775MQm5MxXC2DEJLWU5BYdNtHZEicgREvYkvpTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9418

On Mon, Jan 15, 2024 at 09:38:19PM +0100, Krzysztof Kozlowski wrote:
> On 15/01/2024 20:44, Frank Li wrote:
> > On Fri, Jan 12, 2024 at 11:06:01AM -0500, Frank Li wrote:
> >> On Fri, Jan 12, 2024 at 04:50:25PM +0100, Krzysztof Kozlowski wrote:
> >>> On 12/01/2024 16:31, Frank Li wrote:
> >>>> I review previous comments. The previous RFC patches and I just want I3C
> >>>> expert review to check if there are comments about whole software
> >>>> architecture. Of course, thank you for your comments about "slave".
> >>>>
> >>>> Go back this binding doc problem. 
> >>>>
> >>>>   "No, it's the same device.
> >>>>
> >>>>    Anyway, this was not tested.
> >>>>
> >>>>    Please use scripts/get_maintainers.pl to get a list of necessary people
> >>>>    and lists to CC. It might happen, that command when run on an older
> >>>>    kernel, gives you outdated entries. Therefore please be sure you base
> >>>>    your patches on recent Linux kernel.
> >>>>
> >>>>    You missed at least devicetree list (maybe more), so this won't be
> >>>>    tested by automated tooling. Performing review on untested code might be
> >>>>    a waste of time, thus I will skip this patch entirely till you follow
> >>>>    the process allowing the patch to be tested.
> >>>>
> >>>>    Please kindly resend and include all necessary To/Cc entries.
> >>>>    "
> >>>>
> >>>> It is the same devices, work at difference mode (master  and target).
> >>>> what's do you want to change to?
> >>>>
> >>>> Copy to new file like pci/pci-ep? all context is the same, except for
> >>>> compatible string. 
> >>>>
> >>>
> >>> Apologies, I mixed up a bit patches, so this was not obvious. I meant
> >>> this comment:
> >>>
> >>> https://lore.kernel.org/all/20231017201404.GA2570433-robh@kernel.org/
> >>>
> >>> There is no indication in your commit msg that these concerns were
> >>> addressed.
> >>
> >> Look like everyone already accecpted 'silvaco,i3c-master-v1'.
> >>
> >> driver part:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8911eae9c8a947e5c1cc4fcce40473f1f5e475cd
> >> dts part:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b8ec0f3b42a3498d5115d1fb1490082ab525747b
> > 
> > @Krzysztof:
> > 	Patches were accepted after discussion, what you ponit to. So I
> > think everyone agree on the name 'silvaco,i3c-master-v1'.
> > 	I plan send next version to fix auto build error. Any additional
> > comments about this?
> 
> I still do not see how did you address Rob's comment and his point is
> valid. You just did not reply to it.

See https://lore.kernel.org/imx/ZXCiaKfMYYShoiXK@lizhi-Precision-Tower-5810/

Frank

> 
> Best regards,
> Krzysztof
> 

