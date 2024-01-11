Return-Path: <linux-kernel+bounces-24009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B804C82B539
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8481F25F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3520155E4D;
	Thu, 11 Jan 2024 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ujJYEHLR"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5755764;
	Thu, 11 Jan 2024 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGyR2pSY3F39Q8DS3IhZI0rkhm2vaN2pfCeUJeMUa6vZPZvQUCEqN99RvXMrFfyHNBO6LdeUNdZC6921R2AS9MJMXF40R3B7kn7t4MudGVkMiVvZtF6kSCSZMIfpRLnXjRjn8osYOilNRY1mYgjT6obGf2HW+02pH0bqGxtDCBVDXNxneaK1u4UrMPWxgJRXkVk8hJFujNqGNO/KSo1gJo0q/9j9zTBV2MSGtQY/6yojOQvUqgg2rsXnYL8aah3nfceMWvNww/nZo7UO2N9PfEzgiEDw2/TLKpsPPq5C/vCtdkXvM5kybldEv1ORgKMQfOO6nQF3EIXlV28IXStTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cj6qEhPE21N8s2lPVxuiAOqXKyUK3iXFCwBCXjgGHyM=;
 b=ANRytGBmWmk1uAOExuJ53AEzs/CuGziWeH3zSjDUbJQbiMbj1J12YQQJUkHW2Yz0v0yR+6d2wbLFR9EYSWO+E1cQZMBDQbI0l+0wnyloT/c6PnoR+bWE1s+eGEm7KLeY/9tz1+awuTsScDjuHoUNmzoOVnimyUayGSiOw/ILT6AaILLsWr44VwgnGmhsP0SYCpdW8pAKKaxBXdXWinpWw4Te7NaTY7MChX7VVRRB177X97TcJpr8adPVH2d61se0XHF7XPhTQAebpwuxTPghbs/htlbmmKUFz8r65hYF+XH9Pf5I2TcRd7k9bnBzulcdbRt33Agt42gn8LT5rp2/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cj6qEhPE21N8s2lPVxuiAOqXKyUK3iXFCwBCXjgGHyM=;
 b=ujJYEHLR8jwNI5flnyK5JhoKd9gsMWhZr7JWQyujZUTAs1VgifIsvUqdeIw8pClC9sKurp+N4pvb2mpnzWABDfP9R/9p4KQJI2MWBIm3Mf3c97ZEzymjUkh/rnagUReKvdmVzQv+F0ndV+r5MzujSnxqq4skiBBz27SWmd41/TcLhWsrLmXLY1AYkxZ2JozNNpI6sajsAh8D8bkfuqkAtraOuthLpyD6QBIibBuR3nGUyePnWWwC6+/Gpr6RxMDCeE/Yp7KXsJF3kzp1JPb7FM5kvdf9+9BYg+Z8MzRGX3wSxskqe0oI+MdfapTpZ5jvtxUm6VPWhXuGoucQRe2NtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 19:33:19 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 19:33:19 +0000
