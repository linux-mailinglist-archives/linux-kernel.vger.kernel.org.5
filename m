Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A8878873B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244572AbjHYM1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244849AbjHYM1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:27:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0DE2686;
        Fri, 25 Aug 2023 05:26:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [171.76.83.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 45CC9660728F;
        Fri, 25 Aug 2023 13:25:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692966340;
        bh=rgpvSeZGKF3SGFM/V9KInphj6CaJZryw7a6Wsi7NMHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUsazqsdd7YYCLplGD/KDgVV9qU8B7rbCgTNMJwelCqQvmG/vZMNdJXYqZEECL/nL
         EOVV27wzXS6bnAmH2uFcQXqMxz+Dmmq1srKqTdUThEhbUieSsk4iR17OP1aPOn4l0+
         a5EflmDqvEa2IEboOYZ3DW1zpi9qiaY6mrO0BDCzsyuYe3gv+j0z5FLJtXhPKUOeQ7
         +bYxU8nK3WN/ucLD9QwgOKn2nMrdDM3qO5Xb5g+FNzQv78xls3x6jMwOttal7xKcOe
         kQAtjS5VksTlpXSkYKKQ08dDod9zl4c/GXZnUHqwxSYvaCcSAdecYRLqqlEUHutoWK
         uN3CmS1+MkWKg==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     helen.koike@collabora.com, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, david.heidelberg@collabora.com,
        daniels@collabora.com, emma@anholt.net, robclark@freedesktop.org,
        gustavo.padovan@collabora.com, robdclark@google.com,
        anholt@google.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, corbet@lwn.net, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, heiko@sntech.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 6/6] drm: ci: Remove rules
Date:   Fri, 25 Aug 2023 17:54:35 +0530
Message-Id: <20230825122435.316272-7-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230825122435.316272-1-vignesh.raman@collabora.com>
References: <20230825122435.316272-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the rules from the following jobs, as the issues noted in the
TODO comments have been resolved. This will ensure that these jobs
are now included and executed as part of the CI/CD pipeline.

msm:apq8016:
TODO: current issue: it is not fiding the NFS root. Fix and remove this rule.

mediatek:mt8173:
TODO: current issue: device is hanging. Fix and remove this rule.

virtio_gpu:none:
TODO: current issue: malloc(): corrupted top size. Fix and remove this rule.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---
 drivers/gpu/drm/ci/gitlab-ci.yml | 2 +-
 drivers/gpu/drm/ci/test.yml      | 9 ---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index 2c4df53f5dfe..d2aac4404914 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -248,4 +248,4 @@ sanity:
 
 # Jobs that need to pass before spending hardware resources on further testing
 .required-for-hardware-jobs:
-  needs: []
\ No newline at end of file
+  needs: []
diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index d85add39f425..1771af21e2d9 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -108,9 +108,6 @@ msm:apq8016:
     RUNNER_TAG: google-freedreno-db410c
   script:
     - ./install/bare-metal/fastboot.sh
-  rules:
-    # TODO: current issue: it is not fiding the NFS root. Fix and remove this rule.
-    - when: never
 
 msm:apq8096:
   extends:
@@ -273,9 +270,6 @@ mediatek:mt8173:
     DEVICE_TYPE: mt8173-elm-hana
     GPU_VERSION: mt8173
     RUNNER_TAG: mesa-ci-x86-64-lava-mt8173-elm-hana
-  rules:
-    # TODO: current issue: device is hanging. Fix and remove this rule.
-    - when: never
 
 mediatek:mt8183:
   extends:
@@ -333,6 +327,3 @@ virtio_gpu:none:
     - debian/x86_64_test-gl
     - testing:x86_64
     - igt:x86_64
-  rules:
-    # TODO: current issue: malloc(): corrupted top size. Fix and remove this rule.
-    - when: never
\ No newline at end of file
-- 
2.40.1

