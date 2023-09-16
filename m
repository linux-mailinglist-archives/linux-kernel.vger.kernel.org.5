Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD087A2EF6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjIPJOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 05:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238315AbjIPJO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 05:14:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A071173B
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 02:14:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CCAC433C7;
        Sat, 16 Sep 2023 09:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694855661;
        bh=GdGIL53lm5iv/mox0ahLK0T+iKNQXpwOmFGuHh0bLKI=;
        h=From:To:Cc:Subject:Date:From;
        b=MXFjs8+pBJZdHwmuPF39Dgwiac3x3AZ6Ss001Xqa4bdVx5TwxJZjc+2e08dgidLqf
         a1ThGwqoJ6cAu9E0MeCHJLx4YOr4hm9Z4mcrWe/AUeICdzvrfMbZbi2UcDrqEh1tJu
         WK2k44+EDyhxS10IwH49j77ngj+JZcI23btS3KkdtAZqkUiiUMQxMS/U0aQ0eZ9YOd
         k1fEulNFIvO4rcGn6pWtQ7eDvtckKZ5CJIrZVrbRcmjwKpWfQ8W4iomNjJpwNeTJuf
         6gRJg40669dhp8j//RhdpTdWlIC4Q/Wrs9uP6kOb5PQrs2tS15Xl/YQFaiYnQp7g/i
         uoD7BOXntteuw==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] riscv: dts: allwinner: remove address-cells from intc node
Date:   Sat, 16 Sep 2023 10:14:00 +0100
Message-Id: <20230916-saddling-dastardly-8cf6d1263c24@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=UgmedOCSd3V8sGIbZthMv9VrCmYnN+opWlLsZB5DVno=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmshVfr/vQqXF5o7fZG0oplI5uJspPEknN7nj39fsdMy ckhYXlFRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbizMbwT8U7bukPz22JO/Yt to7Y7bVftroz1N7/sa+Obo/PthIJK4b/NVf+PvkQ5LS8NWG25eMLWp3N3x9XHX96bs379guOHle SGQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

A recent submission [1] from Rob has added additionalProperties: false
to the interrupt-controller child node of RISC-V cpus, highlighting that
the D1 DT has been incorrectly using #address-cells since its
introduction. It has no child nodes, so #address-cells is not needed.
Remove it.

Fixes: 077e5f4f5528 ("riscv: dts: allwinner: Add the D1/D1s SoC devicetree")
Link: https://patchwork.kernel.org/project/linux-riscv/patch/20230915201946.4184468-1-robh@kernel.org/ [1]
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Chen-Yu Tsai <wens@csie.org>
CC: Jernej Skrabec <jernej.skrabec@gmail.com>
CC: Samuel Holland <samuel@sholland.org>
CC: devicetree@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: linux-sunxi@lists.linux.dev
CC: linux-kernel@vger.kernel.org
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 8275630af977..b8684312593e 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -30,7 +30,6 @@ cpu0: cpu@0 {
 			cpu0_intc: interrupt-controller {
 				compatible = "riscv,cpu-intc";
 				interrupt-controller;
-				#address-cells = <0>;
 				#interrupt-cells = <1>;
 			};
 		};
-- 
2.39.2

