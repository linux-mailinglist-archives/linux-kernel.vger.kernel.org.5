Return-Path: <linux-kernel+bounces-52282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC87849641
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E093D1C219EF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D28212B96;
	Mon,  5 Feb 2024 09:19:27 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089B0125AF;
	Mon,  5 Feb 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124766; cv=fail; b=txTtVjCi+25RLV5gbtgKTM297XKFe2kEbx6Qg4bKXNLJnyLnGf7Iwzu/5ekFnFw5jmOuqc7GU92xCY/rsTSkfkxhRPPMKqrhxT2ZO9CGfhX1CSc6uurlNydMt+l1BkNbmDyYGBCTjkj254IbfuK/DRtCBcXoujmWSVk3xERK+yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124766; c=relaxed/simple;
	bh=xaRnqo45z0ApjhTqs02CZucb69yQYidNC+qlxfr0jK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bp20cSlxy5Dgv75cntcj6uM5y1Zb27McYL05q1aKAf+xl3h4z+K312qW5PL0ULta2alYPW8/z+Jm573oXJSMdMlsFQ3Hagd6UWlK5yxaBJdFMjDJHAfTx8cc7ZvjkhqqqNE/u4xOIbaDAUNKg2Tt76wZH3TpUd5oD0a/lzMal0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+exHjZlWejtStaB+kbPf/oGucllRu5q+rVYzZpbyAL4cETMcFIVskvuZZRqtPw1DE7ZL7prVwsLBUlmsHYzo5xn3vBGba62JH2CRyypfPym4kh1ZGMAX1azYvK94mUQmLWwYmiQGOfSP1vV3KRop81fIqUOOwuCKDPiPCxzhDnZYab8UL71RgkYgIWLgfvPiQ5hU1kSvtYAPJgjc0PIHspEWtY4fboAsN2UrwLi8Rw9jv4kn3FWpij4xD4Ux50lI4Vxfh4dXZI9MGduY+LwVqKF2DeVWuHGRxHGjsyFZE1zxwnv0+9AjlCoDkiWdIRBiTuSVTH+XtYNIWW/sSGPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Jy/SuAcG1gIwP/kIZ5O9qAhT0+XRn4JxQLxdUQoFYw=;
 b=BxxqkH4MbyxpAJXkpPLgkYW1kuJz/8xYrGxPJ+HDX/5whz0ZkB9A7oT9RJgsOJ5enxyr1pAIJ3YtwRFqS0qre45qlaUsCxvzQAWYcTK07YN2sNlfiIWWcJ9UBYtF406NWM5s7OTeAqdTO/AB3FkIa+tfkOI46UJ0pTHoC/3cSX8r6N5bqPYYtIptYh2iEfSmhd0F+E82wfpaZ4u/ePHz81oDklDn0Z5maiVu0oeEsTMlnPCaf6W46N0qUboBbAzt4o8exDWUXoA5CSpeo77o1zY6lwUPaLGEuk/UPaMoRR9FV1VzhQhIIqzAlxmZE9EH29dXbViqq0RDrwQlNi7f3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0815.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 09:04:45 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.025; Mon, 5 Feb 2024 09:04:45 +0000
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
Subject: [PATCH v3 07/13] staging: media: starfive: Separate ISP hardware from capture device
Date: Mon,  5 Feb 2024 01:04:18 -0800
Message-Id: <20240205090424.40302-8-changhuang.liang@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 35bfb7f4-99c8-4d69-d894-08dc26297f3a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HMczyP3m/DH+hBLUDmdsaWY7E1pnGsOOp8aQFqwl074Eblid2NFb9bVvNH5j/olcEJLDGLGEyF/Obf8k0ME3P5Rk7V5QLoaREuneR7KROYjIWBNTVtJBMhdI0jEwjW6HcNkXSRgtVsNaRpcjMAHsp3mBsVmWX3fw5C5VwoZWj7+ivvEEZPQdjWgNeyIDu8XmhqwEWnCsnUZwJZ07D8Q7gPw/2+5Y4wbiggYvSE0C9fAOd7ESJDOJnL80rj6v+vAgzjStFUtT60blZN+ftsdtK6K2EwZnaSCo7hG2lG8Kuaq6zCW2vXA9ShxOJ2Vpe6DZlbz7IZ9tHikYXzKImNHzifqua8Plyg7kyyGQrWB9MKrqbut6eBMvkRHEqDGj9qifIMqtiqAYpoBndGtCCDRefDShhCaMLVJnLJRTHgsr38YZi5C9GHX8I3jEr+9UtQAtK+cBRVxpZReGuLbH7q2fxEnwTZk3sJPt/fYS/wXe56NXBRHTunTRwvahI+W42NRihMG6zzHsYHe8X1YnFNIMLZkLqRRZ46uUow3FWxPRsJ3JldRYkX+0O8RgwRFnDt4ItmkZy5/l+3AjyiobJXFx0w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41320700001)(6666004)(52116002)(36756003)(40180700001)(508600001)(38350700005)(40160700002)(38100700002)(2616005)(1076003)(26005)(83380400001)(86362001)(5660300002)(2906002)(7416002)(8936002)(8676002)(4326008)(110136005)(44832011)(54906003)(66946007)(66556008)(66476007)(41300700001)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1HNCs74MkbAOkVXEUe2iXU7IcWz0DnSQd89KZC3jXUoQR6PCatif5AxD4rdX?=
 =?us-ascii?Q?Jh46lDF3KIx1hBi8xHxlP3qAMtcuHYc2isXCQTQOjuE/+p12RpPu2ZXUccKN?=
 =?us-ascii?Q?zAtSlHFLdTHh4mesWzpZyFuaTTDJxyO5toquBVPZLNsMhOpbtrAmIezHyQCd?=
 =?us-ascii?Q?c8v5c5iYf4cLqXwc288zov6IP/kEh5T3qbX8cWAWDnPjQzpStYZMBowh6STk?=
 =?us-ascii?Q?QD7NrNCP6uN8cFKHlh6wSJ7ujG20yYfZCuMTFdxXsftnVDSGme+yjDRx7b+x?=
 =?us-ascii?Q?NtFqV2PQnnXe5/reggUpwsw0gjQSE7L5lqZsoDPkUVH7wj8fpUcQpZpy//PL?=
 =?us-ascii?Q?ZMwh1anhTxSHpE6oJuZLdkITeY/6rrqMJep8tVA5vQ6Lno7ccMytC8eIA0WU?=
 =?us-ascii?Q?aqmdflTh17LGk4tGTLlMTmNpkqlHPD/v0kimXdZF2LSY7s1xFvFT903d/gIn?=
 =?us-ascii?Q?kvX+8pYFZOr7l2FQqacf77AtXHNkcozQhrnwrY5SVm3POHaoutgbctCWNjqM?=
 =?us-ascii?Q?PM4SXAnM9JPtAPreglx0GyCHBkPxGynV3K+teBkNNJVI2m2DyP61gLiw/qnV?=
 =?us-ascii?Q?mdZuUWW5cLHHSz+rGuo5FxPMkNUcUZsOaxlBqbqGbG/z3XCmae2H/rncnHou?=
 =?us-ascii?Q?iXIQJsXz5zBAn+3atSC8ng4G4Gah3XxrNVeDS1MyE3ikXDP8ZpZLcbVTCXWX?=
 =?us-ascii?Q?oxjyksL7plebp7wFdzZhfhGxvCMEywTh7+TbFnfLVNIZfv0yMZoERxWd+Dn8?=
 =?us-ascii?Q?rFf37ood1TGTJf/MastE0SFz5jbFA0xazTHxY64E2t4o73IdGr4ACgvD7AqD?=
 =?us-ascii?Q?54JogT628clqy/pR4T2nhEEnHynBO0vdS9WQEmGzX/2bE6jY/jm/N2o2TrRr?=
 =?us-ascii?Q?JV4TPoxtyNNgimciJ3mvnhR8VEoI3dnr73dtDgKKkxNtQrO3l9M37wAj2pb2?=
 =?us-ascii?Q?fQEEKJiWNiyF+BpBdhn+8ERDHzYdRUJKDjKl2Gl1KWkPVwtlAYDIjLmjSFac?=
 =?us-ascii?Q?1DQtZLWNfvoCTD2vHvbjOT34HHovKb18S9nRbZujaZcbP0Tsjxq5dHW+EVbK?=
 =?us-ascii?Q?07RSTmR1d5SL03bpIME6a4hMMiTMXaOZDm0ZS5N0+lHnqCjtmq3bLkUwYBiG?=
 =?us-ascii?Q?Lye2VnCeMZL5nBiL2mU1fA3hmLF9/IY0mHGSibp+2rYGD8Ir/JMzhgYiAlHu?=
 =?us-ascii?Q?RybKZcL1rdPd5siP7N/yqB52oRNj6SbNiFdD3md0Y8LrCSQl+E+sbqQBI+HS?=
 =?us-ascii?Q?TqdH/4gDR7yepWOQreLIiEczGk0QsK7ZSiSh36k2+DKHTlHJfJJmZeExdzwp?=
 =?us-ascii?Q?AIQPVg/IHoV/80naDyS1dcFu9z/I4gG/ANzz/R2ru8IQrDHGhrP2djvONJD1?=
 =?us-ascii?Q?I/UanxJZS8GDITokA1DPCWifjb7UXTyJn5tp2qWzQ5S34wFcM6IJzsJackIA?=
 =?us-ascii?Q?ph1QtnTYKwe8RGn+j+8cZRQj6nTQ3NH1WSRdZga3V06AUJdUpiniNMTj68/Y?=
 =?us-ascii?Q?4UOITfznk6sDU4A5+KtVJwUfDhI5k3AJom1Xj7eYsrmOpdevDe7TGGSFdvg7?=
 =?us-ascii?Q?q6ARzdb9N4I+lbKkVWAXM1m/ezxEV0ZP3LjgtdPu3qn9sHV/K/OJVaQ20Kwb?=
 =?us-ascii?Q?kIYg10Cy/o/T65U3kKmnWqI=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bfb7f4-99c8-4d69-d894-08dc26297f3a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 09:04:45.1032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBpUjGrh+Xnp2JwuSkg2LBrNyR5NkpBZjMokkXmPGHIWpTRea8RgFonbARUhdsWD7RIJzeW48OGzmfJcP/8wNyFEQ8LVf124uUI3JKco5i84ziyhLcu88ZjC7P4fm2pA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0815

