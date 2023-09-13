Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6AD79E24A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbjIMIij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238983AbjIMIii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:38:38 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D0D196
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:38:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf7a6509deso45784235ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694594314; x=1695199114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0GxVMeNb/eVsL5k6yegenMY0uKehAcu5sJKI/IuX61Q=;
        b=TQ606CQ/XNc0d6LRzKEeveRJMj17fIFhZVKbBLROhRf4Gp46fa9GZhxK7q2oH/DXab
         PNSzSrCa91yRnMNEHQQ2PRAsnve9FQBfXePaKnJATHrM5ON7UGIxf0B3ngFITaTOLw/j
         yQmrJq3FAq8EzW8XxAfU9F+2ZBPyVljqSh8mFArG+LKHy7UeCn5TkWorKb/bhaX2EyY3
         w2fPwMErd7ZEkkBnWT4su14/SzVv1MR/xcin+yCF8vFVcIVbl1p7iH79ZkBI1R8Fe21j
         /F1Ph4lD4wFBJq3lmyQ7I9R4Hcd4PC7psf7TPrMr6hK6C9lSd52M6WW8BkWxCMuGRHFT
         7QUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694594314; x=1695199114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GxVMeNb/eVsL5k6yegenMY0uKehAcu5sJKI/IuX61Q=;
        b=LMvoOepOe4wzG1jKtqwvJTo6lLHmFPI2d9A4agEBx4Hb2oHItTMk6cUJPQ+Pf2z2Iw
         KN6DENMwmp9jT9l+oT+miqCJ7PjyJP/ujevEcgOhpTxqWSbFAJjT+/sE+1K/UZ8kEVYE
         hhOSspgQskGBrMqI5JZx6JK1uklkM1oB7jChDjvZOlrqEu3kgDEZwPsDPW23qFfwaUeq
         BS08YAnK6pKfVBCH7tr2sSnn9b1AlpnlXKDBSaidGCvue83ikXqIbRQzqR8DQVov7kOC
         umXfAahRVnpqbqNgxF6PfdJBwsUnXvLoFdO6JDUTp/stncImTJOfNhuZA/Y4TiU7aD+0
         Emkw==
X-Gm-Message-State: AOJu0YzLb1xa4kfs5o/yECl3bGkddKqXfi9VP7Hz2E+iGUP1VEId6bik
        2Ch2pWybF5vdlKoWuhVPB8RlnA==
X-Google-Smtp-Source: AGHT+IFWBPA0XW9K/VWSg6ZZN+P8wcn1hKSWwcd0lGMvhnBB+1hQSKCALcQ1XEhRqqNvk13bStTGJg==
X-Received: by 2002:a17:902:ab95:b0:1c1:fe97:bf34 with SMTP id f21-20020a170902ab9500b001c1fe97bf34mr2055525plr.24.1694594314083;
        Wed, 13 Sep 2023 01:38:34 -0700 (PDT)
Received: from PF2LML5M-SMJ.bytedance.net ([220.243.131.6])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902a40600b001c3adb4f9e3sm6105837plq.120.2023.09.13.01.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 01:38:33 -0700 (PDT)
From:   guojinhui <guojinhui.liam@bytedance.com>
To:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org
Cc:     lizefan.x@bytedance.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "guojinhui" <guojinhui.liam@bytedance.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] driver core: platform: set numa_node before platform_add_device()
Date:   Wed, 13 Sep 2023 16:38:25 +0800
Message-Id: <20230913083825.2670-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "guojinhui" <guojinhui.liam@bytedance.com>

platform_add_device creates numa_node attribute of sysfs according to
whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
of the device before creating numa_node attribute of sysfs.

Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
Signed-off-by: guojinhui <guojinhui.liam@bytedance.com>
---
 drivers/acpi/acpi_platform.c |  4 +---
 drivers/base/platform.c      | 13 +++++++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 48d15dd785f6..adcbfbdc343f 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -178,11 +178,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	if (IS_ERR(pdev))
 		dev_err(&adev->dev, "platform device creation failed: %ld\n",
 			PTR_ERR(pdev));
-	else {
-		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
+	else
 		dev_dbg(&adev->dev, "created platform device %s\n",
 			dev_name(&pdev->dev));
-	}
 
 	kfree(resources);
 
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 76bfcba25003..206dc7b020cd 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -795,6 +795,18 @@ void platform_device_unregister(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(platform_device_unregister);
 
+#ifdef CONFIG_ACPI
+static inline void platform_set_dev_node(struct platform_device *pdev)
+{
+	struct acpi_device *adev = to_acpi_device_node(pdev->dev.fwnode);
+
+	if (adev && adev->handle)
+		set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
+}
+#else
+static inline void platform_set_dev_node(struct platform_device *pdev) {}
+#endif
+
 /**
  * platform_device_register_full - add a platform-level device with
  * resources and platform-specific data
@@ -841,6 +853,7 @@ struct platform_device *platform_device_register_full(
 			goto err;
 	}
 
+	platform_set_dev_node(pdev);
 	ret = platform_device_add(pdev);
 	if (ret) {
 err:
-- 
2.20.1

