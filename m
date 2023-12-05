Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11514805C50
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjLEQnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjLEQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:42:57 -0500
X-Greylist: delayed 149 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 08:43:03 PST
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1A81AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com;
        s=dkim1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dxoc7igFwFFDBFrWxPUApHF/u2m+gHzOOTpkXqJPg/I=; b=KI9qPq41R0eQSfczmpWd4oQFLC
        UMzTTiUflJUDIVBEkdRfHIHZNj0Xp7Nk7B8uLK2s1Lhn/qgqoEvOnjSv+dXF5nPVCoN45TFhABs3p
        J4bHeHQuwKTPbcr1jSWdZcGs1BmwWDl0ojCaPfv8pEhjpSg6uztUJTZ1FQQWAH9tt8RPHW8IgV5L1
        lsqKh4BVDmDXfflhQt4LrTLD3TSeRDC2okNDMRe14uKz3+aX80aqHw0DXxB7DYwddK5j7Iw7T3s14
        FR9JiRXsmZJo+vDjvIGBT7SxVydXRxvDB04lrpTgVxBfCQI8t9JmIGcawxz8y1OjufCl5iTbzRCWE
        aNvqRjbg==;
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:57784 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
        (Exim 4.96)
        (envelope-from <dd@embedd.com>)
        id 1rAYTE-0001qs-0Y;
        Tue, 05 Dec 2023 17:40:28 +0100
X-SASI-Hits: BODY_SIZE_3000_3999 0.000000, BODY_SIZE_5000_LESS 0.000000,
        BODY_SIZE_7000_LESS 0.000000, CTE_8BIT 0.000000, DKIM_ALIGNS 0.000000,
        DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
        LEGITIMATE_SIGNS 0.000000, MULTIPLE_RCPTS 0.100000,
        MULTIPLE_REAL_RCPTS 0.000000, NO_FUR_HEADER 0.000000, OUTBOUND 0.000000,
        OUTBOUND_SOPHOS 0.000000, SENDER_NO_AUTH 0.000000,
        SINGLE_URI_IN_BODY 0.000000, SUSP_DH_NEG 0.000000,
        URI_WITH_PATH_ONLY 0.000000, __ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
        __BULK_NEGATE 0.000000, __CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
        __CC_REAL_NAMES 0.000000, __CP_URI_IN_BODY 0.000000, __CTE 0.000000,
        __DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000,
        __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
        __FROM_NAME_NOT_IN_ADDR 0.000000, __FUR_RDNS_SOPHOS 0.000000,
        __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
        __HAS_X_MAILER 0.000000, __HTTPS_URI 0.000000,
        __INVOICE_MULTILINGUAL 0.000000, __MIME_TEXT_ONLY 0.000000,
        __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
        __MULTIPLE_RCPTS_CC_X2 0.000000, __MULTIPLE_RCPTS_TO_X2 0.000000,
        __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
        __OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
        __PHISH_SPEAR_SUBJ_TEAM 0.000000, __RCVD_PASS 0.000000,
        __SANE_MSGID 0.000000, __SINGLE_URI_TEXT 0.000000, __SUBJ_ALPHA_END 0.000000,
        __SUBJ_STARTS_S_BRACKETS 0.000000, __TO_MALFORMED_2 0.000000,
        __TO_NO_NAME 0.000000, __URI_ENDS_IN_SLASH 0.000000,
        __URI_HAS_HYPHEN_USC 0.000000, __URI_IN_BODY 0.000000, __URI_MAILTO 0.000000,
        __URI_NOT_IMG 0.000000, __URI_NO_WWW 0.000000, __URI_NS 0.000000,
        __URI_WITH_PATH 0.000000, __X_MAILSCANNER 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2023.12.5.160315
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com; s=mikd;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=dxoc7igFwFFDBFrWxPUApHF/u2m+gHzOOTpkXqJPg/I=;
        b=JI5OFYb2wBUqNXBxyMIvWqIruCX82yI1tP6fHuuR6bOcjtrw9SX1QEl/hbV2tXqb/T7jLcNddZbwK/l5hxRpliXOL5ZyN0B3dhWdGyHTVOw2U739uUa+ow+/K1w87QCRCwGN9NJkGa4OCJ+E9lSPS1JJdSXYSMYJxou82gdjbCs=;
