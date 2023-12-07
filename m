Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FD38094B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444064AbjLGVib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjLGViI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:38:08 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFDC47B5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:34:44 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d33b70fce8so15744377b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 13:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701984884; x=1702589684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+dxQ+lFxuekIJsQrZiGvKP2+R83S4w5OOR8cyBrT1oo=;
        b=s+igP09JeB7W1ja3SIjcYioWkjyYxBhF6Hb8HT7jCDIrnyMsSGw8J0vAg1jr38+en8
         mHLGLx3SYCzuMHzIB1LjVdqQwNv6o5X5G+0IKfFct9lhqb/TZ7M+B3PWYiCSQspjDNsa
         RpRs/TYJw9NgXe8HklByOP3c8+bNQ4TRncB/4MAXH9OURwcjjtBNLWsFOB+LqVFSsfm0
         5SBxEPX5RhtTznqN0kWawiWTYSNBNJpq3N9pz4H4GjMO4qr02WB0EDOy0WJxWHWTHVpB
         5eWyM34jkZ9bM0Nid4lQdzsuPT6iIswPjRl/TYASTGBv+XiMR55rFSmeKMBXYl6FvkZp
         VOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701984884; x=1702589684;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+dxQ+lFxuekIJsQrZiGvKP2+R83S4w5OOR8cyBrT1oo=;
        b=WT7hOYiMwlTZRuSVsr92/+djzYJOYI+ZD/VhVAYBDDjzWIKDp1JFvEMK478YWVTAX8
         fr1/nn/OV5j1+kIY40R8nFLJc4Tp6TdFQysMLUCQBKLKyYNccYuCCMfPQFfsrm8gpXQR
         v6GU5jv3Br8udvrO211FSAMEnIVyzhyiQcycrrpSlpXf/M8XgLplSo0hprd+h7hdGLfy
         OQlKfdY970LgmxXZVNEalaE3fUjuD6tFtMhn7s7GEiuJ4B60hAtBHvUkYcfbWIBQV5oa
         29KVc9T0QxJWkNlIO9yDFRZGTZ1TfSUmJoNg3DbB9EJhbFKSy48tc33bctTWB9Cbszq5
         Hw3g==
X-Gm-Message-State: AOJu0YySPM2Vvsvi1m1kd/CYKqzMFfoef4ClHTBd5TVvkPPG53g4EO+E
        VGL21BVG1aIbHnlKXtJrDKdDszSyTXuUHyQQRg==
X-Google-Smtp-Source: AGHT+IEgzdAATHoxhjUVd4cnR3dvFK0Qlar2PLS7jkiyijD9vhvYac3HXo2lIis5WbXhIOSPsw0S25yOh/YRBaCX5w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:3144:0:b0:db3:f436:5714 with SMTP
 id x65-20020a253144000000b00db3f4365714mr45374ybx.0.1701984883901; Thu, 07
 Dec 2023 13:34:43 -0800 (PST)
Date:   Thu, 07 Dec 2023 21:34:42 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHE6cmUC/6WOTQ6DIBSEr2JY9zVgKf6seo/GNBRflaSCeRBSa
 7x70St0Mcl8s5iZlQUki4G1xcoIkw3WuwzlqWBm1G5AsH1mVvLyIji/QojkzLxATzYhBXAYAeO
 ItBs96a93gE7veuSoxwQGlJE1l1IprSuWq2fCl/0cs/cu82hD9LQcL5LY0z8HkwABTy3rqmkqK RS/Dd4PbzwbP7Fu27YfgaQtMPkAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701984883; l=2405;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=NfdFJEILBicX+cKI9Lam0xi1N5rwWJPZbrcrKRNR7ek=; b=USHVW9EnVVap8XHQCQKZwCMqui5mXIlCs8pOQqrQSBk37cDVheZxNNOSUifYJos12XxU1VyCf
 mt+BoGh3e/1Bu0+A0U+bcdSiCoC3A3xOy3rdcwDhwzLsK7PZ95BW9iF
X-Mailer: b4 0.12.3
Message-ID: <20231207-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v2-1-a1f2893d1b70@google.com>
Subject: [PATCH v2] net: ena: replace deprecated strncpy with strscpy
From:   justinstitt@google.com
To:     Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

host_info allocation is done in ena_com_allocate_host_info() via
dma_alloc_coherent() and is not zero initialized by alloc_etherdev_mq().

However zero initialization of the destination doesn't matter in this case,
because strscpy() guarantees a NULL termination.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- update commit message, dropping inaccurate statement about allocation
  (thanks Arthur)
- copy/paste Arthur's explanation regarding host_info allocation into
- rebased onto mainline
- Link to v1: https://lore.kernel.org/r/20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com
---
Note: build-tested only.
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index b5bca4814830..4a41efcc996b 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3276,8 +3276,8 @@ static void ena_config_host_info(struct ena_com_dev *ena_dev, struct pci_dev *pd
 	strscpy(host_info->kernel_ver_str, utsname()->version,
 		sizeof(host_info->kernel_ver_str) - 1);
 	host_info->os_dist = 0;
-	strncpy(host_info->os_dist_str, utsname()->release,
-		sizeof(host_info->os_dist_str) - 1);
+	strscpy(host_info->os_dist_str, utsname()->release,
+		sizeof(host_info->os_dist_str));
 	host_info->driver_version =
 		(DRV_MODULE_GEN_MAJOR) |
 		(DRV_MODULE_GEN_MINOR << ENA_ADMIN_HOST_INFO_MINOR_SHIFT) |

---
base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
change-id: 20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-6c4804466aa7

Best regards,
-- 
Justin Stitt <justinstitt@google.com>

