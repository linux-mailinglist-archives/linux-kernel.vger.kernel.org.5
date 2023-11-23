Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2777F61CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345915AbjKWOoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345905AbjKWOoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:44:00 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972A4D6E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:44:04 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id AC2AE3200A2D;
        Thu, 23 Nov 2023 09:44:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 23 Nov 2023 09:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1700750643; x=
        1700837043; bh=2+oCaAJMz2K+v99Rw3IHlg2+n9lVGfZLcZHc+W8P+GY=; b=A
        cIxC/V0Md1kHOullpFMoe3xHyCziytcRjiSFuvolVNfOZPijJvBiWcMgrXnblNuH
        nIbCcH21BnaNSTXpDzpKZiZpo5AZjOPN9gWDLBYKV4MJ+Vlmr50F6RxKTH2DI6ZV
        CXqpMQ9G16RM/guAz2LlSjEUTo35A5fCiabCujC1l0Rpn0CoSokSqvbBAvbQ4hd7
        OZz/FJyGlhukVFQo3I80WOIxg67EzOAOAhzqfCE8f4Wayhy4RMhs0dA3jgSt0ikz
        Yq2D/AgOxJgBw0WQOgkYHl2TOxbd+rb4gsR1bf8JmV86VM92d3s8rzi0bbqT+AE+
        8v5KcFj4rDUSN6+sU573A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700750643; x=
        1700837043; bh=2+oCaAJMz2K+v99Rw3IHlg2+n9lVGfZLcZHc+W8P+GY=; b=Y
        SlzWTSPOTp7izPAW4yi7TOtPUejcyem4+j00+fyRcTObuR1LJeq35foNCCkXHVVR
        hHKzPc4XDJ1YUcsmP4jsf8SPuq2GS0mdss+10rvYEfMLwAVJvjFFAxizfdAWUu0q
        06ZaexNYieG/p/NxX7yviB89bnRyBc06VbGrxJTk5R0OFn0nzNfusOudjpVxykbu
        +0h9oqFfw25y2DPL9VFusX41kLSHO6DFeWjvfzxIRZKgFtDjuPC9Xu9fEp9nt9hE
        fXmW2MyVVrosexnwD9N3oQ4BgKXH3ePM7W67jjydG5bQwL91KTuaeRhl3yG4qNF+
        R6sFsZjSdlHzLixmlaSwg==
X-ME-Sender: <xms:M2VfZa2eR0OYa8eoVI6zB3ta__sl94KM0Mfk0yY9Dko_5hfKpy11IQ>
    <xme:M2VfZdEZgJMfxXHgQLWqqR8PS-qUNdWlTNhzCdR1Mm1D3Bapnsov1kPqs1ghzMcRh
    5LbE_Bvq69bpOIKSDQ>
X-ME-Received: <xmr:M2VfZS4cyeYG8m2mfA8BHWTS9c-Sqrqh9vCdB5DH6mbNC4QPv6yUOzNU2GPsFdrCKOEFpkx-IU0jx4F6-QUVUbhl-uPMc-xFlMjQ6w99nu1Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehfedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:M2VfZb2_PRZsPN9ZcHpH507c-27e1D_940GB5KYFVFuy_1jRRSf7lQ>
    <xmx:M2VfZdE1DtcHNNDPuOBAiveBM1vjRkyUK7VYID3sCXkXVXnKn2xobw>
    <xmx:M2VfZU9M-bDLJWUEEwkclqQD8J9GJ5fjOSMJUUd8hOa_g3QzXJlvZQ>
    <xmx:M2VfZdBMm6RFbfb3Caj1yXyF-kocrO6yeGCcsOlQzl3V502ozzRliw>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Nov 2023 09:44:02 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v3 3/5] staging: rtl8192e: renamed variable IsHTHalfNmodeAPs
Date:   Thu, 23 Nov 2023 09:43:35 -0500
Message-ID: <20231123144337.13112-4-garyrookard@fastmail.org>
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
IsHTHalfNmodeAPs.
ISHTHalfNmodeAPs -> is_ht_half_nmode_aps

Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver/module rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v3: Corrected versioning from v1 -> v3, includes change history.
v2: v2 was skipped over..v3 corrects this.
v1: Style and compile issues, asked to redo.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h         | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index fb8294f31a60..0993263c13d3 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -139,7 +139,7 @@ u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
 	return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate & 0xf];
 }
 
-bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
+bool is_ht_half_nmode_aps(struct rtllib_device *ieee)
 {
 	bool			retValue = false;
 	struct rtllib_network *net = &ieee->current_network;
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0226a69f40c3..6b549629087b 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1782,7 +1782,7 @@ extern u8 MCS_FILTER_ALL[];
 extern u16 MCS_DATA_RATE[2][2][77];
 u8 HTCCheck(struct rtllib_device *ieee, u8 *pFrame);
 void HTResetIOTSetting(struct rt_hi_throughput *ht_info);
-bool IsHTHalfNmodeAPs(struct rtllib_device *ieee);
+bool is_ht_half_nmode_aps(struct rtllib_device *ieee);
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate);
 int rtllib_rx_ADDBAReq(struct rtllib_device *ieee, struct sk_buff *skb);
 int rtllib_rx_ADDBARsp(struct rtllib_device *ieee, struct sk_buff *skb);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 42d652fe8601..89bc38774fa7 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1872,7 +1872,7 @@ static void rtllib_rx_auth_resp(struct rtllib_device *ieee, struct sk_buff *skb)
 		ieee->softmac_stats.rx_auth_rs_ok++;
 		if (!(ieee->ht_info->iot_action & HT_IOT_ACT_PURE_N_MODE)) {
 			if (!ieee->GetNmodeSupportBySecCfg(ieee->dev)) {
-				if (IsHTHalfNmodeAPs(ieee)) {
+				if (is_ht_half_nmode_aps(ieee)) {
 					bSupportNmode = true;
 					bHalfSupportNmode = true;
 				} else {
-- 
2.41.0

