Return-Path: <linux-kernel+bounces-52285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B1E849648
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2723281299
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B293512E45;
	Mon,  5 Feb 2024 09:20:22 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2110.outbound.protection.partner.outlook.cn [139.219.17.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC512B93;
	Mon,  5 Feb 2024 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124822; cv=fail; b=HV8OzYQ4chYEyP1UnX9TpmpllvnKmZc8aO7fOQUBkBfmyqcxRUZwK6x+3vXsHt3QFCMHq8snDFcwlHnVzOXzF04dpM5aJmLrivfU7esqTc4CmAtWik1N6mvfRIQBVKEooRNapKD1Ops6uXBhBLeWQewl5kwzjYiOAvTq4DfsDgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124822; c=relaxed/simple;
	bh=RSyL+aweMP3bUyvi8stMkrxlcJdwRksv+mZYJTY7s6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sl54Z4HeB5aoq1VLJmuLyArnZIAzaE3OykktxFOfYcM3xjPHq1ZuRH5Sff65nhz/vKWdi3Rqfeif6e4XboejUuy+dRqxmSWnmgz31Lfuo3nvD4igZoPJ1oW2lQPpHFWlDj9HcvzGDDrBXyFRHkJqoZNfhOBJjRyIIxxX5Den9qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nF7rdnTPKi1lHDwfj3iSuX0vvU0fMuXKFRFZPsWZE02o1OhXDDR4OT9y2px+WEC1lDhKJljzZ/vpRzQju0oRjvyaKOaC1yo71ZKni7uWKPeFtWtV4m5J5r9OevI0Th7WzjVHCMVNJlx4sRbYSzmrrqh0/U8QL4m0/8W7bycV0Xk9xmzOcIxURRuAOvs0EVwmOEz/EFjhzE6miKJKHuHfOFum4Udc2/Wy19ushykZmoKCl+g2dcWf8/4Bz2FRo1qh8R3PfV0hGqSGJRqq1R4hGVykreDcMe90fpa2ISJ+GU+PO8v6VFSp9wzrJAhVK0wYj5LdQGN+xoEwnXlO93rz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbrQo/s0w1VWC/wynUGuXozVgj4oEPkEu40VFXe3aSo=;
 b=Hz/MqBqLUsheoltL4Gds7Ci7OEcCriy6SLTWqpmIVqdH7CNlfUobTPegr0D3FPV96TSKY6Ic68ZnfSDjqPRM24IUYqDlCrTYbpUzJbe9MU5a/zkPLem8HcNO7fvtkXFRp6YCWDqnQMJc5J7E+LnRb1M3pILL42cz3vXQKMAzq4uDbd3hop4M6CJFJWBUDQ/jROKbLaLw5zHcM5P0wAPBViAMqnH3YvXmn9mJwlTuriUAW0c0MjLhXt43xSJtfVbeDzXeydGOb/LQ5a8zwwLyVtSXNQFmmzBcGb88Wjg1ry0BZwQ+5EXhRIy6rPGiR+Va62Y+Hm9wnl+NVSPY8rOp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0815.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:04:48 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.025; Mon, 5 Feb 2024 09:04:48 +0000
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
Subject: [PATCH v3 09/13] staging: media: starfive: Update ISP initialise config for 3A
Date: Mon,  5 Feb 2024 01:04:20 -0800
Message-Id: <20240205090424.40302-10-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: b78b2912-a11e-4340-a416-08dc26298136
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KOHFFXQofriPGRAC0QktC/Wemhg+yTSwUJ5ZVLlFb911w2JW5BXW/Ko+d8J34CqzHduSc2IIHdciRQODPJl6lm+GQIcdOWyK6HT4zU6Oz5K45CVkOPH3DXqEfCMa00abbAgHgSQGcSubcZWseyvvaf7U0f5a+veHpoXaRO9okCsjnHCCwiq+owRBH6OQ3tvjkNVBK4jsUKUdS+63UzBwL7a2NhF0OqKiDEuDDj+aamZXdM0V5RH2Zcsq6rg/Ms01M/AHIVi2vOgG0AteVNrJN2pxqbfQnInxzbukosU4+JUlyOBB9dOGKuF0hTMh/EmG50dLk1Q1c79P91uWrRFpypjM/GITu34Fypoc+vrs8BWPAZqKg2ISR1Ink6kaXnIRfZvBc65LUwjyAxf6pYhhyOSZgvBMcO6BjAj/S1d6SSA+/6lMNP/Ra9u+vqeOMPvDP085MDPZlimU3ZWtyZHb6wC1cMPEoJnibVXPM+IsjgsSIMfoch+mjQ1r+YIYYyO6hqjbDv9xJQ2Z//5eD5T1VIHYnPqVTwE8djeXQvhHvRKAT22gNBdaLgdckv0Ir6MFhs2LBw9tfJ1kY5f0F+juqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41320700001)(6666004)(52116002)(36756003)(40180700001)(508600001)(38350700005)(40160700002)(38100700002)(2616005)(1076003)(26005)(86362001)(5660300002)(2906002)(7416002)(8936002)(8676002)(4326008)(110136005)(44832011)(54906003)(66946007)(66556008)(66476007)(41300700001)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vyFxjdOqO6EDAyP7tRUKOjRKRX9K40G0yP3OJVnigfkIoCs3Gh2GWfnAEP2D?=
 =?us-ascii?Q?foeIq7re3TIVQD++t81z6MDAtRSmJ/cJWyUmE+oGvI07mUKqc1yb52C92HAv?=
 =?us-ascii?Q?PlDYj+mOD3iICKuA4e7kJBm9QxJgC3Cc5OnEWgV7f2HNqAFAXCpxZKSSffg/?=
 =?us-ascii?Q?QEzlcIFP2SG9yWAr443cz/VqH8OexUJgPAhQbDfqEXNAlrTXhfZ0WJxkCMOC?=
 =?us-ascii?Q?hWNFG6m1aTFzGf4Jx4zXhgkvhLhJ2iPZtmr0f6PhkcO7KnxLl9eJEd815+Dp?=
 =?us-ascii?Q?E/VGVhWCJjiBLiSzVnkzspyst33+AWk0UzqMkffPYFUSm/tFkE0MtI7WWKoD?=
 =?us-ascii?Q?B5pAI5GlZPVk8Xw4eNl5a2r4lUTah37+QA1zA+ddEKH5Na6qmYKi1ZZyUDZX?=
 =?us-ascii?Q?L7I7xkr1aDm1OD3ekuhMrtmAC3RPZpdYYOFA1BMJj95Vu3jRXH/B6MkvMe4a?=
 =?us-ascii?Q?+2U8zqWqcwAoC166S4jGKzF4MzIgUyL0r/KIye+GSfvPrtO7M8n1TPfTJyeq?=
 =?us-ascii?Q?Dd+KalpX9x9fhHvxPvyWN8qzmqgwT95cjzwLdqwYKffdjrc8V67mK5GJkb7K?=
 =?us-ascii?Q?3sbPaAFFS3R5igAZzbKExLv51t1MEEkQIsbl4ZiIgB32oYAUo32iqdn7GTd9?=
 =?us-ascii?Q?FHV8M/ol9XD7UTiwRnGwz32tIpI2c9RiT3Kdj/qcJaVjp/FSQYqhZzWk917t?=
 =?us-ascii?Q?P5IDs+l3WagxqpXIJ3pN0ju0ZNuG64I45lOlkkbfQv1j91avmfY1C84Ihj/6?=
 =?us-ascii?Q?LhWyGHOJgqpetglKrzznieGJAlbEY9H6jbRWaKi63tmnsm4GLpMPwVljFkbp?=
 =?us-ascii?Q?eofTxk6PYxN06HYONYv0cr29P5ViZmq9nsNOpabTsHhf8ywfWOK7/RlWgrqz?=
 =?us-ascii?Q?cu6AX0tqp3YNv4VBy41n9ZeElzGQaVRjNHhrL0xgzLx1rnXJJjb2+1aiHfU9?=
 =?us-ascii?Q?DioTl2CdHov089BPrgUAX+CgbaDDtL90S0RxSUWSs1jU/I1FNBb366Wmqn/+?=
 =?us-ascii?Q?FrpROSTLGDiYWIurtY8AbEnqyOvy04SDtRd+WrTve+PGyzFj0yxhc6wJgaC0?=
 =?us-ascii?Q?0hRmVgH1VCkSyKzyYDp8KSrR22h6Tq9UeigMkB469BlMiyqzai989meb0/WZ?=
 =?us-ascii?Q?qPEZvMkmA1z1RrWwSJQsy6rAVZjRhvN0MihMeRqr8AYyGIA6Wjy4jm+GeCmT?=
 =?us-ascii?Q?CBiWCybXRGGA+SSrilf0QWmydhuKPiw0aK0XIRdmC5fDwvTluAeaFax9kQXX?=
 =?us-ascii?Q?oxmyJFRXopTYH64ssRuD1r0M5FFIMImm0JpktSR33bysXv7Y4p+OiJkZmoc5?=
 =?us-ascii?Q?b+xtzT45cW9rmAAArWME7uwNl7c4uJgWHyJqe9atjp08vupI1qdaiLYBH4AC?=
 =?us-ascii?Q?jBsBDTcp+JHXlZY2YfDowJj67j9o0WPzPvD+BcwJJ4o/+hGcK1h+mUKu00xp?=
 =?us-ascii?Q?u8osCiIfZdaIy28LWm/CjUUXDfqf1kMGT3cVAPH51pRq3PYaboj/V2DpLljl?=
 =?us-ascii?Q?C0No6uqtUCPF36RO9Ijr76SwrKXWIwKWQ+Q6poyX5TBV7VdJPnjTF+pw8fSw?=
 =?us-ascii?Q?bfGU77ig2WTM8c9Cu/r4s0akzvJ/Qu6ltvqXGpeO9PFmyVkG0axb9xryk8vs?=
 =?us-ascii?Q?mcrtOqWIKTDKs4OzTcytNJ0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78b2912-a11e-4340-a416-08dc26298136
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 09:04:48.4525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIrU2VKZP6MtJhQU6t7xdQiMoaCFMmCQ/bTp5nJi3Jv5IL5STb/tiUAPmDszZvOywR5leeCZsm6Rf0AxErPW4LjwnQxd5Sa6qcAp3xJSd1//7Qvni+EBhA2HpeCi18DC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0815

Upadte ISP initialise for 3A statistics collection data.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../media/starfive/camss/stf-isp-hw-ops.c     | 23 +++++++++++++++++++
 .../staging/media/starfive/camss/stf-isp.h    | 21 +++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
index ae88668e5798..c778251e0024 100644
--- a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
+++ b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
@@ -300,6 +300,25 @@ static void stf_isp_config_sat(struct stfcamss *stfcamss)
 	stf_isp_reg_write(stfcamss, ISP_REG_YADJ1, YOMAX(0x3ff) | YOMIN(0x1));
 }
 
