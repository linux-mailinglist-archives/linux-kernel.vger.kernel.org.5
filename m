Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048F77768B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjHITZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjHITZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:25:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61C726AF;
        Wed,  9 Aug 2023 12:24:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbea147034so980945e9.0;
        Wed, 09 Aug 2023 12:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691609060; x=1692213860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNX6lDzJ0d718pSUe3xwW15aLLHHaMX3WIRGJs7J7yY=;
        b=R/R2f7Iha4oTPdSdqqRn/3phuO4mni0vOveqNYB1NVGlZjBijaLLQZxgWmytPyL2st
         ou6ZC5u8fyw6dRVhEg1TsKQLDJ5QtcPsoqneF9C0EuAtIwv8KJjAFfFVHNworkkfxLKC
         XFp9SSVKs6WO7od8DXC65Q5pTBmHVAugrYAyj1m8R5G2gCvnFZe/IMadhvPpVMzI5FW9
         5T6Ifwbr4+M/EnzKhBfcDRgTS61hIYNcnSH1BKEp+eZr1idBcem+LjLp4E/SXzdGE2D7
         Qqr4f20Zs83fBPauWNao0OaewHVzsoGcKGVPP3qe8o9GFN70vNeOtd2Kp158hek0aPJN
         57JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609060; x=1692213860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNX6lDzJ0d718pSUe3xwW15aLLHHaMX3WIRGJs7J7yY=;
        b=BiDvLOxZQil9Ac2oBOKyUKq78Ik6DsLNFhrWj5rgDYLzUNXj+MAsljBUYAwJDUGTne
         UoCv/F3hhNYTkIuPlr4NTZEfGit1Le2wvkYlSxxM+Jwu1F1iB9Fkz9pSD5bCfgmANg3G
         fPHheBJE1D1Am7Zpl+bGmt+EACQvxPKWGn5MEJJDU+0ehyzVtiobPgdzh1RM6SMEzXe6
         jY/AcrYbJmAU0rKD7zMI7+I1PNt8HfMxGWiAzaMd2FlBffMa2ptnQGNH/Cd6UIDfhCOm
         huQiqXLV65cVpBmu06MRp+B0nfVxPtP6MXBCtAQ1IIUhKDuZX2Lv7H7iBNMAFCsmeSmZ
         RwmQ==
X-Gm-Message-State: AOJu0YwyTeaxXCJMheQN8XeQKLqZlkEc030rkXDauB8i5Z3whBKto+Hh
        5eSrBTRUlJXT2LZYb5YfoRE=
X-Google-Smtp-Source: AGHT+IFpvId/KSK9vwzsmZMrX1Bn3EG+ercdKy6bm7+DDu9KUQFGsg/7todXUV/CbQjKKTbeQ5FiVQ==
X-Received: by 2002:a05:600c:2307:b0:3fe:2463:2614 with SMTP id 7-20020a05600c230700b003fe24632614mr66196wmo.24.1691609060144;
        Wed, 09 Aug 2023 12:24:20 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fba6a0c881sm2776208wmj.43.2023.08.09.12.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:24:19 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 09 Aug 2023 21:24:07 +0200
Subject: [PATCH v2 5/6] kernel/reboot: remove generic restart mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-pca9450-reboot-v2-5-b98b4f8139d5@skidata.com>
References: <20230809-pca9450-reboot-v2-0-b98b4f8139d5@skidata.com>
In-Reply-To: <20230809-pca9450-reboot-v2-0-b98b4f8139d5@skidata.com>
To:     Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        peng.fan@oss.nxp.com, rafael.j.wysocki@intel.com,
        Jerome Neanne <jneanne@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Remove the "unspecified" restart mode, as it is not in use anymore. New
handler registrations should use the specified "cold" or "warm" instead.
These respect the "reboot_mode" kernel parameter and enable implicit
priorization (cold before warm) when the reboot_mode is unspecified.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
v2:
- improve commit message
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
index ab99f450801f..af0e090dd087 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -443,10 +443,6 @@ register_sys_off_handler(enum sys_off_mode mode,
 		handler->blocking = true;
 		break;
 
-	case SYS_OFF_MODE_RESTART:
-		handler->list = &warm_restart_handler_list;
-		break;
-
 	case SYS_OFF_MODE_RESTART_COLD:
 		handler->list = &cold_restart_handler_list;
 		break;
@@ -576,28 +572,6 @@ int devm_register_power_off_handler(struct device *dev,
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

