Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA3A7D2062
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 01:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjJUXG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 19:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUXG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 19:06:58 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1407BDF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 16:06:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D38375C009C;
        Sat, 21 Oct 2023 19:06:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 21 Oct 2023 19:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1697929608; x=1698016008; bh=mKoeEncD58
        UuMyMXPFqT+Ps3JfDvCVyfvtYlalXYITQ=; b=WYoBu7AgV5CrY6cOtE+tfY2/yP
        e6lS4edotRyhsDSBr+nggWLKgoX+79ORarzM62Ghl1JURsE0fpZlT83XU/TsXO/+
        LdRLCeuR18BY4Pol6CxZs3a19H8t2VTQJnJluP0agpacXJp43IlvrQ9sstuRf0YS
        WVHUl/5EbMYnwfFqVF/b2cwqMoAXeGrd5Fvw+8idTBwhE+8KkgeCBiuN5L2vwdDl
        1YKj17nO8GIoyXrbQzzmMUttSRztyk+u5wXsVHQhgiIvkLn7c3kv5UsA0qcx+BhC
        x4uZ9QjAtXzt71I8wP50a0kdgxMdpjqalvBShCc+LpmgLgJ7hOoj6pgsA+wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697929608; x=1698016008; bh=mKoeEncD58UuM
        yMXPFqT+Ps3JfDvCVyfvtYlalXYITQ=; b=mrK9B+XsjrHq0s84vtZqfIs3HzikE
        sElYEQvvTTSpWso4NK7BW0r4QmFLQTQfNHYUwzYR2LD7QhR/xVLITjSiY7l4zDhE
        OKvPFjlq9Odvp2jYbnU4dvszXjQZdpxrBK2c4Zmq6cbbHoIqQvpHrcx6aESgB5fK
        UN++O/ua7CRzMfbQ/p48O1s7mUwTrS/FYLpEuTWxLAPV88aMsXvgghGwN3dP/T6q
        cGePVRGqyer08CUrFHITjbmc3ZEHC0jPcdDDSJS8+qqekHFQUW3yEf9wHC37eks2
        xNmjzwd7FLjsc7aF4n+gDTghQC+kvhzZhbGoPMpi2NizXYvjgm8MfaRbA==
X-ME-Sender: <xms:iFk0ZbuHABDwjtytgDmuG5UcLkD8TvRuCFXNbsqD_Gds86seYyy7kg>
    <xme:iFk0ZcfohdybhL5sXjwstzqa-GWePP-SLVYVfoq7fLLs_hxNGCQawt1lP8B47Jxg0
    qYtKyRJCi__QDpD2nA>
X-ME-Received: <xmr:iFk0Zew--1QHgQE-UuhiFxfBNG4jmzISr2Nz6i25V5ru2ZARr4jRblQevL0RSfyU_hMoIeU-2rYEQY416PAmZf83QTXK-Kx3dAdXgstAZkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedugddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhkrghruges
    fhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeelgefffffghefhjeegje
    ehiedvgfelfeehueeuteektdffiefhveelhfegvedvveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrghsth
    hmrghilhdrohhrgh
X-ME-Proxy: <xmx:iFk0ZaM-9ddvQno6r07cv0rYRsFDVxirU7C314c8dFGOz2uewdaGPw>
    <xmx:iFk0Zb_hOZ6JxNhYFps-oCmI6TIrXp-Tw9frdxvh9OxobfAzbvQRdA>
    <xmx:iFk0ZaVUcZ4sM2dbC-Mc9mhtZair0ngDFL_0kb_B8HlCK7TQbgIApA>
    <xmx:iFk0ZebJr2xY8Bcu1-yBtW0wB7UUuqXafXIyVcjXS_zGBGriofyJqQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 19:06:47 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH] staging: rtl8192e: renamed variable HTIOTPeerDetermine
Date:   Sat, 21 Oct 2023 19:06:03 -0400
Message-ID: <20231021230603.8819-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renamed from Pascal/CamelCase to Snake case the variable
HTIOTPeerDetermine, HTIOTPeerDetermine -> ht_iot_peer_determine.

Linux kernel coding style (cleanup) checkpatch Avoid CamelCase.
Driver rtl8129e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f564474fab52..8522a3594848 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -164,7 +164,7 @@ bool is_ht_half_nmode_aps(struct rtllib_device *ieee)
 	return retValue;
 }
 
-static void HTIOTPeerDetermine(struct rtllib_device *ieee)
+static void ht_iot_peer_determine(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 	struct rtllib_network *net = &ieee->current_network;
@@ -693,7 +693,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 			ht_info->RT2RT_HT_Mode = (enum rt_ht_capability)0;
 		}
 
-		HTIOTPeerDetermine(ieee);
+		ht_iot_peer_determine(ieee);
 
 		ht_info->iot_action = 0;
 		bIOTAction = HTIOTActIsDisableMCS14(ieee, pNetwork->bssid);
-- 
2.41.0

