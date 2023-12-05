Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD06805C07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjLEQnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjLEQnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:43:00 -0500
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BE6129
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com;
        s=dkim1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dJAnMEW06iGwu/vdkpWFAyGu3mN364Y4LDQ8PGNg3OY=; b=OUdqO4xgW7hi9qHIebo2cOR315
        cEHIWdXLEMq9efn0KCaaQhZz/OStgkACge2ObVDmPyO1MGVZJUqVBVfTXSyWZIFRSC0jGey/0JjV0
        3bYBFa5ZuFbBtVfCq8ZO2NNIFE+vY539UhmrPbvsmDyukIHu5HTubfC2U9mHyOqO7L2ETdA7KmjmA
        rmM+l22Gfu0bdq9w0Wcl6IcMnjL5UtNs2ETZdAlW+MHNVF0BwqEr0KHykyJlv0CVOc53o0POeLj5f
        ARHoLR2jbvBD9lPzz3fCcMkKVaB3r+Gr4wZQiqlLsPrnlSKlFoMLLnNySMfUvxLEstK9sdZbhWGab
        EjgHaiHQ==;
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:57804 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
        (Exim 4.96)
        (envelope-from <dd@embedd.com>)
        id 1rAYTG-0001rH-1L;
        Tue, 05 Dec 2023 17:40:30 +0100
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_2000_2999 0.000000,
        BODY_SIZE_5000_LESS 0.000000, BODY_SIZE_7000_LESS 0.000000,
        CTE_8BIT 0.000000, DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000,
        HTML_00_01 0.050000, HTML_00_10 0.050000, IN_REP_TO 0.000000,
        LEGITIMATE_SIGNS 0.000000, MULTIPLE_RCPTS 0.100000,
        MULTIPLE_REAL_RCPTS 0.000000, NO_CTA_URI_FOUND 0.000000,
        NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000, OUTBOUND 0.000000,
        OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000, SENDER_NO_AUTH 0.000000,
        SUSP_DH_NEG 0.000000, __ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
        __BULK_NEGATE 0.000000, __CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
        __CC_REAL_NAMES 0.000000, __CTE 0.000000, __DKIM_ALIGNS_1 0.000000,
        __DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
        __DQ_NEG_IP 0.000000, __FROM_DOMAIN_IN_ANY_CC1 0.000000,
        __FROM_DOMAIN_IN_RCPT 0.000000, __FROM_NAME_NOT_IN_ADDR 0.000000,
        __FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
        __HAS_MSGID 0.000000, __HAS_REFERENCES 0.000000, __HAS_X_MAILER 0.000000,
        __IN_REP_TO 0.000000, __MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000,
        __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
        __MULTIPLE_RCPTS_CC_X2 0.000000, __MULTIPLE_RCPTS_TO_X2 0.000000,
        __NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
        __OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
        __RCVD_PASS 0.000000, __REFERENCES 0.000000, __SANE_MSGID 0.000000,
        __SUBJ_ALPHA_END 0.000000, __SUBJ_STARTS_S_BRACKETS 0.000000,
        __TO_MALFORMED_2 0.000000, __TO_NO_NAME 0.000000, __URI_MAILTO 0.000000,
        __URI_NO_WWW 0.000000, __URI_NS 0.000000, __X_MAILSCANNER 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2023.12.5.160315
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com; s=mikd;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=dJAnMEW06iGwu/vdkpWFAyGu3mN364Y4LDQ8PGNg3OY=;
        b=XwXKkndQrpTSA4hogizS9JNhQ2PHSz4Ls1MerZnZM1toJIiALLRw5R1+DtStkj+TqFFMdB6Agv984LpEFZWB0VY0aLiOk/zVgj/yL2o8Oy+QMgctWHvfjSPlBKGci2knMYSDn+sQ2M8W5d8IY4lu/yFXMBxDRuaLHJ2giCRGkhY=;
