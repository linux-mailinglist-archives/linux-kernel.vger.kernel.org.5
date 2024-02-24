Return-Path: <linux-kernel+bounces-79492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9520C86232F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B8A1F237A0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 06:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2DE224CE;
	Sat, 24 Feb 2024 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XX2NHxqF"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9E18E1E
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708757750; cv=none; b=A9Ng+MfbLQ+/X3gw7nN5GKzcks7VUz/Qoov8uCE0a4TvRr2M8U+Yw7pBNhMxztvh5gmdsad9JoPb5zBJFngcVjjJnM61vbGYXRebV9PrUmIZPmRHWFEk8/c6MU66NOXlgYK0Qt08zf7L1XA26lSqf7Zsm/HwHhOclhFYVq11vL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708757750; c=relaxed/simple;
	bh=xgOAPReEJUOUSBbq55ieo+WguRSIcL9ZHZoCKItajLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZ1hh17JIOH3RbP5PMkCLrXh7Z+A1aTDgahAE+wfKxj8WPHDdPr8/QA6XGqNUwqVeKC7AEOVibAf+S9s/zYii74HmGb5kfnN9EbtgsJWNusebstjXzH2U4C9qkw8reBjB6ZbaBEcIGMf0PgpaBw+l4br0yHWg5VgGu5wCYxHNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XX2NHxqF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6da202aa138so1035132b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708757734; x=1709362534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TgFiBJufO6zwQVBrqTARojW9dQ2irJqXt9kXbZy5Siw=;
        b=XX2NHxqFXz7UJgWjzDKtJma4OHfTjmNOjrhqxvpEwsV8qAzyGn/qh8o6Y3EZKTfPCE
         +kwuq2kBdNjPWTmOd8roUCFcOeJ5Fw/Vj+AfCPCwCvcpbp64aHayXLV7u61nmxJlMhHK
         CoqX6SCvbdWoQ78Faf0QcuCxqrKrCSLOjNw4PhkZ6R7BR20M0XFLL+tY0/m+Gee1I4Jr
         lhIcCong5pvH9JP78IJ4v96obZgGcM028FGgkF22b7uHsT9O0Y2v3/MiKzMbe4CSgZ3c
         aLxShXTKyg2Yce5hMG9VyhL0WC5taHLm5S//XhMrrjU3msN+ki8xvbZT9tyK2P0WPWBs
         ymlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708757734; x=1709362534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgFiBJufO6zwQVBrqTARojW9dQ2irJqXt9kXbZy5Siw=;
        b=GueKMh6T9SLqRUmLfs+LTVMIT7rVLFsWmHcXe0PFt+uLThOX4S+OD+D/O6I8CZjYzf
         xJxNR9r0tmbVnsffwi798w7d1kIoWR3cnHHucV2zmEH2HUVt5fP3RbVIN0FuIf5uhjbB
         wyGlZ2AY6UH4jAjXo5+J2KxE/KY4t4z9pClF40ndeCLaiz/VOJiMZIdlgzmCV63bzS06
         o6MAnsi126u8+BFLVW8zxscxuMwXAEvRg5N7wkKVR35gIH3av8fqdFftOaNCZyQFgNSC
         8ZIWxsEfiwEt+8IwBQ3Nx7VxCDcLNwm1hbGclCx+DcbD9m7h4Gh7tL8KdoAf9+sBBYZO
         q1yQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGcmtzrW1MsjOg5DrFZE95cVf/9fNpqD/YYuIVt/NOPnpAzNjrfqMCgPvVDLBOD8biKknTRVhZdzSQhrcTIgtRK9SHjmXXEioMvpgb
X-Gm-Message-State: AOJu0YysfTAYtH4O+6Q1FZa97unIvurjkd0PyJUqHQYuO/hYMVMtROEb
	hL1kBuRltxE+DJ9j7ZKI3fSQK832piQ9ErKLZ/1Q/Rr2S0MKz0epDbLFAkqnKQ==
X-Google-Smtp-Source: AGHT+IHPvv3eeLRswfzLtKg1ymbWAHVl7o4aabRURWTXp2NkX34tLKuvOmNrUwW5nDnWY0Fx0QpU3w==
X-Received: by 2002:a05:6a21:398a:b0:1a0:ec6d:6e25 with SMTP id ad10-20020a056a21398a00b001a0ec6d6e25mr1171245pzc.49.1708757734013;
        Fri, 23 Feb 2024 22:55:34 -0800 (PST)
Received: from [127.0.1.1] ([120.138.12.46])
        by smtp.gmail.com with ESMTPSA id r5-20020aa78b85000000b006e4cb7f4393sm502932pfd.165.2024.02.23.22.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 22:55:33 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Sat, 24 Feb 2024 12:24:14 +0530
