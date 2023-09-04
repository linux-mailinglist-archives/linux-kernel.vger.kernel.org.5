Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D1C791B4E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349477AbjIDQQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 12:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjIDQQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 12:16:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF951731;
        Mon,  4 Sep 2023 09:16:29 -0700 (PDT)
Received: from localhost.localdomain (unknown [171.76.82.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E316966072B1;
        Mon,  4 Sep 2023 17:16:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693844188;
        bh=umMyyWR3blb/7+ypoWlatuHnPXSznjCt0EiGPJfGB/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMBRS4WKAbFhDaryAvnht4UhVRxhiIXEvIqaCz5emM6lsb7xBCpMk7YC1EVsbp/zo
         QdAe7MOtwyyt5v7eJz7UzpV6sHhtg+I4YxGqdbR+wpzsqS35zev5TIqX4YWwnRxWJ2
         5WyUaUbUfaI+H5dumAgab8y/wbSxYGc+bPnkIbRbGPwqcEChyt6pyYy9ls0pZrx1QA
         DEScQBrSFPZKe8UcVCzizbqaiWP6WJ9/DrvMIwpkwsuzeVsTHu4rFTzY+QiPjJa1oQ
         sOl87ZfbKxlzzKOB/URZ9QoBUy2hUqZsnEkzEg7vkvpCHBQP8weYeIVhioM7btSYDL
         bz6X7MrH3BiFg==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     helen.koike@collabora.com, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, david.heidelberg@collabora.com,
        daniels@collabora.com, gustavo.padovan@collabora.com,
        emma@anholt.net, robclark@freedesktop.org, robdclark@google.com,
        anholt@google.com, robdclark@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, jani.nikula@linux.intel.com, mripard@kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 5/7] drm: ci: Update xfails
Date:   Mon,  4 Sep 2023 21:45:14 +0530
Message-Id: <20230904161516.66751-6-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230904161516.66751-1-vignesh.raman@collabora.com>
References: <20230904161516.66751-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update amdgpu-stoney-fails, mediatek-mt8173-flakes,
mediatek-mt8173-fails, rockchip-rk3399-fails, rockchip-rk3399-flakes,
rockchip-rk3288-flakes, i915-cml-fails, i915-cml-flakes,
msm-apq8016-flakes files.

Add tests that fail sometimes into the *-flakes file and tests
that are failing into the *-fails file.

Signed-off-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - No changes
  
---
 .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt    |  1 -
 drivers/gpu/drm/ci/xfails/i915-cml-fails.txt     |  1 -
 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt    |  2 ++
 drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt    |  1 +
 .../gpu/drm/ci/xfails/mediatek-mt8173-fails.txt  |  2 --
 .../gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt | 16 ++++++++++++++++
 drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt |  2 ++
 .../gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt |  1 +
 .../gpu/drm/ci/xfails/rockchip-rk3399-fails.txt  |  4 ++--
 .../gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt |  3 +++
 10 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/ci/xfails/amdgpu-stoney-fails.txt b/drivers/gpu/drm/ci/xfails/amdgpu-stoney-fails.txt
index bd9392536e7c..58bfded8a3fc 100644
--- a/drivers/gpu/drm/ci/xfails/amdgpu-stoney-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/amdgpu-stoney-fails.txt
@@ -1,7 +1,6 @@
 kms_addfb_basic@bad-pitch-65536,Fail
 kms_addfb_basic@bo-too-small,Fail
 kms_async_flips@invalid-async-flip,Fail
-kms_atomic@plane-immutable-zpos,Fail
 kms_atomic_transition@plane-toggle-modeset-transition,Fail
 kms_bw@linear-tiling-1-displays-2560x1440p,Fail
 kms_bw@linear-tiling-1-displays-3840x2160p,Fail
diff --git a/drivers/gpu/drm/ci/xfails/i915-cml-fails.txt b/drivers/gpu/drm/ci/xfails/i915-cml-fails.txt
index 6139b410e767..5f513c638beb 100644
--- a/drivers/gpu/drm/ci/xfails/i915-cml-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/i915-cml-fails.txt
@@ -1,4 +1,3 @@
-kms_color@ctm-0-25,Fail
 kms_flip_scaled_crc@flip-32bpp-linear-to-64bpp-linear-downscaling,Fail
 kms_flip_scaled_crc@flip-32bpp-linear-to-64bpp-linear-upscaling,Fail
 kms_flip_scaled_crc@flip-32bpp-xtile-to-64bpp-xtile-downscaling,Fail
diff --git a/drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt b/drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt
index 0514a7b3fdb0..f06f1a5b16f9 100644
--- a/drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt
+++ b/drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt
@@ -7,6 +7,8 @@ kms_bw@linear-tiling-3-displays-3840x2160p
 kms_bw@linear-tiling-4-displays-1920x1080p
 kms_bw@linear-tiling-4-displays-2560x1440p
 kms_bw@linear-tiling-4-displays-3840x2160p
+kms_color@ctm-0-25
+kms_cursor_legacy@torture-move
 kms_draw_crc@draw-method-xrgb8888-render-xtiled
 kms_flip@flip-vs-suspend
 kms_flip_scaled_crc@flip-32bpp-ytile-to-64bpp-ytile-downscaling
diff --git a/drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt b/drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt
index fc41d13a2d56..3aee1f11ee90 100644
--- a/drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt
+++ b/drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt
@@ -8,6 +8,7 @@ kms_bw@linear-tiling-3-displays-3840x2160p
 kms_bw@linear-tiling-4-displays-1920x1080p
 kms_bw@linear-tiling-4-displays-2560x1440p
 kms_bw@linear-tiling-4-displays-3840x2160p
+kms_cursor_legacy@torture-bo
 kms_flip@blocking-wf_vblank
 kms_flip@wf_vblank-ts-check
 kms_flip@wf_vblank-ts-check-interruptible
diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8173-fails.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8173-fails.txt
index 671916067dba..c8e64bbfd480 100644
--- a/drivers/gpu/drm/ci/xfails/mediatek-mt8173-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8173-fails.txt
@@ -1,5 +1,4 @@
 kms_3d,Fail
-kms_addfb_basic@addfb25-bad-modifier,Fail
 kms_bw@linear-tiling-1-displays-1920x1080p,Fail
 kms_bw@linear-tiling-1-displays-2560x1440p,Fail
 kms_bw@linear-tiling-1-displays-3840x2160p,Fail
@@ -11,7 +10,6 @@ kms_bw@linear-tiling-3-displays-2560x1440p,Fail
 kms_bw@linear-tiling-3-displays-3840x2160p,Fail
 kms_color@pipe-A-invalid-gamma-lut-sizes,Fail
 kms_color@pipe-B-invalid-gamma-lut-sizes,Fail
-kms_force_connector_basic@force-connector-state,Fail
 kms_force_connector_basic@force-edid,Fail
 kms_force_connector_basic@force-load-detect,Fail
 kms_force_connector_basic@prune-stale-modes,Fail
diff --git a/drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt b/drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
index e69de29bb2d1..9ed6722df2c2 100644
--- a/drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
+++ b/drivers/gpu/drm/ci/xfails/mediatek-mt8173-flakes.txt
@@ -0,0 +1,16 @@
+core_setmaster_vs_auth
+kms_addfb_basic@addfb25-bad-modifier
+kms_color@invalid-gamma-lut-sizes
+kms_cursor_legacy@cursor-vs-flip-atomic
+kms_cursor_legacy@cursor-vs-flip-legacy
+kms_force_connector_basic@force-connector-state
+kms_hdmi_inject@inject-4k
+kms_plane_scaling@plane-scaler-with-pixel-format-unity-scaling
+kms_plane_scaling@plane-upscale-with-modifiers-20x20
+kms_plane_scaling@plane-upscale-with-pixel-format-20x20
+kms_plane_scaling@plane-upscale-with-rotation-20x20
+kms_plane_scaling@planes-downscale-factor-0-25-upscale-20x20
+kms_plane_scaling@planes-downscale-factor-0-5-upscale-20x20
+kms_plane_scaling@planes-downscale-factor-0-75-upscale-20x20
+kms_prop_blob@invalid-set-prop
+kms_prop_blob@invalid-set-prop-any
diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt b/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
index 0e3b60d3fade..cd48a8c1d569 100644
--- a/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
+++ b/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
@@ -1,3 +1,5 @@
+kms_cursor_legacy@forked-bo
+kms_cursor_legacy@forked-move
 kms_force_connector_basic@force-connector-state
 kms_force_connector_basic@force-edid
 kms_force_connector_basic@force-load-detect
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt
index 45c54c75c899..081fe6f8d488 100644
--- a/drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3288-flakes.txt
@@ -1,6 +1,7 @@
 kms_addfb_basic@addfb25-bad-modifier
 kms_cursor_crc@.*
 kms_flip@basic-flip-vs-wf_vblank
+kms_flip@blocking-wf_vblank
 kms_invalid_mode@int-max-clock,Crash
 kms_pipe_crc_basic@.*
 kms_properties@connector-properties-atomic,Crash
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt
index 6db08ba6b008..029a3be3164d 100644
--- a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-fails.txt
@@ -2,14 +2,13 @@ kms_color@legacy-gamma,Fail
 kms_color@pipe-A-legacy-gamma,Fail
 kms_color@pipe-B-legacy-gamma,Fail
 kms_flip@basic-flip-vs-wf_vblank,Fail
-kms_flip@blocking-wf_vblank,Fail
 kms_flip@dpms-vs-vblank-race,Fail
 kms_flip@flip-vs-absolute-wf_vblank,Fail
 kms_flip@flip-vs-absolute-wf_vblank-interruptible,Fail
 kms_flip@flip-vs-blocking-wf-vblank,Fail
 kms_flip@flip-vs-panning,Fail
 kms_flip@flip-vs-panning-interruptible,Fail
-kms_flip@flip-vs-wf_vblank-interruptible,Fail
+kms_flip@modeset-vs-vblank-race,Fail
 kms_flip@plain-flip-fb-recreate,Fail
 kms_flip@plain-flip-fb-recreate-interruptible,Fail
 kms_flip@plain-flip-ts-check,Fail
@@ -35,3 +34,4 @@ kms_plane_multiple@atomic-pipe-B-tiling-none,Fail
 kms_plane_multiple@tiling-none,Fail
 kms_prime@basic-crc,Fail
 kms_rmfb@close-fd,Fail
+kms_universal_plane@universal-plane-pipe-B-functional,Fail
diff --git a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt
index 4c0539b4beaf..869426a02cbd 100644
--- a/drivers/gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt
+++ b/drivers/gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt
@@ -1,7 +1,10 @@
 
+kms_color@gamma
 kms_cursor_crc@.*
+kms_flip@blocking-wf_vblank
 kms_flip@dpms-vs-vblank-race-interruptible
 kms_flip@flip-vs-expired-vblank
+kms_flip@flip-vs-wf_vblank-interruptible
 kms_flip@modeset-vs-vblank-race-interruptible
 kms_pipe_crc_basic@.*
 kms_pipe_crc_basic@compare-crc-sanitycheck-pipe-A
-- 
2.40.1

