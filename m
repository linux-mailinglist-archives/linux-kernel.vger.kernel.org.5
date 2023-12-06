Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2618066E3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376862AbjLFF6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 00:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376768AbjLFF6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 00:58:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708AC1B6;
        Tue,  5 Dec 2023 21:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=NtggG1InZAv0Tvwy1xVMHIpHvfsKvYI8PLGZB31GSbI=; b=QotLXqrwpRTYc2pzUE7UCK0QTo
        davewsxjMwpxIDTws2pUuJdEBN9MvrG1JCDi7YZC2foZ+0QbVj/5HIbSCK7xrLcjkjoPJ3ASZlrlA
        km7C5al91lIYfdF02LuFVTaZ9mzw26Kd49nqva99sf72F0p9MAfhQhpW2F5rtaR56PVJ/2QIuVhQF
        Q85cAbyP31UOPUYEbJYSCeqVl2jKN384ge2DxT+j6v4t5cdVtfJwBxN1biaD6SMBgtRKfvnY8SSlC
        jQrA28yeRsfFo2h21ZYvkljqSFrsA7cThNNOVJ69sZYrMRCEBvWTXboZ9rvErb9JxT/2Yot13ijb6
        Zykw5+nA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAkvw-0098sn-0k;
        Wed, 06 Dec 2023 05:58:56 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-omap: don't misuse kernel-doc marker
Date:   Tue,  5 Dec 2023 21:58:55 -0800
Message-ID: <20231206055855.21092-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "/*" instead of "/**" for common C comments to prevent warnings
from scripts/kernel-doc.

sdhci-omap.c:3: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
sdhci-omap.c:3: warning: missing initial short description on line:
 * SDHCI Controller driver for TI's OMAP SoCs

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202311201117.lFxgJTK6-lkp@intel.com/
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
---
This does not Close the report since there are also some warnings for
missing-prototypes.

 drivers/mmc/host/sdhci-omap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * SDHCI Controller driver for TI's OMAP SoCs
  *
  * Copyright (C) 2017 Texas Instruments
