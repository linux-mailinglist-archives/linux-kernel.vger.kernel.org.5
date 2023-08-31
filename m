Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C4378EFA4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242786AbjHaOgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239985AbjHaOgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:36:52 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE1C1BF;
        Thu, 31 Aug 2023 07:36:49 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79277cfc73bso32740039f.1;
        Thu, 31 Aug 2023 07:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693492609; x=1694097409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5R1GdPaeLcvWWf/P/bdBnkb1To4X1joTlLoTaa9dNMw=;
        b=Fp8ZAVbTJwfUxPao4o/YHV/16QlpLImTT+Sd6PrZLuhVM+Wp5GiH0WDDxyqQua49xA
         mZ5iCruERv+JXAnpD7LkraarXDp9psq4z5BjjNov4lz/f63lofA9ZAe2gGlnm316oGK6
         75EopaDQNreC1ymRALKkOpw2NRXw/MndMdS3OaFn6GmmkkHB0G5ICSf0VB80YxgKul5d
         9UecFrgvZBoYTzjbNhT99NBrc/QPm7kXNs87TkGdzF1F2rzXv2kiHmWwKe56ANFa27/Y
         vLXPOaN7o2+cmA1EbKXDi0hvU2PyVnKPm+SHe4G7PUGfO2T5fQkNdzEilwR0ASpGz8FA
         cV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693492609; x=1694097409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5R1GdPaeLcvWWf/P/bdBnkb1To4X1joTlLoTaa9dNMw=;
        b=S/Q2xGsH4atNXRY+3u4Cs69aM8E1hgoNxN4VjPC2V9M4pNgLK7XH4je2CZC/GBqHNI
         CioipfoFVJMYe7Uwy4gtAX1FL+AAaw4DRmxas4k6MCfnGZohKkYo9tuR0jyd0xdWIX8z
         UvEUKsMop1ysG8IyTtT1j7AIxeBU1J9QxkQq4bRbpoLyUUqKbxvjiIeWTVplmq6fRbnY
         VoBnCMuEbxXShwaKOco5/+0ywqBjz9xMfCUMrvGTACFMKviV57xsA2sdBa4iCF4LbM+k
         k/vyr9iDmbO5sPd0MKlLAZPGSBgodxVoaoZV1TSiForuGv2w6SqK5ZfZCMY6pfIMAxQr
         3g9w==
X-Gm-Message-State: AOJu0YznYTP+3X1ZFRuLEIPCaM8ASPlOT/8+yqvlPo7zHyO3GMZAhMKS
        QQJxlKgPsJOO0hvomiRwXPU=
X-Google-Smtp-Source: AGHT+IHc4441gdCO3ea8BbmsDiYb9wcircb59yZeHUBrb9SNWuN5jM+SsQvtxyiKZd/l8q9YDDUByw==
X-Received: by 2002:a05:6e02:10a:b0:34b:ae9b:d039 with SMTP id t10-20020a056e02010a00b0034bae9bd039mr5578936ilm.18.1693492608886;
        Thu, 31 Aug 2023 07:36:48 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id ee15-20020a056638292f00b0042b47e8869bsm434201jab.49.2023.08.31.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 07:36:48 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] scsi: target: Replace strlcpy with strscpy
Date:   Thu, 31 Aug 2023 14:36:38 +0000
Message-ID: <20230831143638.232596-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is safe here since return value of -errno
is used to check for truncation instead of sizeof(dest).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
v3:
 * Address readability comment.

v2:
 * Replace all instances of strlcpy in this file instead of just 1.
 * https://lore.kernel.org/all/20230830210724.4156575-1-azeemshaikh38@gmail.com/

v1:
 * https://lore.kernel.org/all/20230830200717.4129442-1-azeemshaikh38@gmail.com/

 drivers/target/target_core_configfs.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 936e5ff1b209..d5860c1c1f46 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -1392,16 +1392,16 @@ static ssize_t target_wwn_vendor_id_store(struct config_item *item,
 	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
 	unsigned char buf[INQUIRY_VENDOR_LEN + 2];
 	char *stripped = NULL;
-	size_t len;
+	ssize_t len;
 	ssize_t ret;

-	len = strlcpy(buf, page, sizeof(buf));
-	if (len < sizeof(buf)) {
+	len = strscpy(buf, page, sizeof(buf));
+	if (len > 0) {
 		/* Strip any newline added from userspace. */
 		stripped = strstrip(buf);
 		len = strlen(stripped);
 	}
-	if (len > INQUIRY_VENDOR_LEN) {
+	if (len < 0 || len > INQUIRY_VENDOR_LEN) {
 		pr_err("Emulated T10 Vendor Identification exceeds"
 			" INQUIRY_VENDOR_LEN: " __stringify(INQUIRY_VENDOR_LEN)
 			"\n");
@@ -1448,16 +1448,16 @@ static ssize_t target_wwn_product_id_store(struct config_item *item,
 	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
 	unsigned char buf[INQUIRY_MODEL_LEN + 2];
 	char *stripped = NULL;
-	size_t len;
+	ssize_t len;
 	ssize_t ret;

-	len = strlcpy(buf, page, sizeof(buf));
-	if (len < sizeof(buf)) {
+	len = strscpy(buf, page, sizeof(buf));
+	if (len > 0) {
 		/* Strip any newline added from userspace. */
 		stripped = strstrip(buf);
 		len = strlen(stripped);
 	}
-	if (len > INQUIRY_MODEL_LEN) {
+	if (len < 0 || len > INQUIRY_MODEL_LEN) {
 		pr_err("Emulated T10 Vendor exceeds INQUIRY_MODEL_LEN: "
 			 __stringify(INQUIRY_MODEL_LEN)
 			"\n");
@@ -1504,16 +1504,16 @@ static ssize_t target_wwn_revision_store(struct config_item *item,
 	/* +2 to allow for a trailing (stripped) '\n' and null-terminator */
 	unsigned char buf[INQUIRY_REVISION_LEN + 2];
 	char *stripped = NULL;
-	size_t len;
+	ssize_t len;
 	ssize_t ret;

-	len = strlcpy(buf, page, sizeof(buf));
-	if (len < sizeof(buf)) {
+	len = strscpy(buf, page, sizeof(buf));
+	if (len > 0) {
 		/* Strip any newline added from userspace. */
 		stripped = strstrip(buf);
 		len = strlen(stripped);
 	}
-	if (len > INQUIRY_REVISION_LEN) {
+	if (len < 0 || len > INQUIRY_REVISION_LEN) {
 		pr_err("Emulated T10 Revision exceeds INQUIRY_REVISION_LEN: "
 			 __stringify(INQUIRY_REVISION_LEN)
 			"\n");
--
2.42.0.283.g2d96d420d3-goog


