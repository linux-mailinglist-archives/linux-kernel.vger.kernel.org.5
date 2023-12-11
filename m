Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D015C80BE71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 01:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjLKANc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 19:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjLKANX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 19:13:23 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A5DFF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 16:13:29 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.west.internal (Postfix) with ESMTP id 401433200A94;
        Sun, 10 Dec 2023 19:13:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sun, 10 Dec 2023 19:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1702253607; x=
        1702340007; bh=l9+VzySB0gw0n5S4jmMdo5qskQsKDEUo0nDqFjjTHyc=; b=J
        HP2Q3w/pu/VgtJUahD5j5cdG0DFwXJSQEYcAx9nUdg7NPrkeJOkQFEfcrJ3RlxQN
        xmZDgpbTe7HbWWi9Yv5XR2E04WMasIr1evzokfgyGvf4XrdhHkl+pNYkqaH3ixmO
        WzCh7pM/8sxoSkndx7zHpKuuVE7xU9OqReHPeU5Z9905ggOKSY9aXhg4sjeRwiUW
        euRx1L4yS8cIJBA7BF0bgr60Ms5Fd032H13S3ba3aetxHMAIAsSukW/C3T/aD9Up
        W7iPw9IV7WDvseHYpLnwWSvoNuUFBfiLo0eEjNExxRZLr4foggyjjRYB49/FDGYi
        l5zKsFt+PCPZ2UDz2hT+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702253607; x=
        1702340007; bh=l9+VzySB0gw0n5S4jmMdo5qskQsKDEUo0nDqFjjTHyc=; b=S
        6b20OgzwU+j+agz7yFzjviG5ZSi3MqhotdY+poREKpRJUceosPDYGfhsEcHZHHjl
        cK2Jdp/Y+a60gFrBm6z9xR2lHjoZMkXmso1qd05Svp1L9MH/wcrQpBm8ctAP+SG0
        xvkBHMFqRKP0sqgoyhbjGxxUI1JKP+44PxvA3ilPwxdNlAcv2+6cr3BiCvwqO0ME
        0Y9hTEhuFHsIzXdRJHtFGWbE/tMUu5/XLOeYZKn3tZ0zM2IIuJdn/WUZJWbUz/FL
        iymAmQRpyyqPLnX3hFfwEYMOE6J7syAH6vhWNYegjf25R+Oe6duQdFnwCjEiIX5Y
        gX5KVmpzwuw6AV3iylxeQ==
X-ME-Sender: <xms:J1R2ZakoXDB386SSI1u6IygvnL1qr9y3c2mwMNb4WqMCa4q6ne6_KA>
    <xme:J1R2ZR1Ch7XP-Fr2ylKcAdRHIqmuK_cOx3B8pbTCTupRq3-Ib86i3aFEmO8_nBgVz
    U7eOKoOwWWnV2gzN-o>
X-ME-Received: <xmr:J1R2ZYqMGeDIuLKF_GMwPsd6iC0FQ1cnYUzOqEH4u1LFO64-3utd70HIuU7MXDHOqxFVwjyXgII-5CGXwS_YJ0B_wg1vgzoWfBNvwxb3dis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:J1R2Zek-QN9TPyczoW_8gwrXPSyESn86Zm1t4RCHcWdzclt4hRsC8A>
    <xmx:J1R2ZY3j7w8SPRgSJYV8N8A1Fgv7R13AtBUu3KJD6838enyBqS42NA>
    <xmx:J1R2ZVstd9zhLf4mG-0BtINyysD3qGCnIvRMoQR0hgI7PvY779rDyQ>
    <xmx:J1R2ZVzDV2lWY8fmuCWiHbHZtMb3xySQVkDvXN75XEeI2uUtqd7S-A>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Dec 2023 19:13:27 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 4/5] staging: rtl8192e: rename variable HTConstructRT2RTAggElement
Date:   Sun, 10 Dec 2023 19:13:34 -0500
Message-ID: <20231211001335.26169-5-garyrookard@fastmail.org>
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
rename it. HTConstructRT2RTAggElement -> ht_construct_rt2rt_agg_element

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index c2c7fc316f62..a374f4c9f17e 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -328,7 +328,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *posHTCap,
 	}
 }
 
-void HTConstructRT2RTAggElement(struct rtllib_device *ieee, u8 *posRT2RTAgg,
+void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee, u8 *posRT2RTAgg,
 				u8 *len)
 {
 	if (!posRT2RTAgg) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index ff3ba9bca023..0d6144548c34 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1758,7 +1758,7 @@ void ht_update_default_setting(struct rtllib_device *ieee);
 void ht_construct_capability_element(struct rtllib_device *ieee,
 				  u8 *posHTCap, u8 *len,
 				  u8 isEncrypt, bool bAssoc);
-void HTConstructRT2RTAggElement(struct rtllib_device *ieee,
+void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee,
 				u8 *posRT2RTAgg, u8 *len);
 void HTOnAssocRsp(struct rtllib_device *ieee);
 void HTInitializeHTInfo(struct rtllib_device *ieee);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 9e9725ed8fa0..31a072e2a6d7 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -739,7 +739,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 			realtek_ie_buf = ieee->ht_info->sz_rt2rt_agg_buf;
 			realtek_ie_len =
 				 sizeof(ieee->ht_info->sz_rt2rt_agg_buf);
-			HTConstructRT2RTAggElement(ieee, realtek_ie_buf,
+			ht_construct_rt2rt_agg_element(ieee, realtek_ie_buf,
 						   &realtek_ie_len);
 		}
 	}
-- 
2.41.0

