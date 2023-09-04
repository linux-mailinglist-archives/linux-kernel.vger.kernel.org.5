Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00B3791B45
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 18:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353313AbjIDQQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 12:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353317AbjIDQQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 12:16:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F87D1709;
        Mon,  4 Sep 2023 09:16:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [171.76.82.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A889666072AD;
        Mon,  4 Sep 2023 17:16:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693844178;
        bh=7W5lNOyCrtC6tzFADwhpkMdQvmxObo4VaXMUWmtRyf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOZfaooRFWiEablQxoxUOQv2pOxlMBXsxc1CL6SGGaXidRRW9jeH339PuZwFKkWw0
         2cQqzWWMsnlLloRH7zMBUtutsUYHgQfdShnVOQ3xbc2Jg7GanVMknYJTJ3yA0htXOW
         LXzFRlntnU6vrz/4HFAHM6K59YxQ7PDcwKlEwQpXvvDfk2Id0C7QeW7TPpmyjJDK7s
         ove/YpCsFDB6VN4nMW0CvLteZYGaVDDyQ2GnewtNX9BbCrhEU3z/BiIEavguu2oKBg
         LL73nEKGEIHk6Tj7bA7fjlffCk7OMbi9/SLlu0WL7ThCz+WA/rYOXAYNuY7hulHIkY
         xRlH0bhBr0Vtw==
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
Subject: [PATCH v2 3/7] drm: ci: virtio: update ci variables
Date:   Mon,  4 Sep 2023 21:45:12 +0530
Message-Id: <20230904161516.66751-4-vignesh.raman@collabora.com>
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

Update ci variables to fix the below error,
ERROR - Igt error: malloc(): corrupted top size
ERROR - Igt error: Received signal SIGABRT.
ERROR - Igt error: Stack trace:
ERROR - Igt error:  #0 [fatal_sig_handler+0x17b]

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - No changes
  
---
 drivers/gpu/drm/ci/test.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index 6473cddaa7a9..d85add39f425 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -316,8 +316,11 @@ virtio_gpu:none:
   stage: virtio-gpu
   variables:
     CROSVM_GALLIUM_DRIVER: llvmpipe
-    DRIVER_NAME: virtio_gpu
+    DRIVER_NAME: virtio
     GPU_VERSION: none
+    CROSVM_MEMORY: 12288
+    CROSVM_CPU: $FDO_CI_CONCURRENT
+    CROSVM_GPU_ARGS: "vulkan=true,gles=false,backend=virglrenderer,egl=true,surfaceless=true"
   extends:
     - .test-gl
   tags:
-- 
2.40.1

