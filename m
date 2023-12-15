Return-Path: <linux-kernel+bounces-442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC881412F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085BD1C223C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511E4CA6F;
	Fri, 15 Dec 2023 05:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QabC6c2R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551C9CA6B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 05:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6cea2a38b48so244726b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 21:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702617678; x=1703222478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+5lBSVYnqDcPFtwn8gCQhYwDjCzvbLiJIKd8Yzo52s=;
        b=QabC6c2RpuvHsizgy4fYjZzA9v4vpeaD1eS0LlBx7bdMwFMX/JHDs1af2TX7QucMK0
         MLqfM39sbjn1q2vz0AGm+uINktCCzGWWHfzZDjN8AecnSPZA3crSbQ9a/+UIQt09woim
         v+ZpsTpVAtOvctbaG1fEOt6qqNidjV+grAvb6pDPcWWJzuw42Y2VtQX0f4ec7sKJQfjW
         nMz+RfcW2p1CNGoV0COs7GP4R5hnpXBGwRMpnrIleAkEcE1jPhHxKp72lj0F81dp83mh
         Bs6pamyCFeCAAXSO1r7a7cUgr0YOqIgNHcHOiS0+M782ASExnyF4h8oTO6K9kMQIfRmv
         1auA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702617678; x=1703222478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+5lBSVYnqDcPFtwn8gCQhYwDjCzvbLiJIKd8Yzo52s=;
        b=L2xTI/l8edFq3ORl3GsokxYm//Nbf/ugLHa/3wxqzPMiKVWfCtkS75UAqAJpH9mYSy
         2Ll3yxvLWCv0w2kJnnoVFBnbR2R4xRRsojh0iyJazZ7M14pGltPqVXakbTL73vkKvlWh
         O9frsjsZvL1QpUwygm1gySKAit3l/dQLaChTfU64bGJfiVIInwGbdx8xXLnDS+7mH0Tn
         Ux1Y2oIkKFKVa0BH4yoedEaefx9fyNES6vKk3dOfq15kEOQIoX528N9z/cJ/F/zTv5V3
         VLGPgZ1QzP9BmRrr02I34nu3SXur1FNRkiMJIbQcM5b34r7CejKy6ciUej0BO7K8AZRn
         8ZoA==
X-Gm-Message-State: AOJu0Yy1keQ+0AtHwO+NL8BAOa/ZwvehkbJefhNc9qE5s6NdWT4T5sc0
	hgeGfBuZtOGT1JfYesPssak=
X-Google-Smtp-Source: AGHT+IFht6jswMwabNafHJ7W/vy2mXm7pcUSJHVjGcuN971hwNVXm68KGLw+XrOGkEqilBvD4XKa5Q==
X-Received: by 2002:a05:6a00:2e10:b0:6d0:9913:3363 with SMTP id fc16-20020a056a002e1000b006d099133363mr8892948pfb.46.1702617678480;
        Thu, 14 Dec 2023 21:21:18 -0800 (PST)
Received: from localhost.localdomain ([202.137.218.19])
        by smtp.gmail.com with ESMTPSA id y20-20020a056a00191400b00688435a9915sm12608593pfi.189.2023.12.14.21.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 21:21:18 -0800 (PST)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	candice.li@amd.com,
	Le.Ma@amd.com,
	lijo.lazar@amd.com
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: drm: amd: fixed typos
Date: Fri, 15 Dec 2023 10:50:33 +0530
Message-Id: <20231215052033.550509-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed multiple typos in atomfirmware.h

Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index fa7d6ced786f..41d553921adf 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -210,7 +210,7 @@ atom_bios_string          = "ATOM"
 };
 */
 
-#pragma pack(1)                          /* BIOS data must use byte aligment*/
+#pragma pack(1)                          /* BIOS data must use byte alignment */
 
 enum atombios_image_offset{
   OFFSET_TO_ATOM_ROM_HEADER_POINTER          = 0x00000048,
@@ -452,7 +452,7 @@ struct atom_dtd_format
   uint8_t   refreshrate;
 };
 
-/* atom_dtd_format.modemiscinfo defintion */
+/* atom_dtd_format.modemiscinfo definition */
 enum atom_dtd_format_modemiscinfo{
   ATOM_HSYNC_POLARITY    = 0x0002,
   ATOM_VSYNC_POLARITY    = 0x0004,
@@ -645,7 +645,7 @@ struct lcd_info_v2_1
   uint32_t reserved1[8];
 };
 
-/* lcd_info_v2_1.panel_misc defintion */
+/* lcd_info_v2_1.panel_misc definition */
 enum atom_lcd_info_panel_misc{
   ATOM_PANEL_MISC_FPDI            =0x0002,
 };
@@ -683,7 +683,7 @@ enum atom_gpio_pin_assignment_gpio_id {
   /* gpio_id pre-define id for multiple usage */
   /* GPIO use to control PCIE_VDDC in certain SLT board */
   PCIE_VDDC_CONTROL_GPIO_PINID = 56,
-  /* if PP_AC_DC_SWITCH_GPIO_PINID in Gpio_Pin_LutTable, AC/DC swithing feature is enable */
+  /* if PP_AC_DC_SWITCH_GPIO_PINID in Gpio_Pin_LutTable, AC/DC switching feature is enable */
   PP_AC_DC_SWITCH_GPIO_PINID = 60,
   /* VDDC_REGULATOR_VRHOT_GPIO_PINID in Gpio_Pin_LutTable, VRHot feature is enable */
   VDDC_VRHOT_GPIO_PINID = 61,
-- 
2.25.1


