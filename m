Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD547FC514
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345388AbjK1UOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjK1UOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:14:50 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D85083;
        Tue, 28 Nov 2023 12:14:55 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ASEWoYk025952;
        Tue, 28 Nov 2023 21:14:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=3wum3M3
        uGkwBSpakL3jJmsR2FXWJMQzhEHn2WaGllZI=; b=6thw0lQMM3/jSHUykSdUmg5
        g60wNRp1znWXHe3w2Qdf1vqk9mqXAtsWRmJ64nfh+ovGcSocDzPeRsbcJHGs4d0D
        fxv0T9cvtVacdgGw/eRFDFWBOJEzZQqmhISZtPiTgxzHk5PBKnTAAIdr4yWbLP5U
        TvBZUWcPEMXIrS+5BI9rfNgBJzsV27q2ldmLmc61UQ1YNwtsQnEKyqODEgL6sxys
        42mb6HBUuJ897KMObaTym+vAR/c/x5pAtZauXIKe0absnsJTUGEAgQP+oVsq0X5M
        9vxtzMoZLNwCn69MuOXg39xWh63IzIDCvLTuKNvLDPPRgRBgcHd8G6u0ItIVKXA=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uk8pjwn91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Nov 2023 21:14:36 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5547310002A;
        Tue, 28 Nov 2023 21:14:34 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4A135276D9F;
        Tue, 28 Nov 2023 21:14:34 +0100 (CET)
Received: from localhost (10.252.11.142) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 28 Nov
 2023 21:14:34 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: stm32-dcmipp: correct kerneldoc issues in dcmipp-common
Date:   Tue, 28 Nov 2023 21:14:03 +0100
Message-ID: <20231128201404.237856-1-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.11.142]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_23,2023-11-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct kerneldoc issues regarding:
  - dcmipp_ent_sd_register
  - dcmipp_pads_init
  - dcmipp_colorimetry_clamp

Rename as well dcmipp_pads_init parameter from pads_flag to pads_flags.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 .../media/platform/st/stm32/stm32-dcmipp/dcmipp-common.c    | 4 ++--
 .../media/platform/st/stm32/stm32-dcmipp/dcmipp-common.h    | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.c b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.c
index d4f149f7e1b7..562933e08d62 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.c
@@ -14,7 +14,7 @@
 #include "dcmipp-common.h"
 
 /* Helper function to allocate and initialize pads */
-struct media_pad *dcmipp_pads_init(u16 num_pads, const unsigned long *pads_flag)
+struct media_pad *dcmipp_pads_init(u16 num_pads, const unsigned long *pads_flags)
 {
 	struct media_pad *pads;
 	unsigned int i;
@@ -27,7 +27,7 @@ struct media_pad *dcmipp_pads_init(u16 num_pads, const unsigned long *pads_flag)
 	/* Initialize the pads */
 	for (i = 0; i < num_pads; i++) {
 		pads[i].index = i;
-		pads[i].flags = pads_flag[i];
+		pads[i].flags = pads_flags[i];
 	}
 
 	return pads;
diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.h b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.h
index 5fd26d6f857a..69cfa67ffeeb 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.h
+++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-common.h
@@ -33,7 +33,7 @@
 #define DCMIPP_XFER_FUNC_DEFAULT	V4L2_XFER_FUNC_DEFAULT
 
 /**
- * struct dcmipp_colorimetry_clamp - Adjust colorimetry parameters
+ * dcmipp_colorimetry_clamp() - Adjust colorimetry parameters
  *
  * @fmt:		the pointer to struct v4l2_pix_format or
  *			struct v4l2_mbus_framefmt
@@ -103,7 +103,7 @@ struct dcmipp_ent_device {
  * Helper functions to allocate/initialize pads
  */
 struct media_pad *dcmipp_pads_init(u16 num_pads,
-				   const unsigned long *pads_flag);
+				   const unsigned long *pads_flags);
 
 /**
  * dcmipp_pads_cleanup - free pads
@@ -130,6 +130,8 @@ static inline void dcmipp_pads_cleanup(struct media_pad *pads)
  * @pads_flag:	flags to use in each pad
  * @sd_int_ops:	pointer to &struct v4l2_subdev_internal_ops
  * @sd_ops:	pointer to &struct v4l2_subdev_ops.
+ * @handler:	func pointer of the irq handler
+ * @thread_fn:	func pointer of the threaded irq handler
  *
  * Helper function initialize and register the struct dcmipp_ent_device and
  * struct v4l2_subdev which represents a subdev node in the topology
-- 
2.34.1

