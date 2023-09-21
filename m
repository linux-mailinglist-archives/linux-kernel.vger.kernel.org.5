Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4567A9D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjIUTmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjIUTmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:42:02 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C816311C9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:36 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c364fb8a4cso12168595ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695324515; x=1695929315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIB9Su1U7bIPFr+7ANN/OcavTAqWwcBq0GS4I1/bwSs=;
        b=kA6r8M8D6Zpr7sxzIC+SfyB79mHUCKovgwcDPwEVLYgz10fPiu0IgMY8JNr//MEMfL
         kOmkrIGwDWfenhXNaIzEnQ3K/IAKCH8owsMw5ZchmcmYLk6XB7RXok1v+97Ppsnsd9XR
         l3U2zsJGakrUFmXlBAXPfEHlwGH/ftunRaVQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695324515; x=1695929315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIB9Su1U7bIPFr+7ANN/OcavTAqWwcBq0GS4I1/bwSs=;
        b=ZFddzsZR+DmC9ftY00mJBLVGY9APdp2LXROVIY9P9PIuR6DMREWtgMF+5WapBmOCzZ
         ch+y6ZfGAbaJ4f+buB1U0QNInSBAi767OVT1QZwyzup4BkHtC0Zdy+LTHqyRHOYEH4lj
         V4ek32NVJR+007mAYKX89msO3vlWRHDlqS8szgLeNap4Jzj3rW/SyneL/+qmq39teGPH
         s690Z6Yv3A0W4FdUpQqjKOJluROxiKpNWfbPGt7ck35W15fFGVTMqhx5b4/uKtpSYxuQ
         DJa5ekV5a0/CaRKHYsIdPGtrKYFYlk19nNSvKgd6qheV1kvZIYgRZmYCVVD0tk6ejHWz
         GRdw==
X-Gm-Message-State: AOJu0Ywp22PBlvkOiDzj43sgqpoQAsPlddRK4iXOFpSgn9EPSLujrBsW
        N/0vRbf59Okp0D0BQPzwp5qpMQ==
X-Google-Smtp-Source: AGHT+IG6gT2BLC16ToMT+YRTSkTdSEdEW0H2PnMiZoFRHOn+2vS6h4Vr0OhvW/jKYuQ4kfyd3+axAQ==
X-Received: by 2002:a17:902:bb83:b0:1c2:82e:32de with SMTP id m3-20020a170902bb8300b001c2082e32demr5155768pls.0.1695324515416;
        Thu, 21 Sep 2023 12:28:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e6ed:6d49:f262:8041])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709029a8800b001b9f032bb3dsm1892875plp.3.2023.09.21.12.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 12:28:34 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>, Bokun.Zhang@amd.com,
        Hawking.Zhang@amd.com, James.Zhu@amd.com, Victor.Zhao@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
        daniel@ffwll.ch, felix.kuehling@amd.com, jim.cromie@gmail.com,
        le.ma@amd.com, lijo.lazar@amd.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mario.limonciello@amd.com,
        mdaenzer@redhat.com, shiwu.zhang@amd.com,
        srinivasan.shanmugam@amd.com, tzimmermann@suse.de
Subject: [RFT PATCH v2 07/12] drm/amdgpu: Call drm_atomic_helper_shutdown() at shutdown time
Date:   Thu, 21 Sep 2023 12:26:50 -0700
Message-ID: <20230921122641.RFT.v2.7.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921192749.1542462-1-dianders@chromium.org>
References: <20230921192749.1542462-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

(no changes since v1)

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
2.42.0.515.g380fc7ccd1-goog

