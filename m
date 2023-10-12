Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E9D7C797D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443006AbjJLWa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443014AbjJLWa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:30:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6BCDC
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:30:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a509861acso1951802276.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697149855; x=1697754655; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rizs44+83M1Yv3Y7Tz35EZFb6rX3ufgnc6hvuYWPAQA=;
        b=BbJ3txwMvDd7M4UKTgvyRCRHEBi90MSZAP14YjDXT+vjcrBKHDLRmhOcIfMGEfsTMA
         ZpcqG2M9PWNXdAf+sKsebnrIpKgpSJI2WS8EvdKG1jp+HHseXOlH5y3gux5budT7wuSF
         a3ryjUu3kSoYUkz66BK5VxsS+QM8R+GYLi9IRtIXuMzz4FO51T48+sxgVSAd/kUSxLs6
         XCNkNbAefeYVD4Pzel/GkitZM6d+3w24TIXH0lmUtnvtapwAcDB7VoiiYpMKbhnjRax/
         G1xizao6qaheTEEiTOyzyvIO/SiHeWsxYRQ4llawVjaGqwtczbKW/p7vmujybI1qBykm
         JoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149855; x=1697754655;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rizs44+83M1Yv3Y7Tz35EZFb6rX3ufgnc6hvuYWPAQA=;
        b=fQqwLJmmhPkrQC1rL6eaJkAPMnuatODSYykQ5IP709zAcBYWK7gKey6VgQbOIlTSnn
         +OXDX/Sk3lj46FTNA+/vC9JVbSzhe99vOpiUFxCc7zYXnjiceBld1lj3tz7OyDbxU0bb
         Oxp5IqOSNXrI+Mg4jFmIDJFqhnHD6a0s0kpatJ/lyMhSUBmukeJ6cZpMM03ZE+ZcuVdc
         uBJhTYtVT/ypt6jOlNEV9olGD0TARHtUbLG+wwNLTkGJ6nZSFwZwnbzOgG7GIrCzsTcx
         8R9+M6dConbaie0dxLMOO9MWZNyFaN4iY9AAXCTJwqs1t20B+sgbqw4eLSjUYbGMc82r
         6ypA==
X-Gm-Message-State: AOJu0YwcK00BEEzJE/SVXAvnbys02RePNKGgFfl5LwMapBhwYd6tIRCv
        ba3JmE2taeRbermQeSmIPWNXnf3BRwW8JfVexA==
X-Google-Smtp-Source: AGHT+IEyJi+6aR4m8VCk9B1FVnsRZVbIeTZO5xWLf+zSzEab3f9/rvhauXqUE1a1ekH3cBluonY+I8G/UdZO0ZIl3A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ef4c:0:b0:d9a:6633:a799 with SMTP
 id w12-20020a25ef4c000000b00d9a6633a799mr181229ybm.13.1697149854993; Thu, 12
 Oct 2023 15:30:54 -0700 (PDT)
Date:   Thu, 12 Oct 2023 22:30:54 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ1zKGUC/x3NTQqDQAxA4atI1g3MT6G2VyldTMeMBiSVRGWKe
 PcOXX6b9w4wUiaDR3eA0s7GH2nwlw7ylGQk5KEZggvROx/QVpW8fHFQ3kkNhVbc7I1zkltfK2Y s/n6NkcgVl6B1FqXC9f94vs7zB+QO05VzAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697149854; l=1788;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Q/1jnaD/aLB5yEOg0SnHWnlmWben+eHo3uTy3iuBQAU=; b=ddxVrViH6Mz9J+19fMq1qOkfWAGORwS3qksqgHG/khfZO5dItcJoGVoGPXwxYvfTsC69cmRPu
 fxom8MzxhspBbWX2KdeKk0vDJwAJA773DmNslhYSz0ZYxxrjAnEt60Q
X-Mailer: b4 0.12.3
Message-ID: <20231012-strncpy-drivers-net-usb-lan78xx-c-v1-1-99d513061dfc@google.com>
Subject: [PATCH] lan78xx: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
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

Other implementations of .*get_drvinfo use strscpy so this patch brings
lan78xx_get_drvinfo() in line as well:

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
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/usb/lan78xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 59cde06aa7f6..5add4145d9fc 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1758,7 +1758,7 @@ static void lan78xx_get_drvinfo(struct net_device *net,
 {
 	struct lan78xx_net *dev = netdev_priv(net);
 
-	strncpy(info->driver, DRIVER_NAME, sizeof(info->driver));
+	strscpy(info->driver, DRIVER_NAME, sizeof(info->driver));
 	usb_make_path(dev->udev, info->bus_info, sizeof(info->bus_info));
 }
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231012-strncpy-drivers-net-usb-lan78xx-c-f19433ee0f0a

Best regards,
--
Justin Stitt <justinstitt@google.com>

