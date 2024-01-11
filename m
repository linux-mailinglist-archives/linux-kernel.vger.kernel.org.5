Return-Path: <linux-kernel+bounces-23275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAB782AA13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF661C25823
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF101549C;
	Thu, 11 Jan 2024 08:58:32 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2040.outbound.protection.partner.outlook.cn [139.219.17.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7276B14F8F;
	Thu, 11 Jan 2024 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVKfsXypWpy5ShaBPLcA1yXUEIrpetn8UQCG7u3huAUcw/Ut0LQEDNsDU786Khi73V8zElioP7PgBTCecw6LW3pOyQiEO20xY/IrBdXf6M+ASSNLeKp482A6K4UapOocbuu6d+c/eSnaG7ujs8qILqWqqZzhk00yzzn0WSX/+NQYu5T56m4ZcQBhFF8SMo3pplNllVh4iOeee+dB/Plb+/Er6be8WYTW4pOvRckO8kpZ81N0otTaUbFSN8oyR1LeKwtd/2UPIGRxJpaZ3cDG7e7OUMam2y6+PumD+I0kz6lNiMjn/b2FcQ4GUi2AA6FApEwM5Ewk1D6/Z8whsI97pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpYS+v+cBn1HqDAmhXTHJL+v2aLemV00fes8PvGvKzM=;
 b=hO/Y3TDh+Xl+83aqrrnnaakq+b2XZrech0AO0HNJg8/ys9JCH5RY7MBOFMUBQc7+D5cFZ6kTKMX3WRXMGpd+kyo/sK+KrSlc9lPOi1tGBhbqNd9HnWA0BSGxYd4yaQ1hQuA6BsZ53ZJbcdLY+LRooJBIcHDG+1Y+r1xZJaddUcWJpGOcYSVHMNij02ZTD0AH/CqMQvRHRNGpJJQyPYWdLv4ypvGcAKVffZmJ0WsT5mqp5nF5l7zej7jjOwRe9dWqkF+v8lazIBLWQg5XNEkRtZAeGzcl7CN13cCdpYvaU/+SXGsDau+vfSo75VDqhjErAUfwsn6ZP05GGAWekkOWVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21) by SH0PR01MB0747.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Thu, 11 Jan
 2024 08:41:36 +0000
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 ([fe80::e255:98f3:ba27:8c7d]) by
 SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn ([fe80::e255:98f3:ba27:8c7d%3])
 with mapi id 15.20.7135.033; Thu, 11 Jan 2024 08:41:36 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Ming Qian <ming.qian@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	Mingjia Zhang <mingjia.zhang@mediatek.com>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v2 10/13] staging: media: starfive: Add V4L2_CAP_IO_MC capability
