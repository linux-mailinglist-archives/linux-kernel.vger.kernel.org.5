Return-Path: <linux-kernel+bounces-18586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF4B825FC1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA27F1C2120F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E3279FE;
	Sat,  6 Jan 2024 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHwUCxXd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134B79F1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-28be52a85b9so265819a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 06:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704549810; x=1705154610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS8AIREFz1XWmTAMUhkfxle7maAtwV7jGirdI2uRztQ=;
        b=PHwUCxXdEU7bwoIf8mjeALzg82qdYIYNc8Goj6mH2SqLSf6dzkK7ZU9bCy/h/5LRjd
         meH7WekP+VzorUVg5v+00KKEozUFSdYVgIVXiGCipvXe7YugMHaSFQufyGtDMrjveV73
         FsDs90p+2hzm4ywxZ8wmymO2DMBy3sJN8hVrX3r0F7ZUyd9/LAnpS2SXz72owtT375sv
         ZWUTu+eYUvYVYNfUYL6ONf2JysLBAqFa1yKGb3p6hc2xoTOTSrXr5J0fMyf4XCJb4a0j
         XnXQZQl6a5NECvHfNn4ri2JlpqltQDYxTv9xxrA0ty2t4P8PYpQn6NQtIs0x5R6MRHdv
         7r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704549810; x=1705154610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NS8AIREFz1XWmTAMUhkfxle7maAtwV7jGirdI2uRztQ=;
        b=OHNF9I4yFzkqmAb+DHrbGiTnHQfaTsb6vsUcetezVs9pmVZLJPQtWBXmw8b1TfRGil
         eqpS/A1glW//e60bga+jSw11AcgbbK7OTmMwdP9SttzM4x18j+gN3bkDw/9zT9riH820
         2OJe3YPAu346URWCmoMQS80v+D9e6n4WOLfCqvXSVvP11atL2aXplnu56Cphz9SAb4D2
         oLQ1EYgrilJQTamzW/QX1Hdq5qNM8P2l8iQMfvYe6ed0ZH3uMsmqGmkFK8X0RwepiGAj
         /KZAqmAPm4UZRoHamd5pRv9bJkvpZrAo92CXv2/N6o/ZW8xRWO95gJh8X6zmcBo38wRp
         koCQ==
X-Gm-Message-State: AOJu0YztiV1noiXgnJcggL/KSUUlzgjeOV/aYaRWj/BSgL0AfYtJ7dcK
	f/wNtC9pU9zMf+efjjgH1T8=
X-Google-Smtp-Source: AGHT+IG4c74Zx8hbqiQVId29IZQbC6NTlq/Z51ofPKz6crwPf/GIf/VzHhswWMqbUus7RJOZFgdIpA==
X-Received: by 2002:a17:902:7004:b0:1d4:2df6:95c0 with SMTP id y4-20020a170902700400b001d42df695c0mr382327plk.114.1704549810223;
        Sat, 06 Jan 2024 06:03:30 -0800 (PST)
Received: from anfanite396-Predator-PH315-51.. ([202.43.120.140])
        by smtp.gmail.com with ESMTPSA id bj12-20020a170902850c00b001d058ad8770sm3071576plb.306.2024.01.06.06.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 06:03:29 -0800 (PST)
From: Dipam Turkar <dipamt1729@gmail.com>
To: maarten.lankhorst@linux.intel.com
Cc: mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Dipam Turkar <dipamt1729@gmail.com>
Subject: [PATCH v3 1/1] drm/tests: Add KUnit tests for drm_mode_create_dvi_i_properties()
Date: Sat,  6 Jan 2024 19:31:18 +0530
Message-Id: <20240106140117.9777-1-dipamt1729@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CALHmwspWRT=pj+mPDhf8YTwSpTz6LiNjq18wbUk7wCW3ijKU4A@mail.gmail.com>
References: <CALHmwspWRT=pj+mPDhf8YTwSpTz6LiNjq18wbUk7wCW3ijKU4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 drivers/gpu/drm/tests/drm_connector_test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index c66aa2dc8d9d..aad63839b5e5 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -4,6 +4,9 @@
  */
 
 #include <drm/drm_connector.h>
+#include <drm/drm_device.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_kunit_helpers.h>
 
 #include <kunit/test.h>
 
@@ -58,10 +61,27 @@ static void drm_test_get_tv_mode_from_name_truncated(struct kunit *test)
 	KUNIT_EXPECT_LT(test, ret, 0);
 };
 
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
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_select_subconnector_property);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm->mode_config.dvi_i_subconnector_property);
+}
+
 static struct kunit_case drm_get_tv_mode_from_name_tests[] = {
 	KUNIT_CASE_PARAM(drm_test_get_tv_mode_from_name_valid,
 			 drm_get_tv_mode_from_name_valid_gen_params),
 	KUNIT_CASE(drm_test_get_tv_mode_from_name_truncated),
+	KUNIT_CASE(drm_test_mode_create_dvi_i_properties),
 	{ }
 };
 
-- 
2.34.1


