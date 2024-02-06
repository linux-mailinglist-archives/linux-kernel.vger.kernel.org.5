Return-Path: <linux-kernel+bounces-54811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4339F84B3FD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA90B286E51
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECE613174E;
	Tue,  6 Feb 2024 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XV4FOSJS"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1AE134CC0;
	Tue,  6 Feb 2024 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219249; cv=none; b=OjS9MzvwqOjn2pp/6byjpWKsPAmoyu6dm/LcOedHfB/UXJlAB61zSCDDz5KuENPVVsWsLpnaVO4e25FZrJAXgnQvTNH/dPw0O1rQviQOr/CIGXlhvPVDezz8A1PwoPROVXo+sRVLXg79eIeZjl32hF2HHkED728jqn2OL14s3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219249; c=relaxed/simple;
	bh=iKYO2rG3BTMKt5WCaCdwZY//PQVAlVNZ1d+5MI+Gots=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nNcySv5VvANYZwX8jRMWKkVh6/yuVCtIZyastDsejHbdzNNPrf1bSlnO9UeR5GfK8dgjo9E/tMuN9JkqbFB1ffVr9kR5RhHqcUJHzjdDIKVLUEvk3QcvPXP9/9LbnbJY8sxCcw7fZ6pGQdgpQMzDaYJ2Ld55RLNKPO86yobwi5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XV4FOSJS; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4169DVsF003834;
	Tue, 6 Feb 2024 12:33:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=selector1; bh=DnsKquutEGOQewPoi6J/BDbXg1mh4kqRqxYNbt4LG2M
	=; b=XV4FOSJSfZnWum0RQAYV7/5WuOrVgo2wwcKtAjAqyBf/AgHS9CWDt/tUlCB
	Xvbncqy0uqPaCmwxwjj0I1kfpeG4bifTcrEau5FG05sRD9vwbv4zC3YigHIiYdPA
	QSq0j1QkV1Mx0xpL0mSGq/63FKErSe1iQc+wSechpbYNPcXf3r//DRr40G2ncByi
	DfG+ZdwVzwlS65Qbg4O27FFbfR04OLDsp25G2fwJK6jKR/5QhLkBogXhf7onivCI
	Wf6eh9+oyQ4Na346QIKz7Lu5oRaj4GtTZcmW9kJcHmE74P7LdR2QiJAVs9GvCSUZ
	UD2j/g8R06eop1DTl9HHhtDF0aw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3w1ewp33mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 12:33:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 76D5310005A;
	Tue,  6 Feb 2024 12:33:20 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6AD3F23C6B7;
	Tue,  6 Feb 2024 12:33:20 +0100 (CET)
Received: from localhost (10.129.178.155) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 6 Feb
 2024 12:33:20 +0100
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Tue, 6 Feb 2024 12:33:18 +0100
Subject: [PATCH v4 3/3] drm/stm: ltdc: add lvds pixel clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240206-lvds-v4-3-98d5f9af399d@foss.st.com>
References: <20240206-lvds-v4-0-98d5f9af399d@foss.st.com>
In-Reply-To: <20240206-lvds-v4-0-98d5f9af399d@foss.st.com>
To: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_04,2024-01-31_01,2023-05-22_02

The STM32MP25x display subsystem presents a mux which feeds the loopback
pixel clock of the current bridge in use into the LTDC. This mux is only
accessible through sysconfig registers which is not yet available in the
STM32MP25x common clock framework.

While waiting for a complete update of the clock framework, this would
allow to use the LVDS.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
---
Changes in v2:
	- Fixed my address
	- Fixed smatch warning
---
 drivers/gpu/drm/stm/ltdc.c | 19 +++++++++++++++++++
 drivers/gpu/drm/stm/ltdc.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 5576fdae4962..23011a8913bd 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -838,6 +838,12 @@ ltdc_crtc_mode_valid(struct drm_crtc *crtc,
 	int target_max = target + CLK_TOLERANCE_HZ;
 	int result;
 
+	if (ldev->lvds_clk) {
+		result = clk_round_rate(ldev->lvds_clk, target);
+		DRM_DEBUG_DRIVER("lvds pixclk rate target %d, available %d\n",
+				 target, result);
+	}
+
 	result = clk_round_rate(ldev->pixel_clk, target);
 
 	DRM_DEBUG_DRIVER("clk rate target %d, available %d\n", target, result);
@@ -1896,6 +1902,8 @@ void ltdc_suspend(struct drm_device *ddev)
 
 	DRM_DEBUG_DRIVER("\n");
 	clk_disable_unprepare(ldev->pixel_clk);
+	if (ldev->lvds_clk)
+		clk_disable_unprepare(ldev->lvds_clk);
 }
 
 int ltdc_resume(struct drm_device *ddev)
@@ -1910,6 +1918,13 @@ int ltdc_resume(struct drm_device *ddev)
 		DRM_ERROR("failed to enable pixel clock (%d)\n", ret);
 		return ret;
 	}
+	if (ldev->lvds_clk) {
+		if (clk_prepare_enable(ldev->lvds_clk)) {
+			clk_disable_unprepare(ldev->pixel_clk);
+			DRM_ERROR("Unable to prepare lvds clock\n");
+			return -ENODEV;
+		}
+	}
 
 	return 0;
 }
@@ -1981,6 +1996,10 @@ int ltdc_load(struct drm_device *ddev)
 		}
 	}
 
+	ldev->lvds_clk = devm_clk_get(dev, "lvds");
+	if (IS_ERR(ldev->lvds_clk))
+		ldev->lvds_clk = NULL;
+
 	rstc = devm_reset_control_get_exclusive(dev, NULL);
 
 	mutex_init(&ldev->err_lock);
diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
index 9d488043ffdb..4a60ce5b610c 100644
--- a/drivers/gpu/drm/stm/ltdc.h
+++ b/drivers/gpu/drm/stm/ltdc.h
@@ -44,6 +44,7 @@ struct ltdc_device {
 	void __iomem *regs;
 	struct regmap *regmap;
 	struct clk *pixel_clk;	/* lcd pixel clock */
+	struct clk *lvds_clk;	/* lvds pixel clock */
 	struct mutex err_lock;	/* protecting error_status */
 	struct ltdc_caps caps;
 	u32 irq_status;

-- 
2.25.1