Date: Thu, 11 Jan 2024 00:41:17 -0800
Message-Id: <20240111084120.16685-11-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111084120.16685-1-changhuang.liang@starfivetech.com>
References: <20240111084120.16685-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0009.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::19) To SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0667:EE_|SH0PR01MB0747:EE_
X-MS-Office365-Filtering-Correlation-Id: 060f83a9-a4dc-4d7b-7996-08dc12811eff
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YcGJbMGfN5k4Zf+exk08/BZCrNKc3+FZ37P+G/TFvFS8NUQqu60o9DXX6CjDDfTkpgzVlvIzJw2GkGjnKwx+/ZkxM1e4NQBOd0ahEwTrosVjQWusF5Na94uErrDFT3xyoMgMQtI8J2Jb1UpK03HaZRkuRpUpo8CxiEjAY4pJIUy6iyuL8CUF4mjvpd+o8owjkdouljnXxy4QI8GWnAYSANKJbcVkv1wBfR1xQ/JaQVAgQX95AynOqdb/i1qR57noKdAIVyIW4v/MEpteTivWu9H9rUKIAo6ewazkYx0JAim7qrS0nOH1IedixKQZB1CIfB71i46/LT6gZaIqVHZOaMvx6l/rzkxkyl1tsgQhNkcU9tYPF7YPh0pHoRaQ9niNFZk5J1EpKl/v7h5pgvM9aPd81YeCUml/w3B7pgKM2bk0kTeNvpLRh13zRj/3i24Ew6HMc3KcwRctXQwWiyMn5ruInRyPDs781U0ZnjIC0zqW8nCxyiC/fr9s7jLxYwBuZHRJfC6kxo6ApLLINWX3nF775ygQxuti2hXMOp2NpJie3aAu2sFvRTyOUuzuGoZ4ZCGhj5JbiFhouuT/kNJIDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39830400003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(52116002)(41300700001)(2616005)(508600001)(38100700002)(40160700002)(1076003)(26005)(86362001)(36756003)(921011)(38350700005)(83380400001)(110136005)(54906003)(66556008)(66946007)(66476007)(8676002)(8936002)(41320700001)(4326008)(44832011)(2906002)(40180700001)(5660300002)(4744005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WBF96B5Er/5ZrSz3zsGKBWbadtFzp71CA8pUD3WCHmUjOmghW3+ICeGPXzps?=
 =?us-ascii?Q?bJmt7vdmETcs19w27SidT7yIjhWU3HbraYKo+4qFWas1qPbeNji8LOgNgXPl?=
 =?us-ascii?Q?nr+J2O3HNKGmurtMFcH88P1SpKlZvBMNIYo3wxIK1rgPP0jgPkemmvavzM0Z?=
 =?us-ascii?Q?DvLJSlwp9s4CfgGg6S2gtHIgVTSiIxLQx+0c8eVzBlAthQ5IYC4yqsK8egur?=
 =?us-ascii?Q?oE3DTfvIGqkZTkFxRuldOBZJAp2pGFdJSVGTPZnJLMBuF6KpZdpR95X9O+1r?=
 =?us-ascii?Q?6wWvMqGogYDc58O4uxaS8aDYxjm8fIHok1z4OnXiDCdSkXfcYi6dEHf3AVfL?=
 =?us-ascii?Q?oB3rHaNa+keMMEj9dgNmTQ3C32gVGgyjbuScaXJQaC78jfpGD0I/CD9Wwti5?=
 =?us-ascii?Q?PytqWEFtz1WSc446AT0/n6JNxrsndkHWb0xSyUcW3ORhbV01Lyx9RL52O4Fs?=
 =?us-ascii?Q?ewxBAbEMx61vDfK/8fE40Vf7cEYlv4UVQprd27LUdfoKwlXry3BdOIJmH/dO?=
 =?us-ascii?Q?1GloWJH3YUwrnkzUAJcYdiBrbWlZWiO/+vANgPD/mjIqFtkvwxFY3RbpMXOr?=
 =?us-ascii?Q?XxPNNDXGxOuwcQZrUf9o8r7+xQLCYTQg9LEgxdRmt5s5GeJfgEugv6loumtZ?=
 =?us-ascii?Q?xYuXnKeSAV4Dp5gxxRCT/xW6bo4fhCf/TZfkT6oZndoNeta9ezHnBp2rlJdj?=
 =?us-ascii?Q?C3FzOpYjuEQQcuoEjN11ttBGvSy18RIuZ4ZCi/DbA2HuX3ePr7X7P9/X4Qd/?=
 =?us-ascii?Q?jFW6ovXIu/qb8pT3QmwTjAZ/wiq/cFh5S1VH500Rt3cULQVwwGm/vNZslvA3?=
 =?us-ascii?Q?fB68KGYb+o5JddwfO5299Rn8zBZUku0sfW5RD5oWGG9f3QWfl/uWG3KapgrJ?=
 =?us-ascii?Q?GLv9LYO6lyAxBwGT0ri/U6H2yg/Ad8xVBi5Rk7dXRctJILTztsgzKIQu26Ns?=
 =?us-ascii?Q?0aSx712Vv+zKq0glj5MkbdPo907Nlj4+R3ovH1p3t7/foCWNwJfX+a1Me5Lx?=
 =?us-ascii?Q?GfiRC4bh+ExQ8MNaSbY8tVEE3KxuC2/fRjgcMUKp58bNAZCl4yVnWellv42t?=
 =?us-ascii?Q?3VM8ccMkGWVFO8aq8j5EMe3NVE93OwnIIAFiOkrAVWTkiRYB3DeLJSG1gWvg?=
 =?us-ascii?Q?c5iNJsobBx4GcI7Ud9dGL/hT4nppkwOcNL1vdOB3oS8JDRsYEKMf/kyixwsu?=
 =?us-ascii?Q?FTR2hptHrdH+V5tFohVbwUS3mTUKY8fkKGSSk6/JyoWnCs5qOex3MVc5jdVA?=
 =?us-ascii?Q?Hhov9v/6x/8rGKof7sEQA/oMQnCkjY0nKh2XZ9XYyPriB5mEYtndbVDMdCh7?=
 =?us-ascii?Q?TeLPHj5U1Ql6Pf5cHd32udMTbXe0/AWfewhKTRQjMcfP466fbmLOKKC0F+w2?=
 =?us-ascii?Q?5BzKMvoL1nJJAkRyxaOqiqTRXl7oxoQki9UMfxb33zw5+Bopl4bRrChP4+GH?=
 =?us-ascii?Q?oVZ3ROJj730JzPR95GrkoVYXJcWPGlLU7F8ccDC1NFz07NU2GVnNs2Xx7DKn?=
 =?us-ascii?Q?f5mzgG4JHHPECCDFkqTpGuCZ71LaSOlEF3g84sHevmIDUMgNXlft9bl8P+7H?=
 =?us-ascii?Q?OPl7kJIIVv1ZNrBOWmJuQkAAVSCWymzAsXWNxXRTLWEue2VBxocx8kgpKJrQ?=
 =?us-ascii?Q?W5fEfmXkYpwZUE1GKYoJwU4=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060f83a9-a4dc-4d7b-7996-08dc12811eff
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 08:41:36.1161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuA4lj49L9ve69LVy7UdgJtnDDYfLLp+0oUz7AAV6JsnUUIAnfEJb3FvtnJ7aYixozm4ASnBts4bzp7HmBdbLpq6kPqr7kCJn0uPZ3PNLufxd5PouBXmiRz/8uwqrOSa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0747

Add V4L2_CAP_IO_MC capabality for video device. User space can enumerate
formats by mbus code.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/staging/media/starfive/camss/stf-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/starfive/camss/stf-video.c b/drivers/staging/media/starfive/camss/stf-video.c
index d9e51d4e2004..4ca889a7b757 100644
--- a/drivers/staging/media/starfive/camss/stf-video.c
+++ b/drivers/staging/media/starfive/camss/stf-video.c
@@ -665,7 +665,7 @@ int stf_video_register(struct stfcamss_video *video,
 	}
 
 	vdev->fops = &stf_vid_fops;
-	vdev->device_caps |= V4L2_CAP_STREAMING;
+	vdev->device_caps |= V4L2_CAP_STREAMING | V4L2_CAP_IO_MC;
 	vdev->entity.ops = &stf_media_ops;
 	vdev->vfl_dir = VFL_DIR_RX;
 	vdev->release = stf_video_release;
-- 
2.25.1


