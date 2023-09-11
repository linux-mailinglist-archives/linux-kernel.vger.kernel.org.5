Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEE479C2D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbjILC2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbjILC2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:28:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1F6134D3C;
        Mon, 11 Sep 2023 18:52:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B41C433BF;
        Mon, 11 Sep 2023 21:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694468775;
        bh=vY7vawU4FZYoEgdX4LDl+2Hb+tqanE/PYLPwILCYrzU=;
        h=From:To:Cc:Subject:Date:From;
        b=Jq/ie0C175g+KTBPmu5n84htYUDAi1mRxI4NyK4fvQTjM/LuZlK054qvUoGSVWBzb
         lqMpADHgNYUdroXydWBpFZlhaQozAOY4m5iRRFs+I+ZmhO4muIR2bLcUeQhezgf45G
         21njU3Mvd9JBaEWU50PZVrC8Zwj7Ta9k0bijWDJofATThy0FTB86ha/WcMscp+Ie44
         t2aD14HVwW71epMXTsOf9x21tQr6Ug90O2jsy3XTAe1LosUODEYb8zExGVkKorjx6e
         eU+/aYK3spBILJv7mFcFNwbKv740fdloCJf8IQpISjz7v75RYqWIvga+qJ6atpsIPV
         8iMopSVxgiPiQ==
Received: (nullmailer pid 2201291 invoked by uid 1000);
        Mon, 11 Sep 2023 21:46:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: dts: omap: Apply am57xx-idk overlays to base dtbs
Date:   Mon, 11 Sep 2023 16:46:02 -0500
Message-Id: <20230911214609.2201040-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT overlays in tree need to be applied to a base DTB to validate they
apply, to run schema checks on them, and to catch any errors at compile
time.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Note that I have no idea if this combination of overlays makes sense.
---
 arch/arm/boot/dts/ti/omap/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
index d2b590004fed..d0c76d09fe70 100644
--- a/arch/arm/boot/dts/ti/omap/Makefile
+++ b/arch/arm/boot/dts/ti/omap/Makefile
@@ -129,6 +129,11 @@ dtb-$(CONFIG_SOC_AM43XX) += \
 am57xx-evm-dtbs := am57xx-beagle-x15.dtb am57xx-evm.dtbo
 am57xx-evm-reva3-dtbs := am57xx-beagle-x15-revc.dtb am57xx-evm.dtbo
 
+am571x-idk-overlays-dtbs := am571x-idk.dtb \
+	am571x-idk-touchscreen.dtbo am57xx-idk-lcd-osd101t2587.dtbo
+am572x-idk-overlays-dtbs := am572x-idk.dtb \
+	am572x-idk-touchscreen.dtbo am57xx-idk-lcd-osd101t2045.dtbo
+
 dtb-$(CONFIG_SOC_DRA7XX) += \
 	am57xx-beagle-x15.dtb \
 	am57xx-beagle-x15-revb1.dtb \
@@ -145,6 +150,8 @@ dtb-$(CONFIG_SOC_DRA7XX) += \
 	am574x-idk.dtb \
 	am57xx-idk-lcd-osd101t2045.dtbo \
 	am57xx-idk-lcd-osd101t2587.dtbo \
+	am571x-idk-overlays.dtb \
+	am572x-idk-overlays.dtb \
 	dra7-evm.dtb \
 	dra72-evm.dtb \
 	dra72-evm-revc.dtb \
-- 
2.40.1

