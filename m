Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B3C7F35A9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjKUSKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbjKUSKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:10:14 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E46D49
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:10:10 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 25D893201A33;
        Tue, 21 Nov 2023 13:10:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 21 Nov 2023 13:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1700590208; x=
        1700676608; bh=9THkF506HhQTz9C2aPreqLigusizQOZKZ9S9SPw4Ix8=; b=R
        fM+P+rpd8/gzAOEjgSevOMGH6TmxL3DTvI3/JenoScBxBDTWs9bfenVLQeRHlMNN
        4mditM/FEOh+oaKYeIV8LWtVcCSNgqgbygHgC7kXOoSrP3AF0bL2QpPH2MuuEw6P
        oVs7P013LDLEfkdBiCJUyjynnHTvJ3837VXaQwojTa3tNZ92famopefHRIFjaO/b
        d0BfGyyQO1gyY4AZ2eQemMzlFhaU4TCRbVRUrkAf5f7d4Ao90gg03+nYz8LhU+K9
        Jj/oqFXcZruokVSvzaZHPZIgvbY10KIO7WpSeQdce2BBxGpzvdctJILX0n3f7+64
        ToKdpurlyvgmogwIyRE/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700590208; x=
        1700676608; bh=9THkF506HhQTz9C2aPreqLigusizQOZKZ9S9SPw4Ix8=; b=Y
        5vxS6QLUolf4z70vu5Iy5XIVF3v7nhRr5QGUzH6eP1zG+nli6h0FvGp9sriJAZD4
        F2Q2CFpNM2Lqhz3Kkpyt81pDfDbDL3zCCfw0ktMYPLEfUvYgOuEfv1fbB2TjEdb8
        WPn6stE0mvJfvvWEVH2lMzrHB4IM2FCwzVASuicFarxc6yEt16Tqw8zDd1cmBPid
        Cw9LsmsJ5uG8WeYHkc87YLLjpYF8iBqza69CKL1KP8x39F9SzZFUUtDP40dniM+t
        l6YSiL3vJqznVHpse/T9doxS+QHs+tuBZ++9ooapz7D92mVsjqpitBqnyGFiZF3l
        hF7IJN3/e4exYrg6wgGrg==
X-ME-Sender: <xms:gPJcZf5HNBhfGdc3Lo1GXV2HcwbFB7ethu2TJUaAR3P6Ub7wSBzk5g>
    <xme:gPJcZU73DjFxISzs89Rj1dPJ0bRW1IGtooCVxsm1hUx5z_Il-RK5X92z4_LBaHxIy
    7ufZvAOrRt5cxzdj5U>
X-ME-Received: <xmr:gPJcZWe41-x4B7B77_j7cyh65-Av7ce07YCC2gNylxuiZwd8XFNcO3gDABry9YvUVn0yq0slmmwgmNe2-MJDDjHGrEa_4B30vjPHLm9LN3IL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhk
    rghrugesfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeekuedvffeuud
    ekgeeiueffjeehgfekteefheeuleefudeugfevleelhfefgfejvdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhguse
    hfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:gPJcZQJ6XT1CsvCABLp7HpGteKSiOehIFeMOlWGonCWlLueVW0NWDw>
    <xmx:gPJcZTKDho6pt_qEdJ91qnH-N1OdHFr1grVmTuYdQjRBpOMbONksTQ>
    <xmx:gPJcZZxkI1i60P-SEP14syjtNLs4QzwRs_DNM6sZK-smM_dwK8wiFg>
    <xmx:gPJcZb1BQayje-amGoVmhbOeJ_Lg0vUFZPD8BaLzRnB1YVqNN-5xHg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 13:10:08 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoudation.org, philipp.g.hortman@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 2/5] staging: rtl8192e: renamed variable TXCountToDataRate
Date:   Tue, 21 Nov 2023 13:09:44 -0500
Message-ID: <20231121180947.9223-3-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121180947.9223-1-garyrookard@fastmail.org>
References: <20231121180947.9223-1-garyrookard@fastmail.org>
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
TXCountToDataRate.
TXCountToDataRate -> tx_count_to_data_rate

Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver/module rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c    | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 280e335cbb6d..fb8294f31a60 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -114,7 +114,7 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 nMcsRate)
 	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
 }
 
-u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate)
+u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
 {
 	u16	CCKOFDMRate[12] = {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18,
 				   0x24, 0x30, 0x48, 0x60, 0x6c};
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index d2cf3cfaaaba..0226a69f40c3 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1783,7 +1783,7 @@ extern u16 MCS_DATA_RATE[2][2][77];
 u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
 void HTResetIOTSetting(struct rt_hi_throughput *ht_info);
 bool IsHTHalfNmodeAPs(struct rtllib_device *ieee);
-u16  TxCountToDataRate(struct rtllib_device *ieee, u8 nDataRate);
+u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
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

