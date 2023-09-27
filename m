Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1AC7B0EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjI0WhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI0WhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:37:12 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057E1AF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:37:10 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F81D5C28C9;
        Wed, 27 Sep 2023 18:36:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 Sep 2023 18:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1695854162; x=1695940562; bh=cIxox338FB
        bGAustO1WcDvxTsjNNrAH/UryFJoEr9uw=; b=GuBDln7zO6JgIzHn7hqRl9vLbl
        NMYWQ5VAnTJfxHo9dAasCRyXxCiUz59yohwG3WwK/SHDaM/hP2TYHmJcU6rvdKJn
        v0RsP/l6VyhbTV9qO/+T7sPw4Cx3wy7Bzvv+Z3mb9ED/f7x2DgCPEUZEZfmpV0hq
        2aFWrGUm/eMqmc6llr6szKeSU3A1L40Cfg9KWCga1lRwlG6bX/T3QA1fpgmH3Iwy
        pxg50fIukAvkAuIsZuNHX3Aak4z+UXSFNA6qsr5foD6+lXWr8L4j2jk66tyzyVJB
        3HAZY6MZOqJqlVyJlGPU/xvS+vQ3iw1YMXR0ov3kp/efEqJwv5R61Z50Jm5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695854162; x=1695940562; bh=cIxox338FBbGA
        ustO1WcDvxTsjNNrAH/UryFJoEr9uw=; b=lldpGNk/GHH0iqE+UgjII9+tPPPsX
        uh8tz9w9MacOlGuXQ/pmNVfZ27R9wN6zK9lYljwhi/LCf1wmxSWd2A8cUcbS4184
        CR9oIEFK3IbslMnsb7EB6tHSTAvwDtVahhQ4WtMLg0/oRSd1HrdyF7efGjnDy4PK
        9dH7B4asUj2ryvspiTG0MHKgKaSPrSVcuIz6rcDohWLIZd0oiaBMviYP17qb1G6Y
        HGN8X4CvUWR+eNmlEyszjRuvheALWTUCaCKytmyxjCjMs23r7qGJPc3MCbBWjfsj
        FMRDCYAOShCkeSSObeyQDt4nqEbwrVwmy2Sk4fUM3opy1ag9a14toZBhQ==
X-ME-Sender: <xms:Ua4UZS_6m5NmF3ElbXYF48NryBgJmqxIayJXqQKP0Nsf-jEkPiMcTg>
    <xme:Ua4UZSvcealRPM2tZJWEbNLVMdMWWu5pkrdm0g22Gi-aNv-L3PoQDQ_7ebh6Ip8l5
    NHZ4KGdQJlnZMYNcPs>
X-ME-Received: <xmr:Ua4UZYC4td11pYzv6SGz3IuafDP4tS5RbBwxbJ_hJuubDhK7yJd7AZuhSb12kLrMvtXYqA_HfBehf6sz_9J-PFt5jQHHZ-PSs1LUOEiJrQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdehgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhkrghruges
    fhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeelgefffffghefhjeegje
    ehiedvgfelfeehueeuteektdffiefhveelhfegvedvveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrghsth
    hmrghilhdrohhrgh
X-ME-Proxy: <xmx:Ua4UZaf6BQXjUj-mhg4egb8Qzb7TP3jq3sYmKDR3bQ22LPq0aPHlZw>
    <xmx:Ua4UZXOH9aJ95ndsD8RmPD-TQuPQwyVSY2gI7l39XlabZblkyV6shQ>
    <xmx:Ua4UZUmaJhM28Y_ibpviq8xIrFi8Bx4T2nybgsN-58fNXf90La_BIw>
    <xmx:Uq4UZQbwMD5a00ZbhOvUAyQ_bIXJN96uu1cSzeZZARlgIxYlb6UZUA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 18:36:01 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v3] Subject: [PATCH v3] staging: rtl8192e: renamed (3) variables
Date:   Wed, 27 Sep 2023 18:35:19 -0400
Message-ID: <20230927223519.27213-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

