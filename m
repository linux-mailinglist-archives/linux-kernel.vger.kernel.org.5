Return-Path: <linux-kernel+bounces-9277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F8781C342
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A02A1C21024
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 03:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A5210F0;
	Fri, 22 Dec 2023 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b="Y4hG1d7z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C6EB8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dionne-riel.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-425a3cdbda9so10679121cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 19:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20230601.gappssmtp.com; s=20230601; t=1703214141; x=1703818941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ycJodXT+JZm9RNjkqB/4yrbtDWd2hG7NkdRmpVRoew=;
        b=Y4hG1d7ztX6OwwmYHjVs3K64pGOJfrlXa/JtVm64WvVeglqrPaEnerluT7jiLRL3oE
         4mKZt0somcNUEYjNK0RLgiYWW8ncfUqIMSioXHTg5ryallRiz2+5Nd++YHvHoADZt33f
         U8qcocQ1SCKfq6ZELrsevq8+0zKvy8HMhfzX6JcJt44So1NzjTdhkOADbmtstdEbt5UI
         8afmudOMk4uNnYBCFxfZBq1KFLbwtEZXt0uO9eGVzFRjzG2G/UQfMVRAuACHrIXluRvf
         1fROhUdbSlncXykmCfJjxrKWTGFTlgt/s1kJ22VQ2NAYWeMSIDJSKSbL5C+4UfwNaqro
         Yuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703214141; x=1703818941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ycJodXT+JZm9RNjkqB/4yrbtDWd2hG7NkdRmpVRoew=;
        b=WIkOXfO3tMJfY49f3KMTlzLZPL/LyNg4SdBG4HfElVsuGJAJODUqxHXvqhoNwiUjnv
         sGO1c+rC6bTndtkai5z+PfRQY1VkTlJs+UFdD/HDG7knaW07vd2tMeaTcJ0ztl14OFw8
         ZuZQlIoNrg8da9VeRTL0C540OuZb4bJl0A/Dqsm0dxxwC23+Jh0oXEk6cGtnpoiV5mEf
         4p1HGg0TkgFSyWwb7+e1hrcpRYasZF8uMJ3660UAamd6uC6QeuNBlLPfLdKSg+xsFVpD
         kLKAxcq+CFDN0Fntm9Jfw3jO/v3EM4mVv2biaDFkqHbtyTvoVkiXdLhfc0ZbgLiiMO+r
         FCyg==
X-Gm-Message-State: AOJu0YywNtplXc1ilPOc2vubPiWScnzuEx2ezYMW5D+3c2M4yjTRQa1R
	hq2uHK2E8GX+Uuw11nejSuC9HRLFeq3N
X-Google-Smtp-Source: AGHT+IE40nhHEoelPMU/O3MVy2WfMGSFfflA4Fa2S4y1VDWTmTHF7liaXsitD4NIA5+wJEBX0bQRog==
X-Received: by 2002:a05:622a:1ba0:b0:423:732e:c345 with SMTP id bp32-20020a05622a1ba000b00423732ec345mr882621qtb.26.1703214141401;
        Thu, 21 Dec 2023 19:02:21 -0800 (PST)
Received: from localhost.localdomain (135-23-195-66.cpe.pppoe.ca. [135.23.195.66])
        by smtp.gmail.com with ESMTPSA id ev4-20020a05622a510400b0042387bd254bsm1419008qtb.9.2023.12.21.19.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 19:02:20 -0800 (PST)
From: Samuel Dionne-Riel <samuel@dionne-riel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Samuel Dionne-Riel <samuel@dionne-riel.com>
Subject: [PATCH v2] drm: panel-orientation-quirks: Add quirk for GPD Win Mini
Date: Thu, 21 Dec 2023 22:01:50 -0500
Message-ID: <20231222030149.3740815-2-samuel@dionne-riel.com>
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

Changes since v1:

 - Add 1080p right-side up panel data
 - Use the correct panel orientation

 drivers/gpu/drm/drm_panel_orientation_quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3d92f66e550c3..aa93129c3397e 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -117,6 +117,12 @@ static const struct drm_dmi_panel_orientation_data lcd1080x1920_leftside_up = {
 	.orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP,
 };
 
+static const struct drm_dmi_panel_orientation_data lcd1080x1920_rightside_up = {
+	.width = 1080,
+	.height = 1920,
+	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
+};
+
 static const struct drm_dmi_panel_orientation_data lcd1200x1920_rightside_up = {
 	.width = 1200,
 	.height = 1920,
@@ -279,6 +285,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1618-03")
 		},
 		.driver_data = (void *)&lcd720x1280_rightside_up,
+	}, {	/* GPD Win Mini */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "GPD"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "G1617-01")
+		},
+		.driver_data = (void *)&lcd1080x1920_rightside_up,
 	}, {	/* I.T.Works TW891 */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
-- 
2.42.0