From:   Daniel Danzberger <dd@embedd.com>
To:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Danzberger <dd@embedd.com>
Subject: [PATCH net-next 2/2] net: dsa: microchip: move ksz_chip_id enum to platform include
Date:   Tue,  5 Dec 2023 17:42:31 +0100
Message-Id: <20231205164231.1863020-2-dd@embedd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205164231.1863020-1-dd@embedd.com>
References: <20231205164231.1863020-1-dd@embedd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dd@embedd.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: dd@embedd.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1rAYSw-00051S-Vn
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: dd@embedd.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
        by webmail.newmedia-net.de with esmtp (Exim 4.72)
        (envelope-from <dd@embedd.com>)
        id 1rAYSw-00051S-Vn; Tue, 05 Dec 2023 17:40:11 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the ksz_chip_id enums moved to the platform include file for ksz
switches, platform code that instantiates a device can now use these to
set ksz_platform_data::chip_id.

Signed-off-by: Daniel Danzberger <dd@embedd.com>
---
 drivers/net/dsa/microchip/ksz_common.h      | 20 +-------------------
 include/linux/platform_data/microchip-ksz.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index d1a1c876ba0d..15612101a155 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -14,6 +14,7 @@
 #include <linux/regmap.h>
 #include <net/dsa.h>
 #include <linux/irq.h>
+#include <linux/platform_data/microchip-ksz.h>
 
 #include "ksz_ptp.h"
 
@@ -203,25 +204,6 @@ enum ksz_model {
 	LAN9374,
 };
 
-enum ksz_chip_id {
-	KSZ8563_CHIP_ID = 0x8563,
-	KSZ8795_CHIP_ID = 0x8795,
-	KSZ8794_CHIP_ID = 0x8794,
-	KSZ8765_CHIP_ID = 0x8765,
-	KSZ8830_CHIP_ID = 0x8830,
-	KSZ9477_CHIP_ID = 0x00947700,
-	KSZ9896_CHIP_ID = 0x00989600,
-	KSZ9897_CHIP_ID = 0x00989700,
-	KSZ9893_CHIP_ID = 0x00989300,
-	KSZ9563_CHIP_ID = 0x00956300,
-	KSZ9567_CHIP_ID = 0x00956700,
-	LAN9370_CHIP_ID = 0x00937000,
-	LAN9371_CHIP_ID = 0x00937100,
-	LAN9372_CHIP_ID = 0x00937200,
-	LAN9373_CHIP_ID = 0x00937300,
-	LAN9374_CHIP_ID = 0x00937400,
-};
-
 enum ksz_regs {
 	REG_SW_MAC_ADDR,
 	REG_IND_CTRL_0,
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/platform_data/microchip-ksz.h
index 6480bf4af0fb..f177416635a2 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -22,6 +22,25 @@
 #include <linux/types.h>
 #include <linux/platform_data/dsa.h>
 
+enum ksz_chip_id {
+	KSZ8563_CHIP_ID = 0x8563,
+	KSZ8795_CHIP_ID = 0x8795,
+	KSZ8794_CHIP_ID = 0x8794,
+	KSZ8765_CHIP_ID = 0x8765,
+	KSZ8830_CHIP_ID = 0x8830,
+	KSZ9477_CHIP_ID = 0x00947700,
+	KSZ9896_CHIP_ID = 0x00989600,
+	KSZ9897_CHIP_ID = 0x00989700,
+	KSZ9893_CHIP_ID = 0x00989300,
+	KSZ9563_CHIP_ID = 0x00956300,
+	KSZ9567_CHIP_ID = 0x00956700,
+	LAN9370_CHIP_ID = 0x00937000,
+	LAN9371_CHIP_ID = 0x00937100,
+	LAN9372_CHIP_ID = 0x00937200,
+	LAN9373_CHIP_ID = 0x00937300,
+	LAN9374_CHIP_ID = 0x00937400,
+};
+
 struct ksz_platform_data {
 	/* Must be first such that dsa_register_switch() can access it */
 	struct dsa_chip_data cd;
-- 
2.39.2

