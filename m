Return-Path: <linux-kernel+bounces-127708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5A6894FC7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62D81F21F56
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E0F5DF0D;
	Tue,  2 Apr 2024 10:15:53 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2124.outbound.protection.partner.outlook.cn [139.219.17.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0095D749;
	Tue,  2 Apr 2024 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052953; cv=fail; b=KRCdpwdpUhWwnmioEvjW4qs375EXSl4JX9t0tHzboOCXeHblnU5XsRdsBhZ5+NglT1P4GdX/R5LRPQAlyi2/pZVhjMVv4KtIHgk4oYary5lc8zmrEXwKosWN7yll+kBe1i9X56BIRMO6ECHyT7jrGbpX2ytAtF1RSVGomxJHlFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052953; c=relaxed/simple;
	bh=BPOTdn9PqZIjRRaxsBjsW0oQegeY1gBtb92b60WIuSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWWTfwCHYYkJBpGXAb8xU5b1MceL4olEmujGZW0JSIPWi4nzGjq7sSdfsRakDGksOpZC16BDr4cw7CiO9WV1jVlTUwz/BEal1NHl3AHDohqwNTIEDIMKhqGV2I7PnnFoaFV7AXaTEmIFqwz0EhZIodKdpYVezseSkFVAG98nWAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeK3rzgt+VzdggXrkZvk1KbSu3bYshYVIUjCm+XicYGvGg9fQCl477FI+irIAuwkr58ePmy/fmvrOX5aTh8Ktq6Qy6uY5xZqniOX4mqMnNVNz7A1SxHt7FAQHAEUvanhKo7rKyQ9439Iw3aV5PE8luRzg9CHv8L6Q9VjdaBX1SpQ9ITtZRsC5PyRdzCu+ZL9yVQzRuGmRy97HEue3jVClRCZL4eOECyPGeymmbAnXxloC4osUxPJjz2dgApeZw4yF9+mJbnqzuYgblG7bM/uvpRJvXFVcIFY0jx+UVFRJiuk7plsByesaPcfKDFqe9I7p2AYLI6aXStCyNPVthmdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+3pg0h1rxF1CLiHTkvZO7Y0N4g9pCr1wHeur26bsDQ=;
 b=czbWBaoCsz6ibTIT/fz815GHKja8HRmM9kNBquoM08iX72uHlHdjVGSgtz8sJFls7gez0L5pI4NUc0wJ+uik/EQo7wyyOo8wQCsYYgcxKHEZVhHyqBRAORDQmVrt7IEiwMolef6jmjdKRmK6x+oGUrlZTZywSeC2lbayspQ1gA6Jf6vx13XweHjeggiXZy/AjCnqhAfqGyk+rCQmcUbknya4lo4GT12MJCNpICKVu7j25BB+84Ai2Gw3LBTJOlhRJQTEqxH+XE5k7rebJZk4h9XRHpXoRdww6HZ8xEHirAkNWI/NKUSvxSYQuGy05ge8sq2uVi7daoydYVnzd5LzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0669.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Tue, 2 Apr
 2024 10:00:25 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.038; Tue, 2 Apr 2024 10:00:25 +0000
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
	Mingjia Zhang <mingjia.zhang@mediatek.com>,
	Marvin Lin <milkfafa@gmail.com>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v4 03/13] media: videodev2.h, v4l2-ioctl: Add StarFive ISP meta buffer format
