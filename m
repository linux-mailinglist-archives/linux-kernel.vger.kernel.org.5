Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618127878EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbjHXToF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243247AbjHXTnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:43:31 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905E21BE9;
        Thu, 24 Aug 2023 12:43:29 -0700 (PDT)
Received: from dslb-188-097-211-187.188.097.pools.vodafone-ip.de ([188.97.211.187] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qZGEq-0003HB-6H; Thu, 24 Aug 2023 21:43:28 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/3] hwrng: ks-sa - remove dev from struct ks_sa_rng
Date:   Thu, 24 Aug 2023 21:40:36 +0200
Message-Id: <20230824194037.1575276-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824194037.1575276-1-martin@kaiser.cx>
References: <20230824194037.1575276-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev in struct ks_sa_rng is not used. Remove it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/ks-sa-rng.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/hw_random/ks-sa-rng.c b/drivers/char/hw_random/ks-sa-rng.c
index 0857964f8714..70d21bf657ce 100644
--- a/drivers/char/hw_random/ks-sa-rng.c
+++ b/drivers/char/hw_random/ks-sa-rng.c
@@ -81,7 +81,6 @@ struct trng_regs {
 };
 
 struct ks_sa_rng {
-	struct device	*dev;
 	struct hwrng	rng;
 	struct clk	*clk;
 	struct regmap	*regmap_cfg;
@@ -213,7 +212,6 @@ static int ks_sa_rng_probe(struct platform_device *pdev)
 	if (!ks_sa_rng)
 		return -ENOMEM;
 
-	ks_sa_rng->dev = dev;
 	ks_sa_rng->rng = (struct hwrng) {
 		.name = "ks_sa_hwrng",
 		.init = ks_sa_rng_init,
-- 
2.39.2

