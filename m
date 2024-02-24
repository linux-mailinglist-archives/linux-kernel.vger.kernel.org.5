Return-Path: <linux-kernel+bounces-79488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057BF862313
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1321C21BD6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 06:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293F417993;
	Sat, 24 Feb 2024 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvw/IPH2"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED617592
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708757703; cv=none; b=bzHDn/P129H399cccsANB8xX6BGx6chk8CTEQfAAkYmBA1g1WrnHIenyZpeBj0wt4nY72eFOjREWoEFawHPAroaiOVTD1iEoR1cQn9PVLakStKncqyB27HeH5SozM2F/3oLDZE4lLzo6ikethp1Jlx65YK63Vi8rk2iuZmUr15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708757703; c=relaxed/simple;
	bh=qldMTtVGUo5lDMZM4xG3tzrJt0x+Ru12VAwPkqahGjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a8RgxfQMWQu0gCmFxnNwpy69moBg1whQjV7RiPkOWB36Dq7e41CETgFX0DpfN9/umvvLlF4jZE5abgpXYHyxMb1KDMizzT3MfepXK7qBOvDLbjD7+4Yi1tw1gRCGpDHHZHHjzlG5jDOo9yb1Fa7VKCxbjCAXfMvNgQxOS2NhrbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dvw/IPH2; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-21e6be74db4so598463fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708757700; x=1709362500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=joeXMwEVA7mDgrHHJmbcOh+YUIfmjaNkgN+gOStshl4=;
        b=dvw/IPH22Mn5PdULt+ca8ifWhzwoHzL4jqNWCUYNgc8nbmz+8dOIsltmUpkPd2K5J9
         RaN6vD+fu6xdi7/TUwIyhnT0ISH1imeyHdfzcwaSHTP/LSl7C7fIVJV7ipmltiUFnn89
         CXCJbDRNNTV88QGMF1wwsO3toRGySo5k8ba1tDsHCVsYDP+RYg+SmlZgutLmrdtlLKIQ
         w+YF33wR1Z1ZWiYEl862S2WFF2zM+rTlJuaJ2/wfAUFzJ42NLeMuddtoUevBoKXeimaB
         gQKAhYW7WLuvKwIqjIuX3GjwV0RrRoQVFBRI5F0uiciNxG6PIrwcrVpoHP4GZAg7s5wS
         64SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708757700; x=1709362500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joeXMwEVA7mDgrHHJmbcOh+YUIfmjaNkgN+gOStshl4=;
        b=DzC9Op8hiLVgObHj7AR2yeGiW44B5HS4yGpF51AGy94NxgjYT1kMQ+7crN6IGVUZOM
         W/VKCena7muqd5tFks55JpQCjllSpIrCl9qdr5kSYLqCxb4Kfudm68p9VhHLR52Ih6l0
         4wMcW1ZNciumT0Klrbgf91SHBnPOyYT9tHLxaWZOt2cKv1owDt5Pl9S2XW8RhkQD34Yq
         8u6G/bR46LeftdnjMvpvNKe99zsHuSbDZmZcAzkv2q6jPu0ihEVLnbAmFD1r0ajJ+MrO
         SZP/VPf20ySPk5HFS2YAQja3DHc8djytojvHPd4rVsWMUD+mCOnoE88VSb9AlysaXaEc
         UH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0tftBIMbEeIWR+d7i7KXsqk1oGnO7YZpT45TdgFiPX7VrM2n5qLweNJl8f5o6o5jRYgmuc4QBPlF8aomR5QRUiI8IFoytxj6qM919
X-Gm-Message-State: AOJu0YxI/9mfHO8sgcPDKDlshUzA+lqdRvWKgljKrdyDL/U0QmKruLhR
	v2PYWpaVfsX/kugGo9y/qy73a0OUqaZpRGp+bSXgCE4MkuKbNB3Wmr/oXlqP4Q==
