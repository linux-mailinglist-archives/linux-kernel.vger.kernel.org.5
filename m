Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1947B3534
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjI2OcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjI2OcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:32:06 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D87610E3;
        Fri, 29 Sep 2023 07:32:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-533e7d127d4so13798352a12.3;
        Fri, 29 Sep 2023 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695997919; x=1696602719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGIQpTQvObysL6Oo7cgMHdezro1zF1YMMi1C0CmxddE=;
        b=h4h32S1Rap4pOQkBV1FUdUT4Rpuw5nKsBZh/MaQd3D4inrg2FUKKyF1M0efJM6pnRW
         +sx9BZ2Le8N3Kj2rgJ2F3A2FaUc9PHnood1R7Q/IAoowTYHroSW7Dp8faZ70E4F3a8ot
         +6d5xsAA1laPzuhfgO0pbrr2eTIT2DekAw92/Mryafgl+fmKbSuV+O0W7jHMkk+yijEC
         0bl52kB9ckbS89Bi6E+jEI3J9NdMfoxK5/PxWKEuRnMbxwHY0jizx4cb+po+W+eObz1q
         ug3Dhq3+tZjISsYF7DK7F31jHZtCarZhAU2YvgB1dSN0Is453ExZ8+W94IEP6TbH6Fh1
         OZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997919; x=1696602719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGIQpTQvObysL6Oo7cgMHdezro1zF1YMMi1C0CmxddE=;
        b=Ula2gjCGgn/ay+py+2rAginC9WiXFZ3ldXbysdBXLtRAw6YtgK3x9b/jJOPZS/pUPB
         mrWwENB259IC6qb/1HmLdsDPAi/cTlZ03vTgNAvgsbo8Dqjy011+UJ393gWH9sQ3cx/z
         RZcQ2knD4SkoVlcbPJ7Gk2GNeqxILrMypGACTeApV48FB5v/71WJEDBWYvKC6TYfO5iO
         02akYiIcbx1ao4+ZXewuO2iUCrtws3RX9xJ+EBCNRgZVjZE+k44kZjRrpdY76yv/xuX5
         LvmsWQwZgJ3b6iQa1L8zk+kMm7Mwv1aLgf/I66vfdFIUX3U5OFioVNydh+WOp8m3x3yw
         mDGA==
X-Gm-Message-State: AOJu0YyP4+3M8NFx1z3M9Opob+ysoP5VVVhmloNtrKCJw/+OCz9IkNXc
        tk9B+bILcgzOc+8EN9lkmOE=
X-Google-Smtp-Source: AGHT+IHy/fBJxhU8s/gRHcL71PosjiZ58hk6z+foLhkQqKqCAkfeR9RRunm2COKPl8r2SJvUdfRa1Q==
X-Received: by 2002:a17:906:53d9:b0:9ae:7611:99bb with SMTP id p25-20020a17090653d900b009ae761199bbmr4368551ejo.59.1695997918627;
        Fri, 29 Sep 2023 07:31:58 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b0099293cdbc98sm12660105ejp.145.2023.09.29.07.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:31:58 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v8 02/14] USB: typec: tsp6598x: Add cmd timeout and response delay
Date:   Fri, 29 Sep 2023 10:30:43 -0400
Message-Id: <20230929143055.31360-3-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929143055.31360-1-alkuor@gmail.com>
References: <20230929143055.31360-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

Some commands in tps25750 take longer than 1 second
to complete, and some responses need some delay before
the result becomes available.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v8:
  - Add Reviewed-by
Changes in v7:
  - Add driver name to commit subject 
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

