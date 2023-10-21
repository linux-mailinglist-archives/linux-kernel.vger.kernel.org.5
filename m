Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98207D2053
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 00:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjJUWls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 18:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjJUWlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 18:41:47 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C081A3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 15:41:38 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0773F5C0185;
        Sat, 21 Oct 2023 18:41:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 21 Oct 2023 18:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1697928098; x=1698014498; bh=BszvcR3tf2
        Jhc+fpKLNeSEqkteDfp1YlgKmf0KxGLWE=; b=toprMpb+PNqjggicnuA0OGv7JI
        0xmgkQSl6b7srE2OxxSV5pCv5GEA9Q2jo0+hahueYoZpmepkABHFONgByHVg9UEf
        nkm2ZrxLSqw1y9LYt/vykoazwDC3CLBbXorL9jdEHx0hgzTEs6T/bm7JXPnAI/5R
        uUTjxyybTFOmMcm6Ap8mo72qkjkZaD6x3IbMex7NdXswC5UIW6i720a+5m4QLDMj
        f2w2UWPUv0wiXfA+orMJUyUpyZubmp/9SWNv+5q7lwutnPiLim2Bq8w3NlpqMXu/
        xNHC+HzK7ank4APDNYFdfKcGAFvd97Sr61W3WppOa/7SvoOQWv1L26Hfotgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697928098; x=1698014498; bh=BszvcR3tf2Jhc
        +fpKLNeSEqkteDfp1YlgKmf0KxGLWE=; b=gxVA53ipnTA/BZS/fB2ERMLgLJzJp
        31FVe8oWaa19SXcWQ2fztFZ3eC+ULAEPCciTKDCt1EcVemeKiCc2ev//VktfoEFb
        p9KjbUiuweRGJWPg4ZjjwxGD/JR09ruEwA9yGUnnfc9YBNgpOlzmBuwdRf5D1On9
        VAEGMj8rhK2l/9f6lTlOID8HYXcpwLuCZcscmmrIeVkv2D3PV0hQkUXGIdnq1opq
        M4jNClzyMg0r+WTGvDoWRQb3AJmf/9I0gy8uZT77eOOZndHNXntUVJICWN61cBW5
        SVEBrfy3QU1MAZZFF6BifQ8Wk50h80eiyF/uW3k87Bx/00x1DZcarYdqw==
X-ME-Sender: <xms:oVM0ZVm-zsaAp_4XJwPI0PlJr_wCfTM0WFo7TaYPLK17wLlSeWisXw>
    <xme:oVM0ZQ0eDVX0mKOI2E29M6blse1252LsLU4jXhJgeA_JrpWHGnkkuuE7Aw8pEAkWP
    hNb9A4QjJdmbwPV2yM>
X-ME-Received: <xmr:oVM0ZbrR8fAGlZkwfStx5x0qDfT85dbTf19jksD46xCzEoVed4X9It3xXoc0xg1YGJUl0U0j7bMbr3IQwQirBnV1gbNsDaEo0S6x8PmEHj4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedugddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhkrghruges
    fhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeelgefffffghefhjeegje
    ehiedvgfelfeehueeuteektdffiefhveelhfegvedvveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrghsth
    hmrghilhdrohhrgh
X-ME-Proxy: <xmx:oVM0ZVnUvsGtYCv-3mYNfkFBW1vjBl8DoOIR0gW8ChuuQlxm5LIB1Q>
    <xmx:oVM0ZT0kWB07fjhZHNIdJcOs0sdMahrsGyc42ui638MdB8oYH6JjLQ>
    <xmx:oVM0ZUvYOH7TPfwhfee7p7jl4kBNJTgfBCDTElOTJfCq9h8k7Q9cOg>
    <xmx:olM0ZUzcKVEXaisGqH1xUTz583rnj_jmUk6d91RzEktPINTkfvl0rg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 18:41:37 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH] staging: rtl8192e: renamed variable IsHTHalfNmodeAPs
Date:   Sat, 21 Oct 2023 18:40:51 -0400
Message-ID: <20231021224051.7443-1-garyrookard@fastmail.org>
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
IsHTHalfNmodeAPs, IsHTHalfNmodeAPs -> is_ht_half_nmode_aps.

Linux kernel coding style (cleanup) checkpatch Avoid CamelCase.
Driver rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 8070a152712e..f564474fab52 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -139,7 +139,7 @@ u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
 	return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate & 0xf];
 }
 
-bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
+bool is_ht_half_nmode_aps(struct rtllib_device *ieee)
 {
 	bool			retValue = false;
 	struct rtllib_network *net = &ieee->current_network;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 6a9550eaf148..5cae02883a59 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1783,7 +1783,7 @@ extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
 u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
 void HTResetIOTSetting(struct rt_hi_throughput *ht_info);
-bool IsHTHalfNmodeAPs(struct rtllib_device *ieee);
+bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
 u16  tx_count_data_rate(struct rtllib_device *ieee, u8 nDataRate);
 int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index ff98b41c94e0..501295f5b75e 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1872,7 +1872,7 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 		ieee->softmac_stats.rx_auth_rs_ok++;
 		if (!(ieee->ht_info->iot_action & HT_IOT_ACT_PURE_N_MODE)) {
 			if (!ieee->GetNmodeSupportBySecCfg(ieee->dev)) {
-				if (IsHTHalfNmodeAPs(ieee)) {
+				if (is_ht_half_nmode_aps(ieee)) {
 					bSupportNmode = true;
 					bHalfSupportNmode = true;
 				} else {
-- 
2.41.0

