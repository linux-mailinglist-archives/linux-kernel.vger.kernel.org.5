Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F45D7F61CB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345883AbjKWOnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345876AbjKWOnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:43:45 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B883DD48
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:43:50 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D58623200A2D;
        Thu, 23 Nov 2023 09:43:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 23 Nov 2023 09:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1700750629; x=
        1700837029; bh=GA437atRox2oPURIGiXlxqMebZt5ndNZI36HbZNzvG4=; b=f
        sE/QkLKNixyVnObR0dRRFx/WXcgU6HLcunrQl7/eimp90EcFnIrj1wj3SELkEZAy
        /edQ8SuRrMS3T6RF4J/xmVjV91ZpneSGj9MnLPnTl/F24WY76eEXEoQtg+QB8DRw
        Px9HVNHYndGEiUJ/G80YaoqYR31LnwEQyU11pfRXO+hai5CIllx6T8rOT9gOmS4F
        XwPyzVZn8t/6DouuoO0XcBGGtq7jVuBpjlZNxptWhJ+7PdtFRkmLg15OBhYhbmyl
        xxbeRaOIWcX7vNh4ePEINmoKiLv21ffxi7JKS/+S/UnF9NdBtDIxpCSA3iQwb4D1
        0FcNLE53GNevioKRaz6Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700750629; x=
        1700837029; bh=GA437atRox2oPURIGiXlxqMebZt5ndNZI36HbZNzvG4=; b=T
        NtkENEOmgFf3EFbriwHH1eVY6TDir3fWe0Ougw8jvdRyckAc48OgRjk7BEer+B1h
        HJyRBW6kQyk+1l/TkvHfYPtshKF65nvBzdlYs+Cj9pwqb9HL9FVab5PM1TL+LJOO
        neB6sDthyfxThFKwzNnrOSeFD4vyIzOYn2xBP/2WVzdYpdbF4zbGlhTGEvAv7nfc
        itGKmcMzJ57MFGv4tUf5dUhpUNpJryBMmlg+M0YVrlInRBOhuKi095/hI9TEDWG/
        /uqDhWqzkXu74Be1PrzDbtpRG5K9tpzrxm7qxsJh9AzhT8PfEHvPBIgqJ+oEoAkH
        qb3G0DRZ56iAegnP4Km5g==
X-ME-Sender: <xms:JWVfZQTc_S0W0BZYxqYSUBEnPjwc8sWuCklkQx-CK3vIxFCEyyBgjQ>
    <xme:JWVfZdxhaDzccmalp0Kczb0Yrynat0YHGYYwNCGSK_SXY_k2QuxBQ3C4lrjK7colo
    l5g2m_51w1YbYSm4gw>
X-ME-Received: <xmr:JWVfZd2qjXYnhfGx9i1cfUMO7eAUjDmbYv2TkCp96Z6rB3A6WQJ9QbQMh6PipEgbPfV_TLI5WvExM0QsSKN2YYjZEoitNA5ZwX1zE5BZjbqq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehfedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:JWVfZUC6czCqfMkTHrZR6_Bs3hsFCAbNzyBVuKhXYSKMUD79_CYD-Q>
    <xmx:JWVfZZiR3wlK-HMX9V2zuPWIJFzse4kucRNs5lpztmXWrab9Yrs4mg>
    <xmx:JWVfZQoqBprE1ghlYViW5nM7uY5BXwV_ajnNA-BilkzMDAAGvuEy_A>
    <xmx:JWVfZesGAt5Wgsp2OTbtY6HgqOPJXMqBVr7N6C_3ibEYTiIQZ4QBfQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Nov 2023 09:43:48 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v3 1/5] staging: rtl8192e: renamed variable HTMcsToDataRate
Date:   Thu, 23 Nov 2023 09:43:33 -0500
Message-ID: <20231123144337.13112-2-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123144337.13112-1-garyrookard@fastmail.org>
References: <20231123144337.13112-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renamed variable from Pascal/CamelCase to Snake case the variable
HTMcsToDataRate.
HTMcsToDataRate -> ht_mcs_to_data_rate

Linux Kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver/module rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v3: Corrected versioning from v1 -> v3, includes change history.
v2: v2 was skipped over..v3 corrects this.
v1: Style and compile issues, asked to redo.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index e607bccc079a..280e335cbb6d 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -103,7 +103,7 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 	ht_info->rx_reorder_pending_time = 30;
 }
 
-static u16 HTMcsToDataRate(struct rtllib_device *ieee, u8 nMcsRate)
+static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 nMcsRate)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
@@ -422,8 +422,8 @@ u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 			bitMap = availableMcsRate[i];
 			for (j = 0; j < 8; j++) {
 				if ((bitMap % 2) != 0) {
-					if (HTMcsToDataRate(ieee, (8 * i + j)) >
-					    HTMcsToDataRate(ieee, mcsRate))
+					if (ht_mcs_to_data_rate(ieee, (8 * i + j)) >
+					    ht_mcs_to_data_rate(ieee, mcsRate))
 						mcsRate = 8 * i + j;
 				}
 				bitMap >>= 1;
-- 
2.41.0