Date: Tue,  2 Apr 2024 03:00:01 -0700
Message-Id: <20240402100011.13480-4-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240402100011.13480-1-changhuang.liang@starfivetech.com>
References: <20240402100011.13480-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::11) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0669:EE_
X-MS-Office365-Filtering-Correlation-Id: 659f9687-1706-4c94-b2cd-08dc52fbb7e8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QiWF6RtaDeKUhn6jGssstwLXPgDOmE5aRWE58zRTEa498zUuphAGAe9PBqCqefvpAEh5ob8EgwT4F0Gkx12DGVTRO4ysotUkrJDdMTvXGESNMC2fGZJiRlq+x3BjL0HKBsfP+H/Gv+hmix4QPBVgUjvQvaaCshyfdgeVZxxdBkym28thwSxcg8QJg2t0W6Kcw7PJcTlk6L/LMPGu8Y6ZZAz6tlDZ5MPPT3pzNxdxL0xNAEJmQBUTcMqS/XDwAFpxYzJet54dLFYDIGXv6RdxSxD9XkUeAOetTSQBGhjQilX8BfF45pIgZk8XsXed97Sze0JVPYH3gOhEtzdT6Xq12UT14Vi8JIKsQul75bBZeQkl4quyctlkHEduuJMXvKK2BPhBl8bGncmyEpXFtFEmjX6XuozlKiAFU3Bu0VInvVKzZXhjI47Ef9bBf8Asj8TAYI9WAT2wlvkEHmZx6vtf7HLSGGToNzQtLToPRjQzBbw9TvPwKPDMswAvKmFNQLkIHa+MEzMxqaT26HJ+l4KbS8GuzPqglRc0GZa3zCt/qlND4pb5HopCzl8MgYc0rkCCy8r6Fpx0is9NN7xm8DyXDGEFOi0aAbmmHg1+nEOWDEuuAPUKm03w+qzuEfL/1SNXtpAn2dQAhGaI9NcxhgyjgA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(1800799015)(52116005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IufWn+1Fm0xmqg5rnAcSChSm4S72AokLQ5xL0gqV0h7xNN6wMiOLCXiEtxY+?=
 =?us-ascii?Q?Bf2FhNjZfMEXl35iiROtq7l8+gTpEHecV20O8UeJXEPrMeZ7MRzOXMiM2ot5?=
 =?us-ascii?Q?d/VlYlyVQ2r+IiAmbIrYSqQGmlG0Xsjpl+qBgZUnGTESMRDVNH2P1E1+I5it?=
 =?us-ascii?Q?648eu0EkOI1yWjqH6/pAFm3Tlz7NPDafaAxShAkUOSqBaizGHK8uEJMcMaeE?=
 =?us-ascii?Q?xTITts7e73VW1OUUGsuGx83DyV93RdmwGYAxSMsxWD2ACIX5Jz2t5ttQ9Dze?=
 =?us-ascii?Q?KxfXS5az2j4hHDn08i47Uoez4Ol7MJ78MWSJTvuBb1vKE6BDiXy8rnbzHBiv?=
 =?us-ascii?Q?4RgXuhEQx+CD7fhjtBScKGaGrGzG+M9VnLam9UIaY2TrW/GDhI/Wyp6dqvwG?=
 =?us-ascii?Q?viogW/GUzv49d7GDqEPZWpEGn+b9hXJTHijsGtGY4QvqAELHuY1j63FWIdWp?=
 =?us-ascii?Q?pV5teLDkKyYWrYuAT2dR0kYHlbwhcTduUln0DccmxXlUP2nrIGeDDYocnI+n?=
 =?us-ascii?Q?XWLjptQWIMaoGgUoV1iqx+HG3PdzGII692XyrDSeVPFUONkjousP9FdC/lhM?=
 =?us-ascii?Q?5khvGOdH+WxDA4V8cIBPDuk6iCaI2lhtEs9GfjKwFS/ekey/mYBEQTjX4X82?=
 =?us-ascii?Q?DOE7+dgOepujFEuNjzQYaf5wf9gsLZ1WPUV2CD2afgpM4Su4KB2p4+dFbpsD?=
 =?us-ascii?Q?BeqZHc9h2gD+ErKpUi+8Apcu+q6VTVAAzTcuR4eD+cLrFLmB7vzmilL3Ma2q?=
 =?us-ascii?Q?yWaauMtU/p/bpYt9eKesRxIO0lZxpQYz+GSq9ZZ3g2d7MFaxlrZCWrmxz031?=
 =?us-ascii?Q?s/34z+N9Udglifb7eqvsmrQ/EW3DYFQnVHPi9lj3zuTCTDJVlmVuE17lkgVm?=
 =?us-ascii?Q?L7y73qlDwL1/4dADpFfoCJq2HgfIwhHrJR9QCLzxwIYrwc9pE2D2CGEQhwnr?=
 =?us-ascii?Q?3rLv9/7NH61mgzqLIJPb6L+muxIcjJjezv8vm7Nb/FZfy4LpgX/VXM9A6iKK?=
 =?us-ascii?Q?1D7II/z7Zi184EjRDNv9U3mmMQYTtq1RIkajOhdqNwSpL9obHMkidAw7qJAF?=
 =?us-ascii?Q?QHEhcgPnd6VUqQ9ATE+kE3vo7qmvyU4CWdhiLIh+4kA2ET+RUGFAtvI/qWWM?=
 =?us-ascii?Q?bdQIpylrp/XbrS5ID71j/wgeSx0CcrPimi48T54iZel1+gyPQZ+uHVKCkvDh?=
 =?us-ascii?Q?C0zGTWondO5f3vKOkx2omZn7bEokzZQf0x2nToxxcU2qiFZBAQBG3EE8YRo3?=
 =?us-ascii?Q?UuD/cDSoqgg/6Lf+/M9Ubpk2fdV6q8di8Tj5Y2B4Vl8GPtSQZZ24XGliALUN?=
 =?us-ascii?Q?01FXu4sMClf4tH3K2G5eMTIKumTJoA4UDK+QUJYzntqY/iWkf5o6NFBb+I3G?=
 =?us-ascii?Q?B9mYbAoUXlEDJOfHo8O45y/O5ig4FcxK8f0vOfDhscuvszHNybPO4FH9gMo2?=
 =?us-ascii?Q?OukQmvI0jV3/gyV3bBTHN2IXRi7kxiqST37CwaWRn99wom1TxICnqrluJxNo?=
 =?us-ascii?Q?mxbQNcd72o1gu+tq4eYJGsG96dJfTLy955OcKW724gLOVIUtx0j5cFEWkXIE?=
 =?us-ascii?Q?3Aq1pJBA2glC0Tg53fmK6e9ZZVEPXS1lpgNOaj4Cz1Mlg0To+XRcB1epHp9H?=
 =?us-ascii?Q?afYJo6gqGB5/A3k8Vwn7lYo=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659f9687-1706-4c94-b2cd-08dc52fbb7e8
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:00:25.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojEgmDFL+M7xr2DmqvtQ05nWASj+IJBc+hBZSuTnWv95T0CB8zynMjxBeoGDkmYAhrufzQtePnDRTj6sT0la2O+DAxLztaF4gOppJGz4pnuzn/+4aRrNHdWZjEPawsi9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0669

Add the StarFive ISP specific metadata format
V4L2_META_FMT_STF_ISP_PARAMS & V4L2_META_FMT_STF_ISP_STAT_3A for 3A.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 ++
 include/uapi/linux/videodev2.h       | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 5aeff5519407..9fb8f9c510a9 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1453,6 +1453,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
 	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr = "Rockchip ISP1 3A Parameters"; break;
 	case V4L2_META_FMT_RK_ISP1_STAT_3A:	descr = "Rockchip ISP1 3A Statistics"; break;
+	case V4L2_META_FMT_STF_ISP_PARAMS:	descr = "StarFive ISP 3A Parameters"; break;
+	case V4L2_META_FMT_STF_ISP_STAT_3A:	descr = "StarFive ISP 3A Statistics"; break;
 	case V4L2_PIX_FMT_NV12_8L128:	descr = "NV12 (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12M_8L128:	descr = "NV12M (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_10BE_8L128:	descr = "10-bit NV12 (8x128 Linear, BE)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 2663213b76a4..8fb9f2f20832 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -839,6 +839,10 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_RK_ISP1_PARAMS	v4l2_fourcc('R', 'K', '1', 'P') /* Rockchip ISP1 3A Parameters */
 #define V4L2_META_FMT_RK_ISP1_STAT_3A	v4l2_fourcc('R', 'K', '1', 'S') /* Rockchip ISP1 3A Statistics */
 
+/* Vendor specific - used for StarFive JH7110 ISP camera sub-system */
+#define V4L2_META_FMT_STF_ISP_PARAMS	v4l2_fourcc('S', 'T', 'F', 'P') /* StarFive ISP 3A Parameters */
+#define V4L2_META_FMT_STF_ISP_STAT_3A	v4l2_fourcc('S', 'T', 'F', 'S') /* StarFive ISP 3A Statistics */
+
 /* priv field value to indicates that subsequent fields are valid. */
 #define V4L2_PIX_FMT_PRIV_MAGIC		0xfeedcafe
 
-- 
2.25.1


