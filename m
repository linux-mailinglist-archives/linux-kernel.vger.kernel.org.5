Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349A779CE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjILKhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjILKhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:37:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B472105;
        Tue, 12 Sep 2023 03:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694514972; x=1726050972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UE6R71ILf/9stRdcLZnggEzxfGKw+NVMfPOUWW0UkBo=;
  b=QOvjXhHa437Fxn+R/o/F8c4guz+eSzgEq1SfkkCbkJSLhdrhR4GiRGru
   Sikauelax2hBGWe+eMG6kyFoY1bKb7qYF7TZAJhnJdpPXgawwaTMdD12u
   OqTrSyZgd8fBhlaDjqIDmc7FDmpgmRbRFF6WvEh45c+o80WW+gQy8YrrQ
   CpLIVS5s3kbHsr4i3lbJ9/pm+IaoSGHmx+ySW6giyOuDxsBbTa7E0+Oso
   I0PJfzO+iAA9BzFS4RFDwTo8ZyAw0H5Q5UGvfJmxLCbSELfuN6UD3Si89
   JE6VYb1ybxCPAAo4MPmpEGgUMtXw1dfeIJZRr3h4l4W6/UwMaz8eGhR+W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="375665459"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="375665459"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 03:36:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="772948799"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="772948799"
Received: from npejicx-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.217.90])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 03:36:09 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] tty/serial: 8250: Sort drivers in Makefile
Date:   Tue, 12 Sep 2023 13:35:58 +0300
Message-Id: <20230912103558.20123-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230912103558.20123-1-ilpo.jarvinen@linux.intel.com>
References: <20230912103558.20123-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort drivers in alphabetic order in Makefile to make it easier to find
the correct line. In case the CONFIG and filenames disagree, sort using
the filename (ignore 8250 prefix while sorting).

In addition, place 8250_early separately above the drivers.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/Makefile | 42 +++++++++++++++++---------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index 628b75be312e..ea2e81f58eac 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -13,39 +13,41 @@ obj-$(CONFIG_SERIAL_8250)		+= 8250.o 8250_base.o
 8250_base-$(CONFIG_SERIAL_8250_DWLIB)	+= 8250_dwlib.o
 8250_base-$(CONFIG_SERIAL_8250_FINTEK)	+= 8250_fintek.o
 8250_base-$(CONFIG_SERIAL_8250_PCILIB)	+= 8250_pcilib.o
-obj-$(CONFIG_SERIAL_8250_PARISC)	+= 8250_parisc.o
-obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
-obj-$(CONFIG_SERIAL_8250_EXAR)		+= 8250_exar.o
-obj-$(CONFIG_SERIAL_8250_HP300)		+= 8250_hp300.o
-obj-$(CONFIG_SERIAL_8250_CS)		+= serial_cs.o
+
+obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= 8250_early.o
+
+obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
 obj-$(CONFIG_SERIAL_8250_ACORN)		+= 8250_acorn.o
 obj-$(CONFIG_SERIAL_8250_ASPEED_VUART)	+= 8250_aspeed_vuart.o
 obj-$(CONFIG_SERIAL_8250_BCM2835AUX)	+= 8250_bcm2835aux.o
-obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= 8250_early.o
-obj-$(CONFIG_SERIAL_8250_FOURPORT)	+= 8250_fourport.o
-obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
+obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
 obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
-obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
-obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
-obj-$(CONFIG_SERIAL_8250_PCI1XXXX)	+= 8250_pci1xxxx.o
-obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
-obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
 obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
 obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
 obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
+obj-$(CONFIG_SERIAL_8250_EXAR)		+= 8250_exar.o
+obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
+obj-$(CONFIG_SERIAL_8250_FOURPORT)	+= 8250_fourport.o
+obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
+obj-$(CONFIG_SERIAL_8250_HP300)		+= 8250_hp300.o
+obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
+obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
 obj-$(CONFIG_SERIAL_8250_IOC3)		+= 8250_ioc3.o
-obj-$(CONFIG_SERIAL_8250_OMAP)		+= 8250_omap.o
-obj-$(CONFIG_SERIAL_8250_RT288X)	+= 8250_rt288x.o
 obj-$(CONFIG_SERIAL_8250_LPC18XX)	+= 8250_lpc18xx.o
-obj-$(CONFIG_SERIAL_8250_MT6577)	+= 8250_mtk.o
-obj-$(CONFIG_SERIAL_8250_UNIPHIER)	+= 8250_uniphier.o
-obj-$(CONFIG_SERIAL_8250_INGENIC)	+= 8250_ingenic.o
 obj-$(CONFIG_SERIAL_8250_LPSS)		+= 8250_lpss.o
+obj-$(CONFIG_SERIAL_8250_MEN_MCB)	+= 8250_men_mcb.o
 obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
+obj-$(CONFIG_SERIAL_8250_MT6577)	+= 8250_mtk.o
+obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
+obj-$(CONFIG_SERIAL_8250_OMAP)		+= 8250_omap.o
+obj-$(CONFIG_SERIAL_8250_PARISC)	+= 8250_parisc.o
+obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
+obj-$(CONFIG_SERIAL_8250_PCI1XXXX)	+= 8250_pci1xxxx.o
 obj-$(CONFIG_SERIAL_8250_PERICOM)	+= 8250_pericom.o
 obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
+obj-$(CONFIG_SERIAL_8250_RT288X)	+= 8250_rt288x.o
+obj-$(CONFIG_SERIAL_8250_CS)		+= serial_cs.o
+obj-$(CONFIG_SERIAL_8250_UNIPHIER)	+= 8250_uniphier.o
 obj-$(CONFIG_SERIAL_8250_TEGRA)		+= 8250_tegra.o
-obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
-obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
-- 
2.30.2

