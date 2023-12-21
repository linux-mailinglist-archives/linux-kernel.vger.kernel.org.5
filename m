Return-Path: <linux-kernel+bounces-8342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F83281B5F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B347286BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008EF6EB61;
	Thu, 21 Dec 2023 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KHCJ1Bvs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FDE768F4;
	Thu, 21 Dec 2023 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BL91QIS020448;
	Thu, 21 Dec 2023 13:29:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=B5wcMGFh4CoqzFZs1z1bofbkFA+Gq4yfIFxfUXbmg0w=; b=KH
	CJ1BvsOmo2hZjg+eTlF3NZro65o0DPAYmJ5s58NnctVMokk0T8PRCSxgEMqwgkhG
	R7yNGbfX/VloQPcCJ476IWIE08TljR7r59d57DXGuySsjwKJdD/TETA92H2RXS8c
	bRC6AUCQmcP4KVHyReDGvRPfDaK02vworhxiUuaqV2euAA5gWKouYBcoAGTblxkG
	klkVD7PHfwDZVF+sk8Jy/UDy/NFqqITqPZIYZhiLZTDM9tZVzYYuaucIxuoEJ1yk
	FDtjq8xafthmTAJL598MwiUch4qPpidB25bX7JkmX1iMxyj06cJtvMKuRPQskhfw
	1hb7lJLIbMo8x2FifqyQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v14427gm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 13:29:53 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 28B7A10005F;
	Thu, 21 Dec 2023 13:29:51 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1D6A923C699;
	Thu, 21 Dec 2023 13:29:51 +0100 (CET)
Received: from localhost (10.252.25.159) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Dec
 2023 13:29:50 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam
 Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lad
 Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thierry Reding
	<thierry.reding@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v1 4/8] drm/stm: ltdc: implement bus clock
Date: Thu, 21 Dec 2023 13:28:39 +0100
Message-ID: <20231221122843.418650-5-raphael.gallais-pou@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221122843.418650-1-raphael.gallais-pou@foss.st.com>
References: <20231221122843.418650-1-raphael.gallais-pou@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_05,2023-12-20_01,2023-05-22_02

From: Yannick Fertre <yannick.fertre@foss.st.com>

The latest hardware version of the LTDC presents the addition of a bus
clock, which contains the global configuration registers and the interrupt
register.

Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 8 ++++++++
 drivers/gpu/drm/stm/ltdc.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 5576fdae4962..67064f47a4cb 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1896,6 +1896,8 @@ void ltdc_suspend(struct drm_device *ddev)
 
 	DRM_DEBUG_DRIVER("\n");
 	clk_disable_unprepare(ldev->pixel_clk);
+	if (ldev->bus_clk)
+		clk_disable_unprepare(ldev->bus_clk);
 }
 
 int ltdc_resume(struct drm_device *ddev)
@@ -1910,6 +1912,12 @@ int ltdc_resume(struct drm_device *ddev)
 		DRM_ERROR("failed to enable pixel clock (%d)\n", ret);
 		return ret;
 	}
+	if (ldev->bus_clk) {
+		if (clk_prepare_enable(ldev->bus_clk)) {
+			DRM_ERROR("Unable to prepare bus clock\n");
+			return -ENODEV;
+		}
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
index 9d488043ffdb..155d8e4a7c6b 100644
--- a/drivers/gpu/drm/stm/ltdc.h
+++ b/drivers/gpu/drm/stm/ltdc.h
@@ -44,6 +44,7 @@ struct ltdc_device {
 	void __iomem *regs;
 	struct regmap *regmap;
 	struct clk *pixel_clk;	/* lcd pixel clock */
+	struct clk *bus_clk;	/* bus clock */
 	struct mutex err_lock;	/* protecting error_status */
 	struct ltdc_caps caps;
 	u32 irq_status;
-- 
2.25.1


