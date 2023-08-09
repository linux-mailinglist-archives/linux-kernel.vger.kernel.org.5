Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1407776C75
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjHIWvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjHIWvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A06DE4B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691621440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gF/DsPM8L4MqlHp9tlfI2YXb+0b5z0aTjeRWWwXcwao=;
        b=a9pwQK5fvZObNawAs6snqGcVOIjQiIUOzFzE72//888nhyCb+uax/vCgk6ZTGn8aXBMS6E
        t6Ze5UZy/7b2q9rlFwc/ojpEWZ5SGCP2GRS3/zoiQMmgpVY6ZEVtZ2zxtZ+M01OmkYbDW+
        EQaIkVcViTKKPHrCBCZeTTcPKy1e11s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-EHxs8vDlMd24BNvD624gcg-1; Wed, 09 Aug 2023 18:50:39 -0400
X-MC-Unique: EHxs8vDlMd24BNvD624gcg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a34d3e5ebso19924666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 15:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691621438; x=1692226238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gF/DsPM8L4MqlHp9tlfI2YXb+0b5z0aTjeRWWwXcwao=;
        b=AS1gYZ+T3Zo97fdXIqMt4MgUT2GR+VazZvomVQwYj2OWRE0+Kp5UYkaf9tpnyBs+F+
         sdSm6kF72uCSQ2mx83edBaJaPavxaWQwNT/aR29CTVH9ye8c32sl+l8TRWWYexk2QAuJ
         xF2ArSOt9H4zrTgOfe+MoZVxy90WE+/CvinsQbAMxTKU61ACjkDzo65YlQ1MFcnKDmIv
         wZCOkQcvgm1/EA/B6A+DaGS74DzX/NzvUIw30iX5P7cOjK9hcGX0KD/VcHVYVvnbrKqX
         Xojmq7etZUwZ4m6itcyp6HB00Pbm9hjX4RHI3nB6Bp/xN/IVagmDKDjRHO09WCy2lV10
         SW0w==
X-Gm-Message-State: AOJu0YzD+oOCgBhsJG1B26jNLIGEVk/Ck4ntnjg6k6ckJkTMFdxMuDjm
        PB4uwCObUR5gtqJ5NFOt0uCQaYSWIkhrDCCOvSVIXP6GT7Gan/LsOwbaZqkh5kC4fkwIXE005vN
        hcrmj4QHdAi3vGZTGXYOELNOk
X-Received: by 2002:a17:906:105c:b0:99b:4956:e4e3 with SMTP id j28-20020a170906105c00b0099b4956e4e3mr366948ejj.8.1691621438188;
        Wed, 09 Aug 2023 15:50:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6vRNFFeqAB3QpQbIXjT+bkqtYOwBj+1lQOt4+Ju691WeyIdUOlvAcgM88u9tqNgL2EABoqQ==
X-Received: by 2002:a17:906:105c:b0:99b:4956:e4e3 with SMTP id j28-20020a170906105c00b0099b4956e4e3mr366938ejj.8.1691621437902;
        Wed, 09 Aug 2023 15:50:37 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id kg23-20020a17090776f700b0099cfd0b2437sm99580ejc.99.2023.08.09.15.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 15:50:37 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, christian.koenig@amd.com,
        alexander.deucher@amd.com, arthurgrillo@riseup.net
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next] drm/test: drm_exec: fix memory leak on object prepare
Date:   Thu, 10 Aug 2023 00:50:14 +0200
Message-ID: <20230809225034.8803-1-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index f79c9f0359aa..9ccf0dd9ca89 100644
--- a/drivers/gpu/drm/tests/drm_exec_test.c
+++ b/drivers/gpu/drm/tests/drm_exec_test.c
@@ -125,8 +125,6 @@ static void test_duplicates(struct kunit *test)
 	drm_exec_fini(&exec);
 }
 
-
-
 static void test_prepare(struct kunit *test)
 {
 	struct drm_exec_priv *priv = test->priv;
@@ -145,6 +143,8 @@ static void test_prepare(struct kunit *test)
 			break;
 	}
 	drm_exec_fini(&exec);
+
+	drm_gem_private_object_fini(&gobj);
 }
 
 static void test_prepare_array(struct kunit *test)
@@ -165,6 +165,9 @@ static void test_prepare_array(struct kunit *test)
 					     1);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	drm_exec_fini(&exec);
+
+	drm_gem_private_object_fini(&gobj1);
+	drm_gem_private_object_fini(&gobj2);
 }
 
 static struct kunit_case drm_exec_tests[] = {

base-commit: e05f3938c5a7896d09736e3381675a57ffee7a0a
-- 
2.41.0

