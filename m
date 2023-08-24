Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1957868B3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbjHXHih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbjHXHh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:37:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C06C7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:37:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 408D162349
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551FFC433C9;
        Thu, 24 Aug 2023 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692862676;
        bh=HAx36VxD8SeJ19cuhWARnMLzp3fwBWyVuZuUJYdgr/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHuHQaGg4Vb86jowcTNgkWiVaVeYdqTolC0e84zCxI8iISBvWduO+la86lew1mX5S
         yrHkH1eRcW1Ar0svfHOovGuWCJpKh+e7NsKP7UE9oez3OLiEy4caGPDBggU5pDFW61
         8lXY1H+o3m5N8W19E4JZIAlwqZjssGSszLiJtwKHCQvxexYl+/3OE39X97kAKZXgO2
         ZJkjcAwCA760dNQHuSnWRkdvk/yG6NyRqKKnuRkqrD8Vev8vrazo4AxJQZ95F2mKvw
         og5sbSAmypyfGTlS+JTu6aH6bmSiw6NT70BHJAkLs9SnmNI5fXuRlmqHlu1Jb31KPG
         Zyrb3ARi6Uh8Q==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shashank Sharma <shashank.sharma@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 11/20] drm/amd/amdgpu/amdgpu_doorbell_mgr: Correct misdocumented param 'doorbell_index'
Date:   Thu, 24 Aug 2023 08:36:56 +0100
Message-ID: <20230824073710.2677348-12-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824073710.2677348-1-lee@kernel.org>
References: <20230824073710.2677348-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c:123: warning: Function parameter or member 'doorbell_index' not described in 'amdgpu_doorbell_index_on_bar'
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c:123: warning: Excess function parameter 'db_index' description in 'amdgpu_doorbell_index_on_bar'

Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index da4be0bbb4466..d0249ada91d30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -113,7 +113,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
  *
  * @adev: amdgpu_device pointer
  * @db_bo: doorbell object's bo
- * @db_index: doorbell relative index in this doorbell object
+ * @doorbell_index: doorbell relative index in this doorbell object
  *
  * returns doorbell's absolute index in BAR
  */
-- 
2.42.0.rc1.204.g551eb34607-goog

