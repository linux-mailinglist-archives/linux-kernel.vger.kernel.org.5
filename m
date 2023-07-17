Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3127C756515
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjGQNer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjGQNeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:34:46 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B229D1;
        Mon, 17 Jul 2023 06:34:45 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4R4NNd5Wr3z9sSZ;
        Mon, 17 Jul 2023 15:34:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1689600881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rv0VQb3dID9vli2KRI1IVx8tJ5Pn4HiXMxnfk/v2f54=;
        b=UdgMZcFQiZNijaJ818yBZITHgNgs7jk9u/yxUH2p4p6zjpy2lMPdZjGYvH9tuo3JL0PLyz
        AIwcmeJV8YtIavkbsDo/ckUIrUBBzd5udR1J11SCpqLUOJtik7xrFrTpRX9dwvBsnNSe3g
        IdpuM2ckCPnexhIs3KkTRs3AE5AL7jzwxZAGJrRNUZFD1U3PZ/0fl2LnrsotXLlOQad++p
        /chQPeBFUr53hjGSl/j9+rgn4B9G1e3x9ZCrICpVBAEnTmKwdSr+PO9u5Ugg89LkWA6eBE
        sinCM2G5EFfOG+kcq8mNPkQPLKdrv2SC8SFHUZRWS0oy5yuHekvB2S6f1YaRHw==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 17 Jul 2023 15:34:25 +0200
Subject: [PATCH v4 01/11] clk: sunxi-ng: nkm: Use correct parameter name
 for parent HW
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-pll-mipi_set_rate_parent-v4-1-04acf1d39765@oltmanns.dev>
References: <20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev>
In-Reply-To: <20230717-pll-mipi_set_rate_parent-v4-0-04acf1d39765@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=891; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=uK7iF9etz2opMttdEsAttxwMIOMUY7i/XdBlUa+elf0=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBktUNmFQCKCWHtrI124RzW8kgbzVigb3cH+d6IZ
 XD6/S3ICBiJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZLVDZgAKCRCaaaIIlErT
 x9QAC/9fRFd5dETwAqOSVpi+ipUDaYRB+lzuhAfAdqmX2FjcTnTuSiBAgk/WAkANzhgLAoMTfeO
 DxJmc/G4V6gSd+X9mDNjwbdNh1HCxHYXAkqz3RwwEYSRl7bH+29uQyEeNd+A7vLlRs64ODpR7ok
 xwn8O0HYE45jPYYh6jjcE9/rlujiqY1AbxvRfVprQoB6JHpzFwmQe1ukoeUDMXTUw2S9S1UEetr
 IsGGuPOetODJP6mqbtcdhU9xCmjqmiJsUWw58Wz/5QqZw6tpA2LQcHY9bsLOB4zGuGDgx4olfY2
 pZ1vGNja0LpukouUr4c6/SIDd4r6wEAE0rktWi3lp4MyjlV0cEyOOVhiCgd+YfiX6z9bbppnYEg
 JMv4x1VVGQoBnOfOMYQ098WX9yaUrBxAydC7e151XRkQeHpcMhdMg4FXskfVfsLahVPSdc/Pgsq
 GTKa4K3rjMAe1Yor8IegTjJTS9pF2lL5pyHJVQSEYaROVqEh25+iWYDfbflmqJrUY26Xk=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ccu_nkm_round_rate() takes a clk_hw as parameter "hw". Since "hw" is the
nkm clock's parent clk_hw, not the clk_hw of the nkm clock itself,
change the parameter name to "parent_hw" to make it more clear what
we're dealing with.

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

