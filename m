Return-Path: <linux-kernel+bounces-28343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746CA82FD16
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7712F1C28802
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A7422324;
	Tue, 16 Jan 2024 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Id9BOSD/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF722304
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443758; cv=none; b=eeWH4HbEPeAc4NYbayio43DG6XQTK8hx4+31h1yykC/dNSO4oExX2/iSliFuh4XG1gMNr3NFO0fQIhtPEoiWjLlkHVI7UVNPEcRNYRweS5CXrySqZ/+qXa/UjLpx6FkS/n3+k68k8aEOxqqdFzm75SECQbSj4rQ2kDtSLlNnagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443758; c=relaxed/simple;
	bh=YHox5H/93RZKO+ux/ZK/BUHphi1XV9Rb6lfG5SlsGPk=;
	h=Received:DKIM-Signature:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Originating-IP:
	 X-ClientProxiedBy:X-QCInternal:X-Proofpoint-Virus-Version:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=uOLCeyD5ofNzFGzOQIAe8+MYd2QUEYWalqRThFRUbYOPprq97Ldh1aK8qBSuidI15SrZDOvwS0FUf2SOGMkNFmrpBrR2PH42MelDmKxEGCc8tz/D9JlRbPfJ5Pn1HmylRrMidQrXEvyuYEKZYAwo4G9+XVyGysOMg6pFsMLGEBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Id9BOSD/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GLVFQk026055;
	Tue, 16 Jan 2024 22:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=854SqBsgeysKQXfyNn7Vkf0hrKCxp+OzdVC5nhRI4IE
	=; b=Id9BOSD/n2SykiqydoJytzrhNMHGquL7S7Wta1KLhYcOkgeM0s23KZDTNUd
	3vjfztNGrAwE7OYBc1M4RJ8AnK3rs4+lpC6TwcbE8o7W9eMTmryneLvgwrFZfCis
	akUhSXX15VPAmM24AVHGgC9balJmK1xFI6APVkgjz3fxyirG+DAij/Wgr5hx6F2Y
	IKfXcnLWiQp3qLNv+qpdPGNTzaXt6F/DVbhLX7ZH2rywn/FcglyYvpkxMuT4+t/a
	MHlyiOo/SyRA9gOTCbCpq4EBosY9hb0014XKFK1QyBad7W/gPVZGf1BUUQPIgw5s
	YJaAZoc+j3XyooWN9ZI8Td0t4wA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnnhmt4rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 22:22:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40GMMOgQ001553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 22:22:24 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 16 Jan 2024 14:22:24 -0800
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Tue, 16 Jan 2024 14:22:06 -0800
Subject: [PATCH RFC 3/4] drm/panel: Introduce simulated panel bridge API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240116-jz-test-sim-panel-v1-3-f9511f46c9c7@quicinc.com>
References: <20240116-jz-test-sim-panel-v1-0-f9511f46c9c7@quicinc.com>
In-Reply-To: <20240116-jz-test-sim-panel-v1-0-f9511f46c9c7@quicinc.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg
	<sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <quic_abhinavk@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705443743; l=3852;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=YHox5H/93RZKO+ux/ZK/BUHphi1XV9Rb6lfG5SlsGPk=;
 b=28BQc2j6P7jSyGgeYvg37r1ZFOz3sQGWldrTxngOdp2PRfm8J0EHA7sW/AhINVl9+AkbUy0XN
 AH5IUluoNfcBchRlM3p+4y3qc8qvEZ2ADp8KLQllpUOMB+faNR1kKyf
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IAcjjadV8E5X2K8vHTttE8BsOsX3NDXy
X-Proofpoint-GUID: IAcjjadV8E5X2K8vHTttE8BsOsX3NDXy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160174

Add separate bridge and drm_panel API for getting the simulated panel.

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/bridge/panel.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_panel.c    | 33 +++++++++++++++++++++++++++++++++
 include/drm/drm_bridge.h       |  1 +
 include/drm/drm_panel.h        |  1 +
 4 files changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index e48823a4f1ede..87a83f4ce68a1 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -499,6 +499,30 @@ struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge)
 }
 EXPORT_SYMBOL(drm_panel_bridge_connector);
 
+/**
+ * drm_get_sim_panel_bridge - return the simulated panel bridge
+ * @dev: device to tie the bridge lifetime to
+ *
+ * This function will return a bridge for the simulated panel.
+ *
+ * Returns a pointer to the bridge if successful, or an error pointer
+ * otherwise.
+ */
+struct drm_bridge *drm_get_sim_panel_bridge(struct device *dev)
+{
+	struct drm_bridge *bridge;
+	struct drm_panel *panel;
+
+	panel = drm_find_sim_panel();
+	if (IS_ERR(panel))
+		return ERR_PTR(-EPROBE_DEFER);
+
+	bridge = devm_drm_panel_bridge_add(dev, panel);
+
+	return bridge;
+}
+EXPORT_SYMBOL(drm_get_sim_panel_bridge);
+
 #ifdef CONFIG_OF
 /**
  * devm_drm_of_get_bridge - Return next bridge in the chain
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index e814020bbcd3b..062541505fa74 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -290,6 +290,39 @@ int drm_panel_get_modes(struct drm_panel *panel,
 }
 EXPORT_SYMBOL(drm_panel_get_modes);
 
+/**
+ * drm_find_sim_panel - look up the simulated panel
+ *
+ * Searches for the simulated panel in the panel list.
+ *
+ * Return: A pointer to the simulated panel or an ERR_PTR() if the simulated
+ * panel was not found in the panel list.
+ *
+ * Possible error codes returned by this function:
+ * - EPROBE_DEFER: the panel device has not been probed yet, and the caller
+ *   should retry later
+*/
+struct drm_panel *drm_find_sim_panel(void)
+{
+	struct drm_panel *panel;
+
+	mutex_lock(&panel_lock);
+
+	list_for_each_entry(panel, &panel_list, list) {
+		bool is_sim_panel = !strncmp(panel->dev->driver->name,
+				"panel_simulation",
+				strlen("panel_simulation"));
+		if (is_sim_panel) {
+			mutex_unlock(&panel_lock);
+			return panel;
+		}
+	}
+
+	mutex_unlock(&panel_lock);
+	return ERR_PTR(-EPROBE_DEFER);
+}
+EXPORT_SYMBOL(drm_find_sim_panel);
+
 #ifdef CONFIG_OF
 /**
  * of_drm_find_panel - look up a panel using a device tree node
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index e39da5807ba71..941f1f825e2c6 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -927,6 +927,7 @@ static inline int drm_panel_bridge_set_orientation(struct drm_connector *connect
 }
 #endif
 
+struct drm_bridge *drm_get_sim_panel_bridge(struct device *dev);
 #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
 struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struct device_node *node,
 					  u32 port, u32 endpoint);
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 10015891b056f..c3a5944c35a91 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -283,6 +283,7 @@ int drm_panel_enable(struct drm_panel *panel);
 int drm_panel_disable(struct drm_panel *panel);
 
 int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector);
+struct drm_panel *drm_find_sim_panel(void);
 
 #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
 struct drm_panel *of_drm_find_panel(const struct device_node *np);

-- 
2.43.0


