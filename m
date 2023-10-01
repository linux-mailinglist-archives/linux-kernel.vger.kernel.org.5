Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8B17B45F1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbjJAIP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjJAIPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:15:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF01DBA;
        Sun,  1 Oct 2023 01:15:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b2cee55056so441980866b.3;
        Sun, 01 Oct 2023 01:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696148120; x=1696752920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXPGOO8O8at+wGMGIlqhcBW/HHlv4Zqhk0okLpSRNJU=;
        b=Vv4lBv2M0T38TRc1d+qSs1hJ0Pa2XsM3mBGBz2U4aPo2JdxDecmTgfVFLyQhX3Dc5Z
         rucOnmB4F3+P7I6UoHbtWYKxKj9LbGDqJeIShOX8pPuHXjIz2gGK0i0MuQyyBg+2VJPi
         fQRPLmYUZKtbmrrSH7V87DNgP9wVBner8+gVkRfAWZeBtlcn2BgRVys3Rh9iqM6VAR3d
         u3SfHxCROTAXQ8A7ulnCt12rMoGwvVjpZ7CGVpX/QMezutOryhhGc/74/EN65JDAZutb
         WGLiYFKBqKbYGja4epQzj9c0occ1Ing25KzuxADN+YhbKl9uq7OUaPKv0qN4Ae+WfL7S
         tASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696148120; x=1696752920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXPGOO8O8at+wGMGIlqhcBW/HHlv4Zqhk0okLpSRNJU=;
        b=jqEhqNNOSgLwCD2RbaHuOZQJTiPVuibVWzTLrSPluZ4UT5wRIJm0ZGNhgfoQC4KhK8
         m15a9d/sk12dbs1+uOLc2OKOXITUNF2oOw0m3xoa1VjF5/9jQdtnFifjXboOOdRTgk8T
         gaREGmeiC2EDs1g2WdTBoyJcR43sT8BeilTLHX42xgaDCo7Iet6VfPwbYQ7pDhpZ/kma
         tz0eonFb4Htnz8naYNLUQrhuSSwYZyE/410XSyeSFq7K3KJKwdk5dIgEtMHo0eBRMoRu
         1f8iMD2vtZzUVY3SBCj/3v7gTcGdmOjNwhaV4bxh9BbCvJcuWJ1u4BpWQt5ehIHOKXaI
         JVOg==
X-Gm-Message-State: AOJu0YynDE0G5qekWnZN520PGumvX+9cnRwXS/j5dYaDscZCxiDET+sx
        19o9NyasbUD3DcQ6h0+txaI=
X-Google-Smtp-Source: AGHT+IFoG1Xk4xZXcw5QGT0BNVlKxAxA+W8WCMiypY5kOMOssGc51vH/NrB79UCzJnSl0JZgmz78ww==
X-Received: by 2002:a17:906:cc2:b0:9ad:a59f:331a with SMTP id l2-20020a1709060cc200b009ada59f331amr7221138ejh.57.1696148119934;
        Sun, 01 Oct 2023 01:15:19 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm15121841ejc.153.2023.10.01.01.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:15:19 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v9 02/14] USB: typec: tsp6598x: Add cmd timeout and response delay
Date:   Sun,  1 Oct 2023 04:11:22 -0400
Message-Id: <20231001081134.37101-3-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001081134.37101-1-alkuor@gmail.com>
References: <20231001081134.37101-1-alkuor@gmail.com>
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

