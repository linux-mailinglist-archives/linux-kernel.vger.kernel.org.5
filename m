Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E9078872D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244193AbjHYM0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244848AbjHYM0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:26:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377492116;
        Fri, 25 Aug 2023 05:25:53 -0700 (PDT)
Received: from localhost.localdomain (unknown [171.76.83.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0DE23660319E;
        Fri, 25 Aug 2023 13:24:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692966305;
        bh=x4lq+tbR066pnVQGeJjEJAxiYr3tkgjX1Xjly0l74rI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wi+smrECNXlcnUOBI7muZ/8Nm8As7l8y6nvRVAqrMSZgU8xWkdOzhvNJ1TL2rVRhV
         ablXvIcmLPu01xDlOLUujge/fRUGoYyfbaMnP8OzGLVRWu4uNvbLUi72C+BIEC7IHn
         SmwjvI3b0cokzv+aOFSSS6t5++foVeu6fhuBewNDxrwj4wOouQAoCbczYw+GL9faM2
         dsdEDuy32afZqIehx19Ir2PfDFDxoJlt5EBHg/5d3C5GcxgRq/PqPk4RHTMU8viPzL
         f9zUHPHN10hz9hxR3tDpz682Sgh+7HwXDx7f9dLpOIJ5csTx1kiIlNDT0j2nPAtHqF
         4dnfo7WtXwSdA==
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
Subject: [PATCH 1/6] drm: ci: igt_runner: remove todo
Date:   Fri, 25 Aug 2023 17:54:30 +0530
Message-Id: <20230825122435.316272-2-vignesh.raman@collabora.com>
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

/sys/kernel/debug/dri/*/state exist for every atomic KMS driver.
We do not test non-atomic drivers, so remove the todo.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
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

