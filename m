Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E307868B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbjHXHil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbjHXHiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:38:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A2DC7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:38:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 079AD62349
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7545C433CC;
        Thu, 24 Aug 2023 07:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692862682;
        bh=8KAGK/pCRryvB+pifyUnHrIVznLi7QuAqCIeWiGv0as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oUBVB7WSOsWQwTReD7RO4Xdvbtoj3weNATue3V95ZaBQnJBOfR35SOlYfEuG5XK97
         q+2Lzv4gyWcINm3BjY4BNu8YQ8I8HZITQhxk4ASCP63PURcotWXoisT29/nd9RFlS8
         CH34RY+vKW0T2kkJ1rZ+ArdGYRGHuZfzmLcKsLB4UYjY6drZ0oAv8VuZSFQ6FwyT9t
         8VADzfniwV2kJmHARJS7z8aTtoRYeUS1OlHM2lpUlvMO3ODCvjBFOdJUFWdnjZRZ8Y
         DMTG08cyvgItNohmd8sHYQc0KA7U6yaTes3lRDqEcyDWsady4/uxPfTx74Dy6nCD/b
         rjVcFEwIQKQ8w==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 13/20] drm/tests/drm_kunit_helpers: Correct possible double-entry typo in 'ddrm_kunit_helper_acquire_ctx_alloc'
Date:   Thu, 24 Aug 2023 08:36:58 +0100
Message-ID: <20230824073710.2677348-14-lee@kernel.org>
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

 drivers/gpu/drm/tests/drm_kunit_helpers.c:172: warning: expecting prototype for ddrm_kunit_helper_acquire_ctx_alloc(). Prototype was for drm_kunit_helper_acquire_ctx_alloc() instead

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
index f102c23eee1dd..c1dfbfcaa0001 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -156,7 +156,7 @@ static void action_drm_release_context(void *ptr)
 }
 
 /**
- * ddrm_kunit_helper_acquire_ctx_alloc - Allocates an acquire context
+ * drm_kunit_helper_acquire_ctx_alloc - Allocates an acquire context
  * @test: The test context object
  *
  * Allocates and initializes a modeset acquire context.
-- 
2.42.0.rc1.204.g551eb34607-goog

