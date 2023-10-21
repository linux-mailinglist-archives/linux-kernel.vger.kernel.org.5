Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0057D1A60
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 03:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjJUBtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 21:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUBtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 21:49:03 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFFDD75
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 18:48:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E8B35C0312;
        Fri, 20 Oct 2023 21:48:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 20 Oct 2023 21:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1697852935; x=1697939335; bh=7ynTSd3R0j
        IltgITt1Ec02Lsx2ooxlTW5LJQFjc5TQo=; b=UqSK1nI3l5igTIdibioT51tgA+
        XjkEOhvcFSDsE22DrQf/EIN5ll2qd656DQs9sU3hX/LVhMJnVRMeBN2EOPczgayL
        MHz/fE0Z5KIASVvkVXvZmUCdHLkfNSzfx4dVzqIC06y2Zt1uyH9ZhUYY62hkY/N7
        3lV04IYF5FHcBps1/13+zUS/ilOLGuJxJZO75cH6eQenPxFZnuplOFo2fqhYK9N2
        rZt3ILlpgbyANyQWVHqLOD3PF9zdOp0wf48Bd683rlmh785v09tFD3xVIYD4eKtz
        ieVykvwQZl3D0mHN8MQudBynns9/SoNUx5WKdYNSTgBe53dazA37WLzlTQlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697852935; x=1697939335; bh=7ynTSd3R0jIlt
        gITt1Ec02Lsx2ooxlTW5LJQFjc5TQo=; b=KAASq8QQ0t9Pr4LLZnqjcPeY8g2ZI
        Qq8jnwxucwKZoHHA9FEcecYkvlErFQ7mehppfO+KJyINe2PJsglENVpHv5ni1qMj
        w8riy1mwofJZNqFh64bSghytHolCowvtH4GkaiwTu38wYu8c66CTkuWlTbsyaGUH
        ILGdb9sfv/fDzoR4qGARSbgRc5INfYUBTi/dkFOmyL0PAeF86HMJ2dBtChXtg3/O
        ubzad4JAhwxWuoBfD+ShIZmk9KegECjlPaSQ8VjIRzLv+bx7k2r2xzugl0W3oDOx
        i3kb3K2EOoxLBlNcPW5HBRmR+yU0Iv9+8rJsm2Q94VVbDqt/H3mn9yuhA==
X-ME-Sender: <xms:Bi4zZXEiElWoVyLohn09hmHB-sOMchwtAJ8DWtjgLLlCZ5OB4rWo5Q>
    <xme:Bi4zZUVMzIl9xdw1I9HK5EC6SMe3wz3w50EIsGamUa4oIsoFgOLYTd2d0vZLRzrEh
    kZzxCayI6P5uGKcyBM>
X-ME-Received: <xmr:Bi4zZZLPflVAA7DKi1ds_Ipwu1x1yuTXdT76qROGvstH8j98oudpQPS31xyv9Q3HVwwplD9aZlgYUEcJcmGJcBh369jtRcinKteDncx6ZV4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeelgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhkrghruges
    fhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeelgefffffghefhjeegje
    ehiedvgfelfeehueeuteektdffiefhveelhfegvedvveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrghsth
    hmrghilhdrohhrgh
X-ME-Proxy: <xmx:Bi4zZVH59pACPV5mdgrkDl4eLfQrPhvjJBV2W--BlFZIvtlfiZTCHg>
    <xmx:Bi4zZdWxFu4zLHMbFOZmj8Z4KqYxnbe3drD7QXsFc8RKUtqP4468pA>
    <xmx:Bi4zZQOyseoOwzxAFHXq2pwjFKH8oQ972aBd0oZOxza69B979eA1Eg>
    <xmx:By4zZQQ1jxuXPM7wu1furfavv7WFo70prVQTKVHhyxQn-AF5ZgsdVQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Oct 2023 21:48:54 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@list.linux.dev,
        linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH] staging: rtl8192e: renamed variable HTUpdateDefaultSetting
Date:   Fri, 20 Oct 2023 21:47:59 -0400
Message-ID: <20231021014759.29844-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renamed from Pascal/CamelCase to Snake case the variable HTUpdateDefaultSetting,
HTUpateDefaultSetting -> ht_update_default_setting

Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_module.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index bb80d3ba182d..00b21542ddc3 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -67,7 +67,7 @@ static u8 CISCO_BROADCOM[3] = {0x00, 0x17, 0x94};
 
 static u8 LINKSYS_MARVELL_4400N[3] = {0x00, 0x14, 0xa4};
 
-void HTUpdateDefaultSetting(struct rtllib_device *ieee)
+void ht_update_default_setting(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 64a846af8679..9d141aad8cd5 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1762,7 +1762,7 @@ int rtllib_wx_get_rts(struct rtllib_device *ieee, struct iw_request_info *info,
 void HTSetConnectBwMode(struct rtllib_device *ieee,
 			enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset);
-void HTUpdateDefaultSetting(struct rtllib_device *ieee);
+void ht_update_default_setting(struct rtllib_device *ieee);
 void HTConstructCapabilityElement(struct rtllib_device *ieee,
 				  u8 *posHTCap, u8 *len,
 				  u8 isEncrypt, bool bAssoc);
diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index f280c9e94958..95b6d6b9429c 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -122,7 +122,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 	if (!ieee->ht_info)
 		goto free_softmac;
 
-	HTUpdateDefaultSetting(ieee);
+	ht_update_default_setting(ieee);
 	HTInitializeHTInfo(ieee);
 	rtllib_ts_init(ieee);
 	for (i = 0; i < IEEE_IBSS_MAC_HASH_SIZE; i++)
-- 
2.41.0

