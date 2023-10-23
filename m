Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711E67D3CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjJWQqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjJWQqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC82E4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698079561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bDdV6vKEwynTtIWNDDANhowwMTEJWz/8nr/BNp+GhQo=;
        b=cuqSyG8tXcm49LunTAlUQrXT5tGh6+IQHjk7cnMomb8AP1lDYQaWAzVB3055xhvgsDHqVK
        Jqg+KitmC2qrg+DjjfNtfg6PDHlQAt+tK0BUg0BipOukQVnuhYVUwvXjMnCnF5/qE0b6Bl
        tjvR3yeEnbeciDvEWXdeQbf3CNXs1+8=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-ykAVMxBQODyTRq6BoKH5FQ-1; Mon, 23 Oct 2023 12:45:55 -0400
X-MC-Unique: ykAVMxBQODyTRq6BoKH5FQ-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-457c02bfb64so1734661137.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698079555; x=1698684355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDdV6vKEwynTtIWNDDANhowwMTEJWz/8nr/BNp+GhQo=;
        b=nqYU6xjEbME6OGVHwU1YGoMJw7J7oYpDpi+4gzStJXzY0CBiSumxHXm3VrhJrEgR6/
         sgIG1xSsYI5jHw99ACUO5zGdGzSYyWnezXVBSJMInz1tROeCPruW69Psl0Oof/+ZEFdZ
         J/KvLPvO+txi9CuzROkUoDR43/fuow6oNq0SoL0q4yt1FDf+Th5xmIAkLJ5yQBch781v
         2rgVNOSscY41P2V+Je43ZCHdy4hADMZm39lq8VhbX/HjnRLGufID+H9mcgoqFJw36GfU
         bJXbI6+cpmSU1NJEVdVab3dYNKa2MqDqpm1nS6pCgsEjz3ayLQxrrFzJnE30XETdXO+L
         XrEw==
X-Gm-Message-State: AOJu0YzVhR/cErej6aSdWq4TMgYzTCKFOf9OwMDdwrIw2ntlJpCc/VGc
        Onk2lYsjWciURQ/+eSfzTQCl3mYfBHSTXHZQHcpnv+iY/TFiI8s1Pxnj9o5wQdOmYEMhSeFGZev
        NuMNZQ7nGRNUbBSoi5OsQ90o=
X-Received: by 2002:a67:e114:0:b0:457:6cf4:6fa2 with SMTP id d20-20020a67e114000000b004576cf46fa2mr8099884vsl.4.1698079554648;
        Mon, 23 Oct 2023 09:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLwoQjwceKkUAwDMJn4avaZIKfK6c04KakeBVIIXjNnuuHhT8ZNUyX6L0ek48c5MBmVurGyw==
X-Received: by 2002:a67:e114:0:b0:457:6cf4:6fa2 with SMTP id d20-20020a67e114000000b004576cf46fa2mr8099865vsl.4.1698079554286;
        Mon, 23 Oct 2023 09:45:54 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-31-107.cust.vodafonedsl.it. [2.34.31.107])
        by smtp.gmail.com with ESMTPSA id g21-20020a05620a109500b0077580becd52sm2812885qkk.103.2023.10.23.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 09:45:54 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: [RFC PATCH] drm/test: add a test suite for GEM objects backed by shmem
Date:   Mon, 23 Oct 2023 18:45:40 +0200
Message-ID: <20231023164541.92913-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces an initial KUnit test suite for GEM objects
backed by shmem buffers.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/gpu/drm/Kconfig                    |   1 +
 drivers/gpu/drm/tests/Makefile             |   3 +-
 drivers/gpu/drm/tests/drm_gem_shmem_test.c | 303 +++++++++++++++++++++
 3 files changed, 306 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/tests/drm_gem_shmem_test.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 3eee8636f847..f0a77e3e04d7 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -84,6 +84,7 @@ config DRM_KUNIT_TEST
 	select DRM_EXPORT_FOR_TESTS if m
 	select DRM_KUNIT_TEST_HELPERS
 	select DRM_EXEC
