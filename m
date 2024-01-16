Return-Path: <linux-kernel+bounces-28342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE3F82FD15
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E581C2878A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9161E22321;
	Tue, 16 Jan 2024 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KSq1LBJr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21A2209F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443758; cv=none; b=btEBX4lbMatGBvQ9eIMG5y15YtfqUX0sKJpuRUMmEKLymcsSGKhAm/62lXKhedYruYA2icAsfLiSEHv7EgqTzUblMEmu5RQxyBVeBjR/59eUZlhV3WTcO250sFdjlhYY1tTXzdj+TvyUXIGM7Qckdyk9qtG3QoNQlI4U8ToUnaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443758; c=relaxed/simple;
	bh=4exVjp7sl3jEyHqi/O64KXlGDRIagRnzpF/Qkfnhe10=;
	h=Received:DKIM-Signature:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Originating-IP:
	 X-ClientProxiedBy:X-QCInternal:X-Proofpoint-Virus-Version:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=irAoZI6IfJJDoGdPQfBkSy6s6WO5JGoPQVazl0CPp9fZ4FCiktTkhpa5SikAl5A8J8xOosxUXQFnPZdXwYKeGE5BwR+caR6pojm7ekEh1zyi/gD31QOHmuFZjuNgTIBgmXuCj69ULf7SKeB9WPise8KlHV+fEzO2iwazppVTjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KSq1LBJr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GLK9x0001662;
	Tue, 16 Jan 2024 22:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=X7pudHFbPhvig+cOVdw0OfswUXgRDwB047Kg839LXIg
	=; b=KSq1LBJrdL4bPUL5dRBgyyVhF0G0KbH+GPcclo8g1ojzdqhxTlgTgmF4WLP
	8cp6UtQdnMF6j/lnb/0fqoxhpmGWv1wbg2tppMPEmsNdQF4pZmaY4zMV6lQvsY3p
	GDSgJSiLh+haZpt8g5C6QoXfgstOAjaI0GCil3K3rj+nh1NNoGEOwTCniA90FZXb
	mAkY25H1SYa6xKmmBePuzFnuqHJCClWaMbqD71e2lXJ/oEhjfUvSXjPwT47+wZ9O
	3F5UMjdbMMObeWsgtgw8963fROeORCNrkTbdDf63Z6SKgOFFWwtlVcSnRje2fum+
	oEE3712GHfHqe4UxbBsTNwyiY9g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnnajj3s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 22:22:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40GMMO46001543
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 22:22:24 GMT
Received: from jesszhan-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 16 Jan 2024 14:22:24 -0800
From: Jessica Zhang <quic_jesszhan@quicinc.com>
Date: Tue, 16 Jan 2024 14:22:05 -0800
Subject: [PATCH RFC 2/4] drm/dsi: Add API to register simulated DSI panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240116-jz-test-sim-panel-v1-2-f9511f46c9c7@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705443743; l=2397;
 i=quic_jesszhan@quicinc.com; s=20230329; h=from:subject:message-id;
 bh=4exVjp7sl3jEyHqi/O64KXlGDRIagRnzpF/Qkfnhe10=;
 b=s+bAYnBaboUd1+InwjYXBosjD+zhAarjEiwUpa26kWQUIQJMRjqpzxuz9+CDjxRyilnNf3VkP
 Ykj3M2Voiq4D0NoRSu/VIbhdfgxAOK/Y5Fv4mmgwkPnfkn7s9wyphuQ
X-Developer-Key: i=quic_jesszhan@quicinc.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eC_wffRwQnb7km1OuZgQX2uX-BTEglnb
X-Proofpoint-ORIG-GUID: eC_wffRwQnb7km1OuZgQX2uX-BTEglnb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=968 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401160174

Add new APIs to register a simulated panel.

For drivers that want to support a simulated panel, they must call
mipi_dsi_host_register_sim_panel().

Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 30 ++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 843a6dbda93a0..6996014990979 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -153,6 +153,24 @@ static int mipi_dsi_device_add(struct mipi_dsi_device *dsi)
 	return device_add(&dsi->dev);
 }
 
+#if IS_ENABLED(CONFIG_DRM_PANEL_SIMULATION)
+static struct mipi_dsi_device *mipi_dsi_device_add_sim_panel(struct mipi_dsi_host *host)
+{
+	struct mipi_dsi_device_info info = { };
+
+	info.channel = 0;
+	info.node = NULL;
+	strscpy(info.type, "panel_simulation", sizeof(info.type));
+
+	return mipi_dsi_device_register_full(host, &info);
+}
+#else
+static struct mipi_dsi_device *mipi_dsi_device_add_sim_panel(struct mipi_dsi_host *host)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+
 #if IS_ENABLED(CONFIG_OF)
 static struct mipi_dsi_device *
 of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
@@ -324,6 +342,18 @@ struct mipi_dsi_host *of_find_mipi_dsi_host_by_node(struct device_node *node)
 }
 EXPORT_SYMBOL(of_find_mipi_dsi_host_by_node);
 
+int mipi_dsi_host_register_sim_panel(struct mipi_dsi_host *host)
+{
+	mipi_dsi_device_add_sim_panel(host);
+
+	mutex_lock(&host_lock);
+	list_add_tail(&host->list, &host_list);
+	mutex_unlock(&host_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(mipi_dsi_host_register_sim_panel);
+
 int mipi_dsi_host_register(struct mipi_dsi_host *host)
 {
 	struct device_node *node;
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index c0aec0d4d664e..4ca44b7b3efdb 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -107,6 +107,7 @@ struct mipi_dsi_host {
 	struct list_head list;
 };
 
+int mipi_dsi_host_register_sim_panel(struct mipi_dsi_host *host);
 int mipi_dsi_host_register(struct mipi_dsi_host *host);
 void mipi_dsi_host_unregister(struct mipi_dsi_host *host);
 struct mipi_dsi_host *of_find_mipi_dsi_host_by_node(struct device_node *node);

-- 
2.43.0


