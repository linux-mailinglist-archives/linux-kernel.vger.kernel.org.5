Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA1C7F8FD6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 23:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjKYWef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 17:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjKYWee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 17:34:34 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656AF119
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 14:34:40 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A20495C0124;
        Sat, 25 Nov 2023 17:34:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 25 Nov 2023 17:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1700951679; x=
        1701038079; bh=KTI9C2I6tkQjoQs+7XIU28ci/b8dXWYt0juWD3lvkIw=; b=i
        NlD9PtJdvZF6eNl8I3lIuD3KKoHqfc4iaqG1A5GbncfdguBSzHObQ/Hnm4RFbsjG
        8BKNuFLCDrEv2RHDC5Ol0+ljM6z9ahlUhgOV1fh7V9M8xzGlUCxImTjcX41dLcGW
        l0QujNYKf+HShpctljZ7zmIbazYsVgkp+eZGvkPNlCPhmVLSwMlzAmSRMt9opEf/
        4xWzWh3Lh9QJd+SuhJwTHpxnh56fiALw8HUT82L4thi7bkD2/uN+EQd3SzhLF7FS
        lp0elebxZ9etIsFQTq+/BJT35a6EgW5to/luq1SNZw7+EPK/zz2rio/diUzFv4pL
        7WOnl8Pnr89I02SZ345Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700951679; x=
        1701038079; bh=KTI9C2I6tkQjoQs+7XIU28ci/b8dXWYt0juWD3lvkIw=; b=C
        RSYuou0gzqiWWD04OjZJjYxpDzQp6aYajgLpe8f6WjD5239lQHb05lr2tp0XkdVd
        gP44No82gAiKVpcwinz+k9meQRFUNiIEU6F3t/rV2QEdruKUgWGkjURldMKddgFm
        yTJWTC7l1uhAUyV4JAg+LMK/3aMlBWIWEpasRGkc2QtkF4bz+UQu5yulfm7osRzm
        I6IwPVHMizXAj5JDjULuEjqw/4Uj/8FZtFi2iLZw6h1Qf09iDcao3BJZi7I95NR8
        AN+pRoOqsXOyDsSf6o44ErnGxh7WTtspH07ye59pTEmw3hUOWb/4ll7mIRTI+FNA
        BNU34mF1lTkztfi1saf0g==
X-ME-Sender: <xms:f3ZiZTn2nXqL9kehcesxSn_yEbVAXKX3ryjbTajsUErl_zvcIx8-KA>
    <xme:f3ZiZW0o-9KCXsDHuwLzm1mxTuaj8CBTsaih78_dt0hVe8SHOkJ2ML-_X907_jArk
    pHCpvNCauAFOJgpOmU>
X-ME-Received: <xmr:f3ZiZZp8Hj0wRqkGG80B-_JE490pbkqQuEb2hkTxURYXEd9B79u5XqjfJmuovw1IlbJjg7tFNYtcAyZLZv_1EhT51zAvdwGFuy8Alhz74agR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehjedgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhk
    rghrugesfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeekuedvffeuud
    ekgeeiueffjeehgfekteefheeuleefudeugfevleelhfefgfejvdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhguse
    hfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:f3ZiZbnVyBjUG15_poYuT_MrHuTcxetmHRVT6kQh3ddNyA_7IrcRmQ>
    <xmx:f3ZiZR36Vq7pqdZHH4kmN25htjW5zmuS-hkfvvituQ5CcDINvuqUdQ>
    <xmx:f3ZiZasoYZlYjj7u6VAnN6hNRLv6buf6lEFgYcG2L2oP9vo4slAjXg>
    <xmx:f3ZiZazYJxk4g7xeK0YOAgektTplc_OH5kyVPIN_1XKo01cGWt1huA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Nov 2023 17:34:39 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 1/5] staging: rtl8192e: renamed 2 variables nMcsRate, mcsRate
Date:   Sat, 25 Nov 2023 17:34:28 -0500
Message-ID: <20231125223432.13780-2-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231125223432.13780-1-garyrookard@fastmail.org>
References: <20231125223432.13780-1-garyrookard@fastmail.org>
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

Renamed 2 variables from CamelCase to Snake case nMcsRate
and mcsRate.
nMcsRate -> n_mcs_rate
mcs_Rate -> mcs_rate

Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver/module rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f43249fd78d7..7e61ebd2bc25 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -103,7 +103,7 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 	ht_info->rx_reorder_pending_time = 30;
 }
 
-static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 nMcsRate)
+static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 n_mcs_rate)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
@@ -111,7 +111,7 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 nMcsRate)
 	u8	isShortGI = (ht_info->bCurBW40MHz) ?
 			    ((ht_info->bCurShortGI40MHz) ? 1 : 0) :
 			    ((ht_info->bCurShortGI20MHz) ? 1 : 0);
-	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
+	return MCS_DATA_RATE[is40MHz][isShortGI][(n_mcs_rate & 0x7f)];
 }
 
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
@@ -398,7 +398,7 @@ u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 {
 	u8		i, j;
 	u8		bitMap;
-	u8		mcsRate = 0;
+	u8		mcs_rate = 0;
 	u8		availableMcsRate[16];
 
 	if (!pMCSRateSet || !pMCSFilter) {
@@ -423,14 +423,14 @@ u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 			for (j = 0; j < 8; j++) {
 				if ((bitMap % 2) != 0) {
 					if (ht_mcs_to_data_rate(ieee, (8 * i + j)) >
-					    ht_mcs_to_data_rate(ieee, mcsRate))
-						mcsRate = 8 * i + j;
+					    ht_mcs_to_data_rate(ieee, mcs_rate))
+						mcs_rate = 8 * i + j;
 				}
 				bitMap >>= 1;
 			}
 		}
 	}
-	return mcsRate | 0x80;
+	return mcs_rate | 0x80;
 }
 
 static u8 HTFilterMCSRate(struct rtllib_device *ieee, u8 *pSupportMCS,
-- 
2.41.0

