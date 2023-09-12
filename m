Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D745F79C64F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjILFge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjILFg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:36:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE8DCCC;
        Mon, 11 Sep 2023 22:36:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-271b0a8e7ecso3459648a91.3;
        Mon, 11 Sep 2023 22:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694496985; x=1695101785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EC6DC2N23DWPNLHVQFVPgCN6nVNHhth6n3io/xw9+nQ=;
        b=QpELkG48TEJi3I6X0qHvEwirNtPASrXNenH7wMo4sL6YEcN2QaU9X38K2nQg+lpiSV
         txH/ijXNSC6GtvjN/GsN4BFvNGDOf8wkt+PlpPDfX7kIXCo36cJMU0tVViyhji3y+tde
         c4ptifbvpWq64pMs193NAEvvCoGhBdlJTnzYxHG/r0yvkxsvpeJpWXmSLm0+dzUR3vk5
         IIV5+sssuEwKxHxccRrgtcMGs1uxCvKQVIe3K8lyPvPPHbl6Gm0TNDVHC0YoeKykTcNU
         4IKWTgbVk6MpyhQYvXgpwu29cws1XKoB2sDODchh7i6zBHuR6fXx8PacWI43MTLbmoZY
         2HNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694496985; x=1695101785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EC6DC2N23DWPNLHVQFVPgCN6nVNHhth6n3io/xw9+nQ=;
        b=BXvWpdXuBQZ/E64dX30rOGDpNUbQZsC7kj2A2RMGPyhgGVfyZGHwjOJM2xeQ1yROH2
         WIXRPUhfadjDDx2Wh0tckPR1C+hoqn2xYDVE6EeS9qMkWaEV+1zUDBsjqyLyQXNQ+TIw
         FgWIMyeeMZCVK+eZavR0Byle/J1LDLzkoPwUDt4z8PjJCaeRu66FZ26QLHdjemm7oiXv
         AXE5vAiCSzVoxtWIShlX7i48DWDo4uE/Z0S+D7M2KEfh8dIBmet8MrdiDGNIsqfI2R6w
         nvoqEw6fALh8CZnz2Qj99BzKvhr61nKPeahXaoZ8ZSxtvtO26aH8pG3j/9MDc5kh9AJS
         yUFg==
X-Gm-Message-State: AOJu0YyLogrL4pAUaw+btvsvCabypGzImNEj70sDzTNrog16JphsqnTA
        uLBTtDfAtzwEF9upsOGvNV4=
X-Google-Smtp-Source: AGHT+IGp0ALSFvxxmTXrz/UXJkCYc8DWAIzfJv+bujBDncNqHaiLY9s6ZenJfixhlbBHUbybUgrWMQ==
X-Received: by 2002:a17:90a:e7c8:b0:274:1b8c:da01 with SMTP id kb8-20020a17090ae7c800b002741b8cda01mr3362145pjb.33.1694496984759;
        Mon, 11 Sep 2023 22:36:24 -0700 (PDT)
Received: from localhost.localdomain (220-133-92-191.hinet-ip.hinet.net. [220.133.92.191])
        by smtp.googlemail.com with ESMTPSA id m2-20020a17090a34c200b002680ef05c40sm1047609pjf.55.2023.09.11.22.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 22:36:24 -0700 (PDT)
From:   Zenm Chen <zenmchen@gmail.com>
To:     Jes.Sorensen@gmail.com
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, rtl8821cerfe2@gmail.com,
        Zenm Chen <zenmchen@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: Add a description about the device ID 0x7392:0xb722
Date:   Tue, 12 Sep 2023 13:36:14 +0800
Message-ID: <20230912053614.10644-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the driver provided by EDIMAX, the device ID
0x7392:0xb722 belongs to EDIMAX EW-7722UTn V3, so add a comment about this.

Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index d1bb605e8b54..43ee7592bc6e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7801,6 +7801,7 @@ static const struct usb_device_id dev_table[] = {
 /* Asus USB-N13 rev C1 */
 {USB_DEVICE_AND_INTERFACE_INFO(0x0b05, 0x18f1, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192fu_fops},
+/* EDIMAX EW-7722UTn V3 */
 {USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xb722, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192fu_fops},
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x318b, 0xff, 0xff, 0xff),
-- 
2.42.0

