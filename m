Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D86E78E132
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbjH3VKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240443AbjH3VK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:10:29 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B263DE76;
        Wed, 30 Aug 2023 14:09:49 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-34ccedcc584so321245ab.0;
        Wed, 30 Aug 2023 14:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693429661; x=1694034461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ofr1jYcnUdNDcThGOeqc7mheVMPv4mVGcLb0lf2Uv9c=;
        b=Zu39t0/OcKtwC+SPf80xR1v8iapM+UGPebWTs+7k+rG2PCfBWf2bC/wy1QUTM5yDib
         rdCb1ulPkm9vROGwEpxhExgNYSCda8tgPyTNnnVUYXnQMBhtBpflnsTzoQ4vUGkwfa1r
         H0Tf0X1mFodej2e0vHA1AKLSqb2YZ++InHVK8YrnxMEBadCUO+27M75CvkpJhX7I+bqK
         qxGFQTIZgb5yn2l5lSprUVVrjl3aVpWC1VrACTOcxiXFrlFW/Vg/ZNQmUNLrYe4HPe+6
         ae2teLSBNNkx3uTRNZO3ggAkZD1WHynFmue+4FTjKsVIBISGooQlSTLDDH06JLtJJy4V
         azIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693429661; x=1694034461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofr1jYcnUdNDcThGOeqc7mheVMPv4mVGcLb0lf2Uv9c=;
        b=EbiE+SifZNrMYmVmjt2/QyU3C4TQnmsYOTA+fk2sAZZKlUfEG6Z50O3+hU8dcGaEOc
         MMw/a9HRAIneS3w2lO64AXiDbIllIenqRYsMFE7gxwXvCFDcQ1sYOhpW0qC7i4bV/cYE
         zbxqpesww+YzcAfRCdYJgTbfjrmo+DoGgfjnjd5abrkFklJbQ5US2xLRppe/3X1mpQEe
         eq84kPLbhH6LbTp2oklP5T+Au/YZTPQctFGtH9oKnFAxbosKp60tDg5Gv+5zhEr8V3X5
         NioxUUpEhiPzf4HM13I/fe37xxMckJX8Hbbc378URkYE/nLmz55J+EFgYuHGNmHl/06X
         fgeg==
X-Gm-Message-State: AOJu0YzPkMjmuLpJMjFx/8ByV2LmiEf+YQyWZWM9ZDIdeDBUnREt/CgF
        aWj1qfZwLrCAMKpGmjEVWS7boSQz1mj3lJfb
X-Google-Smtp-Source: AGHT+IFDTEJlxTlaQiAOqsKetI2wXncxQtVs9v69CWR7izlVYs1P7AgO0mxLpg+EsJ1yRk/Nc8Oydg==
X-Received: by 2002:a05:6e02:17c9:b0:349:345b:6595 with SMTP id z9-20020a056e0217c900b00349345b6595mr611217ilu.11.1693429661168;
        Wed, 30 Aug 2023 14:07:41 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id ee16-20020a056638293000b0042b227eb1ddsm3958497jab.55.2023.08.30.14.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:07:40 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: target: Replace strlcpy with strscpy
Date:   Wed, 30 Aug 2023 21:07:24 +0000
Message-ID: <20230830210724.4156575-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
v2:
 * Replace all instances of strlcpy in this file instead of just 1.

v1:
 * https://lore.kernel.org/all/20230830200717.4129442-1-azeemshaikh38@gmail.com/

 drivers/target/target_core_configfs.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index 936e5ff1b209..10a22a428267 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -1392,16 +1392,15 @@ static ssize_t target_wwn_vendor_id_store(struct config_item *item,
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
-		len = strlen(stripped);
 	}
-	if (len > INQUIRY_VENDOR_LEN) {
+	if (len < 0 || strlen(stripped) > INQUIRY_VENDOR_LEN) {
 		pr_err("Emulated T10 Vendor Identification exceeds"
 			" INQUIRY_VENDOR_LEN: " __stringify(INQUIRY_VENDOR_LEN)
 			"\n");
@@ -1448,16 +1447,15 @@ static ssize_t target_wwn_product_id_store(struct config_item *item,
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
-		len = strlen(stripped);
 	}
-	if (len > INQUIRY_MODEL_LEN) {
+	if (len < 0 || strlen(stripped) > INQUIRY_MODEL_LEN) {
 		pr_err("Emulated T10 Vendor exceeds INQUIRY_MODEL_LEN: "
 			 __stringify(INQUIRY_MODEL_LEN)
 			"\n");
@@ -1504,16 +1502,15 @@ static ssize_t target_wwn_revision_store(struct config_item *item,
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
-		len = strlen(stripped);
 	}
-	if (len > INQUIRY_REVISION_LEN) {
+	if (len < 0 || strlen(stripped) > INQUIRY_REVISION_LEN) {
 		pr_err("Emulated T10 Revision exceeds INQUIRY_REVISION_LEN: "
 			 __stringify(INQUIRY_REVISION_LEN)
 			"\n");
--
2.42.0.283.g2d96d420d3-goog


