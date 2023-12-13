Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF459811B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjLMRyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjLMRyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:54:20 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F2183
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:54:26 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D11E5C0304;
        Wed, 13 Dec 2023 12:54:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 13 Dec 2023 12:54:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=fm1; t=1702490066; x=
        1702576466; bh=GFUxrXC+6NmQeYvpOTRSuHLgXL/L+nTvW94IaYCc+BQ=; b=b
        KfYWj0zvATh5K7AenSccp4wpYBUkEKbTdlvAZHaWg2vpD+NB9ET3ny/k5dHj8bIM
        +OP7CxrCLc7AHFU04Y6CZ+f7EcL82KOJkQNisrGyoPOvPymO7+fZRAab2behmGjr
        MpZXS8FUsCDS4TfB5rbp2hbxJ9EpyzdDf4KsXk2mwowXw0fZUZAVu4QCzgHiG0dW
        cUUtOyK1+9GTDt0TAiIIHNurRbjpWaDH5lf+oR1kphwiNMBYyVhNRi8fJMJprqd+
        mP53qnOuZ6H1tWpJ6BH2hUf4LlbO8/2cUYVt6NJJiMM+uFV62NRs/Qri70uqydDz
        Za2wYp+t4kC60112N4jBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702490066; x=
        1702576466; bh=GFUxrXC+6NmQeYvpOTRSuHLgXL/L+nTvW94IaYCc+BQ=; b=T
        cjqPn1jVJlYnWikHgl6xtHMAccUAYOe+I5S8qlv9vOfkCQveyucDgQ5zaFMs3Cx+
        lQ8xxrI43zx3hlAkqYPOM6JuDWeDhNtr3acIczkbIjaQ1OqvXRbRMyFn2OQmcnUQ
        lCa778WOcc4XXl6FRt15SFGeRa4qCdgw52CNQEdxBTT2XJYXduvyWh90qLx3c1rd
        Rjz9BSS1azU8hB9PNv7dR62WBPwGOhM7p/SOtoBFE0u2rLYWTe8EZS7ailkXQTxM
        Z5d29AamCMpSjRWdVkgi0GSAAw4PPD5BqJBb9XRTe4wygBAEN/dZJTnvWf2/v7p9
        Ih/63Zs5fbv0qVo+g3LWA==
X-ME-Sender: <xms:0e95ZWWF8zU_wno7F93DiXF3RfXdJJKzT90bSDH0lsECrqxPESBZNQ>
    <xme:0e95ZSmmmpkKKJq91VA1Baznw97RkFKbHe_1G9jj-E5gLB8TMuwIMx0Tt2x5iKzmZ
    10pWbAwPQ39Z8sPHyU>
X-ME-Received: <xmr:0e95ZabtTQucGkkUUGhicVVH_XssIJaQ9fIsO1wBF01a7CMJZ7iuAFyGNLu_sxQecj7cZlKs24boo5Edys5BfPBuwqCY9Lpt5GcXYOwGxY0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeljedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:0e95ZdW_nCF_p4QkTE3Qyzmpmq4qrid1a1IwrHJ5i1KdE3-mXpa7Ew>
    <xmx:0e95ZQnQtu6eSNu9sohqnFvHn-AImQO4-bDOREOErg6Wsl-jLhY6Zg>
    <xmx:0e95ZSdG8fk3KCGUnMHxLn1nUjD_w5OAqZW4i0akRHHepc-gUdl6FQ>
    <xmx:0u95Zaip91RiKPFXWXZTlLbGL89U9ScRSDa9GfAe-sCpM2K-zmCFlQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 12:54:25 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 1/5] staging: rtl8192e: rename variable HTGetHighestMCSRate
Date:   Wed, 13 Dec 2023 12:54:55 -0500
Message-ID: <20231213175459.5425-2-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231213175459.5425-1-garyrookard@fastmail.org>
References: <20231213175459.5425-1-garyrookard@fastmail.org>
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
rename it. HTGetHighestMCSRate -> ht_get_highest_mcs_rate

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_wx.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 25097f1935a5..06542ac851fc 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -377,7 +377,7 @@ static u8 ht_pick_mcs_rate(struct rtllib_device *ieee, u8 *pOperateMCS)
 	return true;
 }
 
-u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
+u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 		       u8 *pMCSFilter)
 {
 	u8		i, j;
@@ -545,7 +545,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 		pMcsFilter = MCS_FILTER_1SS;
 	else
 		pMcsFilter = MCS_FILTER_ALL;
-	ieee->HTHighestOperaRate = HTGetHighestMCSRate(ieee,
+	ieee->HTHighestOperaRate = ht_get_highest_mcs_rate(ieee,
 						       ieee->dot11ht_oper_rate_set,
 						       pMcsFilter);
 	ieee->HTCurrentOperaRate = ieee->HTHighestOperaRate;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0d6144548c34..eef7c2b8c660 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1767,7 +1767,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 				   struct rtllib_network *pNetwork);
 void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
 				     struct rtllib_network *pNetwork);
-u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
+u8 ht_get_highest_mcs_rate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 		       u8 *pMCSFilter);
 extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index a37250de7ba3..f92ec0faf4d5 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -134,7 +134,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
 				((ht_cap->ShortGI40Mhz) ? 1 : 0) :
 				((ht_cap->ShortGI20Mhz) ? 1 : 0);
 
-		max_mcs = HTGetHighestMCSRate(ieee, ht_cap->MCS,
+		max_mcs = ht_get_highest_mcs_rate(ieee, ht_cap->MCS,
 					      MCS_FILTER_ALL);
 		rate = MCS_DATA_RATE[is40M][isShortGI][max_mcs & 0x7f];
 		if (rate > max_rate)
-- 
2.41.0

