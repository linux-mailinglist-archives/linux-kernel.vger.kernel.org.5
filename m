Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EA677246F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjHGMoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHGMoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:44:09 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3E4171A;
        Mon,  7 Aug 2023 05:44:06 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RKGGV62y8z9snG;
        Mon,  7 Aug 2023 14:44:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1691412242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7xunkH+eplPFJS6xmeOR6PfO5HXKdfmXSQre18tglE=;
        b=wksyKUBg7az1g+U5XnvWYd/eML/uU8VmHklspVcTEltUDIeq9HSnw7quA62rgsLdwt15dt
        DLN/PpVQwxW1xhIMjkMIS4onN2JHloIm23efIV+30CTSPZY9HJzl7E6udVdOAU5BkEcEGj
        FxKTO6H74F2f3hT5l3VRzuKFa8Sw4wCUfTyvzLgHxvMuDJDiVSdVHNO1QKqodY7k7J9WG7
        m2FN4u7zH9hD0P0YPG1gt6tcx4wGRZe2QQJrUiFgMTFWBTmFYxl/zocoFDuxJkF05bvIBo
        s7UqIkgQjXJKRhqR/9ODtpeaneuexzkYwQ7pCA3/bz7xp7ipa2pQd40NGMuWOA==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Mon, 07 Aug 2023 14:43:34 +0200
Subject: [PATCH v6 01/11] clk: sunxi-ng: nkm: Use correct parameter name
 for parent HW
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-pll-mipi_set_rate_parent-v6-1-f173239a4b59@oltmanns.dev>
References: <20230807-pll-mipi_set_rate_parent-v6-0-f173239a4b59@oltmanns.dev>
In-Reply-To: <20230807-pll-mipi_set_rate_parent-v6-0-f173239a4b59@oltmanns.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=993; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=J6lNhQH93AkSfayEFm5nQRn8x5rZvQ+scqDM/7cL81I=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBk0OcJeltk/PivTlSiWRcBOFYm7PZOWIMRYMGjM
 RWzMMDnn26JAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZNDnCQAKCRCaaaIIlErT
 x+VUC/47WWLIjW3u247is9gP9SM58/c6axgqxtcxPeRvU6HtetXfdf6vRMLsKUzAkEvqwnD4p8a
 oHqCeKZAG0m1Syd6sXkNnV6liB0ALRuc82DS7a4MP/5VkNTniHW9TyoD3beDkmQbc7/HIRToCge
 AP6m+y50vdArcvbYs0CeS7mjxQROtzSX0UhWivJtnEFn14MExhRD8abYLg6/CAxT6AqLxEGcShe
 ngmQKu5RWj87VuoYmK7QSZJeP9kTVkJ/s+H9cl5W65yZ7RDpRKPxTfWeU0/JiJIPFOdqzZQlYX5
 WVC7cTUN7ATNCxSDdiWplPATSYTlTtm6cKWnqsRQRzCk/gCnBSmxgei1ZqEfz+25JO6lnYe5z18
 kMe5vc1b0frBSgjTChttKcVc+4eZA0Zcgy57DNjDtyBBDSgGb1mIgN697L8zMhNLAvKuiPgk0JR
 7+jymkS2o/CWeWeJvLyvNCFQpBFRq/ClWTo42eqgWkSH5LqMo2El29jstnLZlVkB+Tjco=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Rspamd-Queue-Id: 4RKGGV62y8z9snG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
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

