Return-Path: <linux-kernel+bounces-24841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F2782C34D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8ACB22CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3B5745D2;
	Fri, 12 Jan 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YniVJPz9"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F73745C9;
	Fri, 12 Jan 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1AcOrcdnhJnEOHWzvrYEINik/rgCIOgNqB7uFZSM9H8BA/+nHJ//naIc+iaWVSJEWJl2EgoJ7FED5sEuG/7+hQDxTKChyWe7uemR92yEsyGB6nBNVfI7CWqjetnz8he/Ee4rUiImh72jmqOD6pRtJPLXdrfqK+y2kCW7eybQPucHu4nUYiIqug+us/FaooqdyAY1NeZgjjZ1TPWkFp9s0BPS7rdp5A1UV27oxlPXD/YFtqZQa+30etNAT98V+9V1avckTjEHzCfmwZ8FEcxbae1QFVBQiKBVQ/tz07teZ2sraYJ7lspPbMfftowQiJPzZi3u2afELQREU64lmgC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToZ//M+yE0nKT/UHK5mKKvur7YTn80QnF6gMgFTlDlI=;
 b=JS+hnkNW9HJV2jsFWEUjgDrMv1LZ18xVr/ZPBG1HOhAB/kI99G6MiJN5Wcp6gYM3wwTrsFI/GKKO3i7gSbcsYg5X+IyU6a2UvxsgjgGp1p9cYme8iBdl3ClM75hBn1F7XabSw0ts29YPjknUWXyCc2HKJ9LG5TN4/UQ0C9F3FHIxl/sH4vXrbAS60u3EKE62kJ/PckuiDJ20G2t/e3MftDYtITDSG2u2LiFbdYGgp9Wx0p2mOmTlCaWbVUXaAludUOwQ2TM/j2sna7mYWJBgZ1QBM6wTv9mSP6n0BzCGLtVhbjWnRoS/y9f7SEwjMhJhFqOrs7CWKFGOzqSzsj82gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToZ//M+yE0nKT/UHK5mKKvur7YTn80QnF6gMgFTlDlI=;
 b=YniVJPz9ysu/fhAAgTezXDuUv/thoY7IlfSvlal+AYg+q0o0hZ7qE1UCNHACSfp9+EH1CnfUp4ujyCQwYrLe9ir44vwoWzqz7NvH00U3NRu60gG1bfUtTF1A/mJ+WpHhwXKO1UeU0vky1HASnyBngIWMEs0fJXNiNFSjCuO+dyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AM9PR04MB8321.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 16:06:10 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 16:06:10 +0000
