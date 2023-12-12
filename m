Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB3E80F3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjLLQ5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235152AbjLLQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:56:16 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A57B7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:56:22 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.west.internal (Postfix) with ESMTP id 6FADE3200AB1;
        Tue, 12 Dec 2023 11:56:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 12 Dec 2023 11:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=fm1; t=1702400180; x=
        1702486580; bh=Fb0pDO1f0yINjQLVIJ/Z6Zltm4xMmfYmovEsSAll8kg=; b=g
        6gsWYvTMi6DJhpHpSIEWcHceSQI6os0nVX8dcEepSe6Y4Lj258hYu0P8oYR0lEKs
        Gv/AmldnUTQWb3l4eaug1N4/+yT800A9ZbS8PnXCjYcQWo2B+cSKtBvlt+g7kz+S
        Ll5vR33n81EC/4+qQFq8aMp5ucgItf+BBEWRgfUUjGLy5sd1YvyYZ1xovN/1In0n
        CyGZRS/0+NXVK5Yo3t2iOp+fgq61dg02AqSY01awMQ9caqW35BJifQfppKYRB4YI
        qNKC9QqaXkwYLM05UXNcQm2m/yMXWWZ2kcLsUBL1g4ZRYfAtlZRK+n0xWUFFGpc0
        NQ3C+jlU6Ng72tILlgm1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702400180; x=
        1702486580; bh=Fb0pDO1f0yINjQLVIJ/Z6Zltm4xMmfYmovEsSAll8kg=; b=T
        +HuUGq//k5tMytBxtuvF5POQDfUFv5wQUd+s7eye8tthOldTjQ0DPHWGlFl2+hSw
        OODdwKUpJj3IKmc91VyQLke1BJZtzL5PGBnhZgWnBgwWwdaoKFUr/hqzczgrvszn
        LwipiJVKoS2qJtr/Mriaj9zl2IhCtHSgjA6Bu0D7AUKlFyUdBAW79z19zMzYEAcr
        WOR6NnI0E+lApEv8z8TGHPUC61PHOMbBHTuIpjYeETU6JsvlNMZEi5rsSiGNo29I
        NnEuzJ1i4qf4R3sKRha80rW7sGWr9vEtw5K2OmB5tvJ0dh3eiOlw/Y2XMSXXZVvU
        8hsiPY1QPl0UNzRnoekHg==
X-ME-Sender: <xms:tJB4ZYbndnFr2KiecgN3o0AvYK4AABb3Fr77mxd2t067PMbv4VEt0A>
    <xme:tJB4ZTYUIQ-ViEaesluuTK1PnGvz96GZ7wSqCM47OibrATnzYAi4jTm6dW6QByW4j
    pUUwPiDlZMBKY_V-J8>
X-ME-Received: <xmr:tJB4ZS93ZpaPRBy7r20VV02zXXoWYgtdO9cpqIC3PPaNeicFapebthWWSR1mATAYKpS_ZE7IWeF0hp9vpeYGAAyRMikTgJkY6dB7fDp5gY8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:tJB4ZSpl7P6y2b7-_DBGnATL54Sb6VshcEH6BBCmsQzcba6JOhlDwg>
    <xmx:tJB4ZTqThtj4zSTopROp5-TlSXOwhFkQAFO0mas74cDd6csQahGD4Q>
    <xmx:tJB4ZQRo8Z85J4fI8I3MqoQYbRxf1tgHBNB5tnA2AynmZQKPhw-pig>
    <xmx:tJB4ZSVK9fcnRaFksNbnmi42TcXC9joDHn8dr4nJQ8KYTWoSsYquBw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 11:56:20 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 5/5] staging: rtl8192e: rename variable pCapELE
