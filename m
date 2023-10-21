Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80FD7D1FA3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 22:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjJUUsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 16:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUUsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 16:48:13 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CFE197
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 13:48:07 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id 83A9E5C01F2;
        Sat, 21 Oct 2023 16:48:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sat, 21 Oct 2023 16:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1697921284; x=1698007684; bh=BDYJzfq9i/
        puSDcqQUW+jA4P44FDJOi4JPAwuK9QcPc=; b=UDJXpTQf0EkvwkhZ9bzLDTZqvO
        GkJMOW2/uAsza0CrjjDSwQxeFvFew6L3vt99IHc9aJoj5/9RJ5POwNTE1QSIFbUL
        kl4zH2c6RXVBrC6fsxSIfc3S5pzfGrjnXvOaZpqhHMGHomHNrd16rZPuOYlBZQv3
        kKMCGOxGRGkKJe9994xsmy24gEr+cOagXjsASt7Tz8A7mbyNhH7/v0dgfIgyoJin
        LfErPgpB4xuhj3w6mFbDammZYUKJ3cyTRqqTA1AEE09qygvQkw38vytgSykHCP4q
        BHMkOc3a+YnW6ggMVxlNCljCRRMTRJJVpBAX/4w7VE+/0ndGDnXdEAQWG3Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697921284; x=1698007684; bh=BDYJzfq9i/puS
        DcqQUW+jA4P44FDJOi4JPAwuK9QcPc=; b=QSmWyIIBFrlvm8NAi8JuHDc73POMU
        h8cxLXhnhafyXBAn9obSoLJshRWJAupYK3tlJ5dm42jMuUtfL3V1Khj/l9cma5fd
        7ywhJ95525OSBZT+WpU1uS1oo603uSMp8HDOakl5KjNohB5A9Es8XntWpqjIU1po
        YtcBxpDAM1EIGrL0M+dbrOmfvWCrN6XyUvlqqpYoUnL2sVumjBbMDlWRTi1NW2Dn
        OiTRtiC0SyBa8sgvP1NUyID4SBD1VShH5IPyGD4TsF+DxWGM6WDy21psVpPOkO06
        ZzJDymhnHsQ7RtE0HgE8xpERcEYIAZrSyMpM9YZccIKKN6g8L0LRKIO+w==
X-ME-Sender: <xms:Azk0ZX6sGE1Lws33kahYVkUzfGODfpFK192atetg7pzfNu3Y2GLRpg>
    <xme:Azk0Zc7BmI5qdwVWqyEXhFO-LiG2Q9PlE_2Na1XFmszyrJ0rB14TuN5_Wjd1VFlun
    1IgCvOSmdaB8QsMC44>
X-ME-Received: <xmr:Azk0ZefwcTr2P4mzzlp5xVN5oDm2X-F7su7RzSD0W8658fSQpCNBvOBgisnn1xl3YoYrOxTKo0cz0KLAMA-mVIOGkZYiSC1gsLTGsjKI_EY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedtgddugeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:Azk0ZYKIyuyUNkiONq0PVAQh3_amsy4s9pUHa0Ty8lspNFcBQea-qQ>
    <xmx:Azk0ZbKv_JjKF6HzEC-fFoP9tu69ENXOGnyuGw4rdvfy7h8fEd4bqw>
    <xmx:Azk0ZRxXb_72IpA4gHXAsYxvAZ94mNyulCsYJuhzaVGw5mSvEkmt_w>
    <xmx:BDk0ZT0EKdRZR9wHdn0rtPiwpudTEa3UthILhVeFNiWUyjfjPG5ChA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 16:48:03 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH] staging: rtl8192e: renamed variable TxCountToDataRate, spacing, realignment
Date:   Sat, 21 Oct 2023 16:46:55 -0400
Message-ID: <20231021204655.6570-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1) Renamed from Pascal/CamelCase to Snake case the variable
   TxCountToDataRate, TxCountToDataRate -> tx_count_to_data_rate.

2) Made a realignment w/open parenthesis adjustment after renaming.

3) Corrected spacing.

Linux kernel coding style (cleanup),checkpatch Avoid CamelCase,
checkpatch Alignment should match open parenthesis.
Driver rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 00b21542ddc3..304f2ab0be3e 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -114,7 +114,7 @@ static u16 HTMcsToDataRate(struct rtllib_device *ieee, u8 nMcsRate)
 	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
 }
 
-u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate)
+u16 tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
 {
 	u16	CCKOFDMRate[12] = {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18,
 				   0x24, 0x30, 0x48, 0x60, 0x6c};
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 9d141aad8cd5..5c8c7caf2c17 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1784,7 +1784,7 @@ extern u16 MCS_DATA_RATE[2][2][77];
 u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
 void HTResetIOTSetting(struct rt_hi_throughput *ht_info);
 bool IsHTHalfNmodeAPs(struct rtllib_device *ieee);
-u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate);
+u16 tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
 int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index f32584291704..52c9c2c873b1 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -208,8 +208,8 @@ int rtllib_wx_get_rate(struct rtllib_device *ieee,
 {
 	u32 tmp_rate;
 
-	tmp_rate = TxCountToDataRate(ieee,
-				     ieee->softmac_stats.CurrentShowTxate);
+	tmp_rate = tx_count_to_data_rate(ieee,
+					 ieee->softmac_stats.CurrentShowTxate);
 	wrqu->bitrate.value = tmp_rate * 500000;
 
 	return 0;
-- 
2.41.0

