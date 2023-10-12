Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB98E7C7859
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442780AbjJLVFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344156AbjJLVFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:05:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C6CA9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:05:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d86dac81f8fso1998067276.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697144741; x=1697749541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9oP1I5+6soWcUdUsGpPJJ1MkksTpN6au5vjlY6dm6ew=;
        b=FL4WKoDfrNzUfF5xOsMB0jsP+qN7hxQ4Bn/JloeAIva4CPC5+7u8qttj2yP6lqCKN7
         pRM6kM7gcArQWUleJWvgxSEBZgwy9oUAqIuaIsY/54xKKQFOc8WUp6f5Fo4qtzqfmyCV
         ko0pKKj8Z7PultN256DASij0HpWE5/ewhZkcrb88lVMQuwHLHJE9SKI1S52zGvh5V8Ce
         MN93sQ3ytzi1iMJwG04qV6n1PQPawcclrFYxtHlqiyVcVplhItx4uBOTY7nNNb3SM3PC
         etPmvSyK/sle7U2VABVYgeMCVBlMFE+epS+lyAMaklpT86JLAAea2ACovcZACkZANXbi
         IZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697144741; x=1697749541;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9oP1I5+6soWcUdUsGpPJJ1MkksTpN6au5vjlY6dm6ew=;
        b=jsrfzdlKZpoDwVnKY27enovccb2bphPrPZdMGTvEjGuZq11gGjg3Qsk3KkdD6Y7fDI
         S8m6YLi+g+0/iYXfQF8MlRLvCmPKb53zw56OV4E7HHczepY+XCfSafjPEpxBqLy9pE6A
         ziD7NqkWcMNdrzENeoiMYT/ZL57eWxB2/CFP7Qf8WwNyat1Pyz8VWemamXN5Cfj39bJp
         so4bRw1JLGK9HRXbLQPSeAAMVO0WClt4o446THzr1RS5EbQoEoX5Gpn0gjvuyFLju9SF
         1c01JLHdK+qq3H9Ara+eRqjWlPXzPh4DNnmvIiMZYVmm8DneHE4Klaop4raf1JjahosT
         oOyA==
X-Gm-Message-State: AOJu0YwDqLBlZV96wZ4SNztX7uBHkoCbgU/HXYfuLnQAKMK1z3jpFJ8P
        s4u+MbffncjUTp5cCsAHEpicJgxyKYymqzd2YQ==
X-Google-Smtp-Source: AGHT+IF+Mw9425usSnUzeclQbBybIwQGa7QUGOCHES6UcpiCEFJFOmGud0Uoi8h3hGdXHqB12Frgbi79XkvtIU7AQA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:4a9:b0:d9a:4c45:cfd0 with
 SMTP id r9-20020a05690204a900b00d9a4c45cfd0mr192649ybs.2.1697144741041; Thu,
 12 Oct 2023 14:05:41 -0700 (PDT)
Date:   Thu, 12 Oct 2023 21:05:40 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKNfKGUC/x3NzQqDQAwE4FeRnBvYH0Tpq5RSJEbNZV2SRSriu
 7t6m28OMwcYq7DBuzlAeROTNVX4VwO0DGlmlLEaggvROx/QiibKO44qG6th4oJcFtY7FLlN+Vc bMySMrh3a2HeRJoK6mZUn+T9/n+95XhC8cMN/AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697144739; l=2331;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=x/31VF0rLVNABMGyii39oVifDyB7uVtgS7xEolZ5yEo=; b=yfIEANn3f5HuZXL0PZLHgFcd1H8NeT0NZngBT+amfYdzZCLwoLOmXx7VYz2PwhUYgQ2e4arJx
 4p9sHq8QdmSA/QPh6cM04BI9frRlWD0J/j144CQAbvbgCs+oa+XI86u
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-ethernet-ti-netcp_ethss-c-v1-1-93142e620864@google.com>
Subject: [PATCH] net: netcp: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Other implementations of .*get_drvinfo also use strscpy so this patch
brings keystone_get_drvinfo() in line as well:

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

Found with: $ rg "strncpy\("
---
 drivers/net/ethernet/ti/netcp_ethss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 2adf82a32bf6..02cb6474f6dc 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -1735,8 +1735,8 @@ static const struct netcp_ethtool_stat xgbe10_et_stats[] = {
 static void keystone_get_drvinfo(struct net_device *ndev,
 				 struct ethtool_drvinfo *info)
 {
-	strncpy(info->driver, NETCP_DRIVER_NAME, sizeof(info->driver));
-	strncpy(info->version, NETCP_DRIVER_VERSION, sizeof(info->version));
+	strscpy(info->driver, NETCP_DRIVER_NAME, sizeof(info->driver));
+	strscpy(info->version, NETCP_DRIVER_VERSION, sizeof(info->version));
 }
 
 static u32 keystone_get_msglevel(struct net_device *ndev)

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-ethernet-ti-netcp_ethss-c-305a53873cfc

Best regards,
--
Justin Stitt <justinstitt@google.com>

