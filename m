Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDDF7E82DD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345615AbjKJTh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbjKJThl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:37:41 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFA06EAD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:25:33 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6ce2c71c61fso1308208a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699644332; x=1700249132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9WuF0Pi5V569GCKj27JB/b2x9SROneMhMi2aagE8fG0=;
        b=jhdjAkJvwPa+l8aSkd/O7mgTXDzVZWEXePDqi1xDqtHiWwlwjpxtjs0OBR6N+ZOZWG
         xN2B1yCaaPdSyhP8QdWBJyV+1HVShCcGQAGzH42EbKMRJv8Okhcv0ujKfheuZqm895jO
         Tx4jtzLDvJuQzmad3aEHBJgaDZbsNdsTdR+xSNKteL4wJOJ9TzBEgbJQ+gADf3KnRdPX
         LdLkQ+AWpLT+sMz08GowTnsGGzFdjr/Ws2cZwvKJt0VK4pDZZEUsd4WFlfmuc8pBJrkT
         dg8U1Oj1RfLeKdtxaN/yhKEs4p3yATqLpHtefr43zipgnINe7/o1Xcx7f60Ajn40N9Y9
         urdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699644332; x=1700249132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9WuF0Pi5V569GCKj27JB/b2x9SROneMhMi2aagE8fG0=;
        b=jcbI3KG8Tlph0n8mnhTTpJM2UgbPjCjoSnE8Boejg85lp51S+O48FkKfgrjRxgHLQj
         L/ku0bVwzYVgmojl6QMMoo7VIXlMsFpEWS2GCRTbyOQ1dNJUY3IeV+jo/qBoYa/3i3X8
         SMJucaBgjC84yHk6Q2nYd1WmLAu3MeijDHpXCIm+a/qr5NFKDfv0ZJsvSaRZYl6cxPW2
         GgsmPdjXAlRwSigQJMSBXYC2cNOe37EpMlmOIxBsvaGII5SBwODEjZZAh/oenefkPcIh
         Bo5jEIduQsz1x/4BAfrJsC5P6/9tXkX2XOXSX9HhjSmJtLbQ5BtVLmILPoAr+9z5WHon
         KuSg==
X-Gm-Message-State: AOJu0YwWvh/MXZgfhcDYOC9fdfODaFT9XRZJ32gBUtqNqmXf1hmZgc3Z
        SkEKWkSs/vTaObM9NplgyjY=
X-Google-Smtp-Source: AGHT+IEo1//wDVWt/tm1wE749UqnbecpRb3xBJK4fg+h8xqM6wjIx3xSoS40xzkNWv62fUOim9iKYQ==
X-Received: by 2002:a05:6830:3492:b0:6b8:dc53:9efd with SMTP id c18-20020a056830349200b006b8dc539efdmr83527otu.3.1699644332401;
        Fri, 10 Nov 2023 11:25:32 -0800 (PST)
Received: from anfanite396-Predator-PH315-51.gateway.iitmandi.ac.in ([14.139.34.101])
        by smtp.gmail.com with ESMTPSA id 71-20020a63004a000000b0057412d84d25sm32493pga.4.2023.11.10.11.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 11:25:32 -0800 (PST)
From:   Dipam Turkar <dipamt1729@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, mairacanal@riseup.net, javierm@redhat.com,
        arthurgrillo@riseup.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Dipam Turkar <dipamt1729@gmail.com>
Subject: [PATCH v2] drm/tests: Add KUnit tests for drm_mode_create_dvi_i_properties()
Date:   Sat, 11 Nov 2023 00:54:53 +0530
Message-Id: <20231110192452.734925-1-dipamt1729@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce unit tests for the drm_mode_create_dvi_i_properties() function to ensure
the proper creation of DVI-I specific connector properties.

Signed-off-by: Dipam Turkar <dipamt1729@gmail.com>
---
 drivers/gpu/drm/tests/drm_connector_test.c | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm/tests/drm_connector_test.c
index c66aa2dc8d9d..9ac1fd32c579 100644
--- a/drivers/gpu/drm/tests/drm_connector_test.c
+++ b/drivers/gpu/drm/tests/drm_connector_test.c
@@ -4,6 +4,9 @@
  */
 
 #include <drm/drm_connector.h>
+#include <drm/drm_device.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_kunit_helpers.h>
 
 #include <kunit/test.h>
 
@@ -58,6 +61,30 @@ static void drm_test_get_tv_mode_from_name_truncated(struct kunit *test)
 	KUNIT_EXPECT_LT(test, ret, 0);
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
+
+	// Expect the function to return 0 if called twice.
+	KUNIT_EXPECT_EQ(test, drm_mode_create_dvi_i_properties(drm), 0);
+}
+
 static struct kunit_case drm_get_tv_mode_from_name_tests[] = {
 	KUNIT_CASE_PARAM(drm_test_get_tv_mode_from_name_valid,
 			 drm_get_tv_mode_from_name_valid_gen_params),
@@ -70,7 +97,18 @@ static struct kunit_suite drm_get_tv_mode_from_name_test_suite = {
 	.test_cases = drm_get_tv_mode_from_name_tests,
 };
 
+static struct kunit_case drm_connector_tests[] = {
+	KUNIT_CASE(drm_test_mode_create_dvi_i_properties),
+	{ }
+};
+
+static struct kunit_suite drm_connector_test_suite = {
+	.name = "drm_connector",
+	.test_cases = drm_connector_tests,
+};
+
 kunit_test_suite(drm_get_tv_mode_from_name_test_suite);
+kunit_test_suite(drm_connector_test_suite);
 
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
 MODULE_LICENSE("GPL");
-- 
2.34.1

