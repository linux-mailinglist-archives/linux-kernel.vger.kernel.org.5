Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0CE7B47A8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjJANo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjJANo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:44:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E67F0
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:44:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-537efaf742aso423233a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696167863; x=1696772663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LEP+m1gZqUF2dlXF0HPKoDRFFOr5o0irSFxrQKPSymU=;
        b=g5xtz1LLx7pKg/SLCtrCrKb7YzcvGAJaYbvZtkKr92jwze/vMhMQ7CWarzlfEb/ZNQ
         ZJG9sqqtdcJU+7PGhTL0AgZ1sYpz8XPwC5OpmzrTyzLRYUrnd/PFo1/OADgOxhboWgB5
         s4MBtGs/QlONWwq314vUhG8b/40CFhc1SYc4dD/FiaN1pVmZl+w2sf11CXq0iFAjaMVq
         /AoaP080f4leRIMzRAu0emtw8S4hi2TDsfVzXJsvHdIC4uFDr8w41IcTWV7zAhvZZF3j
         yHBnqCUtudV8Nr6QL9DNdEUT+wLY5K9SaVnoNSaXjpMYsOgGtvMnkwqgVUzogmET3sjH
         an+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696167863; x=1696772663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEP+m1gZqUF2dlXF0HPKoDRFFOr5o0irSFxrQKPSymU=;
        b=QJcre7uYfgXwJ2F5X9IO88YjsqnCnOHSo7/AUYnajNF6aV8f19EiHkBqbuSys5VMm8
         0hj8TPp/vcVxgyfd0wh3+Aru50Wc/6gwn7W8Jj3gIJhV/eYSX9PVFpdqiZ9VkRoebHER
         fnywpI3PHYbzYSJs+7hy6EK0gTGSXJs7NCf5dGTFM5kQ/MSTvxxx1uyY5BBk4ps6YMhC
         14TluChGk358/t0+5LmH4S78hahJCDdLgdLjtvQiugeZuY+7PRbb0IWl4NTn5TSEpeYf
         ojH7goJ84XZ2d8dYFiXUYXSATOehO+xYZCr6HSCS4DCqhEGODCw5nM5qPYjPmToFw+eW
         N4Fg==
X-Gm-Message-State: AOJu0YzGz3bHhxmZFDx0+jUaIobvl0M/TxBJ9uR0W6toChlH4HPYs/Ha
        sfKoOpvMRiJBMyXFB7kKqm0=
X-Google-Smtp-Source: AGHT+IGMX9+Dus1EyYTTX1u5SQI+uSD22+wFbNFkFibaq9PlI6vVQ04/mlXa9JGWX/dXmflOSC/hWQ==
X-Received: by 2002:a05:6402:26c5:b0:523:2e64:122b with SMTP id x5-20020a05640226c500b005232e64122bmr7806299edd.3.1696167862351;
        Sun, 01 Oct 2023 06:44:22 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id x18-20020aa7d6d2000000b0052febc781bfsm14037773edr.36.2023.10.01.06.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:44:22 -0700 (PDT)
Date:   Sun, 1 Oct 2023 15:44:20 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] staging: rtl8192e: Remove RESET_TYPE_NORMAL
Message-ID: <e951e39f0d75fb6baf8beb37e8c5fed05365078d.1696165351.git.philipp.g.hortmann@gmail.com>
References: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696165351.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ResetType == RESET_TYPE_NORMAL is always false. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 5 -----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f67923ccf790..11d20fc11a7d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1237,11 +1237,6 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 	}
 	spin_unlock_irqrestore(&priv->tx_lock, flags);
 
-	if (ResetType == RESET_TYPE_NORMAL) {
-		priv->rst_progress = RESET_TYPE_NORMAL;
-		return;
-	}
-
 	if ((priv->force_reset || ResetType == RESET_TYPE_SILENT))
 		_rtl92e_if_silent_reset(dev);
 	priv->force_reset = false;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index fa82a0667813..d6e924fc8011 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -132,7 +132,6 @@ enum rt_customer_id {
 
 enum reset_type {
 	RESET_TYPE_NORESET = 0x00,
-	RESET_TYPE_NORMAL = 0x01,
 	RESET_TYPE_SILENT = 0x02
 };
 
-- 
2.42.0

