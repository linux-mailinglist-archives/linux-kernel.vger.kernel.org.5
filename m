Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B21D7A364E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbjIQP2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjIQP12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:27:28 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F05A188;
        Sun, 17 Sep 2023 08:27:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-404573e6c8fso36714015e9.1;
        Sun, 17 Sep 2023 08:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694964441; x=1695569241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3y8c1achGK+WQ5g0X4obcawzUgKoXn6NXo4Tvawvo4=;
        b=CctofdMvKInfUHMp8wksY8ygDmJKGvzGshQ4iLysJSoFvv9LXkexqJOjtoxBgffCNh
         RiYvgGNDlKl4AuiLWoTx0ZE9DH1uylh1phz2QAgTndpLybB9DQK8u09AlkRVc2SfmWAd
         89b3QGg0U4oZXN13tHycrFDupTt4STrBEhC1X8VZhq9/YGJtvuFuw+MTquF1Ok5Ed6Ee
         WCs9a64eDFmMOLvHQ9W0cApg558aY6bKlxWEQ9Xt29JV++oCX75vAnK5pu3k0AjevBZT
         l/zQnGa2GM4lAtWpT9FBj4wqxVvjdh5Nv+yTCLarxquKagaFmdvaUeSNBxn0ipmI5IOH
         02kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694964441; x=1695569241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3y8c1achGK+WQ5g0X4obcawzUgKoXn6NXo4Tvawvo4=;
        b=QhnhpUryitCjJUfcmODxzt8PpWU61XNJfO27D57rqRnqJEKNnAw45qJVmfkMxtRs+e
         bfchqLK0KhuKpP9qpmXp5Y+DicShDo5MqoQ02++4HftI78q9b/GpSY2D7G2aB6LKYhc5
         z4yT3LqVrfPYodMqJLmiCOPrY0R38riQCIkiFulv1o/399FVZFbnVSHDa+Yyt6DUDPGE
         75Ki1CKlNoPedwBPpkmuYNjuDQKSoH0uoIjM25xMpgPe+E438Xs9s9SrXIkDeJVmtFOR
         56mhkIT291Q3Uueqclkz07tkBX7+jSHMenjXCi265KOW988arSwjwR7svqBlUJ/e8MvP
         q9SA==
X-Gm-Message-State: AOJu0YwUNotOW08KxsynRm8NNyCa+Amcp3q+mKM8zR7i0Q3Kw4YhrJ70
        pDiazBDTszjMg42O3l1VSxA=
X-Google-Smtp-Source: AGHT+IGko7b9aR5sWDMm6H18nBCRxP4mO2QkcpzdwsQ27qTAHPfZm8aZZ0pGm5eyyZXvPOzhlRjw+w==
X-Received: by 2002:a1c:ed10:0:b0:401:daf2:2737 with SMTP id l16-20020a1ced10000000b00401daf22737mr6521093wmh.30.1694964440875;
        Sun, 17 Sep 2023 08:27:20 -0700 (PDT)
Received: from localhost.localdomain ([5.45.134.53])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c489700b003fe15ac0934sm7388865wmp.1.2023.09.17.08.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:27:20 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com, Abdel Alkuor <alkuor@gmail.com>
Subject: [PATCH v5 02/15] USB: typec: Add cmd timeout and response delay
Date:   Sun, 17 Sep 2023 11:26:26 -0400
Message-Id: <20230917152639.21443-3-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230917152639.21443-1-alkuor@gmail.com>
References: <20230917152639.21443-1-alkuor@gmail.com>
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

Some commands in tps25750 take longer than 1 second
to complete, and some responses need some delay before
the result becomes available.

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
 drivers/usb/typec/tipd/core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 37b56ce75f39..a8aee4e1aeba 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -284,7 +284,8 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
 
 static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
 			     size_t in_len, u8 *in_data,
-			     size_t out_len, u8 *out_data)
+			     size_t out_len, u8 *out_data,
+			     u32 cmd_timeout_ms, u32 res_delay_ms)
 {
 	unsigned long timeout;
 	u32 val;
@@ -307,8 +308,7 @@ static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
 	if (ret < 0)
 		return ret;
 
-	/* XXX: Using 1s for now, but it may not be enough for every command. */
-	timeout = jiffies + msecs_to_jiffies(1000);
+	timeout = jiffies + msecs_to_jiffies(cmd_timeout_ms);
 
 	do {
 		ret = tps6598x_read32(tps, TPS_REG_CMD1, &val);
@@ -321,6 +321,9 @@ static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
 			return -ETIMEDOUT;
 	} while (val);
 
+	/* some commands require delay for the result to be available */
+	mdelay(res_delay_ms);
+
 	if (out_len) {
 		ret = tps6598x_block_read(tps, TPS_REG_DATA1,
 					  out_data, out_len);
@@ -354,7 +357,7 @@ static int tps6598x_dr_set(struct typec_port *port, enum typec_data_role role)
 
 	mutex_lock(&tps->lock);
 
-	ret = tps6598x_exec_cmd(tps, cmd, 0, NULL, 0, NULL);
+	ret = tps6598x_exec_cmd(tps, cmd, 0, NULL, 0, NULL, 1000, 0);
 	if (ret)
 		goto out_unlock;
 
@@ -384,7 +387,7 @@ static int tps6598x_pr_set(struct typec_port *port, enum typec_role role)
 
 	mutex_lock(&tps->lock);
 
-	ret = tps6598x_exec_cmd(tps, cmd, 0, NULL, 0, NULL);
+	ret = tps6598x_exec_cmd(tps, cmd, 0, NULL, 0, NULL, 1000, 0);
 	if (ret)
 		goto out_unlock;
 
@@ -654,7 +657,10 @@ static int cd321x_switch_power_state(struct tps6598x *tps, u8 target_state)
 	if (state == target_state)
 		return 0;
 
-	ret = tps6598x_exec_cmd(tps, "SSPS", sizeof(u8), &target_state, 0, NULL);
+	ret = tps6598x_exec_cmd(tps, "SSPS",
+				sizeof(u8), &target_state,
+				0, NULL,
+				1000, 0);
 	if (ret)
 		return ret;
 
-- 
2.34.1

