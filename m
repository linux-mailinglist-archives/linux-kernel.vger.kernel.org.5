Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9871F7ADB31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjIYPS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjIYPS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:18:26 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BD4103
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:18:19 -0700 (PDT)
Received: from Monstersaurus.local (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 79602291;
        Mon, 25 Sep 2023 17:16:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695654997;
        bh=gozTk7lyY/6ypu7+3Un1hCKYcvFcJxTXtAmzQjFkaLI=;
        h=From:To:Cc:Subject:Date:From;
        b=oMiBoohc8SIuoAcuTVI3625y4eV251g502y9wyABX81qFHNcXv0OXZmQCn68Hm9B2
         /+YjBsp9NieAjWt2pbAiNdcKICoDcNLwxM3M3fwQB8cfWTXOriFk6ZZIsrEHEZCE8d
         RBSq/oqc6qc5P3zs2n51aqV7Xqr52laf/obKCN8g=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Maxime Ripard <mripard@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Joel Savitz <jsavitz@redhat.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Yuan Can <yuancan@huawei.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: [PATCH] firmware: raspberrypi: Fix devm_rpi_firmware_get documentation
Date:   Mon, 25 Sep 2023 16:18:11 +0100
Message-Id: <20230925151812.142480-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kieran Bingham <kieran.bingham@ideasonboard.com>

The function documentation for devm_rpi_firmware_get() was missing
a description for the dev parameter.

Provide it and clear the warning produced here.

Fixes: f663204c9a1f ("firmware: raspberrypi: Introduce devm_rpi_firmware_get()")
Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/firmware/raspberrypi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index f66efaa5196d..4cd290a60fba 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -378,6 +378,7 @@ EXPORT_SYMBOL_GPL(rpi_firmware_get);
 
 /**
  * devm_rpi_firmware_get - Get pointer to rpi_firmware structure.
+ * @dev:              The firmware device structure
  * @firmware_node:    Pointer to the firmware Device Tree node.
  *
  * Returns NULL is the firmware device is not ready.
-- 
2.34.1

