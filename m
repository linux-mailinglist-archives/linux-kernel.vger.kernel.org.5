Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20FB7D4075
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjJWTvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJWTvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:51:01 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308FD1A4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:50:59 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id 46e09a7af769-6c70e93400bso6210181a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698090658; x=1698695458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bF7T0d28n9cL6YgeW2rqKNnAbndsOrdsoITtJXsJhco=;
        b=VV3XnTVniOZXoCAAMyXAJgZvS8v42+VNeI5Jy5p7T5SzwXqUdBY8rQY3MaH/S4Uk/G
         ekNsTdpE7mdmR+9VU2l++lBxbAPF/u6wwxxHv3jvijT6Kh/a1y4QCOAM5SFaqzi6SGGU
         pDrgPmSWzFxbnPSRqt460d5QHzXrXDSAsGXIpYkEL4+d662ygpOuEB6hW6oShoNzU2zs
         Rw/15fWa0uewaEnEX2WL15o+vhJMce8CEZ85emXq14bIOs/X0owBoVnHj5/kGAEzMFa7
         pmtyNQbyR59uld+6jpJNtti+V2pTlWT9URS7rYyAjgcmI3myuq+YH4Mk81nYYqrdJzY/
         WrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698090658; x=1698695458;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bF7T0d28n9cL6YgeW2rqKNnAbndsOrdsoITtJXsJhco=;
        b=muHw/bSboiSCGWkLkdrKG/orXbGYatdbyu6G7uimPPPfO2prTMVPwihiLNm7aNo64l
         gb34u1KaKKgw56QOen03vIyw/Rfh5pd/n6lKfTczYoblrwvDqQnOG0/T27LPhiycCiO5
         Z+y2EAvli994LglMeaZg9tIHVORIaOvBuHCw1lI30zEDv7MWeLuUeTZcMB24BjbzHdF0
         sPhtCFoLWkQ26YFnJi8iEBuefQetCybb9HNdRW17OUJKUb7pVu2I4FaLBvjclzYMFHl0
         IPSmLbYdY64QcLSkJCBMxwee6E46Bn+I6twZCsEKk8q2JlHZtuD96OYnBRvt4Jt/AlYJ
         HVjQ==
X-Gm-Message-State: AOJu0YyuqQaP3GACk1YA34LS2wNr2nQ1X1QwQHLTw4f5WtHQBKIHA3CO
        dzMpsPbjf5zHjn1XU//Zrp6jq1XeJ5+yjC14VA==
X-Google-Smtp-Source: AGHT+IF0h+/xrakdb44PmJlTv4OdJIpOxbtE1q6VwuBoxBcow2sL1DM3RGqW5GixyjHX+YFxDwu9WN9g/oFlYuuWcQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6830:9:b0:6bc:f328:696a with SMTP
 id c9-20020a056830000900b006bcf328696amr2714868otp.0.1698090658533; Mon, 23
 Oct 2023 12:50:58 -0700 (PDT)
Date:   Mon, 23 Oct 2023 19:50:57 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKDONmUC/x3MMQqDQBBG4avI1BlQV5B4FbHQ2TGZZiPzi1Fk7
 54lxSu+5t0EdVPQUN3kehjskwqaR0XyntNL2WIxtXUbmhJj9yTbxdHtUAdDYBy+jBksLL1IHfr YLfKk8thcVzv//3HK+QePuh6hbwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698090657; l=2555;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=7GBzrHxBfUi4U3AvyTYICsD2FUILDgUdjKwKv0QmnCY=; b=XgVC/DXR0DzmOmUA/pGXj7Oim73+vtl9EM47VYRbVwNnvy3QrTsTEi4sHRs+WdbEqHS0hunvB
 atsZa3YYQWACsuUDJze3QJQSkCf0yxVXO1e09sFqUyHmC9pCx30v7rk
X-Mailer: b4 0.12.3
Message-ID: <20231023-strncpy-drivers-scsi-3w-sas-c-v1-1-4c40a1e99dfc@google.com>
Subject: [PATCH] scsi: 3w-sas: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
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

This pattern of strncpy(dest, src, strlen(src)) is extremely bug-prone.
This pattern basically never results in NUL-terminated destination
strings unless `dest` was zero-initialized. The current implementation
may be accidentally correct as tw_dev is zero-allocated via:

	host = scsi_host_alloc(&driver_template, sizeof(TW_Device_Extension));
        ...
	tw_dev = shost_priv(host);

... wherein scsi_host_alloc zero-allocates host:

        shost = kzalloc(sizeof(struct Scsi_Host) + privsize, GFP_KERNEL);

Also, further suggesting this change is worthwhile is another strscpy()
usage in 32-9xxx.c:

	strscpy(tw_dev->tw_compat_info.driver_version, TW_DRIVER_VERSION,
		sizeof(tw_dev->tw_compat_info.driver_version));

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's not be accidentally correct, let's be definitely correct.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/scsi/3w-sas.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index 55989eaa2d9f..9bdb75dfdcd7 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1326,7 +1326,8 @@ static int twl_reset_sequence(TW_Device_Extension *tw_dev, int soft_reset)
 		}
 
 		/* Load rest of compatibility struct */
-		strncpy(tw_dev->tw_compat_info.driver_version, TW_DRIVER_VERSION, strlen(TW_DRIVER_VERSION));
+		strscpy(tw_dev->tw_compat_info.driver_version, TW_DRIVER_VERSION,
+			sizeof(tw_dev->tw_compat_info.driver_version));
 		tw_dev->tw_compat_info.driver_srl_high = TW_CURRENT_DRIVER_SRL;
 		tw_dev->tw_compat_info.driver_branch_high = TW_CURRENT_DRIVER_BRANCH;
 		tw_dev->tw_compat_info.driver_build_high = TW_CURRENT_DRIVER_BUILD;

---
base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
change-id: 20231023-strncpy-drivers-scsi-3w-sas-c-c7cc037d4bc9

Best regards,
--
Justin Stitt <justinstitt@google.com>

