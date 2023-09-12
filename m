Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1C079CE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbjILKhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbjILKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:37:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C161FC8;
        Tue, 12 Sep 2023 03:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694514968; x=1726050968;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sJ7RXJpjaaE1dxFXuQoY1C1LBW/iqf7J2wYID3Hi8ps=;
  b=Khsseuvc7Bbj12EhC3gAsF47hP0UuFlgsWiBpXw0s5RhzXXrelW6ImUG
   i03aExto/E02CpVc4PZlSwp8E5g4PSjuYTsf/+7Vp6j8yXTqbns0NUgnC
   o8Oex7k6T8SAPlQYWIM+JlyiQJbWc+XMvDT8wgUt2Lj5Xp+hwihXBj8pr
   ix0EJuzp2Hds0Djb9Pi4BsWzC9b6MxhJXtxpQkh8lkkzb+t8/s2qHSK5M
   luhN/JTpJIHZxo1+Od0Cfr1AoU5OK5YiC/3QdCPoQpERsB8burrhKEPi7
   lL+ua2dlAu8hOBZaiWQmhhAhvnpgr/aeG21ah4YmEewALtjcqYiPf/8ks
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="375665451"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="375665451"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 03:36:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="772948755"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="772948755"
Received: from npejicx-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.217.90])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 03:36:05 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/2] tty/serial: Sort drivers in makefile
Date:   Tue, 12 Sep 2023 13:35:57 +0300
Message-Id: <20230912103558.20123-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort drivers in alphabetic order in Makefile to make it easier to find
the correct line. In case the CONFIG and filenames disagree, sort using
the filename (but ignoring "serial" prefixes).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/Makefile | 124 ++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 138abbc89738..f6b8c220dcfb 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -24,70 +24,70 @@ obj-$(CONFIG_SERIAL_21285) += 21285.o
 # Now bring in any enabled 8250/16450/16550 type drivers.
 obj-y += 8250/
 
-obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
-obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
-obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
-obj-$(CONFIG_SERIAL_PXA_NON8250) += pxa.o
-obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
-obj-$(CONFIG_SERIAL_BCM63XX) += bcm63xx_uart.o
-obj-$(CONFIG_SERIAL_SAMSUNG) += samsung_tty.o
-obj-$(CONFIG_SERIAL_MAX3100) += max3100.o
-obj-$(CONFIG_SERIAL_MAX310X) += max310x.o
-obj-$(CONFIG_SERIAL_IP22_ZILOG) += ip22zilog.o
-obj-$(CONFIG_SERIAL_MUX) += mux.o
-obj-$(CONFIG_SERIAL_MCF) += mcf.o
-obj-$(CONFIG_SERIAL_PMACZILOG) += pmac_zilog.o
-obj-$(CONFIG_SERIAL_HS_LPC32XX) += lpc32xx_hs.o
-obj-$(CONFIG_SERIAL_DZ) += dz.o
-obj-$(CONFIG_SERIAL_ZS) += zs.o
-obj-$(CONFIG_SERIAL_SH_SCI) += sh-sci.o
-obj-$(CONFIG_SERIAL_CPM) += cpm_uart.o
-obj-$(CONFIG_SERIAL_IMX) += imx.o
-obj-$(CONFIG_SERIAL_IMX_EARLYCON) += imx_earlycon.o
-obj-$(CONFIG_SERIAL_MPC52xx) += mpc52xx_uart.o
-obj-$(CONFIG_SERIAL_ICOM) += icom.o
-obj-$(CONFIG_SERIAL_MESON) += meson_uart.o
-obj-$(CONFIG_SERIAL_SB1250_DUART) += sb1250-duart.o
-obj-$(CONFIG_SERIAL_SCCNXP) += sccnxp.o
-obj-$(CONFIG_SERIAL_SC16IS7XX_CORE) += sc16is7xx.o
-obj-$(CONFIG_SERIAL_JSM) += jsm/
-obj-$(CONFIG_SERIAL_TXX9) += serial_txx9.o
-obj-$(CONFIG_SERIAL_ATMEL) += atmel_serial.o
-obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
-obj-$(CONFIG_SERIAL_MSM) += msm_serial.o
-obj-$(CONFIG_SERIAL_QCOM_GENI) += qcom_geni_serial.o
-obj-$(CONFIG_SERIAL_OMAP) += omap-serial.o
-obj-$(CONFIG_SERIAL_ALTERA_UART) += altera_uart.o
-obj-$(CONFIG_SERIAL_ST_ASC) += st-asc.o
-obj-$(CONFIG_SERIAL_QE) += ucc_uart.o
-obj-$(CONFIG_SERIAL_TIMBERDALE)	+= timbuart.o
+obj-$(CONFIG_SERIAL_ALTERA_JTAGUART)	+= altera_jtaguart.o
+obj-$(CONFIG_SERIAL_ALTERA_UART)	+= altera_uart.o
+obj-$(CONFIG_SERIAL_AMBA_PL010)		+= amba-pl010.o
+obj-$(CONFIG_SERIAL_AMBA_PL011)		+= amba-pl011.o
 obj-$(CONFIG_SERIAL_GRLIB_GAISLER_APBUART) += apbuart.o