Date:   Tue, 12 Dec 2023 11:56:37 -0500
Message-ID: <20231212165637.17618-6-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212165637.17618-1-garyrookard@fastmail.org>
References: <20231212165637.17618-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style issue, checkpatch Avoid CamelCase,
rename it. pCapELE -> cap_ele

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 64 +++++++++++------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index add8f58b5b1e..25097f1935a5 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -251,7 +251,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 				  u8 *len, u8 is_encrypt, bool assoc)
 {
 	struct rt_hi_throughput *ht = ieee->ht_info;
-	struct ht_capab_ele *pCapELE = NULL;
+	struct ht_capab_ele *cap_ele = NULL;
 
 	if (!pos_ht_cap || !ht) {
 		netdev_warn(ieee->dev,
@@ -264,66 +264,66 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 		static const u8	EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
 
 		memcpy(pos_ht_cap, EWC11NHTCap, sizeof(EWC11NHTCap));
-		pCapELE = (struct ht_capab_ele *)&pos_ht_cap[4];
+		cap_ele = (struct ht_capab_ele *)&pos_ht_cap[4];
 		*len = 30 + 2;
 	} else {
-		pCapELE = (struct ht_capab_ele *)pos_ht_cap;
+		cap_ele = (struct ht_capab_ele *)pos_ht_cap;
 		*len = 26 + 2;
 	}
 
-	pCapELE->AdvCoding		= 0;
+	cap_ele->AdvCoding		= 0;
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
-		pCapELE->ChlWidth = 0;
+		cap_ele->ChlWidth = 0;
 	else
-		pCapELE->ChlWidth = (ht->reg_bw_40mhz ? 1 : 0);
+		cap_ele->ChlWidth = (ht->reg_bw_40mhz ? 1 : 0);
 
-	pCapELE->MimoPwrSave		= ht->self_mimo_ps;
-	pCapELE->GreenField		= 0;
-	pCapELE->ShortGI20Mhz		= 1;
-	pCapELE->ShortGI40Mhz		= 1;
+	cap_ele->MimoPwrSave		= ht->self_mimo_ps;
+	cap_ele->GreenField		= 0;
+	cap_ele->ShortGI20Mhz		= 1;
+	cap_ele->ShortGI40Mhz		= 1;
 
-	pCapELE->TxSTBC			= 1;
-	pCapELE->RxSTBC			= 0;
-	pCapELE->DelayBA		= 0;
-	pCapELE->MaxAMSDUSize = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
-	pCapELE->DssCCk = ((ht->reg_bw_40mhz) ? (ht->reg_supp_cck ? 1 : 0) : 0);
-	pCapELE->PSMP = 0;
-	pCapELE->LSigTxopProtect = 0;
+	cap_ele->TxSTBC			= 1;
+	cap_ele->RxSTBC			= 0;
+	cap_ele->DelayBA		= 0;
+	cap_ele->MaxAMSDUSize = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
+	cap_ele->DssCCk = ((ht->reg_bw_40mhz) ? (ht->reg_supp_cck ? 1 : 0) : 0);
+	cap_ele->PSMP = 0;
+	cap_ele->LSigTxopProtect = 0;
 
 	netdev_dbg(ieee->dev,
 		   "TX HT cap/info ele BW=%d MaxAMSDUSize:%d DssCCk:%d\n",
-		   pCapELE->ChlWidth, pCapELE->MaxAMSDUSize, pCapELE->DssCCk);
+		   cap_ele->ChlWidth, cap_ele->MaxAMSDUSize, cap_ele->DssCCk);
 
 	if (is_encrypt) {
-		pCapELE->MPDUDensity	= 7;
-		pCapELE->MaxRxAMPDUFactor	= 2;
+		cap_ele->MPDUDensity	= 7;
+		cap_ele->MaxRxAMPDUFactor	= 2;
 	} else {
-		pCapELE->MaxRxAMPDUFactor	= 3;
-		pCapELE->MPDUDensity	= 0;
+		cap_ele->MaxRxAMPDUFactor	= 3;
+		cap_ele->MPDUDensity	= 0;
 	}
 
-	memcpy(pCapELE->MCS, ieee->reg_dot11ht_oper_rate_set, 16);
-	memset(&pCapELE->ExtHTCapInfo, 0, 2);
-	memset(pCapELE->TxBFCap, 0, 4);
+	memcpy(cap_ele->MCS, ieee->reg_dot11ht_oper_rate_set, 16);
+	memset(&cap_ele->ExtHTCapInfo, 0, 2);
+	memset(cap_ele->TxBFCap, 0, 4);
 
-	pCapELE->ASCap = 0;
+	cap_ele->ASCap = 0;
 
 	if (assoc) {
 		if (ht->iot_action & HT_IOT_ACT_DISABLE_MCS15)
-			pCapELE->MCS[1] &= 0x7f;
+			cap_ele->MCS[1] &= 0x7f;
 
 		if (ht->iot_action & HT_IOT_ACT_DISABLE_MCS14)
-			pCapELE->MCS[1] &= 0xbf;
+			cap_ele->MCS[1] &= 0xbf;
 
 		if (ht->iot_action & HT_IOT_ACT_DISABLE_ALL_2SS)
-			pCapELE->MCS[1] &= 0x00;
+			cap_ele->MCS[1] &= 0x00;
 
 		if (ht->iot_action & HT_IOT_ACT_DISABLE_RX_40MHZ_SHORT_GI)
-			pCapELE->ShortGI40Mhz		= 0;
+			cap_ele->ShortGI40Mhz		= 0;
 
 		if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
-			pCapELE->ChlWidth = 0;
-			pCapELE->MCS[1] = 0;
+			cap_ele->ChlWidth = 0;
+			cap_ele->MCS[1] = 0;
 		}
 	}
 }
-- 
2.41.0

