Return-Path: <linux-kernel+bounces-118333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330BE88B875
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 04:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EDA51F3EC21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21653129A69;
	Tue, 26 Mar 2024 03:27:22 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2114.outbound.protection.partner.outlook.cn [139.219.146.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C34A1292D8;
	Tue, 26 Mar 2024 03:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711423641; cv=fail; b=I00UF2qmg4T8BpyADGCb31SGytKREhmhO1epTJW6WzWQGogXrznMVGA3d4dS4Fx+ATYpzNmWO2vs8VuPCfYWdM5+zMRm9llOsqW2xBcIAEUIkvqtA+Exq0fq8mByHZC58smDEuz95o1N2TdKfrzy7fNyvwxtsigRN+oJJZZmves=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711423641; c=relaxed/simple;
	bh=plclBZiUnSE34FIAHHTyhM3MmPMnraCmuItvkdbBcs0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EnpT48zeTo2wZs/fuUdBA5SeIvvp5mVJdVSeZ8mrxPPgKEjfPm3QwYJrD+d77LXLNG8xBwolrPxjFE+hOP7t+pwtHa4dI6eEbRKNzor+KH0U6SiZWKR4uhZDZib+0bJHWoc1E1X8N9+bdHQ619HhOGsMjURLs6pOKKXffIvOfJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbucBwXKKz6gy/eWACJ3r3+vja4rfzo9Qw8nVbKaeXV//kDgEIqrq1WtSJuTGfqGgG/LQvRvxWsWvJ3MksYxHPy7y1KyR0C0Mj3fw20CZGLWYQxpwsE5SX9RokKj/TzHFFyJe0ufeTtWInWOdDQiT7F3vaZy35WG5W+czpty9cRYX1/gU+hCGgG1uAKiJEGTZXVnoYMB9x6AYutqPZwsAUoelrPsqpNKGyaoHADhdYY5POOecrnW8Vix7YCgqDK2j7BwMrJ1tfwr6Z63w5s7u4UdbGn9qAMdlOrQMyNwMHi7cBXHMICMd+iTNuU/BEwAn8++C5dI2ZIx974cQTUI5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuJsjkWrTKju/XUVj6QAUG+XJG5o1keZTFgQLp2G34g=;
 b=Am9BkrF6J26eV9JzqmjQ+QqLiFWDO3MAed4NvyAx+MX3CSHkdM1FC5etw+88UCTku01ubHwwzPk8P0BLjBiwl+eR+So2AIt+WB4uI2p6mznpRzwFzly/VHncq6tcaraYujgJNTKDqu5q7DM+ODhKA5YjReODzVO9htA/6zglSrSrnhz0TbKPM453HnBCtNUXXEynEzFmfelfBe1LgbVJeK2kSCtwoDbF655AwWMRyEEommS8VkLik/Q42xa7Nu5xYEs51aDcJPkUEsjR3exm1XQglSIILvge/e/tke1mo6tCgjMfIcPLYn5A/Z0nnoRIIhYGCt/ycLz3dA9Dz4jH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0622.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Tue, 26 Mar
 2024 03:12:45 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Tue, 26 Mar 2024 03:12:45 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jayshri Pawar <jpawar@cadence.com>,
	Jai Luthra <j-luthra@ti.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v1 0/4] Add StarFive Camera Subsystem hibernation support
