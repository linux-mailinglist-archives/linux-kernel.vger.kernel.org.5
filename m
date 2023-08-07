Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9A5772569
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjHGNWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjHGNWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:22:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6551711
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7F0F61AA0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A71C433CC;
        Mon,  7 Aug 2023 13:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414521;
        bh=i6brw9U/L+6pC4Q/XEJT9zKna/1DXXdaKKQQ6GTutFM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=WjCgyrlmel6WUBY2FHUMxCT30g3rE5bHGHYOZIhu9qfsOfDkqvhbgAqjzAMVc05Ly
         EC7Hk0Bkf8axBddEhvOVx1dTzOYXy6zEtOsCoDqsxk394afqPEL65qHlelTUIgEp07
         xwcIWB5S3+PmM4Tn3ihwhIwwv6Rk50EA24SZprCrn0GPXb1AzIutoQvuiwTGB8JIpI
         oKampRSE5QxjNM+DrHyI9lllb5NmEZ65syLJ8jbnznTS/eT1bGisV3M9SVhVQfnpjC
         j7jlro32sGTVitcMdDFRGtqmpxf2ujEnEtsSBXK5VNDcwdfaXlRRK9CSUeKiUGEuL6
         /nzJuoQzn3S+A==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:20:58 +0200
Subject: [PATCH 04/41] mtd: spi-nor: xilinx: remove addr_nbytes from
 S3AN_INFO()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-4-3d3d5bef4ba4@kernel.org>
References: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default value of addr_nbytes is already 3. Drop it.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/xilinx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/xilinx.c b/drivers/mtd/spi-nor/xilinx.c
index de5189c38432..34267591282c 100644
--- a/drivers/mtd/spi-nor/xilinx.c
+++ b/drivers/mtd/spi-nor/xilinx.c
@@ -27,7 +27,6 @@
 		.n_sectors = (_n_sectors),				\
 		.page_size = (_page_size),				\
 		.n_banks = 1,						\
-		.addr_nbytes = 3,					\
 		.flags = SPI_NOR_NO_FR
 
 /* Xilinx S3AN share MFR with Atmel SPI NOR */

-- 
2.39.2

