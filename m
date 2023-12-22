Return-Path: <linux-kernel+bounces-9213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8514281C260
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84CE28809D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054B8EB8;
	Fri, 22 Dec 2023 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b="caSd2Egs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991AA41
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dionne-riel.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bb732e7d78so947196b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 16:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20230601.gappssmtp.com; s=20230601; t=1703205560; x=1703810360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FvBycHxiyxAxWwzvQi+SXabOjPJ6utrXr2SoxBa7h+E=;
        b=caSd2EgsIbSblAcciQMl0YZqC8no/gCsY8b4Y8HG4UqSbP7q0alXE30WiPhCc+DVWc
         fmyFRBt195dtVq4ntF5LMiN4arumnEL2ib4Gk1G/p+wF14Rf82hwk+fWMzvRDABxVM1W
         gHyEc44X7YzjJ/7jrrMGyB5IYqrPlvul1sB6QmwG/S5Q8s5hYAH9ATqoEXXgpJmQsyAq
         INS6vFkVRCDN8p5Riasx49gawe1cbI1OlTMTGH7zF0Nef0y300OI91NglplTy9dZNWXm
         G+4OGtwJ2M6/CVolHPndil0l0MDi8N3eq78tGqUxXAwfT881DsTEc+brO+uDghBXyDkg
         oQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703205560; x=1703810360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvBycHxiyxAxWwzvQi+SXabOjPJ6utrXr2SoxBa7h+E=;
        b=sMTt2JkDaRq4NiVYOFF/VEK6WXn4gLKdYT/vZSbOApYBs3ec92vArRKMqlQ3n6Atu1
         oNuNViZwRO8s+dQNzB39JLMA2TsYVwb+o+Y+V3D0QMFYKt7hEyzMsYbUfXSmSfWQpD2K
         pJxo0k8KvjpOJM1qgVYgHY9bcHhnXYZt7277XxXoZTC86toenvd712LWJWxJwwTrSg+S
         EMj8sAPJ1iKriPPRbp2aVgxPC5hPour+uagJB4/s1IrQ1NDol782Ej4Yk5DiNZlD88jj
         JM0UIJiSGKZ4TkCp7Hk0lcRGFrM9VmTYULxOIlO5GQOKRPmoTgZQXFLvgeBVuhxLRp8A
         x4lA==
X-Gm-Message-State: AOJu0Ywd/Q2Z0w87EFmLJ1y3TTQfA6b8brBDgzN3PQxaqOsEpnzzCZZg
	44CKNghC17fA9kHvynQMZiXs9MpXBd8a
X-Google-Smtp-Source: AGHT+IHQRIskVW0NcklyqymEhtyN0B0USfhteB48zp4ZQnVTXipQ0h15Ru0U5WO75hizH8cS0jSgag==
X-Received: by 2002:a05:6808:1303:b0:3b8:b063:6665 with SMTP id y3-20020a056808130300b003b8b0636665mr481640oiv.92.1703205559750;
        Thu, 21 Dec 2023 16:39:19 -0800 (PST)
Received: from localhost.localdomain (135-23-195-66.cpe.pppoe.ca. [135.23.195.66])
        by smtp.gmail.com with ESMTPSA id fv11-20020a056214240b00b0067f7f73d632sm936651qvb.138.2023.12.21.16.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 16:39:19 -0800 (PST)
From: Samuel Dionne-Riel <samuel@dionne-riel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Samuel Dionne-Riel <samuel@dionne-riel.com>
Subject: [PATCH] drm: panel-orientation-quirks: Add quirk for GPD Win Mini
Date: Thu, 21 Dec 2023 19:38:30 -0500
Message-ID: <20231222003830.3733310-1-samuel@dionne-riel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3d92f66e550c3..f730886ae10df 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -279,6 +279,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1618-03")
 		},
 		.driver_data = (void *)&lcd720x1280_rightside_up,
+	}, {	/* GPD Win Mini */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1617-01")
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* I.T.Works TW891 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
-- 
2.42.0


