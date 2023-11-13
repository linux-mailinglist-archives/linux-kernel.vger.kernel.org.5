Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051807E9AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjKMLPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMLPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:15:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AC7D5C;
        Mon, 13 Nov 2023 03:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699874106; x=1731410106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LbRnYdRPeFJ5gAHOR1oLBzeoo2auHB7sRXGXnI/SXvQ=;
  b=iCygM4xr5RAPzLPnRQUiO8VGlN1PfMcNq74Ae4NUf2nH1mACrV6zaCFr
   7st5FOhcxpEhR8QbjT0R8FMEvjS56FhcXWROFu3R2tTonkY6k1phESqgw
   8ERorta6Sg0duW6HYai0WTtdNZte3nvxkJjaHgSV5FEZ5beCvq1mfqfZv
   JPtuRg3f8dBe6QSQP4dcYzlvzUIkVHvoJUfgsFWm5eCEkA6j3sasU0VU4
   X70ELEMdmNHkWUTW3Lctr2CclstPDJyI8Zv60NI50P2KmZBFF+mAGGbA8
   CohHZ389bCIRRawQVmHNhjUPGVyXUjLt82QhiKL6eSYCNPRB8JT7q+5RQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="387581132"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="387581132"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 03:13:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="834688980"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="834688980"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2023 03:12:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A689E574; Mon, 13 Nov 2023 13:12:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v1 1/1] treewide, spi: Get rid of SPI_MASTER_HALF_DUPLEX
Date:   Mon, 13 Nov 2023 13:12:49 +0200
Message-ID: <20231113111249.3982461-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPI_MASTER_HALF_DUPLEX is the legacy name of a definition
for a half duplex flag. Since all others had been replaced with
the respective SPI_CONTROLLER prefix get rid of the last one
as well. There is no functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/input/rmi4/rmi_spi.c             | 2 +-
 drivers/mmc/host/mmc_spi.c               | 2 +-
 drivers/net/ethernet/micrel/ks8851_spi.c | 4 ++--
 drivers/usb/gadget/udc/max3420_udc.c     | 2 +-
 include/linux/spi/spi.h                  | 2 --
 5 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
index 852aeb0b2c07..07c866f42296 100644
--- a/drivers/input/rmi4/rmi_spi.c
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -375,7 +375,7 @@ static int rmi_spi_probe(struct spi_device *spi)
 	struct rmi_device_platform_data *spi_pdata = spi->dev.platform_data;
 	int error;
 
-	if (spi->master->flags & SPI_MASTER_HALF_DUPLEX)
+	if (spi->master->flags & SPI_CONTROLLER_HALF_DUPLEX)
 		return -EINVAL;
 
 	rmi_spi = devm_kzalloc(&spi->dev, sizeof(struct rmi_spi_xport),
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index cc333ad67cac..b0cccef4cfbf 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1322,7 +1322,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 	/* We rely on full duplex transfers, mostly to reduce
 	 * per-transfer overheads (by making fewer transfers).
 	 */
-	if (spi->master->flags & SPI_MASTER_HALF_DUPLEX)
+	if (spi->master->flags & SPI_CONTROLLER_HALF_DUPLEX)
 		return -EINVAL;
 
 	/* MMC and SD specs only seem to care that sampling is on the
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c
index 70bc7253454f..7c41623dac90 100644
--- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -156,7 +156,7 @@ static void ks8851_rdreg(struct ks8851_net *ks, unsigned int op,
 
 	txb[0] = cpu_to_le16(op | KS_SPIOP_RD);
 
-	if (kss->spidev->master->flags & SPI_MASTER_HALF_DUPLEX) {
+	if (kss->spidev->master->flags & SPI_CONTROLLER_HALF_DUPLEX) {
 		msg = &kss->spi_msg2;
 		xfer = kss->spi_xfer2;
 
@@ -180,7 +180,7 @@ static void ks8851_rdreg(struct ks8851_net *ks, unsigned int op,
 	ret = spi_sync(kss->spidev, msg);
 	if (ret < 0)
 		netdev_err(ks->netdev, "read: spi_sync() failed\n");
-	else if (kss->spidev->master->flags & SPI_MASTER_HALF_DUPLEX)
+	else if (kss->spidev->master->flags & SPI_CONTROLLER_HALF_DUPLEX)
 		memcpy(rxb, trx, rxl);
 	else
 		memcpy(rxb, trx + 2, rxl);
diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index 2d57786d3db7..89e8cf2a2a7d 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -1201,7 +1201,7 @@ static int max3420_probe(struct spi_device *spi)
 	int err, irq;
 	u8 reg[8];
 
-	if (spi->master->flags & SPI_MASTER_HALF_DUPLEX) {
+	if (spi->master->flags & SPI_CONTROLLER_HALF_DUPLEX) {
 		dev_err(&spi->dev, "UDC needs full duplex to work\n");
 		return -EINVAL;
 	}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 255a0562aea5..7b4baff63c5c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1638,8 +1638,6 @@ spi_transfer_is_last(struct spi_controller *ctlr, struct spi_transfer *xfer)
 /* Compatibility layer */
 #define spi_master			spi_controller
 
-#define SPI_MASTER_HALF_DUPLEX		SPI_CONTROLLER_HALF_DUPLEX
-
 #define spi_master_get_devdata(_ctlr)	spi_controller_get_devdata(_ctlr)
 #define spi_master_set_devdata(_ctlr, _data)	\
 	spi_controller_set_devdata(_ctlr, _data)
-- 
2.43.0.rc1.1.gbec44491f096

