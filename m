Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD637D1FE0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 23:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjJUVzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 17:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJUVzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 17:55:36 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5D993
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 14:55:31 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 183965C024A;
        Sat, 21 Oct 2023 17:55:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 21 Oct 2023 17:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1697925328; x=1698011728; bh=DVK74q2dXS
        TQuNao7RVDtKlw88z9AdWp2sI4Ekawc3Y=; b=Td2DwNMhq/mCqC5Qr4VjyDMMhx
        iAyBBB+wnNRFt4m8chnpoG2CMl02fUvdiUKoBWsiL6WqigLAfTgDxgCvhDDJTwxj
        eS6FmI0mcQxumAnwhmzC430zuxh1eAaiDNHSe6J6PqCympONt1Q9t7/ZCRjC1Dqr
        3OA1RIeHV4HPanJ2NI9Blq1CiabD+WQiTdsF0+fM0cxCga4c5BpRUkP76uMoyEg6
        rkL1M6LGibhFlyd+OXQ+S/jUwyUjcNU3p1wxvAJqmXVkDYJR9BKo1eqxm768p/uQ
        T0nDBHsrMv2c52TXxmOZO26oqpKFyugPw6Shs2/Xbu6oh5DbxBFx4JExoZmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697925328; x=1698011728; bh=DVK74q2dXSTQu
        Nao7RVDtKlw88z9AdWp2sI4Ekawc3Y=; b=oSjz+kSM9Sn2tEAd6BpXwEuL5PHPQ
        t08Ktr8myTeArkxk0xTSEs/TT9dvKxgI++68IyGYP+Exchl9XbT054cIWwq++jpm
        8UmC001jjfyFWDM9dIquZuXiKvUBB+ss3kZMT5sA5NswRjzNb2K0xZ1rJvMUIf4u
        HC8BDySTlal7yo7wmGBJKlhJWFocVUTRo8yfbNb+S0cu5ELeXzTJNvxn5wiUMh1L
        VwYA9m6ZXZmDAcKcsE4GSWIljBvwxuSl1bTAQf/qOfuse9eIafXp4BwDtRsinRUl
        b+tpKx0fR5wf/Pa17liKjqxfpVtQeerF4bjNMVZY0FG3C1J6Ii4Z7wz+Q==
X-ME-Sender: <xms:z0g0Zf-uRPcYgeB8jqFKE4_nc5cjLtfnA1-ML0IwEIS_47WIfcR3lA>
    <xme:z0g0Zbu4gboqsZlTEFpRMgnU0MXjVFOHScMOI_a7c5FX3J7TG9ITGs6EEL2nNZxsj
    9s058dCYRNW3GXEDaQ>
X-ME-Received: <xmr:z0g0ZdAB-GLwQqSQH-tOPnNOWvi41LTMRuy9NnCwzuF8djK0MjKM7M8hxrBI_UL-uzPdi_yXn3Fo8dxlnTwCmdpqlhYu_jnaMqAadL2hgbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedugddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhkrghruges
    fhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeelgefffffghefhjeegje
    ehiedvgfelfeehueeuteektdffiefhveelhfegvedvveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrghsth
    hmrghilhdrohhrgh
X-ME-Proxy: <xmx:z0g0ZbcR3UWJ0Y1KzlwRFESGVtkOZgDzGriVO8y4GjDuu_-hjlwdxQ>
    <xmx:z0g0ZUO5AqBO7P4UO4gqe6FWrEoMb6N0yoZH2FGdAyFb3c_lLePOqQ>
    <xmx:z0g0ZdmvRfggGCv-tdmOGc06hwz23ZeYjL8w7dI5GYEmrp7qlfoC3g>
    <xmx:0Eg0ZZrXOGB_M5LrhrZ-xhqA-iqs4zYM2kmloc1xZ3uf8wtdvvQz7g>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 17:55:27 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v3] staging: rtl8192e: renamed variable TxCountToDataRate
Date:   Sat, 21 Oct 2023 17:54:40 -0400
Message-ID: <20231021215440.6584-1-garyrookard@fastmail.org>
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
Removed parenthesis alignment, and removed corrected spacing from
this patch. Only contains renaming variable.

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

