Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E0576A1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGaUcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGaUcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:32:17 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34011FEB;
        Mon, 31 Jul 2023 13:31:48 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1bb7e083783so3707548fac.2;
        Mon, 31 Jul 2023 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690835508; x=1691440308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORy/KirT4m+ce+uPY5vqyS0RMXRRbr7WlzIIEULMUow=;
        b=WYA8s/QPa85xHYmyaaGiwjLDzCAo4e0uyYvL/OeQt34wS9QzEoSRJuUourNruAhFik
         hiVENS3p/FRMXySvzt6QJ+4TC9YZ6oef3RkyHX4E9e1aNYHSy8heb7I/M7m2AzM9tQ5a
         F/cATPfYA3UeW83SNDgNd5mN9TKJACbvr3kCYZJJlISkuIo54GCcyobKIf+vdof85oP7
         9ezD//amjdVtY5+m7RR0f8spxSqdtPpmRaMZ51hL1ClPQvw/wastwQChIe9oiGz/NvxM
         fmSIhzQh/alYHw5NYy5uhuc/nvwlldd6+e0Bmc3rNyXfRZ06qSNgFF5JHeDl54gSBGEe
         2jXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690835508; x=1691440308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORy/KirT4m+ce+uPY5vqyS0RMXRRbr7WlzIIEULMUow=;
        b=WhZ4qESHqgXWCiVQtHphRFflvZ2SWTyDq+sIKglVn1F+C03Ng463sQnyJV4l9yRiTe
         6J4nxKIsyy3j2Ma8ePaQpz6Sss/edUGNwZqaLFMXrLUigoC9lVPn8F/BKlHyruqhhwTK
         oPw23vNu6ZV52WN+2L2iVlpE75rNkYbh9QbI1xTKm38dwKU6bVRGdkdTJpK7+k8OhE/E
         CPCzV7c24pQgBYg/kQtjvvrg5l0w5vrAvI+h/I/a9+DjTvp5hgHyiGzKW3/SOuF6B+/r
         dulWTJm2+Y1WscrNnRziYbahCphr6vJeUsNK5TykeWfnuUsL5vjTeo8Yu/JsifAe3bZg
         0mAw==
X-Gm-Message-State: ABy/qLbT6pz6YTfG84WHgI0AjdWkcTYHPwEuU8us8ETF/kPcRcC9XWf5
        pRlwRZ3zz/4LvY9wVckG63Q=
X-Google-Smtp-Source: APBJJlHXTILjlNjNxHIVxPcF7LxCfNItSbegA28vbBrEtBP+32azg5wRY3OQyB71B7fo9dSVpqPX3Q==
X-Received: by 2002:a05:6870:4394:b0:1b0:222f:9cda with SMTP id r20-20020a056870439400b001b0222f9cdamr12716459oah.0.1690835507769;
        Mon, 31 Jul 2023 13:31:47 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:b620:ce9:47eb:26ab])
        by smtp.gmail.com with ESMTPSA id g8-20020a9d6208000000b006b9848f8aa7sm4498841otj.45.2023.07.31.13.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:31:47 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com, dan.carpenter@linaro.org
Subject: [PATCH 4/8] hp-bioscfg: Change how prerequisites size is evaluated
Date:   Mon, 31 Jul 2023 15:31:37 -0500
Message-Id: <20230731203141.30044-5-jorge.lopez2@hp.com>
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

Update steps taken to evaluate prerequisites size value

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c       | 6 ++++--
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c        | 6 +++++-
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 6 ++++--
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 6 ++++--
 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c     | 6 ++++--
 5 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index 50855ff48926..89bb039a8a3c 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -190,9 +190,11 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 			enum_data->common.sequence = int_value;
 			break;
 		case PREREQUISITES_SIZE:
-			enum_data->common.prerequisites_size = int_value;
-			if (int_value > MAX_PREREQUISITES_SIZE)
+			if (int_value > MAX_PREREQUISITES_SIZE) {
 				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+				int_value = MAX_PREREQUISITES_SIZE;
+			}
+			enum_data->common.prerequisites_size = int_value;
 
 			/*
 			 * This step is needed to keep the expected
diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
index a45919616fa8..86b7ac63fec2 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
@@ -208,8 +208,12 @@ static int hp_populate_integer_elements_from_package(union acpi_object *integer_
 			integer_data->common.sequence = int_value;
 			break;
 		case PREREQUISITES_SIZE:
-			if (integer_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE)
+			if (int_value > MAX_PREREQUISITES_SIZE) {
 				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+				int_value = MAX_PREREQUISITES_SIZE;
+			}
+			integer_data->common.prerequisites_size = int_value;
+
 			/*
 			 * This step is needed to keep the expected
 			 * element list pointing to the right obj[elem].type
diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index aba7d26b54b2..71f588cbdf88 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -202,9 +202,11 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 			ordered_list_data->common.sequence = int_value;
 			break;
 		case PREREQUISITES_SIZE:
-			ordered_list_data->common.prerequisites_size = int_value;
-			if (int_value > MAX_PREREQUISITES_SIZE)
+			if (int_value > MAX_PREREQUISITES_SIZE) {
 				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+				int_value = MAX_PREREQUISITES_SIZE;
+			}
+			ordered_list_data->common.prerequisites_size = int_value;
 
 			/*
 			 * This step is needed to keep the expected
diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index 3840380a5aee..afb5190afc03 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -289,9 +289,11 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 			password_data->common.sequence = int_value;
 			break;
 		case PREREQUISITES_SIZE:
-			password_data->common.prerequisites_size = int_value;
-			if (int_value > MAX_PREREQUISITES_SIZE)
+			if (int_value > MAX_PREREQUISITES_SIZE) {
 				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+				int_value = MAX_PREREQUISITES_SIZE;
+			}
+			password_data->common.prerequisites_size = int_value;
 
 			/* This step is needed to keep the expected
 			 * element list pointing to the right obj[elem].type
diff --git a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
index 378cedb502ba..f0c20070094d 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
@@ -198,10 +198,12 @@ static int hp_populate_string_elements_from_package(union acpi_object *string_ob
 			string_data->common.sequence = int_value;
 			break;
 		case PREREQUISITES_SIZE:
+			if (int_value > MAX_PREREQUISITES_SIZE) {
+				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
+				int_value = MAX_PREREQUISITES_SIZE;
+			}
 			string_data->common.prerequisites_size = int_value;
 
-			if (string_data->common.prerequisites_size > MAX_PREREQUISITES_SIZE)
-				pr_warn("Prerequisites size value exceeded the maximum number of elements supported or data may be malformed\n");
 			/*
 			 * This step is needed to keep the expected
 			 * element list pointing to the right obj[elem].type
-- 
2.34.1

