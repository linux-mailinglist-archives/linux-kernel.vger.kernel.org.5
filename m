Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71709762554
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjGYWBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjGYWBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:01:09 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A82E1FEC;
        Tue, 25 Jul 2023 15:01:06 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1bba254a7d4so650191fac.2;
        Tue, 25 Jul 2023 15:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690322465; x=1690927265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNrWzLvwqEWfm83K2uRioAjV1pOkPLb6ELuVS9z3syU=;
        b=h+XCLvqsjKeM7GRAO2yvRxh7nYDqyHfpp/xhltHZEyOy8xi3kh4p/43Kca21j94dN3
         JU8KtiHQXU4S4xjhu+I9+HYE/8vAyKznNDmTb6vbWUeRTF/Vixp8ulGmxFFBwZmHeJhs
         ObLpFFZoRkY1Fgfju5iYjyYTzZSZw4bYq7pa61HP8/1q5YpMXb3Cbarj9T7x0DJQIIek
         YctXQDYeVsUTwwxLGniQE1Hkw+gQzI1j1HWuGsk+DYB/rUMNzt6MjJLoeSn+InVoITnY
         QeiUrhezi3i79M66btXVMDqFtwBK00QXUI5qUSrxvUefTJDQcnZL6F7dmIQP3r3HuuZq
         xULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322465; x=1690927265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNrWzLvwqEWfm83K2uRioAjV1pOkPLb6ELuVS9z3syU=;
        b=TZ6gmXxHOEVbXBPNmyx78mDlIr1P6hKRtMW5dOw4n/pkW9Kil7CLz/TSaCZ5PJt1jx
         ShzaN2Z1B40gjKdjTzv2UUUvGg9kM0KCiExxzWVWrh7Ht3hsQdXz5XXMBiP/d4u8j4n6
         cPHJvlp9hPbb4ayZAfV1JCI8euHyMgrGFlp/nXIH1ximtsfeugUi0R9bfOi0kkR4VpEe
         LH2aTzmasBER1QjohYVL0QEdIMrR9vAphWn0QKgAEjZioSsFKo76tHQGo60Y8ls9h/CZ
         G0q4mFC9G28juy8nsGRz9bI/5TdcTgckM/OR9gvF/Yj5KFZYAWITcB7anFDjEk9OnwqI
         Nb0Q==
X-Gm-Message-State: ABy/qLaNcXlUYhMnmHVQJBm0ZivwY2w4V65EvKGbSUMxdr+Qn3mwYcAo
        GKDG7jloJQu0VZm6Gx3JHRo=
X-Google-Smtp-Source: APBJJlFBn5vUqnknyj718FC81NIV4HcjANhJsE9UmdaArbL635it94NRx9qBhd84aRQf57NOAGh68w==
X-Received: by 2002:a05:6870:f615:b0:1b0:5bf7:3bac with SMTP id ek21-20020a056870f61500b001b05bf73bacmr366061oab.37.1690322465502;
        Tue, 25 Jul 2023 15:01:05 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:871d:ebb3:c6e2:8ac3])
        by smtp.gmail.com with ESMTPSA id v40-20020a4a8c6b000000b0056688eea98csm5870026ooj.27.2023.07.25.15.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:01:04 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH 5/5] hp-bioscfg: Fix memory leaks in password_elements_from_package()
Date:   Tue, 25 Jul 2023 17:00:56 -0500
Message-Id: <20230725220056.25560-6-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725220056.25560-1-jorge.lopez2@hp.com>
References: <20230725220056.25560-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address memory leaks in hp_populate_password_elements_from_package()
and uninitialized variable errors.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 .../platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index 52e4d346b529..5e833ea0c5e3 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -227,7 +227,7 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 	int value_len;
 	int ret;
 	u32 size;
-	u32 int_value;
+	u32 int_value = 0;
 	int elem;
 	int reqs;
 	int eloc;
@@ -264,6 +264,7 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 		if (expected_password_types[eloc] != password_obj[elem].type) {
 			pr_err("Error expected type %d for elem %d, but got type %d instead\n",
 			       expected_password_types[eloc], elem, password_obj[elem].type);
+			kfree(str_value);
 			return -EIO;
 		}
 
@@ -318,6 +319,8 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 					sizeof(password_data->common.prerequisites[reqs]));
 
 				kfree(str_value);
+				str_value = NULL;
+
 			}
 			break;
 		case SECURITY_LEVEL:
@@ -356,6 +359,8 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 					str_value,
 					sizeof(password_data->encodings[pos_values]));
 				kfree(str_value);
+				str_value = NULL;
+
 			}
 			break;
 		case PSWD_IS_SET:
@@ -365,6 +370,9 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 			pr_warn("Invalid element: %d found in Password attribute or data may be malformed\n", elem);
 			break;
 		}
+
+		kfree(str_value);
+		str_value = NULL;
 	}
 
 exit_package:
-- 
2.34.1

