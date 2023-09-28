Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6218D7B0FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 02:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjI1ADP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 20:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI1ADN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 20:03:13 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34CCF9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 17:03:09 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B7C1E320091D;
        Wed, 27 Sep 2023 20:03:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 27 Sep 2023 20:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1695859388; x=1695945788; bh=cIxox338FB
        bGAustO1WcDvxTsjNNrAH/UryFJoEr9uw=; b=Zo2LDJui9X8/wmnLWnsopqD1Q+
        tAITJoPihxtC5ZBSGfEV5joX8BHkHSDveMe9fc3JdhIDawAMAi7m8TAiFxGkvxPX
        FZHlMnl+CGzgBtsgcO5oV3sWJmCyu5Hc9xQisnWovSWD483PKNm9RpWxVZX5QoQf
        j5sABIqJWBovCCx/I5NGC5Py8rh5wxKw+fzQorKHHG1middt8FUtd2IPl4nhcmya
        IC5Fddfr4+56Ky0y3EpSXv1mtADEVHAV0xLc0RAE4qQmnx7BLOT2MyfcwBFho9c7
        tE/fpYUbtGrwNGJH+ZUJSim61/C36w4dYIixDtLNQhOyyvXUQmWcp4a3GzZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695859388; x=1695945788; bh=cIxox338FBbGA
        ustO1WcDvxTsjNNrAH/UryFJoEr9uw=; b=lwAkvMCffDQHejs0AhnHkvo3QIaag
        CE8YeagR8BPF9pK75DDgBU88Q/S6Ze0k84MTE8w90JhpBwPhVLtdwx8DVpGUz8pq
        BSmfNOViKQ9cMQLLFZq8Mw5yig3xVqGa90eQ/kcyMRuiVvjofKScPxQqqkqslJ/d
        PT6W1piaQf0Hc01BZMvJlh1YuFDx3EJHRBWpEZ0+pOc0fh4xKI2ETMmcy5OJ6EIt
        k7Rs5VArfUy3MB64pTDE3Pjfv17H9PqVEbcjWNRP2Bxqbhi7k/8ag9ZCHW5ssatR
        ZfGIHIPcup/3zD/ud8CiWfsYbze8cB49uHoOKqI4HnZHu07wqORWy8E9w==
X-ME-Sender: <xms:vMIUZb9xV3olyoDa6JXm7bRrdvTB_k6Ot24HLLB7ezg9iEY8EUt0_Q>
    <xme:vMIUZXskd20-Qtbax_XlTXq9p-n6PvxSo-Xh6cUsYPZhWOX1qazG5CPSAsrIgElBp
    BMlgQQwjv9IsZekIDE>
X-ME-Received: <xmr:vMIUZZBiRekGQ1CmMKpyNr9H8EjS16qD9Jlzlmp1yJ3e-t8a_ssbivc3YSlPag3LgGKCzf4BRmTIvNa4relqfXHAXnmBANy94da0JMPjXMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhkrghruges
    fhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeelgefffffghefhjeegje
    ehiedvgfelfeehueeuteektdffiefhveelhfegvedvveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrghsth
    hmrghilhdrohhrgh
X-ME-Proxy: <xmx:vMIUZXfDu6p3UtW9eO6R02dyujcixgV3GW05goRaI04ZgW27QGUS0g>
    <xmx:vMIUZQPohgPfBUaSCYYDS7poLHMVfNBTRuWeNd0T8bL1zHdHvgdwUg>
    <xmx:vMIUZZkXjrIcQxaupIiR3ddHKN2SjHBZByxIEkMjXYLd5QfrzbAQ6A>
    <xmx:vMIUZZbSt2CIALL9FNIFtfPyArRtWTTtg9Tj-mJpGx6L8Igwdjly6g>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 20:03:07 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v4] staging: rtl8192e: renamed (3) variables
Date:   Wed, 27 Sep 2023 20:02:25 -0400
Message-ID: <20230928000225.27912-1-garyrookard@fastmail.org>
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

This patch renames the vaiable in staging/rtl8192e
HTUpdateDefaultSetting -> ht_update_default_setting
in (3) files of rtl8192e:
1) rtl819x_HTProc.c
2) rtllib.h
3) rtllib_module.c

Linux Kernel Coding Style "cleanup", no change in runtime,
staging/rtl8192e builds before and after.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_module.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index a7e356e90d0e..832f595d36c2 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -67,7 +67,7 @@ static u8 CISCO_BROADCOM[3] = {0x00, 0x17, 0x94};
 
 static u8 LINKSYS_MARVELL_4400N[3] = {0x00, 0x14, 0xa4};
 
-void HTUpdateDefaultSetting(struct rtllib_device *ieee)
+void ht_update_default_setting(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index bdbd27e382b9..ec1eef7486a2 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1785,7 +1785,7 @@ int rtllib_wx_get_rts(struct rtllib_device *ieee, struct iw_request_info *info,
 void HTSetConnectBwMode(struct rtllib_device *ieee,
 			enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset);
-void HTUpdateDefaultSetting(struct rtllib_device *ieee);
+void ht_update_default_setting(struct rtllib_device *ieee);
 void HTConstructCapabilityElement(struct rtllib_device *ieee,
 				  u8 *posHTCap, u8 *len,
 				  u8 isEncrypt, bool bAssoc);
diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index abd6bfd4dfa3..859241af617c 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -126,7 +126,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 	if (!ieee->ht_info)
 		goto free_softmac;
 
-	HTUpdateDefaultSetting(ieee);
+	ht_update_default_setting(ieee);
 	HTInitializeHTInfo(ieee);
 	rtllib_ts_init(ieee);
 	for (i = 0; i < IEEE_IBSS_MAC_HASH_SIZE; i++)
-- 
2.41.0

