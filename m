Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7DE8062CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346596AbjLEXQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjLEXQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:16:03 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A511AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:16:09 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id DF1933200AD7;
        Tue,  5 Dec 2023 18:16:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 05 Dec 2023 18:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701818168; x=
        1701904568; bh=THCdElhyvWkZbj7sCkvWw3NvcixUHD2ZPoSOA/uOitg=; b=f
        tAgWcLCrX9rW5OhCqJauo/DCOp/h35bvNOHw3nIBXyiD91Fgxei06dR6o9I8bE4b
        ipYPVjwQJP4vNdBcuiF8trOcnFt0oHAnzcqTHHKaWnznO6A2FYQCK/MzzUb5k4pE
        AfBztf5J3+85AlLXnbnz4LoTOFu35jKa1MF3mcZOCs99O/EQ8XMbFG9gMYvxKjZG
        l8oomCZi9/KPQRa0/F5hnVACy1lnE1M9PUGOesHtQoRGoKvzuh0uzyUn1NxwllWE
        HAjhp3xhzSGR8Kd/Iw0WFmeobVRPvxQQMldOEq9a8JKiWbaMMsVIqs4m6bozzwQm
        ZeETZWgKBDg9yEEKzJNxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701818168; x=
        1701904568; bh=THCdElhyvWkZbj7sCkvWw3NvcixUHD2ZPoSOA/uOitg=; b=U
        8Nlc/hu1VsJ0Hbs3yux2hmgtLCyiBi7USyVnw27bmPkKZq3HJQMILihUheKDL7zU
        Ai7oh75Lw2kbFxToNt+1JF49CI6IXe29hJdkool5HJDJRWTDU8xqNfadAPoV7z77
        OclM47QR2XYJLWxg2UVZVCNzbhFVOqJ/HbpwsCRckKwrxtBHzOtx5Uhp7DmPeQ0u
        VzwkEWyM9Sg/oxzy9QohauzzXvAdaXTcvcGD3xEIG/z0ALr7F2hMnRwRRZYHAczM
        DXnI7T5btmLEHEFgEdS/5kZ73Om5Jd6yqaJWuIrGJF8u89EE/j99G8U21a3ti9wy
        oAbDheys7Lzji3F+GfzYQ==
X-ME-Sender: <xms:OK9vZfsdpZHsstU-jULTnxZXULv-hr46FvQ5HsB5VzjOYU0U7E_k3A>
    <xme:OK9vZQdil_FP7JvA61N8mx-RENBQ1mr3ZGvlnaFLQ8mdaLK823jworOPEyHlIw7PF
    KVaQIeTWhi0nHr_Fac>
X-ME-Received: <xmr:OK9vZSxfW0dATTvyaothYgJaGz1NPKNMq5o81ue6VOzlXG5VVQ9V_2MzjgJhild4mk-eDJdcS-S_WCszhxP8Aeu1rST87BJ3ieH4MPF5lQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejledgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:OK9vZeN53KJ9BATItx8d2M163zaPNk3ThwVorNHPqcwufYiZS0P26A>
    <xmx:OK9vZf-b6eB8-maC-L67EvXzSePOKYAVgbcIGLudBRG-PoIoGpdKJg>
    <xmx:OK9vZeUhmRfwlu5ofvLu9rvrYOW5oRbW2xA5c_rXkxL8bNugyqiUJA>
    <xmx:OK9vZSb_iy0MZt52_SeSvZgHd4YSuTr1gFpEXgjeTxOpTc-E96bZDQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Dec 2023 18:16:07 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 1/5] staging: rtl8192e: renamed variable bRegShortGI20MHz
Date:   Tue,  5 Dec 2023 18:16:19 -0500
Message-ID: <20231205231623.23070-2-garyrookard@fastmail.org>
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
rename it bRegShortGI20MHz -> reg_short_gi_20mhz

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index dd86faab6f53..411a1d61128c 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -98,7 +98,7 @@ struct rt_hi_throughput {
 	u8 cur_bw_40mhz;
 	u8 bRegShortGI40MHz;
 	u8 bCurShortGI40MHz;
-	u8 bRegShortGI20MHz;
+	u8 reg_short_gi_20mhz;
 	u8 bCurShortGI20MHz;
 	u8 bRegSuppCCK;
 	u8 bCurSuppCCK;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f263f329db77..c8792f6397ed 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -71,7 +71,7 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-	ht_info->bRegShortGI20MHz = 1;
+	ht_info->reg_short_gi_20mhz = 1;
 	ht_info->bRegShortGI40MHz = 1;
 
 	ht_info->bRegBW40MHz = 1;
@@ -478,7 +478,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 	ht_info->cur_tx_bw40mhz = ((pPeerHTInfo->RecommemdedTxWidth == 1) ?
 				 true : false);
 
-	ht_info->bCurShortGI20MHz = ((ht_info->bRegShortGI20MHz) ?
+	ht_info->bCurShortGI20MHz = ((ht_info->reg_short_gi_20mhz) ?
 				    ((pPeerHTCap->ShortGI20Mhz == 1) ?
 				    true : false) : false);
 	ht_info->bCurShortGI40MHz = ((ht_info->bRegShortGI40MHz) ?
-- 
2.41.0

