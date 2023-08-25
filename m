Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4286B789170
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjHYWKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjHYWJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:09:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B9626B0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:09:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58f9db8bc1dso20780627b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693001394; x=1693606194;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IdHKEBf6LNa2SDLafbTePlchXJqRhBXEEMD76f6TFqQ=;
        b=Q81oK/zkDH876XIfN0sPNVNN5z8b6L18X4x/1+1qY92QqqQw7RJRN82Vwabqzz8jrz
         yHCgVzhl9GVIhGnnLQxocTR0yqRL9v3b5FA/IwncCsNRSrd/ESpv2nYwsG1l/hZ1Y2J4
         uAyCLHE/pmVmYzGGkJ/Q7H8MW0nyoHLw8eYch6DINFcG0D/1UDyS0q72RiLzlfOFcJjN
         OW6JujW6FHIXebrZScvsrviTCqEUJM/XiL0dfIQC2KEGrZgt8q6eM6oS8v0a0eSnq5vn
         VPEFVNM9NG39LxSIl2Fk+Vlv+A7ZelyFFuFC1HzNShnlt7pZVtaN0Sm07XZ1Uiv1FDCA
         YpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693001394; x=1693606194;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IdHKEBf6LNa2SDLafbTePlchXJqRhBXEEMD76f6TFqQ=;
        b=BaSchNIxIsSxpVqQMXDRcGKC0qIgIvMZVibKLJOyCjrXYlIyS59cNAPT/M6geh/p5K
         UqEK5OV1BR/7p/F8zhFkZpd3Vz0AJ37zSmSHULRWsSb/sZosR8JcBkjp2pmN0NmggnTT
         O9pLVOkaWe9syvZMBXxlIfp6nlIQBnwtV2eefRobIvsrf+c+puyosUQ/3NufOsV/yAaj
         KWsVnJbviqQk+VYxM9LZIPf0gxzyP7QnWx8kCI2rPiHi7KSABWK0Bdy/Flbyfer5R+FS
         epjuVOsKlgj2XJlh3XkbOVIIRfJ/K0jYPQN0fD42IN4gcXEe3k56HZwwcCNh8o5EqG2i
         6b7w==
X-Gm-Message-State: AOJu0YywEkqNIIRScA5I6lC5l6yCZZxvz9SmlU65QUrHY2C6Cl3XTmec
        bgkPUHdPPmucg+PdLVszf0mecxtFqwaR4491MA==
X-Google-Smtp-Source: AGHT+IHtHRJ7fRcrma2Kt5JyL7K7aUmRWz+4dgMzIzO4z3FEZfOjTLnf+nN/dtoeAPuD6wy6OK9GjuCLAJHjuYGHxg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:ae06:0:b0:569:e04a:238f with SMTP
 id m6-20020a81ae06000000b00569e04a238fmr475035ywh.4.1693001393869; Fri, 25
 Aug 2023 15:09:53 -0700 (PDT)
Date:   Fri, 25 Aug 2023 22:09:51 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK4m6WQC/x3MwQqDMAwA0F+RnBdoqxO3Xxk7pG3UwBalkbEh/
 rtlx3d5OxgXYYN7s0Phj5gsWuEvDaSZdGKUXA3BhdYN4Yq2FU3rD2eKpPSiaJiWdxTljKlro8/ e33rHUIe18Cjf//54HscJfImEpm0AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693001392; l=5014;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=F1dg9ALegRSZFeyfAqDYuZEhvE32uhDXNyNHIraocuA=; b=3yMl0CQziwtRieL23Jknw+VaM6GOX8JUpBH9l1dlLv9vmV7gcjOFiB3EcfL6Q7IDaNoZziNU+
 AYzlvo2lvZlCy8qmFlE1zcPe8wLsY2EG7W3nj6zGmEYx2OgYbFLym4q
X-Mailer: b4 0.12.3
Message-ID: <20230825-strncpy-habanalabs-combined-v1-1-daa05a89b7e3@google.com>
Subject: [PATCH] accel/habanalabs: refactor deprecated strncpy to strscpy_pad
From:   Justin Stitt <justinstitt@google.com>
To:     Oded Gabbay <ogabbay@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We see that `prop->cpucp_info.card_name` is supposed to be
NUL-terminated based on its usage within `__hwmon_device_register()`
(wherein it's called "name"):
|	if (name && (!strlen(name) || strpbrk(name, "-* \t\n")))
|		dev_warn(dev,
|			 "hwmon: '%s' is not a valid name attribute, please fix\n",
|			 name);

A suitable replacement is `strscpy_pad` [2] due to the fact that it
guarantees both NUL-termination and NUL-padding on its destination
buffer.

NUL-padding on `prop->cpucp_info.card_name` is not strictly necessary as
`hdev->prop` is explicitly zero-initialized but should be used
regardless as it gets copied out to userspace directly -- as per Kees' suggestion.

Link: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings[1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
Suggested-by: Kees Cook <keescook@chromium.org>
---
Note: build-tested only

This patch combines three previous strncpy refactor patches into one.
1) https://lore.kernel.org/all/20230824-strncpy-drivers-accel-habanalabs-gaudi-gaudi-c-v1-1-a7fb9054734c@google.com/
2) https://lore.kernel.org/all/20230824-strncpy-drivers-accel-habanalabs-gaudi2-gaudi2-c-v1-1-1a37b65576b4@google.com/
3) https://lore.kernel.org/all/20230824-strncpy-drivers-accel-habanalabs-goya-goya-c-v1-1-b81d5639e7a3@google.com/
---
 drivers/accel/habanalabs/gaudi/gaudi.c   | 4 ++--
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 4 ++--
 drivers/accel/habanalabs/goya/goya.c     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi/gaudi.c b/drivers/accel/habanalabs/gaudi/gaudi.c
