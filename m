Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F287875CAB6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGUOyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjGUOyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:54:36 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7AB121;
        Fri, 21 Jul 2023 07:54:35 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b74310566cso30586561fa.2;
        Fri, 21 Jul 2023 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689951273; x=1690556073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p18D6PEGwHZfci/zN2/shTnhQCgmj3XJsAK+DBdady0=;
        b=LeZFMEyzNH2rUW5qlERk7OHgFC4JT7udCzLCdY8GulHU5guy0npYZDiRCcOlRH7oP1
         l3BcHD1cIrS5rEKu0r9mpTC0MZgBI9hmeo8YHgV/6Hh7Oy4bf/vx481R7C59OB9ysc39
         M6BuL5EmX+VeB+BgvayuBP5BGnbTVYVDYNOzrRyRwoSab2wh/iC9B6+/OMEYtiqSDAGk
         h+B2DXX5K0hjEKuuJRed/wTkjb5Dw/jXM3sXVJVJj1zhOQCJIfgeXxfwfxjsefqBq2je
         QxBGEDt2wlS6Hoz1KnVaymJsD1UOP6HL7lwMPki+9BPGwAciU5zX2Rnqmkblx5DX2awW
         tg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689951273; x=1690556073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p18D6PEGwHZfci/zN2/shTnhQCgmj3XJsAK+DBdady0=;
        b=jeGkWADlUond2CuQoXG50xPR50vmvtwDO7OuAIR2T/AdUr0ZLTODmMwQSJr5XzRKTg
         jDMik3G906T4yCoi+isBjKc2MNlIA+FENid9JErVY/D5PLvCuqFz+hX2JMXSDNxS9Hrd
         tvUv9cBLjLI3ZB2BSZTGmzdrDexAMZDPPVbveAfKiVk9bQvtnzVPsCfY2CY4iq0ETXA3
         0TQE+ehED+QyID1Q8bQ89k8ahqcn8c4L/p7Swk8ae4gsxAR8V7um4T9WibhUNQ/NpFQc
         OYRPQZoSS48Cu/hB+YvuUdEaQ1XdqxOCxCaPi0yVcukpFH0JoUZ5Rx4SZHygCElUYwrW
         5IRg==
X-Gm-Message-State: ABy/qLaV9kqx84YTjqFiLzDHvcVn+f7Rb69u7jho7+KLedf4wd8++Vt8
        +Qmk168H12VzBtn5jMSuDg0=
X-Google-Smtp-Source: APBJJlEVSQIHS57WY/7masMQAjH951ZCqyx4T5TCZWNHS5UBtWWegZfR2Duqzr2C8ATT77X2h3Mr0g==
X-Received: by 2002:a2e:8810:0:b0:2b6:a057:8098 with SMTP id x16-20020a2e8810000000b002b6a0578098mr1745920ljh.0.1689951273335;
        Fri, 21 Jul 2023 07:54:33 -0700 (PDT)
Received: from localhost ([95.214.234.139])
        by smtp.gmail.com with ESMTPSA id l12-20020a05651c10cc00b002b6b60c14besm968554ljn.29.2023.07.21.07.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 07:54:32 -0700 (PDT)
From:   Maxim Mikityanskiy <maxtram95@gmail.com>
To:     "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Matthew Garrett <matthew.garrett@nebula.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Mikityanskiy <maxtram95@gmail.com>
Subject: [PATCH] platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100
Date:   Fri, 21 Jul 2023 17:54:23 +0300
Message-ID: <20230721145423.161057-1-maxtram95@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the HW rfkill state is toggled on laptops with quirks->ec_read_only
(so far only MSI Wind U90/U100). There are, however, a few issues with
the implementation:

1. The initial HW state is always unblocked, regardless of the actual
   state on boot, because msi_init_rfkill only sets the SW state,
   regardless of ec_read_only.

2. The initial SW state corresponds to the actual state on boot, but it
   can't be changed afterwards, because set_device_state returns
   -EOPNOTSUPP. It confuses the userspace, making Wi-Fi and/or Bluetooth
   unusable if it was blocked on boot, and breaking the airplane mode if
   the rfkill was unblocked on boot.

Address the above issues by properly initializing the HW state on
ec_read_only laptops and by allowing the userspace to toggle the SW
state. Don't set the SW state ourselves and let the userspace fully
control it. Toggling the SW state is a no-op, however, it allows the
userspace to properly toggle the airplane mode. The actual SW radio
disablement is handled by the corresponding rtl818x_pci and btusb
drivers that have their own rfkills.

Tested on MSI Wind U100 Plus, BIOS ver 1.0G, EC ver 130.

Fixes: 0816392b97d4 ("msi-laptop: merge quirk tables to one")
Fixes: 0de6575ad0a8 ("msi-laptop: Add MSI Wind U90/U100 support")
Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
---
 drivers/platform/x86/msi-laptop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/msi-laptop.c b/drivers/platform/x86/msi-laptop.c
index 6b18ec543ac3..f4c6c36e05a5 100644
--- a/drivers/platform/x86/msi-laptop.c
+++ b/drivers/platform/x86/msi-laptop.c
@@ -208,7 +208,7 @@ static ssize_t set_device_state(const char *buf, size_t count, u8 mask)
 		return -EINVAL;
 
 	if (quirks->ec_read_only)
-		return -EOPNOTSUPP;
+		return 0;
 
 	/* read current device state */
 	result = ec_read(MSI_STANDARD_EC_COMMAND_ADDRESS, &rdata);
@@ -838,15 +838,15 @@ static bool msi_laptop_i8042_filter(unsigned char data, unsigned char str,
 static void msi_init_rfkill(struct work_struct *ignored)
 {
 	if (rfk_wlan) {
-		rfkill_set_sw_state(rfk_wlan, !wlan_s);
+		msi_rfkill_set_state(rfk_wlan, !wlan_s);
 		rfkill_wlan_set(NULL, !wlan_s);
 	}
 	if (rfk_bluetooth) {
-		rfkill_set_sw_state(rfk_bluetooth, !bluetooth_s);
+		msi_rfkill_set_state(rfk_bluetooth, !bluetooth_s);
 		rfkill_bluetooth_set(NULL, !bluetooth_s);
 	}
 	if (rfk_threeg) {
-		rfkill_set_sw_state(rfk_threeg, !threeg_s);
+		msi_rfkill_set_state(rfk_threeg, !threeg_s);
 		rfkill_threeg_set(NULL, !threeg_s);
 	}
 }
-- 
2.41.0

