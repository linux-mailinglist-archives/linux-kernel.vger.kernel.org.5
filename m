Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74CD7FD697
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjK2MTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbjK2MT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:19:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31811FD4;
        Wed, 29 Nov 2023 04:19:23 -0800 (PST)
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: vignesh)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 344CA6607325;
        Wed, 29 Nov 2023 12:19:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701260362;
        bh=O5ckehyI20/PoLmFk+FV3fLp1KbSS4iwwIAE9XfLTh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+WiHN3gCDt6vq+jDhSG7b8yQDkYWemthE6ABt1fa9Hazyp8zqJeM9wW/w/uz0cQz
         Eg0iMzsj7MsUCs1wGKkd96wLK/MK8PGYXoH6h6DDbJlUFg5fGLhwbiEjKGT+KCblyo
         jSTXJKUt4qpVLqzzHFCQvxQnKuYOQv+4Jux+uFCjOGlJx+aP1fQD3bJaq15aG6bpAU
         tVJtDMOzdUyMqCRp0Z9K1e2KzqOEbWlgzwSJlI/kXrgDLibdWeZS6KYc6JhyGxqXkm
         daUeCsjPUoRUMXm8KmxDRzzxTORlSZrjoAKfBiSHZKE/OCrninnhKiVE/9FEwCrwrZ
         D+UWU24o7lXgg==
From:   Vignesh Raman <vignesh.raman@collabora.com>
To:     helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     david.heidelberg@collabora.com, sergi.blanch.torne@collabora.com,
        guilherme.gallo@collabora.com, daniels@collabora.com,
        gustavo.padovan@collabora.com, emma@anholt.net,
        robdclark@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 07/10] drm: ci: virtio: Make artifacts available
Date:   Wed, 29 Nov 2023 17:48:38 +0530
Message-Id: <20231129121841.253223-8-vignesh.raman@collabora.com>
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

There were no artifacts available for virtio job.
So make the artifacts available in the pipeline job.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v5:
  - Added a new patch in the series to make artifacts available for virtio jobs

v6:
  - No changes

---
 drivers/gpu/drm/ci/test.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index e0fdc55c9b69..2c9a1838e728 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -329,6 +329,8 @@ virtio_gpu:none:
   script:
     - ln -sf $CI_PROJECT_DIR/install /install
     - mv install/bzImage /lava-files/bzImage
+    - mkdir -p $CI_PROJECT_DIR/results
+    - ln -sf $CI_PROJECT_DIR/results /results
     - install/crosvm-runner.sh install/igt_runner.sh
   needs:
     - debian/x86_64_test-gl
-- 
2.40.1

