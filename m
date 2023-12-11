Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E6E80BE70
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 01:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjLKANW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 19:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjLKANU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 19:13:20 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2276110A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 16:13:26 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3365E3200065;
        Sun, 10 Dec 2023 19:13:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 10 Dec 2023 19:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1702253604; x=
        1702340004; bh=liaRfIyqhfUp5XSbFWt2b8nzKtqWafaP5eJQX8WOtsE=; b=k
        1eCvexUrpLE5dl6HytUpEoE1gpdp9uq/XH+XQLBOK3uIDCwtZRifU5X9Y7EEiVLX
        KldUsXTnBLdmqh7yfEZzgMrdC7p3cv3fwI8FtixJ2A6yYbM4Pnw/Cbh+zWEaZl48
        KUDUOYv+nJ3herYYFNCGF20RIdO+ZxlHPIsH6mjSnK3imOGQYpZ+qkEpYFP87uC7
        JkKxs9lfMlCqdtsWsKumGe0UOzeq1p5Fkg91OSR1GUTsI2O8i4ujG/NwNBf7rz5n
        IB3E584lsRmEAs2nzWGDKrcOIs2nD0V+Onf4NQsiuvaOeav6/oG5bOONT6DuEDvR
        cbjSe8ChAYfexkxTugSLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702253604; x=
        1702340004; bh=liaRfIyqhfUp5XSbFWt2b8nzKtqWafaP5eJQX8WOtsE=; b=2
        7XwCM+mzHLjY35kG68YwMt/VHxIWKL6gesKnyabdWXENkO1izi+9GVr2OxeaZYE4
        Ew8QXzDogQRaLG5F8JESc/28sCuvcRAv1JWCDyNRQVt2o28bOg99vR51SqxYrFJD
        ReJbAxaaO1WbCdSt+M68egftxQdj1BrlMtaRPSksKsX9AAryb4zsHmJCefmCxv9X
        qekyEb4e22Y8qutqwUFpP9A1HpQX3aw51ArUP8pyYXNtmJFnM8p+5HXivpeUZRzA
        SrM080KJk9pWCYCHqcGQTXZ+xFZXf8JBLLPIFvefNwYBYLYLMPX47rnR88ppZb+2
        42JAThNyqBn1guea8fptA==
X-ME-Sender: <xms:JFR2ZYnXIS5YIxpK9f5Hz70UqKumv8y2eY7oeU0nthSkK2E2S4uYZA>
    <xme:JFR2ZX33T9RefHvGIf7NV_cpOG-JwkvtYqVwUiyAt5ZHfK2r_ZMyi29OF1N6dHN63
    IUPnLzl2IERsemK9ig>
X-ME-Received: <xmr:JFR2ZWoGA8Nyfe9HdggV9n7LG5RfITCYLSplQq0eKCjor_leatBeXVMhpNrd2ocxrHu62ywKE0Zyu4U-R9oUWj7_Nl0mXGbHk3dcrQjAvfM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:JFR2ZUljqNqcoXVf_9Nu_OtUcJ7Fi0C3dQhEpo2Y1ySUP9ia0xapaA>
    <xmx:JFR2ZW2gdXQititA_9PcDuchttZS1ic4_wonbzWLKUMvhJieezc-Gw>
    <xmx:JFR2ZbvYmS-Xq87i91H-ghhuLOLYBXVXeq-SGkv2xUN7BtJtGTuiYA>
    <xmx:JFR2Zbx6IA7MnIE4sznFfUKuCMjFAByMKwZyTE0KtF1D9z7XKhs_JQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Dec 2023 19:13:24 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 3/5] staging: rtl8192e: rename variable HTConstructCapabilityElement
Date:   Sun, 10 Dec 2023 19:13:33 -0500
Message-ID: <20231211001335.26169-4-garyrookard@fastmail.org>
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
rename it. HTConstructCapabilityElement -> ht_construct_capability_element

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 2a3cb6434100..c2c7fc316f62 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -247,7 +247,7 @@ void ht_reset_iot_setting(struct rt_hi_throughput *ht_info)
 	ht_info->iot_ra_func = 0;
 }
 
-void HTConstructCapabilityElement(struct rtllib_device *ieee, u8 *posHTCap,
+void ht_construct_capability_element(struct rtllib_device *ieee, u8 *posHTCap,
 				  u8 *len, u8 IsEncrypt, bool bAssoc)
 {
 	struct rt_hi_throughput *pHT = ieee->ht_info;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index e8c795faf4f9..ff3ba9bca023 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1755,7 +1755,7 @@ void HTSetConnectBwMode(struct rtllib_device *ieee,
 			enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset);
 void ht_update_default_setting(struct rtllib_device *ieee);
-void HTConstructCapabilityElement(struct rtllib_device *ieee,
+void ht_construct_capability_element(struct rtllib_device *ieee,
 				  u8 *posHTCap, u8 *len,
 				  u8 isEncrypt, bool bAssoc);
 void HTConstructRT2RTAggElement(struct rtllib_device *ieee,
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 296c2ca643e8..9e9725ed8fa0 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -733,7 +733,7 @@ rtllib_association_req(struct rtllib_network *beacon,
 	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht) {
 		ht_cap_buf = (u8 *)&(ieee->ht_info->SelfHTCap);
 		ht_cap_len = sizeof(ieee->ht_info->SelfHTCap);
-		HTConstructCapabilityElement(ieee, ht_cap_buf, &ht_cap_len,
+		ht_construct_capability_element(ieee, ht_cap_buf, &ht_cap_len,
 					     encrypt, true);
 		if (ieee->ht_info->current_rt2rt_aggregation) {
 			realtek_ie_buf = ieee->ht_info->sz_rt2rt_agg_buf;
-- 
2.41.0

