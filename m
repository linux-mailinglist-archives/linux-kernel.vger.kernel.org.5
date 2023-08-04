Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFFD770BCC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjHDWON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjHDWOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:14:09 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EC510E6;
        Fri,  4 Aug 2023 15:14:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bb775625e2so18030885ad.1;
        Fri, 04 Aug 2023 15:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691187248; x=1691792048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MCGHoL2HjRolVuFapg3wsPgWGn6Us8frIVMV2s7TjRc=;
        b=KJuxSQEet6lhAZGrG3E4EvZX6ZzngqJFC6Ki8ROPd7mhXl0F0n5pe+KfowTbHmaTtL
         32VrPt1d4uMvtpw5xE/wtzsL6vdWVrqOZ5oWwZxtsQN13xmPDjrbrtUndq+Q2eoEduVg
         x0RbNfOQv919oqujt1hHMTWcOOfAOMsvTyKadqA/N2Whqor699+oosRa5aJoCMMtse+u
         NTGHMuMi0qM50DQFSjaOiblP4HKtHjUTRHGz6ysUPrMebokhR1r+2nZosTuEp8i/yUX9
         OC7Fjamf4ACuvC8lAg+jmaDvQA+jECCU5IRLVkUFu6cJII0Q1MuOcczU2vTbtuxEw72r
         /Z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691187248; x=1691792048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MCGHoL2HjRolVuFapg3wsPgWGn6Us8frIVMV2s7TjRc=;
        b=kNLi38hlffZFI17i2RxIcc7a+qYxbxZgU2NU+ndrZDoe4TWL7eFz1xxr4MKQflMb52
         4pSXQcJnH+7K8r2CB8nLfBjxaLz4E5aoqkZwuPrfzBA+nKDNhTCLUGQbuTH8rjEiN2R3
         p6qKhKBxDdEDQjNyIw13I/tFGp2lDTocIMutooMlkVSAsifx2ZfKO3nHcwu7VU9+TE8g
         RtzyhSZYK0OV2JcMVfKPjgT15+QDmXuL2cw7AXycYdfR3kYDIxa2Z77pbzSPLC5UDxBm
         us0/6iAGXX1y70iyl5NsrlNlzICVn8+qWVCeqXIF4CrAXBm6ZraXjtoUHV53sM2T7z3T
         1BDg==
X-Gm-Message-State: AOJu0Yyym/pE8keMjcA81pVCQZMiUtCZb36bomNPdMA4Hdiy+0mqrvxn
        QDg9cKONO+lIAXohsg9DaJU=
X-Google-Smtp-Source: AGHT+IHpZr8hkqGA/na6UMgvLi389VBGghzRz3wYbvUQ10fblHgNqUIctgg0/EP6D+NZh77CEhhTxw==
X-Received: by 2002:a17:902:c211:b0:1b6:783d:9ba7 with SMTP id 17-20020a170902c21100b001b6783d9ba7mr947360pll.27.1691187248329;
        Fri, 04 Aug 2023 15:14:08 -0700 (PDT)
Received: from localhost.localdomain ([76.132.59.39])
        by smtp.gmail.com with ESMTPSA id m14-20020a170902db0e00b001a6f7744a27sm2229235plx.87.2023.08.04.15.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 15:14:07 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, taoren@meta.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2] hwmon: (pmbus/bel-pfe) Enable PMBUS_SKIP_STATUS_CHECK for pfe1100
Date:   Fri,  4 Aug 2023 15:14:03 -0700
Message-Id: <20230804221403.28931-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Skip status check for both pfe1100 and pfe3000 because the communication
error is also observed on pfe1100 devices.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
   - improving comments.
   - removing unnecessary {}

 drivers/hwmon/pmbus/bel-pfe.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pmbus/bel-pfe.c b/drivers/hwmon/pmbus/bel-pfe.c
index fa5070ae26bc..7c5f4b10a7c1 100644
--- a/drivers/hwmon/pmbus/bel-pfe.c
+++ b/drivers/hwmon/pmbus/bel-pfe.c
@@ -17,12 +17,13 @@
 enum chips {pfe1100, pfe3000};
 
 /*
- * Disable status check for pfe3000 devices, because some devices report
- * communication error (invalid command) for VOUT_MODE command (0x20)
- * although correct VOUT_MODE (0x16) is returned: it leads to incorrect
- * exponent in linear mode.
+ * Disable status check because some devices report communication error
+ * (invalid command) for VOUT_MODE command (0x20) although the correct
+ * VOUT_MODE (0x16) is returned: it leads to incorrect exponent in linear
+ * mode.
+ * This affects both pfe3000 and pfe1100.
  */
-static struct pmbus_platform_data pfe3000_plat_data = {
+static struct pmbus_platform_data pfe_plat_data = {
 	.flags = PMBUS_SKIP_STATUS_CHECK,
 };
 
@@ -94,16 +95,15 @@ static int pfe_pmbus_probe(struct i2c_client *client)
 	int model;
 
 	model = (int)i2c_match_id(pfe_device_id, client)->driver_data;
+	client->dev.platform_data = &pfe_plat_data;
 
 	/*
 	 * PFE3000-12-069RA devices may not stay in page 0 during device
 	 * probe which leads to probe failure (read status word failed).
 	 * So let's set the device to page 0 at the beginning.
 	 */
-	if (model == pfe3000) {
-		client->dev.platform_data = &pfe3000_plat_data;
+	if (model == pfe3000)
 		i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
-	}
 
 	return pmbus_do_probe(client, &pfe_driver_info[model]);
 }
-- 
2.40.1