Some ISP hardware operations also used for output device, so separate
them from capture device, move them to ISP common file.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 .../media/starfive/camss/stf-capture.c        | 60 -------------------
 .../media/starfive/camss/stf-isp-hw-ops.c     | 60 +++++++++++++++++++
 .../staging/media/starfive/camss/stf-isp.h    |  3 +
 3 files changed, 63 insertions(+), 60 deletions(-)

diff --git a/drivers/staging/media/starfive/camss/stf-capture.c b/drivers/staging/media/starfive/camss/stf-capture.c
index 5cbafac46ee6..e91e726a1462 100644
--- a/drivers/staging/media/starfive/camss/stf-capture.c
+++ b/drivers/staging/media/starfive/camss/stf-capture.c
@@ -66,13 +66,6 @@ static void stf_set_raw_addr(struct stfcamss *stfcamss, dma_addr_t addr)
 	stf_syscon_reg_write(stfcamss, VIN_START_ADDR_N, (long)addr);
 }
 
-static void stf_set_yuv_addr(struct stfcamss *stfcamss,
-			     dma_addr_t y_addr, dma_addr_t uv_addr)
-{
-	stf_isp_reg_write(stfcamss, ISP_REG_Y_PLANE_START_ADDR, y_addr);
-	stf_isp_reg_write(stfcamss, ISP_REG_UV_PLANE_START_ADDR, uv_addr);
-}
-
 static void stf_init_addrs(struct stfcamss_video *video)
 {
 	struct stf_capture *cap = to_stf_capture(video);
@@ -307,59 +300,6 @@ irqreturn_t stf_wr_irq_handler(int irq, void *priv)
 	return IRQ_HANDLED;
 }
 
