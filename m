Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F787F8FD9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 23:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjKYWer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 17:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbjKYWeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 17:34:44 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F8018B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 14:34:49 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3AD135C0117;
        Sat, 25 Nov 2023 17:34:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 25 Nov 2023 17:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1700951689; x=
        1701038089; bh=UfgmNetnmT6pcHxIWVUCY7IgEe86zoWIG8ibMcMDTDk=; b=i
        Wz5Wk0JfsS1zNuWzbjcPa47F7WJWSZ7mGne1cmII+VzjnFUttXYuVflhhQXTJNgj
        sWywVlf7lxPc7Zhzo8YTXWnxUXuVOkLCc0FMzkxbilTPbsgrR5J88RQN1V8zwnuL
        p1MW3hHchR4dY6FXsZKwVjbGr3Bp7nkWvTHBks1rvC9JDwoAvo+d2l4BsJOM7SmO
        Vy/+MSBAFUSFB9WXT2WfmeAmz6JpyQ65JJRyZYoCYBJrOKPlhkGipFn3J5d3q8xg
        HnFXChin/CX5PYKMyNa+WddMVMeyK+bhPS5ZkeDpfrZhd15h35koIz2I/Iici4wQ
        qvUiPnu4QHHEMrcYVd1ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700951689; x=
        1701038089; bh=UfgmNetnmT6pcHxIWVUCY7IgEe86zoWIG8ibMcMDTDk=; b=J
        hlJXX9XZ8hveAzsZwQmSsq4qVWe+T2R2m2YURGrAVUL+khuicJnSB6om6KiCnG9E
        FHI99wfA6gOTl9ZQF8dr2m1tUgAWEGBtrbEfDxj8dkO3rrKzfK/DWwzBRo2B7HaZ
        UO3FKJ8ZX0UdbG+opBHpOgH/igHR64kpDiPh6Te/mv5cMvvcpZq0Thx9P55vrWY8
        8MQkOETWc5Leqn9V7wQsTq9WYQl/OP3Q9Zo+tgl59K1Ly+3chhf/6vKdIGZLTian
        Eu/Q+sCjnkA8+XolnpN0Uo+UllrnQVZOCMcK8srfbBZuk+7ymjn3PfcTEn5I2z4a
        Zn1WOTYMRfATIIS3kZWvw==
X-ME-Sender: <xms:iXZiZfMnWEEuF3gJOWqUvl2EzN8QF-ND2LaCrmjNsUaC_b-Mw_ta_A>
    <xme:iXZiZZ9wZ9w9GUPRZO9LXPkm3MdCpoPLI1ag2Lc_O_neEVAU81RjWypy0AaOUutt5
    ZA5Jum3gkV1CJrIVls>
X-ME-Received: <xmr:iXZiZeQlLnPntiY9mBFVtFybIE5qVZOUVMpY0BY6Wo0npS6crMS9JnLdEgp71NFNAmWUWuW3UA8vV1RLTrdzf2Ro6851SbBKvAxRJB3E_ZHm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehjedgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhk
    rghrugesfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeekuedvffeuud
    ekgeeiueffjeehgfekteefheeuleefudeugfevleelhfefgfejvdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhguse
    hfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:iXZiZTtmxGt_mnu9KaSbPC6sEiTjYJxotdl7kUXm1yDlWDWUtivfJw>
    <xmx:iXZiZXdNIPuTesOp4RcZ2e6AWyVSx_8TxAON07_I35Qjh6r7i1Vp1A>
    <xmx:iXZiZf2B9A6rlJoWp-Tiw8gWS15Skeo5b-ynOXDEOyzGR2XrzgVtSQ>
    <xmx:iXZiZT5KepzqLHtMhDGuRZO31TIoF_dDOLylfaTpeQwp6-WxYaYskg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Nov 2023 17:34:48 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 4/5] staging: rtl8192e: renamed variable nDataRate
Date:   Sat, 25 Nov 2023 17:34:31 -0500
Message-ID: <20231125223432.13780-5-garyrookard@fastmail.org>
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

Renamed from CamelCase to Snake case the variable nDataRate.

Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver/module rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f4de5ad7d9d1..82681d21ed2b 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -114,29 +114,29 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 n_mcs_rate)
 	return MCS_DATA_RATE[is40MHz][is_short_gi][(n_mcs_rate & 0x7f)];
 }
 
-u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
+u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 n_data_rate)
 {
 	u16	CCKOFDMRate[12] = {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18,
 				   0x24, 0x30, 0x48, 0x60, 0x6c};
 	u8	is40MHz = 0;
 	u8	is_short_gi = 0;
 
-	if (nDataRate < 12)
-		return CCKOFDMRate[nDataRate];
-	if (nDataRate >= 0x10 && nDataRate <= 0x1f) {
+	if (n_data_rate < 12)
+		return CCKOFDMRate[n_data_rate];
+	if (n_data_rate >= 0x10 && n_data_rate <= 0x1f) {
 		is40MHz = 0;
 		is_short_gi = 0;
-	} else if (nDataRate >= 0x20  && nDataRate <= 0x2f) {
+	} else if (n_data_rate >= 0x20  && n_data_rate <= 0x2f) {
 		is40MHz = 1;
 		is_short_gi = 0;
-	} else if (nDataRate >= 0x30  && nDataRate <= 0x3f) {
+	} else if (n_data_rate >= 0x30  && n_data_rate <= 0x3f) {
 		is40MHz = 0;
 		is_short_gi = 1;
-	} else if (nDataRate >= 0x40  && nDataRate <= 0x4f) {
+	} else if (n_data_rate >= 0x40  && n_data_rate <= 0x4f) {
 		is40MHz = 1;
 		is_short_gi = 1;
 	}
-	return MCS_DATA_RATE[is40MHz][is_short_gi][nDataRate & 0xf];
+	return MCS_DATA_RATE[is40MHz][is_short_gi][n_data_rate & 0xf];
 }
 
 bool is_ht_half_nmode_aps(struct rtllib_device *ieee)
-- 
2.41.0

