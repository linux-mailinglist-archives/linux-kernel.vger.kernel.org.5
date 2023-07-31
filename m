Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9245876A1F5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjGaUcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjGaUcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:32:15 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041D71FE4;
        Mon, 31 Jul 2023 13:31:45 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bc9efb5091so991272a34.1;
        Mon, 31 Jul 2023 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690835505; x=1691440305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6etgdLhlCvwrN3XxAkq8IgBOAz9g8chc4g8ku19/Um8=;
        b=lAOKnEYr51S+mk8Cn85+E8N3t8/zWUaA4tcAilXB3LQ0tKtlsv2eMub1UlsnUHuM3L
         jq9pdYcmxwZdjiuNWPgpDZDYphyc4Xf90Xj1kG+BweGOcwV56rjpp102t/8VLEuz/6B5
         5aFRbjhJSX1bQ00o2QYCqhDbEMTei/IeCLt3zTqbv+SRmNKrRjFyEynBcGuBKBK5jXWZ
         ANt8+rm/8mzYHabh5JMYySgLDHKIOHAXekGsjt0ApsOTtzt1kc8L5m7bqdnassNgHfOU
         ZVcNOYMNg82UnaCMM58jV2pWn/C47MFK6KDbKklqd3UzsOD15xOLPyvQNofTvMccIb7B
         WSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690835505; x=1691440305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6etgdLhlCvwrN3XxAkq8IgBOAz9g8chc4g8ku19/Um8=;
        b=HsEBOgwzDbTrqzW4SFeUvMTqYipYRk9h29bRADwHqyoK6Ede6FtmDZNkMdUU3Fbwlk
         bCGfEvEAEEV/RfSvHSuBYZq7ZxD5TKbMXJmGJTIVmvrAaPQJWpaXOjnUpPCKyFz2O0fw
         lc5l/JAP93hOjBpcOk+udUiNE9Sp6JHiIJlVE1+IU6+R9XImK+8h3WdKfQtGYJSDfp20
         HnGzRD//3e5VzsVYNvHLbyLdVekEqHM9rx9D+o96G6D1K/smxMecA08HlTZmsG4MSusP
         XptaWGN2RsmndnXPqBY2fvBYPbelcCZGu2YdQQtbMAdSf8aSc2Afhs1bP43giZAv1Gv1
         H3JQ==
X-Gm-Message-State: ABy/qLZq8NZQQySW+CIpkuvH+hnIS03ch5TLaT8kUMG4p21VYPzFaYBJ
        nx5H9nxjeDvjbcn4nICpVls=
X-Google-Smtp-Source: APBJJlFArQcIw8leDIvWHellOjfCxDxrNkOqjoe5lrrEZDh2X/twXbk7wXOWAdM0lullVdpngDGJ9w==
X-Received: by 2002:a05:6830:102:b0:6b9:cfc3:65d1 with SMTP id i2-20020a056830010200b006b9cfc365d1mr9518433otp.17.1690835505296;
        Mon, 31 Jul 2023 13:31:45 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:b620:ce9:47eb:26ab])
        by smtp.gmail.com with ESMTPSA id g8-20020a9d6208000000b006b9848f8aa7sm4498841otj.45.2023.07.31.13.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:31:45 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com, dan.carpenter@linaro.org
Subject: [PATCH 2/8] hp-bioscfg: Fix uninitialized variable errors
Date:   Mon, 31 Jul 2023 15:31:35 -0500
Message-Id: <20230731203141.30044-3-jorge.lopez2@hp.com>
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

Fix uninitialized variable errors.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c       | 2 +-
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c        | 2 +-
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c | 4 ++--
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c  | 2 +-
 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c     | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index 8e615ccfc9b5..7f77963cd7fa 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -129,7 +129,7 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 	char *str_value = NULL;
 	int value_len;
 	u32 size = 0;
-	u32 int_value;
+	u32 int_value = 0;
 	int elem = 0;
 	int reqs;
 	int pos_values;
diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
index 6db2c8ba02a9..97f88e0ef0cc 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
@@ -143,7 +143,7 @@ static int hp_populate_integer_elements_from_package(union acpi_object *integer_
 	char *str_value = NULL;
 	int value_len;
 	int ret;
-	u32 int_value;
+	u32 int_value = 0;
 	int elem;
 	int reqs;
 	int eloc;
diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index 739998682874..89e67db733eb 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -131,10 +131,10 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 							  int instance_id)
 {
 	char *str_value = NULL;
-	int value_len;
+	int value_len = 0;
 	int ret;
 	u32 size;
-	u32 int_value;
+	u32 int_value = 0;
 	int elem;
 	int reqs;
 	int eloc;
diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index 3f7b9fe857f1..5e833ea0c5e3 100644
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
diff --git a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
index c9e124af170e..e0ecdfca4def 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
@@ -133,7 +133,7 @@ static int hp_populate_string_elements_from_package(union acpi_object *string_ob
 	char *str_value = NULL;
 	int value_len;
 	int ret = 0;
-	u32 int_value;
+	u32 int_value = 0;
 	int elem;
 	int reqs;
 	int eloc;
-- 
2.34.1

