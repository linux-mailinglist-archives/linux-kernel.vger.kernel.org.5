Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBF27C43FA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbjJJW10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbjJJW1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:27:12 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6291A10F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:27:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d918aef0d0dso8654246276.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696976829; x=1697581629; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lTnwaqL2jLBaxkmW2WMaRMaHCldHf8+/MXLc/TIFT4c=;
        b=HaXYx2MHjD9Ln9m2JeqtU5jOiYeAa5LVO/a7+aRBVUcBVGti0k/pnWDJrS9TTGt2Eb
         6jyB2MOw64gG1EYLLODJlEbdJjJdGmi2CHrTsgq/BLUfmI/EDeIJBVhNGh+jNDv3T7wf
         scwzc1yNRQTAwBs57Gp2roWdL4onWVEWuSOewIzmQu1B7vzmo0DGtnCrwJQOgxJ2w/Rz
         kLdy972tJFimWH4+R8sAdPUkghl/fnPLdEOESBTXoHNRGSBvmUY4sPEDU97CyiWGqEqk
         55KUWlw1/KLqaqghQWvvD+TV/NCnxFP6GsVt9p1mzr6Kj9PKuklNiazCRy6BoZ52+GST
         jtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696976829; x=1697581629;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTnwaqL2jLBaxkmW2WMaRMaHCldHf8+/MXLc/TIFT4c=;
        b=iK4p3zm1VxsxLt3fax6F/RAhOt3BPMMGYQw7FzHwBc8gSt1eG2kXTHC8Hq+GM3OUQ4
         gnDre137jMkAbyyAS6V8z+NtOyPAH0JNFNu2ucGjkd4iexMFxm/AVq3jT2pkiOyGGALU
         pQd40JtZZXqvOr225oqvCGpyJFpWaBsZNzdgSwwgVCWl2N9iemccDsm2YOEF5W6VcOk7
         nC2m2DbBciJjesY9rLqvdAtnvfjc5nrQizPzTLZHg4ltIL5slTc5JMp9l1Eoz4DXiohd
         PDja9ALEHGbcgNsaDIc+JyylAPLPcc49Bp8HMhG+KRZViP6YhpqyKuofG/GTpg95dVO5
         lKYA==
X-Gm-Message-State: AOJu0YyvajgEmnF4MoQCkzT3fgwGVU+ax8gZeSGOOauyzBKatMrPuALP
        ywqqNkqbGloEOtaFA2FyKQjx3R18j4jT7Xb3JQ==
X-Google-Smtp-Source: AGHT+IEhKRo7Fa50WHzFdWOO31BMGB9F9TmfVk9lGMD83bOfMPCZJRqBjhsWFbscP5Go+W8LBaXKuS+3ektW2jj+vA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:9349:0:b0:d80:12c:d49b with SMTP
 id g9-20020a259349000000b00d80012cd49bmr352222ybo.8.1696976829556; Tue, 10
 Oct 2023 15:27:09 -0700 (PDT)
Date:   Tue, 10 Oct 2023 22:26:56 +0000
In-Reply-To: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
Mime-Version: 1.0
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696976825; l=2155;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=OVZJsM7ldFpBAzherL0f3bvpgvacQBDrwKwi/3HnF5o=; b=VAP1FhD196P2wXpYtHTj+oub2FKXyLs035gJ11JD9BWHTobZWE7G6hG6hva6AMypTOMJugLLr
 iU1NTx0gyFVACLLcwaYcZNUqVriQ4UPkUi7BGHg/1QJ/x1taOIyXHl8
X-Mailer: b4 0.12.3
Message-ID: <20231010-netdev-replace-strncpy-resend-as-series-v1-3-caf9f0f2f021@google.com>
Subject: [PATCH v1 net-next 3/7] fm10k: replace deprecated strncpy with strscpy
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Other implementations of .*get_drvinfo also use strscpy so this patch
brings fm10k_get_drvinfo in line as well:

igb/igb_ethtool.c +851
static void igb_get_drvinfo(struct net_device *netdev,

igbvf/ethtool.c
167:static void igbvf_get_drvinfo(struct net_device *netdev,

i40e/i40e_ethtool.c
1999:static void i40e_get_drvinfo(struct net_device *netdev,

e1000/e1000_ethtool.c
529:static void e1000_get_drvinfo(struct net_device *netdev,

ixgbevf/ethtool.c
211:static void ixgbevf_get_drvinfo(struct net_device *netdev,

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>

---
Note: build-tested only.
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index d53369e30040..13a05604dcc0 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -448,10 +448,10 @@ static void fm10k_get_drvinfo(struct net_device *dev,
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
 
-	strncpy(info->driver, fm10k_driver_name,
-		sizeof(info->driver) - 1);
-	strncpy(info->bus_info, pci_name(interface->pdev),
-		sizeof(info->bus_info) - 1);
+	strscpy(info->driver, fm10k_driver_name,
+		sizeof(info->driver));
+	strscpy(info->bus_info, pci_name(interface->pdev),
+		sizeof(info->bus_info));
 }
 
 static void fm10k_get_pauseparam(struct net_device *dev,

-- 
2.42.0.609.gbb76f46606-goog