X-Google-Smtp-Source: AGHT+IFGcbFYU737M6kmjlvWiLrV5ZwFktGaKSDAef9fKN1VKtWrJDg8F4zZYhUORgNytSFe8fxXgg==
X-Received: by 2002:a05:6358:5623:b0:17b:5dd1:a38d with SMTP id b35-20020a056358562300b0017b5dd1a38dmr2266837rwf.1.1708757699831;
        Fri, 23 Feb 2024 22:54:59 -0800 (PST)
Received: from [127.0.1.1] ([120.138.12.46])
        by smtp.gmail.com with ESMTPSA id r5-20020aa78b85000000b006e4cb7f4393sm502932pfd.165.2024.02.23.22.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 22:54:59 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Sat, 24 Feb 2024 12:24:10 +0530
Subject: [PATCH v8 04/10] PCI: dwc: ep: Fix DBI access failure for drivers
 requiring refclk from host
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-pci-dbi-rework-v8-4-64c7fd0cfe64@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7390;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=qldMTtVGUo5lDMZM4xG3tzrJt0x+Ru12VAwPkqahGjw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl2ZKWRKBz+u4mIJBImyyENYXdGJCigRqJ+VZ6I
 xNQ03ZNJ2iJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdmSlgAKCRBVnxHm/pHO
 9X+rB/0XGKWgslByHRknPL5uaQJs6G4qN4NnmaUNEbfXjxQWEnSZPe68Kr3YrdqU8nlLQ7VxVZK
 ctAdojob7nujJOeAVFVX1/OY2M4OgL8duskQBdbWNBCMhkruB+zp+62BOF1eDMqMntXQhdWnr2M
 viK7WuMrPa4p0Kj1nGrdQfQ50v1TAt9JmhxMgNB2u+lZXmA8DwKyCUsQtcTeYiUN4L22yz8QOg1
 LO4Zbo5HoGmIa6xlWtKQkc2AcnfEdPVICI9rW9llHPtbVUld/O/j/TgTcIVqKWUCSSYGaNLZKTx
 6ZUL2f0FOtdWTxdwnL65bUnvHWQvKmJbidJyOLAcE9oUfJBf
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

The DWC glue drivers requiring an active reference clock from the PCIe host
for initializing their PCIe EP core, set a flag called 'core_init_notifier'
to let DWC driver know that these drivers need a special attention during
initialization. In these drivers, access to the hw registers (like DBI)
before receiving the active refclk from host will result in access failure
and also could cause a whole system hang.

But the current DWC EP driver doesn't honor the requirements of the drivers
setting 'core_init_notifier' flag and tries to access the DBI registers
during dw_pcie_ep_init(). This causes the system hang for glue drivers such
as Tegra194 and Qcom EP as they depend on refclk from host and have set the
above mentioned flag.

To workaround this issue, users of the affected platforms have to maintain
the dependency with the PCIe host by booting the PCIe EP after host boot.
But this won't provide a good user experience, since PCIe EP is _one_ of
the features of those platforms and it doesn't make sense to delay the
whole platform booting due to PCIe requiring active refclk.

So to fix this issue, let's move all the DBI access from
dw_pcie_ep_init() in the DWC EP driver to the dw_pcie_ep_init_complete()
API. This API will only be called by the drivers setting
'core_init_notifier' flag once refclk is received from host. For the rest
of the drivers that gets the refclk locally, this API will be called
within dw_pcie_ep_init().

Fixes: e966f7390da9 ("PCI: dwc: Refactor core initialization code for EP mode")
Co-developed-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 120 ++++++++++++++----------
 1 file changed, 71 insertions(+), 49 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1205bfba8310..99d66b0fa59b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -606,11 +606,16 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
 int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_func *ep_func;
+	struct device *dev = pci->dev;
+	struct pci_epc *epc = ep->epc;
 	unsigned int offset, ptm_cap_base;
 	unsigned int nbars;
 	u8 hdr_type;
+	u8 func_no;
+	int i, ret;
+	void *addr;
 	u32 reg;
-	int i;
 
 	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
 		   PCI_HEADER_TYPE_MASK;
