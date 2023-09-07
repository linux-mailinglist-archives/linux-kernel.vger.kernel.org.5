Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB5E797B39
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343613AbjIGSJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343556AbjIGSJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:09:27 -0400
X-Greylist: delayed 3650 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 11:09:03 PDT
Received: from mail.as201155.net (mail.as201155.net [IPv6:2a05:a1c0:f001::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4DF1724
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com;
        s=dkim1; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:
        To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WpI7H1Gvt9lgGH2ycMO9T2GTxR9m0Eby2eQfvWe+3oI=; b=AdIuG8Oj4grTdZ0S72Aejf70Hi
        Gr+KGGaWXlsttLj64O5F0ePtqpua+2PjT5MiWIoFG4cN4KYOk8nvlY9MPX8kHwRa1XqBWmrGAKuTD
        XA2j518M+5yQJW/9/n9nmE+nhHqFEsBtGVHGNXQAskCeunmR8gSJxY/S629XH3N1+TBQzApsEaFYF
        jrvFszXdB+D1EULPwaJmKy0D0dtKTIIncqBDWI5Z1SGw3Au2hl1r+M7K7PBi6zyVOoxN7KQpFl051
        0S1OiN1N4ZzOT1zJD6gMCbGGaIeWksio2aCpo0D2gxn8lhnxuYaEJKGgQVLwdLjaO/SV83qLQN8TP
        UZ4F4XNQ==;
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:41570 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
        (Exim 4.96)
        (envelope-from <dd@embedd.com>)
        id 1qe8hd-0004qN-0c;
        Thu, 07 Sep 2023 08:41:21 +0200
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_1000_LESS 0.000000,
        BODY_SIZE_2000_LESS 0.000000, BODY_SIZE_5000_LESS 0.000000,
        BODY_SIZE_500_599 0.000000, BODY_SIZE_7000_LESS 0.000000, CTE_8BIT 0.000000,
        DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000,
        HTML_00_10 0.050000, LEGITIMATE_SIGNS 0.000000, MULTIPLE_RCPTS 0.100000,
        MULTIPLE_REAL_RCPTS 0.000000, NO_CTA_URI_FOUND 0.000000,
        NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000, OUTBOUND 0.000000,
        OUTBOUND_SOPHOS 0.000000, SENDER_NO_AUTH 0.000000, SUSP_DH_NEG 0.000000,
        __ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000, __BULK_NEGATE 0.000000,
        __CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
        __CC_REAL_NAMES 0.000000, __CTE 0.000000, __DKIM_ALIGNS_1 0.000000,
        __DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
        __DQ_NEG_IP 0.000000, __FROM_DOMAIN_IN_ANY_CC1 0.000000,
        __FROM_DOMAIN_IN_RCPT 0.000000, __FROM_NAME_NOT_IN_ADDR 0.000000,
        __FUR_RDNS_SOPHOS 0.000000, __HAS_CC_HDR 0.000000, __HAS_FROM 0.000000,
        __HAS_MSGID 0.000000, __HAS_X_MAILER 0.000000, __MIME_TEXT_ONLY 0.000000,
        __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
        __MULTIPLE_RCPTS_CC_X2 0.000000, __NO_HTML_TAG_RAW 0.000000,
        __OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
        __OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __SANE_MSGID 0.000000,
        __SUBJ_STARTS_S_BRACKETS 0.000000, __TO_MALFORMED_2 0.000000,
        __TO_NO_NAME 0.000000, __URI_MAILTO 0.000000, __URI_NO_WWW 0.000000,
        __URI_NS 0.000000, __X_MAILSCANNER 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2023.9.7.61216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com; s=mikd;
        h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To:From; bh=WpI7H1Gvt9lgGH2ycMO9T2GTxR9m0Eby2eQfvWe+3oI=;
        b=Ux8IqIPQcmekkpNKzo79g6FfdmBGB2m4YNw/Syni7+ReHwfYuHawzpwAsNgAllFgWMXIewBtq3KALcSQwvri3uz4qCyD/LlmShsX1iYk5Jrujdh7DbnE4ZIsvZJBWeRoCA96fcU9Kby5h2mQynK4vz6ViRVPzmqr0eu1f5kaFb0=;
From:   Daniel Danzberger <dd@embedd.com>
To:     johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, Daniel Danzberger <dd@embedd.com>
Date:   Thu,  7 Sep 2023 08:44:13 +0200
Message-Id: <20230907064413.1302336-1-dd@embedd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.113.177.185
X-SA-Exim-Mail-From: dd@embedd.com
Subject: [PATCH] gnss/usb: Add U-blox 8/M8 device id
X-SA-Exim-Version: 4.2.1 (built Thu, 26 May 2011 15:22:33 +0200)
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); Unknown failure
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1qe8hY-00063e-Gg
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: dd@embedd.com
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Received:  from [217.113.177.185] (helo=am5build.newmedia-net.de)
        by webmail.newmedia-net.de with esmtpa (Exim 4.72)
        (envelope-from <dd@embedd.com>)
        id 1qe8hY-00063e-Gg; Thu, 07 Sep 2023 08:41:19 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for U-Blox 8 GNSS devices

Signed-off-by: Daniel Danzberger <dd@embedd.com>
---
 drivers/gnss/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gnss/usb.c b/drivers/gnss/usb.c
index 028ce56b20ea..927f89a5b3f0 100644
--- a/drivers/gnss/usb.c
+++ b/drivers/gnss/usb.c
@@ -18,6 +18,7 @@
 
 static const struct usb_device_id gnss_usb_id_table[] = {
 	{ USB_DEVICE(0x1199, 0xb000) },		/* Sierra Wireless XM1210 */
+	{ USB_DEVICE(0x1546, 0x01a8) },         /* U-blox 8/M8 GNSS Receiver */
 	{ }
 };
 MODULE_DEVICE_TABLE(usb, gnss_usb_id_table);
-- 
2.39.2

