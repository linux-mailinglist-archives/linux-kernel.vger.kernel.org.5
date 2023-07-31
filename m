Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEA976A1F6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjGaUc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjGaUcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:32:16 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390211FE8;
        Mon, 31 Jul 2023 13:31:47 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b9ec15e014so4511775a34.0;
        Mon, 31 Jul 2023 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690835506; x=1691440306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4r7hlXWseUPS8Ohu6FpUF1/8b6j8vCToVBA5O29jC0=;
        b=ilsHLKr9sXxSN9KO6o8w+5ZAiMMnrUHolPSXvNFQZ4kHdhuiI8oLlVqrEY7z8H/vwW
         y3Ps6IJb3FQoWySEGwbMJQlSCYvs258SBRtYu6Cb6dkZmjXpQkPeVlnWsosLQKKt8rSS
         Phhcj/xSaycVl5DEh3I06JUH/n0pb1yv/9MEahgxDq21E0tkL/VruGpcU947/zctXplW
         pJb2SFwtU6/YQtveBZqtW2jlN+loZWIFOga7LP9hJ5kTjgTmMa88R7/zZHu2H7CVhFye
         uywxjqI3Acdsa5M394ls7uZkL1vLXNpunpGGOe3MRlN2G49m9DgSeL1vJY+JOFbZmjXT
         gYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690835506; x=1691440306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4r7hlXWseUPS8Ohu6FpUF1/8b6j8vCToVBA5O29jC0=;
        b=RPsklGatqp6f7eb1uYOHnct/5fAmqi0TDEVZ6l3grSghGF5u7d6VWkdotZ2ec5i6Jx
         +/lqXU1DDvgW2o+JLkIfiTIkx+b/ot3f5U9f+boOFMKFrV4nPheCIdPgBlIeBXML8f1c
         VjBRpNQDI89S8oWZoYkwXhiH1F8XlKf5xLwTgcUSaOoNnbAgoAOhcXimqAx2jklwyOoG
         LC4wmV5atquKefL9ly1ND2JZsgm5iV6K3fe2cHO13DMacOdqTQ+/iPY5gcM/64cEzl8d
         eNkKxRc7hZ+5cp+lZrN5wducuZ5jvVp5m3FgPL+WAk51Hy2CUyXanKxtS5rV8l3ZmlIH
         1Z1w==
X-Gm-Message-State: ABy/qLYLmtlXNVRQ6PNRsNuoDOR0EXOVhtgChs/8RXRDO7WRS+Y1QD82
        Bk0BqD8iUZy81bzQoQijCd0=
X-Google-Smtp-Source: APBJJlH+HQj0Mdp7320TlY6ZA7Iv7YdYb2t06bJ2204C073Npiwf0EEZ/FEKseBOu+iSsTuQHYvbrg==
X-Received: by 2002:a9d:6205:0:b0:6af:9b42:9794 with SMTP id g5-20020a9d6205000000b006af9b429794mr11087047otj.35.1690835506544;
        Mon, 31 Jul 2023 13:31:46 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:b620:ce9:47eb:26ab])
        by smtp.gmail.com with ESMTPSA id g8-20020a9d6208000000b006b9848f8aa7sm4498841otj.45.2023.07.31.13.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:31:46 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com, dan.carpenter@linaro.org
Subject: [PATCH 3/8] hp-bioscfg: Replace the word HACK from source code
Date:   Mon, 31 Jul 2023 15:31:36 -0500
Message-Id: <20230731203141.30044-4-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731203141.30044-1-jorge.lopez2@hp.com>
References: <20230731203141.30044-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the word 'HACK' with 'step' from source code

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c       | 4 ++--
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c        | 2 +-
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 4 ++--
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 4 ++--
 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c     | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index 7f77963cd7fa..50855ff48926 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -195,7 +195,7 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
 
 			/*
-			 * This HACK is needed to keep the expected
+			 * This step is needed to keep the expected
 			 * element list pointing to the right obj[elem].type
 			 * when the size is zero. PREREQUISITES
 			 * object is omitted by BIOS when the size is
@@ -243,7 +243,7 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 				pr_warn("Possible number values size value exceeded the maximum number of elements supported or data may be malformed\n");
 
 			/*
-			 * This HACK is needed to keep the expected
+			 * This step is needed to keep the expected
 			 * element list pointing to the right obj[elem].type
 			 * when the size is zero. POSSIBLE_VALUES
 			 * object is omitted by BIOS when the size is zero.
diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
index 97f88e0ef0cc..a45919616fa8 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
@@ -211,7 +211,7 @@ static int hp_populate_integer_elements_from_package(union acpi_object *integer_
 			if (integer_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE)
 				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
 			/*
-			 * This HACK is needed to keep the expected
+			 * This step is needed to keep the expected
 			 * element list pointing to the right obj[elem].type
 			 * when the size is zero. PREREQUISITES
 			 * object is omitted by BIOS when the size is
diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index 89e67db733eb..aba7d26b54b2 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -207,7 +207,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
 
 			/*
-			 * This HACK is needed to keep the expected
+			 * This step is needed to keep the expected
 			 * element list pointing to the right obj[elem].type
 			 * when the size is zero. PREREQUISITES
 			 * object is omitted by BIOS when the size is
@@ -245,7 +245,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 			if (int_value > MAX_ELEMENTS_SIZE)
 				pr_warn("Ordered List size value exceeded the maximum number of elements supported or data may be malformed\n");
 			/*
-			 * This HACK is needed to keep the expected
+			 * This step is needed to keep the expected
 			 * element list pointing to the right obj[elem].type
 			 * when the size is zero. ORD_LIST_ELEMENTS
 			 * object is omitted by BIOS when the size is
diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index 5e833ea0c5e3..3840380a5aee 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -293,7 +293,7 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 			if (int_value > MAX_PREREQUISITES_SIZE)
 				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
 
-			/* This HACK is needed to keep the expected
+			/* This step is needed to keep the expected
 			 * element list pointing to the right obj[elem].type
 			 * when the size is zero. PREREQUISITES
 			 * object is omitted by BIOS when the size is
@@ -337,7 +337,7 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 			if (int_value > MAX_ENCODINGS_SIZE)
 				pr_warn("Password Encoding size value exceeded the maximum number of elements supported or data may be malformed\n");
 
-			/* This HACK is needed to keep the expected
+			/* This step is needed to keep the expected
 			 * element list pointing to the right obj[elem].type
 			 * when the size is zero. PSWD_ENCODINGS
 			 * object is omitted by BIOS when the size is
diff --git a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
index e0ecdfca4def..378cedb502ba 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
@@ -203,7 +203,7 @@ static int hp_populate_string_elements_from_package(union acpi_object *string_ob
 			if (string_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE)
 				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
 			/*
-			 * This HACK is needed to keep the expected
+			 * This step is needed to keep the expected
 			 * element list pointing to the right obj[elem].type
 			 * when the size is zero. PREREQUISITES
 			 * object is omitted by BIOS when the size is
-- 
2.34.1

