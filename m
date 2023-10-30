Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3217DC15E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjJ3Uk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjJ3Uky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:40:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8A2FA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:40:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ae5b12227fso51473637b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698698450; x=1699303250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+L7D0X/8UFbDxxszxyMbdHdPxX3IfKefskLSxNpM7js=;
        b=hhCVTP1Cpvd/PbNbXwNxuudSN/Unh9YfIWVY4kHLyrAiEYZvsCX4MU/CMXFpWnqUSp
         tOLKqD4Vl+s51RaKPfLSbfdSYOuCanq9on7S4SwK0l1FCfDyZgA0ojEO3Xuxu8LXcEzr
         JxRjs/ww7V09VohbauzPUHNSf2DVW0uRT8rYujygl4mMcAvNnTbgQ9iOJDXhvvADMd+t
         MK/fEVVavdhMHwSxlTk6+h51IjTyUal4Ei+/oe5kB8W+ikTMAZH7HCpb2eW/9LGgsqRv
         cB7UMmchzhjvKe7VflVLOWCjc441YfhkZ5yZprQvn0IAAV0IxQHrcwsNT1r4yXQbylL+
         uqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698698450; x=1699303250;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+L7D0X/8UFbDxxszxyMbdHdPxX3IfKefskLSxNpM7js=;
        b=gq6CWvkHZiQvi2UN/t6C2ZSHyDOVspXmxE8Thjjhm8s1qIBivmeA13nHlkyKtDY3+f
         WGxyIXYJuceOIEZuw6UQoQs7BiZ49u/yu8xLtWbKhusA2W3IaeFhWJW6mvAQARVm53ND
         SOom3wm9hyW+sQN/J7BGfUm0YwR/IgOmsTR6bsBx30waQigz37HZKS42hTC5iIZeuzS8
         02bprAuz2h0YzkxJuFLQYO3lOVsl2HpD6Kp3UVurA/OCTX8dhDKbdR6cEXj54yucx3QO
         1DIK1SdnIvKK2pD680ea6VEXb8HBRGhcLWHez5tJeFREaVQSs7sHAs04J/vbNBoALSXL
         QbvQ==
X-Gm-Message-State: AOJu0YzI0tA9HWxtDhUTvhc3uDQDlMQKFPKAKGEgVQlHk3bRk7GJ1iUk
        qDovX/4eB1bSemyDeAJhgTa2Nn8pleDkpzUFFA==
X-Google-Smtp-Source: AGHT+IFMwgpHnQc+ZprATG+9xkN/YQLqGDr23c9NaiAHsaOO+EK9sMO0RJNh4rCFVzgL3jJHRVsodsSz8UC842FQaQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:8494:0:b0:5a8:6162:b69 with SMTP
 id u142-20020a818494000000b005a861620b69mr223809ywf.3.1698698450488; Mon, 30
 Oct 2023 13:40:50 -0700 (PDT)
Date:   Mon, 30 Oct 2023 20:40:48 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAM8UQGUC/1WNMQ6DMAwAv4I8Y8khYihfQR3AcVsPBGRXERXi7
 43Y2O6WuwNcTMVhaA4wKeq65iqhbYA/U34LaqoOHXUxUCT0r2XefphMi5ijsyvqvJQ7MMa5p/B g6WlKUHObyUv3azU+z/MPq6nGinoAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698698449; l=2516;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=gC2v5Pe9R9loyw+Pgy7T7l7m2TvAbA4wi3ehG1YRi0M=; b=W3M+JdyCyQGlb9fJmaBzQFKyHdjqWqWHavOQpR+qFwi3gIjoNLdwqlFCE5x4QCeRE1qFOjDV/
 sdKApW7tbo9DiqLojPnw03mfZ+Pl1LUprSvDY4g8Uc12B3oz4FkevI6
X-Mailer: b4 0.12.3
Message-ID: <20231030-strncpy-drivers-scsi-ibmvscsi-ibmvscsi-c-v1-1-f8b06ae9e3d5@google.com>
Subject: [PATCH] scsi: ibmvscsi: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
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

We expect partition_name to be NUL-terminated based on its usage with
format strings:
|       dev_info(hostdata->dev, "host srp version: %s, "
|                "host partition %s (%d), OS %d, max io %u\n",
|                hostdata->madapter_info.srp_version,
|                hostdata->madapter_info.partition_name,
|                be32_to_cpu(hostdata->madapter_info.partition_number),
|                be32_to_cpu(hostdata->madapter_info.os_type),
|                be32_to_cpu(hostdata->madapter_info.port_max_txu[0]));
...
|       len = snprintf(buf, PAGE_SIZE, "%s\n",
|                hostdata->madapter_info.partition_name);

Moreover, NUL-padding is not required as madapter_info is explicitly
memset to 0:
|       memset(&hostdata->madapter_info, 0x00,
|                       sizeof(hostdata->madapter_info));

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 59599299615d..71f3e9563520 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -266,7 +266,7 @@ static void set_adapter_info(struct ibmvscsi_host_data *hostdata)
 	dev_info(hostdata->dev, "SRP_VERSION: %s\n", SRP_VERSION);
 	strcpy(hostdata->madapter_info.srp_version, SRP_VERSION);
 
-	strncpy(hostdata->madapter_info.partition_name, partition_name,
+	strscpy(hostdata->madapter_info.partition_name, partition_name,
 			sizeof(hostdata->madapter_info.partition_name));
 
 	hostdata->madapter_info.partition_number =

---
base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
change-id: 20231030-strncpy-drivers-scsi-ibmvscsi-ibmvscsi-c-3b5019ce50ad

Best regards,
--
Justin Stitt <justinstitt@google.com>

