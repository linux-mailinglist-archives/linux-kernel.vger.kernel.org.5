Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C93765795
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbjG0P1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjG0P0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:26:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4793E1FF2;
        Thu, 27 Jul 2023 08:26:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31751d7d96eso1093581f8f.1;
        Thu, 27 Jul 2023 08:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690471610; x=1691076410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHqP+YZKi6UJxxMncRrogAGn87C6jhHE2PztBFcHNPw=;
        b=e7V1bqT9LFG14ArBckFFf5U7nVwFOFhfQI65sytOs6iyWfx/rrSLXqxcBI0kdkJGrY
         BA8wiuyrjV4RRx2Aw2P7Z2wSPDA6HLK9Zxy2hwRbNQmRKvP/HuFOVUFDZlzH24MS4lv6
         GPa2VT1dQKdlr9GcArGDQ2ScCqO8tBvSEnXWBXKeHAFxtO2XYsdFgR/X/HhMr1QjOE5l
         LAwKVfMBohvzhbha/2jbs5i8Vqbq7KF4D64mfM/15jaLedERLibA1pV8cwovVeCnPHFg
         jSgvcCUTBXXJmRN363H3veG2acSaToTiJ4OvCSEksuc8PPcP6gshrtwtQYUVewZ5MlA4
         /tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690471610; x=1691076410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHqP+YZKi6UJxxMncRrogAGn87C6jhHE2PztBFcHNPw=;
        b=Egi+qDOHwjPOfFA/0Q9zzJz8HClKTlQq7x1Na0usEijxh1XkbcxTpMByVDdYxGLON7
         UIx8j+NOPe4HZ+LdlCSuOcFkKJ7eDXOI9gMnIc4C6orM6+wHEQ5BUuFvnnYA8+aouZpJ
         qPsahDiOvrIktsDq+JkzwT2BCJuM8lpNaxVtUjXgHsQfj7/YI7yrAuUH+eZNWlS/9VjJ
         cdCspm8ZOjbLhSYFiGhqA6PDrzOYsktO8w5T2A1LxOZJL0EiVGEPGhduXeOkAvPEwRT3
         L32IHKIPzNPQuVfjgJ51+ryq9CrZmKvYl5dj8wgEzCRgbYvRCptd2Sw0PoIQ9RbckGGq
         BvJw==
X-Gm-Message-State: ABy/qLZS1CetxGRe4b4gShr8rvAyKk0AsrXiXQ7vHpiDp1FMtc72E75G
        ULxf3knC+Z5eoVn/okGLmaQ=
X-Google-Smtp-Source: APBJJlFj3FWI2f83wCFSfx20cQToMSQfK77tg5WSRKxqR64WlE46swV6tDTyvqOj7Fu01gkMWRLe+A==
X-Received: by 2002:adf:ef05:0:b0:317:6cca:a68a with SMTP id e5-20020adfef05000000b003176ccaa68amr1949427wro.41.1690471610225;
        Thu, 27 Jul 2023 08:26:50 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id b17-20020adfde11000000b003143765e207sm2350622wrm.49.2023.07.27.08.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:26:49 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Thu, 27 Jul 2023 17:26:40 +0200
Subject: [PATCH 5/6] kernel/reboot: remove generic restart mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230727-pca9450-reboot-v1-5-c8edb27bf404@skidata.com>
References: <20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com>
In-Reply-To: <20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com>
To:     Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Jerome Neanne <jneanne@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Remove the "unspecified" restart mode, as it is not in use anymore. New
handler registrations should use the specified "cold" or "warm" instead.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 include/linux/reboot.h | 11 -----------
 kernel/reboot.c        | 26 --------------------------
 2 files changed, 37 deletions(-)

diff --git a/include/linux/reboot.h b/include/linux/reboot.h
index 05199aedb696..ad1a7b4026c0 100644
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -113,13 +113,6 @@ enum sys_off_mode {
 	 */
 	SYS_OFF_MODE_RESTART_PREPARE,
 
-	/**
-	 * @SYS_OFF_MODE_RESTART:
-	 *
-	 * Handlers restart system. Handlers are disallowed to sleep.
-	 */
-	SYS_OFF_MODE_RESTART,
-
 	/**
 	 * @SYS_OFF_MODE_RESTART_COLD:
 	 *
@@ -167,10 +160,6 @@ int devm_register_power_off_handler(struct device *dev,
 				    int (*callback)(struct sys_off_data *data),
 				    void *cb_data);
 
-int devm_register_restart_handler(struct device *dev,
-				  int (*callback)(struct sys_off_data *data),
-				  void *cb_data);
-
 int devm_register_cold_restart_handler(struct device *dev,
 				       int (*callback)(struct sys_off_data *data),
 				       void *cb_data);
diff --git a/kernel/reboot.c b/kernel/reboot.c
index d0d3faf70a79..072489e48636 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -441,10 +441,6 @@ register_sys_off_handler(enum sys_off_mode mode,
 		handler->blocking = true;
 		break;
 
-	case SYS_OFF_MODE_RESTART:
-		handler->list = &warm_restart_handler_list;
-		break;
-
 	case SYS_OFF_MODE_RESTART_COLD:
 		handler->list = &cold_restart_handler_list;
 		break;
@@ -574,28 +570,6 @@ int devm_register_power_off_handler(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_register_power_off_handler);
 
-/**
- *	devm_register_restart_handler - Register restart handler
- *	@dev: Device that registers callback
- *	@callback: Callback function
- *	@cb_data: Callback's argument
- *
- *	Registers resource-managed sys-off handler with a default priority
- *	and using restart mode.
- *
- *	Returns zero on success, or error code on failure.
- */
-int devm_register_restart_handler(struct device *dev,
-				  int (*callback)(struct sys_off_data *data),
-				  void *cb_data)
-{
-	return devm_register_sys_off_handler(dev,
-					     SYS_OFF_MODE_RESTART,
-					     SYS_OFF_PRIO_DEFAULT,
-					     callback, cb_data);
-}
-EXPORT_SYMBOL_GPL(devm_register_restart_handler);
-
 /**
  *	devm_register_cold_restart_handler - Register cold restart handler
  *	@dev: Device that registers callback

-- 
2.34.1

