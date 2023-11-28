Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F287FC2EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbjK1SRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjK1SRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:17:18 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671D71990
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:17:24 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D23345C01E9;
        Tue, 28 Nov 2023 13:17:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 28 Nov 2023 13:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701195443; x=
        1701281843; bh=DGt/u5VtnW/s5etlOXvVuEt4iqTg+WUDCBQcBJzdb9s=; b=L
        88rWrZd+XyCW2CLPeh73uDIHOW8Y6+GD0nMUCcUVK6XnU4VgwvpbXVI4pvBnU95A
        Ur7hiiUmhejrrEfvL46aHMcLODRjzN0dQQuyOneY77Rju0kKYbne+Xwwz682zoSB
        aS7tN8rK5NxNS2ryrzU/ig7nfk9gU1i+ii0+VZaHLZOFv9w9xWizT/7hwK+lGRqm
        txAHE99pCrLA8A16gBsxNkqGwXSA6RZU78xnYtOKAAeIgkMtwvFLAcOfxSUNVZSj
        4VLdXSUabn5dpMy0Hx1wtTfYB8lQZhjsige04NRa9Hb2JkJ4MxQ4HS/iLKDqYUes
        QxDTOtfbvzvA0V7UF583g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701195443; x=
        1701281843; bh=DGt/u5VtnW/s5etlOXvVuEt4iqTg+WUDCBQcBJzdb9s=; b=K
        6b7FxNhVk0ktnPxP6roBlqPDlNY+SJFXFWBFBcwNzW04z4DskvV2c/3AItMKwFIp
        GL8T4UxyfQRn6LSpHVw96aA0Rsjxp454mJyjmRe2AnYcTmFH26Fw6aSHHVhrb9NX
        9gF6eiBpWa3dmbFFhuAoTCBEETS/7x3K9MQtjLTAJsLO9PM6qJw7izdWw6G1FJpG
        h3wVJ3FBCHFfb3TuWiOmk3rkSvQ2lTWltkU8fWJECYiHh6eG0SLt8ry3ZIrDtui8
        ctLxRoKWhsbFC6mQ3WIAvv+1FQwNtgAvy1r36PJaSsgkBQ0mnjFB96zS6eeP+7J+
        RcWiyRnYhuZYATfxrzgpQ==
X-ME-Sender: <xms:sy5mZUTuJiUOqfQFFCvec0EUWg-ZbXUFTyVxUedVV6HNBmI1KSlrAw>
    <xme:sy5mZRynSrI3hTwKcymJ3PM3R4HHmq-irrLzyJkcrCBKRhYNI9DQhodZWYEAAgs4j
    O8oECITWofzZYDFkv4>
X-ME-Received: <xmr:sy5mZR2nHEkemhjKeZUs3Ouiis0VpI66lTQseR1A7z2Z5fGL68YOrBhGo4abEgJHrdjYUul2y0NZA7KMBdDeMUutuDIs2WAAq--2aB4hYeGx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhk
    rghrugesfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeekuedvffeuud
    ekgeeiueffjeehgfekteefheeuleefudeugfevleelhfefgfejvdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhguse
    hfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:sy5mZYCh9lil9tNz5r_fZSfqHXOslho1CwTTRzpDCRMARHft3b9zew>
    <xmx:sy5mZdiHX5Sv2ncYqr3c-p996z8AZqeTiPP6jTHq4_kn_XIOFYquXw>
    <xmx:sy5mZUqDvwzaVLyL2N-RanlQyUfDusLQv32eauuSUAoZg8e9gwchag>
    <xmx:sy5mZStIlWxbPZ8JUHKd_PDDpFmHcyBNT_z3xPzTs1ofjEs0zucjfQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 13:17:23 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH v3 1/3] staging: rtl8192e: renamed variable nMcsRate
Date:   Tue, 28 Nov 2023 13:17:25 -0500
Message-ID: <20231128181727.19504-2-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128181727.19504-1-garyrookard@fastmail.org>
References: <20231128181727.19504-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style issue, checkpatch Avoid CamelCase,
rename it nMcsRate -> mcs_rate.


Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
v3: Corrects commit message style issues.
v2: Style issues, redo.
v1: Style issues, redo.
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 00273d709f3c..4ed72936eb4a 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -103,7 +103,7 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 	ht_info->rx_reorder_pending_time = 30;
 }
 
-static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 nMcsRate)
+static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 mcs_rate)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
@@ -111,7 +111,7 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 nMcsRate)
 	u8	isShortGI = (ht_info->bCurBW40MHz) ?
 			    ((ht_info->bCurShortGI40MHz) ? 1 : 0) :
 			    ((ht_info->bCurShortGI20MHz) ? 1 : 0);
-	return MCS_DATA_RATE[is40MHz][isShortGI][(nMcsRate & 0x7f)];
+	return MCS_DATA_RATE[is40MHz][isShortGI][(mcs_rate & 0x7f)];
 }
 
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 nDataRate)
-- 
2.41.0

