Return-Path: <linux-kernel+bounces-25447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CD482D061
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 11:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879491C20B53
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F7F1FD1;
	Sun, 14 Jan 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK9zSmx2"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EEB1FBF
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bd5f1711e3so1427453b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 02:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705229747; x=1705834547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5su21lrElvoMrT51RPv9OkcSkDVz35FwFqaxlZOVWbQ=;
        b=mK9zSmx24nhr8nzBAhajiTAOmoiANmrHUdBjpQ4aB6ofA030UFF90r+0qY/5195GS4
         ohehMQPIjFhE1REldqMj7CzgCpY9jq+hege2331QIGjBn4KqcR1vIpUQ7WjVcY0xiqix
         EIhD8iYGBjys5gHymubLpo0911aPzgxnFQ4+nqOfi1Onrl/pSDJLx74awbjwH41E79fy
         i4ZTm2BYM1rdWI9GpgvAZ15ukXBcx0y+3Wd8mKAhyG8FcY2RI1KeOrB9BU6YVqexFfN/
         3cpuSvq2XZAt1+lD/P2m7SStP2Zhd36xC5PdUJvro7hMrd0HkPZ14W4id0VUSWAFikYW
         GEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705229747; x=1705834547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5su21lrElvoMrT51RPv9OkcSkDVz35FwFqaxlZOVWbQ=;
        b=IXCBbYuSaQPxkwdDK7vKVGF6PRCmqPpdXtmWcDQDRYZss6cyv4IhrusQj0J9MVzVd1
         xY62F3KgUpaXOhiI9f8RmQ9biGsXFnhJBbMk9lToY0kSC3rQ6mDIJK8+cp5Cl54ZvVNn
         +Fqipfjj/M0UX6UI2Aaxad62oaAEt4UslJ1415BLbUhYH3wLTSHTo1lLXoLfQHZ9uMzQ
         CQJKAdnFRjfiSZw6gt6XYcIGdg7mRfX3jQBxwN1mnnUUoeewzr246Fr1dkoUf+TVtwl2
         hxd8246PCjGVzCqkjj/8bzHzSKIGJ4msuPiy0JWI0M64yxcwDGNHLetvxoo7zO0dpzev
         Oe5Q==
X-Gm-Message-State: AOJu0YxD+fGGmhUMY7V7T/wdNspvNwccmiHKbuXUiwLRS56hbrm3Gg6b
	w+DIffBkoiJkjarH0LdtDZs=
X-Google-Smtp-Source: AGHT+IFs9diLCTJ1nBrxwBQXGsP8bvdXH3LQIBAmfSAPjpj7ka1Atnu/olzG2jnoWxV9ed533jKCkA==
X-Received: by 2002:a05:6808:2f0d:b0:3bd:5f35:58f6 with SMTP id gu13-20020a0568082f0d00b003bd5f3558f6mr6080166oib.37.1705229747410;
        Sun, 14 Jan 2024 02:55:47 -0800 (PST)
Received: from anfanite396-Predator-PH315-51.. ([202.43.120.125])
        by smtp.gmail.com with ESMTPSA id t3-20020a6564c3000000b005ce033f3b54sm5469576pgv.27.2024.01.14.02.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 02:55:46 -0800 (PST)
From: Dipam Turkar <dipamt1729@gmail.com>
To: mripard@kernel.org
Cc: maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	mairacanal@riseup.net,
	javierm@redhat.com,
	christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Dipam Turkar <dipamt1729@gmail.com>
Subject: [PATCH v4 1/1] drm/tests: Add KUnit tests for drm_mode_create_dvi_i_properties()
Date: Sun, 14 Jan 2024 16:23:38 +0530
Message-Id: <20240114105337.480807-1-dipamt1729@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce unit tests for the drm_mode_create_dvi_i_properties() function to ensure
the proper creation of DVI-I specific connector properties and success if called 
multiple times.

Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
---
 drivers/gpu/drm/tests/drm_connector_test.c | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index c66aa2dc8d9d..217c0988171e 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -4,6 +4,9 @@
  */
 
 #include <drm/drm_connector.h>
+#include <drm/drm_device.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_kunit_helpers.h>
 
 #include <kunit/test.h>
 
@@ -70,7 +73,62 @@ static struct kunit_suite drm_get_tv_mode_from_name_test_suite = {
 	.test_cases = drm_get_tv_mode_from_name_tests,
 };
 
+/*
+ * Test that drm_mode_create_dvi_i_properties() succeeds and
+ * DVI-I subconnector and select subconectors properties have
+ * been created.
+ */
+static void drm_test_mode_create_dvi_i_properties(struct kunit *test)
+{
+	struct drm_device *drm;
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*drm), 0, DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+
+	KUNIT_EXPECT_EQ(test, drm_mode_create_dvi_i_properties(drm), 0);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_select_subconnector_property);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_subconnector_property);
+}
+
+/*
+ * Test that drm_mode_create_dvi_i_properties() doesn't fail if called twice.
+ */
+static void drm_test_mode_create_dvi_i_properties_repeated(struct kunit *test)
+{
+	struct drm_device *drm;
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev, sizeof(*drm), 0, DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+
+	KUNIT_EXPECT_EQ(test, drm_mode_create_dvi_i_properties(drm), 0);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_select_subconnector_property);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_subconnector_property);
+
+	/* Expect the function to return 0 if called twice. */
+	KUNIT_EXPECT_EQ(test, drm_mode_create_dvi_i_properties(drm), 0);
+}
+
+static struct kunit_case drm_mode_create_dvi_i_properties_tests[] = {
+	KUNIT_CASE(drm_test_mode_create_dvi_i_properties),
+	KUNIT_CASE(drm_test_mode_create_dvi_i_properties_repeated),
+	{ }
+};
+
+static struct kunit_suite drm_mode_create_dvi_i_properties_test_suite = {
+	.name = "drm_mode_create_dvi_i_properties",
+	.test_cases = drm_mode_create_dvi_i_properties_tests,
+};
+
 kunit_test_suite(drm_get_tv_mode_from_name_test_suite);
+kunit_test_suite(drm_mode_create_dvi_i_properties_test_suite);
 
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
 MODULE_LICENSE("GPL");
-- 
2.34.1


