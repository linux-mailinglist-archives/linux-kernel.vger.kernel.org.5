Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78D8780C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376985AbjHRMzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376966AbjHRMy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:54:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E67F30F6;
        Fri, 18 Aug 2023 05:54:56 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe8c3b5ca0so1295310e87.1;
        Fri, 18 Aug 2023 05:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692363295; x=1692968095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=67vQ/7mBcvvdfmCbFxtyg3zPIiXbP/aBRSw9NykcPYQ=;
        b=de+OCZbgrWDgijwJTI1s/t4gopxklWXkSAc0gJKXlzmGlbpjvfu2wVMnKQ33d7u2cq
         0/x0ma2djv9bzNli+YCbqQmNqprxfqztchy2ttMahuIt9Aliorq0DWCrmqeR70kHA5S3
         frq3o1zloYTV4t2uxOIcHkkFFJ4KwfTsf0IpZW1shMzrGa7XJKNUOregmuBCg5RpxprS
         6NXyBG3N8pRy5w2sJ6or7ZZUqrpSQMpA3P0GPmoqMVleAHBUTLWtmZaZ57evbXob9mQ/
         m5PjRgH1OKDjW07ezkpbPbG+Ht5Mu1waTJygKnkQ1Zdgfmd1QOjVl1Wf5mEmQbBS4F/M
         8cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692363295; x=1692968095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=67vQ/7mBcvvdfmCbFxtyg3zPIiXbP/aBRSw9NykcPYQ=;
        b=C4/BR35F1VwITWjpJn8tTjwI61xUYTMDBxotzxcXvoLBFT4pt2knlJYDHaJQDwbaIu
         knVg0UFpD2JdN2j10KjHSnihK4WTFeHeE8yxzj6pUA/SUChzqoYcTMIE8f6qnTSdlLz2
         xt78MM4EF3IkyRy8blqf9ZYgu6J9dUQwNPEhgNH2hyhtwodbnhuifhoO5jrNYIGlcPLR
         lWN4KTOn/x99d+97rckxM+gPg67GC0aQkgKTDWJkfRnJdLz9aYZdMpU5H5cJXO/jf+Iu
         1V6epAnPSireFMlgji/e3sFtuD5Lg5sOBOIcMdvrMX9XrwrzQwbblTWZpV4JqT2rIgZf
         Hh3w==
X-Gm-Message-State: AOJu0YxqH8IsJx11Ekz39fHN+17enuyrqgASsKHsRjal74Zgjre4kWBC
        /h5amogHd8B624pxSNLnpWU=
X-Google-Smtp-Source: AGHT+IGoP8nkkUCENgMRwAGy7olq9sqV8gE/z7Ae8FR7k0BWN0v0FtuWlYbDu/1ipG0ZzJpvhVWs5g==
X-Received: by 2002:a05:6512:3f03:b0:4fe:19ef:8794 with SMTP id y3-20020a0565123f0300b004fe19ef8794mr2028379lfa.28.1692363294572;
        Fri, 18 Aug 2023 05:54:54 -0700 (PDT)
Received: from localhost ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id b25-20020ac247f9000000b004fe509970dasm328154lfp.250.2023.08.18.05.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 05:54:54 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: Fix deadlocking in phy_error() invocation
Date:   Fri, 18 Aug 2023 15:54:45 +0300
Message-ID: <20230818125449.32061-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Since commit 91a7cda1f4b8 ("net: phy: Fix race condition on link status
change") all the phy_error() method invocations have been causing the
nested-mutex-lock deadlock because it's normally done in the PHY-driver
threaded IRQ handlers which since that change have been called with the
phydev->lock mutex held. Here is the calls thread:

IRQ: phy_interrupt()
     +-> mutex_lock(&phydev->lock); <--------------------+
         drv->handle_interrupt()                         | Deadlock due
         +-> ERROR: phy_error()                          + to the nested
                    +-> phy_process_error()              | mutex lock
                        +-> mutex_lock(&phydev->lock); <-+
                            phydev->state = PHY_ERROR;
                            mutex_unlock(&phydev->lock);
         mutex_unlock(&phydev->lock);

The problem can be easily reproduced just by calling phy_error() from any
PHY-device threaded interrupt handler. Fix it by dropping the phydev->lock
mutex lock from the phy_process_error() method and printing a nasty error
message to the system log if the mutex isn't held in the caller execution
context.

Note for the fix to work correctly in the PHY-subsystem itself the
phydev->lock mutex locking must be added to the phy_error_precise()
function.

Link: https://lore.kernel.org/netdev/20230816180944.19262-1-fancer.lancer@gmail.com
Fixes: 91a7cda1f4b8 ("net: phy: Fix race condition on link status change")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/phy/phy.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index bdf00b2b2c1d..a9ecfdd19624 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1184,9 +1184,11 @@ void phy_stop_machine(struct phy_device *phydev)
 
 static void phy_process_error(struct phy_device *phydev)
 {
-	mutex_lock(&phydev->lock);
+	/* phydev->lock must be held for the state change to be safe */
+	if (!mutex_is_locked(&phydev->lock))
+		phydev_err(phydev, "PHY-device data unsafe context\n");
+
 	phydev->state = PHY_ERROR;
-	mutex_unlock(&phydev->lock);
 
 	phy_trigger_machine(phydev);
 }
@@ -1195,7 +1197,9 @@ static void phy_error_precise(struct phy_device *phydev,
 			      const void *func, int err)
 {
 	WARN(1, "%pS: returned: %d\n", func, err);
+	mutex_lock(&phydev->lock);
 	phy_process_error(phydev);
+	mutex_unlock(&phydev->lock);
 }
 
 /**
@@ -1204,8 +1208,7 @@ static void phy_error_precise(struct phy_device *phydev,
  *
  * Moves the PHY to the ERROR state in response to a read
  * or write error, and tells the controller the link is down.
- * Must not be called from interrupt context, or while the
- * phydev->lock is held.
+ * Must be called with phydev->lock held.
  */
 void phy_error(struct phy_device *phydev)
 {
-- 
2.41.0

