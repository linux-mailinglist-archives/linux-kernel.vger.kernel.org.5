Return-Path: <linux-kernel+bounces-23274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E7E82AA10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7B3EB2533B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD87014F8C;
	Thu, 11 Jan 2024 08:58:30 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2040.outbound.protection.partner.outlook.cn [139.219.17.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8E14F81;
	Thu, 11 Jan 2024 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT8okzn+fQw82pWXQnpDQoZKoXwQ13DjNjkyNkFLLqvub+HBy/lMpitnV+8YYlSnOoEL8AQqN8aRH7W/FsRG9DmW3BcX4zBeqywERz/Vua4eodKdljqnSm7LPi6uoY66ftWOMrCqo1bQNeo7l67+atG9JC/WdjW0HAIQ2+IvPUiNGlkSXp30Q21kQL/UI2vxV+ym6LKajX+s3AKPtu0qx4oLVHJROPamOce6MT3AjHetxBEbVQNe/R89A3sm9oz00KJYd30Fn/sQ01Klb4htCPuh3ms8rJCyhaZNojxGxi+CpF6oFJE39iB+lZDl3tRBQwW8jdboA0IqCQ9aaje7wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbrQo/s0w1VWC/wynUGuXozVgj4oEPkEu40VFXe3aSo=;
 b=nrMhve9hJaeBtTHelooKZNFrx9R4Pe1LqUmTukYa8M+XHsBRny4jS2R8PY0PsFUlKZhB4psNTWWMO3yYI/H/vejV6WairEzd4sGxNYNS1p46SaylFebWHN+X2wJVbEQHaPBoFBm6yxNiNFrEF7bcZJk0WY1Og5bcWjuNjGEFuXrGFp8NaFk0pFOU8UQPiC6nvhlxECOnucJPCT0Y11v+9s3HoUQpk0rhvA/P/h+f7FlZmuitZUk5fh3BjQDcVSnrWNMRmLgrxKtMwsuYxX42WrLzunxeOj0xyO7jpT+FxWJw4KCUWYEAcLRZ25/xGq70kB+FDWJFvKaJ6oQ0a4ABtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::21) by SH0PR01MB0747.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Thu, 11 Jan
 2024 08:41:35 +0000
