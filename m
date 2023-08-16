Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B651177E85A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345411AbjHPSKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345457AbjHPSJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:09:54 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93E12724;
        Wed, 16 Aug 2023 11:09:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe655796faso11043029e87.2;
        Wed, 16 Aug 2023 11:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692209389; x=1692814189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3hmUZtnYOlje3SiIYlxtkLekigYMK8BRi+/WrOCpJxY=;
        b=AbYFhr2u/MCCxcfA7wiOeNMrtmodMyT8blwmzYr72E71Dz/dJlHBUkjDmJHSH98Vkn
         KjX8OnoNwSOIHB9sRr3XcZbOtpg+M7vIMo6Bi/madONR8aSOWTLD8UlZ8xfdW2soufr3
         dZBYcA5hz7MJsrHtal/nbhWDeM+KaaX1TENGeQBc3VGiCyGxdd78EEEYqqm7wraZM4QV
         XSxfTsGaISTrR20sfsJFfI5RYNWwvu1Ssmyve22+QdFevqd+ZJuUScOTcgSuyrzUniGm
         9CLv3fzCOqbB1bJtUMxzPib2ebiDwDxyRssYsM1KUJXrTWRofkokqX39ltqnJIKeUoEn
         6+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692209389; x=1692814189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hmUZtnYOlje3SiIYlxtkLekigYMK8BRi+/WrOCpJxY=;
        b=KuHXGoXBAqKqZT7vIjeu8eETgJ2pZQxiLV8BeOpgCJKD91gn9Rw8Kp2mBCs09eZ3W9
         gAVr7a1nYeOmD+LYZB3yUBGLn4Oyv06qbC53Q2SUI/VqICW7WxDKQj4G8NaGLe+VCDVq
         aGH50fvsmuAAf6LVy++bYbRX+bJ1QYGNZBCHP+Gmhd8rmLsH4dujKp5nkf0T/V9rGoFc
         R0neu9uY0GQbAM/CKlJ1I7BXUUt54rmDvwj+ReABrnt2X6fBLWrPMu9e+9zEmBH4iMAb
         mtVlCGfikmfOAkga4UjrzMeLz7UQ16CEYmoY4UeIE9X/Zr6xP/Q5LZ9jNKV6FyxTBvT9
         ykVw==
X-Gm-Message-State: AOJu0YyqB6HjPZi03ruZjKetQZe3MXNC1+reH6gKH0FAfkTt2KQ5dlZz
        gVpkkpuJ73yueUhCx7yVymE=
X-Google-Smtp-Source: AGHT+IHUjkdE2V8c9PyTOGmNIoR+PfdEPf111soD37zpFR/zNbnhHUMGphBQ61jqlk7ABCeP7ct2HQ==
X-Received: by 2002:a05:6512:447:b0:4fe:a5c:efa3 with SMTP id y7-20020a056512044700b004fe0a5cefa3mr2014247lfk.62.1692209388629;
        Wed, 16 Aug 2023 11:09:48 -0700 (PDT)
Received: from localhost ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id w25-20020a19c519000000b004fe3c47253asm2976112lfe.297.2023.08.16.11.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 11:09:48 -0700 (PDT)
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
Subject: [RFC net] Revert "net: phy: Fix race condition on link status change"
Date:   Wed, 16 Aug 2023 21:09:40 +0300
Message-ID: <20230816180944.19262-1-fancer.lancer@gmail.com>
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

Protecting the phy_driver.drv->handle_interrupt() callback invocation by
the phy_device.lock mutex causes all the IRQ-capable PHY drivers to lock
the mutex twice thus deadlocking on the next calls thread:
IRQ: phy_interrupt()
     +-> mutex_lock(&phydev->lock); <-------------+
         drv->handle_interrupt()                  | Deadlock due to the
         +-> phy_error()                          + nested PHY-device
             +-> phy_process_error()              | mutex lock
                 +-> mutex_lock(&phydev->lock); <-+
                     phydev->state = PHY_ERROR;
                     mutex_unlock(&phydev->lock);
         mutex_unlock(&phydev->lock);

The problem can be easily reproduced just by calling phy_error() from the
any PHY-device interrupt handler. Reverting the commit 91a7cda1f4b8 ("net:
phy: Fix race condition on link status change") fixes the deadlock.

This reverts commit 91a7cda1f4b8bdf770000a3b60640576dafe0cec.

Fixes: 91a7cda1f4b8 ("net: phy: Fix race condition on link status change")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Since obviously it would be better to fix both the deadlock and the
problem described in the blamed commit the patch is marked as RFC. I am
not aware of a better solution for now than to revert the commit caused
the regression. So let's discuss to find out whether it's possible to have
a better fix here.

---
 drivers/net/phy/phy.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index bdf00b2b2c1d..9483bd57158e 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1235,7 +1235,6 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 {
 	struct phy_device *phydev = phy_dat;
 	struct phy_driver *drv = phydev->drv;
-	irqreturn_t ret;
 
 	/* Wakeup interrupts may occur during a system sleep transition.
 	 * Postpone handling until the PHY has resumed.
@@ -1259,11 +1258,7 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 		return IRQ_HANDLED;
 	}
 
-	mutex_lock(&phydev->lock);
-	ret = drv->handle_interrupt(phydev);
-	mutex_unlock(&phydev->lock);
-
-	return ret;
+	return drv->handle_interrupt(phydev);
 }
 
 /**
-- 
2.41.0

