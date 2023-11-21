Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F1B7F35C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjKUSPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbjKUSPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:15:04 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A07D54
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:15:00 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id ADA2E3201926;
        Tue, 21 Nov 2023 13:14:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 21 Nov 2023 13:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1700590499; x=
        1700676899; bh=yt9x+GFYOOcz+oCAtF66VyzySg0BOpnmmsYizNQZV7o=; b=T
        x6OyUJ6siGMgLCOSlmMPRlcgewz5t6hllwuUkz31sW6YbxKQnQcLEXxU2OTol58x
        ADSE55fjgZJSM1xaQk924oyU9AOCfKQnJP6uwV7GBIzXpB4+CMDSKGyzmeOOp8Yl
        jCTY9qJ3MC5IzcY0stT6Jcvm/JDK6nbt8zQWSFrr9kvrVZcvnMSTd6Kdf1ZAores
        sJvw3RZ5EFHOmWdYTiyefeEbbEarAvMsxnZx7Cf1WifUVRHD2hmIn89611Ju6OgP
        sQer1t6TIHUFvioXnUZQ5z4dMQE6BCsQJMtaq4bszIKCl6+058NsaVPobkqxNJk/
        1OfFy51seUH9vG4x55aQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700590499; x=
        1700676899; bh=yt9x+GFYOOcz+oCAtF66VyzySg0BOpnmmsYizNQZV7o=; b=J
        dTrRogRjZog6Npk/fbuHWmNvQ+yXoM/hVJddWN3g47j1QhftGeW1Q6Wpr4TPzYoI
        XCe+mPfRT/brI2EXx6HKoZfoYh3xxRTkphSmjrrobOiFUMtKweEnem+inJYR9D3G
        3lH3wM0cI5Sid5O6XQnbhRVfusW5GRFUrQ5S6IAUEb81ltZyMx+xYuKZ38s/fTmy
        1TItTanJjtNrRLXaKjUaxXXftZkZg3myiL33PN0tF2jlLd0jgHm2X6nZTUjodqWi
        XKy8iH35lMVlpIdo4ffznSCDIXqujYPZzYQLJgyXtBlhe7jjUCzJqUhQs+oOMlHZ
        Yxtzo87lvaM+prTx0mW3g==
X-ME-Sender: <xms:o_NcZc5Flqt9IOM9xVpyxeYCze2ix-_tWWE5SuQaYbSgIWST6sF-FQ>
    <xme:o_NcZd7okFciI0Mml9oz0ESVJ88A53kevkcUnfMYkywmzAauBIAEmaqkJUHTyq8CX
    -iFBFsFKnWwOtQbCY4>
X-ME-Received: <xmr:o_NcZbfy8qFMoTu1KbWh-jgR2mHufJ0jngNJLSoD8UX3n-foNW-tMOLX3IiqjNukoyjTT1fEA1l33r4cQwzsOWDYSOzmNCmlz65wPO5FWLpr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhk
    rghrugesfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeekuedvffeuud
    ekgeeiueffjeehgfekteefheeuleefudeugfevleelhfefgfejvdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhguse
    hfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:o_NcZRIuGfI0t64dL_UntwC0yD9eMUmXVNqQPn-7gSOOZ5GbURnxyw>
    <xmx:o_NcZQKO-AQJ5U7k4PDVZjMn2bOi13HLbXuTkyaJIhhXXNsLAJ8c7w>
    <xmx:o_NcZSzfKJSH2bgPGRrAzvQRV3AeDKu0JRWTsXKf2w4fQbfJUsvO3g>
    <xmx:o_NcZU1-5fZ-u5SBCNGsPrQAqGBkej2gT6CsMXMThbe6CeCocUJ51Q>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 13:14:58 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 3/5] staging: rtl8192e: renamed variable IsHTHalfNmodeAPs
Date:   Tue, 21 Nov 2023 13:14:33 -0500
Message-ID: <20231121181435.9337-4-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121181435.9337-1-garyrookard@fastmail.org>
References: <20231121181435.9337-1-garyrookard@fastmail.org>
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

Renamed from Pascal/CamelCase to Snake case the variable
IsHTHalfNmodeAPs.
ISHTHalfNmodeAPs -> is_ht_half_nmode_aps

Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver/module rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index fb8294f31a60..0993263c13d3 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -139,7 +139,7 @@ u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
 	return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate & 0xf];
 }
 
-bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
+bool is_ht_half_nmode_aps(struct rtllib_device *ieee)
 {
 	bool			retValue = false;
 	struct rtllib_network *net = &ieee->current_network;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0226a69f40c3..6b549629087b 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1782,7 +1782,7 @@ extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
 u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
 void HTResetIOTSetting(struct rt_hi_throughput *ht_info);
-bool IsHTHalfNmodeAPs(struct rtllib_device *ieee);
+bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
 int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 42d652fe8601..89bc38774fa7 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1872,7 +1872,7 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 		ieee->softmac_stats.rx_auth_rs_ok++;
 		if (!(ieee->ht_info->iot_action & HT_IOT_ACT_PURE_N_MODE)) {
 			if (!ieee->GetNmodeSupportBySecCfg(ieee->dev)) {
-				if (IsHTHalfNmodeAPs(ieee)) {
+				if (is_ht_half_nmode_aps(ieee)) {
 					bSupportNmode = true;
 					bHalfSupportNmode = true;
 				} else {
-- 
2.41.0

