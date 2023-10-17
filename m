Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C327CCB86
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbjJQTCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJQTCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:02:19 -0400
X-Greylist: delayed 368 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 12:02:16 PDT
Received: from emag.lindev.ch (unknown [81.221.122.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A549BC6;
        Tue, 17 Oct 2023 12:02:16 -0700 (PDT)
Received: from ryzen9.fritz.box (unknown [81.221.122.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bero@lindev.ch)
        by emag.lindev.ch (Postfix) with ESMTPSA id E2D8120046E;
        Tue, 17 Oct 2023 20:55:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lindev.ch; s=default;
        t=1697568969; bh=gwey47VpMjc/YXHiRhLoI1/IArDcNkx8f4YK5Mbj5Qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=G07QyuGHICoGRRAEvMHlAG7B4565tNqjcEeelAyNntzafwJT0q1TIXXhGP9tIeQG0
         6SjHmys4mNasFBUGafjFT4ot9Bdp/xRKbMksx7iYiYhFVmCg6LlkyWSXi2NFDtPNik
         e0Eixk2mi1KZlcacLJpQF/+kai43IiF5eYAFLm1Y=
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@lindev.ch>
To:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dunlap@infradead.org,
        e.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, ames.lo@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Subject: [PATCH v5 5/5] thermal/drivers/mediatek/lvts_thermal: Update calibration data documentation
Date:   Tue, 17 Oct 2023 20:55:55 +0200
Message-ID: <20231017185555.142062-6-bero@lindev.ch>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017185555.142062-1-bero@lindev.ch>
References: <20231017185555.142062-1-bero@lindev.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

Update LVTS calibration data documentation for mt8192 and mt8195.

Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
[bero@baylibre.com: Fix issues pointed out by Nícolas F. R. A. Prado <nfraprado@collabora.com>]
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 31 +++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 487401424951d..15fcf573f5cc5 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -604,7 +604,34 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
  * The efuse blob values follows the sensor enumeration per thermal
  * controller. The decoding of the stream is as follow:
  *
- * stream index map for MCU Domain :
+ * MT8192 :
+ * Stream index map for MCU Domain mt8192 :
+ *
+ * <-----mcu-tc#0-----> <-----sensor#0----->        <-----sensor#1----->
+ *  0x01 | 0x02 | 0x03 | 0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09 | 0x0A | 0x0B
+ *
+ * <-----sensor#2----->        <-----sensor#3----->
+ *  0x0C | 0x0D | 0x0E | 0x0F | 0x10 | 0x11 | 0x12 | 0x13
+ *
+ * <-----sensor#4----->        <-----sensor#5----->        <-----sensor#6----->        <-----sensor#7----->
+ *  0x14 | 0x15 | 0x16 | 0x17 | 0x18 | 0x19 | 0x1A | 0x1B | 0x1C | 0x1D | 0x1E | 0x1F | 0x20 | 0x21 | 0x22 | 0x23
+ *
+ * Stream index map for AP Domain mt8192 :
+ *
+ * <-----sensor#0----->        <-----sensor#1----->
+ *  0x24 | 0x25 | 0x26 | 0x27 | 0x28 | 0x29 | 0x2A | 0x2B
+ *
+ * <-----sensor#2----->        <-----sensor#3----->
+ *  0x2C | 0x2D | 0x2E | 0x2F | 0x30 | 0x31 | 0x32 | 0x33
+ *
+ * <-----sensor#4----->        <-----sensor#5----->
+ *  0x34 | 0x35 | 0x36 | 0x37 | 0x38 | 0x39 | 0x3A | 0x3B
+ *
+ * <-----sensor#6----->        <-----sensor#7----->        <-----sensor#8----->
+ *  0x3C | 0x3D | 0x3E | 0x3F | 0x40 | 0x41 | 0x42 | 0x43 | 0x44 | 0x45 | 0x46 | 0x47
+ *
+ * MT8195 :
+ * Stream index map for MCU Domain mt8195 :
  *
  * <-----mcu-tc#0-----> <-----sensor#0-----> <-----sensor#1----->
  *  0x01 | 0x02 | 0x03 | 0x04 | 0x05 | 0x06 | 0x07 | 0x08 | 0x09
@@ -615,7 +642,7 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
  * <-----mcu-tc#2-----> <-----sensor#4-----> <-----sensor#5-----> <-----sensor#6-----> <-----sensor#7----->
  *  0x13 | 0x14 | 0x15 | 0x16 | 0x17 | 0x18 | 0x19 | 0x1A | 0x1B | 0x1C | 0x1D | 0x1E | 0x1F | 0x20 | 0x21
  *
- * stream index map for AP Domain :
+ * Stream index map for AP Domain mt8195 :
  *
  * <-----ap--tc#0-----> <-----sensor#0-----> <-----sensor#1----->
  *  0x22 | 0x23 | 0x24 | 0x25 | 0x26 | 0x27 | 0x28 | 0x29 | 0x2A
-- 
2.42.0