+	select DRM_GEM_SHMEM_HELPER
 	default KUNIT_ALL_TESTS
 	help
 	  This builds unit tests for DRM. This option is not useful for
diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index ba7baa622675..b8227aab369e 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_DRM_KUNIT_TEST) += \
 	drm_plane_helper_test.o \
 	drm_probe_helper_test.o \
 	drm_rect_test.o	\
-	drm_exec_test.o
+	drm_exec_test.o \
+	drm_gem_shmem_test.o
 
 CFLAGS_drm_mm_test.o := $(DISABLE_STRUCTLEAK_PLUGIN)
diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
new file mode 100644
index 000000000000..0bf6727f08d2
--- /dev/null
+++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test suite for GEM objects backed by shmem buffers
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#include <linux/dma-buf.h>
+#include <linux/iosys-map.h>
+#include <linux/sizes.h>
+
+#include <kunit/test.h>
+
+#include <drm/drm_device.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_kunit_helpers.h>
+
+#define TEST_SIZE		SZ_1M
+#define TEST_BYTE		0xae
+
+struct fake_dev {
+	struct drm_device drm_dev;
+	struct device *dev;
+};
+
+/* Test creating a shmem GEM object */
+static void drm_gem_shmem_test_obj_create(struct kunit *test)
+{
+	struct fake_dev *fdev = test->priv;
+	struct drm_gem_shmem_object *shmem;
+
+	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
+	KUNIT_ASSERT_EQ(test, shmem->base.size, TEST_SIZE);
+	KUNIT_ASSERT_NOT_NULL(test, shmem->base.filp);
+	KUNIT_ASSERT_NOT_NULL(test, shmem->base.funcs);
+
+	drm_gem_shmem_free(shmem);
+}
+
+/* Test creating a private shmem GEM object from a scatter/gather table */
+static void drm_gem_shmem_test_obj_create_private(struct kunit *test)
+{
+	struct fake_dev *fdev = test->priv;
+	struct drm_gem_shmem_object *shmem;
+	struct drm_gem_object *gem_obj;
+	struct dma_buf buf_mock;
+	struct dma_buf_attachment attach_mock;
+	struct sg_table *sgt;
+	char *buf;
+	int ret;
+
+	/* Create a mock scatter/gather table */
+	buf = kunit_kzalloc(test, TEST_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+
+	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sgt);
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	sg_init_one(sgt->sgl, buf, TEST_SIZE);
+
+	/* Init a mock DMA-BUF */
+	buf_mock.size = TEST_SIZE;
+	attach_mock.dmabuf = &buf_mock;
+
+	gem_obj = drm_gem_shmem_prime_import_sg_table(&fdev->drm_dev, &attach_mock, sgt);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, gem_obj);
+	KUNIT_ASSERT_EQ(test, gem_obj->size, TEST_SIZE);
+	KUNIT_ASSERT_NULL(test, gem_obj->filp);
+	KUNIT_ASSERT_NOT_NULL(test, gem_obj->funcs);
+
+	shmem = to_drm_gem_shmem_obj(gem_obj);
+	KUNIT_ASSERT_PTR_EQ(test, shmem->sgt, sgt);
+
+	/* The scatter/gather table is freed by drm_gem_shmem_free */
+	drm_gem_shmem_free(shmem);
+}
+
+/* Test pinning backing pages */
+static void drm_gem_shmem_test_pin_pages(struct kunit *test)
+{
+	struct fake_dev *fdev = test->priv;
+	struct drm_gem_shmem_object *shmem;
+	int i, ret;
+
+	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
+	KUNIT_ASSERT_NULL(test, shmem->pages);
+	KUNIT_ASSERT_EQ(test, shmem->pages_use_count, 0);
+
+	ret = drm_gem_shmem_pin(shmem);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_NOT_NULL(test, shmem->pages);
+	KUNIT_ASSERT_EQ(test, shmem->pages_use_count, 1);
+
+	for (i = 0; i < (shmem->base.size >> PAGE_SHIFT); i++)
+		KUNIT_ASSERT_NOT_NULL(test, shmem->pages[i]);
+
+	drm_gem_shmem_unpin(shmem);
+	KUNIT_ASSERT_NULL(test, shmem->pages);
+	KUNIT_ASSERT_EQ(test, shmem->pages_use_count, 0);
+
+	drm_gem_shmem_free(shmem);
+}
+
+/* Test creating a virtual mapping */
+static void drm_gem_shmem_test_vmap(struct kunit *test)
+{
+	struct fake_dev *fdev = test->priv;
+	struct drm_gem_shmem_object *shmem;
+	struct iosys_map map;
+	int ret, i;
+
+	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
+	KUNIT_ASSERT_NULL(test, shmem->vaddr);
+	KUNIT_ASSERT_EQ(test, shmem->vmap_use_count, 0);
+
+	ret = drm_gem_shmem_vmap(shmem, &map);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_NOT_NULL(test, shmem->vaddr);
+	KUNIT_ASSERT_EQ(test, shmem->vmap_use_count, 1);
+	KUNIT_ASSERT_FALSE(test, iosys_map_is_null(&map));
+
+	iosys_map_memset(&map, 0, TEST_BYTE, TEST_SIZE);
+	for (i = 0; i < TEST_SIZE; i++)
+		KUNIT_ASSERT_EQ(test, iosys_map_rd(&map, i, u8), TEST_BYTE);
+
+	drm_gem_shmem_vunmap(shmem, &map);
+	KUNIT_ASSERT_NULL(test, shmem->vaddr);
+	KUNIT_ASSERT_EQ(test, shmem->vmap_use_count, 0);
+
+	drm_gem_shmem_free(shmem);
+}
+
+/* Test exporting a scatter/gather table */
+static void drm_gem_shmem_test_get_pages_sgt(struct kunit *test)
+{
+	struct fake_dev *fdev = test->priv;
+	struct drm_gem_shmem_object *shmem;
+	struct sg_table *sgt;
+	struct scatterlist *sg;
+	unsigned int si, len = 0;
+	int ret;
+
+	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
+
+	ret = drm_gem_shmem_pin(shmem);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	sgt = drm_gem_shmem_get_sg_table(shmem);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
+	KUNIT_ASSERT_NULL(test, shmem->sgt);
+
+	for_each_sgtable_sg(sgt, sg, si) {
+		KUNIT_ASSERT_NOT_NULL(test, sg);
+		len += sg->length;
+	}
+	KUNIT_ASSERT_GE(test, len, TEST_SIZE);
+
+	kfree(sgt);
+	drm_gem_shmem_free(shmem);
+}
+
+/* Test exporting a scatter/gather pinned table for PRIME */
+static void drm_gem_shmem_test_get_sg_table(struct kunit *test)
+{
+	struct fake_dev *fdev = test->priv;
+	struct drm_gem_shmem_object *shmem;
+	struct sg_table *sgt;
+	struct scatterlist *sg;
+	unsigned int si, len = 0;
+
+	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
+
+	sgt = drm_gem_shmem_get_pages_sgt(shmem);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
+	KUNIT_ASSERT_PTR_EQ(test, sgt, shmem->sgt);
+
+	for_each_sgtable_sg(sgt, sg, si) {
+		KUNIT_ASSERT_NOT_NULL(test, sg);
+		len += sg->length;
+	}
+	KUNIT_ASSERT_GE(test, len, TEST_SIZE);
+
+	/* The scatter/gather table is freed by drm_gem_shmem_free */
+	drm_gem_shmem_free(shmem);
+}
+
+/* Test updating madvise status */
+static void drm_gem_shmem_test_madvise(struct kunit *test)
+{
+	struct fake_dev *fdev = test->priv;
+	struct drm_gem_shmem_object *shmem;
+	int ret;
+
+	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
+	KUNIT_ASSERT_EQ(test, shmem->madv, 0);
+
+	ret = drm_gem_shmem_madvise(shmem, 1);
+	KUNIT_ASSERT_TRUE(test, ret);
+	KUNIT_ASSERT_EQ(test, shmem->madv, 1);
+
+	ret = drm_gem_shmem_madvise(shmem, -1);
+	KUNIT_ASSERT_FALSE(test, ret);
+	KUNIT_ASSERT_EQ(test, shmem->madv, -1);
+
+	ret = drm_gem_shmem_madvise(shmem, 0);
+	KUNIT_ASSERT_FALSE(test, ret);
+	KUNIT_ASSERT_EQ(test, shmem->madv, -1);
+
+	drm_gem_shmem_free(shmem);
+}
+
+/* Test purging */
+static void drm_gem_shmem_test_purge(struct kunit *test)
+{
+	struct fake_dev *fdev = test->priv;
+	struct drm_gem_shmem_object *shmem;
+	struct sg_table *sgt;
+	int ret;
+
+	shmem = drm_gem_shmem_create(&fdev->drm_dev, TEST_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, shmem);
+
+	ret = drm_gem_shmem_is_purgeable(shmem);
+	KUNIT_ASSERT_FALSE(test, ret);
+
+	ret = drm_gem_shmem_madvise(shmem, 1);
+	KUNIT_ASSERT_TRUE(test, ret);
+
+	sgt = drm_gem_shmem_get_pages_sgt(shmem);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt);
+
+	ret = drm_gem_shmem_is_purgeable(shmem);
+	KUNIT_ASSERT_TRUE(test, ret);
+
+	drm_gem_shmem_purge(shmem);
+	KUNIT_ASSERT_TRUE(test, ret);
+
+	drm_gem_shmem_free(shmem);
+}
+
+static int drm_gem_shmem_test_init(struct kunit *test)
+{
+	struct fake_dev *fdev;
+	struct device *dev;
+
+	/* Allocate a parent device */
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	/*
+	 * The DRM core will automatically initialize the GEM core and create
+	 * a DRM Memory Manager object which provides an address space pool
+	 * for GEM objects allocation.
+	 */
+	fdev = drm_kunit_helper_alloc_drm_device(test, dev, struct fake_dev,
+						 drm_dev, DRIVER_GEM);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdev);
+
+	fdev->dev = dev;
+	test->priv = fdev;
+
+	return 0;
+}
+
+static void drm_gem_shmem_test_exit(struct kunit *test)
+{
+	struct fake_dev *fdev = test->priv;
+
+	drm_kunit_helper_free_device(test, fdev->dev);
+}
+
+static struct kunit_case drm_gem_shmem_test_cases[] = {
+	KUNIT_CASE(drm_gem_shmem_test_obj_create),
+	KUNIT_CASE(drm_gem_shmem_test_obj_create_private),
+	KUNIT_CASE(drm_gem_shmem_test_pin_pages),
+	KUNIT_CASE(drm_gem_shmem_test_vmap),
+	KUNIT_CASE(drm_gem_shmem_test_get_pages_sgt),
+	KUNIT_CASE(drm_gem_shmem_test_get_sg_table),
+	KUNIT_CASE(drm_gem_shmem_test_madvise),
+	KUNIT_CASE(drm_gem_shmem_test_purge),
+	{}
+};
+
+static struct kunit_suite drm_gem_shmem_suite = {
+	.name = "drm_gem_shmem",
+	.init = drm_gem_shmem_test_init,
+	.exit = drm_gem_shmem_test_exit,
+	.test_cases = drm_gem_shmem_test_cases
+};
+
+kunit_test_suite(drm_gem_shmem_suite);

base-commit: 3f5ba636d6987ddffeaa056dea1c524da63912f3
-- 
2.41.0