-irqreturn_t stf_isp_irq_handler(int irq, void *priv)
-{
-	struct stfcamss *stfcamss = priv;
-	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
-	struct stfcamss_buffer *ready_buf;
-	u32 status;
-
-	status = stf_isp_reg_read(stfcamss, ISP_REG_ISP_CTRL_0);
-	if (status & ISPC_ISP) {
-		if (status & ISPC_ENUO) {
-			ready_buf = stf_buf_done(&cap->buffers);
-			if (ready_buf)
-				vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
-		}
-
-		stf_isp_reg_write(stfcamss, ISP_REG_ISP_CTRL_0,
-				  (status & ~ISPC_INT_ALL_MASK) |
-				  ISPC_ISP | ISPC_CSI | ISPC_SC);
-	}
-
-	return IRQ_HANDLED;
-}
-
-irqreturn_t stf_line_irq_handler(int irq, void *priv)
-{
-	struct stfcamss *stfcamss = priv;
-	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
-	struct stfcamss_buffer *change_buf;
-	u32 status;
-
-	status = stf_isp_reg_read(stfcamss, ISP_REG_ISP_CTRL_0);
-	if (status & ISPC_LINE) {
-		if (atomic_dec_if_positive(&cap->buffers.frame_skip) < 0) {
-			if ((status & ISPC_ENUO)) {
-				change_buf = stf_change_buffer(&cap->buffers);
-				if (change_buf)
-					stf_set_yuv_addr(stfcamss, change_buf->addr[0],
-							 change_buf->addr[1]);
-			}
-		}
-
-		stf_isp_reg_set_bit(stfcamss, ISP_REG_CSIINTS,
-				    CSI_INTS_MASK, CSI_INTS(0x3));
-		stf_isp_reg_set_bit(stfcamss, ISP_REG_IESHD,
-				    SHAD_UP_M | SHAD_UP_EN, 0x3);
-
-		stf_isp_reg_write(stfcamss, ISP_REG_ISP_CTRL_0,
-				  (status & ~ISPC_INT_ALL_MASK) | ISPC_LINE);
-	}
-
-	return IRQ_HANDLED;
-}
-
 static int stf_queue_buffer(struct stfcamss_video *video,
 			    struct stfcamss_buffer *buf)
 {
diff --git a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
index c34631ff9422..6b3966ca18bf 100644
--- a/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
+++ b/drivers/staging/media/starfive/camss/stf-isp-hw-ops.c
@@ -443,3 +443,63 @@ void stf_isp_stream_set(struct stf_isp_dev *isp_dev)
 	stf_isp_reg_write_delay(stfcamss, ISP_REG_CSI_INPUT_EN_AND_STATUS,
 				CSI_EN_S, 10);
 }
