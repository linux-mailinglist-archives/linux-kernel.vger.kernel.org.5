Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A444B7989CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbjIHPXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243637AbjIHPXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:23:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA811FC4;
        Fri,  8 Sep 2023 08:23:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [171.76.82.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 22E0C66072A2;
        Fri,  8 Sep 2023 16:23:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694186587;
        bh=U53MyadmkUoo+q2fgQ1q5zkF0GV25IACrHzrAL1ghFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SsmNkBjmb4DzUxzQ7C3tROK4iWGGMyOVw2tfVwGYw0BuPDP/A1hwXe1bUU9WRCaQW
         Ad/WVTNM0WJsC2IVOu3Oz5XNrf9HSJTzuKJ1fdIeNIPFWK10lghn36DYwEggiFWBbR
         Fxo3wONRpTjhoMCumF2qHcNarOw4ZhI3suNIG93CXP8ixbdopWqrEou17+VZA7Oa4r
         Pvf65Elam8iiZwWjbgAXcwE0sd5/0DJfo9dkSNwqW3fvKzLCy8Fi8mMj6Fx/UxYspp
         57c/lZWPfXEbBMvspYs3LnnXiDr/HNYpXbwknoFlmdZS1X7OotQ657PHw1GXEqJQ0P
         OI5XSWW9N+KMQ==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     helen.koike@collabora.com, guilherme.gallo@collabora.com,
        sergi.blanch.torne@collabora.com, david.heidelberg@collabora.com,
        daniels@collabora.com, gustavo.padovan@collabora.com,
        angelogioacchino.delregno@collabora.com, emma@anholt.net,
        robclark@freedesktop.org, robdclark@google.com, anholt@google.com,
        robdclark@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, mripard@kernel.org,
        dmitry.baryshkov@linaro.org, matthias.bgg@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 1/9] drm: ci: igt_runner: Remove todo
Date:   Fri,  8 Sep 2023 20:52:17 +0530
Message-Id: <20230908152225.432139-2-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908152225.432139-1-vignesh.raman@collabora.com>
References: <20230908152225.432139-1-vignesh.raman@collabora.com>
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

/sys/kernel/debug/dri/*/state exist for every atomic KMS driver.
We do not test non-atomic drivers, so remove the todo.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - No changes

v3:
  - No changes
  
---
 drivers/gpu/drm/ci/igt_runner.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
index 2bb759165063..5bf130ac57c9 100755
--- a/drivers/gpu/drm/ci/igt_runner.sh
+++ b/drivers/gpu/drm/ci/igt_runner.sh
@@ -15,7 +15,6 @@ cat /sys/kernel/debug/device_component/*
 '
 
 # Dump drm state to confirm that kernel was able to find a connected display:
-# TODO this path might not exist for all drivers.. maybe run modetest instead?
 set +e
 cat /sys/kernel/debug/dri/*/state
 set -e
-- 
2.40.1

