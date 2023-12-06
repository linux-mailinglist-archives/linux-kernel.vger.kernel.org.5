Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F264807C07
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379673AbjLFXEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379605AbjLFXED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:04:03 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DEB10F2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:04:06 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.west.internal (Postfix) with ESMTP id 9710C320092C;
        Wed,  6 Dec 2023 18:04:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 06 Dec 2023 18:04:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701903845; x=
        1701990245; bh=TA6tUUcxmz+vbjorjXywqibrS6cbbOuc+Zoc8LbwEp0=; b=S
        Rt8l09rhEacOmO1FGls7kdGU42EV1g/yghDi6pr6Qs9AC8HmwiPP7E5zSGbJ2Rv5
        bt5yVkp0p2VRV3MgLlpqwHwwEB70q7PW1kLsWuug00AIarjy5ARCqOUllozD6ajS
        46GvpTv8jTPkfcdgDXiaFYA/+qqucGycH60cFh9tn0C2h7YK+sUoIx5LKe+bE3h0
        BYRvXUw+HjFdhZuGwlETkYJNxTXYyyKy4hFMSBiaqL7YbxJC7Upa6bOrvwQeKK+p
        6o3nM2FTAD60aKIn4pgeJl0U6E65o8A6XoumDPW7ViUF65bf1iQ1hqc0MPV0xDdY
        7H9K/26DZHLOvNVycc1hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701903845; x=
        1701990245; bh=TA6tUUcxmz+vbjorjXywqibrS6cbbOuc+Zoc8LbwEp0=; b=l
        tbQikN1N/vSO6xrJc3mc6dhXWC/xnoQn+UBvaHeaRSld4ePXEgE6qH/xTNFrWpMk
        24ySqfIcURYpM0MahukoOBPHofDHMyVneTIEQ3MxeEEOzeVMcEnss/ebMSfVv+3S
        A3Y02+Ffk8/tbZ10MFUdJTy5zEdzXLwbMeSbQcyqSW9xynk6fTwDHphCEhsjHVb0
        z7Ai/FdsT3SsEU+Iz2OrWD7+XcUMj70wzoko6NzCUxDcYjliHUH4j7uM4qxxEsaq
        gO1dMS+tz8poNkwZjZe040Fp5XnhqdMVnpmqtCvPDfCglgBY8Qv/gEkZXCDieH0Q
        JMJ/SUdoJd+SQhTEFMX9g==
X-ME-Sender: <xms:5P1wZbypHfBaVFOKsOL28BAV4OIQpdrJi_HmPmC7wjKQAAmPlaToHA>
    <xme:5P1wZTRJZqwZs71rmCyeljomwJxVJquq1ay5Ve0hbz0DBZBYRzEf6Nv5M5wGDyPXB
    burl1DNwQ1THALKccE>
X-ME-Received: <xmr:5P1wZVU7otiZQ8ixr3ibdziL9RBsi3giV8IN_MaCqNjabam7I3tBZuFM8BoX9_7pGFV62kW0tE1d7QO3vsZCM8MIGrepINwW40dcSXbT6_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:5P1wZVgNoaswTkQDWmpGMHM165rz-UBFJIvm5codOZRp-mRqbzTSdg>
    <xmx:5P1wZdCC855uAj4kp08EWgcyERslOsXFjym3ZYnTBIFz77FKJqxlgQ>
    <xmx:5P1wZeIu3O2qf91SRd4glpkKsc662GtzjE8bx4z5WqfFRc02vcUfdA>
    <xmx:5f1wZcPO0nQC2V5shZ39UL3X9n0IUhMeWK3r6Q2HL5rukWdKZf10oA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Dec 2023 18:04:04 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 4/5] staging: rtl8192e: renamed variable MPDU_Density
Date:   Wed,  6 Dec 2023 18:04:03 -0500
Message-ID: <20231206230404.1721-5-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231206230404.1721-1-garyrookard@fastmail.org>
References: <20231206230404.1721-1-garyrookard@fastmail.org>
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

Coding style issue, checkpatch Avoid CamelCase,
rename it. MPDU_Density -> mpdu_density

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index c01ccf252924..98c1e5840e31 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -115,7 +115,7 @@ struct rt_hi_throughput {
 	u8 current_ampdu_enable;
 	u8 ampdu_factor;
 	u8 CurrentAMPDUFactor;
-	u8 MPDU_Density;
+	u8 mpdu_density;
 	u8 current_mpdu_density;
 	enum ht_aggre_mode ForcedAMPDUMode;
 	u8 forced_ampdu_factor;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 0f044356e428..72b30d4df5f7 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -86,7 +86,7 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 
 	ht_info->ampdu_enable = 1;
 	ht_info->ampdu_factor = 2;
-	ht_info->MPDU_Density = 0;
+	ht_info->mpdu_density = 0;
 
 	ht_info->self_mimo_ps = 3;
 	if (ht_info->self_mimo_ps == 2)
@@ -525,7 +525,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 							    HT_AGG_SIZE_32K);
 		}
 	}
-	ht_info->current_mpdu_density = max_t(u8, ht_info->MPDU_Density,
+	ht_info->current_mpdu_density = max_t(u8, ht_info->mpdu_density,
 					      pPeerHTCap->MPDUDensity);
 	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
 		ht_info->current_ampdu_enable = false;
@@ -570,7 +570,7 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
 
 	ht_info->bCurrent_AMSDU_Support = false;
 	ht_info->nCurrent_AMSDU_MaxSize = ht_info->amsdu_max_size;
-	ht_info->current_mpdu_density = ht_info->MPDU_Density;
+	ht_info->current_mpdu_density = ht_info->mpdu_density;
 	ht_info->CurrentAMPDUFactor = ht_info->ampdu_factor;
 
 	memset((void *)(&ht_info->SelfHTCap), 0,
-- 
2.41.0

