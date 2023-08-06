Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBD7771523
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 15:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjHFNHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 09:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFNHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 09:07:31 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B958319A6;
        Sun,  6 Aug 2023 06:07:29 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RJfqy5M5Mz9stK;
        Sun,  6 Aug 2023 15:07:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691327246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QjIv1HLGr8M+5FVCd5ineasqD/tSHOm93SA0NvSqrHk=;
        b=Gx+OkUETVuPsXIdpsbBbcj+fKzKlvOQ1uCKGlZt3DD2iUcxI2XAZ2AmywPWG6mFXVcj0W1
        0Eifu1Adxz7wRdY0jwOlOKnR22JcE7H111YjCwhoGO5SehKd943GUavid6A2Dfe1FmVEKr
        eHy72HIgKnGeswSJZ7GwcFWUA4um+OtofeCUFPHv6eS8aINvUtTKcpzKlokn6s58s/IgfP
        fsxMfztWXyiwczO+PXAQ/MCcqcyV/DwL7WY+m2IpyVopPOnvKRq8QSRJl41Y1bYeatQCZh
        GyqmRrAz0NeiMGPcnb8Kmif3+awGeryx020i/x+XLKMTjQgMwcEmJmXRkD27Pw==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 06 Aug 2023 15:06:46 +0200
Subject: [PATCH v5 01/11] clk: sunxi-ng: nkm: Use correct parameter name
 for parent HW
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-pll-mipi_set_rate_parent-v5-1-db4f5ca33fc3@oltmanns.dev>
References: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
In-Reply-To: <20230806-pll-mipi_set_rate_parent-v5-0-db4f5ca33fc3@oltmanns.dev>
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=Sswnw4bRuM7bW6xD6gAVjI9f1VtIg89IqRRpy5EZ2+s=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkz5sGou+voxb/S82pNeivjmNnup8GMti5l+ah3
 DMm2uRpC96JAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZM+bBgAKCRCaaaIIlErT
 x1pVC/9zkO8bLiH9IvDUTmhwUR5N261doqXodIn1o08jSfjRjGsGa41iNBtr9QEanG2aMXh+WD8
 xHVWs5uHdS/sD5mKKI0yohq7m+WOb6H90x0YOZB0vZ0vyysBK1TiwutPEfUY+JBAHAWdR+L1V+/
 vhMBRdx8RarjeN/RsyF4Sh5Hpgei+uLeqEGsgLoVDzOtRj2I6S72I2ME1VKlksDKbQPhr2oTreN
 iTCOPy7mgWBfqnAXVPlQ9MharQBXYr1eSK+E6jeXKekx4lCLRKPzukMqYWIt5WIFK4tbr9cKMGq
 H3burQ/LIWxmspQQZ+wszhA5mCGV5dmd5Rnp39LO24mrigB3/1MH7eVI0T6NdaDsSzMrcEV7umi
 2iY5BnN5QbZFM6gOEytR2wivhhrYgclMhAlt7lZ37mnJnrLx6FsmqbrvjXVXqXPvMmEln2s1A15
 nyDkWz6TtbV6qrd49bMexw7dWCM0MaO26Hn+tEoJw35GaZwmKnwq8I7CStQbgupSPHxPY=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4RJfqy5M5Mz9stK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ccu_nkm_round_rate() takes a clk_hw as parameter "hw". Since "hw" is the
nkm clock's parent clk_hw, not the clk_hw of the nkm clock itself,
change the parameter name to "parent_hw" to make it more clear what
we're dealing with.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu_nkm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index a0978a50edae..f267142e58b3 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -106,7 +106,7 @@ static unsigned long ccu_nkm_recalc_rate(struct clk_hw *hw,
 }
 
 static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
-					struct clk_hw *hw,
+					struct clk_hw *parent_hw,
 					unsigned long *parent_rate,
 					unsigned long rate,
 					void *data)

-- 
2.41.0

