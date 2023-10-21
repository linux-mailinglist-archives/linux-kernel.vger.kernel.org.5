Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C266C7D207B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 01:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjJUXyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 19:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUXx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 19:53:59 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AD3BE
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 16:53:52 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7ADD05C01C1;
        Sat, 21 Oct 2023 19:53:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 21 Oct 2023 19:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1697932431; x=1698018831; bh=iTKOkh8rwX
        5nAsZe+Xkiff/EUDvriYJ6UrMw6g9j4iU=; b=axN+i9s+4Ow4ASdoE729S4TUrQ
        HFB3lfHHifB1zhW9lnfXVZM2BSTUuS6fTl9kV3v6TSNEi3XvMalC4kqjSSAWmpxC
        74FwL8j8e/wEfZ46nWxu8cSmN1ML1GoifmsKwLcs6ItAA+ZvzgseiLrBCZ1ZGZ2X
        s2KEi3EfZDBsXKc1UBK9HpS7bzGXfz3/cfu9gs6HTFCOtlz1H+P3NdOndsZFJSLB
        362hWigcUDan/XEdN9Z3GN9R+SWxsRV09STxYjIlitg2g/eO9RpJVAuWukM1G7RE
        pwresB9INQ19JHjq/CW2qdXxllBKINe63hxm4Ld0BWbLyLQK/6eB3PxoEOuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697932431; x=1698018831; bh=iTKOkh8rwX5nA
        sZe+Xkiff/EUDvriYJ6UrMw6g9j4iU=; b=SJA4Vp+lJKF8z3Lbxo87POBZW2abU
        Z1wyk3rmbp7k407DwxmWJiYewFxEXgqrc9XLXDLca/sfqfxqO0INFB/qD8sExXT9
        ktKZoftHkFVlaCD6IgNyQmT4N46hbwfUGrZYiHbjijprdgO8dIATDwY4z8sRUCKI
        XVlZ9JKYIa1lgWns+WvpBp2AHX7QpmGEcHynbkJq5VEjPagrEKRRi2ol9Li6TS9n
        NTdajcF3QLaFhatD8FA8NLTXSfHyb64ZIt/QUsvVsmh2HQlYgEPzinTNSFmQF/7F
        Rcv0+XzZX7srIyK8Au7FgOsXihtme0TrEjyJeHHzilYYWWiMH3iCUdieA==
X-ME-Sender: <xms:jmQ0ZVhvUEwgHeix35fF98MtwwP33dRJSoVu2OQuSTGaFH4Rs55a7g>
    <xme:jmQ0ZaCUXv_6zuCO-TyZaxLd2ldjIwOKJGhy9jf-EsbFZcTvQmt4Bps6ekkD8O_e8
    JsLbGgDsdyAWiggdiM>
X-ME-Received: <xmr:jmQ0ZVFgrW8F-pYIgv0sp6pswRne7Vvtg5fHEzRH5UMbX0JWpfsYbDQTuuGF19rLT5HmalEholWv9mgwOqG4ojZWgL4H1olt2keoQAr2m00>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkedugddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhkrghruges
    fhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeelgefffffghefhjeegje
    ehiedvgfelfeehueeuteektdffiefhveelhfegvedvveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrghsth
    hmrghilhdrohhrgh
X-ME-Proxy: <xmx:jmQ0ZaQ06p4yoj-wtVFLKBnFQ7xwFnSdIvtDnBK46xll2Aq4Bac8Iw>
    <xmx:jmQ0ZSyGdxBE0rJJhvMJldXYwF6cC99Ut3WdCt4hvyLuLLksJQ5dEw>
    <xmx:jmQ0ZQ5F5r7p7BXIiLgrcj-fLiVjp6zPbs7tmu-mvYkotP5yY8W0Dg>
    <xmx:j2Q0ZW_-QDM5EDtIGXaeuxSprMl6S5fkcHcKawWEJHoxhf_mplJJtw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Oct 2023 19:53:50 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH] staging: rtl8192e: renamed varaible HTIOTActIsDisableMCS15
Date:   Sat, 21 Oct 2023 19:53:05 -0400
Message-ID: <20231021235305.10741-1-garyrookard@fastmail.org>
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
HTIOCActIsDisableMCS15, HTIOTActIsDisableMCS15 -> ht_ioc_act_disable_mcs15.

Linux kernel coding style (cleanup), checkpatch Avoid CamelCase
Driver rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 5dca97b07874..8868672131a1 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -212,7 +212,7 @@ static u8 ht_iot_act_is_disable_mcs14(struct rtllib_device *ieee, u8 *PeerMacAdd
 	return 0;
 }
 
-static bool HTIOTActIsDisableMCS15(struct rtllib_device *ieee)
+static bool ht_iot_act_is_disable_mcs15(struct rtllib_device *ieee)
 {
 	return false;
 }
@@ -700,7 +700,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 		if (bIOTAction)
 			ht_info->iot_action |= HT_IOT_ACT_DISABLE_MCS14;
 
-		bIOTAction = HTIOTActIsDisableMCS15(ieee);
+		bIOTAction = ht_iot_act_is_disable_mcs15(ieee);
 		if (bIOTAction)
 			ht_info->iot_action |= HT_IOT_ACT_DISABLE_MCS15;
 
-- 
2.41.0

