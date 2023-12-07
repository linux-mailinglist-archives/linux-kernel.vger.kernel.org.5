Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7501A80845A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378588AbjLGJSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjLGJSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:18:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4708D10C0;
        Thu,  7 Dec 2023 01:18:49 -0800 (PST)
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AF9336607390;
        Thu,  7 Dec 2023 09:18:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701940728;
        bh=dQ0I3KVxJFnBzrqq6GuCqoIBfvIJZXEwFZhY/AqFdis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ReWjOiZo9rxuv/mfLQexz/CZDhQnyU2IUB2pl3m01Gxopu3JDxYb0fbVcBtNkasqv
         GJVP3rK/ROcmbjFowKQEvaEnxUz/fq1/fn88/C4qvMwtday/5qgNlaJkKpsn6YMh9U
         8Aw6vImsjYoLkhwpv7xb3uQOBQ+l2+Jr5U/cSx5Lu/qjqLcNuGSFi1zM+92WvQG0eM
         OinQGbzbHkyBVaaNRJ7ULbQX1mxDwUb+e/nRKofQHbg0FO/aWVykPJYldH9wFeYNbY
         aPqtEPpXXcIsdWdD7c6c2ludMrKNJ05ZXrix1QAe76TXkSUeCob/kw94v7EMemew0j
         XzHFGABMBb4/A==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     david.heidelberg@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robdclark@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 01/10] drm: ci: igt_runner: Remove todo
Date:   Thu,  7 Dec 2023 14:48:22 +0530
Message-Id: <20231207091831.660054-2-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207091831.660054-1-vignesh.raman@collabora.com>
References: <20231207091831.660054-1-vignesh.raman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/sys/kernel/debug/dri/*/state exist for every atomic KMS driver.
We do not test non-atomic drivers, so remove the todo.

Acked-by: Helen Koike <helen.koike@collabora.com>
Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v2:
  - No changes

v3:
  - No changes

v4:
  - No changes

v5:
  - No changes

v6:
  - No changes

v7:
  - No changes

---
 drivers/gpu/drm/ci/igt_runner.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/drm/ci/igt_runner.sh
index 2f815ee3a8a3..c6cf963592c5 100755
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