@@ -621,6 +626,58 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 		return -EIO;
 	}
 
+	dw_pcie_version_detect(pci);
+
+	dw_pcie_iatu_detect(pci);
+
+	ret = dw_pcie_edma_detect(pci);
+	if (ret)
+		return ret;
+
+	if (!ep->ib_window_map) {
+		ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
+						       GFP_KERNEL);
+		if (!ep->ib_window_map)
+			goto err_remove_edma;
+	}
+
+	if (!ep->ob_window_map) {
+		ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
+						       GFP_KERNEL);
+		if (!ep->ob_window_map)
+			goto err_remove_edma;
+	}
+
+	if (!ep->outbound_addr) {
+		addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
+				    GFP_KERNEL);
+		if (!addr)
+			goto err_remove_edma;
+		ep->outbound_addr = addr;
+	}
+
+	for (func_no = 0; func_no < epc->max_functions; func_no++) {
+
+		ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
+		if (ep_func)
+			continue;
+
+		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
+		if (!ep_func)
+			goto err_remove_edma;
+
+		ep_func->func_no = func_no;
+		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
+							      PCI_CAP_ID_MSI);
+		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
+							       PCI_CAP_ID_MSIX);
+
+		list_add_tail(&ep_func->list, &ep->func_list);
+	}
+
+	if (ep->ops->init)
+		ep->ops->init(ep);
+
 	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
 	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
 
@@ -655,14 +712,17 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
+
+err_remove_edma:
+	dw_pcie_edma_remove(pci);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
 
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	int ret;
-	void *addr;
-	u8 func_no;
 	struct resource *res;
 	struct pci_epc *epc;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -670,7 +730,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
 	const struct pci_epc_features *epc_features;
-	struct dw_pcie_ep_func *ep_func;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -688,26 +747,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ep->ops->pre_init)
 		ep->ops->pre_init(ep);
 
-	dw_pcie_version_detect(pci);
-
-	dw_pcie_iatu_detect(pci);
-
-	ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
-					       GFP_KERNEL);
-	if (!ep->ib_window_map)
-		return -ENOMEM;
-
-	ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
-					       GFP_KERNEL);
-	if (!ep->ob_window_map)
-		return -ENOMEM;
-
-	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
-			    GFP_KERNEL);
-	if (!addr)
-		return -ENOMEM;
-	ep->outbound_addr = addr;
-
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
 		dev_err(dev, "Failed to create epc device\n");
@@ -721,23 +760,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ret < 0)
 		epc->max_functions = 1;
 
-	for (func_no = 0; func_no < epc->max_functions; func_no++) {
-		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
-		if (!ep_func)
-			return -ENOMEM;
-
-		ep_func->func_no = func_no;
-		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
-							      PCI_CAP_ID_MSI);
-		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
-							       PCI_CAP_ID_MSIX);
-
-		list_add_tail(&ep_func->list, &ep->func_list);
-	}
-
-	if (ep->ops->init)
-		ep->ops->init(ep);
-
 	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
 			       ep->page_size);
 	if (ret < 0) {
@@ -753,25 +775,25 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		goto err_exit_epc_mem;
 	}
 
-	ret = dw_pcie_edma_detect(pci);
-	if (ret)
-		goto err_free_epc_mem;
-
 	if (ep->ops->get_features) {
 		epc_features = ep->ops->get_features(ep);
 		if (epc_features->core_init_notifier)
 			return 0;
 	}
 
+	/*
+	 * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
+	 * step as platforms that implement 'core_init_notifier' feature may
+	 * not have the hardware ready (i.e. core initialized) for access
+	 * (Ex: tegra194). Any hardware access on such platforms result
+	 * in system hang.
+	 */
 	ret = dw_pcie_ep_init_complete(ep);
 	if (ret)
-		goto err_remove_edma;
+		goto err_free_epc_mem;
 
 	return 0;
 
-err_remove_edma:
-	dw_pcie_edma_remove(pci);
-
 err_free_epc_mem:
 	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
 			      epc->mem->window.page_size);

-- 
2.25.1


