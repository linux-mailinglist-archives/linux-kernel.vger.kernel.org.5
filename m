Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2269580BE72
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 01:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjLKANm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 19:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjLKANc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 19:13:32 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E43199
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 16:13:33 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7AB523200A49;
        Sun, 10 Dec 2023 19:13:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 10 Dec 2023 19:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1702253610; x=
        1702340010; bh=Bmw/wp7j+cPK5IuVvd2b+9dGsZdJqyjeSb9WLoFcNEU=; b=I
        MQQZA+NxAw8AiC89aWIutdFP8t4Mg4gh5lTjw/2VacReOCzHpaoTmFc6qPso/q7w
        FMHkzET+lQwYCNpYvDNdVqdWs8v7opJ5iMXYxnogacl4HqqOVTU3rb/E+0Ha1UO2
        twyXbmh3Ct19jGD9bk9/K3jJ0KWumlv3DAg693ZFiaVrq1VQikr+HdZpGJrU1L9V
        foQWz3JTifnhQA8k7meoAOg00KwRXIE44rXMFAGrVNbUr9rWQv0xqooR8p1eYYYU
        XK+T6zmw9YrnFvk5k/iM4qJMrRMhNhvlid1bF2VfWcO8TN+k9P9S1iDjrHwfZcy6
        Xw1D7krZhUHwDgqFQRW/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702253610; x=
        1702340010; bh=Bmw/wp7j+cPK5IuVvd2b+9dGsZdJqyjeSb9WLoFcNEU=; b=U
        aJF/M0C2s1Wiyd4dTnKDPsCjG+5azGtgLC/OMPxZnH8wXV7y3c1Lb0pgkZMoiXeJ
        LJnG3wYvk2X53Rwh+4Ax+WMHz0fxFLDGhQfuiBX3sP4DGK7AviNb0WGfc9/GLdsZ
        VTL4TKAniyk8tTiOc5FSfhF5yuYj0u+lqhFCKGhzB5/yJPKFsABIsYTH23Q4vREi
        Y+HfeNVgfRT4pzLHIO2oUJF0B6uKnmq6MftvXtiqhd2U6GEJpTJseXrb8R777kI1
        lTLOCGxjR8SV8OFGNBcke/TJxF/uo5MN87gwxyvutOk1z2F8KI6/vh/q8y31ss6l
        12H9yPVFAZuMoFQ9hrmzw==
X-ME-Sender: <xms:KlR2ZbkPSR-qSPFVaWB1t32rpwDGMuu4ji7xA3BiEa6XInJvCqL7_A>
    <xme:KlR2Ze0DviqxlM-XR1JT-31-BFmjqvEBVt4XOhPZZrCYaWMa5iPPfzi4N_55pZz8v
    FjugxebrmW1RezKK_Q>
X-ME-Received: <xmr:KlR2ZRrySgbiQ13-oKEXjpNbwnZ50xtZA7JJ8ZyNsUp6PbAIWm-QhMj_iCdXagd15ObPxXOCUXngy5auMMPeS5rI6NSBQAbv2GD8hsbsamE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:KlR2ZTndRwRgUuTBiR8pJEJbKSBRuIofWIXxq5FJF2I-sl7kO5A2bg>
    <xmx:KlR2ZZ0rKv6LNIy_aAwnVTQu4CXxWsHs12PMoUnRZ1ja9CyIV-vXRQ>
    <xmx:KlR2ZSs8xvZcuVvpC3g118KfhcNvcvb97eiI019Ut_Eep6d2RVJegw>
    <xmx:KlR2ZSzcyzsTBbgPOjcmxHsaBCzVk38imRS6UrsSGhzDwXNI0qjYaA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Dec 2023 19:13:30 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 5/5] staging: rtl8192e: rename variable HT_PickMCSRate
Date:   Sun, 10 Dec 2023 19:13:35 -0500
Message-ID: <20231211001335.26169-6-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211001335.26169-1-garyrookard@fastmail.org>
References: <20231211001335.26169-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
rename it. HT_PickMCSRate -> ht_pick_mcs_rate

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index a374f4c9f17e..14e25f87c1bf 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -350,7 +350,7 @@ void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee, u8 *posRT2RTAgg,
 	*len = 6 + 2;
 }
 
-static u8 HT_PickMCSRate(struct rtllib_device *ieee, u8 *pOperateMCS)
+static u8 ht_pick_mcs_rate(struct rtllib_device *ieee, u8 *pOperateMCS)
 {
 	u8 i;
 
@@ -426,7 +426,7 @@ static u8 HTFilterMCSRate(struct rtllib_device *ieee, u8 *pSupportMCS,
 		pOperateMCS[i] = ieee->reg_dot11tx_ht_oper_rate_set[i] &
 				 pSupportMCS[i];
 
-	HT_PickMCSRate(ieee, pOperateMCS);
+	ht_pick_mcs_rate(ieee, pOperateMCS);
 
 	if (ieee->GetHalfNmodeSupportByAPsHandler(ieee->dev))
 		pOperateMCS[1] = 0;
-- 
2.41.0

