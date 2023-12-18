Return-Path: <linux-kernel+bounces-3285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D1816A62
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF654B229B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352F012B75;
	Mon, 18 Dec 2023 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="i3whlhbj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8847414270
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3ce28ac3cso693745ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1702893596; x=1703498396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sy6k6O0gnka0FbbvIFBJRob1aY75ND6ZFq7nHnki2Ho=;
        b=i3whlhbjbdF1IweGWYblUTGehPJMxoS3t9r673F9gHXMD2dThhuhYLSIQ2qBX1UMke
         E/eY0Q6Kr1+IA+ZpoLdwtGLZTikHKMVby119vHtXU68d45PemljGhGmqKVBW+Em+UWsN
         gTOMYOFJ/dwKYmFe7XpE/ENpgrpQRwiUIAUSqnZJBuCgepwK/dTbdU1chOrlleNtyvg/
         ZIq4K/cyWxRjuDISWW5b9xcHZvaTesWS1GfGUPwDqq2tStRh8a/lzyEGzJq71Lgw3zlI
         sx/vOUhSYw3fc15vlc6V43K4NM/N5PwgULAk6DWFHpo1ZP5gpuQdPM+P8yIWf+Z15xh6
         BJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702893596; x=1703498396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sy6k6O0gnka0FbbvIFBJRob1aY75ND6ZFq7nHnki2Ho=;
        b=JvNJFLFUgPDWbPQ30ooJ8+yiBsUrltvZKGUaSecJPk5ziLKixP2pLUKgY8WOCYivh7
         Xe/JtUvNdbSqtwNyrDb29N474a3wkuQtB7S8KJ+jpFc1l0BD3Yaf4oXdGj0vGc4aY1TY
         3eN02aPGJ25VoP7HbsfIp7PHBKRfUTn4DqQMW82uG3pVqS4k/mdBE/FVFOJkUqL9Ee6G
         TR1Cw08RivXVQNVRJ6JoKZ7HLMMUchl/fj17s8w+6JXKEcRzTOLFVNhyr2REsFIfSwif
         oP6lxt1bzQD1QDD+SSLFb48GFrhecy592RzSQ3XmH3lN8XWmiVFs/IGLu+FcY4ArgH+m
         /inQ==
X-Gm-Message-State: AOJu0YyDKAruIrpYTFLXlq+DuC4APwPnVYFGbTgQEA21SPK5RaT9kYsr
	NnhIWY9Px4/Fuv/DAdCAZUyooQ==
X-Google-Smtp-Source: AGHT+IHO2lwtkTr6e6g4w5HE1ZOX6syB/PnhjRdnQee+I0Iem3MIJVAFE0+R348FIJpOKDA3rfRy4g==
X-Received: by 2002:a17:902:7449:b0:1d3:bb08:70f4 with SMTP id e9-20020a170902744900b001d3bb0870f4mr340215plt.60.1702893595855;
        Mon, 18 Dec 2023 01:59:55 -0800 (PST)
Received: from xu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001cc8cf4ad16sm3559451pls.246.2023.12.18.01.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 01:59:55 -0800 (PST)
From: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel-edp: Add several generic edp panels
Date: Mon, 18 Dec 2023 17:59:33 +0800
Message-Id: <20231218095933.2487360-1-xuxinxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the following 3 panels:
1. BOE NV116WHM-N49 V8.0
2. BOE NV122WUM-N41
3. CSO MNC207QS1-1

Signed-off-by: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 95c8472d878a..454c2398184f 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1852,8 +1852,10 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x095f, &delay_200_500_e50, "NE135FBM-N41 v8.1"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x098d, &boe_nv110wtm_n61.delay, "NV110WTM-N61"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09dd, &delay_200_500_e50, "NT116WHM-N21"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a3e, &delay_200_500_e80, "NV116WHM-N49"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ac5, &delay_200_500_e50, "NV116WHM-N4C"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b34, &delay_200_500_e80, "NV122WUM-N41"),
 
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1139, &delay_200_500_e80_d50, "N116BGE-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
@@ -1863,6 +1865,8 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d4, &delay_200_500_e80_d50, "N140HCA-EAC"),
 
+	EDP_PANEL_ENTRY('C', 'S', 'O', 0x1200, &delay_200_500_e50, "MNC207QS1-1"),
+
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200, "R140NWF5 RH"),
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x854a, &delay_200_500_p2e100, "M133NW4J"),
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "R133NW4K-R0"),
-- 
2.39.2


