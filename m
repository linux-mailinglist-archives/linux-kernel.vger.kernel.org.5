Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF6A7F8FD7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 23:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjKYWek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 17:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjKYWeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 17:34:36 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E261119
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 14:34:43 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id 80E765C01B6;
        Sat, 25 Nov 2023 17:34:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sat, 25 Nov 2023 17:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1700951682; x=
        1701038082; bh=gqciJXCIfQMDcREYb+UEOq9HfqNJt8A3t4egWRDGqsI=; b=Q
        UT9YHRgBh1S72dl/0XWIa3Z5tdQUu+BEYQEnEYpSYh8vNgQSFCgI+Hfsd0gfkF4L
        jvmJp3m9TWVJ0zW5RMwXaZLLF6HtKaT58HHYsdsomC9bTJJiAkiNV7ariKvlywrv
        dSxaY55ET/9LJoI6XvWRBdBG3txePSp8dGn+Iip1HqBO6erlikFVE/UmKnAwE0ps
        wubq1DKJLpTxus688jnJ7AyiduDpeofbCCPohzvWvGYvKaQKtyasGJYNvCubmoyU
        LnHNqu8hc9D0LHDLumYygADNKhu78ic77uaFE32u5R/O3BHZLIfFhV/Pm6Vmaf+K
        fm/lL6ZmXNaGixCC6Ixtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700951682; x=
        1701038082; bh=gqciJXCIfQMDcREYb+UEOq9HfqNJt8A3t4egWRDGqsI=; b=M
        Y/i3bETuXS5fap91tWwSV8gTukGzzq/KjBSY2eE2Tfnnglut6bVZdMlu/cAB+Ztw
        kA70aW+37BRxRiF7DjbT7sOhUMH1ivbPuOvks2AVoPzGQIyXv9PMaCcyayHIdtM3
        7ZlqHVEYIs65WKk+ZR9lQHRRNcfhqmTQ6jfCSmCzda9LvR4EZMSDlh2r93LR3XsR
        AJZbHrrYA38og8+fq/EuRiOCfJO7n4R0OVjpS5FYacZkfTYOqe/Nt+GFo6JvwcKh
        vIQFVlBHvlDoGlkBxhsZR8KlCgN3g8s0vKa17dPszO7mkuwupNy8CtcFKSiWtWij
        FTvyM/FYN9LC17Ny3fc4g==
X-ME-Sender: <xms:gnZiZbYhT_5V_uUkp-9IBP5cwPEBkrg_uBvHU1zVRT0SAcrSOnJqxw>
    <xme:gnZiZab6uI8YIeFYM4gWHdDHN51lj82bQ12oLx2wSYZpb-AVjYEEW3qjZflHpTvnr
    LPdvSqC2_001LsL9Zw>
X-ME-Received: <xmr:gnZiZd80XF-6bbMEZTNuCVfxHWXsr466zuVvLsmHAnEyu_QJGGhUVdrzjM7diindaEMg8C-hCwwNuGh54ltAPpmEhH9NzC6i25NmxCPWZKe3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehjedgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhk
    rghrugesfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeekuedvffeuud
    ekgeeiueffjeehgfekteefheeuleefudeugfevleelhfefgfejvdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhguse
    hfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:gnZiZRpJOtZ0tO9MAJ_wB1Tj6Nq-NGPg3vIWDEAYI5L_KR-s-REhCg>
    <xmx:gnZiZWpAusChDUl5fokMoHbwohVyZruR07Lkzn99TlzbrDJEenu9LA>
    <xmx:gnZiZXRFyzNznd3YNUffiCgWnffVemoB3C2VJ9E-2lKHs38vQmHgDQ>
    <xmx:gnZiZZVlw-hzjF1gPp8tDyQbDgijsiYY7U1MIu5ZifZUiPp9RWJoTg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Nov 2023 17:34:41 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 2/5] staging: rtl8192e: renamed variable isShortGI
Date:   Sat, 25 Nov 2023 17:34:29 -0500
Message-ID: <20231125223432.13780-3-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231125223432.13780-1-garyrookard@fastmail.org>
References: <20231125223432.13780-1-garyrookard@fastmail.org>
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

Renamed from CamelCase to Snake case the variable isShortGI
isShortGI -> is_short_gi

Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver/module compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 7e61ebd2bc25..f002d948a316 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -108,10 +108,10 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 n_mcs_rate)
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
 	u8	is40MHz = (ht_info->bCurBW40MHz) ? 1 : 0;
-	u8	isShortGI = (ht_info->bCurBW40MHz) ?
+	u8	is_short_gi = (ht_info->bCurBW40MHz) ?
 			    ((ht_info->bCurShortGI40MHz) ? 1 : 0) :
 			    ((ht_info->bCurShortGI20MHz) ? 1 : 0);
-	return MCS_DATA_RATE[is40MHz][isShortGI][(n_mcs_rate & 0x7f)];
+	return MCS_DATA_RATE[is40MHz][is_short_gi][(n_mcs_rate & 0x7f)];
 }
 
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
@@ -119,24 +119,24 @@ u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
 	u16	CCKOFDMRate[12] = {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18,
 				   0x24, 0x30, 0x48, 0x60, 0x6c};
 	u8	is40MHz = 0;
-	u8	isShortGI = 0;
+	u8	is_short_gi = 0;
 
 	if (nDataRate < 12)
 		return CCKOFDMRate[nDataRate];
 	if (nDataRate >= 0x10 && nDataRate <= 0x1f) {
 		is40MHz = 0;
-		isShortGI = 0;
+		is_short_gi = 0;
 	} else if (nDataRate >= 0x20  && nDataRate <= 0x2f) {
 		is40MHz = 1;
-		isShortGI = 0;
+		is_short_gi = 0;
 	} else if (nDataRate >= 0x30  && nDataRate <= 0x3f) {
 		is40MHz = 0;
-		isShortGI = 1;
+		is_short_gi = 1;
 	} else if (nDataRate >= 0x40  && nDataRate <= 0x4f) {
 		is40MHz = 1;
-		isShortGI = 1;
+		is_short_gi = 1;
 	}
-	return MCS_DATA_RATE[is40MHz][isShortGI][nDataRate & 0xf];
+	return MCS_DATA_RATE[is40MHz][is_short_gi][nDataRate & 0xf];
 }
 
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee)
-- 
2.41.0

