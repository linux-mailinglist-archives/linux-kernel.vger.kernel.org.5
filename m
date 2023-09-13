Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E45079DD8B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjIMB2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjIMB2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:28:19 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852E310FE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:28:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58ee4df08fbso74332787b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 18:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694568495; x=1695173295; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yCqiEa2a8nIymMx7rh7S0DSXU/QWPryO0phU6kWLCVE=;
        b=zlprAgTJgIJXT3nwJ+MFsq/tmMuG7AWBvhAwOnHZIaNdVJbYgtXHaItMdKbs5olMkJ
         Mbj1dAa/XLxLtxrO+sVATMuPUpD054zxfY36pwN8gXyktkP1fhl2IxGrU6EN65fz4/xr
         jQZ0wEyajq4MYHAy2gm5q/4K5xtFd/28tjcCfYSEOjCWchvgAEZ/oH8AIQmiW+azGGfe
         c/rY8WHoEM/L4R/i8FHuxm1brrBZLKzHmgoNpSplPm8ycpSISO8/SFYPFmbhHcr+soHa
         BUPeJnjAmE/vSEbv6vSuxTA7wvw4nWP8z5MNsBhVpHezIQnFQv540xofb19awUmij5n2
         Nrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694568495; x=1695173295;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCqiEa2a8nIymMx7rh7S0DSXU/QWPryO0phU6kWLCVE=;
        b=Gf7gftNWysBpJlM/63Gl55I971cGr7bhDs3TaX7MB35vX60Adx66pcabimOZW3Bvb3
         9mISXIZJJiKU2UN2c9h/G0xR+ECHGfPadNHvhQ4Dd0n3j4tmmpHYc3juFuaQWvELzRZ2
         PG1S/eFbL0FwkJrR9F+YLWdrA1/Rzql+jHnRQlA9Kj70O7SZ5ELUt7dvoBLLnVQigwH3
         28p3pnnyyFsARXHR/ZJZTNGEYKnHAa9jG1F6yct1SUeM7/q3mdnG9Q0AvMCIHw9Y0yLQ
         MsOvZ66lkQXxng1zvM/rmxIR8C0yTiJeAzlhBJUfPZWLwMX0aoQYNNG+KQl4t6tIx4Dz
         YAtQ==
X-Gm-Message-State: AOJu0YyOnPKaUXWXKGUnb1aVLlJg42QwViXXdwYd+5ljpMVf12eL46+Y
        CN80VOMhkle4a4LuvxAZsCAg2IKy/Gk36tuyzA==
X-Google-Smtp-Source: AGHT+IG9jYbXDqQ2MGuyWeWiHc67c8YoVJvzpuJFxXoAyAEbmuLzIAXquE4h9Krg0Xej9il/nyHwcSf19MDOQxwo5w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:cf57:0:b0:d7f:809a:9787 with SMTP
 id f84-20020a25cf57000000b00d7f809a9787mr25547ybg.1.1694568494833; Tue, 12
 Sep 2023 18:28:14 -0700 (PDT)
Date:   Wed, 13 Sep 2023 01:28:13 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC0QAWUC/5XNTQqDQAyG4avIrJsyP22pXfUeRURnogaqI4kMF
 fHunXqDbgJPFt+7KUEmFPUoNsWYSChOGfZUKD80U49AIVtZbZ0ujQNZePLzCoEpIQtgaPxx6tH
 XskonkH0zZau1sZfGqTw1M3b0OTKvKnsgWSKvRzWZ3/fPQDJgIFhn76Vp9bXVzz7G/o1nH0dV7 fv+BZMFMzjZAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694568493; l=2154;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=AWBmh6vqolUPI9k2kK+RgtaYzFJyIqpMGxFIUsXlqtc=; b=tWhd4sSBGUjk/dE42wrncFzUu7cnY4UMj6bzWSGfWi6sJHP3XzmxBhPfWjRmkJV1Tc9sl1ZbT
 5p8B0BuhMpbCce1oKqePnqhzhsgZFViKPd7ZcDNAU+onynxh1UMJKYl
X-Mailer: b4 0.12.3
Message-ID: <20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v2-1-2d2e6bd43642@google.com>
Subject: [PATCH v2] EDAC/mc_sysfs: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

A suitable replacement is `strscpy_pad` [2] due to the fact that it guarantees
NUL-termination on the destination buffer whilst maintaining the
NUL-padding behavior that `strncpy` provides. This may not be strictly
necessary but as I couldn't understand what this code does I wanted to
ensure that the functionality is the same.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- included refactor of another strncpy in same file
- Link to v1: https://lore.kernel.org/r/20230913-strncpy-drivers-edac-edac_mc_sysfs-c-v1-1-d232891b05b0@google.com
---
Note: build-tested only.
---
 drivers/edac/edac_mc_sysfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 15f63452a9be..ce025a20288c 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -229,8 +229,7 @@ static ssize_t channel_dimm_label_store(struct device *dev,
 	if (copy_count == 0 || copy_count >= sizeof(rank->dimm->label))
 		return -EINVAL;
 
-	strncpy(rank->dimm->label, data, copy_count);
-	rank->dimm->label[copy_count] = '\0';
+	strscpy_pad(rank->dimm->label, data, copy_count);
 
 	return count;
 }
@@ -535,7 +534,7 @@ static ssize_t dimmdev_label_store(struct device *dev,
 	if (copy_count == 0 || copy_count >= sizeof(dimm->label))
 		return -EINVAL;
 
-	strncpy(dimm->label, data, copy_count);
+	strscpy_pad(dimm->label, data, copy_count);
 	dimm->label[copy_count] = '\0';
 
 	return count;

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230913-strncpy-drivers-edac-edac_mc_sysfs-c-e619b00124a3

Best regards,
--
Justin Stitt <justinstitt@google.com>