Received: from SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
 ([fe80::e255:98f3:ba27:8c7d]) by
 SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn ([fe80::e255:98f3:ba27:8c7d%3])
 with mapi id 15.20.7135.033; Thu, 11 Jan 2024 08:41:35 +0000
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
Subject: [PATCH v2 09/13] staging: media: starfive: Update ISP initialise config for 3A
Date: Thu, 11 Jan 2024 00:41:16 -0800
Message-Id: <20240111084120.16685-10-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6d7e768-6a78-4a5b-81b1-08dc12811e83
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4GMe/ChAOz+QF0uP08DUWA+KlnKrQcAVFpKXiW+sxc0e9ciA3qJdhajoBalGXH2i2DFMIX7Uex7wynTxyNjiLBy8mJsZd/CDFqZ0n5SoPEe7KyNeU1LeM+ucFGw3DAdxwMAEnCmR+4d7th7p5p2dMgtYrZpnFvRCRc/2ojhWaBC+OjMBFRqsB9QXkt0cCJnAUUjB/q0VmQKucVPrMTFOPHeT3gdN741G3BvgEbJ1ou7+DiwlvjgYBozE9oyhezbLqvhojS4WsHdepbtSsrX7i+STE/jsiBpydMZQ1OnB9ScyDuRV5nbvhE92iY2EjSuo0lYU/BwFAeruQAKiCzQdElqKH5dPQpaHayYIL+bDlabDKCM73Jou/9aUtORGxuRXAhObZdiRM6C13Jc6uR0g4ldFDZnfktQ/WkvEBGkpgvXY8qH1+JJhMuqDZX5ToKq5juEvvgu3xO5WqX6QJR+NPicPxPw0vqEqeypIk4sfPVE3RfhYqgMaP5Oy0TvZ2StbfL9+SSZ4u7B2R9tsEUZkkaluTegO1bSTHHPLmdupEqxr6vK84VAGi72RIaFNyvSKVKu6sKCoaysu6ZTwwGYWBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39830400003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(52116002)(41300700001)(2616005)(508600001)(38100700002)(40160700002)(1076003)(26005)(86362001)(36756003)(921011)(38350700005)(110136005)(54906003)(66556008)(66946007)(66476007)(8676002)(8936002)(41320700001)(4326008)(44832011)(2906002)(40180700001)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gt3HAiEu10xpxKjji5PUsz+7UFXmrgI88wqCAtJsqlT/dgEB7Eny2rcsZbxi?=
 =?us-ascii?Q?2zigc9HZ8bFhmPRdU/7+MlH5zVZc0nLVVPZ656FzaJEU4TvJuAUOwdfDbSMu?=
 =?us-ascii?Q?Az4dR1kMCiXw67sgeHnjn3+BWIQ0Y1w/dPWm7SbIS0LnhM3juvw6VSgmXDXo?=
 =?us-ascii?Q?9z8+EMY/98f1/eSEJEugE+ma3JljzDeKUbfKRlixjI4EGFIgevlRYhnQaQyk?=
 =?us-ascii?Q?57+OH54Hyoq7wi/QQbdifJzzcMhWZMgaNhiKaBLAnJ33iplVAiQ06Ub6L1/c?=
 =?us-ascii?Q?ccojKZHzH7rJIjMK3v39uJ7rSb0PoN+bzCv4Mt74h0mqViy8AcMmKs17h4GS?=
 =?us-ascii?Q?L2jcAFO6NCmtax4h6nhw6joKks5h7KwR5uddg5wta54wFqTIpyf/fERSSRXH?=
 =?us-ascii?Q?1YfB+ESlQF9LcoASP8JXrqOjuoDmWxKreOT8XIRQsEt2oDVxd03zbdhNSVzh?=
 =?us-ascii?Q?L6RF73TG97gSjwynAH5KpfkxQPdDaZ0V3ggMUw9Z+65zt721oYCJsmf+rbCu?=
 =?us-ascii?Q?LpNdLdApEGhkkipBH7MvSFj+2da1QzQAxBgavtRpaZFwkOuHCjr00OyZw5o+?=
 =?us-ascii?Q?lLttnk6QDxBxnVJZhXmB91II806p9+qPG+FPkMWeNV7N5OQ3soL3/szMHsym?=
 =?us-ascii?Q?z8TJO+mPcrdVRk775gPYxm/xXpZheyHglpS0JdXZHnel7ZSIvNFuGiZHo37H?=
 =?us-ascii?Q?+9GZiVVCNjOmh8UMCjS3I1wTC5K9kGTdLIGZVvn5n3KSjnOAfw0qMTaJy8Gk?=
 =?us-ascii?Q?e609FZ8Nn0eYHjbcSKZYvMtTMcr6/hdDX3YjhRo9RP1PefokRd06SkgnQkae?=
 =?us-ascii?Q?F6sAbdz9g8azsqIkjA07IGHgim3hy3bATSaxGPIwpw+7ZLqbh13Adb+K1zz8?=
 =?us-ascii?Q?jGI2Hhe0MnYCXaPxbNSA/aCYUL/D48sRfFAcNtcz7EGemDS/iLcBDD5rSGLp?=
 =?us-ascii?Q?zvUwsbRf03I89lh4fDESF3BdN2xG31WuIxpBDcFYvQ9LXUZPB2Hzyw7z+guB?=
 =?us-ascii?Q?3h37J5RdLZTVTKI6Q+WZ6uVfo5ghOEotQCcyHEHEHpZ3bggxcxq/yWLd9zOO?=
 =?us-ascii?Q?jQDxJAyv0ynxQrpdY+LhucWDeGMn6u7Kr+NBW5X1VoKbvt9uwj85O8DIqifC?=
 =?us-ascii?Q?D1MO+1BE5fs6UeraGYI2n+42M8nEPTH1KGJfq8RJKNLrmsIFqgsNyHw1ROFf?=
 =?us-ascii?Q?wFazTGilvMnU9NQkNIKMYIsasSyUdf5mV9TYblHlf6XZowTmIPhNpruxJ7zw?=
 =?us-ascii?Q?FLs/3OnKwQH3803kBR6fNs/Vy74isukus5ZisFLzObWCNNSnqyS6Ok6yUQwy?=
 =?us-ascii?Q?Sq6GEOME1IP5T1gyKaOSc8I9Aq+afHtIExcYVdaD0pTLaF4gZF6QcQBQUEC2?=
 =?us-ascii?Q?8vRGmBxwpQGB69upgFw/q2Jxk9L5wz8On1WN/JoK9yfu3Lk1WGbZdhEqSq2N?=
 =?us-ascii?Q?2SIz00KTdBtk7+PNi6Cvl2KtxeRNhrltkyMD1Y6uyii6HQf7bTqtGyhQd/nc?=
 =?us-ascii?Q?XX1g5UcOOqYzGpu1GGCA+gV/8P+XLhYt5T3syMzEp+WyeT9tgrFtocf3i3L1?=
 =?us-ascii?Q?P/AephIdzmgmFZ6kr++J0BLokiGrV1rnk4nCJGUYh8buDqi5mH8a/DLyOVmc?=
 =?us-ascii?Q?M3F1KsZQ1er92+Eym9ajRmo=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d7e768-6a78-4a5b-81b1-08dc12811e83
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0667.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 08:41:35.3018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtqgjyWDFESq0/xVuGL8+EUaTkyv0865WzeKMHzvYlbFYr1QPQNsKn2yTtJSxvME/9MKDMAhPPalZX/khokwCCc+Hdl7zWHBxewc1+/9yxyNgfYStZDywW1AsgqrxO66
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0747

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


