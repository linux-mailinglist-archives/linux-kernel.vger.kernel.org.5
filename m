Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816797D0531
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346700AbjJSW5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346663AbjJSW5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:57:20 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F7F131
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:57:18 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c9e6a4ff2fso1578835ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697756238; x=1698361038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Eogj0ZIYp5lAoNttJXlBaUD0mycxslTcJprZ08tb/AA=;
        b=F794g3wQhCOU1YKzGPMaocjnYfHUI6QVS1UvsJM13eOlKOH4GFAxc1oU7eEwytJqTv
         NTkypBwjsjpfCfPS6memfJeWJO5uZvQB/+hjskHHbywWhMpbr/w88wa7qZarDi8kwWP2
         tkd9YSrhK73YlF6gzw3FOXvvOVKMsWSxa+JycgX+GU7JEBihWLAAUirKwyGxBJep24E7
         03zRBbRtVS8mOcCuOSCoLdgwJISjYqgImMPgM7kQt1pcNXbpHM8k8/F0sO3EKN4ZhhOa
         cY+4qxKl6XeIIRenBs6DvZPYa74nwz+9YFPP2YqdW4X7b5KLl3qmcMEbEmKAp18PCBEB
         oRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697756238; x=1698361038;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eogj0ZIYp5lAoNttJXlBaUD0mycxslTcJprZ08tb/AA=;
        b=KGtqn8LRPeUk6e66dHCNZsIIrCRDjAYi0IUphdWc4rKSTM4daXy/h5rPtv81k47Nun
         t3Zae18WCrVScF5cjEEVu+EngF5SmsAvEXho+ezjguab7EeGQyz0wOKF33Rchpszn8k2
         5XhRxhhelTmSiEeRutqSzDgJ/rDjuLqQ8X2jiGpu4Dh86WhQdOf6IfCN2ZytyCVpj4nc
         qGISRAsjSSB6fsKmqemQw904mx2GTVrBYMGnlw0MznQGL6YmdRDSCHq7GqJDd9il8Zgt
         PgckgMM3Y+imFZ5RX3ojuSBtBliZb8RWKv8TjtoJP+VOjhptzp4kVeVruWoM38vdnlom
         XKDQ==
X-Gm-Message-State: AOJu0Yx3XB9zYdXakaBQtuU1+8ou3NMHDu6hL+Ykjf+T6eV3BwWamrqT
        4B6oBo6SKTXv/KE2uJl+wd1IKK6Lt9Io4YuHHQ==
X-Google-Smtp-Source: AGHT+IGqB8ePfZRfnc6eFr02PfyeXAhmA4mOPwWQgXiGl4wPSgLLHP9PZwQt6gAmJ10vDpPWoSqXiU8o2V125OsO1g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6871:330c:b0:1e9:9b7f:a04f with
 SMTP id nf12-20020a056871330c00b001e99b7fa04fmr107113oac.6.1697755678870;
 Thu, 19 Oct 2023 15:47:58 -0700 (PDT)
Date:   Thu, 19 Oct 2023 22:47:58 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB2yMWUC/x2NMQ6DMAwAv4I81xIJYaBfqTqA4xYvwbIrVIT4O
 4HhhlvudnA2YYdns4PxKi5LqRIeDdA8li+j5OoQ29iFNgzoPyukG2aTlc1Ri16MpIK0GCNhn/I wUYopdQw1pMYf+d+T1/s4Tp7JueN0AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697755678; l=2211;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=C6lzZd1cxmbbPTc6wyYJ22pu7h/P2ENQ5AFRalgiPpo=; b=ge/iP8gZqQZ3kKz0nqiurxoo3s00oFATnxJET06+lyq2Es+o9MhT5CXAqjQ4A8jC+RVZcccT+
 yv2TMnhmGYPBHTrmirBrNyBkwKZfL1Jzoy9d6rUK4WbdCBk0xS8hzEK
X-Mailer: b4 0.12.3
Message-ID: <20231019-strncpy-drivers-pnp-pnpacpi-core-c-v1-1-4c634a73bcf3@google.com>
Subject: [PATCH] ACPI: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We know dev->name should be NUL-terminated based on the presence of a
manual NUL-byte assignment.

NUL-padding is not required as dev is already zero-allocated which
renders any further NUL-byte assignments redundant:
dev = pnp_alloc_dev(&pnpacpi_protocol, num, pnpid); --->
  dev = kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding. This simplifies the code and makes
the intent/behavior more obvious.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/pnp/pnpacpi/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 6ab272c84b7b..a0927081a003 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -250,12 +250,9 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 		dev->capabilities |= PNP_DISABLE;
 
 	if (strlen(acpi_device_name(device)))
-		strncpy(dev->name, acpi_device_name(device), sizeof(dev->name));
+		strscpy(dev->name, acpi_device_name(device), sizeof(dev->name));
 	else
-		strncpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
-
-	/* Handle possible string truncation */
-	dev->name[sizeof(dev->name) - 1] = '\0';
+		strscpy(dev->name, acpi_device_bid(device), sizeof(dev->name));
 
 	if (dev->active)
 		pnpacpi_parse_allocated_resource(dev);

---
base-commit: dab3e01664eaddae965699f1fec776609db0ea9d
change-id: 20231019-strncpy-drivers-pnp-pnpacpi-core-c-54d9bc42443e

Best regards,
--
Justin Stitt <justinstitt@google.com>

