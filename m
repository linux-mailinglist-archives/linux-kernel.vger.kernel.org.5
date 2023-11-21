Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7377F35C3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjKUSO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjKUSO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:14:57 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09156193
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:14:54 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 24A4F3201928;
        Tue, 21 Nov 2023 13:14:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 21 Nov 2023 13:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1700590492; x=
        1700676892; bh=9rRVIO4sacT/WuKNye++g7i1GjccmOxkpvkcPs1Z4KY=; b=W
        HILJ1/JKWzU9UVfQSgl802z15F+A0JXblqmKH4cn/9QuAbR9R8XoCCqsXo3jmDF4
        wfR6G4culql6PNzPTUncs7d1M2ARsnh8fOuxDf0YmbBEr1EPMxp/4NQ+m6H1nnhR
        LWBplBMFUJpWF9/RTts6zknDUR+sjClMb9P14fjHi3H+30fVYQPK4AUfqXxOfVvq
        JiPrU4RnBm+YZoNd209krXUPz5k5/hb5r6t8IgZl66ovTdb19vN/dPpnhpGzukbo
        fR2M5WQ4dgHdF1Otmv5L/HiTwr1gDkSz8dAlxKMwf7WmLjyIBaByUNSDMakYqrf3
        jwPqA3t431DHwCiVilaeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700590492; x=
        1700676892; bh=9rRVIO4sacT/WuKNye++g7i1GjccmOxkpvkcPs1Z4KY=; b=R
        SbjTL0o0LUYs+FWoSSxjSD9Gv+bG23F9Z74Qclgt6dh752vH8aFxNp4GyuFFihgS
        7PYFBhHhui9mA5vat+ZeBajzzOqIeUN8gDKzBKB8a+6FQOGf14ULaUlITlU5/ed7
        ZnVDb5VQc3n3vFJyQfX+J5CIxMrPdPGWO0LJpIYH4YfTPLHjRlIIHQrloXjap3ys
        QULAPdDKpHUQ4mCNS4DcvQnFblE25WjmD+Uu29zgGEjvnsDXqEWEFxZpVgQ1cdcm
        U1HZN2NcWmOCAPIBH63oNplyKRTzyv+bYh26hhugybp+2ghc2VgakPtPtyI7bH+v
        Hcw6ip2HO5+xZtXHv1lbg==
X-ME-Sender: <xms:nPNcZbJdY3cOrJNxjG9nkXjiC5wX1rwjMUijRmE3FZ3NkBEr1m2dGA>
    <xme:nPNcZfLsih8IR9pprosOk5oEpslLTGLPTi9gcaJAGAGxBtcds5768M_lPYCgJcBrf
    PtH7DvS8XsLeVZSgH8>
X-ME-Received: <xmr:nPNcZTungIHNCQXVv1uIJzMArbq072ZMP6UdJ8XiMuJ4uVuvZhGLiyPcBsGcZgClm4dJn904JSrCqGfi-YobVEYGuFoJhj15a8Fay4mgv_VL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
    ekredtredttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhk
    rghrugesfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeekuedvffeuud
    ekgeeiueffjeehgfekteefheeuleefudeugfevleelhfefgfejvdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhguse
    hfrghsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:nPNcZUaiTVOpJZE_HbX5fb0LaluPqW25Qo7d11Z6p-b0JmIoZPd3BQ>
    <xmx:nPNcZSbApMDDx1FxsGqSIDXiKJzHd1O0WmvA90WFTUNDoRfkCWfjwA>
    <xmx:nPNcZYCQtqJ-Y3uWPD9rKtt7GjcEqFIweqE2KKVgyD42g7eKq--EUQ>
    <xmx:nPNcZSGGcKXnLX1idajyq2Qu3dy7afWdc2NDo-uGDlBfYWWSk06ICA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 13:14:52 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 1/5] staging: rtl8192e; renamed variable HTMcsToDataRate
Date:   Tue, 21 Nov 2023 13:14:31 -0500
Message-ID: <20231121181435.9337-2-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121181435.9337-1-garyrookard@fastmail.org>
References: <20231121181435.9337-1-garyrookard@fastmail.org>
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

Renamed variable from Pascal/CamelCase to Snake case the variable
HTMcsToDataRate.
HTMcsToDataRate -> ht_mcs_to_data_rate

Linux Kernel coding style (cleanup), checkpatch Avoid CamelCase.
Driver/module rtl8192e compiles.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index e607bccc079a..280e335cbb6d 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -103,7 +103,7 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 	ht_info->rx_reorder_pending_time = 30;
 }
 
-static u16 HTMcsToDataRate(struct rtllib_device *ieee, u8 nMcsRate)
+static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 nMcsRate)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
@@ -422,8 +422,8 @@ u8 HTGetHighestMCSRate(struct rtllib_device *ieee, u8 *pMCSRateSet,
 			bitMap = availableMcsRate[i];
 			for (j = 0; j < 8; j++) {
 				if ((bitMap % 2) != 0) {
-					if (HTMcsToDataRate(ieee, (8 * i + j)) >
-					    HTMcsToDataRate(ieee, mcsRate))
+					if (ht_mcs_to_data_rate(ieee, (8 * i + j)) >
+					    ht_mcs_to_data_rate(ieee, mcsRate))
 						mcsRate = 8 * i + j;
 				}
 				bitMap >>= 1;
-- 
2.41.0