Date: Mon, 25 Mar 2024 20:12:33 -0700
Message-Id: <20240326031237.25331-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::15) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0622:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1da64e-c60d-4c5b-ade6-08dc4d429b9a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Un1KIB8ViEt6Or64iwhd+dn8wL6WydVAoXrrgqY6fDChQ6rAfNd+3/AV7QRkahUB/hlOO+P1vZuRe0g9irYdyDQ9c1Q3mcWRDKjBsvz0xS02pDSKNcasSZiPnkOTZl3gDg5Ly702EGCclXnoPnVdl8xGV5KWgnbSIMR2GDzjCDoSHZEHJqpfPwyGDXarWvxzbMDpJK+BLEULf3ltwpcrlba+lM0LsuMvnPHQDcLv14TiTxR0WEpopVBYxWknbU5+APJhXH9+kDVP42M1PA5pDU9KBDPOuQ+USKlZl4DNT/vbb5Xi7WxNi/FZp9pnC9EJpcIVRG2XcE2yOeeIJYKwRmQ1wkGLamuIoG5tgJtPXNQYz3OO5kkmI5sZjcrd3EKRLpMEowzxjEzkWtpxvCTt508OsCAMoOfoe7zHI5iBjFPLknTicYw0U3iVVrV5bFcSvNgVLmqVLeqWS3ANTszN4+vv43wGB+71S3jO8atAyiAy4hW7Fs+ODOimr9ZdiuS/pgLcvh6KTr+U5G6GsUMFceEdzWfXLw6SFGFHPLMdsXHWsEmCvoRxvlLrQAHc4gCPImx7AzPxFjUiP3j31nhuo1/z21oJK4v5QWXGTPnp7DFzyXaL4u6gUNhMgctFNV4X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(41320700004)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AH2nICRHFzyhCRS/Wh5Y/iWo95CdbdirZ99F/WIiqL6SpbJ/Y7Pf0c8uRntc?=
 =?us-ascii?Q?9C16zRBJ/ZZFPdaUt2myLxiYhG/ma0Ax/FaYQ29kjUFJukNycfUuhUS0yE8a?=
 =?us-ascii?Q?jzu1bYhE3UhKiyrE4zbA4wo/j8IwBZoNMoivt8e16pEs2V5qNwJblEmpPoHV?=
 =?us-ascii?Q?tUrLRgpKjJG9Pg/yfyxU7eZWag6thphw2pI5dP5q3cweeL9SACfqR0S+wKcm?=
 =?us-ascii?Q?f+7McsyrzSzpAbwGK/OeboMghh+Pz7DbA2UWjxTpuYMREvw1CFLKdWhZuOOd?=
 =?us-ascii?Q?QJWfjUJFE65XOTkTXst5i2fhvX9yqHgi0NGEESTfImSHOHPKI9/JuXmja6UJ?=
 =?us-ascii?Q?Btaw8P7hBGrUP9ykt9nSgRUtu6ALu6DFls6WFhCqjDrfnrwhGodyrobolA0j?=
 =?us-ascii?Q?hISm2n5Fb3BhqLTDWDJ1Xbtq4xV9dymyux0oONWu9rUQBWcjojt0erVH22qr?=
 =?us-ascii?Q?cwuXYGuedkW4TUo88q7x6ouDgmcxcdJ4x8BYXo6gFf7PAnD7x0kPJj8+lMf7?=
 =?us-ascii?Q?2h4SX78exZOcFoAtlG82KCzM3Kthz8NCP7woDZ4/ONR0GwsDNYjT6OnZ8rii?=
 =?us-ascii?Q?BKhAEyJpWS5y/FkuuxhpPD6++9RiTwhuyzVUBEfH1GEwjYlQeh0CqY3WEmBB?=
 =?us-ascii?Q?MSUqSJZYauIKlz/SYiPPlBB/9Q4wLCLFb2mE3hA9enKkCf4NDsndzWYaFYNB?=
 =?us-ascii?Q?U3gGy7Och+9aZ04kYvD7C7PLWVxbDGvhCj4fuDdQjl51BrjgnRl/zbZ8DVo1?=
 =?us-ascii?Q?cq9uriPAJ7Yz2181VN5Ko57pPqJHeVaff/0jpNa4CN5nNBnAhp/MQbN0Zd2B?=
 =?us-ascii?Q?sp1GCGyuMaaWC9E8P8LxEj0UTsuWMy6UiRIbuf0lnQ6KxD64bJLclMswvEXo?=
 =?us-ascii?Q?DSNr4aX1yLRGofvSQHIu5unPdgyLZHPGuNifXToa2R/j0RVu+KrGoOnWg+o9?=
 =?us-ascii?Q?MLcPLoYXucnG6Lgdt8nzB75PCyeNx3xfCblFmccpl1Y3RTDeYfr3qhE0bn5g?=
 =?us-ascii?Q?e7kxetQTpZnWnQmZXgNu/B53kD+K5QJMyYqfEr0hUoEfwcCUhGtk8QhsdVYb?=
 =?us-ascii?Q?dMqVY4/OBWmzse610g4QI+AdUSVOwETjVChkYao1tZykpmLwnGu0mhBFVsie?=
 =?us-ascii?Q?SKTIEyZbKl1GXFKXJcU/KKS+mrhCfwcD7SB6bHvX3soGqZBsLddHjOr9Vhsb?=
 =?us-ascii?Q?ByQ8fwZERwUp04qDDgeer4QdF95AURsFg+Kg5Lla79nsRtKsulhni5KFHBAg?=
 =?us-ascii?Q?Dq1BD2fgWwe+AhwdhKrdCyUUmLIuFOXm/wnBiIE4aF1sjI+NVCTVxq04iJ8N?=
 =?us-ascii?Q?yMinUx94KSjL8mEbsNjLu+kfXPpjd7JS/aL8TDxkTLmZeTYc6FEzlDbcK8TW?=
 =?us-ascii?Q?vcLPPVKwfq616NM/pE4IBaQ+PAdpzjPmH336pU8ULiICMcVZvfnkXjaPwYNq?=
 =?us-ascii?Q?hi7K7Zg+VTZt6SU/JgA4Tfc8SRsW5HR0Y9yykHT2KYHW+H0eHq23mKAboJ/o?=
 =?us-ascii?Q?57Ixxxyy68s/LgAfDQAQV/gCOariPZIylaFJRs/ZYTTpuEhIKGipjoB/b3be?=
 =?us-ascii?Q?B2sqOLFu9sQjqhr9aCrsaq9oyf2H/b0c0ZiF6WTGVHvhinHcmkRBRlME5mTo?=
 =?us-ascii?Q?K4YohmQkKURFuwcZ9axD2ho=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1da64e-c60d-4c5b-ade6-08dc4d429b9a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 03:12:45.5420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKXs9axkdl0svE+6K1ZHBALBmH12zXNO/WfkKI64VccL9uxx5rrWziqsH5W6vTZcbnusRZXYUGIiuevdGtB7CzYxrcOro+IEz+WCYlutwvHM87ZiztRF6h0us92nU73q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0622

This series implements suspend and resume operation for StarFive Camera
Subsystem on JH7110 SoC. It supports hibernation during streaming and
resume streaming when the system wake-up stage.

Changhuang Liang (3):
  media: cadence: csi2rx: Add suspend and resume support
  staging: media: starfive: Extract the ISP stream on as a helper
    function
  staging: media: starfive: Add suspend and resume support

Jayshri Pawar (1):
  media: cadence: csi2rx: Support runtime PM

 drivers/media/platform/cadence/cdns-csi2rx.c  | 44 ++++++++++++++++-
 .../staging/media/starfive/camss/stf-camss.c  | 49 +++++++++++++++++++
 .../staging/media/starfive/camss/stf-isp.c    | 27 ++++++----
 .../staging/media/starfive/camss/stf-isp.h    |  2 +
 4 files changed, 111 insertions(+), 11 deletions(-)

--
2.25.1

