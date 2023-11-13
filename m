Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E767E96E0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 08:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjKMHHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 02:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjKMHG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 02:06:59 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7056C10F5;
        Sun, 12 Nov 2023 23:06:55 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ACCf7Zj016211;
        Mon, 13 Nov 2023 08:06:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=9eluZSRn7peMLgOArt+M1C4neGyvCINQUcgy5sA40d4=; b=BG
        fOc0s9gg4SOLo+hA119T6rL2A9Rraksrjc2dLsrgdzbpxLCB+h+u1xEMq/HsoycL
        zebhF1zKBdXUpZw0pG+UeVi0GpAFjKSjGgyvPh3r3/NPPcesjB3mxkozomCYlfbb
        P5/UqZzK/gxWnyfOlbQMRLS/9ZPtX/WeoFsWeXeoTMPqLnbXciM21O6wdYeD8TFu
        5u+66xUabQbbzf+UuwN6Kw88qyv9VCCIiqQbIJvFNEB02tV1Z9qbVYKLImIt6xoW
        oe3u+DlaxD3Bp/cm1OVHMNsoEP1pnzsoOL86MweHhcEqJ/6OsikkZPtpYB9I/CF8
        GJGWFuKvcAZrJgQg8UyQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ua1u1nkyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Nov 2023 08:06:38 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5EBB910005B;
        Mon, 13 Nov 2023 08:06:38 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 535242092E6;
        Mon, 13 Nov 2023 08:06:38 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 13 Nov
 2023 08:06:38 +0100
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
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/5] media: MAINTAINERS: add entry for STM32 DCMIPP driver
Date:   Mon, 13 Nov 2023 08:05:21 +0100
Message-ID: <20231113070532.71509-3-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231113070532.71509-1-alain.volmat@foss.st.com>
References: <20231113070532.71509-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-12_24,2023-11-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the entry related to the STM32 MEDIA DCMIPP driver within the
MAINTAINERS file.
Add myself as maintainer of the DCMI driver as well.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..ffff6f61461c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13274,13 +13274,16 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/dvb-frontends/stv6111*
 
-MEDIA DRIVERS FOR STM32 - DCMI
+MEDIA DRIVERS FOR STM32 - DCMI / DCMIPP
 M:	Hugues Fruchet <hugues.fruchet@foss.st.com>
+M:	Alain Volmat <alain.volmat@foss.st.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
 F:	drivers/media/platform/st/stm32/stm32-dcmi.c
+F:	Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
+F:	drivers/media/platform/st/stm32/stm32-dcmipp/*
 
 MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
-- 
2.25.1