From:   Daniel Danzberger <dd@embedd.com>
To:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Daniel Danzberger <dd@embedd.com>
Subject: [PATCH net-next 1/2] net: dsa: microchip: properly support platform_data probing
Date:   Tue,  5 Dec 2023 17:42:30 +0100
Message-Id: <20231205164231.1863020-1-dd@embedd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dd@embedd.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: dd@embedd.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1rAYSv-00051S-Fi
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: dd@embedd.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
        by webmail.newmedia-net.de with esmtp (Exim 4.72)
        (envelope-from <dd@embedd.com>)
        id 1rAYSv-00051S-Fi; Tue, 05 Dec 2023 17:40:09 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

The ksz driver has bits and pieces of platform_data probing support, but
it doesn't work.

The conventional thing to do is to have an encapsulating structure for
struct dsa_chip_data that gets put into dev->platform_data. This driver
expects a struct ksz_platform_data, but that doesn't contain a struct
dsa_chip_data as first element, which will obviously not work with
dsa_switch_probe() -> dsa_switch_parse().

Pointing dev->platform_data to a struct dsa_chip_data directly is in
principle possible, but that doesn't work either. The driver has
ksz_switch_detect() to read the device ID from hardware, followed by
ksz_check_device_id() to compare it against a predetermined expected
value. This protects against early errors in the SPI/I2C communication.
With platform_data, the mechanism in ksz_check_device_id() doesn't work
and even leads to NULL pointer dereferences, since of_device_get_match_data()
doesn't work in that probe path.

So obviously, the platform_data support is actually missing, and the
existing handling of struct ksz_platform_data is bogus. Complete the
support by adding a struct dsa_chip_data as first element, and fixing up
ksz_check_device_id() to pick up the platform_data instead of the
unavailable of_device_get_match_data().

The early dev->chip_id assignment from ksz_switch_register() is also
bogus, because ksz_switch_detect() sets it to an initial value. So
remove it.

Also, ksz_platform_data :: enabled_ports isn't used anywhere, delete it.

Link: https://lore.kernel.org/netdev/20231204154315.3906267-1-dd@embedd.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Daniel Danzberger <dd@embedd.com>
---
 drivers/net/dsa/microchip/ksz_common.c      | 21 +++++++++++++--------
 include/linux/platform_data/microchip-ksz.h |  4 +++-
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 9545aed905f5..db1bbcf3a5f2 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -1673,15 +1673,23 @@ static const struct ksz_chip_data *ksz_lookup_info(unsigned int prod_num)
 
 static int ksz_check_device_id(struct ksz_device *dev)
 {
-	const struct ksz_chip_data *dt_chip_data;
+	const struct ksz_chip_data *expected_chip_data;
+	u32 expected_chip_id;
 
-	dt_chip_data = of_device_get_match_data(dev->dev);
+	if (dev->pdata) {
+		expected_chip_id = dev->pdata->chip_id;
+		expected_chip_data = ksz_lookup_info(expected_chip_id);
+		if (WARN_ON(!expected_chip_data))
+			return -ENODEV;
+	} else {
+		expected_chip_data = of_device_get_match_data(dev->dev);
+		expected_chip_id = expected_chip_data->chip_id;
+	}
 
-	/* Check for Device Tree and Chip ID */
-	if (dt_chip_data->chip_id != dev->chip_id) {
+	if (expected_chip_id != dev->chip_id) {
 		dev_err(dev->dev,
 			"Device tree specifies chip %s but found %s, please fix it!\n",
-			dt_chip_data->dev_name, dev->info->dev_name);
+			expected_chip_data->dev_name, dev->info->dev_name);
 		return -ENODEV;
 	}
 
@@ -4156,9 +4164,6 @@ int ksz_switch_register(struct ksz_device *dev)
 	int ret;
 	int i;
 
-	if (dev->pdata)
-		dev->chip_id = dev->pdata->chip_id;
-
 	dev->reset_gpio = devm_gpiod_get_optional(dev->dev, "reset",
 						  GPIOD_OUT_LOW);
 	if (IS_ERR(dev->reset_gpio))
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/platform_data/microchip-ksz.h
index ea1cc6d829e9..6480bf4af0fb 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -20,10 +20,12 @@
 #define __MICROCHIP_KSZ_H
 
 #include <linux/types.h>
+#include <linux/platform_data/dsa.h>
 
 struct ksz_platform_data {
+	/* Must be first such that dsa_register_switch() can access it */
+	struct dsa_chip_data cd;
 	u32 chip_id;
-	u16 enabled_ports;
 };
 
 #endif
-- 
2.39.2

