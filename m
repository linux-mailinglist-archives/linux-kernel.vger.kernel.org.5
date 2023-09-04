Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1057914F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352671AbjIDJpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjIDJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:45:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC851A7;
        Mon,  4 Sep 2023 02:45:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-402d0eda361so4173475e9.0;
        Mon, 04 Sep 2023 02:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693820715; x=1694425515; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yOSRr7K35Hc+UAZpcN45/qFAWoXviUeo887gKFn0P2E=;
        b=ABwe8/0dsS3LHCn0Gd786d90ZoVpAUnaxzgP2Ck6IdDI+fVkxI9TaWonUOGPmBLu0Q
         jTCFdWIOrWRlbN1/3oj8LnKzqUGjX4jV6kTHbBXIfBiAJa9iUeaZf8nxxA+dzhJt0fV4
         cVXlhFYmb+WXva648CF9krgl9WFA063+Tx/mLdzo6kfKyS+ZAnz3ARtTDJpuw4HCmCyL
         YWO6TnmDNzIlKljvCWe7PZIBYjIXkeCeABc1EerWZ1fvTkkoGsVFg/Z9/xADThRd2TyA
         +jPruW4MQio7cTmveXYHkIGT4vUL3SzS8FKMjGSd8CEMfn9gAMPyQr+flDxwCf6BL+gN
         91CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693820715; x=1694425515;
        h=reply-to:references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOSRr7K35Hc+UAZpcN45/qFAWoXviUeo887gKFn0P2E=;
        b=ZNLPrDwjNbTrHSw0/kTLAVWuwtRM0kJdAlVUqF2j2yZt07wOORSy2Fv1baQJnzBYPM
         rk5sN455hu2NBqVYSlHRALKGDEGkBsa1y4VqHXIQLIrm1Kg3V6ooWqJpJdYQTboOAvQn
         SinNdhXQ9h6pj/O8g+jG7/U31AtWP2BPolsboQQFte98DXYluvEQA5ze0kirzhK+CCcV
         Yh7UTn/Q3Z1DISNiUoP3z2jp4tLiIIBo/EyJvlryhAKcNbqauHpmpGPB+/mRW6Eccxn4
         bgjrLOXVDz/EbfdrpGwb/VrMYjvhcTPTngowMBfAUpmhpJ6k12AR/8pDsFCgCwc7xdT3
         gLZA==
X-Gm-Message-State: AOJu0YzndHzXEX1ayRUgnSaaBwEFsJ9A84tZMcJY186ew1OnZ3nei5Xz
        bDVqQjBjoVN6oxWbSxnxO3QTQ89iNDYuHIZV
X-Google-Smtp-Source: AGHT+IFIg+83crZXdfCR0PXn/7kTFbHg0Bddl5pIkyUX3GX9dWmDRPiqWBqqes3N/VKAsMLTvukCZQ==
X-Received: by 2002:a05:600c:2488:b0:3fe:2b8c:9f0b with SMTP id 8-20020a05600c248800b003fe2b8c9f0bmr7548710wms.23.1693820714650;
        Mon, 04 Sep 2023 02:45:14 -0700 (PDT)
Received: from localhost.localdomain ([113.203.244.138])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c219000b003fe2a40d287sm13528312wme.1.2023.09.04.02.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 02:45:14 -0700 (PDT)
From:   fasih0001@gmail.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fasih <fasih0001@gmail.com>
Subject: [PATCH] usb: uvc: Fix macro in uvc_driver.c for complex values
Date:   Mon,  4 Sep 2023 14:45:11 +0500
Message-Id: <20230904094511.11880-1-fasih0001@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230903205906.GD13794@pendragon.ideasonboard.com>
References: <20230903205906.GD13794@pendragon.ideasonboard.com>
Reply-To: laurent.pinchart@ideasonboard.com
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fasih <fasih0001@gmail.com>

The macro UVC_INFO_QUIRK(q) in uvc_driver.c initializes a structure
using a compound literal, and the complex value within the macro was
not properly enclosed in parentheses. This could lead to operator
precedence issues and reduced code clarity.

This commit adds an extra set of parentheses to the macro definition
to ensure correct evaluation and adherence to best practices. This
change also improves code readability and portability.

Signed-off-by: Syed Muhammad Fasih Ul Hassan <fasih0001@gmail.com>
Signed-off-by: Fasih <fasih0001@gmail.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 08fcd2ffa727..63999f1c8d55 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2417,9 +2417,9 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
 	.quirks = UVC_QUIRK_FORCE_Y8,
 };
 
-#define UVC_INFO_QUIRK(q) (kernel_ulong_t)&(struct uvc_device_info){.quirks = q}
-#define UVC_INFO_META(m) (kernel_ulong_t)&(struct uvc_device_info) \
-	{.meta_format = m}
+#define UVC_INFO_QUIRK(q) ((kernel_ulong_t)&(struct uvc_device_info){.quirks = q})
+#define UVC_INFO_META(m) ((kernel_ulong_t)&(struct uvc_device_info) \
+	{.meta_format = m})
 
 /*
  * The Logitech cameras listed below have their interface class set to
-- 
2.17.1

