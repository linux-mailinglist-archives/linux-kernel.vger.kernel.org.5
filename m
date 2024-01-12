Return-Path: <linux-kernel+bounces-24718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF4E82C143
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E1328263F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41666D1C4;
	Fri, 12 Jan 2024 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS09amwn"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0542628C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so4605460a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705068058; x=1705672858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XS8Rep9Va+/PRgkDzjJYb2S8kbvY9z/pUUqJQoFIFy4=;
        b=ZS09amwnzg1H5DIf2dvVc/6gDS1jfE/fyQaAsSxSpNE/Sc8f2rI02H12z4GjZA8X07
         qTrhDY6rkUqswbtVpsLVnL1kF7UVCsn3ufOVE6r0b3U+UfmYVgy+FixkQxW0aV6/kZjs
         AGe4CqDsPXPRoVHGJy20mubGHX45cekymcFi2KZ4IWu7snq5BUzxGgZD2QYtHZeLpQ+4
         Nt/4WkQSw3DBud1etOXzfSIcP1WBqbPEFj9iSWoYRufc8hhCGAVDWes1c+2knDoclZec
         zWzDIV92hPLHdNbTnfgclpERmU/177mBqsmcZK99QrXayRmIghUpcIanpQNQCSiLYHxD
         8PxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705068058; x=1705672858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XS8Rep9Va+/PRgkDzjJYb2S8kbvY9z/pUUqJQoFIFy4=;
        b=d0l9KD5CMsQGTUqlUVrI6U7HyNOk297HCu273nblIwBeBBr1IQsirzGWLYnjReC3uF
         Ag1mK4UwwaQLHJmz/BncMS7r5TAUEH6pwMEo7lUiIGvBbxNz439p0vDbTy0EH5EgG5On
         4OgBUjcSx889U7ZC2BSwmM/KT0Nn7UEpuKdFh0oEqiqfIs4PEwN9vtBaPO3vHny8Jrkp
         ATmjKmdZvRM916X4MEK6MWzTpswE2YJUT2rwf1VNAHKdS0MpX68iNN/yK6GUCGZgpUpd
         2Wv2YFG/sLesJxBCUgS6unuJMmMLDDZEbH48e9NuEWJ1EQQwPKBjVG3VgL+mWhDnde8J
         S1Eg==
X-Gm-Message-State: AOJu0YzZA4Lv+M7JOvp5xKOft/k0Loa/oFmYBfPlVm/wo0ac/Yo0iW6u
	oZIk8+6fHxuJ+XA7+rxB46U=
X-Google-Smtp-Source: AGHT+IHazKNfF5Sl/dHs/3CsbUVKYhtaDsFQhN7NUmoATtPYwXCEzL3gzslDnXKJTBDOtMuhXd5PuQ==
X-Received: by 2002:a17:90a:d254:b0:28d:95c6:abb7 with SMTP id o20-20020a17090ad25400b0028d95c6abb7mr3392604pjw.14.1705068057893;
        Fri, 12 Jan 2024 06:00:57 -0800 (PST)
Received: from localhost.localdomain ([2409:8a6a:5422:1e81:f0d5:a137:e742:acec])
        by smtp.gmail.com with ESMTPSA id sj4-20020a17090b2d8400b0028d9b5d41edsm4065564pjb.38.2024.01.12.06.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 06:00:57 -0800 (PST)
From: Jianhua Lu <lujianhua000@gmail.com>
To: Jianhua Lu <lujianhua000@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: nt36523: Set 120Hz fps for xiaomi,elish panels
Date: Fri, 12 Jan 2024 22:00:47 +0800
Message-ID: <20240112140047.18123-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit e6c0de5f4450 ("drm/msm/dpu: try multirect based on mdp clock limits")
merged, 120Hz is working on xiaomi,elish panels, so feature it.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt36523.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
index a189ce236328..d6fa76dbf948 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
@@ -933,8 +933,7 @@ static int j606f_boe_init_sequence(struct panel_info *pinfo)
 
 static const struct drm_display_mode elish_boe_modes[] = {
 	{
-		/* There is only one 120 Hz timing, but it doesn't work perfectly, 104 Hz preferred */
-		.clock = (1600 + 60 + 8 + 60) * (2560 + 26 + 4 + 168) * 104 / 1000,
+		.clock = (1600 + 60 + 8 + 60) * (2560 + 26 + 4 + 168) * 120 / 1000,
 		.hdisplay = 1600,
 		.hsync_start = 1600 + 60,
 		.hsync_end = 1600 + 60 + 8,
@@ -948,8 +947,7 @@ static const struct drm_display_mode elish_boe_modes[] = {
 
 static const struct drm_display_mode elish_csot_modes[] = {
 	{
-		/* There is only one 120 Hz timing, but it doesn't work perfectly, 104 Hz preferred */
-		.clock = (1600 + 200 + 40 + 52) * (2560 + 26 + 4 + 168) * 104 / 1000,
+		.clock = (1600 + 200 + 40 + 52) * (2560 + 26 + 4 + 168) * 120 / 1000,
 		.hdisplay = 1600,
 		.hsync_start = 1600 + 200,
 		.hsync_end = 1600 + 200 + 40,
-- 
2.41.0


