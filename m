Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8BA80F3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjLLQ5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376773AbjLLQ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:56:12 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F81895
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:56:19 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3BC913200AB1;
        Tue, 12 Dec 2023 11:56:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 12 Dec 2023 11:56:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=fm1; t=1702400177; x=
        1702486577; bh=/+M9IjnFHxdC7RuAIS3s25vkqInV/9zFKLtDT3kzv/I=; b=b
        ke5HObmZP9BQYI/hHrINGwDrAF+NarFlwX7RQpZc7Ru7wZX09bhVCJVlJ4STMPg/
        gUZ0qyOC5SBZEbZviPmTGu8GjNFZQyegs7IcZ0nrHkLGlIzmmbHBKvgd8jXBRC6t
        7l66I6RtmBX3DpdofJqUmHW5zbMCl1U4D7F1gR0CwWAdGQty826c97XOWSiBA7zw
        +j0z3tvQW8emWlWF0TTsV5sKDI+iiLp2+TrT7Xsd1WLc8gzqXeOfRgUg9amktW3P
        XAisCXMwGjiH9bCEQKW6R67NZWBhiavo2eTnF8aHxggtpnQBZm9bDCwOF+yI4RFo
        JMmUP/QYzKVTfel/X74ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702400177; x=
        1702486577; bh=/+M9IjnFHxdC7RuAIS3s25vkqInV/9zFKLtDT3kzv/I=; b=G
        OOIDE1MnLrFSx5wStnhMYJh+DKiya9bjvuP+qRev9D7K71WwITEcywYyGOrQ3RdB
        B1TrYwDBTuzitvCRaQHu/cjskZPolyj1TxiwpYkxtox9k5+8kRdGtqBpqQ18hl7u
        Dv5wAKzexjsKglVtuZ4S5oWBMt2mDV002M9HMj5SjwztjBG9Y410ZocTox2+8Esl
        R6TOFtFs/YZ6G/tjCsAqJpVTZU6VoZe0OEfYcSpcVdtKFN5r9m2/Dyx1nS5sNnmI
        puWHIbvxGI1Ki2Wm4iAvOucSTnPQ5MujG8McWnhoHg1SxFPKIjHDsR9Z7N+n9lZV
        FlkqOOUYW+63oE2GMTThw==
X-ME-Sender: <xms:sZB4ZRjukcASlLblo4xLNvyQ3-kHqR7K-0ZkenzhXGJXxNK4R3qEMg>
    <xme:sZB4ZWAMIrDnRngNCg-8NbeCXj_6yQ6qS6HVBnfLQc6vY9mxNagVzYxvc9P_wlY_1
    SIhoXOHtxBWg33-bfQ>
X-ME-Received: <xmr:sZB4ZRHdfTVbMpJyDyAdn72AOZwKZ0ja4kFvJj8gPpBs2Q_k7sQ9oIqhvWd64E5WbyFoJribJax3hPTu72-t6p7rhHRgWnaSqAPwdwudcAs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:sZB4ZWTSw6lypB0-AYDiAK5Q0QhLXRLX8JHwQrpOgx0FWBAZyHo88Q>
    <xmx:sZB4Zeww2h9LINjE9_7JLApe_IJFxPfEIcj_TbE9J7Zkreu0lggOFQ>
    <xmx:sZB4Zc54UdpdoT7szCPhgUciBHrYQ_8lf7RU_17rDqsgA1MlQW8FZQ>
    <xmx:sZB4ZS_q9gu6ndnzTZqEn0Fpgteu1hzICRZcry7cw4OPh0drH3r0Jw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 11:56:17 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 4/5] staging: rtl8192e: rename variable pHT
Date:   Tue, 12 Dec 2023 11:56:36 -0500
Message-ID: <20231212165637.17618-5-garyrookard@fastmail.org>
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

Coding style issue, Avoid CamelCase
rename it. pHT -> ht

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index ac85151a6069..add8f58b5b1e 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -250,17 +250,17 @@ void ht_reset_iot_setting(struct rt_hi_throughput *ht_info)
 void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 				  u8 *len, u8 is_encrypt, bool assoc)
 {
-	struct rt_hi_throughput *pHT = ieee->ht_info;
+	struct rt_hi_throughput *ht = ieee->ht_info;
 	struct ht_capab_ele *pCapELE = NULL;
 
-	if (!pos_ht_cap || !pHT) {
+	if (!pos_ht_cap || !ht) {
 		netdev_warn(ieee->dev,
 			    "%s(): posHTCap and ht_info are null\n", __func__);
 		return;
 	}
 	memset(pos_ht_cap, 0, *len);
 
-	if ((assoc) && (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC)) {
+	if ((assoc) && (ht->ePeerHTSpecVer == HT_SPEC_VER_EWC)) {
 		static const u8	EWC11NHTCap[] = { 0x00, 0x90, 0x4c, 0x33 };
 
 		memcpy(pos_ht_cap, EWC11NHTCap, sizeof(EWC11NHTCap));
@@ -275,9 +275,9 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pCapELE->ChlWidth = 0;
 	else
-		pCapELE->ChlWidth = (pHT->reg_bw_40mhz ? 1 : 0);
+		pCapELE->ChlWidth = (ht->reg_bw_40mhz ? 1 : 0);
 
-	pCapELE->MimoPwrSave		= pHT->self_mimo_ps;
+	pCapELE->MimoPwrSave		= ht->self_mimo_ps;
 	pCapELE->GreenField		= 0;
 	pCapELE->ShortGI20Mhz		= 1;
 	pCapELE->ShortGI40Mhz		= 1;
@@ -286,7 +286,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	pCapELE->RxSTBC			= 0;
 	pCapELE->DelayBA		= 0;
 	pCapELE->MaxAMSDUSize = (MAX_RECEIVE_BUFFER_SIZE >= 7935) ? 1 : 0;
-	pCapELE->DssCCk = ((pHT->reg_bw_40mhz) ? (pHT->reg_supp_cck ? 1 : 0) : 0);
+	pCapELE->DssCCk = ((ht->reg_bw_40mhz) ? (ht->reg_supp_cck ? 1 : 0) : 0);
 	pCapELE->PSMP = 0;
 	pCapELE->LSigTxopProtect = 0;
 
@@ -309,16 +309,16 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *pos_ht_cap,
 	pCapELE->ASCap = 0;
 
 	if (assoc) {
-		if (pHT->iot_action & HT_IOT_ACT_DISABLE_MCS15)
+		if (ht->iot_action & HT_IOT_ACT_DISABLE_MCS15)
 			pCapELE->MCS[1] &= 0x7f;
 
-		if (pHT->iot_action & HT_IOT_ACT_DISABLE_MCS14)
+		if (ht->iot_action & HT_IOT_ACT_DISABLE_MCS14)
 			pCapELE->MCS[1] &= 0xbf;
 
-		if (pHT->iot_action & HT_IOT_ACT_DISABLE_ALL_2SS)
+		if (ht->iot_action & HT_IOT_ACT_DISABLE_ALL_2SS)
 			pCapELE->MCS[1] &= 0x00;
 
-		if (pHT->iot_action & HT_IOT_ACT_DISABLE_RX_40MHZ_SHORT_GI)
+		if (ht->iot_action & HT_IOT_ACT_DISABLE_RX_40MHZ_SHORT_GI)
 			pCapELE->ShortGI40Mhz		= 0;
 
 		if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev)) {
-- 
2.41.0