-obj-$(CONFIG_SERIAL_ALTERA_JTAGUART) += altera_jtaguart.o
-obj-$(CONFIG_SERIAL_VT8500) += vt8500_serial.o
-obj-$(CONFIG_SERIAL_PCH_UART)	+= pch_uart.o
-obj-$(CONFIG_SERIAL_MXS_AUART) += mxs-auart.o
-obj-$(CONFIG_SERIAL_LANTIQ)	+= lantiq.o
-obj-$(CONFIG_SERIAL_XILINX_PS_UART) += xilinx_uartps.o
-obj-$(CONFIG_SERIAL_TEGRA) += serial-tegra.o
-obj-$(CONFIG_SERIAL_TEGRA_TCU) += tegra-tcu.o
-obj-$(CONFIG_SERIAL_AR933X)   += ar933x_uart.o
-obj-$(CONFIG_SERIAL_ARC)	+= arc_uart.o
-obj-$(CONFIG_SERIAL_RP2)	+= rp2.o
-obj-$(CONFIG_SERIAL_FSL_LPUART)	+= fsl_lpuart.o
-obj-$(CONFIG_SERIAL_FSL_LINFLEXUART)	+= fsl_linflexuart.o
+obj-$(CONFIG_SERIAL_AR933X)		+= ar933x_uart.o
+obj-$(CONFIG_SERIAL_ARC)		+= arc_uart.o
+obj-$(CONFIG_SERIAL_ATMEL)		+= atmel_serial.o
+obj-$(CONFIG_SERIAL_BCM63XX)		+= bcm63xx_uart.o
+obj-$(CONFIG_SERIAL_CLPS711X)		+= clps711x.o
+obj-$(CONFIG_SERIAL_CPM)		+= cpm_uart.o
 obj-$(CONFIG_SERIAL_CONEXANT_DIGICOLOR)	+= digicolor-usart.o
