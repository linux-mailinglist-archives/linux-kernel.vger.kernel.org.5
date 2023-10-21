Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE647D1FDA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 23:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjJUVc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 17:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJUVc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 17:32:57 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8C2D46
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 14:32:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DFDE35C0167;
        Sat, 21 Oct 2023 17:32:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 21 Oct 2023 17:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1697923969; x=1698010369; bh=iuaUmNApo5
        6iBDizUoXTYoODk/aNqNypD6ay62Ux/kg=; b=GCdIiI3BZHBhTX3nYbcHvPENRX
        0vnNSlUQnkHUbEGMEk/IvCN8q1tzZi9bEASdkPcRX3aDiVfx5f83yx0H80p3nm9W
        vCUKOTdMN+RXJU0++jLHQOSmPLkrlTe0CugnXEcsvv/bMvdUqJbhxhEWOma0kKBr
        EqVGhPSV8upJx83nMIkx60KdnajbtnC0D5Q7PAPtF6p8VPSqOFhFmY1BY8FekfF4
        o8UMDs+gvFFMEQcUZHhubpLPJqNWiEoo8KCG2Dw57PQ1MQhfaRXeU7UbIvTUQw5V
        IoB/SCGvP4S1hYo1iWhjFF7siXgl4G5MSM0ZGqcrDd+O+kIHckS8eQy9xFUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697923969; x=1698010369; bh=iuaUmNApo56iB
        DizUoXTYoODk/aNqNypD6ay62Ux/kg=; b=BawpJx4kn553lQcmdNSR7OpgPTp29
        Wd/Zc1YUE4osmMAthf2i5iZ+3A6CgJdFk56gfKRNTOc/MZ43ikmSW9puXNnkjkYp
        Bj8FT9dCsoy9iE6H8QS13xBdmbd8KD0Usy3iV3H9A6DA9rWKb5roJ1wwNDfVn42l
        gAPNKQdLyhDeS2CybnAWhahi4qO5XO26gdOXySKAdU7rrO1uPI8G72a4tdvqhvcC
        YxF21rD2Bj5oQ5xCvK8RDmxf6UYBIE/FIgMEiko08ls11nyAI6btQPFg+4iUKHIo
        cO6dZ8bJzt2nrSaABge0dcqz2vxIkJMnrECuQvaP3EVQu8WJEo2PnZ8eA==
X-ME-Sender: <xms:gUM0ZaeF2DPVunHWxqi8apSzIwo5xF1zb8T-GkwKKJKWZrrwZZvJiA>
    <xme:gUM0ZUMOL-tI45O049PZcJaHv1ggY39ukcX9uYX-4RExmGYyj1XpUbMvAqOl9cr7g
    tlcpaEz4rALDZMi1cY>
X-ME-Received: <xmr:gUM0Zbic_aCTExWvcC6W6XiGnmd9tZ_aqVvIXlBSMxXbSv6JGI6scUcymdi0W2Zgpz1sOQgfmjFnVchVdgCcUga6YK93E1bbo6MSpsisvPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedtgdduheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:gUM0ZX92TLWPwnzX17vLGn9xYJqksornOT2camy5K-48-_y8LmUeQg>
    <xmx:gUM0ZWtSXH__JdJv5U9Dd4QCfOqxyzOV8kuBimCeKqgbDqYw2tGtWw>
    <xmx:gUM0ZeHV5XFv7jlDmtg35aA49r-NHQEJbg_1Ge_wpknUyQXLYJhxdA>
    <xmx:gUM0ZaK2pPyXJwA88RHMbv6ng4rJHl9j8gER-lH2-q7i_LpH3MmfOw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 17:32:48 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v2] staging: rtl8192e: renamed variable TxCountToDataRate
Date:   Sat, 21 Oct 2023 17:32:02 -0400
Message-ID: <20231021213202.6244-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renamed from Pascal/CamelCase to Snake case the variable
TxCountDataRate, TxCountDataRate -> tx_count_data_rate.

Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 00b21542ddc3..8070a152712e 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -114,7 +114,7 @@ static u16 HTMcsToDataRate(struct rtllib_device *ieee, u8 nMcsRate)
 	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
 }
 
-u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate)
+u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
 {
 	u16	CCKOFDMRate[12] = {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18,
 				   0x24, 0x30, 0x48, 0x60, 0x6c};
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 9d141aad8cd5..6a9550eaf148 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1784,7 +1784,7 @@ extern u16 MCS_DATA_RATE[2][2][77];
 u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
 void HTResetIOTSetting(struct rt_hi_throughput *ht_info);
 bool IsHTHalfNmodeAPs(struct rtllib_device *ieee);
-u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate);
+u16  tx_count_data_rate(struct rtllib_device *ieee, u8 nDataRate);
 int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_DELBA(struct rtllib_device *ieee, struct sk_buff *skb);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac_wx.c b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
index f32584291704..28aba1d610f7 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac_wx.c
@@ -208,7 +208,7 @@ int rtllib_wx_get_rate(struct rtllib_device *ieee,
 {
 	u32 tmp_rate;
 
-	tmp_rate = TxCountToDataRate(ieee,
+	tmp_rate = tx_count_to_data_rate(ieee,
 				     ieee->softmac_stats.CurrentShowTxate);
 	wrqu->bitrate.value = tmp_rate * 500000;
 
-- 
2.41.0