+
+void stf_set_yuv_addr(struct stfcamss *stfcamss,
+		      dma_addr_t y_addr, dma_addr_t uv_addr)
+{
+	stf_isp_reg_write(stfcamss, ISP_REG_Y_PLANE_START_ADDR, y_addr);
+	stf_isp_reg_write(stfcamss, ISP_REG_UV_PLANE_START_ADDR, uv_addr);
+}
+
+irqreturn_t stf_line_irq_handler(int irq, void *priv)
+{
+	struct stfcamss *stfcamss = priv;
+	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stfcamss_buffer *change_buf;
+	u32 status;
+
+	status = stf_isp_reg_read(stfcamss, ISP_REG_ISP_CTRL_0);
+	if (status & ISPC_LINE) {
+		if (atomic_dec_if_positive(&cap->buffers.frame_skip) < 0) {
+			if ((status & ISPC_ENUO)) {
+				change_buf = stf_change_buffer(&cap->buffers);
+				if (change_buf)
+					stf_set_yuv_addr(stfcamss, change_buf->addr[0],
+							 change_buf->addr[1]);
+			}
+		}
+
+		stf_isp_reg_set_bit(stfcamss, ISP_REG_CSIINTS,
+				    CSI_INTS_MASK, CSI_INTS(0x3));
+		stf_isp_reg_set_bit(stfcamss, ISP_REG_IESHD,
+				    SHAD_UP_M | SHAD_UP_EN, 0x3);
+
+		stf_isp_reg_write(stfcamss, ISP_REG_ISP_CTRL_0,
+				  (status & ~ISPC_INT_ALL_MASK) | ISPC_LINE);
+	}
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t stf_isp_irq_handler(int irq, void *priv)
+{
+	struct stfcamss *stfcamss = priv;
+	struct stf_capture *cap = &stfcamss->captures[STF_CAPTURE_YUV];
+	struct stfcamss_buffer *ready_buf;
+	u32 status;
+
+	status = stf_isp_reg_read(stfcamss, ISP_REG_ISP_CTRL_0);
+	if (status & ISPC_ISP) {
+		if (status & ISPC_ENUO) {
+			ready_buf = stf_buf_done(&cap->buffers);
+			if (ready_buf)
+				vb2_buffer_done(&ready_buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
+		}
+
+		stf_isp_reg_write(stfcamss, ISP_REG_ISP_CTRL_0,
+				  (status & ~ISPC_INT_ALL_MASK) |
+				  ISPC_ISP | ISPC_CSI | ISPC_SC);
+	}
+
+	return IRQ_HANDLED;
+}
diff --git a/drivers/staging/media/starfive/camss/stf-isp.h b/drivers/staging/media/starfive/camss/stf-isp.h
index bc7e7b0736fa..fcda0502e3b0 100644
--- a/drivers/staging/media/starfive/camss/stf-isp.h
+++ b/drivers/staging/media/starfive/camss/stf-isp.h
@@ -427,4 +427,7 @@ int stf_isp_init(struct stfcamss *stfcamss);
 int stf_isp_register(struct stf_isp_dev *isp_dev, struct v4l2_device *v4l2_dev);
 int stf_isp_unregister(struct stf_isp_dev *isp_dev);
 
+void stf_set_yuv_addr(struct stfcamss *stfcamss,
+		      dma_addr_t y_addr, dma_addr_t uv_addr);
+
 #endif /* STF_ISP_H */
-- 
2.25.1


