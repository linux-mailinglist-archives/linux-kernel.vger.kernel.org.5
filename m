Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05F27B02EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjI0L2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjI0L1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:27:51 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC0DCC7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:27:22 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id ADEDB5C00AC;
        Wed, 27 Sep 2023 07:27:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Sep 2023 07:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1695814041; x=
        1695900441; bh=EKbUSczfUjZXM9dz+YEUETNkTMNO4yI27Qlbnu0WxoM=; b=i
        6yW7PVPm0YZ3fADuuoojMsq2IM6spKStrqlj/yWPjTnRepFxQkeCt1DW4d1jlXWS
        r+5cPwQUjklfVsowzGOrJnBkPN2vP4q1gD1T8dWludUQ4LaBYrtJ2tdw8R2PqeuR
        +N/HWoy+N9UuhT2D+u7MlU8/OABDvae04UON2Fyv5PuaEqSsRC5McmAfAQHfhs7G
        ibT5sJrzDbV3gvhJkpJdYet3QLjJo2ti0MpwYGnc2SZQMdYijm5yBXcj7zwb12vF
        NinbNZpy7AOMp4J6AbM0YzrlQcakiVdzQ9PSFAIjTlXS22AfnvczCIQcWJObmWb7
        wJ/UKqa+4IaKEYdLq1s9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695814041; x=
        1695900441; bh=EKbUSczfUjZXM9dz+YEUETNkTMNO4yI27Qlbnu0WxoM=; b=Y
        r5zciHIYwFCS6nCb2ud9AANcIe6azrnpyx9P/qd68EdcpZ720n69ybeOf7fLn49U
        kAFyIIo5egKHNjoFLbvYDrRH0JRhylTXP/LU5ZxUHXzasP8kEcYBjaIEqxdf7/kF
        03+G4MnYiDVC7ux+/AWL4nV2/JfiKjP/ogYt5dGiMyoJtGvkK090mbNNE5jv70TZ
        ffPu3bKvyaI/c370/zwy35Qogqj3m2Y6cXGmdSmrwzrJpI6vr9cGMd+HM7GxOjXV
        JIWvm3gEkb/tPdui7QyoLeJOK0GqJJUYZOczwQHo3x2cY/ODIL76OISg47UJ3Bex
        BPt9MVhfxln7Sin8sMIGA==
X-ME-Sender: <xms:mREUZdVoMF6NWAYm2OfvnrqxMNu4buolbeIMLQIf9Pkys_S9fWO4CQ>
    <xme:mREUZdkcHjuwOLDpz6S96k78LmDnAYalq80ZeLYY-BT6-w_pWJ2y7Gi4_-B2Uutel
    3JiAlnZDNsQybJ-HuA>
X-ME-Received: <xmr:mREUZZaWKfd7cCgybyn5ONNgNYCxSWu8ei9wd4r9zpENNbPQ2aB36Cicpz7Q7iqY4MEmUiZ4LCA01POS4f9oYGpXQJ-ZVJZL-BNkdgCy6tk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdefgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhkrghr
    ugesfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeekuedvffeuudekge
    eiueffjeehgfekteefheeuleefudeugfevleelhfefgfejvdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrg
    hsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:mREUZQVOK8VZmfLMRnS7vlbXjLTAj9qX0IaEtrSMSP40DRGx7w2MqQ>
    <xmx:mREUZXl6aFqyOBETSOj5zRBpNldvmGzkimg2gOi0VWpgdYxLsyA8vQ>
    <xmx:mREUZdd397LrCX7QKU7G44o4gWjOMeuqCdL4ESvxcri2R19-tLe9Aw>
    <xmx:mREUZcz90CIo7uWRDCkaKPrd4tQTpfXPfZEdRepx7YOCxmIoiZDfTA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 07:27:21 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 1/3 v2] staging: rtl8192e: rtllib: renamed a prototype variable
Date:   Wed, 27 Sep 2023 07:26:33 -0400
Message-ID: <20230927112635.27637-2-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927112635.27637-1-garyrookard@fastmail.org>
References: <20230927112635.27637-1-garyrookard@fastmail.org>
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

This patch renames a prototype variable from being of mixed case.
HTUpdateDefaultSetting -> ht_update_default_setting

Linux Kernel Coding Style "cleanup", no "runtime" change,
drivers/staging/rtl8192e builds/compiles before and after.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtllib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 5517b9df65be..1a3dd4dcad81 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1807,7 +1807,7 @@ int rtllib_wx_get_rts(struct rtllib_device *ieee, struct iw_request_info *info,
 void HTSetConnectBwMode(struct rtllib_device *ieee,
 			enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset);
-void HTUpdateDefaultSetting(struct rtllib_device *ieee);
+void ht_update_default_setting(struct rtllib_device *ieee);
 void HTConstructCapabilityElement(struct rtllib_device *ieee,
 				  u8 *posHTCap, u8 *len,
 				  u8 isEncrypt, bool bAssoc);
-- 
2.41.0

