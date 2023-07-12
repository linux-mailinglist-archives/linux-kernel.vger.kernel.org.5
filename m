Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283907512BA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjGLVnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGLVnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:43:15 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA371BEF;
        Wed, 12 Jul 2023 14:43:14 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-785cbc5bfd2so344368339f.2;
        Wed, 12 Jul 2023 14:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689198194; x=1691790194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qRm3jgos2zmvvlEHIgv8GCkkPRupEusUu4b46dYKwrg=;
        b=H83t0gRvoc47tAmQYeQxdd5H/bNzm6YLCmV/TIcLz4DdzRYKTSX50Mn58YkWAQvUzf
         rh7lDSWUFgELfLP/8fFYMOJ73WTPWDQgX1NW7anpi/eR0TrhJiDP808UQ6ONTKe9ZwX5
         g85cYeUuTIsCqz08/6215paIiNnMZONkpdAUqd0c8ddCKOuzk8gfgr7mILTlhXZAvdV/
         jPovjbsCTYQV2jaCUFME+QpN+lDH0jOjbsfmA2CK+w2zlo31IuPMmNg5POvQ2IZ1PN/N
         8zY0AkwKFP+CJAg4LUIITkwunSMi7k3fwzJWwo3V6BsEZIDl0d1hZdnPSP3In77faFEG
         b75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689198194; x=1691790194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRm3jgos2zmvvlEHIgv8GCkkPRupEusUu4b46dYKwrg=;
        b=RkhU+S2kWb3AidbGSkNB+6/0LWo2XXkY+MqOd4D7COrS9EgDGW3BUrPngJMQhnJfK8
         njJb2/dVkFtXSmWO0Dsi6MR1nM9xiuyA7L5wsbT6UMbuSxybmvhnY7xGxMoRFUEMoEG6
         teWgsvWSEi3pQxG4qxCPio8SDnZBdVwIAayOCKjwoRbHRN6sJC/bZLa4HMUOwH+Uhn69
         teNjqBZLmN0T0EbyuGTK2ziCmNyY7urPgral2SOmGiY/qqqAXUxsbzahek3dGE31ejVM
         nUJeKfQkbn2TJaRp1O6POOiPn/eC4qylh/6fS727c2Z91q9qQfDxZLG4JPEinLnKVb2V
         ZK2A==
X-Gm-Message-State: ABy/qLYTejVNuZsrVBmIFTD3r+rOLnMghGyCshYALsU9JpNKD9tqmPza
        lSh34a0Q+zHhRUcqlaHCueI=
X-Google-Smtp-Source: APBJJlGeEFuMaM0W/FQocan8VJSxWKEFeS2eB3uQiJVXfzJJbo7NZK6n5vQ/OdQmNpSvWeYJiXJu6w==
X-Received: by 2002:a6b:7012:0:b0:786:cc36:360c with SMTP id l18-20020a6b7012000000b00786cc36360cmr34008ioc.8.1689198193917;
        Wed, 12 Jul 2023 14:43:13 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id o27-20020a056602125b00b00777b94e8efasm1592778iou.18.2023.07.12.14.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 14:43:13 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Subject: [PATCH v2] hwmon: (pmbus/max20730) Remove strlcpy occurences
Date:   Wed, 12 Jul 2023 21:43:07 +0000
Message-ID: <20230712214307.2424810-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
strlcpy() here with direct assignment.

strlcpy in this file is used to copy fixed-length strings which can be
completely avoided by direct assignment and is safe to do so. strlen()
is used to return the length of @tbuf.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
v2:
 * Includes driver name in commit header.
 * Removes unrelated change tbuf{ 0 } -> tbuf{}.
 * Fixes bug where @tbuf was being passed instead of @result.

v1:
 * https://lore.kernel.org/all/20230712144429.2845940-1-azeemshaikh38@gmail.com/

 drivers/hwmon/pmbus/max20730.c |   64 +++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
index 7bcf27995033..1de34da177c9 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -114,6 +114,7 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
 	const struct pmbus_driver_info *info;
 	const struct max20730_data *data;
 	char tbuf[DEBUG_FS_DATA_MAX] = { 0 };
+	char *result = tbuf;
 	u16 val;

 	info = pmbus_get_driver_info(psu->client);
@@ -148,13 +149,13 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
 			>> MAX20730_MFR_DEVSET1_TSTAT_BIT_POS;

 		if (val == 0)
-			len = strlcpy(tbuf, "2000\n", DEBUG_FS_DATA_MAX);
+			result = "2000\n";
 		else if (val == 1)
-			len = strlcpy(tbuf, "125\n", DEBUG_FS_DATA_MAX);
+			result = "125\n";
 		else if (val == 2)
-			len = strlcpy(tbuf, "62.5\n", DEBUG_FS_DATA_MAX);
+			result = "62.5\n";
 		else
-			len = strlcpy(tbuf, "32\n", DEBUG_FS_DATA_MAX);
+			result = "32\n";
 		break;
 	case MAX20730_DEBUGFS_INTERNAL_GAIN:
 		val = (data->mfr_devset1 & MAX20730_MFR_DEVSET1_RGAIN_MASK)
