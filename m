Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23D8766028
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 01:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjG0XLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 19:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjG0XLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF67F30C5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690499444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6weMTuIpszNXHkxpzKCFeAxVKVKCcANl7NKRIpHMrd4=;
        b=JGDpRi7YXeOQ07jMqJekMW0z/fUDPLG9HShjXZ7fBPZbToQs+HkJHtni/icVwhKS8193MB
        88mZw0sgfFhgUz7v6AS0ajkIIBXGPmX/bW3JlFubtHZ3Z4A7PJx0o9Y1zmB5+OMK4XKpZY
        ksqYBj2BGAvsR4gnCNXc/28lNfI40p0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-OMv6W2GsOUaKesLdou0evw-1; Thu, 27 Jul 2023 19:10:42 -0400
X-MC-Unique: OMv6W2GsOUaKesLdou0evw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-997c891a88dso83020766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690499441; x=1691104241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6weMTuIpszNXHkxpzKCFeAxVKVKCcANl7NKRIpHMrd4=;
        b=FdIX5m/Rlrm96UP8zDa36lG8bEDWglb/VYvNuWZpC/pB70R4vQXKWsx2X/e73CJCxk
         yibVO339jqunoOE2GsNlq14GgT/7qxgUR/wscJryWQ6erDUJ6ufs2jtzn5KOggKE+ay7
         jNDdORLSQ3M2BaCSbC5HlQ+sVLXv13m5l932uvM7ACECC7dUa58WfZhwNn1Bbg++32ZC
         S7dvA2is5uQasukDDud/cgUEZ1WegqoOJ+69Ur1gJNKt2sAqVkTi5ka+EGz0eD/ALNTk
         BmIUC2ZueiIDxuX/SqU9ASy6+ajgy255tRrl39f8/uyM9jeYH77oaJsgpeLCkOugUsfP
         i36A==
X-Gm-Message-State: ABy/qLb8LOf9x8BhhCOWEx20YVp0xrbt9tw9/IEr4RhDb29kZ1pQ1WCq
        S+Dw7Lp9yXjw2GcVjhgeamkJ/R/ug2F83AOsv6eUy8GhGnW06DWtkDxI0XKkp+AeRjD/kJe7a9d
        H2T6bAFlEvNTyOswqzZvh+oZ6Lvi4xBu4
X-Received: by 2002:a17:906:51c5:b0:993:ec0b:1a27 with SMTP id v5-20020a17090651c500b00993ec0b1a27mr439233ejk.24.1690499441027;
        Thu, 27 Jul 2023 16:10:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHUrTLDUvyW3xVYY9d7PdNdUMDSsSTZWNlXYh7cW8nBlIxTJhayg6BbjNw9w2E28yu4KbEVGg==
X-Received: by 2002:a17:906:51c5:b0:993:ec0b:1a27 with SMTP id v5-20020a17090651c500b00993ec0b1a27mr439226ejk.24.1690499440783;
        Thu, 27 Jul 2023 16:10:40 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id y20-20020a17090629d400b00992e14af9b9sm1292554eje.134.2023.07.27.16.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 16:10:40 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, christian.koenig@amd.com,
        alexander.deucher@amd.com, arthurgrillo@riseup.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH] drm/test: drm_exec: fix memory leak on object prepare
Date:   Fri, 28 Jul 2023 01:10:36 +0200
Message-ID: <20230727231038.4943-1-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_exec_prepare_obj() and drm_exec_prepare_array() both reserve
dma-fence slots and hence a dma_resv_list without ever freeing it.

Make sure to call drm_gem_private_object_fini() for each GEM object
passed to drm_exec_prepare_obj()/drm_exec_prepare_array() throughout the
test to fix this up.

While at it, remove some trailing empty lines.

Fixes: 9710631cc8f3 ("drm: add drm_exec selftests v4")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/tests/drm_exec_test.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_exec_test.c b/drivers/gpu/drm/tests/drm_exec_test.c
index df31f89a7945..80761e734a15 100644
--- a/drivers/gpu/drm/tests/drm_exec_test.c
+++ b/drivers/gpu/drm/tests/drm_exec_test.c
@@ -118,8 +118,6 @@ static void test_duplicates(struct kunit *test)
 	drm_exec_fini(&exec);
 }
 
-
-
 static void test_prepare(struct kunit *test)
 {
 	struct drm_gem_object gobj = { };
@@ -137,6 +135,8 @@ static void test_prepare(struct kunit *test)
 			break;
 	}
 	drm_exec_fini(&exec);
+
+	drm_gem_private_object_fini(&gobj);
 }
 
 static void test_prepare_array(struct kunit *test)
@@ -156,6 +156,9 @@ static void test_prepare_array(struct kunit *test)
 					     1);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	drm_exec_fini(&exec);
+
+	drm_gem_private_object_fini(&gobj1);
+	drm_gem_private_object_fini(&gobj2);
 }
 
 static struct kunit_case drm_exec_tests[] = {
-- 
2.41.0