Subject: [PATCH v8 08/10] PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown()
 API to handle LINK_DOWN event
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-pci-dbi-rework-v8-8-64c7fd0cfe64@linaro.org>
References: <20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org>
In-Reply-To: <20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Kishon Vijay Abraham I <kishon@ti.com>, Vidya Sagar <vidyas@nvidia.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
 Roy Zang <roy.zang@nxp.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6608;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=xgOAPReEJUOUSBbq55ieo+WguRSIcL9ZHZoCKItajLk=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl2ZKXsDVOA2xzi5k6nOKJT1G7tq0IgmBednaFi
 ati/eycwJuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdmSlwAKCRBVnxHm/pHO
 9W48B/0VuWxxJIQp0+BR1zbVrcK1dNWzJ7o4QTf8sUjO5rLSCcAvcGQchv+LXPN1GBqqOjvCq8P
 xG5rY071pYAA/mbWe8ZYm3WyAqnI/Lw8V3HzfgBBHOhXUnd9kp1v/X7sEYFTZVKkyPQZb6EK4Pp
 9uTEv37jyQoGEKoMLbluDbf8vnExf7zX9FxHqGx6ANm3Y+AKc7sdYQiik+3EUq6GcpIpIdq5Q7i
 0AU5aG2pwHPT+Zq3O47rEKQhfprS+TociNOFODrKDVbDlmN3sKC3mlWF2HhgIlGXRPpU95bkZxM
 yHL/SaLfr6iTK9Y46Y/Ri/R2oAdY5fqDBka/dZFiCkktWf5d
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

The PCIe link can go to LINK_DOWN state in one of the following scenarios:

1. Fundamental (PERST#)/hot/warm reset
2. Link transition from L2/L3 to L0

In those cases, LINK_DOWN causes some non-sticky DWC registers to loose the
state (like REBAR, PTM_CAP etc...). So the drivers need to reinitialize
them to function properly once the link comes back again.

This is not a problem for drivers supporting PERST# IRQ, since they can
reinitialize the registers in the PERST# IRQ callback. But for the drivers
not supporting PERST#, there is no way they can reinitialize the registers
other than relying on LINK_DOWN IRQ received when the link goes down. So
let's add a DWC generic API dw_pcie_ep_linkdown() that reinitializes the
non-sticky registers and also notifies the EPF drivers about link going
down.

This API can also be used by the drivers supporting PERST# to handle the
scenario (2) mentioned above.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 111 ++++++++++++++----------
 drivers/pci/controller/dwc/pcie-designware.h    |   5 ++
 2 files changed, 72 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 278bdc9b2269..fed4c2936c78 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -14,14 +14,6 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 
-void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
-{
-	struct pci_epc *epc = ep->epc;
-
-	pci_epc_linkup(epc);
-}
-EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
-
 void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
 {
 	struct pci_epc *epc = ep->epc;
@@ -603,19 +595,56 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
 	return 0;
 }
 
+static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
+{
+	unsigned int offset, ptm_cap_base;
+	unsigned int nbars;
+	u32 reg, i;
+
+	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
+	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	if (offset) {
+		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
+		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
+			PCI_REBAR_CTRL_NBAR_SHIFT;
+
+		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
+			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
+	}
+
+	/*
+	 * PTM responder capability can be disabled only after disabling
+	 * PTM root capability.
+	 */
+	if (ptm_cap_base) {
+		dw_pcie_dbi_ro_wr_en(pci);
+		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
+		reg &= ~PCI_PTM_CAP_ROOT;
+		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
+
+		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
+		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
+		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
+
+	dw_pcie_setup(pci);
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_pcie_ep_func *ep_func;
 	struct device *dev = pci->dev;
 	struct pci_epc *epc = ep->epc;
-	unsigned int offset, ptm_cap_base;
-	unsigned int nbars;
 	u8 hdr_type;
 	u8 func_no;
-	int i, ret;
 	void *addr;
-	u32 reg;
+	int ret;
 
 	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
 		   PCI_HEADER_TYPE_MASK;
@@ -678,38 +707,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	if (ep->ops->init)
 		ep->ops->init(ep);
 
-	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
-	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
-
-	dw_pcie_dbi_ro_wr_en(pci);
-
-	if (offset) {
-		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
-		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
-			PCI_REBAR_CTRL_NBAR_SHIFT;
-
-		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
-			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
-	}
-
-	/*
-	 * PTM responder capability can be disabled only after disabling
-	 * PTM root capability.
-	 */
-	if (ptm_cap_base) {
-		dw_pcie_dbi_ro_wr_en(pci);
-		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
-		reg &= ~PCI_PTM_CAP_ROOT;
-		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
-
-		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
-		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
-		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
-		dw_pcie_dbi_ro_wr_dis(pci);
-	}
-
-	dw_pcie_setup(pci);
-	dw_pcie_dbi_ro_wr_dis(pci);
+	dw_pcie_ep_init_non_sticky_registers(pci);
 
 	return 0;
 
@@ -720,6 +718,31 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_init_registers);
 
+void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
+{
+	struct pci_epc *epc = ep->epc;
+
+	pci_epc_linkup(epc);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
+
+void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct pci_epc *epc = ep->epc;
+
+	/*
+	 * Initialize the non-sticky DWC registers as they would've reset post
+	 * LINK_DOWN. This is specifically needed for drivers not supporting
+	 * PERST# as they have no way to reinitialize the registers before the
+	 * link comes back again.
+	 */
+	dw_pcie_ep_init_non_sticky_registers(pci);
+
+	pci_epc_linkdown(epc);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_ep_linkdown);
+
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	int ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f8e5431a207b..152969545b0a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -668,6 +668,7 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
 
 #ifdef CONFIG_PCIE_DW_EP
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
+void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep);
 void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
@@ -688,6 +689,10 @@ static inline void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
 {
 }
 
+static inline void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep)
+{
+}
+
 static inline int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	return 0;

-- 
2.25.1


