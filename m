Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485AC7E8276
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345025AbjKJT2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbjKJT2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:28:14 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1682B787
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:03:39 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc37fb1310so16268495ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699614219; x=1700219019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AKw4O8MZEMOutKTAoJPOv7w9iVpbVz72yRMuKDaXQPE=;
        b=KJSxFMGcqiDQhgoftCJzrRYP+RV+Uz4ZN+LzuKjVzWwdJJ0MU6bD1bZVemVU1sKoYH
         6dW73HwV98boRBtp8bm9mQE0L+S8qecbzI10UmAIPflL9oE1FvGI5AogkkT8xjAo0/E9
         5W/dCUIkNHYL+6PSNI+TBOTmkozaJZDFUA7EWVqou1zZHCl2Shhs8Ts/r0b2ADAkKrRG
         oSfoZkYWg+guWDDTp8VTDqwBgLSOL/Jb5nFi3hrWJ4+FDK74la8IsjPt3+7HcU6ZE+I4
         FKMiZhT5aFIFelQRLMWx1mSET9wde8qxkS3aYOi+MWWAY3g1XEPbJF69g8M4ZdcqBBA7
         JsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699614219; x=1700219019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKw4O8MZEMOutKTAoJPOv7w9iVpbVz72yRMuKDaXQPE=;
        b=nzbKd8UuLDyGDvsvR2+75SORVCDIDwR9G/DPX7b3KJy86Caz9iZMkhD9cIsEIaaAP+
         vrYjyPB4Q9wS9Z6PYh1eXn5xt7Dg0eP4Fkf27RDeAUeKBjbJZs6aPpjmAvQSQeNSUkZI
         h7Dc4BMW0k30boLLISfK6bRZ+XqYm3YWR/zZFoOuL1pO2yHGiNM9G9VF+kJ8sFijYoy3
         AlSh1Zm9Khl/nYlG2PD39hLQ/l+2wNds+3Do4dCPNOtzxeQm27MBtJdlHhs05lqoHkDe
         EDuckKePG9OtLLH6lEIJPM9jsEB4K3S9jzCtsPyBkGjuLcZu76DmT9/qgA2bw71Zah8U
         jNrg==
X-Gm-Message-State: AOJu0YyfYB/ylGjH8YHIMZQU/XmSIBXKzF2e94ZSFlge4SYrMAXz/1iX
        Fs6q2gbrS62ugY/IGBd0ZfM=
X-Google-Smtp-Source: AGHT+IFHwT2sbY2VJnvXIZ+EMaEwIg99+ncPmI/ey7ABQ1jF2vodiKtBR+L5R61wPWZTLgb7f/tZww==
X-Received: by 2002:a17:903:11d0:b0:1cc:50ad:58 with SMTP id q16-20020a17090311d000b001cc50ad0058mr7979575plh.42.1699614218952;
        Fri, 10 Nov 2023 03:03:38 -0800 (PST)
Received: from anfanite396-Predator-PH315-51.gateway.iitmandi.ac.in ([14.139.34.101])
        by smtp.gmail.com with ESMTPSA id iy18-20020a170903131200b001c5eb2c4d8csm5097631plb.160.2023.11.10.03.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 03:03:38 -0800 (PST)
From:   Dipam Turkar <dipamt1729@gmail.com>
To:     maarten.lankhorst@linux.intel.com
Cc:     mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, mairacanal@riseup.net, javierm@redhat.com,
        arthurgrillo@riseup.net, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Dipam Turkar <dipamt1729@gmail.com>
Subject: [PATCH] drm/tests: Add KUnit tests for drm_mode_create_dvi_i_properties()
Date:   Fri, 10 Nov 2023 16:33:23 +0530
Message-Id: <20231110110323.381215-1-dipamt1729@gmail.com>
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

