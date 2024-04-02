Return-Path: <linux-kernel+bounces-127712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872B6894FDD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5661F26668
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7035DF0D;
	Tue,  2 Apr 2024 10:16:51 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2100.outbound.protection.partner.outlook.cn [139.219.146.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680DC5B1E4;
	Tue,  2 Apr 2024 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712053011; cv=fail; b=hS8Cm6YZXRJLYcUT4htSR9uMZD3/9fJRzmYFjxCrhzSbp6HT6JTJNClFqU51/MxvR2FFNZ5aITFVtOV0Cs9XoKm+7MhuiVasc8SZ4sM2WmCZ5yl+oDqnuZW5qbnzfwg73CDfkX7favmVEOGROsiUms87fc5GhOlQ99ZYXNKMEhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712053011; c=relaxed/simple;
	bh=1jsNSzcZJQxwnztZGcLKpgcyMoi6HgGenOf9AFmjySE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UD6kIfU7qMFt6n24AkaFKy5uc545K3q0EMyGlk+7qaQqtRN2Bd36BJgRL3GcAbr8Zyaynj7cX9zCOtur+hLuzR70jJUOsdxGVAXE46aniUWjhpcIxBd/qgXRACFW5vGAM0GUTIZ6bAPS32efmEkyncdl/PaD+yRgHWWwZxUzp3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hijIz2dPSs/rrsptoLXV0rZ3kczby4U02Gadb/InielvfdZzzC4+cFIqgpymJeam4klYYRmiMCm2nJCT3BRkShDZrc3AVK+x0seqACIp1qPfFRxoWaqyhvI5KCl6IzsAmVNAx/DdsH+UEipXLN7jdBin6npXQR+GMlvBxwKuJUKCRaSczl1UpXM5HiEZGB7f+2P5QcnF+pVaDoA4EDxli2vII88plsl26CShNp4oynZQgRTlcrFuuPh7+QPeykj381kNqn9zLLOy5+99BybwEa0wV/A87JqKlVbISw59wub6zcRw4j6foa+dOdI27JDYOnET2EctqFPB7wNYSwfkGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTyRtTjTprt5edZgI0pRawIc56nV6QnENHlmP/oD6YY=;
 b=iZD01BkkGjSv927L2VwvOPllBB2xnnhL5ENpo3BLUwqKj4NY3xjYAcpOSrG5N1pB+NHvwei2kDwHG/pVBpXk/qLewYmUGE4TkhlZ4fXLvAiLPWzfGBYgPGuflQT5aDUhMJwjWIa82oHRh1aFG5GHVFUKMtt+r9AC3qg5nJXgZWLx7iQ6PO+E0sgoiTz8XCrEu+nDoPJvE+NCyfHg2iu5ezjbHveWUBHbFNn9ycp5T3IL0Do88phxzBc5GzwdbP/nraKEhuGpYAYmlpzGah+Xz8mWrCo3tVpkq3QU2j7xvBCCkfkkfe+njleg+p13iNUQQeXBcQc2HA7w9xiWeHOQxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0462.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 10:00:36 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.038; Tue, 2 Apr 2024 10:00:36 +0000
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
Subject: [PATCH v4 09/13] staging: media: starfive: Update ISP initialise config for 3A
Date: Tue,  2 Apr 2024 03:00:07 -0700
Message-Id: <20240402100011.13480-10-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0462:EE_
X-MS-Office365-Filtering-Correlation-Id: 228ab50b-6775-4adf-a629-08dc52fbbe29
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lSBdTQvul5hpVeubjjuG2xS/yUP/OukHClyKQZ8ZcWnHMTl2kKPh9JL7ym5Lt3Ro30i1Xe2mkEMYkFHew553hJc2+hI1YQim2zU1bDyyJP3EBiseOc/6/Ch0kCy2wGU6Ls9L2caZAm0gnPWN9DZm20pfRYV6aYmh8xHJx8NWvCO1oewCvLBeHDx4deDK5be5PYoA58L67Rrbf+tIUdSBbAm1xtHhUYgmGJi58slPvLlhcQEle1fMaTQc9TY4i6Ozkx8cQeBiRruUXRYAcL5kZVyqOqF0ldnI4q9mtp4E7Ri54xz/y4blTKVf6i5cTe1hwKjlG14PTTGMCrPFy/p6qrD1bI/gnmjptlma+cCVZFjsbGoOpS70pTMh93FtHtG+jmdd3ctmNHOohX0/ZeHUvqarDSylXMxyhQINIAKNLxPg5oj+7zaigtcyKbgMvzYZE1PwEZPuhUtUZq/nRVAhw8JtlmgBdcVh3yBllq5Ewkcuyu42/WfSW8KF5JSCYJeV9DRzR2wsNP1KRZPkE9KsbWMd8bXlrCsjNau3EowO5bYULGthvE6725G2gDMnm2MQ0mprzfXl0oLeaDwkuRyHOzZ1OSWIZsiNBaWtEj4OZa/VScvRgEt9WsYTS8KK4952p7mJSwJhaxDKpVUdNRT37Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N1TZoTMwLsaK8EIt/1OQvq3fy1DynULwr4hPLCzlez4EzOHto5aRLIY2QwG3?=
 =?us-ascii?Q?kcidopEAwv11YHG0FkCid5WCw0De1ZnXRrAFqDgSbggFeT1q93T8RDFIkWlq?=
 =?us-ascii?Q?bC5i2MCaAABvqJHmsGYudFaTEh47GT5typhsGh0DjdZNUZ4Uh8/odX0U7v77?=
 =?us-ascii?Q?ezckesuyF8SaVfX6toS6MsXiWhv61rkK7kP/SL6QfH1XIJd1Tc1IZWIxV/M7?=
 =?us-ascii?Q?G8956MDfywJtUMq8Yfh6Le3gLxD/s1ToPHonOyV5n3JP4VsFBxn1ARCXvae0?=
 =?us-ascii?Q?qxNDm7OCAfCbCf45FPPkWT0FXA3fPDGP+bCDoMj/0HE9STsFFJ9Kj0Fx4hmF?=
 =?us-ascii?Q?+M3JoJvjTKhdtAyIQ4Udc8OiTmtIeHQhy4FxnqLVN5tEnK7Xru8dswRI3Li4?=
 =?us-ascii?Q?NDSuAKGeOPeduOaGGK0Y3gKmnlyb79RI6eV5GgE8fIjf+0kZ+ZjAvaK5+XMZ?=
 =?us-ascii?Q?km+S//9E9a5is01CCow1cDx4YHmlFOTPVEbHwz6orhxCvPuPFtcJO71TH6xO?=
 =?us-ascii?Q?XTQ7Vn0VhrY+kA2OaEVv9cUaCiYEUvEWk96/5aiXpbFs94mADy7a5vlZR1Yh?=
 =?us-ascii?Q?V29gpULstNa4Aav4n6d6T9+lE88KNCvM0ZaH+ppzzps20zpiCiY3UlsID4iB?=
 =?us-ascii?Q?WF6gFbdFFpFp/prKjYbjGfNsNcakpFMUkeJpHFAhItVGc5gs7TObFyuOwVmi?=
 =?us-ascii?Q?CxgDAgGKDLCT/hHK89UB7AUocKKh4zsTzyzTdSJrCpjZQdkWKBdTz2Mxtm++?=
 =?us-ascii?Q?atoVNOFTxdGvs7K7ujh8f7j6mk+EcsLLL7bVtziSGC/E9FWn0Phb17gEQ/qb?=
 =?us-ascii?Q?mQauX1FxZITGczwGtx/jW0iChE1xSphCAL0p45GOn6r1hy4dWP/vkHJwbxc/?=
 =?us-ascii?Q?LnjW4DlN8IYf/RLlfSyFY8exTKd+u7Kc0S7zvQR2Zdpbha80xEXRQgtxN2uk?=
 =?us-ascii?Q?nWGUsbaJTpqj7VfbqEHQRgn6ZzAg0B9sbpabmqMct8y7WPhVeU5SfQ2cweqH?=
 =?us-ascii?Q?cPS6oKasyOOE02Na/Ydkl2iVv9jnLoBqzlQIdLwgPVmxPRDHCK6/QO50QDac?=
 =?us-ascii?Q?QtQIkiN+dX50D7oj50DQLImU5nTnmyWcqJbScPpYdSLfvNeTL1TKrLEHY/hr?=
 =?us-ascii?Q?AuKIW3MiHXd+oUGAQOQkarWq3FXYzPvBjBBkDhZGfeMswJW/a+OP8QD8j+v7?=
 =?us-ascii?Q?a4txb6PqDW9ufY2F9ohTo0nqXGKmU4rZ7KtbdlqPagROeBOSot9uRiSw0CHP?=
 =?us-ascii?Q?O8r8gKbipXZ7rGzPpiWlYyZMdtv1VObFJzlhMkaZczqP83SmIK9tdennnGn5?=
 =?us-ascii?Q?xzn3737AAT8XtMxD106MHgGQ1yjdGYghKsg/o35TwNZZzw9MrGPDmXBPDAyx?=
 =?us-ascii?Q?PHMqY3OKguUVWblY1OZQzMnP902TAzLJG/RxXtdMn4/TrdvJtyB9JwQxZ7pu?=
 =?us-ascii?Q?B35LcP7YtvMHGFIM6Uj16HJNx4wY2o3+Wy/Oqaf3a4S3DVBF1tqEdL3pCZme?=
 =?us-ascii?Q?m4eEy6w30sB7n+yFRFMirPjPIfxSb8eiqtVKk3+P9A57mTUhSDEOBHCNdZOt?=
 =?us-ascii?Q?kFw/ODQ69uUWN+6yTT0EIM9nSnQRhhjlVS9RsZCmND6OJPDDP9drSPvtA06g?=
 =?us-ascii?Q?9TNSSJC0ChlE2qIvRAA+bvI=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228ab50b-6775-4adf-a629-08dc52fbbe29
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 10:00:36.1542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqK2DaHGv6rJFyrgnbJG4G771U4FQIEGkNLkF+mK2WyeM67gEOrzy+bz/J7nGpp/sq6psckjhq0vSzW5DLHIBpps9yziHJj4cCQscylpF5fTm0JlK7+NILxhXZ76yAE+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0462

Upadte ISP initialise for 3A statistics collection data.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../media/starfive/camss/stf-isp-hw-ops.c     | 23 +++++++++++++++++++
 .../staging/media/starfive/camss/stf-isp.h    | 21 +++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
index abdfa4417145..7b2cc596e967 100644
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


