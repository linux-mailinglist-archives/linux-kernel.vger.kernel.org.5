Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E407FC2EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbjK1SR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjK1SRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:17:21 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF1E19A7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:17:28 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 849B55C0231;
        Tue, 28 Nov 2023 13:17:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 28 Nov 2023 13:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701195447; x=
        1701281847; bh=oxM763CPfUKKm3nWjlOEREGsogFX5ol8jOZHd4mRtRE=; b=A
        e4+kTvhMWNWKxy0q1+4Kf0mGiwjb/+h6jLu/9ZwuGcnqlov+GRBKPzxefFdXN/KH
        mjwDZFiGxw13Aw35JTap/0uPpiEFYlRWYnBvT1Hew5UzzKH/u8MMzWTjgc9FV5B6
        GCEB1usf8t68R178tt+VGBs6rF2qokQwTwQpxlDKWDDqE79GXKDrevSUfdrhD7sm
        r6ryBE1h0KdrJtIVXgSIAWwrrfp4XUc3eh3L3gi0bmTTxYYm7a/0hcJjNIbYklgQ
        T6d6x+UtLeOXOHWtGWtT3GvNCVrEZXug6HuVJm0Zxh24BQ6anBqyk13mtyOV+okr
        VuS/Shr5gPnwzOcJcyGKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701195447; x=
        1701281847; bh=oxM763CPfUKKm3nWjlOEREGsogFX5ol8jOZHd4mRtRE=; b=S
        unPyWxOOPBUToV/xwywJOEqk/OX23QGL5CQV0u+JfN6fyJoY+fQfdNio/foYQ2K/
        wlQtIPoXm+xUR0ZwI6uIk3e2UD+GxfLZO5iE8PedQrqH40QGp/WCG4YVwNqVFDqg
        BpOBipZcRwksO/QCQ7fXhFksJqB315b1jgEsXiXfC4Ne6IzzG8GofvL4fg9RtknA
        myrf9/WQjgy8In5MWkVs89NgRnbPOc+WUERmUhtPmwjXSMvV/uQVWyJPuCfY62XN
        s5H7Jx5MBGUJF5usJ6lhJJEXSwUTp82qeT0vW7CmRwrLKagwcIgfyjLswrMX7UyU
        vN5QqiKXbTJHUjRyq3O8Q==
X-ME-Sender: <xms:ty5mZeH58F59H91NlbLjJ1LS1l8lA_mtAhH0YxlppFohBNs83Pntgw>
    <xme:ty5mZfWmfK5BKXRGat3GYo4ZWdKUn-V_NNd-OnjrDwWHYpSSiGncYj_MlNIpSv484
    QTx9F3px05ZyGOo_5Y>
X-ME-Received: <xmr:ty5mZYKMT6Bx6f0a5g34hmvvraKlhh5RSR6JbUWAIdeseP61IcYwM1mADaZYH9V4G_RM0lWP2fp0ZJKWqOzkNI4e3TDXt2XyW_9A4LSq_wb->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhk
    rghrugesfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeekuedvffeuud
    ekgeeiueffjeehgfekteefheeuleefudeugfevleelhfefgfejvdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhguse
    hfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:ty5mZYEL10LeKxpE1oS7WMa3vUlQbyPu4_SmFXKolyUIeR_9iZWJ1g>
    <xmx:ty5mZUWQFV9fdkj-WjPHvs2-M7K4jwbOo1-7nRfyqFkBYVujo8OM0A>
    <xmx:ty5mZbMHTzIrOuD_HmVd0KiuNLxAKtDit7iFLJGIRw3vcjsV_6Hauw>
    <xmx:ty5mZbSQf8FsOliUu2ucpTvFtDKwTZwQS8GaGE5jYucGIvWISEltVw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 13:17:26 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v3 3/3] staging: rtl8192e: renamed variable nDataRate
Date:   Tue, 28 Nov 2023 13:17:27 -0500
Message-ID: <20231128181727.19504-4-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128181727.19504-1-garyrookard@fastmail.org>
References: <20231128181727.19504-1-garyrookard@fastmail.org>
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

Coding style issue, checkpatch Avoid CamelCase,
rename it nDataRate -> data-rate.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v3: Corrects commit message style issues.
v2: Style issues, redo.
v3: Style issues, redo.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 87e96f2abed0..f263f329db77 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -114,29 +114,29 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 mcs_rate)
 	return MCS_DATA_RATE[is40MHz][isShortGI][(mcs_rate & 0x7f)];
 }
 
-u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
+u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 data_rate)
 {
 	u16	CCKOFDMRate[12] = {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18,
 				   0x24, 0x30, 0x48, 0x60, 0x6c};
 	u8	is40MHz = 0;
 	u8	isShortGI = 0;
 
-	if (nDataRate < 12)
-		return CCKOFDMRate[nDataRate];
-	if (nDataRate >= 0x10 && nDataRate <= 0x1f) {
+	if (data_rate < 12)
+		return CCKOFDMRate[data_rate];
+	if (data_rate >= 0x10 && data_rate <= 0x1f) {
 		is40MHz = 0;
 		isShortGI = 0;
-	} else if (nDataRate >= 0x20  && nDataRate <= 0x2f) {
+	} else if (data_rate >= 0x20  && data_rate <= 0x2f) {
 		is40MHz = 1;
 		isShortGI = 0;
-	} else if (nDataRate >= 0x30  && nDataRate <= 0x3f) {
+	} else if (data_rate >= 0x30  && data_rate <= 0x3f) {
 		is40MHz = 0;
 		isShortGI = 1;
-	} else if (nDataRate >= 0x40  && nDataRate <= 0x4f) {
+	} else if (data_rate >= 0x40  && data_rate <= 0x4f) {
 		is40MHz = 1;
 		isShortGI = 1;
 	}
-	return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate & 0xf];
+	return MCS_DATA_RATE[is40MHz][isShortGI][data_rate & 0xf];
 }
 
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee)
-- 
2.41.0

