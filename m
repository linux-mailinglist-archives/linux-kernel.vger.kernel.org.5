Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BE77989A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244383AbjIHPOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbjIHPOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:14:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F0E1BFA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694186057; x=1725722057;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p4ApRy7A2zU2GWfHf9Q1j1Y38lA80dd85Zcz7xVSJK8=;
  b=JLzB15bAWKfCEmlBUTmZbvBsClrnelZ3M0BzNAbKr3PHYtm2Y+ecJqv8
   5O3a4nkheNcq+UBxDL1EV05xo/MycHJUzs2ik67NT81l/iUpOQiwm5JYI
   au9+PCJBgdBalWSSSRwo9R1M10l5lp4zOjys/nzwNLNk+OHbDxUBgrD4P
   1GmuplwNku/QuavGEZ7pFfbPlNJFkpfkFPqvRknKj0QPSGq423GD6kgqW
   sA1IeLt9qv+SbygYeIOSOE6eIRwhp2346gl7kVnJCRH7m+xmfSSK+8exh
   xcU6sobp2/UosADqUKLd+Q/oxKqGvYOkWqSTa7JSjiZ8aU8kRLsiHxRP8
   g==;
X-CSE-ConnectionGUID: TyWhItiaQ3CcC3nt93gCaA==
X-CSE-MsgGUID: C6rV1iBhTpaOwENpwSRmhw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="3553619"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2023 08:14:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 8 Sep 2023 08:14:16 -0700
Received: from ROU-LT-M43238L.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 8 Sep 2023 08:14:15 -0700
From:   <nicolas.ferre@microchip.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        <miquel.raynal@bootlin.com>, <linux-mtd@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] mtd: spi-nor: atmel: add at25ff321a entry
Date:   Fri, 8 Sep 2023 17:14:00 +0200
Message-ID: <20230908151400.164470-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Hi,

This flash is present on the MikoE flash 10 Click board and was tested on
sama7g5-ek at spi frequency of 80 MHz:

Here is the test I ran:
root@sama7g5ek-sd:~# dd if=/dev/urandom of=./spi_test bs=1M count=3 
3+0 records in
3+0 records out
3145728 bytes (3.1 MB, 3.0 MiB) copied, 0.932896 s, 3.4 MB/s
root@sama7g5ek-sd:~# mtd_debug write /dev/mtd0 0 3145728 spi_test 
Copied 3145728 bytes from spi_test to address 0x00000000 in flash
root@sama7g5ek-sd:~# mtd_debug erase /dev/mtd0 0 3145728 
Erased 3145728 bytes from address 0x00000000 in flash
root@sama7g5ek-sd:~# mtd_debug read /dev/mtd0 0 3145728 spi_read 
Copied 3145728 bytes from address 0x00000000 in flash to spi_read
root@sama7g5ek-sd:~# hexdump spi_read 
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0300000
root@sama7g5ek-sd:~# mtd_debug write /dev/mtd0 0 3145728 spi_test 
 Copied 3145728 bytes from spi_test to address 0x00000000 in flash
root@sama7g5ek-sd:~# mtd_debug read /dev/mtd0 0 3145728 spi_read 
Copied 3145728 bytes from address 0x00000000 in flash to spi_read
root@sama7g5ek-sd:~# sha1sum spi_test spi_read 
06d5459972d51a2ff4270e612270c6519e797a0b  spi_test
06d5459972d51a2ff4270e612270c6519e797a0b  spi_read

Here are the data from sysfs:

root@sama7g5ek-sd:~#  cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
at25ff321a
root@sama7g5ek-sd:~# cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
1f4708
root@sama7g5ek-sd:~# cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
atmel
root@sama7g5ek-sd:~# hexdump -C /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
00000000  53 46 44 50 06 01 00 ff  00 06 01 10 10 00 00 ff  |SFDP............|
00000010  e5 20 e1 ff ff ff ff 01  40 eb 08 6b 08 3b 00 ff  |. ......@..k.;..|
00000020  ee ff ff ff ff ff 00 ff  ff ff 00 ff 0c 20 0f 52  |............. .R|
00000030  10 d8 00 ff 50 2a 2a 01  82 ff 9c d2 64 c1 08 46  |....P**.....d..F|
00000040  7a 75 7a 75 f7 c4 d5 5c  00 06 51 ff 88 30 00 00  |zuzu...\..Q..0..|
00000050
root@sama7g5ek-sd:~# md5sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
d540f07cbfb7c9c19654c453b561b311  /sys/bus/spi/devices/spi0.0/spi-nor/sfdp

Best regards,
  Nicolas

 drivers/mtd/spi-nor/atmel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 58968c1e7d2f..c94d52951481 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -184,6 +184,10 @@ static const struct flash_info atmel_nor_parts[] = {
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
 		NO_SFDP_FLAGS(SECT_4K)
 		.fixups = &atmel_nor_global_protection_fixups },
+	{ "at25ff321a", INFO(0x1f4708, 0, 64 * 1024,  64)
+		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
+		PARSE_SFDP
+		.fixups = &atmel_nor_global_protection_fixups },
 	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128)
 		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
 		NO_SFDP_FLAGS(SECT_4K)
-- 
2.39.2

