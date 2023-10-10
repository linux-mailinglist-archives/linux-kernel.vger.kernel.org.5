Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681337C420D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343829AbjJJVIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjJJVID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:08:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BB994
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:08:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d85fc108f0eso8235038276.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696972080; x=1697576880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ndlPGfYsR5FrdEZ+vU/Zj3bD+kBDGYy33Ae6WjfGffY=;
        b=yH7JNjCGblBJnpFGem+LJ0XJ46VVdoQ8IFy1TPq5B/CXj96sbF05KjMW8+hD1cSwrj
         LzdCJWSnVCNcZUsPQZB9QArlCV1Niq0YfaXz/j4c8pQWXLQYBswKq8RVblq5N8+d92ZV
         pw+O4IeIVAgmgXigzueKgaTYrX77fiXP4NdAACB+zKPnzUTwhyvwOKI7kgFhd4sG09pQ
         1j2EiCxGFOtc36v//Mv3yOSGyo1TSAL33uTkCWqVH6SZxrkDB1t2feYKL3sXKoUL/zav
         a1smD6ldyJIFYI8MaCrY2aCZY1KAVNFAUPNbSe9u+yfBOX1QQ3cQoTERj55dQvJ2gnv1
         pAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696972080; x=1697576880;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ndlPGfYsR5FrdEZ+vU/Zj3bD+kBDGYy33Ae6WjfGffY=;
        b=NxNyhJ5jO0LZ9OjD4tyCXSdvKQJRV2oU4DPCRZuRBIQHbSzZKaUSGgeQmZxAse3Lul
         DZr030Gisu4gjc0kHBf1EVgQrySSX4N6W8aklHkyHocFkUpir918CVUduGLWKSFBgS07
         JNXWkbKtXajCekqENLC4V5xVZ3frNKaNBMGhNl9mn1hkXX/e4AoJ0g1KlA0luMQdJg70
         +otOe2BXxYVdjNXXLjHQOaqopvCx+lNdMZWs7ajYNEILOu4WcWF9L3YT+SFOjZoJtkUW
         9ZBqG+eYI/CU603WdqovQhHnk7N6hG3JADOxM7vIQCcLXvM0kiFdrQjveU0UdDvwnIbt
         LgNA==
X-Gm-Message-State: AOJu0YxfUsv3fe+HAWc87WJGeT5WQyNLTjT2og8wX9yrudSZd0XUTjIb
        qfBi0lUnbVWOtg7F1x0icmrnNuaCQBVrRWB+Mg==
X-Google-Smtp-Source: AGHT+IHj9mcr3yN9cr0pAbeqwrfthhwiz6e+OtQon8JznMOo9KT/dvFu6WV/L5M0mXZjtD1IJkgEjwfrm/dmYR4P9g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:69d4:0:b0:d9a:58e1:bb52 with SMTP
 id e203-20020a2569d4000000b00d9a58e1bb52mr58171ybc.6.1696972080036; Tue, 10
 Oct 2023 14:08:00 -0700 (PDT)
Date:   Tue, 10 Oct 2023 21:07:59 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC69JWUC/x2N0QrCMBAEf6XcswdJimD9FRFpk217oGe5hKKU/
 rupDwM7LzsbZZgg07XZyLBKlrdW8aeG4tzrBJZUnYILrXfecS6mcflyMllhmRWFUWbYMUQLniz TcPB49aIceQjnDu0YLl1qqf4uhlE+/+btvu8/fpTvp4MAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696972079; l=2221;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=flnqc77MqO1c7xUbgevXQV3iKIfkAbCA1etAFyGMSlA=; b=L1o+advtN54cbFa+xXqTVzRfB3SNNlR/1bgBEQXRIdYE2QN+ozFKD/Z7wyvk6nz8JnPbMksY9
 tQcwMCs+e4lBLETRdzxOSlViiob55aevqxlvK6JogW8Evrv/bSkGeKc
X-Mailer: b4 0.12.3
Message-ID: <20231010-strncpy-drivers-net-ethernet-intel-igb-igb_main-c-v1-1-d796234a8abf@google.com>
Subject: [PATCH] igb: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
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

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231010-strncpy-drivers-net-ethernet-intel-igb-igb_main-c-b259e3f289d3

Best regards,
--
Justin Stitt <justinstitt@google.com>

