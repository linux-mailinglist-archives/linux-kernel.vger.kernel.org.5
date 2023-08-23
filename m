Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAB47863F3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 01:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbjHWXcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 19:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbjHWXcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 19:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA852E75
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692833489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xfIBvMHNvpsOSgSnZMhoSJSbG62O2gZi4ABK8EMkbSQ=;
        b=eusM+yf0SETelQiYQppSUcbyuuKp0ce/6rL7idIAytimkfebd6B8+jjq43k+Akdgcn4VVb
        ztz7SmFjxr9iVnk13/X08+lB9g/gVk1Gbv8SExUkCzML83lHyurEsKGlMK2PBErGOHJ7Hw
        iHrQo9pYNhrGzESkub7cmMXAGx0BGPk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-wcjD3bfVPhuP811-Z0ZTog-1; Wed, 23 Aug 2023 19:31:28 -0400
X-MC-Unique: wcjD3bfVPhuP811-Z0ZTog-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-94a34d3e5ebso416661966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 16:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692833487; x=1693438287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfIBvMHNvpsOSgSnZMhoSJSbG62O2gZi4ABK8EMkbSQ=;
        b=GYO/sidEo9A6pbU76rlpF8AU0R+ZfEKyjsAAh/Dfma36KDt8fs9hNoTgjBmnPYdAYk
         pLLejBuuO2AoXvGeWT18O5yX0+FlgCsBxewkhaxYxvbUmWTDYKQSEbglJDxlCX46UJhv
         glJ73W9K4cG7t2yJGGfRv6UIWsPGJTnZvln9orMgObMXzkwkLuM9+eNhtcR3ajQg/3ep
         SIID0WJ+x3RvMiKIHW/wXAAcNR+f+ND09MgytecZGdOyf5qnptsiplboS3IsBMsLWBYb
         jcEjI5HH1YXN61DXuZUo1LMZ23+YuRdFLOTZb8HFnQ+dqEDVAmyiqmTliB48WbVI6uVl
         3spA==
X-Gm-Message-State: AOJu0Yyqa/Dut8Y2FfX+ZJ3ucOKcDC26p7Kb9yXy1K+syPyC+s6R/lZj
        ywqLYMHwlPCmpEr/wR2WzG1nx9V0rnnSrjSX40bxv3Xz3KZ1sEooiw6j5eIoVsRTLrcG/3enxSh
        oR2qVORlAD+92l4EKcQNpB3OuNBYinkOq
X-Received: by 2002:a05:6402:2051:b0:522:b1cb:e6c with SMTP id bc17-20020a056402205100b00522b1cb0e6cmr10588564edb.38.1692833487065;
        Wed, 23 Aug 2023 16:31:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX6ZLtlac/xGYXKpeeZ4nqkoxp3F+cUKCmdJe3qaYOQF32XgUQpel6SE0V9QNARP6jWmjA9A==
X-Received: by 2002:a05:6402:2051:b0:522:b1cb:e6c with SMTP id bc17-20020a056402205100b00522b1cb0e6cmr10588560edb.38.1692833486826;
        Wed, 23 Aug 2023 16:31:26 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id r26-20020aa7d59a000000b005233609e39dsm2891936edq.30.2023.08.23.16.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 16:31:26 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, boris.brezillon@collabora.com,
        matthew.brost@intel.com, thomas.hellstrom@linux.intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next] drm/gpuva_mgr: remove unused prev pointer in __drm_gpuva_sm_map()
Date:   Thu, 24 Aug 2023 01:31:12 +0200
Message-ID: <20230823233119.2891-1-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prev pointer in __drm_gpuva_sm_map() was used to implement automatic
merging of mappings. Since automatic merging did not make its way
upstream, remove this leftover.

Fixes: e6303f323b1a ("drm: manager to keep track of GPUs VA mappings")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_gpuva_mgr.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuva_mgr.c b/drivers/gpu/drm/drm_gpuva_mgr.c
index 1bc91fc60ef3..3e1ca878cb7e 100644
--- a/drivers/gpu/drm/drm_gpuva_mgr.c
+++ b/drivers/gpu/drm/drm_gpuva_mgr.c
@@ -1743,7 +1743,7 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
 		   u64 req_addr, u64 req_range,
 		   struct drm_gem_object *req_obj, u64 req_offset)
 {
-	struct drm_gpuva *va, *next, *prev = NULL;
+	struct drm_gpuva *va, *next;
 	u64 req_end = req_addr + req_range;
 	int ret;
 
@@ -1773,7 +1773,7 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
 				ret = op_unmap_cb(ops, priv, va, merge);
 				if (ret)
 					return ret;
-				goto next;
+				continue;
 			}
 
 			if (end > req_end) {
@@ -1818,7 +1818,7 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
 				ret = op_remap_cb(ops, priv, &p, NULL, &u);
 				if (ret)
 					return ret;
-				goto next;
+				continue;
 			}
 
 			if (end > req_end) {
@@ -1851,7 +1851,7 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
 				ret = op_unmap_cb(ops, priv, va, merge);
 				if (ret)
 					return ret;
-				goto next;
+				continue;
 			}
 
 			if (end > req_end) {
@@ -1872,8 +1872,6 @@ __drm_gpuva_sm_map(struct drm_gpuva_manager *mgr,
 				break;
 			}
 		}
-next:
-		prev = va;
 	}
 
 	return op_map_cb(ops, priv,
-- 
2.41.0

