Return-Path: <linux-kernel+bounces-52333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CB98496D3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527B21C25728
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3E614A8C;
	Mon,  5 Feb 2024 09:39:48 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2110.outbound.protection.partner.outlook.cn [139.219.17.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54FF1428A;
	Mon,  5 Feb 2024 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125987; cv=fail; b=DuONBQpbfW97pZ6Nyc3KgTO1cFbeX535eIbQYDjAVg4L9L21oiH9TBgi61FOkNUhBKTMXYVgksRH3358wUwHxJWUJnjgR6f8XHkHAYCpdPNqSkk/fpiRAMlqJs7XwzuNa+g6NJNtYXLoLIDiAAGpKE6LxvrXqNVPWYspOW0il+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125987; c=relaxed/simple;
	bh=aF1sm0c+Cm00QwaRg87Dac2kr0QT5QtcMJoADOoVzQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rjq/9SV6ploy76GxJqQN5RBOI9R1FzOcTV++DSstF8VNxo/1YQRXdqK7il4iG1z7p7JTV1nDak9RfXBcG95VJo1tm8v49PVDNd7Jh6GuTZ0B88RBJGY+dYAvWiyuK6DM5pIBhAhUEIOFNKw+KOOXW4JL15TUZNlaBDKGWaSMzQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmQv7L99p3UmO1ZwBl6sCTJsZBhzhE7iYX4+6YnDadKLvUjWBqJcPKRDYhkKjn6MkOd17hI1aqqPDhMUzJf1Wc0VXAwF1NIY8+7Kx0hPWd3Da8In1KjIcXNo1Hqe5hwsHmmlcZ5AolHnuNklA5gZGMNwRewHFOI9yM675QSzm7sEeqKssDebA1l/dPFOEIVvyWbytMGd8/OoXX4XjG3LpS1Ze4/gpXqb3AnfF9HnCcXixflOG81WSNHN8YmYejlRTHfJCTpv60m1pA4dY9PguvxqEC6PQpmdxb13FnH0jwxkn4dihaaIZtY4pOAXrGGMxWLDf4L4x0OG7GJlzI4OwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tys5cIxMnn7dQx/nl7KwEcmxWT/25exDuxXWIufoanU=;
 b=DLcqOgx6PW39N1HglyVFwscIXokhXg/Orf74NqV9V6AI2CnUlouX4so7qsAvCpzPuMeyODsiorw1LC8YDozv+fkYUFjwzsOdWcWmEMe35Oak/8/+rC2y481Co+IyL7kvrtnhILQuJdXTCMKJafnL9Nsvbo/0ua8bTA6dQoHJGMCp1fYRzl/qtsehmSTfAoDycnTKumPW1EK010B8CHnmJtTFcWAVletoeNRMFNk2IG8mQRPCCo6UH7z3gB+XjPc+BsUJUnPnOquT/dO2SHH343vmRSdMyB6Po2EdwJSdcZqYCszBHkAtxFcD0XiWZrSY0OEhfm3gfB4Fcv5A7bFSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0815.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:04:38 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.025; Mon, 5 Feb 2024 09:04:38 +0000
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
Subject: [PATCH v3 03/13] media: videodev2.h, v4l2-ioctl: Add StarFive ISP meta buffer format
Date: Mon,  5 Feb 2024 01:04:14 -0800
Message-Id: <20240205090424.40302-4-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205090424.40302-1-changhuang.liang@starfivetech.com>
References: <20240205090424.40302-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::23) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0815:EE_
X-MS-Office365-Filtering-Correlation-Id: d98cec9c-a628-40a4-5401-08dc26297b56
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gfKV8D1hEmX5ILmZin4DU2uz8X9HRrEMcwHYRHdWFg9sY6rih7huYnq9fKhbJ3VVAamz7Kr/+PcOqETv44xf4IIp5RmInP2QuehTR/qnXk86hB0M6Yw+opYPaAldQvYqq9zjXMR6AFoOStcV7L9uoGhtqPALc4Xu41BRtO0XyWFezLNYqngE9REPd7Q4xde3rcvtRxi2dG07PpP3CZCFma28wCTYZOeKFfom2VUm/TxzVvW9eTravaXo2apI5AxbG0WDRy7jA5iRCRfibOwFMe97mb48hXJ7LxY1Ca5SX7KK/HO6UklSQEIepk7FJyI2mnnS+3aaH1bVW4GtWYBRU6RiVfQ6uej3lPqQsdH8ZvTliCj/IYqceNoavBnnHxp6hTw95NyWXzlPo0O4toa9D4mo14oiZyJTUuijC3rm6rx8tGc6EwjvFogGYEiZ9eMepfGzlSAfShVajdVJYNZ5MtOc4mxnBOjWJ/v6xlhM3UOd8a0wJByYsfFBNAAzSefw37IGqbkiCRPGaSVEx/z44qTG2MpasvX9m3e/ShLGnY/HfPaIP3nGdp1k+hMbbKgW0R0yRpkHFmwmFUH2F6CyNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41320700001)(6666004)(52116002)(36756003)(40180700001)(508600001)(38350700005)(40160700002)(38100700002)(2616005)(1076003)(26005)(86362001)(5660300002)(2906002)(7416002)(8936002)(8676002)(4326008)(110136005)(44832011)(54906003)(66946007)(66556008)(66476007)(41300700001)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aHeRldoO9l0o1hPAnS+kxGlC8WcAbgFTwVFaPGdVR6mrcp93wzfCWqH4l1iQ?=
 =?us-ascii?Q?cC9bjWXY+Oumt/gtGhV/Uuu5y9yXKe7LZ/bo/p9m+HlgEAgpDOYvzRh0Lgxu?=
 =?us-ascii?Q?C3+3O5fjumQVCCKkKD189KCcaveXi1yuCPTpEgXgqzuBZov/x9Zp3M2yrd+O?=
 =?us-ascii?Q?2/5JR7+CYeNA8jOuJURxTepBZm0cqPDSvD40X+eA7D0RKckuCDXCRk6KgBhR?=
 =?us-ascii?Q?j299xPUWouovCxkYEM4jdvBZwPPWC10sEAveTtYyXh2/erKPjeCNlaTftqxL?=
 =?us-ascii?Q?iLS/tGVhTgz3s4DK901P6b0GolpZYxclVn2MHJdVJkKd18SdhzbSRLJxUmy2?=
 =?us-ascii?Q?VIjEIN8+0G2jm40W1RCWyluhdIHGaQ04P5J5nuMYjaQ1lZ0ESLLapTXL3qFo?=
 =?us-ascii?Q?BaM7buk/kZ4+oG6dMJucZBTxX8sA/EncmlPry+ShZScQWXjcE7zMfwFs+yVa?=
 =?us-ascii?Q?nGwKQzyDyPEZDYTcDN+o9n7fq1aYpLNaqhFYkA3gC2ihMQCbh7zsfWh+3WEu?=
 =?us-ascii?Q?j0Wr+TI6J07f7t5GyP+gQlhNavU6QzQB7IN8PR3isL0OqMj3EmChQ5cOfScG?=
 =?us-ascii?Q?vCmfKdmnEFg4V6JGrKDIpD0+EL4XCTqej1c2K4wkny2OfMeSZYDBlSpCXJ++?=
 =?us-ascii?Q?zvvFtqup6H5pe7/YU1egtvIM/BfoTdgKlElj2yRtEsHuVvR2fjA3fbaOV/yI?=
 =?us-ascii?Q?+pM7wW8up8ip+2VbU7clMoh8pNSVxydmb0rA4Akcprnm+26bpSLAuT3QxGD1?=
 =?us-ascii?Q?N3v+zizEI5F6AY3lbvqnYejptsZZNsJOKkdPwCCJVeYNbOjcckXUJn1bNRWD?=
 =?us-ascii?Q?RPuzkDiymC6yzlFLBPDWKuX+cbSE/G6dKtn2Bf7C+lDdEYT34ejvyRFHyqYg?=
 =?us-ascii?Q?Jsw7hNp12PrXt2FQrnMHyOj+mWpBhCji8pq/J2z/iqsqjQuxd4mLoLApL1Il?=
 =?us-ascii?Q?oxhJXAlTXvSz2pvroW0xMlqzn2bhCNSqJY871Qp9VX9Ooyx7oUhhxCxql8jd?=
 =?us-ascii?Q?zoWFB6vuVARJ1Jd/fKiWQ3Xgv2FZECY8UIlutfPygKbEAMx6eExq2dA1Y3IV?=
 =?us-ascii?Q?n3mPBVnA6vSl/nm4OCHhmRS2U4kk3CJzf9MVeFoEUK91u3VejpBE/ZXz16GB?=
 =?us-ascii?Q?zZLuJDy1X/ooqT54i8pQbZ4sOqM2qe5hip9tW9s2TsYWisrdC/jltuIwCD+N?=
 =?us-ascii?Q?JKla0n6beQ8LQWakM5pc1WhMzWigh6RRTiquPr2QtD0Fb8NollwxGd8+7HZC?=
 =?us-ascii?Q?AwTuVBcO54/0A3ZBQTn0dAZ0VnL6TZ7KROtQUo1pCFk8lCikUBh6HOP4NPO2?=
 =?us-ascii?Q?PZ+S47T2JpZBA1NWJjW6We3UbiUf3005Nv6oz1vjKFAuhFP5rgteJ0nPjf9q?=
 =?us-ascii?Q?kw8lv+hqWzr+S0nFXo1+nh8GEE609y6/puMCqfNyuua7PYGOyz+DlGi846Fu?=
 =?us-ascii?Q?yIai26C5UwiSxXFekAGFjJ1h7bpT1J8v3SnjkpZYJT50myKZb9iZ2M6OkDf5?=
 =?us-ascii?Q?PYA3krz4lZSp3USPYi0PWGZqDw1YMlP5flBCgjBXRchM9YrGk7FLQGtYF2+f?=
 =?us-ascii?Q?a1aAUnaO5NMhk10QZHBH7YcWGXMehW9fU42DQeSB/bo2nr35rtVxivxTyufG?=
 =?us-ascii?Q?Y7evLmQWvQzCkhWGyBFHhas=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98cec9c-a628-40a4-5401-08dc26297b56
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 09:04:38.5795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoAvukeq/cGYoYDA/PBIXjLY3xKa3MBnWdSkL4clQw35n/zx6OZbUPlZkltir1c3AwEMZTLxcs60L+yKzq4ZwrE3AZPZWcn34V0c3R74dJ2tr9KJ3SG2fnatBRE9o+ji
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0815

Add the StarFive ISP specific metadata format
V4L2_META_FMT_STF_ISP_PARAMS & V4L2_META_FMT_STF_ISP_STAT_3A for 3A.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 ++
 include/uapi/linux/videodev2.h       | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 33076af4dfdb..12c2104a3626 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1445,6 +1445,8 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_META_FMT_VIVID:       descr = "Vivid Metadata"; break;
 	case V4L2_META_FMT_RK_ISP1_PARAMS:	descr = "Rockchip ISP1 3A Parameters"; break;
 	case V4L2_META_FMT_RK_ISP1_STAT_3A:	descr = "Rockchip ISP1 3A Statistics"; break;
+	case V4L2_META_FMT_STF_ISP_PARAMS:	descr = "StarFive ISP 3A Parameters"; break;
+	case V4L2_META_FMT_STF_ISP_STAT_3A:	descr = "StarFive ISP 3A Statistics"; break;
 	case V4L2_PIX_FMT_NV12_8L128:	descr = "NV12 (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12M_8L128:	descr = "NV12M (8x128 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_10BE_8L128:	descr = "10-bit NV12 (8x128 Linear, BE)"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 68e7ac178cc2..349bb8efe28a 100644
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


