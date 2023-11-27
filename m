Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B367FA796
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234646AbjK0RJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234707AbjK0RJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:09:26 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AAA10D4;
        Mon, 27 Nov 2023 09:09:32 -0800 (PST)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ARFTLiN021343;
        Mon, 27 Nov 2023 18:09:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=nF3L7aJY+yTHafD/pzG6dSQt6aa0xu2Pl65VtBLxDqU=; b=Pr
        vUCFd+IuCQhcr8xag4oV238Yeqz900B0IHXR99mR1Wqrr2udDJ8B4KDEW45Z7/K8
        nC/OVG/qKk/z79HFh5M+hqr97Q97O7h0FiMxLZkdrLBnIUGlLpsVTMtwx3j9AZ/m
        y+4ZAWz/X15IAaZAW7jHO66Q3CcODJ70A2n/ZgLZVPX0KYo4NMMGuIeWVJlA+jCn
        vE11ljZfV4bxk8ROsYrrFSPI3ObIU5OHlxnNPKsItmBKc7w+U7cdIMidnaHGG7DK
        YaOYfhQinpyUlzcp7fJHCmu90SzA7VWPvt0lAbNG73bSES2VcIM0sHBQGzwF3TNt
        HGGVcNWtz6vCc8eJbyCQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ums0rhrqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 18:09:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F0B8410004B;
        Mon, 27 Nov 2023 18:09:05 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E656824550B;
        Mon, 27 Nov 2023 18:09:05 +0100 (CET)
Received: from localhost (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 27 Nov
 2023 18:09:05 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
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
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 2/5] media: MAINTAINERS: add entry for STM32 DCMIPP driver
Date:   Mon, 27 Nov 2023 18:08:16 +0100
Message-ID: <20231127170828.1426117-3-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127170828.1426117-1-alain.volmat@foss.st.com>
References: <20231127170828.1426117-1-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_15,2023-11-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
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
index 0c90fed1d65f..bab36ca8e824 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13442,13 +13442,16 @@ W:	https://linuxtv.org
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

