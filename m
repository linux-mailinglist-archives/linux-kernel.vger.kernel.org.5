Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4851F7ABE65
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjIWHkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjIWHkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:40:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2187199;
        Sat, 23 Sep 2023 00:40:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405505b07dfso5841065e9.0;
        Sat, 23 Sep 2023 00:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695454837; x=1696059637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZWmQQmneNrgo+uT9K5V7AmPeAEWKJEhNBsXkP/XAfI=;
        b=RyaFFldnJLF5ccfr/zjHocKQ8+Gt01VEDseNmbdQ3ZkRh7G3bzIi6MFO++dpmwFHS3
         G1SIyVoNz3OwVnS0tYWKH347XNYXatUcMro76kX+yMIBtnrWOh8bPewG9ELez8knM7XX
         FGGUEY9/K5PRvJJUaRF8OR5+L91UrIXVV/FcYIFv1zZ+U8gk6cZhYnQ7TS4HTGnFLsAf
         Xe0A5Su4MrKGih3T1Rxbj8kmLKVJ2h/IX7e7p3m0lc1sDBwSXRHJOgkEc+kV457Cwl5j
         AL/DwV7O7TkDE/7i90tKyRnGOJXNnBzyJ1mFBFbLGTWCckasqR3bZdhag8VQSxHxOgA3
         Parg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695454837; x=1696059637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZWmQQmneNrgo+uT9K5V7AmPeAEWKJEhNBsXkP/XAfI=;
        b=aiyMb3r9ae2BVEMH/bP5CtBfqGkwOGeG/jwWS6t/c524jLMVHtgGzC2wmpcTo6jShJ
         RoL5wFzPmjEzgDhWXG6LtFyIzoZdF/4q0IY38aWebZIBcfJE/E7rnINNxJuGVMfGtbh6
         SUiCXaKKMAfGu5bo24Ne0HN3ahZYwyfsMLQCmbLm61Yu91AlAWJJween0Pc7XgyUwZln
         wLGhNqCnoxKO7E9Aw1p8NMIRYqB8kumqfBULLsvqEDkEfYQwQh5oTjZq1XVaCk2oLgyY
         gSGPdBeqY4Lj3IxUMongJN6E1ewAQu5ucIEglyFOrgv0NtypmD+6zXRu5ENmTDTxfrcp
         3B0Q==
X-Gm-Message-State: AOJu0YwcfrVm5UB4D9A/WP10wsN7jAJjglPHULuXHaw4apgStbNc0MwS
        W0qAuy9oXaPvP4mHRvr81oA=
X-Google-Smtp-Source: AGHT+IF1v2ZNi/Wx6yyowKvu95y3tsBxhZvS365BBEpre4nG0UqIeZdBiFd+4hGK6Mb765SQiUL+DA==
X-Received: by 2002:a05:600c:450:b0:402:ebe1:7960 with SMTP id s16-20020a05600c045000b00402ebe17960mr1148778wmb.2.1695454837199;
        Sat, 23 Sep 2023 00:40:37 -0700 (PDT)
Received: from primary.. ([213.139.62.222])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe3c6000000b003196e992567sm6236955wrm.115.2023.09.23.00.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 00:40:36 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        ryan.eleceng@gmail.com, Abdel Alkuor <alkuor@gmail.com>
Subject: [PATCH v6 02/14] USB: typec: Add cmd timeout and response delay
Date:   Sat, 23 Sep 2023 03:39:47 -0400
Message-Id: <20230923073959.86660-3-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923073959.86660-1-alkuor@gmail.com>
References: <20230923073959.86660-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Changes in v6:
  - Use tps6598x_exec_cmd as a wrapper
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 37b56ce75f39..32420c61660d 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -282,9 +282,10 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
 	power_supply_changed(tps->psy);
 }
 
-static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
+static int tps6598x_exec_cmd_tmo(struct tps6598x *tps, const char *cmd,
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
@@ -345,6 +348,14 @@ static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
 	return 0;
 }
 
+static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
+			     size_t in_len, u8 *in_data,
+			     size_t out_len, u8 *out_data)
+{
+	return tps6598x_exec_cmd_tmo(tps, cmd, in_len, in_data,
+				     out_len, out_data, 1000, 0);
+}
+
 static int tps6598x_dr_set(struct typec_port *port, enum typec_data_role role)
 {
 	const char *cmd = (role == TYPEC_DEVICE) ? "SWUF" : "SWDF";
-- 
2.34.1

