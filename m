Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566F179006C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 18:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245065AbjIAQDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjIAQDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 12:03:13 -0400
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55167CDD;
        Fri,  1 Sep 2023 09:03:10 -0700 (PDT)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 381C16du005074;
        Fri, 1 Sep 2023 18:02:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=vjX0/tsNLNMbPipkdCV1cRUhPSIMyqfeVyK9zOysr+s=; b=nB
        J4s8GNM9rgjrMXxqK6gbbZU8tbZvdeGCQ8W2wilLgb4eSm8TVwNAeq/AIf8fiCeV
        1TEbfG5gfOv/Y9hRnXrcDLv52W+g50xuZiigKUpP6lxdu8HCU2SGo1dhG64uolPW
        GhuzDH5Ghqs06WrysKZt8NmVetKejc0KvX6NKu0H6Kl3Qwi1Vl0dVp43IoAV3TEq
        qfVs7/1ohtuEkk2BUyHzhrQpdRPQlp7E1QjEANTBhMM1ZoH2xzMwVLDuwS+aEKLJ
        Rp5GpShN7KMDE9peEutcskP7/CKMYhm9sOEUEyqvlczKt6GPiY8iVodaPPh60N5U
        DokkeUJ7XPqByC2gf2dw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sqvbhs6xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 18:02:55 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7D90F100056;
        Fri,  1 Sep 2023 18:02:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7387323D41B;
        Fri,  1 Sep 2023 18:02:54 +0200 (CEST)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 1 Sep
 2023 18:02:54 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/5] ARM: multi_v7_defconfig: enable STM32 DCMIPP media support
Date:   Fri, 1 Sep 2023 17:57:24 +0200
Message-ID: <20230901155732.252436-6-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230901155732.252436-1-alain.volmat@foss.st.com>
References: <20230901155732.252436-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_13,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugues Fruchet <hugues.fruchet@foss.st.com>

Enables support of STM32 DCMIPP V4L2 media driver.

Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 524ca56f52d9..b044a719bef9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -689,6 +689,7 @@ CONFIG_VIDEO_STI_BDISP=m
 CONFIG_VIDEO_STI_DELTA=m
 CONFIG_VIDEO_STI_HVA=m
 CONFIG_VIDEO_STM32_DCMI=m
+CONFIG_VIDEO_STM32_DCMIPP=m
 CONFIG_V4L_TEST_DRIVERS=y
 CONFIG_VIDEO_VIVID=m
 CONFIG_VIDEO_ADV7180=m
-- 
2.25.1

