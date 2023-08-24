Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF217868B1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240461AbjHXHie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240400AbjHXHhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48B010FE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5445565936
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB535C433C8;
        Thu, 24 Aug 2023 07:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692862670;
        bh=CHcMfyq7Y4yTbOAJVaDkP63E5aZjNy43V54/xurTZfs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KrGTyrol/RafYXTu3j6Wlw9OigD+fdeU+u36c3+tMTLRBfnvOm79YgyOCpu2va6BO
         oytQvt0gOIgqUBnZeRL3rSQqRPx+gui/o+htJ9D/jKX394v/aWlvOqIA9U79zRStVz
         zDCpmJodY+NrBrGESzwrQUdC/EtBH6o2WtUbSPJQwZxVVPqeajXxksjah3zCqVERRh
         Equhty7b5tENDNFmZM05mRcHVaz/iPLQX7gLLnAYc5lt1Ly/VXo7ca+wy57WSzXcRW
         afzBjILS09g84iDKn00DKGWEiWsknaFhQN6huisM7ter6Xa9wxtCY2YrCUEmQoYup/
         nlpSgWcFwRmkw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 09/20] drm/tests/drm_kunit_helpers: Place correct function name in the comment header
Date:   Thu, 24 Aug 2023 08:36:54 +0100
Message-ID: <20230824073710.2677348-10-lee@kernel.org>
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

 drivers/gpu/drm/tests/drm_kunit_helpers.c:172: warning: expecting prototype for drm_kunit_helper_context_alloc(). Prototype was for drm_kunit_helper_acquire_ctx_alloc() instead

Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: "Maíra Canal" <mairacanal@riseup.net>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 3d624ff2f6517..f102c23eee1dd 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -156,7 +156,7 @@ static void action_drm_release_context(void *ptr)
 }
 
 /**
- * drm_kunit_helper_context_alloc - Allocates an acquire context
+ * ddrm_kunit_helper_acquire_ctx_alloc - Allocates an acquire context
  * @test: The test context object
  *
  * Allocates and initializes a modeset acquire context.
-- 
2.42.0.rc1.204.g551eb34607-goog

