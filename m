Return-Path: <linux-kernel+bounces-27214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAE882EC53
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9741B21ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5CC134C6;
	Tue, 16 Jan 2024 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WxalD3kg"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA55134B3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705398944;
	bh=Tn+C3n03tNhekIf30piUSEYf+ajiHEYTFZ4foDIQlaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WxalD3kgWx42Sccc2+7/LZt2Rz9iBn+AWmE4isthaTm2vMtAcgyoCt0USfvllXCzA
	 fxQ0Z6T0O/fJDEhYg98iS42f7RSHMqwi5NlTXdczQGaIx0mg2oZJ/FZNBY/IgLKU0X
	 oZaFBQRpyw20mx1oO8HEP3S5cH48NNSekxF0cpzjsjGUq36RiTkNMPSm1iJvNk2ydK
	 JcA4MrkYVLmloru+zzpAN/6c89wxbMdDb+0tM4MukeXEPV29mY0lYfBZd2DunDtuka
	 ZTFr+OADY7kRCHOGUJX+h1dy4VVFRvMshNl5pmukn/J71X1l1rBwgdpHqcEZO7XyeA
	 P8n3hinMwCp6Q==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1F05A3782068;
	Tue, 16 Jan 2024 09:55:38 +0000 (UTC)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniel@fooishbar.org,
	helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	david.heidelberg@collabora.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] drm/ci: mediatek: Rename exisitng job
Date: Tue, 16 Jan 2024 15:24:34 +0530
Message-Id: <20240116095439.107324-3-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240116095439.107324-1-vignesh.raman@collabora.com>
References: <20240116095439.107324-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For mediatek mt8173 and mt8183, the display driver is mediatek.
Currently, in drm-ci for mediatek, only the display driver is
tested. So rename the mediatek job to indicate that display
driver is tested.

Rename the name of xfail files for mediatek (mt8173 and mt8183),
to include information about the tested driver and update xfails
accordingly. Since the correct driver name is passed from the job to
test gpu and display driver, remove the check to set IGT_FORCE_DRIVER
based on driver name.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - Refactor the patch to rename job to indicate display driver testing,
    rename the existing xfail files, and remove IGT_FORCE_DRIVER from the
    script since it's now set by the job.

---
 drivers/gpu/drm/ci/igt_runner.sh              | 10 ---------
 drivers/gpu/drm/ci/test.yml                   | 21 ++++++++++++++-----
 ....txt => mediatek-mt8173-display-fails.txt} |  0
 .../xfails/mediatek-mt8173-display-flakes.txt | 13 ++++++++++++
 .../xfails/mediatek-mt8183-display-fails.txt  |  7 +++++++
 .../xfails/mediatek-mt8183-display-flakes.txt |  8 +++++++
 .../drm/ci/xfails/mediatek-mt8183-fails.txt   | 13 ------------
 7 files changed, 44 insertions(+), 28 deletions(-)
 rename drivers/gpu/drm/ci/xfails/{mediatek-mt8173-fails.txt => mediatek-mt8173-display-fails.txt} (100%)
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-display-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-display-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-display-flakes.txt
 delete mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt

diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
index f1a08b9b146f..ce6e22369d4d 100755
--- a/drivers/gpu/drm/ci/igt_runner.sh
+++ b/drivers/gpu/drm/ci/igt_runner.sh
@@ -20,16 +20,6 @@ cat /sys/kernel/debug/dri/*/state
 set -e
 
 case "$DRIVER_NAME" in
-    rockchip|meson)
-        export IGT_FORCE_DRIVER="panfrost"
-        ;;
-    mediatek)
-        if [ "$GPU_VERSION" = "mt8173" ]; then
-            export IGT_FORCE_DRIVER=${DRIVER_NAME}
-        elif [ "$GPU_VERSION" = "mt8183" ]; then
-            export IGT_FORCE_DRIVER="panfrost"
-        fi
-        ;;
     amdgpu)
         # Cannot use HWCI_KERNEL_MODULES as at that point we don't have the module in /lib
         mv /install/modules/lib/modules/* /lib/modules/.
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 355b794ef2b1..e3aaec06a65d 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -279,29 +279,40 @@ amdgpu:stoney:
     - .lava-igt:arm64
   stage: mediatek
   variables:
-    DRIVER_NAME: mediatek
     DTB: ${DEVICE_TYPE}
     BOOT_METHOD: depthcharge
     KERNEL_IMAGE_TYPE: ""
 
-mediatek:mt8173:
+.mt8173:
   extends:
     - .mediatek
   parallel: 4
   variables:
     DEVICE_TYPE: mt8173-elm-hana
-    GPU_VERSION: mt8173
     RUNNER_TAG: mesa-ci-x86-64-lava-mt8173-elm-hana
 
-mediatek:mt8183:
+.mt8183:
   extends:
     - .mediatek
   parallel: 3
   variables:
     DEVICE_TYPE: mt8183-kukui-jacuzzi-juniper-sku16
-    GPU_VERSION: mt8183
     RUNNER_TAG: mesa-ci-x86-64-lava-mt8183-kukui-jacuzzi-juniper-sku16
 
+mediatek:mt8173-display:
+  extends:
+    - .mt8173
+  variables:
+    GPU_VERSION: mt8173-display
+    DRIVER_NAME: mediatek
+
+mediatek:mt8183-display:
+  extends:
+    - .mt8183
+  variables:
+    GPU_VERSION: mt8183-display
+    DRIVER_NAME: mediatek
+
 # drm-mtk doesn't even probe yet in mainline for mt8192
 .mediatek:mt8192:
   extends:
diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8173-fails.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8173-display-fails.txt
similarity index 100%
rename from drivers/gpu/drm/ci/xfails/mediatek-mt8173-fails.txt
rename to drivers/gpu/drm/ci/xfails/mediatek-mt8173-display-fails.txt
diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8173-display-flakes.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8173-display-flakes.txt
new file mode 100644
index 000000000000..64b30c092c85
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8173-display-flakes.txt
@@ -0,0 +1,13 @@
+# Board Name: mt8173-elm-hana.dtb
+# Bug Report: https://lore.kernel.org/dri-devel/931e3f9a-9c5c-fc42-16fc-abaac4e0c0ff@collabora.com/T/#u
+# IGT Version: 1.28-gd2af13d9f
+# Failure Rate: 50
+# Linux Version: 6.7.0-rc3
+
+# Reported by deqp-runner
+kms_cursor_legacy@cursor-vs-flip-atomic-transitions
+
+# Below test shows inconsistency across multiple runs,
+# giving results of Pass and Timeout/Fail alternately
+kms_prop_blob@invalid-set-prop
+kms_prop_blob@invalid-set-prop-any
diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-display-fails.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-display-fails.txt
new file mode 100644
index 000000000000..bfa2f92c907a
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-display-fails.txt
@@ -0,0 +1,7 @@
+kms_bw@linear-tiling-2-displays-3840x2160p,Fail
+kms_cursor_legacy@cursor-vs-flip-atomic,Fail
+kms_flip@flip-vs-panning-vs-hang,Fail
+kms_flip@flip-vs-suspend,Fail
+kms_prop_blob@invalid-set-prop,Fail
+kms_prop_blob@invalid-set-prop-any,Fail
+kms_properties@get_properties-sanity-atomic,Fail
diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-display-flakes.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-display-flakes.txt
new file mode 100644
index 000000000000..5885a950fa72
--- /dev/null
+++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-display-flakes.txt
@@ -0,0 +1,8 @@
+# Board Name: mt8183-kukui-jacuzzi-juniper-sku16.dtb
+# Bug Report: https://lore.kernel.org/dri-devel/931e3f9a-9c5c-fc42-16fc-abaac4e0c0ff@collabora.com/T/#u
+# IGT Version: 1.28-gd2af13d9f
+# Failure Rate: 100
+# Linux Version: 6.7.0-rc3
+
+# Reported by deqp-runner
+kms_cursor_legacy@cursor-vs-flip-atomic-transitions
diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
deleted file mode 100644
index 67d690fc4037..000000000000
--- a/drivers/gpu/drm/ci/xfails/mediatek-mt8183-fails.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-kms_addfb_basic@addfb25-bad-modifier,Fail
-kms_bw@linear-tiling-1-displays-2560x1440p,Fail
-kms_bw@linear-tiling-2-displays-1920x1080p,Fail
-kms_bw@linear-tiling-2-displays-2560x1440p,Fail
-kms_bw@linear-tiling-2-displays-3840x2160p,Fail
-kms_bw@linear-tiling-3-displays-2560x1440p,Fail
-kms_bw@linear-tiling-3-displays-3840x2160p,Fail
-kms_color@pipe-A-invalid-gamma-lut-sizes,Fail
-kms_plane_cursor@overlay,Fail
-kms_plane_cursor@primary,Fail
-kms_plane_cursor@viewport,Fail
-kms_plane_scaling@upscale-with-rotation-20x20,Fail
-kms_rmfb@close-fd,Fail
-- 
2.40.1


