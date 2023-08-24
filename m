Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3581E7868BC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbjHXHiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240389AbjHXHiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:38:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893DE1716;
        Thu, 24 Aug 2023 00:38:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E91462349;
        Thu, 24 Aug 2023 07:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CD6C433CA;
        Thu, 24 Aug 2023 07:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692862698;
        bh=qTc11hboeB2aZlOqkN91NN/Dw5CZWbyrOr80wSzYNm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JvZadWCEBYotqkspkGwfoN/lfsikJ/T6fYB+lxsBQ4+b/7xuDAS+euYAqFWJjjorV
         nJaf7bDOyNhZLRm3jEvgi+JdXdxxzS9roTINN1HfZo41vRV8EC4z/4GLmh1r3q/RAT
         gwV4hMG5CwA6dEYGxHZe7CV7AYsnuIf7L1K2fVUfHwsFcPxScxjf8LE9ya9ZtVuewB
         7I8t1tgs8gXolFV3dApvgXNSvl5c9lqSMMkqraj0/2d3Werd/kFOz6G6cKvASlNYXe
         uJw42JOzUyihKE3BMX638v9Uw9GDCzksJVdFaGOIElhLbpHTxhaocarxF+4KPLuNti
         pOPqUkbedTifg==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Danilo Krummrich <dakr@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [PATCH 18/20] drm/drm_gpuva_mgr: Remove set but unused variable 'prev'
Date:   Thu, 24 Aug 2023 08:37:03 +0100
Message-ID: <20230824073710.2677348-19-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824073710.2677348-1-lee@kernel.org>
References: <20230824073710.2677348-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/drm_gpuva_mgr.c: In function ‘__drm_gpuva_sm_map’:
 drivers/gpu/drm/drm_gpuva_mgr.c:1079:39: warning: variable ‘prev’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
---
 drivers/gpu/drm/drm_gpuva_mgr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuva_mgr.c b/drivers/gpu/drm/drm_gpuva_mgr.c
index f86bfad74ff8a..ad99c9cfedac7 100644
--- a/drivers/gpu/drm/drm_gpuva_mgr.c
+++ b/drivers/gpu/drm/drm_gpuva_mgr.c
@@ -1076,7 +1076,7 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
 		   u64 req_addr, u64 req_range,
 		   struct drm_gem_object *req_obj, u64 req_offset)
 {
-	struct drm_gpuva *va, *next, *prev = NULL;
+	struct drm_gpuva *va, *next;
 	u64 req_end = req_addr + req_range;
 	int ret;
 
@@ -1106,7 +1106,7 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
 				ret = op_unmap_cb(ops, priv, va, merge);
 				if (ret)
 					return ret;
-				goto next;
+				continue;
 			}
 
 			if (end > req_end) {
@@ -1151,7 +1151,7 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
 				ret = op_remap_cb(ops, priv, &p, NULL, &u);
 				if (ret)
 					return ret;
-				goto next;
+				continue;
 			}
 
 			if (end > req_end) {
@@ -1184,7 +1184,7 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
 				ret = op_unmap_cb(ops, priv, va, merge);
 				if (ret)
 					return ret;
-				goto next;
+				continue;
 			}
 
 			if (end > req_end) {
@@ -1205,8 +1205,6 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
 				break;
 			}
 		}
-next:
-		prev = va;
 	}
 
 	return op_map_cb(ops, priv,
-- 
2.42.0.rc1.204.g551eb34607-goog

