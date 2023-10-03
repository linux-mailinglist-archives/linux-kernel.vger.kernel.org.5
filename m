Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4E37B6DD0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbjJCQBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240209AbjJCQA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:00:56 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B4ED7;
        Tue,  3 Oct 2023 09:00:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9adb9fa7200so237147266b.0;
        Tue, 03 Oct 2023 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696348851; x=1696953651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FvVCrqOKh6HKC+bZxE5jYuqFOTddVesEzvzag91z+o=;
        b=H4fYLDJpSzS3ZnfKkMzl4GNG+XdRVq0tPvGi7ziTqTT4YVgAbQVRj4uASv2FFA6Zyw
         nCCZvI40zCjwCU/KP1FHLnQ9Gl8EMD0ZD8j8w4c/7gKz1otxGyokcU8KRyq35JBHooPY
         jo0kSOtAaHTGr1iWJKQRs7WR9pCE8EfuxyhK4A221558glQxU2Ogxc45wHqZMOSTWm/3
         /f3cuAeozbETSgFCVTaKrhDFQOXDTtonCNqe/eVR4d8l5+o3DUrSu4qbU7njpEhuIhta
         dmqWG5aljKft3ArjfZCrsNu9ABt0jWTE1p/9vxQ8rwUrTUzcqRIpPBif9VdldGqzYTZQ
         V6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348851; x=1696953651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FvVCrqOKh6HKC+bZxE5jYuqFOTddVesEzvzag91z+o=;
        b=Y/JAqRkfTXAl5808cVAqpS+jrcKxNDYwd6aL6jRc+JhN+JyTatBIPseTce/j+j4qYW
         wO9WTKIvjYuEsMRKDCI+2pyi0hFdyHn8CaZglToDvZYg7wRcKOns69Ew4W719NGXh0dx
         4Qdhwp/qD4xIC1Zrlnbzie7k0400vmzI3PATj7mjUOSrVDY3TrsOxSKfnY+sTqmjes7/
         nryZHJTxXgb95KI2kMxFBSEib2J9up8aWK/UK4xXk2mgTtCqOL6qLOSLD2QFj8ScdA4w
         fdaRfrjAi+Ay8nk5LdcYGN8Jbp/+Awha28NI9HvlDXrN9IJxCbreZgxkI8EKi28Q5njp
         8sQQ==
X-Gm-Message-State: AOJu0YyLb1Zh/z6vyn/h/aKX84Qwx7Vw7SIsHpiayX80dCOOyliHS5h2
        +0iozeSYHSMDi7KDK4mdEgo=
X-Google-Smtp-Source: AGHT+IHs5e4PJhQyU/pO6caDVGwEi3PeF9fcqlPPalxYgjZKoqStuM7a+mDYM96CPyILV75Ia2uu+A==
X-Received: by 2002:a17:907:74a:b0:9ad:93c8:c483 with SMTP id xc10-20020a170907074a00b009ad93c8c483mr2722943ejb.2.1696348850790;
        Tue, 03 Oct 2023 09:00:50 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id jo3-20020a170906f6c300b0099df2ddfc37sm1270526ejb.165.2023.10.03.09.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:00:50 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v10 2/9] USB: typec: tsp6598x: Add cmd timeout and response delay
Date:   Tue,  3 Oct 2023 11:58:35 -0400
Message-Id: <20231003155842.57313-3-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003155842.57313-1-alkuor@gmail.com>
References: <20231003155842.57313-1-alkuor@gmail.com>
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

From: Abdel Alkuor <abdelalkuor@geotab.com>

Some commands in tps25750 take longer than 1 second
to complete, and some responses need some delay before
the result becomes available.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v10:
  - No changes
Changes in v9:
  - No changes
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