Date: Fri, 12 Jan 2024 11:06:01 -0500
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
Message-ID: <ZaFjaWCA6k+tiCSJ@lizhi-Precision-Tower-5810>
References: <20240110175221.2335480-1-Frank.Li@nxp.com>
 <20240110175221.2335480-3-Frank.Li@nxp.com>
 <3c0be658-e7a6-4231-b206-86ffb47e0cb2@linaro.org>
 <ZaFbbeQrC7o2dchO@lizhi-Precision-Tower-5810>
 <e3b9aa63-25a5-41cc-9eb7-6e7d1eacb136@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3b9aa63-25a5-41cc-9eb7-6e7d1eacb136@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0235.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::30) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|AM9PR04MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 6204ec90-a0ca-4735-e422-08dc1388646f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GHT9sYVzSGXQpxoZgoPSjQyRKAUfsCoKcvSaWUkz6aIP1NgTqAu1TWEQMGAAd224u42o9fgM7zVLJKrNH77h0kwVtfIlVqEz2W7ejIQztEPyJuYK91R1rfl2tdVCFtkh3T3NiS2VPhyQRbSe6wBWoAGjhfqjB0lfniUdYK0zcuJ9N00eYILFfY6jI8DtqTx/C94h3W5DqqBfEwv8rR4SYDdWsFiv6SZrzc+5E9eoEVkSaGWDys2d7OQj/fH4F5gAXVloV2OoLrfENtj2x/8QhFmRpecLhdQDTAuyBFYIqRM8Dd7BOLTcw8IZKpIu7UNQRqpmbWn1wQLDFqsGu7tS0y+O+YxG5UZYidDHqt5aVhjoIbXWas6+JfPVgMb8DyXtaW/SgHGEhKp/Iu7LCuTBOjrspeWkHb4z8aRwC7ssp21RQBfDmUh9zNa0fZLbjEgwzppvId6DMwGb9LGxGtfQGIMD69WQ9vx7RqlswuRutduMALU9ar0Fv3pmB41Qm6ZTnLrXcJ6vTsXJOSPmVwposicuBO5ixzJHiEesiQjfHGnq2uUm7SXG36pE3xl7OIU+bBMpNFI3nQR4kVSXlBfBlNAzhDrYcG3l73ojTWCl/IHUXURaWQ/N20j2GQF6W9ib
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(396003)(366004)(376002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(4326008)(5660300002)(33716001)(26005)(8676002)(8936002)(41300700001)(7416002)(2906002)(478600001)(6666004)(966005)(86362001)(38100700002)(6486002)(6506007)(6512007)(66946007)(38350700005)(66476007)(316002)(66556008)(6916009)(53546011)(9686003)(52116002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kHita5PIxOlpCgCuWiHXoMym+IaHz4kve5cAtI2YSAk+ofPZnR4WbNGeQQLf?=
 =?us-ascii?Q?EWScRGIhDjGEEJeBu86wX2Y9+psf/TUDByLiqvz+CzEEm0D5pL1kj1q52tsl?=
 =?us-ascii?Q?IVmB69SmQ2t+2esa3hVwTve5NEyfDsTirW5amv4d+UFACdcK0zLlGKtlrvDF?=
 =?us-ascii?Q?PIynMAopFNt6QWS1l0/OA3OUJZOgjVlS6iL8rEB+yL5uJZICIlVSqw0LEgtI?=
 =?us-ascii?Q?Vf2vVf5LU/Y8aNtF1PuMfOEr2cZUwN7nkD+2gAMvua8n7ymvipu+Qbs/y+B8?=
 =?us-ascii?Q?dqUQmr3VCfxnmVnnPelsbI9YS7XIYGSM3s8f+LyCPzdWmQUnzJi0bouiGT4I?=
 =?us-ascii?Q?hpEiJDmL69re+JbSrb0IZ3ZiIZ+PvZLiPFy/dyU8Nm9DXN4iyw/DHbnG5tWm?=
 =?us-ascii?Q?C8cVF5E718ra4Vb+SbrjynXaZEQqRS84YBFDh36z+JR6imNpRkpwBS7MnfA2?=
 =?us-ascii?Q?MpqZT9GEnyOez7z8jNEKO5581tbvniFIZl/sOQHfv81T5jGE36duT50lYxZQ?=
 =?us-ascii?Q?cJKTRPtFWQTnA6kR8FSBgJA/3lsNweJmaAes5chF1sr2wBapSoR1OH0DVDC3?=
 =?us-ascii?Q?rHbvdQ2lrAFo56e40wmWmEZaXIxKi9zVBn4d8VMRlaj6XPDD7/96RrhhO1/l?=
 =?us-ascii?Q?SH5oUWixKrlbc8xHVITU7a8Xz8y8paOfq6AF+VcvF/A14K6cGIgxKiZ+mSeE?=
 =?us-ascii?Q?xmPkw8R06u/4HMcnslBHr/BO0PcFJQJ4VpT/R7oQ5flTdocBiejHbQLgLa7t?=
 =?us-ascii?Q?8BlOczNiroiWx5DBGdMAM0e8IuJMHJsZi9GKL7HyRY9i0TSbApyv2Muv3ktB?=
 =?us-ascii?Q?flIXq1NALh4fVWdZYi4az58AtUQAu69Nn4/9OCZbvPUN7ZB0SPz0LU6NWAHo?=
 =?us-ascii?Q?yxQzaOaqSgMN63zQBBQ8GB6/E3HihWSRYwmPbg1oX2fFaRyy7SdTHea6htEJ?=
 =?us-ascii?Q?lcsWb49ugEk8YTwrH+3XIUvzRoEtjYGtSKeaUgUoEuHJVrahSVBMAQfpHldy?=
 =?us-ascii?Q?fAdf5kdvu9VKvkYqMre/qEFr0XVkG9uoISTaVyYQKByLgymsYliUlMRtxPcZ?=
 =?us-ascii?Q?NVMnLh3RNY9AVLv7IYsWgTMaEPFK9pO1sk3BhT0EsT7yNj+choY2DYawhsbT?=
 =?us-ascii?Q?vopFhSWugcrcZb4A61PKs8utT/LEVoA1xAenohZ9pmcrGBXVesLnZtFi0zZ8?=
 =?us-ascii?Q?Mag20bSGadjaT7nY+xuq8/HJa3oGnaSTCXqkMoybNbryMGigqeJTZgYFiVYw?=
 =?us-ascii?Q?IBU4jbzSIl8PKT7Uqasx03NoCYHct1XvGExAVwP+pBkB7CCg95PJ9kS7m5vk?=
 =?us-ascii?Q?sE+2eOixP+60EpH10l8RihE20ia1bOSY6grmb+5IMCoxwkQbVpLHwds8sY71?=
 =?us-ascii?Q?eZ62VNHBGND3BgEpWN+9H9mPIxYA4o5Z6KXD6kXKgsxX131FSRpeoDFIKrHG?=
 =?us-ascii?Q?zQ4YAZfXXk/++5KvrgbG1k7Zu5HbtRpsc83DlBy4tiiVnIEv9rvOfZwgmo10?=
 =?us-ascii?Q?uV89xH7vXOEr9rCj0rO35tDaVFZchq7nNnj2XZKH1mKoP5zbg3snfekoUkaA?=
 =?us-ascii?Q?PVv6tmGMoKOn5gXCpd/8enNvAuNefLHY4I7BEcra?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6204ec90-a0ca-4735-e422-08dc1388646f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 16:06:10.2348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSFC46ZJWitHICzQiNlEDK5Y3BXWKEXRs5DckfHgnzBboVo0Uof5wKLsBpeB3axa2rMAbTjVW0D9t1nrWheWEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8321

On Fri, Jan 12, 2024 at 04:50:25PM +0100, Krzysztof Kozlowski wrote:
> On 12/01/2024 16:31, Frank Li wrote:
> > I review previous comments. The previous RFC patches and I just want I3C
> > expert review to check if there are comments about whole software
> > architecture. Of course, thank you for your comments about "slave".
> > 
> > Go back this binding doc problem. 
> > 
> >   "No, it's the same device.
> > 
> >    Anyway, this was not tested.
> > 
> >    Please use scripts/get_maintainers.pl to get a list of necessary people
> >    and lists to CC. It might happen, that command when run on an older
> >    kernel, gives you outdated entries. Therefore please be sure you base
> >    your patches on recent Linux kernel.
> > 
> >    You missed at least devicetree list (maybe more), so this won't be
> >    tested by automated tooling. Performing review on untested code might be
> >    a waste of time, thus I will skip this patch entirely till you follow
> >    the process allowing the patch to be tested.
> > 
> >    Please kindly resend and include all necessary To/Cc entries.
> >    "
> > 
> > It is the same devices, work at difference mode (master  and target).
> > what's do you want to change to?
> > 
> > Copy to new file like pci/pci-ep? all context is the same, except for
> > compatible string. 
> > 
> 
> Apologies, I mixed up a bit patches, so this was not obvious. I meant
> this comment:
> 
> https://lore.kernel.org/all/20231017201404.GA2570433-robh@kernel.org/
> 
> There is no indication in your commit msg that these concerns were
> addressed.

Look like everyone already accecpted 'silvaco,i3c-master-v1'.

driver part:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8911eae9c8a947e5c1cc4fcce40473f1f5e475cd
dts part:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b8ec0f3b42a3498d5115d1fb1490082ab525747b

Frank

> 
> Best regards,
> Krzysztof
> 

