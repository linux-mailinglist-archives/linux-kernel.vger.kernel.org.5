Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C7D8062CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346618AbjLEXQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346603AbjLEXQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:16:08 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6236F1B8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:16:14 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 52C273200AD7;
        Tue,  5 Dec 2023 18:16:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 05 Dec 2023 18:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701818172; x=
        1701904572; bh=iwSjEUDCHjLDXFruixEeoEgAnGoqp14R4y4NW4pOLyc=; b=o
        TkrnQ7P0QwcZLCmSDZ0n5vIw+mcCzrPPnnWOFveXNFn3rngBKbr2W12OZX0bxE9e
        +dV52XM1vpF879IRVs2Lm43xgtygK3zeaFxecdoM6RZa4nbUqrZs1a6DX2iePX73
        kYEW2qNFAvvmUJfGkfrKXf2M+lXaHNPSJdME21D8fteyXXY0Jd22TTUSMGLOqBj5
        YSJLUxVT3Ttz1Nx264y3hahlWCCdE1DCEdCMKGOLWpUZZIk0EysT6BI4V0Z8z/O+
        vAH2S5TQNUeX00VLUR+A/SHVKOv0NOg6LhbIMtr1gJ6reqTD/3nLgTV55GlXzaK0
        MxS4p8Kptp2QcMA8BebgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701818172; x=
        1701904572; bh=iwSjEUDCHjLDXFruixEeoEgAnGoqp14R4y4NW4pOLyc=; b=J
        IIZsgwa4lgfB3TI/wr61HYUnd5Vqdo8ZLfnvffPiKkejAYnYgsCVGqFa66P1mTl+
        FNQ+rpy7aUQLXThI2FUfDsjFa2KpVVj+Up+GkWp8M35xs2gD85GIfPEExj0qG+uO
        Sb5pGgHpA8+OvSi9vHbcX8E8fGthJPWZpvCxIxqauTxQQBC1oS8Qov9vSVChRo+H
        XIwK3p8Lz0rUBLVVRnliCFsl5Ok7XNA3nX46g5HwF4XbSnlMtLw1mnFPJ9IgWAn4
        NHVA56EEu9JKdsM9uwIW/NT3k3hiYhvTOYlM7hsb28bNsN/Bn+k6AzlEsh0PL7k+
        1FEDjdISRGbSrFbKy6sKw==
X-ME-Sender: <xms:PK9vZR_Xj8p8mu5AE_-Twjz8rDaQK_CzSJK3IKAjsV0QDpyYsqkZ2w>
    <xme:PK9vZVuODvXRwNJelKVoSS-z1rq4WCkLf_bfLAnS38TIh8jZ6ySzVo0Rvt72L8esj
    IZnUxpy2Eit-CGo-pg>
X-ME-Received: <xmr:PK9vZfC2XIhHgW5Jmv0e30i43B6n6u7ZRwGIZRpvSDX0AVkIwynlGkDLoS80CQB8l3Yb6ja4l45kUlfQR5a87dmDHYSdVcjjLXeDuessUHc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejledgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:PK9vZVfw-GWp_cFiDC09mhMSSWwoctF0lH-8PvBbX6Gn2-rNzUWKaQ>
    <xmx:PK9vZWNDZFFS2PTCxYJhcM93nKaU-miNwPyOXnc3YntF8z18VaXeSQ>
    <xmx:PK9vZXk_Zja6OLEb-jV_6CKHj0w-bnGn3ovujoT_AdLtX-ZpQRy11A>
    <xmx:PK9vZTq7v70M9zfBfecgkiB29WYx0qqKFz6z0O2_9maappremjD4_g>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Dec 2023 18:16:12 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 2/5] staging: rtl8192e: renamed variable bRegShortGI40MHz
Date:   Tue,  5 Dec 2023 18:16:20 -0500
Message-ID: <20231205231623.23070-3-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231205231623.23070-1-garyrookard@fastmail.org>
References: <20231205231623.23070-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style issue, checkpatch Avoid CamelCase,
rename it bRegShortGI40MHz -> reg_short_gi_40mhz

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 411a1d61128c..825c60cbcacb 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -96,7 +96,7 @@ struct rt_hi_throughput {
 	u8 current_ht_support;
 	u8 bRegBW40MHz;
 	u8 cur_bw_40mhz;
-	u8 bRegShortGI40MHz;
+	u8 reg_short_gi_40mhz;
 	u8 bCurShortGI40MHz;
 	u8 reg_short_gi_20mhz;
 	u8 bCurShortGI20MHz;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index c8792f6397ed..580b1423c46b 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -72,7 +72,7 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
 	ht_info->reg_short_gi_20mhz = 1;
-	ht_info->bRegShortGI40MHz = 1;
+	ht_info->reg_short_gi_40mhz = 1;
 
 	ht_info->bRegBW40MHz = 1;
 
@@ -481,7 +481,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	ht_info->bCurShortGI20MHz = ((ht_info->reg_short_gi_20mhz) ?
 				    ((pPeerHTCap->ShortGI20Mhz == 1) ?
 				    true : false) : false);
-	ht_info->bCurShortGI40MHz = ((ht_info->bRegShortGI40MHz) ?
+	ht_info->bCurShortGI40MHz = ((ht_info->reg_short_gi_40mhz) ?
 				     ((pPeerHTCap->ShortGI40Mhz == 1) ?
 				     true : false) : false);
 
-- 
2.41.0

