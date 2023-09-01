Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE14A790442
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 01:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbjIAXoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 19:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351300AbjIAXn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 19:43:59 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012171705
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 16:43:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68a42d06d02so2153070b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 16:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693611765; x=1694216565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1wNSnWkGtYsqmdJ7SiIP0G54S9pY24k7p5P1n8MG+s=;
        b=LRVbvyJLIf2G4Y1E4c9uUZDwHa6Lv59cz/pI/FIodexSSlLcPDdZr/X+85OGrBDOMb
         kbKhrHQ2EAkr14QjJzXpSIMaD4IAy0g0IJQgk5Ivrrtj7rrckRHKUtbTgQDpsooMQ8E2
         zdzl24htGHoenngLd5pjgD1rcTwJ3AAZebdVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693611765; x=1694216565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1wNSnWkGtYsqmdJ7SiIP0G54S9pY24k7p5P1n8MG+s=;
        b=gu6enYLvKYfWY0paG7jHGjWTLy3gKmfmAUC1Y1cr8DncpBqTKUSOyWb+oHOiWCsnrG
         I+5TsKaT/jvfzZkkx+tJVcGS7MbcEbfF3XrCT8Y8W39KRnEA1C+1R2Ky+Uxk6MvpGGM6
         zqZRwSxpBF7Eo6z6R19/qpss0x6dSD8+uomFRPRCh7FItLqUwl+z2giRNbEAmWoH+Jr1
         4tpUErRJDVT1VwT7KivdRxM4Til/1yOxojfJH/y1zBd4wdYyO0oIvwACjRoHB+8Aq1X2
         7wjTcJfFb9AY5WEEF49bzjCxZWB7VdutMcUFguOvFA2y5f0CCuJVt4/TDsXAprVxi6+L
         ihxA==
X-Gm-Message-State: AOJu0YwcVI1/AqSMWaIsgS6i2cIUC1vLeCEro5YY0M36JwaU5fQ/ifs9
        EEm4Ea7CU3xeHXSGzJlBPnbmPQ==
X-Google-Smtp-Source: AGHT+IEkl683gWaaIdVyv+hHmYbbrgZJNsGzwDeq5vblOp769UBG3JrWsk8J+Ps9xjU1Cfx4ftFMxQ==
X-Received: by 2002:a05:6a00:2484:b0:68b:e7d4:2564 with SMTP id c4-20020a056a00248400b0068be7d42564mr4944901pfv.24.1693611765024;
        Fri, 01 Sep 2023 16:42:45 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:8d94:1fc5:803c:41cc])
        by smtp.gmail.com with ESMTPSA id o9-20020a639a09000000b0056c3a4a3ca5sm3326390pge.36.2023.09.01.16.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 16:42:44 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, Bokun.Zhang@amd.com,
        Hawking.Zhang@amd.com, James.Zhu@amd.com, Victor.Zhao@amd.com,
        Xinhui.Pan@amd.com, YiPeng.Chai@amd.com, airlied@gmail.com,
        alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
        christian.koenig@amd.com, daniel@ffwll.ch, le.ma@amd.com,
        lijo.lazar@amd.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mario.limonciello@amd.com,
        mdaenzer@redhat.com, shiwu.zhang@amd.com,
        srinivasan.shanmugam@amd.com, tzimmermann@suse.de
Subject: [RFT PATCH 09/15] drm/amdgpu: Call drm_atomic_helper_shutdown() at shutdown time
Date:   Fri,  1 Sep 2023 16:41:20 -0700
Message-ID: <20230901164111.RFT.9.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230901234202.566951-1-dianders@chromium.org>
References: <20230901234202.566951-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on grepping through the source code this driver appears to be
missing a call to drm_atomic_helper_shutdown() at system shutdown
time. Among other things, this means that if a panel is in use that it
won't be cleanly powered off at system shutdown time.

The fact that we should call drm_atomic_helper_shutdown() in the case
of OS shutdown/restart comes straight out of the kernel doc "driver
instance overview" in drm_drv.c.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This commit is only compile-time tested.

...and further, I'd say that this patch is more of a plea for help
than a patch I think is actually right. I'm _fairly_ certain that
drm/amdgpu needs this call at shutdown time but the logic is a bit
hard for me to follow. I'd appreciate if anyone who actually knows
what this should look like could illuminate me, or perhaps even just
post a patch themselves!

 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8f2255b3a38a..cfcff0b37466 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1104,6 +1104,7 @@ static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_device *bdev)
 int amdgpu_device_init(struct amdgpu_device *adev,
 		       uint32_t flags);
 void amdgpu_device_fini_hw(struct amdgpu_device *adev);
+void amdgpu_device_shutdown_hw(struct amdgpu_device *adev);
 void amdgpu_device_fini_sw(struct amdgpu_device *adev);
 
 int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a2cdde0ca0a7..fa5925c2092d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4247,6 +4247,16 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 }
 
+void amdgpu_device_shutdown_hw(struct amdgpu_device *adev)
+{
+	if (adev->mode_info.mode_config_initialized) {
+		if (!drm_drv_uses_atomic_modeset(adev_to_drm(adev)))
+			drm_helper_force_disable_all(adev_to_drm(adev));
+		else
+			drm_atomic_helper_shutdown(adev_to_drm(adev));
+	}
+}
+
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
 	int idx;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e90f730eb715..3a7cbff111d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2333,6 +2333,8 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
+	amdgpu_device_shutdown_hw(adev);
+
 	if (amdgpu_ras_intr_triggered())
 		return;
 
-- 
2.42.0.283.g2d96d420d3-goog

