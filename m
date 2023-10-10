Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A557C422E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjJJVPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbjJJVPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:15:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3917594
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:15:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a61f7aaf8so1417172276.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696972540; x=1697577340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=inAfHUFES32Bj4C70GcKsE711OPK+t9RMjXtNQ5VszM=;
        b=OFwT5hzx701CknF/AANYsdyGw6qzpWUZE+ZSQAT0kcVyFNQ0GkGtzp8zYWa+f9d0tM
         S++c9qb12muBlIC8UWne3c8pegtAvr9BLz7oaY7z54Mjny8duoAZmgTi6KYScJSD85gJ
         n2/iG4w9osWjs4oLszpbl6kAoDCUr2hlwclwtURYrHfK4Maz8RQDtLzDd1EM9KcGQocD
         JvB2fvQp+QRKCXSIFP8KrInMZ6AdfnNBBcKAO52cyAoaP7bZ8oxBgxSbhhA90sD608Ha
         zK3LvttMWQ/uNFLnj57Y90agTZMyU71YJrYFPjx1jYJiChHUNOM9inckgMEfp6FMgARk
         Y1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696972540; x=1697577340;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=inAfHUFES32Bj4C70GcKsE711OPK+t9RMjXtNQ5VszM=;
        b=kfgs98/pmMPuDlaBWNQ3/gw3/Vv2SD918UUk54yQPzYPzMQqfVcYkbOVZobETByGw+
         G1tzmcX6Lqn3YknVxCc1HR8Hq9hpxY/P8Wl70aEWkG8OQO98+xyuw8/BmXJZN4azmkHb
         sNG+tXLmob6r4cgQWce2FrXjBzHVoWNdUXhktoSQTDytNoapaH/lVC7sn+4kZoJ7YQYh
         d8NTCU7WVcp4fLw03stMn2GZcJ/zNqzyZb2SbFX78e+gzqO89prve5pOG9kdiUMcKiWX
         JYniHE2GLshtfh4zUxa4ldMa7Ra6xsMAitGNS3i6hEoWODv6mtRBjxmFKWChqJyJT21j
         A5qw==
X-Gm-Message-State: AOJu0YyBf1u8zPFJ5LJMRAs2m1x3yzn/rDy+/i40bAAK56bWHKM1KuDI
        4qTokLcWQk3PY1CT2Aw8WC6xp+eIdrvmOS3iVg==
X-Google-Smtp-Source: AGHT+IEMUv1TTDgqzDOYIq+Sw2rvHfs+0t2AabsWyLXy1VIOnuqASlfBZBLu9OJtzGdOmIIJ59zdUH9JxiXKqaoZ5g==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ac24:0:b0:d9a:3596:a5e8 with SMTP
 id w36-20020a25ac24000000b00d9a3596a5e8mr87331ybi.7.1696972540475; Tue, 10
 Oct 2023 14:15:40 -0700 (PDT)
Date:   Tue, 10 Oct 2023 21:15:39 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPq+JWUC/x2N0QrCMBAEf6XcswdJREF/RURism0P9CyXUCql/
 27qw8DOy85KBSYodO1WMsxS5KNN/KGjNEYdwJKbU3Dh6J13XKppmr6cTWZYYUVl1BG2D9GKF8u Qdh7vKMqJwxl9DO6S8/NE7Xcy9LL8m7f7tv0AuewH3oMAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696972539; l=2229;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=aszC9coJ3ufDFemnzGBEFSljINDMKfOjEfDt2TlDPEA=; b=M0LjBlQz4apy3gyX2tH8Osydptr9lDj/JzxqU4f3aGIPfDCpy48DUAn7/iUFhpQnXafN44Mnu
 3bQ5fcJIVvbBVvaS1GZ/qGz8AcdS1uPFdCrtmQC0/k/kBHxCMuKuJiG
X-Mailer: b4 0.12.3
Message-ID: <20231010-strncpy-drivers-net-ethernet-intel-igc-igc_main-c-v1-1-f1f507ecc476@google.com>
Subject: [PATCH] igc: replace deprecated strncpy with strscpy
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

We expect netdev->name to be NUL-terminated based on its use with format
strings:
|       if (q_vector->rx.ring && q_vector->tx.ring)
|               sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,

Furthermore, we do not need NUL-padding as netdev is already
zero-allocated:
|       netdev = alloc_etherdev_mq(sizeof(struct igc_adapter),
|                                  IGC_MAX_TX_QUEUES);
...
alloc_etherdev() -> alloc_etherdev_mq() -> alloc_etherdev_mqs() ->
alloc_netdev_mqs() ...
|       p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also opt for the more idiomatic strscpy usage of (dest, src,
sizeof(dest)) instead of (dest, src, SOME_LEN).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 98de34d0ce07..e9bb403bbacf 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6935,7 +6935,7 @@ static int igc_probe(struct pci_dev *pdev,
 	 */
 	igc_get_hw_control(adapter);
 
-	strncpy(netdev->name, "eth%d", IFNAMSIZ);
+	strscpy(netdev->name, "eth%d", sizeof(netdev->name));
 	err = register_netdev(netdev);
 	if (err)
 		goto err_register;

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231010-strncpy-drivers-net-ethernet-intel-igc-igc_main-c-26efa209ddb5

Best regards,
--
Justin Stitt <justinstitt@google.com>

