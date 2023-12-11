Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14C80BE6F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 01:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjLKANU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 19:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjLKANR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 19:13:17 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FFBF5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 16:13:22 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id F2A293200063;
        Sun, 10 Dec 2023 19:13:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 10 Dec 2023 19:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1702253601; x=
        1702340001; bh=yUwGGRnLInSkH0LAfahlr0DV8GDYD5XZXZAg+x6BStQ=; b=Q
        qr9KnkXYnFzyPQMnoKGSwM/c5Y5kSIU4aHXnvE5Ib2Nep1ICBZZ9V3WrAcvs9TiU
        cXymovgpPa6D2t3mo39wN7cD4JoVd5zJ9c2hcD17FOVvqlBv43KbggzN6RzrlOnD
        lclzXH1F7nbyDpjM+VxyWu7/egDVuj++AfuGyXnajxR3sJ0Lu0ngTEcCNAvZJZLq
        s+p5qcjGZbe6wdYA5EkToc3eL+atR0gMIa3Tt8kRerICToIzkW8XX0tCtlLi7QBo
        /4tLHH1Pmo5inOrf1S5t8SkzCAhz6Y0qPOX3qb0LL9R0oBVBDvy2u0gsXoWatFMQ
        S8q33s7KQBg/Tioba/fKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702253601; x=
        1702340001; bh=yUwGGRnLInSkH0LAfahlr0DV8GDYD5XZXZAg+x6BStQ=; b=V
        wldNJzboFH7vIZXLWpCEnUv/xSae/i9HOt6w8oNek+wBFt0kFR6rSStlW9+GDETS
        EJtCctZCPyIXZQQ+BYyelEPCnAyXfBZ7DrQnv3xe8nYjPF0K8OCaJbFpRtT9U/8Y
        Wk3SNz/bgkq3HCMlR3ijjE/V6Hk8JS268r96i3N2ssMQemjVcsvPFxp6dkL1ZdWT
        BuMR0qG8BgXMrBZR7WEEkwPyCldVW/Q0Ewfy4nPrGkErAO58XNdinM6agM9gYL8f
        ikvUCYl1EWUexP0xlTKNVcXIwPHxOscnGvnlLQiwiFExd4obY0gq9SevYHsym/GK
        ho9eSBDSHsFb99k9AiGmw==
X-ME-Sender: <xms:IVR2ZVUBfG2EvALPPsq36wFOhg0ydywJ_o-GsJxcuVpwDpR83SVeCA>
    <xme:IVR2ZVkLUT9v7W8-n-OHk8DiH_EUjLY-EU2famLMXn7xlQ05ivhNzFNidsn7-pzeg
    XB_Q_FhHIIcskH3lmU>
X-ME-Received: <xmr:IVR2ZRYjIGEMnfHS6SjqRUG9hvMIDQigKVt6YeTx6o4a_3CqyFtGnTch8lGQWTbK80szOxDIol7DcBRSQGbxjxxQYicKRQPWzV31tpxXxHY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:IVR2ZYUgYOuHqBKWjmTRVZQCyQb1GDtUsXBmgIbgzQviEc06Wig1oQ>
    <xmx:IVR2ZfkaBSIYPpCtOdZ3k5TGXvjslEaaoOUXX_S4tMoShh6OTtCaWQ>
    <xmx:IVR2ZVfO2l5TAVDeyfvhhZZ8_A_aKscHnJTCRnlB6aZDLA7ATi_cFg>
    <xmx:IVR2ZdgHmOED_6c5Gc1bn8hLOEBVrIZzwMC1fweXnUQmsQhed0rDRQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Dec 2023 19:13:20 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 2/5] staging: rtl8192e: rename variable HTResetIOTSetting
Date:   Sun, 10 Dec 2023 19:13:32 -0500
Message-ID: <20231211001335.26169-3-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211001335.26169-1-garyrookard@fastmail.org>
References: <20231211001335.26169-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
rename it. HTResetIOTSetting -> ht_reset_iot_setting

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index e155a292f6b1..2a3cb6434100 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -240,7 +240,7 @@ static void ht_iot_act_determine_ra_func(struct rtllib_device *ieee, bool bPeerR
 		ht_info->iot_ra_func |= HT_IOT_RAFUNC_TX_AMSDU;
 }
 
-void HTResetIOTSetting(struct rt_hi_throughput *ht_info)
+void ht_reset_iot_setting(struct rt_hi_throughput *ht_info)
 {
 	ht_info->iot_action = 0;
 	ht_info->iot_peer = HT_IOT_PEER_UNKNOWN;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 51dcea57a329..e8c795faf4f9 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1772,7 +1772,7 @@ u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
 u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
-void HTResetIOTSetting(struct rt_hi_throughput *ht_info);
+void ht_reset_iot_setting(struct rt_hi_throughput *ht_info);
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
 int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 5c89744b2bbe..296c2ca643e8 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1215,7 +1215,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 			   !(ieee->softmac_features & IEEE_SOFTMAC_SCAN))
 				rtllib_stop_scan_syncro(ieee);
 
-			HTResetIOTSetting(ieee->ht_info);
+			ht_reset_iot_setting(ieee->ht_info);
 			ieee->wmm_acm = 0;
 			if (ieee->iw_mode == IW_MODE_INFRA) {
 				/* Join the network for the first time */
-- 
2.41.0

