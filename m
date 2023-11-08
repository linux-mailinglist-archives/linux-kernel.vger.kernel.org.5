Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E997E7E600B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 22:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjKHViR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 16:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHViP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 16:38:15 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47C12585;
        Wed,  8 Nov 2023 13:38:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4079ed65471so771055e9.1;
        Wed, 08 Nov 2023 13:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699479491; x=1700084291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BOY/4TbWJlIh9l54tUoY6OQMnJji9pbyz4aczXm5Onw=;
        b=S/5/GOx25f/cpSqx2ALbnlXIESL4uoWXxHdzjAUljfQ6z4AwCUCKE5plnVF0SG2IOE
         /rmxVt0BzB0E/P+DiX5O2IXiv9hgBJ/F3BHz0uIcvCzdUnjRKSwMcYWjBzdNEcM2RmAt
         14VXcVs6E3ZERKlEs7iCQ4M8u7NFhlq6yV+CjgSjRgcvMa3o7fgFD7hucF97bQBkRWmw
         HBpVl6+od7rY0m6sqGjp3eVT/S+rVdT3DsS84hrQhEiXNyd4uVimSGekGBPpHShWotuX
         WaPhSWsRMnC8/X0T9O1YacMFSAZssGygPXmcaSmKz9nVXQ6Zmq8fHjol3oCSKCFb0sH2
         0OMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699479491; x=1700084291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOY/4TbWJlIh9l54tUoY6OQMnJji9pbyz4aczXm5Onw=;
        b=YFKQbBqKpqVAKsMflYbqXGG53kzZJJEf6WOJIupAblWrBbNRPRhC9L2XHeyrMALiD8
         yuhbE7NcTPMurAwdXQVbBI6+Pf/JFscGP72BNQlN6Ra4PH3EbkgKxuP8jWL9Upx1MdmZ
         +SNTA3D/XWiwH/MGojc691Vw56A/BYdlPpY1skiRG5XLewdWPC1ZN0DVp1DbxdnWRhLa
         Phz9V/kg6PbTYerG875uXxsULh6s5mrDYE4VDULTY8TTRrpnkTtjAwN6fe2K0xhk9i4F
         jw4hil/QO/Y0IkwnPhlnxyFLgvb7a1Ipi9BZtTw0zyU4GcUcDo2TDrqsN0TWa0F0fZI5
         psag==
X-Gm-Message-State: AOJu0Yy1kq4buDm5TYehAE6pNC3OaYZr7kohBRMt/p+YNvq9RsfoLPmg
        5Bu30HE9M39I/gNQPPyNpIq9yHsXrSI=
X-Google-Smtp-Source: AGHT+IFaK9xQ+DloNi+NZ+EUiBL2JKwDO76WCe7486uq9CoBenof/WNhhVDU4HR5MYDs/OR/q7vAHw==
X-Received: by 2002:a05:600c:3b96:b0:407:8ee2:997e with SMTP id n22-20020a05600c3b9600b004078ee2997emr2777339wms.27.1699479491088;
        Wed, 08 Nov 2023 13:38:11 -0800 (PST)
Received: from ALPER-PC.. ([178.233.24.52])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c138800b004075d5664basm22032wmf.8.2023.11.08.13.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 13:38:10 -0800 (PST)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH] clock: mediatek: mt8173: Handle unallocated infracfg clock data
Date:   Thu,  9 Nov 2023 00:33:43 +0300
Message-ID: <20231108213734.140707-1-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT8173 infracfg clock driver does initialization in two steps, via a
CLK_OF_DECLARE_DRIVER declaration. However its early init function
doesn't get to run when it's built as a module, presumably since it's
not loaded by the time it would have been called by of_clk_init(). This
causes its second-step probe() to return -ENOMEM when trying to register
clocks, as the necessary clock_data struct isn't initialized by the
first step.

MT2701 and MT6797 clock drivers also use this mechanism, but they try to
allocate the necessary clock_data structure if missing in the second
step. Mimic that for the MT8173 infracfg clock as well to make it work
as a module.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
I've tried adding cpumux support to clk-mtk.c then switching this over
to simple probe functions and it appears to work for me, though I don't
know clock systems enough to recognize if it's subtly broken instead.
That'd remove this piece of code, but this might still be worth applying
to backport to stable kernels.

If I'm reading things correctly, it looks like it would be possible to
add cpumux & pll & pllfh support to clk-mtk.c, then move most if not
every driver to simple probe, with one file per clock and module
support. How much of that is desirable? In what order do the parts need
to be registered?

 drivers/clk/mediatek/clk-mt8173-infracfg.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8173-infracfg.c b/drivers/clk/mediatek/clk-mt8173-infracfg.c
index 2f2f074e231a..ecc8b0063ea5 100644
--- a/drivers/clk/mediatek/clk-mt8173-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt8173-infracfg.c
@@ -98,7 +98,17 @@ CLK_OF_DECLARE_DRIVER(mtk_infrasys, "mediatek,mt8173-infracfg",
 static int clk_mt8173_infracfg_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	int r;
+	int r, i;
+
+	if (!infra_clk_data) {
+		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+		if (!infra_clk_data)
+			return -ENOMEM;
+	} else {
+		for (i = 0; i < CLK_INFRA_NR_CLK; i++)
+			if (infra_clk_data->hws[i] == ERR_PTR(-EPROBE_DEFER))
+				infra_clk_data->hws[i] = ERR_PTR(-ENOENT);
+	}
 
 	r = mtk_clk_register_gates(&pdev->dev, node, infra_gates,
 				   ARRAY_SIZE(infra_gates), infra_clk_data);

base-commit: 2220f68f4504aa1ccce0fac721ccdb301e9da32f
-- 
2.42.0

