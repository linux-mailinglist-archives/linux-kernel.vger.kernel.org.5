Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197EE7FC1BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345120AbjK1Oaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346199AbjK1OUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:20:22 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4621D5B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:20:25 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 284DA5C01DE;
        Tue, 28 Nov 2023 09:20:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 28 Nov 2023 09:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701181225; x=
        1701267625; bh=eCmsTIw1FtK/6Yvz/aSaClPBGjFp5JHXcHbDNG5elnw=; b=U
        fHJ/n56lVrVYi4Hc61cW0Mb0AZEzPmgEexHv45hWgaXNWL8gmy/WshuBIrw8KU53
        YbC5jkKBEv0i/0DOourjl1n8LvfWwSVHNZvGAWD1ulrxUi9rRiaa+s1CJGJq90gE
        h+cCv50FhU5iUhzeGdk6fUWc+w4xPezC1hl3Gpgqc83nGa64blgfYVS+hMrCIwrO
        z7xtPHPRSkyM64ADzW3B3lRSm+ops+Y9kGOq1hgMOQsE0zw8ZCh5meQYR5staBrn
        paSIr3t7H0rQfXbAzFjzRvj7GbR+V51H57Qop97bsm8G23GRelkUhmSsmtL3QXla
        Is2MeajPVaK6gWbtbHAcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701181225; x=
        1701267625; bh=eCmsTIw1FtK/6Yvz/aSaClPBGjFp5JHXcHbDNG5elnw=; b=3
        h0vIrXMVDjY+5NpjSNv63V9/mOdDYuY+4h3AKdsFyhyGva+JoZcIXGXTftNA6sUQ
        iO6KmG7WItr/EoW30HbV4Y7PkUOmafAZIpX/u4f2cCX7A0VJfNaCXMv+TP3RvAtj
        uEK89AhUDfuM2uIcNS0hT8nLDxsGmMLpjm8kfHWzyfCzn+KlJJvFqZgFMxlUJjGZ
        LWzFUopb9JqMGF6rnPjIytKvyl2YPvcj+Er++Fda+swdsEOri0XY3zLF6o6nTfdl
        IerQ0OZx8JP5JpZ7uRPvI/ho6edSHY9SO7s0XhtIm1foG64Gm2Mh+2ch5d6EqNdc
        xP+ju0n0rTXinoBBlztSQ==
X-ME-Sender: <xms:KPdlZcOqc0WCMiWDZ5UJfihs2xHaJ5B9UjSpqLcYN7gruEdNV8YCRA>
    <xme:KPdlZS8DZUuFQSPkALDPdtjH2aNz-ZjjC2dGxYmC03SQsiRRVonnQ_5vxNwFyv5oD
    Y7okLofdyAz4VH7RlA>
X-ME-Received: <xmr:KPdlZTTtkoMxLALFNg88lNNeF_ODcmvKrJZzevBb0DIOnE6s8xyaKkETYC0p-RCuY7XBIfjpWe4RJ_8vE1oGvRXnV789QF1t9igG_MluVWwz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:KfdlZUsjfw8Ol0ih6RJ49aXp0oPLhIhq4sL1SE69DdnQIrkCi8d29g>
    <xmx:KfdlZUctP6KwOPInXLetfFUjNi2li2DWH032l40sznHxSNppTu5ewg>
    <xmx:KfdlZY2t7qeNuAq53qqCgTXqzvvuiF_v6945sVE8k3K_ZXQQGY-dZg>
    <xmx:KfdlZc5XmHEDMsjbBQZqUS6luBJwcvW3FANfwq_Zq-2BJPaN43W-2Q>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 09:20:24 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v2 1/3] staging: rtl8192e: renamed variable nMcsRate
Date:   Tue, 28 Nov 2023 09:20:25 -0500
Message-ID: <20231128142027.15617-2-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128142027.15617-1-garyrookard@fastmail.org>
References: <20231128142027.15617-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: Renamed from CamelCase to Snake case the variable nMcsRate, and
additionally removed the Hungarian notation of (n) that [v1] did not.
nMcsRate -> mcs_rate

Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver/module rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v2: Removes Hungarian notation.
v1: Renames from CamelCase only, Hungarian notation unremoved.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 00273d709f3c..4ed72936eb4a 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -103,7 +103,7 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 	ht_info->rx_reorder_pending_time = 30;
 }
 
-static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 nMcsRate)
+static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 mcs_rate)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
@@ -111,7 +111,7 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 nMcsRate)
 	u8	isShortGI = (ht_info->bCurBW40MHz) ?
 			    ((ht_info->bCurShortGI40MHz) ? 1 : 0) :
 			    ((ht_info->bCurShortGI20MHz) ? 1 : 0);
-	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
+	return MCS_DATA_RATE[is40MHz][isShortGI][(mcs_rate & 0x7f)];
 }
 
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
-- 
2.41.0