+static void stf_isp_config_sc(struct stfcamss *stfcamss)
+{
+	stf_isp_reg_write(stfcamss, ISP_REG_SCD_CFG_1, AXI_ID(0));
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_CFG_0, HSTART(0) | VSTART(0xc));
+	stf_isp_reg_write(stfcamss, ISP_REG_SC_CFG_1,
+			  SC_WIDTH(0x1d) | SC_HEIGHT(0x15) |
+			  AWB_PS_GRB_BA(0x10) | SEL_TYPE(0x3));
+}
+
+static void stf_isp_config_yhist(struct stfcamss *stfcamss)
+{
+	stf_isp_reg_write(stfcamss, ISP_REG_YHIST_CFG_0, 0);
+	stf_isp_reg_write(stfcamss, ISP_REG_YHIST_CFG_1,
+			  YH_WIDTH(0x77f) | YH_HEIGHT(0x437));
+	stf_isp_reg_write(stfcamss, ISP_REG_YHIST_CFG_2,
+			  YH_DEC_ETW(2) | YH_DEC_ETH(1));
+	stf_isp_reg_write(stfcamss, ISP_REG_YHIST_CFG_3, 0);
+}
+
 int stf_isp_reset(struct stf_isp_dev *isp_dev)
 {
 	stf_isp_reg_set_bit(isp_dev->stfcamss, ISP_REG_ISP_CTRL_0,
@@ -332,7 +351,11 @@ void stf_isp_init_cfg(struct stf_isp_dev *isp_dev)
 	stf_isp_config_sharpen(isp_dev->stfcamss);
 	stf_isp_config_dnyuv(isp_dev->stfcamss);
 	stf_isp_config_sat(isp_dev->stfcamss);
+	stf_isp_config_sc(isp_dev->stfcamss);
+	stf_isp_config_yhist(isp_dev->stfcamss);
 
+	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_DUMP_CFG_1,
+			  DUMP_BURST_LEN(3) | DUMP_SD(0xb80));
 	stf_isp_reg_write(isp_dev->stfcamss, ISP_REG_CSI_MODULE_CFG,
 			  CSI_DUMP_EN | CSI_SC_EN | CSI_AWB_EN |
 			  CSI_LCCF_EN | CSI_OECF_EN | CSI_OBC_EN | CSI_DEC_EN);
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index 0af7b367e57a..eca3ba1ade75 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -110,9 +110,19 @@
 
 #define ISP_REG_SCD_CFG_0			0x098
 
+#define ISP_REG_SCD_CFG_1			0x09c
+#define AXI_ID(n)				((n) << 24)
+
+#define ISP_REG_SC_CFG_0			0x0b8
+#define VSTART(n)				((n) << 16)
+#define HSTART(n)				((n) << 0)
+
 #define ISP_REG_SC_CFG_1			0x0bc
 #define ISP_SC_SEL_MASK				GENMASK(31, 30)
 #define SEL_TYPE(n)				((n) << 30)
+#define AWB_PS_GRB_BA(n)			((n) << 16)
+#define SC_HEIGHT(n)				((n) << 8)
+#define SC_WIDTH(n)				((n) << 0)
 
 #define ISP_REG_LCCF_CFG_2			0x0e0
 #define ISP_REG_LCCF_CFG_3			0x0e4
@@ -312,6 +322,17 @@
 #define DNRM_F(n)				((n) << 16)
 #define CCM_M_DAT(n)				((n) << 0)
 
+#define ISP_REG_YHIST_CFG_0			0xcc8
+
+#define ISP_REG_YHIST_CFG_1			0xccc
+#define YH_HEIGHT(n)				((n) << 16)
+#define YH_WIDTH(n)				((n) << 0)
+
+#define ISP_REG_YHIST_CFG_2			0xcd0
+#define YH_DEC_ETH(n)				((n) << 16)
+#define YH_DEC_ETW(n)				((n) << 0)
+
+#define ISP_REG_YHIST_CFG_3			0xcd4
 #define ISP_REG_YHIST_CFG_4			0xcd8
 
 #define ISP_REG_YHIST_ACC_0			0xd00
-- 
2.25.1