-obj-$(CONFIG_SERIAL_MEN_Z135)	+= men_z135_uart.o
-obj-$(CONFIG_SERIAL_SPRD) += sprd_serial.o
-obj-$(CONFIG_SERIAL_STM32)	+= stm32-usart.o
-obj-$(CONFIG_SERIAL_MVEBU_UART)	+= mvebu-uart.o
-obj-$(CONFIG_SERIAL_PIC32)	+= pic32_uart.o
-obj-$(CONFIG_SERIAL_MPS2_UART)	+= mps2-uart.o
-obj-$(CONFIG_SERIAL_OWL)	+= owl-uart.o
-obj-$(CONFIG_SERIAL_RDA)	+= rda-uart.o
-obj-$(CONFIG_SERIAL_MILBEAUT_USIO) += milbeaut_usio.o
-obj-$(CONFIG_SERIAL_SIFIVE)	+= sifive.o
-obj-$(CONFIG_SERIAL_LITEUART) += liteuart.o
-obj-$(CONFIG_SERIAL_SUNPLUS)	+= sunplus-uart.o
+obj-$(CONFIG_SERIAL_DZ)			+= dz.o
+obj-$(CONFIG_SERIAL_FSL_LINFLEXUART)	+= fsl_linflexuart.o
+obj-$(CONFIG_SERIAL_FSL_LPUART)		+= fsl_lpuart.o
+obj-$(CONFIG_SERIAL_ICOM)		+= icom.o
+obj-$(CONFIG_SERIAL_IMX)		+= imx.o
+obj-$(CONFIG_SERIAL_IMX_EARLYCON)	+= imx_earlycon.o
+obj-$(CONFIG_SERIAL_IP22_ZILOG)		+= ip22zilog.o
+obj-$(CONFIG_SERIAL_JSM)		+= jsm/
+obj-$(CONFIG_SERIAL_LANTIQ)		+= lantiq.o
+obj-$(CONFIG_SERIAL_LITEUART)		+= liteuart.o
+obj-$(CONFIG_SERIAL_HS_LPC32XX)		+= lpc32xx_hs.o
+obj-$(CONFIG_SERIAL_MAX3100)		+= max3100.o
+obj-$(CONFIG_SERIAL_MAX310X)		+= max310x.o
+obj-$(CONFIG_SERIAL_MCF)		+= mcf.o
+obj-$(CONFIG_SERIAL_MEN_Z135)		+= men_z135_uart.o
+obj-$(CONFIG_SERIAL_MILBEAUT_USIO)	+= milbeaut_usio.o
+obj-$(CONFIG_SERIAL_MESON)		+= meson_uart.o
+obj-$(CONFIG_SERIAL_MPC52xx)		+= mpc52xx_uart.o
+obj-$(CONFIG_SERIAL_MPS2_UART)		+= mps2-uart.o
+obj-$(CONFIG_SERIAL_MSM)		+= msm_serial.o
+obj-$(CONFIG_SERIAL_MUX)		+= mux.o
+obj-$(CONFIG_SERIAL_MVEBU_UART)		+= mvebu-uart.o
+obj-$(CONFIG_SERIAL_MXS_AUART)		+= mxs-auart.o
+obj-$(CONFIG_SERIAL_OMAP)		+= omap-serial.o
+obj-$(CONFIG_SERIAL_OWL)		+= owl-uart.o
+obj-$(CONFIG_SERIAL_PCH_UART)		+= pch_uart.o
+obj-$(CONFIG_SERIAL_PIC32)		+= pic32_uart.o
+obj-$(CONFIG_SERIAL_PXA_NON8250)	+= pxa.o
+obj-$(CONFIG_SERIAL_PMACZILOG)		+= pmac_zilog.o
+obj-$(CONFIG_SERIAL_QCOM_GENI)		+= qcom_geni_serial.o
+obj-$(CONFIG_SERIAL_QE)			+= ucc_uart.o
+obj-$(CONFIG_SERIAL_RDA)		+= rda-uart.o
+obj-$(CONFIG_SERIAL_RP2)		+= rp2.o
+obj-$(CONFIG_SERIAL_SA1100)		+= sa1100.o
+obj-$(CONFIG_SERIAL_SAMSUNG)		+= samsung_tty.o
+obj-$(CONFIG_SERIAL_SB1250_DUART)	+= sb1250-duart.o
+obj-$(CONFIG_SERIAL_SCCNXP)		+= sccnxp.o
+obj-$(CONFIG_SERIAL_SC16IS7XX_CORE)	+= sc16is7xx.o
+obj-$(CONFIG_SERIAL_SH_SCI)		+= sh-sci.o
+obj-$(CONFIG_SERIAL_SIFIVE)		+= sifive.o
+obj-$(CONFIG_SERIAL_SPRD)		+= sprd_serial.o
+obj-$(CONFIG_SERIAL_ST_ASC)		+= st-asc.o
+obj-$(CONFIG_SERIAL_STM32)		+= stm32-usart.o
+obj-$(CONFIG_SERIAL_SUNPLUS)		+= sunplus-uart.o
+obj-$(CONFIG_SERIAL_TEGRA)		+= serial-tegra.o
+obj-$(CONFIG_SERIAL_TEGRA_TCU)		+= tegra-tcu.o
+obj-$(CONFIG_SERIAL_TIMBERDALE)		+= timbuart.o
+obj-$(CONFIG_SERIAL_TXX9)		+= serial_txx9.o
+obj-$(CONFIG_SERIAL_UARTLITE)		+= uartlite.o
+obj-$(CONFIG_SERIAL_VT8500)		+= vt8500_serial.o
+obj-$(CONFIG_SERIAL_XILINX_PS_UART)	+= xilinx_uartps.o
+obj-$(CONFIG_SERIAL_ZS)			+= zs.o
 
 # GPIOLIB helpers for modem control lines
 obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
-- 
2.30.2

