Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A568B7FD676
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjK2MS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjK2MSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:18:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD04CD7E;
        Wed, 29 Nov 2023 04:18:59 -0800 (PST)
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5E61C6602F27;
        Wed, 29 Nov 2023 12:18:55 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701260338;
        bh=DI8NeroZ4KuIzbHmXtJcxjhkRSFvlWciXa6rjeCI55k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRhx/2kuS24H4npWUoFcWkL6nqKXoBTHVFKhUY0thnxcB/rwKUVUUYC6+twghI7gm
         w6GNltt6DTz68tWbkxOrFYK9ZowNpN3j4ASRkUgoKSEiCDA36J/56kI3FsTPQGNoFC
         RUvZgfpE5YLfGnY0yuInslNOG0eBeaEcU/s4vn1aQjECtcUBHKA8YAaRD/fuCNzH5N
         SIwXsbryAyYsQur9RpXq37SxKCGOVaSM71yNgdicPCCJlBJf2uy3mLCEWpE4V+yJV7
         CZpFb0vjZkgjz4mUp6eWma07v9ULz04Vy1LCL5tSkaLPV8OdnnMB4I3OO2R7PZwdkm
         olN2eayaPSRhw==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     david.heidelberg@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robdclark@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 01/10] drm: ci: igt_runner: Remove todo
Date:   Wed, 29 Nov 2023 17:48:32 +0530
Message-Id: <20231129121841.253223-2-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129121841.253223-1-vignesh.raman@collabora.com>
References: <20231129121841.253223-1-vignesh.raman@collabora.com>
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

