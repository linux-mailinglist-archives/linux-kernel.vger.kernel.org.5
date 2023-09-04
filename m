Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9A87911DD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352357AbjIDHPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjIDHPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:15:00 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6613399;
        Mon,  4 Sep 2023 00:14:57 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d71dd633f33so951546276.2;
        Mon, 04 Sep 2023 00:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693811696; x=1694416496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8iBmqK88tNHvKxoyD/68KKJGPMcQoSmzChGypgNtlxI=;
        b=V1pfnAAQZ1hbaAfFWGAqWF13gi72E8HRMaFqG7brVCgzfjl/UTsfj5oK/ksl11JxMt
         bqL7L8lPDVbEKvalOqwmLN04c/pnOwvtsGBcihtckGHw/bXB/L5Yr5E+HELAKgHV3PXx
         h3IRM8wETr/n4XcXgiAN2Z6Vfg3I+MhTxGDgjhlx2jGQwH7WU6YkNFU5Imq+E0k6+efy
         Y0YnPGY5sxhdUBO3cUYt+g/nM+O/EEtZaHgusmXIkA3+zZ3vAifoFehUC4HaS4GpxGj9
         vusa5s/QRkmvyOfSAAb6LkxOWOi8nyUbQ9jkavuyNqEvZ4v9jwPovwNWtc1d/AOdNTpB
         dAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693811696; x=1694416496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8iBmqK88tNHvKxoyD/68KKJGPMcQoSmzChGypgNtlxI=;
        b=g3QAcX5C+Zbx4vh+AtclbVxFRWJwlieQzDXcZy2wKocXI/y+K3g/RukGc1BYUxdhSV
         H85gdyxLQK3QG0V9VMD+bbR2zZXra9NjMoXThSedJcF3EOAo6DgGsOd4v9bFYDJpsF7X
         gopc4mbh+tJXiCwNXLwStQpWpUZDiEL/2fsfjMFVDVdEOQ3VU0kkN3maLjMVNCQQzg78
         b6uCadC988KIW9j1/ZeVURzNRFQrlGa3G3z9Yq6v95UBmGfgL47zmizsiyqhDJUNLef2
         9RHU6MuY6ZGZvb7/ZHdOLR6amkJPDzyfEnXGo1ti5ygqd7HUSz2ekLa6cfzqtP+noamW
         xTZw==
X-Gm-Message-State: AOJu0YyoUzDvH4iadZQSR7bUyAuwHavlG1XGV0397W4bUyxFexbsi/ct
        hW5CSReEUe4kgfJLuqIHDGy8hRcM41V8oA==
X-Google-Smtp-Source: AGHT+IF5Bh45ZgxD2YqR02X1d6V6cMGzgk4tl+8ldECKWKtSpddCNFT7fX/8l5G9un3fuJfT1d/TvA==
X-Received: by 2002:a25:cad0:0:b0:d77:c0b9:b182 with SMTP id a199-20020a25cad0000000b00d77c0b9b182mr9360458ybg.46.1693811696532;
        Mon, 04 Sep 2023 00:14:56 -0700 (PDT)
Received: from PLK-D0032.dom2.local ([157.25.98.166])
        by smtp.gmail.com with ESMTPSA id 82-20020a251955000000b00d74b144004bsm2207565ybz.12.2023.09.04.00.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 00:14:56 -0700 (PDT)
From:   Tomasz Rostanski <tomasz.rostanski@gmail.com>
X-Google-Original-From: Tomasz Rostanski <tomasz.rostanski@thalesgroup.com>
Cc:     stable@vger.kernel.org, Balaji Prakash J <bjagadee@codeaurora.org>,
        Felipe Balbi <balbi@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] usb: dwc3: reference clock period configuration
Date:   Mon,  4 Sep 2023 09:14:22 +0200
Message-ID: <20230904071432.32309-1-tomasz.rostanski@thalesgroup.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balaji Prakash J <bjagadee@codeaurora.org>

Set reference clock period when it differs from dwc3 default hardware
set.

We could calculate clock period based on reference clock frequency. But
this information is not always available. This is the case of PCI bus
attached USB host. For that reason we use a custom property.

Tested (USB2 only) on IPQ6010 SoC based board with 24 MHz reference
clock while hardware default is 19.2 MHz.

[ baruch: rewrite commit message; drop GFLADJ code; remove 'quirk-' from
  property name; mention tested hardware ]

Acked-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Balaji Prakash J <bjagadee@codeaurora.org>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Nacked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/9f399bdf1ff752e31ab7497e3d5ce19bbb3ff247.1630389452.git.baruch@tkos.co.il
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c | 29 +++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |  6 ++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 6377b9cf81a5..7908c151b95d 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -26,6 +26,7 @@
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/reset.h>
+#include <linux/bitfield.h>
 
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -343,6 +344,29 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
 	}
 }
 
+/**
+ * dwc3_ref_clk_period - Reference clock period configuration
+ *		Default reference clock period depends on hardware
+ *		configuration. For systems with reference clock that differs
+ *		from the default, this will set clock period in DWC3_GUCTL
+ *		register.
+ * @dwc: Pointer to our controller context structure
+ * @ref_clk_per: reference clock period in ns
+ */
+static void dwc3_ref_clk_period(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	if (dwc->ref_clk_per == 0)
+		return;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
+	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
+	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, dwc->ref_clk_per);
+	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
+}
+
+
 /**
  * dwc3_free_one_event_buffer - Frees one event buffer
  * @dwc: Pointer to our controller context structure
@@ -1021,6 +1045,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	/* Adjust Frame Length */
 	dwc3_frame_length_adjustment(dwc);
 
+	/* Adjust Reference Clock Period */
+	dwc3_ref_clk_period(dwc);
+
 	dwc3_set_incr_burst_type(dwc);
 
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
@@ -1404,6 +1431,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				    &dwc->hsphy_interface);
 	device_property_read_u32(dev, "snps,quirk-frame-length-adjustment",
 				 &dwc->fladj);
+	device_property_read_u32(dev, "snps,ref-clock-period-ns",
+				 &dwc->ref_clk_per);
 
 	dwc->dis_metastability_quirk = device_property_read_bool(dev,
 				"snps,dis_metastability_quirk");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3dcb5b744f7c..968608bd98e3 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -385,6 +385,10 @@
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
 
+/* Global User Control Register*/
+#define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
+#define DWC3_GUCTL_REFCLKPER_SEL		22
+
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
 
@@ -969,6 +973,7 @@ struct dwc3_scratchpad_array {
  * @regs: base address for our registers
  * @regs_size: address space size
  * @fladj: frame length adjustment
+ * @ref_clk_per: reference clock period configuration
  * @irq_gadget: peripheral controller's IRQ number
  * @otg_irq: IRQ number for OTG IRQs
  * @current_otg_role: current role of operation while using the OTG block
@@ -1153,6 +1158,7 @@ struct dwc3 {
 	struct power_supply	*usb_psy;
 
 	u32			fladj;
+	u32			ref_clk_per;
 	u32			irq_gadget;
 	u32			otg_irq;
 	u32			current_otg_role;
-- 
2.41.0

