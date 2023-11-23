Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054E77F61CE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345906AbjKWOoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345899AbjKWOoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:44:12 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49D8D4A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:44:19 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id BA2EB3200AA9;
        Thu, 23 Nov 2023 09:44:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 23 Nov 2023 09:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1700750658; x=
        1700837058; bh=/b4ZzXmogOrXx8ItQTm69B3Pdlitd1fiL+X/xKkaPfc=; b=A
        EJ4u3vqysIBumCKAgqG9eWqFAwJZj/dY1bdJ5v6pqMnP9xEc/Q2H+SQBRYWquRgz
        YczvXVPRiFFv+aQrf4dFkmhRB8/khhPuLBsuurAMC2G+TXj086LGxLsNRQsl3wso
        qmgPbN9Z5LIW1jtXkBP6vNWEfgnLSUyQizjS7hUzpA2PG6A1l5Qay9LoXXODs3tb
        dQn/09Ojvy3tir/ZMeaXRWuRHClQXjoIVkDJD3Tu7TcQ0uCJWlvct3bxXPgmfjbb
        Xp0KPkgiWOgp+NvBK9wPR4QJ3q5G/V8B1FJmRRf1EtBVgbM80Vf2Eb02/+HCtPaB
        g1DKr2zkOzlhYu88dtplg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700750658; x=
        1700837058; bh=/b4ZzXmogOrXx8ItQTm69B3Pdlitd1fiL+X/xKkaPfc=; b=m
        RHmmJJmAu0/eij3VmR3SKDVpYeiiaV8DYeGH91gVfQAG9/qDa7Yp2y+lW4ImRrvf
        DnOVV7xuwOjqEMlNJeQTcZOXe+c390BWYHPq50YVOIgEL06NqFD3eMXrvcO8RNw0
        0tsjAcH3hh58aRXcIhDROmhWduxEem8CD7b2KmqDXxHnh0Jh7CwJb6KWKZTxUNCb
        NDyr7xEZMK0dm+fu/uNMwYL7hGQK+tLBf1nN7NiHqb/wLXhjAArV6RTnBeFmPJDn
        wypM9QJ/qMCKxFeOMl8lzCPFVCev4Ym4MrgoIxnNCC/Q66WAVgsqWlKps6Kkhk9N
        6UQccRUjPAsSh8T8u0Pdg==
X-ME-Sender: <xms:QmVfZRyT9nZV9UINZGqmkayG9L3rESzST_It0fOI2YFfu6v5uQlrTg>
    <xme:QmVfZRTn7Vy4DIVVHt5HetktQfAiJ6Pn4F_OX9F9ctjscbUlgh8O_N9KLixotUrnH
    N-yUIGClUr-rBC5aOI>
X-ME-Received: <xmr:QmVfZbWzt6SdamUS100QcU3w7n5iyq_3ttXlstmvlfcKieY_HGIosGo9SdazJ4IAX_mdPloKSRxs7Bmf6DZYRz5hSy-40t72fwz0I5aHTEVf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehfedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:QmVfZTiOaxP7_DO4VD_7b2psAYAwnBV0CSEHB00IDy6_X4rQ74JHpg>
    <xmx:QmVfZTCidc55VGt-4uR-DSFpto1pFS1b94XvRYpUSGQ0dQ71JWvORA>
    <xmx:QmVfZcLK8zwI9rVWeObimMJK8ACFcpRDVY0fzfO5-45AwOySVnTECA>
    <xmx:QmVfZaMGDvgJ_oYAz703NpfFCQk_vZt48OujBumVOqopTUUyfLq7Uw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Nov 2023 09:44:17 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v3 4/5] staging: rtl8192e: renamed variable HTIOTPeerDetermine
Date:   Thu, 23 Nov 2023 09:43:36 -0500
Message-ID: <20231123144337.13112-5-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123144337.13112-1-garyrookard@fastmail.org>
References: <20231123144337.13112-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renamed from Pascal/CamelCase to Snake case the variable
HTIOTPeerDetermine.
HTIOTPeerDetermine -> ht_iot_peer_determine

Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver/module rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v3: Corrected versioning from v1 -> v3, includes change history.
v2: v2 was skipped over..v3 corrects this.
v1: Style and compile issues, asked to redo.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 0993263c13d3..0873c19ca051 100644
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
@@ -672,7 +672,7 @@ void HTResetSelfAndSavePeerSetting(struct rtllib_device *ieee,
 			ht_info->RT2RT_HT_Mode = (enum rt_ht_capability)0;
 		}
 
-		HTIOTPeerDetermine(ieee);
+		ht_iot_peer_determine(ieee);
 
 		ht_info->iot_action = 0;
 		bIOTAction = HTIOTActIsMgntUseCCK6M(ieee, pNetwork);
-- 
2.41.0

