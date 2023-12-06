Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD6B807C03
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379566AbjLFXDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379555AbjLFXDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:03:46 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A1498
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:03:52 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 6AF5F320046F;
        Wed,  6 Dec 2023 18:03:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 06 Dec 2023 18:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701903830; x=
        1701990230; bh=VJcaopnGHBFuS5l8WsRIWzV69AIutNDeRfxQSqYxTG4=; b=L
        JihrPFmLbZvc8kzhxwcVng6qZhnrgTRA9/VKXSr8B65ibjMvPiwXB+yHw9deivCh
        8QC3j/jnDRc1ls3GnMYYh+fqucXQ/gR4+Zceaot2sp33VaXJSP9o8UQ5dIkV0sue
        Fx27Yoy7SE9UyOJMaYlJQ4O2OWubGVgmA4crMx6Zp4/uBYk+PAoGLvV6y0g/XvXm
        2Tlra6X9ihArmxpePUK5RmQzHiCSmw7gEdanTbfl3F+Wr/Uh+4b3WpfeeyEmcsdw
        Z4HT1dnIo1Qw7Uj9PHhL9/1YCEmNllTEODWF4PRN1frtlzEYztXzKBVlaS2khfZT
        +Frdgtru79kjANqZ6o7+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701903830; x=
        1701990230; bh=VJcaopnGHBFuS5l8WsRIWzV69AIutNDeRfxQSqYxTG4=; b=I
        FrlK51/WQhkBunnoTN00UX/XpZwDd9qP59TeL8CHCTL6cYmMeoDw3qm6HRmbZNuq
        +mwy73ZR+40oodRcqS9O5iTCG0ozOH6RHL9fwx7EUukO5RFboci2rfRLNY4uvC9U
        WbMMIsgXWfHpChR8F0Teq4Yyo9xofEXzF0djDcklfTRiRmSBZ91YldP1YgsVchNf
        mz3tL/XXPZfkgy063m90v0Hd/UYCJo1tGjSCELFJunppCuJBPOw2TS8KEEOlZ+FT
        PQyhF87TH/wuLhkO8en7TdM6zqCeCGho3VjFDEOYOorTdRlGNUoH8fB2bC4YmHG/
        1XQFTfrrfLrfIpMhBA3/w==
X-ME-Sender: <xms:1v1wZVWjo1SDgycBt2xOt3u6ubuY-cWBGhGfq16pnTEC35InzSmeGA>
    <xme:1v1wZVkFvZ5Pw4XRDYBDzwHcPDqzDXomDgmZJND3vQ4dEZGJRqCIe4aLQH0i09Un0
    le6vHjXL5sD7ckf3tc>
X-ME-Received: <xmr:1v1wZRaVtXz0gPAnIE2saR7Wdr-EzaaHrfKgKJsXtl2LRnExonyITVX4fltu8G7aKz7J8S1uz2vuwMZ4JMlEVrhtD2cIorcfcSZfXHKzDB8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:1v1wZYWqbQZX1nIWhevXQpqggi8aWKf4T3TYdalp1xxbLE3aQuarMw>
    <xmx:1v1wZfncxAh0zZueXUtJFYz7GUhnCO0KEZaLEDMmXwa_rHRgCqFTCg>
    <xmx:1v1wZVdozL47tc4wARl9P5WtN323gRLFXfzqzQD6s-k0Tbg0zDpJMA>
    <xmx:1v1wZdjhYpDkx9RgNj2qa1QAcgl3N0_0nkVO34l7gwb-Vs4ggV5bJA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Dec 2023 18:03:50 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 1/5] staging: rtl8192e: renamed variable bAMSDU_Support
Date:   Wed,  6 Dec 2023 18:04:00 -0500
Message-ID: <20231206230404.1721-2-garyrookard@fastmail.org>
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
rename it. bAMSDU_Suppport -> amsdu_support

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 5018c3905be8..e02fa40262bd 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -107,7 +107,7 @@ struct rt_hi_throughput {
 	struct ht_info_ele SelfHTInfo;
 	u8 PeerHTCapBuf[32];
 	u8 PeerHTInfoBuf[32];
-	u8 bAMSDU_Support;
+	u8 amsdu_support;
 	u16 amsdu_max_size;
 	u8 bCurrent_AMSDU_Support;
 	u16 nCurrent_AMSDU_MaxSize;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 6475832f23f6..b2f2e1c0cf6b 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -82,7 +82,7 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 		ht_info->reg_supp_cck = true;
 
 	ht_info->amsdu_max_size = 7935UL;
-	ht_info->bAMSDU_Support = 0;
+	ht_info->amsdu_support = 0;
 
 	ht_info->bAMPDUEnable = 1;
 	ht_info->AMPDU_Factor = 2;
@@ -489,7 +489,7 @@ void HTOnAssocRsp(struct rtllib_device *ieee)
 			       ((pPeerHTCap->DssCCk == 1) ? true :
 			       false) : false);
 
-	ht_info->bCurrent_AMSDU_Support = ht_info->bAMSDU_Support;
+	ht_info->bCurrent_AMSDU_Support = ht_info->amsdu_support;
 
 	nMaxAMSDUSize = (pPeerHTCap->MaxAMSDUSize == 0) ? 3839 : 7935;
 
-- 
2.41.0