index 056e2ef44afb..1b5fe4d0cf5d 100644
--- a/drivers/accel/habanalabs/gaudi/gaudi.c
+++ b/drivers/accel/habanalabs/gaudi/gaudi.c
@@ -660,7 +660,7 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 	prop->pcie_dbi_base_address = mmPCIE_DBI_BASE;
 	prop->pcie_aux_dbi_reg_addr = CFG_BASE + mmPCIE_AUX_DBI;
 
-	strncpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
+	strscpy_pad(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
 					CARD_NAME_MAX_LEN);
 
 	prop->max_pending_cs = GAUDI_MAX_PENDING_CS;
@@ -8000,7 +8000,7 @@ static int gaudi_cpucp_info_get(struct hl_device *hdev)
 		return rc;
 
 	if (!strlen(prop->cpucp_info.card_name))
-		strncpy(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
+		strscpy_pad(prop->cpucp_info.card_name, GAUDI_DEFAULT_CARD_NAME,
 				CARD_NAME_MAX_LEN);
 
 	hdev->card_type = le32_to_cpu(hdev->asic_prop.cpucp_info.card_type);
diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 20c4583f12b0..2ba7a50103bc 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -2431,7 +2431,7 @@ static int gaudi2_set_fixed_properties(struct hl_device *hdev)
 	prop->pcie_dbi_base_address = CFG_BASE + mmPCIE_DBI_BASE;
 	prop->pcie_aux_dbi_reg_addr = CFG_BASE + mmPCIE_AUX_DBI;
 
-	strncpy(prop->cpucp_info.card_name, GAUDI2_DEFAULT_CARD_NAME, CARD_NAME_MAX_LEN);
+	strscpy_pad(prop->cpucp_info.card_name, GAUDI2_DEFAULT_CARD_NAME, CARD_NAME_MAX_LEN);
 
 	prop->mme_master_slave_mode = 1;
 
@@ -2884,7 +2884,7 @@ static int gaudi2_cpucp_info_get(struct hl_device *hdev)
 	}
 
 	if (!strlen(prop->cpucp_info.card_name))
-		strncpy(prop->cpucp_info.card_name, GAUDI2_DEFAULT_CARD_NAME, CARD_NAME_MAX_LEN);
+		strscpy_pad(prop->cpucp_info.card_name, GAUDI2_DEFAULT_CARD_NAME, CARD_NAME_MAX_LEN);
 
 	/* Overwrite binning masks with the actual binning values from F/W */
 	hdev->dram_binning = prop->cpucp_info.dram_binning_mask;
diff --git a/drivers/accel/habanalabs/goya/goya.c b/drivers/accel/habanalabs/goya/goya.c
index 7c685e6075f6..024ccf2e159b 100644
--- a/drivers/accel/habanalabs/goya/goya.c
+++ b/drivers/accel/habanalabs/goya/goya.c
@@ -466,7 +466,7 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 	prop->pcie_dbi_base_address = mmPCIE_DBI_BASE;
 	prop->pcie_aux_dbi_reg_addr = CFG_BASE + mmPCIE_AUX_DBI;
 
-	strncpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAME,
+	strscpy_pad(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAME,
 		CARD_NAME_MAX_LEN);
 
 	prop->max_pending_cs = GOYA_MAX_PENDING_CS;
@@ -5122,7 +5122,7 @@ int goya_cpucp_info_get(struct hl_device *hdev)
 	}
 
 	if (!strlen(prop->cpucp_info.card_name))
-		strncpy(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAME,
+		strscpy_pad(prop->cpucp_info.card_name, GOYA_DEFAULT_CARD_NAME,
 				CARD_NAME_MAX_LEN);
 
 	return 0;

---
base-commit: 706a741595047797872e669b3101429ab8d378ef
change-id: 20230825-strncpy-habanalabs-combined-c43b1d11960e

Best regards,
--
Justin Stitt <justinstitt@google.com>

