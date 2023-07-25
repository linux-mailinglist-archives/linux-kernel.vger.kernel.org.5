Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B590761ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjGYNzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGYNza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:55:30 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04065212E;
        Tue, 25 Jul 2023 06:55:02 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R9JQc5ypSzrRx4;
        Tue, 25 Jul 2023 21:53:28 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 21:54:21 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <broonie@kernel.org>, <yuehaibing@huawei.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] spi: fsl: Remove unused extern declarations
Date:   Tue, 25 Jul 2023 21:54:11 +0800
Message-ID: <20230725135411.21152-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b36ece832512 ("spi/mpc8xxx: refactor the common code for SPI/eSPI controller")
left mpc8xxx_spi_bufs() behind.
And since commit 3c5395b66ff6 ("spi: fsl-(e)spi: simplify cleanup code")
mpc8xxx_spi_remove() is not used anymore.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/spi/spi-fsl-lib.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index 015a1abb6a84..50a07f984b23 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -103,12 +103,9 @@ extern void mpc8xxx_spi_rx_buf_u32(u32 data, struct mpc8xxx_spi *mpc8xxx_spi);
 
 extern struct mpc8xxx_spi_probe_info *to_of_pinfo(
 		struct fsl_spi_platform_data *pdata);
-extern int mpc8xxx_spi_bufs(struct mpc8xxx_spi *mspi,
-		struct spi_transfer *t, unsigned int len);
 extern const char *mpc8xxx_spi_strmode(unsigned int flags);
 extern void mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 		unsigned int irq);
-extern int mpc8xxx_spi_remove(struct device *dev);
 extern int of_mpc8xxx_spi_probe(struct platform_device *ofdev);
 
 #endif /* __SPI_FSL_LIB_H__ */
-- 
2.34.1