References: <20240110113730.3704712-1-horatiu.vultur@microchip.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net] net: micrel: Fix PTP frame parsing for lan8841
Date: Thu, 11 Jan 2024 11:31:58 -0800
In-reply-to: <20240110113730.3704712-1-horatiu.vultur@microchip.com>
Message-ID: <87jzofy8aq.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::29) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CY8PR12MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: 08af91ee-cb87-4aa8-eaf4-08dc12dc2a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	peuhN/EQwuO1DIp8GmgbkBcICxZkND66NZQgGoOCWsaL1rtjc058DkvDQtrPhEzLGw49+cNWzEMW582RR3KITyZrlSeqmxBjv3EjV6wXfSMeqKOxqp59yM9TMv+dz8YGiyvdTJBsxwHzPGR5/MJDrIstP8fWtO9Qf3caVsNad667IHFfgsaYbIBX6d8f9oOXg1lrlNuNm2BIMuieXqMICG1H4P5FM6UgBRFBrSA47fhtr//11KT2DWpoKerUBMpzvznLUfnk+CX68Qzta6avviiagy5qGlWE55WeprVwNWHkxx5JH61qEWgCuNJbImJmwUfwXcJMqrdeBXYTXpNTPTU4qFB5qfkND71EjHFfy+IWspfRzvlcm22Y7mvUb9/qM98mSgT8vOJeD1N8VfSlKI0NQRsZDKSUcYe9DksnjXOUaBCHSdmtdsvY6forjLrZ3i+vR8Mc1HDNMK2URCOOp27SYybGeakKnLmg7f7OEP1QKiC+X8igRGJN5V+HOsFZxL4ErjV3gG3cyHR+wiJXS1X7eRK5KSk3S3iz5aFBQrHtcFw6zK+9XXI3MGaVJDsN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(6512007)(6506007)(26005)(2616005)(36756003)(38100700002)(86362001)(83380400001)(41300700001)(478600001)(8676002)(8936002)(4326008)(5660300002)(66946007)(66476007)(66556008)(6916009)(316002)(2906002)(4744005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JN4ZuyiOET+aJMR9Muq854G4EdWcmcL1D1qEIulpFUvHpV826dzmfYMG1G09?=
 =?us-ascii?Q?AABrj9ido7c9xWVLTxhaMsxm5fa7E1y8B/qJMyHFI4saBueG+4odlnfGKexw?=
 =?us-ascii?Q?Zhponzu8OPcs2j+WVMxj5QkHwLSIAFbtSk+vjuA/AzVOD8x0R2doz/dvCSFA?=
 =?us-ascii?Q?IehHfCM4wFN46oW08jH5WyA+quMlOm36bj4UoRDPzwrQy5aAh73+e36qN6Ay?=
 =?us-ascii?Q?frcT06gaERoIvYczrr9ONWIeUbhtuW3q4ebjNLlgWkK4ynNU/W0Wflop7oXd?=
 =?us-ascii?Q?431+K7RbumB0+AnDZAC+1HI282hZf/9NfZm03QgdXKkK/NO32pgwHIbn18KS?=
 =?us-ascii?Q?lVc2xxBUKViazJK28H9lMujNArBKEvhcRecCu8jMmg5TsyTQKD3P8iLTVckm?=
 =?us-ascii?Q?g3HNWbp2f8spXvj06nBoO8eNwjqRgXinPSwI+i9RVspx1hpI0/7OamphnmWW?=
 =?us-ascii?Q?ynD1QTLwe4uZFkSJ0sFx5PLP9Hac4y0clwFK20fIZDm2DcBCNIvETKtoVGQa?=
 =?us-ascii?Q?cfe4M/7jYrZE+PdaD/g37YoYMzBFhiPICJjZdsvbzmMQJFnOaJk9yUC7OadF?=
 =?us-ascii?Q?pjixc3HLsJYyJcLSPoUpEtUeETtKIQ0Z6RATF/ZmbQtmQCMaQLWtYX9jdaql?=
 =?us-ascii?Q?wpQ78dS9Dmm6YfmYWlGv4gdOfLx+vetVNHseJFPx0IQOQ3urKwbULbMYlvy5?=
 =?us-ascii?Q?KxBMx2LCA7LUViL+rIPFi63NRAxRfmM8FoDnKp5YhNEMNUf5m/HCMPUuWTn3?=
 =?us-ascii?Q?NTTSBvWmqM3hrYDi25ddbvEpdz5L1LsJIkX+qn5gLssI5PFSaxj9je/ZLQOx?=
 =?us-ascii?Q?B7iE7KMbODUDF0V/o7CZHXGoDrpM/IlqUIm4Tpkusbj3Epj2a5bTo8ucE6le?=
 =?us-ascii?Q?ffxWIvXwblsteBV8Vcz2Xo3uUA3wXmnuJqFas0OLTxH2p5b5Woj/2E6axNlZ?=
 =?us-ascii?Q?IOVmWZwq57jo+6N5mc228S4TX2g0foZMC62F6eK/VUSN0ZfWbT1IJ2EIYIbM?=
 =?us-ascii?Q?u4WDpv2v1VGobfUZGqKRUugSwrVz95tswDdSiRSyIN+4L8heunACUJ6eVUJ3?=
 =?us-ascii?Q?j9BH8iWTVpm6nuqw5/tfZEyCxaB5wbPRUog/+AS49ppujrPHwDlfYedEp7+o?=
 =?us-ascii?Q?wLs36kBRSwJ7vBBf7FAw/LRYZBqWh9/Anl0xyX9fRFh7QnrwWzaXmv/gbKc6?=
 =?us-ascii?Q?YYSQVvsIKBsuAzjL0BQYd27QT47CE9aF+3wQhzuUmRVBB/kDj0n4CHl4Potw?=
 =?us-ascii?Q?gQDKtJO7jU59Mjve/Lf3pD/xF401eJr7SZvfd6paFl1Ljn9FEPJBSuYwYDQr?=
 =?us-ascii?Q?zvVah9dDwl8IwoqByToXLxF596xLj2PGKXzGLrX6W96UOLW6ebAz3fYGjqER?=
 =?us-ascii?Q?RlKvMc8o1npu7StIdhXhzPq5LnUtgU87jBElXI1evt8Oxick2x/POGHn+nMP?=
 =?us-ascii?Q?fzNUK84aK8uly4ePt0lJxGGQS5k6AR7WxBJfF2GNiKah9FY2NlTJH29Mo9Ih?=
 =?us-ascii?Q?iqgb0BQ+poytGEDAFrW51Bdvbt8c5x8KoFrYkhi5eFnwzFF1JlSA6v0Rj7zw?=
 =?us-ascii?Q?RvIPwfA+NWif5DMJ15f4a7POHluWqErv9zfOY4bkufvqOlosKB2sNvjQdjRu?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08af91ee-cb87-4aa8-eaf4-08dc12dc2a16
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 19:33:19.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4Wbg6CFg74aWz0UQPIqHZPejjVfu+d/qLoTTOaerpUC+QWd1MotfCi9E64QCjUJ0JcU/ENb1QSedK0QfrKHUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216

On Wed, 10 Jan, 2024 12:37:30 +0100 Horatiu Vultur <horatiu.vultur@microchip.com> wrote:
> The HW has the capability to check each frame if it is a PTP frame,
> which domain it is, which ptp frame type it is, different ip address in
> the frame. And if one of these checks fail then the frame is not
> timestamp. Most of these checks were disabled except checking the field
> minorVersionPTP inside the PTP header. Meaning that once a partner sends
> a frame compliant to 8021AS which has minorVersionPTP set to 1, then the
> frame was not timestamp because the HW expected by default a value of 0
> in minorVersionPTP.
> Fix this issue by removing this check so the userspace can decide on this.
>
> Fixes: cafc3662ee3f ("net: micrel: Add PHC support for lan8841")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---

This is a good design decision.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>