@@ -163,35 +164,35 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
 		if (data->id == max20734) {
 			/* AN6209 */
 			if (val == 0)
-				len = strlcpy(tbuf, "0.8\n", DEBUG_FS_DATA_MAX);
+				result = "0.8\n";
 			else if (val == 1)
-				len = strlcpy(tbuf, "3.2\n", DEBUG_FS_DATA_MAX);
+				result = "3.2\n";
 			else if (val == 2)
-				len = strlcpy(tbuf, "1.6\n", DEBUG_FS_DATA_MAX);
+				result = "1.6\n";
 			else
-				len = strlcpy(tbuf, "6.4\n", DEBUG_FS_DATA_MAX);
+				result = "6.4\n";
 		} else if (data->id == max20730 || data->id == max20710) {
 			/* AN6042 or AN6140 */
 			if (val == 0)
-				len = strlcpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
+				result = "0.9\n";
 			else if (val == 1)
-				len = strlcpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
+				result = "3.6\n";
 			else if (val == 2)
-				len = strlcpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
+				result = "1.8\n";
 			else
-				len = strlcpy(tbuf, "7.2\n", DEBUG_FS_DATA_MAX);
+				result = "7.2\n";
 		} else if (data->id == max20743) {
 			/* AN6042 */
 			if (val == 0)
-				len = strlcpy(tbuf, "0.45\n", DEBUG_FS_DATA_MAX);
+				result = "0.45\n";
 			else if (val == 1)
-				len = strlcpy(tbuf, "1.8\n", DEBUG_FS_DATA_MAX);
+				result = "1.8\n";
 			else if (val == 2)
-				len = strlcpy(tbuf, "0.9\n", DEBUG_FS_DATA_MAX);
+				result = "0.9\n";
 			else
-				len = strlcpy(tbuf, "3.6\n", DEBUG_FS_DATA_MAX);
+				result = "3.6\n";
 		} else {
-			len = strlcpy(tbuf, "Not supported\n", DEBUG_FS_DATA_MAX);
+			result = "Not supported\n";
 		}
 		break;
 	case MAX20730_DEBUGFS_BOOT_VOLTAGE:
@@ -199,26 +200,26 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
 			>> MAX20730_MFR_DEVSET1_VBOOT_BIT_POS;

 		if (val == 0)
-			len = strlcpy(tbuf, "0.6484\n", DEBUG_FS_DATA_MAX);
+			result = "0.6484\n";
 		else if (val == 1)
-			len = strlcpy(tbuf, "0.8984\n", DEBUG_FS_DATA_MAX);
+			result = "0.8984\n";
 		else if (val == 2)
-			len = strlcpy(tbuf, "1.0\n", DEBUG_FS_DATA_MAX);
+			result = "1.0\n";
 		else
-			len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
+			result = "Invalid\n";
 		break;
 	case MAX20730_DEBUGFS_OUT_V_RAMP_RATE:
 		val = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_VRATE)
 			>> MAX20730_MFR_DEVSET2_VRATE_BIT_POS;

 		if (val == 0)
-			len = strlcpy(tbuf, "4\n", DEBUG_FS_DATA_MAX);
+			result = "4\n";
 		else if (val == 1)
-			len = strlcpy(tbuf, "2\n", DEBUG_FS_DATA_MAX);
+			result = "2\n";
 		else if (val == 2)
-			len = strlcpy(tbuf, "1\n", DEBUG_FS_DATA_MAX);
+			result = "1\n";
 		else
-			len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
+			result = "Invalid\n";
 		break;
 	case MAX20730_DEBUGFS_OC_PROTECT_MODE:
 		ret = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_OCPM_MASK)
@@ -230,13 +231,13 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
 			>> MAX20730_MFR_DEVSET2_SS_BIT_POS;

 		if (val == 0)
-			len = strlcpy(tbuf, "0.75\n", DEBUG_FS_DATA_MAX);
+			result = "0.75\n";
 		else if (val == 1)
-			len = strlcpy(tbuf, "1.5\n", DEBUG_FS_DATA_MAX);
+			result = "1.5\n";
 		else if (val == 2)
-			len = strlcpy(tbuf, "3\n", DEBUG_FS_DATA_MAX);
+			result = "3\n";
 		else
-			len = strlcpy(tbuf, "6\n", DEBUG_FS_DATA_MAX);
+			result = "6\n";
 		break;
 	case MAX20730_DEBUGFS_IMAX:
 		ret = (data->mfr_devset2 & MAX20730_MFR_DEVSET2_IMAX_MASK)
@@ -287,10 +288,11 @@ static ssize_t max20730_debugfs_read(struct file *file, char __user *buf,
 				"%d.%d\n", ret / 10000, ret % 10000);
 		break;
 	default:
-		len = strlcpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
+		result = "Invalid\n";
 	}

-	return simple_read_from_buffer(buf, count, ppos, tbuf, len);
+	len = strlen(result);
+	return simple_read_from_buffer(buf, count, ppos, result, len);
 }

 static const struct file_operations max20730_fops = {
--
2.41.0.255.g8b1d071c50-goog


