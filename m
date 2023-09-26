Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A277AEDE1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjIZNSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjIZNSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:18:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5DCF3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695734275; x=1727270275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dlh3dXQftHY/1ZVP5UFfcPDTvFrZfh14Xuy9dWmFSS0=;
  b=R9/vkdt/4jUG0rxvhzumrMkpolOcHNSL0Y/uYkqayKVwCvAF0vOxp5Dp
   aRwtvaXcGwwQumAF3aOW1MTF7NejykqIeZ0hZufDKHD2DjHIrLhy61b8/
   XEdA/Bjaxu43GUkyqJCtwi5HPIBu4eb81SYHGC9DuNbQGaq5bLaOK6rOa
   1zzPsL5/+N6jXoZFbiRuLhsTdDnoi4b5ZMzXwj6vihvl69sUstzhbrPoq
   GT3NAX80THctYr1GqqfUN/CDQofzNH/Ff2YfUn4xAChBBRkiyCloyW7FJ
   RxKLgp5PfV8/4/AC9rx3UuhEelZts+iUwoTosgXqfnqtc1+bYAqyNFuVe
   Q==;
X-CSE-ConnectionGUID: qv2bLBQUQDS1+ybmYDf9uQ==
X-CSE-MsgGUID: FZx5G028Q867FAN1S4AGaQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="6518420"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2023 06:17:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 26 Sep 2023 06:17:28 -0700
Received: from ROU-LT-M43238L.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 26 Sep 2023 06:17:27 -0700
From:   <nicolas.ferre@microchip.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        <miquel.raynal@bootlin.com>, <linux-mtd@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v2] mtd: spi-nor: atmel: add at25ff321a entry
Date:   Tue, 26 Sep 2023 15:16:55 +0200
Message-ID: <20230926131655.51224-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Add the at25ff321a 4MB SPI flash which is able to provide
SFDP informations.
Datasheet: https://www.renesas.com/us/en/document/dst/at25ff321a-datasheet

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
v1 -> v2: - adapt to new struct flash_info atmel_nor_parts init
	  - don't set the no_sfdp_flags property

Hi,

This flash is present on the MikoE flash 10 Click board and was tested on
sama7g5-ek at spi frequency of 80 MHz:

Here are the tests that I ran:
root@sama5d27-wlsom1-ek-sd:~# dd if=/dev/urandom of=./spi_test bs=1M count=3
3+0 records in
3+0 records out
3145728 bytes (3.1 MB, 3.0 MiB) copied, 0.285407 s, 11.0 MB/s
root@sama5d27-wlsom1-ek-sd:~# mtd_debug write /dev/mtd0 0 3145728 spi_test
Copied 3145728 bytes from spi_test to address 0x00000000 in flash
root@sama5d27-wlsom1-ek-sd:~# mtd_debug erase /dev/mtd0 0 3145728
Erased 3145728 bytes from address 0x00000000 in flash
root@sama5d27-wlsom1-ek-sd:~# mtd_debug read /dev/mtd0 0 3145728 spi_read
Copied 3145728 bytes from address 0x00000000 in flash to spi_read
root@sama5d27-wlsom1-ek-sd:~# hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0300000
root@sama5d27-wlsom1-ek-sd:~# mtd_debug write /dev/mtd0 0 3145728 spi_test
Copied 3145728 bytes from spi_test to address 0x00000000 in flash
root@sama5d27-wlsom1-ek-sd:~# mtd_debug read /dev/mtd0 0 3145728 spi_read
Copied 3145728 bytes from address 0x00000000 in flash to spi_read
root@sama5d27-wlsom1-ek-sd:~# sha1sum spi_test spi_read
4de5dbe39ab24b169e9dad01a8cc12c4756270a2  spi_test
4de5dbe39ab24b169e9dad01a8cc12c4756270a2  spi_read

root@sama5d27-wlsom1-ek-sd:~# cat /sys/bus/spi/devices/spi0.1/spi-nor/partname
at25ff321a
root@sama5d27-wlsom1-ek-sd:~# cat /sys/bus/spi/devices/spi0.1/spi-nor/jedec_id
1f4708
root@sama5d27-wlsom1-ek-sd:~# cat /sys/bus/spi/devices/spi0.1/spi-nor/manufacturer
atmel
root@sama5d27-wlsom1-ek-sd:~# hexdump -C /sys/bus/spi/devices/spi0.1/spi-nor/sfdp
00000000  53 46 44 50 06 01 00 ff  00 06 01 10 10 00 00 ff  |SFDP............|
00000010  e5 20 e1 ff ff ff ff 01  40 eb 08 6b 08 3b 00 ff  |. ......@..k.;..|
00000020  ee ff ff ff ff ff 00 ff  ff ff 00 ff 0c 20 0f 52  |............. .R|
00000030  10 d8 00 ff 50 2a 2a 01  82 ff 9c d2 64 c1 08 46  |....P**.....d..F|
00000040  7a 75 7a 75 f7 c4 d5 5c  00 06 51 ff 88 30 00 00  |zuzu...\..Q..0..|
00000050
root@sama5d27-wlsom1-ek-sd:~# md5sum /sys/bus/spi/devices/spi0.1/spi-nor/sfdp
d540f07cbfb7c9c19654c453b561b311  /sys/bus/spi/devices/spi0.1/spi-nor/sfdp

# # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
root@sama5d27-wlsom1-ek-sd:~# mtdinfo /dev/mtd0
mtd0
Name:                           spi0.1
Type:                           nor
Eraseblock size:                65536 bytes, 64.0 KiB
Amount of eraseblocks:          64 (4194304 bytes, 4.0 MiB)
Minimum input/output unit size: 1 byte
Sub-page size:                  1 byte
Character device major/minor:   90:0
Bad blocks are allowed:         false
Device is writable:             true

Best regards,
  Nicolas

 drivers/mtd/spi-nor/atmel.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 95f0e139284e..e13b8d2dd50a 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -213,6 +213,11 @@ static const struct flash_info atmel_nor_parts[] = {
 		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
 		.no_sfdp_flags = SECT_4K,
 		.fixups = &atmel_nor_global_protection_fixups
+	}, {
+		.id = SNOR_ID(0x1f, 0x47, 0x08),
+		.name = "at25ff321a",
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE,
+		.fixups = &atmel_nor_global_protection_fixups
 	}, {
 		.id = SNOR_ID(0x1f, 0x48, 0x00),
 		.name = "at25df641",
-- 
2.39.2

