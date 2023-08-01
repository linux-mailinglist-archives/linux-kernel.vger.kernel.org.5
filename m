Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C0976BD3C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjHATEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjHATEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:04:44 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C4B1B6;
        Tue,  1 Aug 2023 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1y6fLsED4M7O0xTn5G+GNfaljUI69EpS2E67l1a0Emk=; b=sa/OIuWxB2iy86ItQTTt1CpQ+n
        8FADi+We4tFabneZnOy8KliPhuvxg1OeQHcCSp2sk7wgLuB5cMcLy2Qyn/ezA6WGf6nF5eNaESV0n
        MnhJ8aCvPh2p35U2IjVnBq+sXng7ATG6J6eTEe9LJBs1NxH+9wn0y7z+cDp9uFzYOFC4=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:41916 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qQufc-0001TE-Ks; Tue, 01 Aug 2023 15:04:37 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue,  1 Aug 2023 15:04:32 -0400
Message-Id: <20230801190432.3340545-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] rtc: pcf2127: remove unused function argument
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Fixes the following W=1 kernel build warning(s):

drivers/rtc/rtc-pcf2127.c: In function ‘pcf2127_probe’:
drivers/rtc/rtc-pcf2127.c:635:32: warning: unused parameter ‘name’ [-Wunused-parameter]
  635 |     int alarm_irq, const char *name, bool is_pcf2127)
      |                    ~~~~~~~~~~~~^~~~

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index 3387afe93417..14f59e4535e8 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -1103,7 +1103,7 @@ static int pcf2127_configure_interrupt_pins(struct device *dev)
 }
 
 static int pcf2127_probe(struct device *dev, struct regmap *regmap,
-			 int alarm_irq, const char *name, const struct pcf21xx_config *config)
+			 int alarm_irq, const struct pcf21xx_config *config)
 {
 	struct pcf2127 *pcf2127;
 	int ret = 0;
@@ -1402,8 +1402,7 @@ static int pcf2127_i2c_probe(struct i2c_client *client)
 		return PTR_ERR(regmap);
 	}
 
-	return pcf2127_probe(&client->dev, regmap, client->irq,
-			     pcf2127_i2c_driver.driver.name, variant);
+	return pcf2127_probe(&client->dev, regmap, client->irq, variant);
 }
 
 static struct i2c_driver pcf2127_i2c_driver = {
@@ -1475,9 +1474,7 @@ static int pcf2127_spi_probe(struct spi_device *spi)
 		return PTR_ERR(regmap);
 	}
 
-	return pcf2127_probe(&spi->dev, regmap, spi->irq,
-			     pcf2127_spi_driver.driver.name,
-			     variant);
+	return pcf2127_probe(&spi->dev, regmap, spi->irq, variant);
 }
 
 static const struct spi_device_id pcf2127_spi_id[] = {

base-commit: 3c87b351809f220294aec3c0df7b078ff5c5b15b
prerequisite-patch-id: 9cbdafa114f5dc7490862c8009f781258c9f9884
-- 
2.30.2

