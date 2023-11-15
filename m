Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17807EC0CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjKOKgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOKf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:35:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2916BF5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700044551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xp9UARNaNPlyIdSssZLj0kaySqIS1RLPGJplNZMoPJI=;
        b=eM6STUDMrPAzGZ79RHZEP7bSOxZeDSxBYBIXmJIlsQ24/xBbo7gNNVaAnIM/VclrJjtIKO
        2ilkKZm14S1HUNMouqZopUQCBvxgMVRb29bUobJEmsp87st0z6XihhyReZEQuJvXeE0ssl
        e+Urs/YL+v78crsZvev3S6xEtO0dHbI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-i9jKdrBfNyunIqs2oCPaMQ-1; Wed, 15 Nov 2023 05:35:48 -0500
X-MC-Unique: i9jKdrBfNyunIqs2oCPaMQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5a7d261a84bso94440947b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700044548; x=1700649348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xp9UARNaNPlyIdSssZLj0kaySqIS1RLPGJplNZMoPJI=;
        b=UgTmeE5PXQ6jjqWa8df3jg2EOXH6JsYuDS47v+5OnYO9KzTwC0qyEBGUJOGSCnW2FM
         Mxu3YEX3/3Lioo0WeysJHzDIo7OEgDtfNDcoj/FQns8W9SzflG7NITwT8ZpYVAdJUhJV
         7ghT7rsXAvXJJbtJ+NOLv8wxJdJ6HO6WsVT1mLcWFXPFMRjR++rDfg0YkN19Co4qg5I9
         gcho/CLNNdrgIl4Raj/pHtA4OXXBn4ucj95l3+wC0o0oDr+rPnqj6H+xC3KldWV5CDBf
         3RCx5xpbwpsCBTJ0tptAmW/feC1AimESSg8cPbmeCUfCn+V/75Y4pLKtV/Y6ntDMHdo2
         A3Ng==
X-Gm-Message-State: AOJu0YxCspV+JLUZWDAH6ghmYqZ4/frZJ+aXtQwrbx9EwuWNBuApFFaI
        4uHbIKxX/TQUzELBVduAsd3cf3Y4jxiTbBOopWo2s7thKskQ/dHyoLUNrVgtrfsKIg/5L2VMaUN
        KAKJSxYyrqULswbNAe8c6pEc=
X-Received: by 2002:a0d:cb8b:0:b0:5a7:ab55:b9af with SMTP id n133-20020a0dcb8b000000b005a7ab55b9afmr12166713ywd.35.1700044548001;
        Wed, 15 Nov 2023 02:35:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1kcYhFvm+awVN8EG3QhLKaWIkC0dBHxZ6wSdcnkopOF0pSjVhSr9LCAUmzhdoryV7+qfkyg==
X-Received: by 2002:a0d:cb8b:0:b0:5a7:ab55:b9af with SMTP id n133-20020a0dcb8b000000b005a7ab55b9afmr12166708ywd.35.1700044547785;
        Wed, 15 Nov 2023 02:35:47 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-24-178.cust.vodafonedsl.it. [2.34.24.178])
        by smtp.gmail.com with ESMTPSA id s20-20020a05621412d400b00647386a3234sm433267qvv.85.2023.11.15.02.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 02:35:47 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marco Pagani <marpagan@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/test: rearrange test entries in Kconfig and Makefile
Date:   Wed, 15 Nov 2023 11:35:36 +0100
Message-ID: <20231115103537.220760-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange entries in Kconfig and Makefile alphabetically to make room
for additional KUnit test suites.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/gpu/drm/Kconfig        | 10 +++++-----
 drivers/gpu/drm/tests/Makefile |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 3eee8636f847..cdbc56e07649 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -75,15 +75,15 @@ config DRM_KUNIT_TEST_HELPERS
 config DRM_KUNIT_TEST
 	tristate "KUnit tests for DRM" if !KUNIT_ALL_TESTS
 	depends on DRM && KUNIT
-	select PRIME_NUMBERS
+	select DRM_BUDDY
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HELPER
-	select DRM_LIB_RANDOM
-	select DRM_KMS_HELPER
-	select DRM_BUDDY
+	select DRM_EXEC
 	select DRM_EXPORT_FOR_TESTS if m
+	select DRM_KMS_HELPER
 	select DRM_KUNIT_TEST_HELPERS
-	select DRM_EXEC
+	select DRM_LIB_RANDOM
+	select PRIME_NUMBERS
 	default KUNIT_ALL_TESTS
 	help
 	  This builds unit tests for DRM. This option is not useful for
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index ba7baa622675..2645af241ff0 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_DRM_KUNIT_TEST) += \
 	drm_connector_test.o \
 	drm_damage_helper_test.o \
 	drm_dp_mst_helper_test.o \
+	drm_exec_test.o \
 	drm_format_helper_test.o \
 	drm_format_test.o \
 	drm_framebuffer_test.o \
@@ -17,7 +18,6 @@ obj-$(CONFIG_DRM_KUNIT_TEST) += \
 	drm_modes_test.o \
 	drm_plane_helper_test.o \
 	drm_probe_helper_test.o \
-	drm_rect_test.o	\
-	drm_exec_test.o
+	drm_rect_test.o
 
 CFLAGS_drm_mm_test.o := $(DISABLE_STRUCTLEAK_PLUGIN)

base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.41.0

