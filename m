Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375D57C43FE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjJJW1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjJJW1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:27:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F71107
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:27:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a581346c4so1733461276.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696976832; x=1697581632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GtM0w+J9cw3jjb0usGEHfb5iDugSjDgb6JSiT+iZymc=;
        b=NEO+sMKtDzsP8gxorptIaos+DmHsjIjrhqDxRsy3hTrzvtOtToRkMNPURCeyMENd1m
         kJxuvWBxzplAlqxue3X7pim5HxPgPjBOX7bWZC5kyW777hvEpFWI5qdchLXSkkn0T3L1
         EuXt89gNgq56/Qm2LzwzF3zS+9UV0+b7klrofE2cOI9Yr1NJimF7BitT8gRlCk6zC36I
         J5IOvuIGujn1RsUvZzpt+1cVYPcCR9xRs0XZPIGSpDZNbZ5Mo9SuB7iZnPIn3xhOLnK2
         8I5ZFTFy3WN0BoJ6IoDf5crQjMsqcxZvfh0EnJIyTykRa7omeVm1fqzK79VrJBd2QO79
         WoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976832; x=1697581632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtM0w+J9cw3jjb0usGEHfb5iDugSjDgb6JSiT+iZymc=;
        b=MFXI8tnUPWn1A0vU+myA3p0/IedSdoCRanzpDJkZHX64MS9aSwAJcKPnoeBWkjp+Ma
         81hjcbu+Yf5no4jfs2Galo/yGDC3pGxPhusRzvg8FuJ7Nzl0LhlnffosnMEkC8KiOJZu
         TFQxtTwDlXLkV4Nd2c6o2TlFmLoUPUg2Np+LAxPf3+L4uQqlpClFEBUgsQJRNzK8lToA
         0QDOr4cNSjS5As1W8F/WjGTXJHUfKaDJJ/V9S0FSjH53tVgXCKjxNwd0LY6mMDnepLs7
         kvr2P2aT4vf8hDd0e9e6wyvnSXtVdaOnOJqYBmFsvLguwzmOWXYmuf2Kq77DTdkifMHG
         9TQg==
X-Gm-Message-State: AOJu0Yz05oWT62UoMUqchpgVXcEfNEyxPwTMPWCgL2w3GU1KasDXQz8e
        Z19O41ol7SFHqX4b6Ivk6+BCY4nYllQgvBP0Gg==
X-Google-Smtp-Source: AGHT+IE90IMRLxbCtK+FWTfBYeHC+U5Cy3qc2KOUif/Mw4hAnclXZq/qXjDbI29Vfn0ZPUuW4ixhfNcK0Pbgbem5bA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ced3:0:b0:d9a:634d:4400 with SMTP
 id x202-20020a25ced3000000b00d9a634d4400mr53292ybe.5.1696976832282; Tue, 10
 Oct 2023 15:27:12 -0700 (PDT)
Date:   Tue, 10 Oct 2023 22:26:58 +0000
In-Reply-To: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
Mime-Version: 1.0
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696976825; l=2053;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=tIBhN0dI5KQV25Dn8IjDZp+7IelZH6PsmdLrTBm66Xc=; b=hRT8DAV5FRqqSXsHAHmPSGPSEQbQBGx13G3GU53NmuUbzuZgGmmwVJqw/B2WprCOy7JOSEs7A
 JUBcK+9dOy2Bis775R/QWrp3y4385KpGI7leBfVy2b+aVrSU/y1pH0a
X-Mailer: b4 0.12.3
Message-ID: <20231010-netdev-replace-strncpy-resend-as-series-v1-5-caf9f0f2f021@google.com>
Subject: [PATCH v1 net-next 5/7] igb: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-hardening@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We see that netdev->name is expected to be NUL-terminated based on its
usage with format strings:
|       sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
|               q_vector->rx.ring->queue_index);

Furthermore, NUL-padding is not required as netdev is already
zero-allocated:
|       netdev = alloc_etherdev_mq(sizeof(struct igb_adapter),
|                                  IGB_MAX_TX_QUEUES);
...
alloc_etherdev_mq() -> alloc_etherdev_mqs() -> alloc_netdev_mqs() ...
|       p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);

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
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 76b34cee1da3..9de103bd3ad3 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3264,7 +3264,7 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	igb_set_ethtool_ops(netdev);
 	netdev->watchdog_timeo = 5 * HZ;
 
-	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
+	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
 
 	netdev->mem_start = pci_resource_start(pdev, 0);
 	netdev->mem_end = pci_resource_end(pdev, 0);

-- 
2.42.0.609.gbb76f46606-goog

