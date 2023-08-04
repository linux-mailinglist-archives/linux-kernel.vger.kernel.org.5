Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904F976FE9E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjHDKjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjHDKjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:39:11 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93C0D46B2;
        Fri,  4 Aug 2023 03:39:10 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 8D2C58140;
        Fri,  4 Aug 2023 10:39:08 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] bus: ti-sysc: Build driver for TI K3 SoCs
Date:   Fri,  4 Aug 2023 13:38:58 +0300
Message-ID: <20230804103859.57458-2-tony@atomide.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804103859.57458-1-tony@atomide.com>
References: <20230804103859.57458-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow building ti-sysc also for K3 SoCs. This allows configuring the wkup
domain devices for SYSCONFIG register wake-up events in a generic way.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -210,7 +210,8 @@ config  TI_PWMSS
 
 config TI_SYSC
 	bool "TI sysc interconnect target module driver"
-	depends on ARCH_OMAP2PLUS
+	depends on ARCH_OMAP2PLUS || ARCH_K3
+	default y
 	help
 	  Generic driver for Texas Instruments interconnect target module
 	  found on many TI SoCs.
-- 
2.41.0
