Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65288778D32
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbjHKLLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjHKLLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:11:42 -0400
X-Greylist: delayed 526 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 04:11:41 PDT
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6B4FD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:11:41 -0700 (PDT)
Received: from [127.0.0.1] (bband-dyn221.178-41-211.t-com.sk [178.41.211.221])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 6EE5E1F6CD;
        Fri, 11 Aug 2023 13:02:52 +0200 (CEST)
From:   Martin Botka <martin.botka@somainline.org>
Date:   Fri, 11 Aug 2023 13:02:35 +0200
Subject: [PATCH 2/3] nvmem: sunxi_sid: Add support for H616 SID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-sid-h616-v1-2-d1dfc9f47b19@somainline.org>
References: <20230811-sid-h616-v1-0-d1dfc9f47b19@somainline.org>
In-Reply-To: <20230811-sid-h616-v1-0-d1dfc9f47b19@somainline.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691751771; l=851;
 i=martin.botka@somainline.org; s=20230811; h=from:subject:message-id;
 bh=gMHCxqgi4YwQ9D8pchBHMnIgAOKw9tONOR5pmmXSDH8=;
 b=hZ3vSClPmzmhvFYP1YXc3lkvXLc5QdKp/p8EMkXkI7IJBbm8XpGdyyFh4e/nW7ShUyJiaM2JI
 nACWxrD5rweB6sy50fA2Ut+ojbpq3/mXMZbRPXF7qM4yO7i/dDa+Oje
X-Developer-Key: i=martin.botka@somainline.org; a=ed25519;
 pk=aTCd3jmwU8GrJidWg3DSKLpdVMcpFzXzCSLXLR6NtWU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the H616 SID controller.

The config can be reused from A64.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 drivers/nvmem/sunxi_sid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index a970f1741cc6..df6fb5e0b724 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -216,6 +216,7 @@ static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h6-sid", .data = &sun50i_h6_cfg },
+	{ .compatible = "allwinner,sun50i-h616-sid", .data = &sun50i_a64_cfg },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);

-- 
2.41.0

