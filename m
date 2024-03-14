Return-Path: <linux-kernel+bounces-103477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3FE87BFEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93FD7B20F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6419673512;
	Thu, 14 Mar 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSWncbYd"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E5B71B5D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429859; cv=none; b=LQw0LsWqiiIGgzFNVqFT/AcF3uoWls0F1iNpdRJarOlvNkVVWqkli+AqgOrEA9wUc6Rihn7d/4+WDe/hZgAPlEiSCOgTVtek8AKtUD06QO7NlNYlv+ySLLES4TEgJMh6kq7jX/HLB88JpKpWVBXUvvLjajW2DyceRrDIjpxUfuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429859; c=relaxed/simple;
	bh=9R/4BRcR5YWjVx8HSWtHp3tea3KFcjiGJn6zOJW2sDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NeLtTJZ53uc/WyVe+vys3jD5pouPWuQ93HHV5FosajynOzD6KyW/W+0fNY4EduqTREYPP8uNNmOTjQZ0g/SWoZCV3SDcV44OSfrVLcoO0eVRB1+0C46xfIAYFqbw9DODtDXfHTtmZxQHZu6JC/ToLakYKSdzk4ylO5XuZBZ6dVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SSWncbYd; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a1cf769452so556459eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710429856; x=1711034656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEWUsK3WjK6B5cd6Lu/XIj57FaZ2PiCBZt++wpc0fHs=;
        b=SSWncbYdzjdBHF22ewVSvs8847+tk94jHWIC08SXJVlzz9HifGytuMWCGlKO0VcClN
         b5JOqzfsq6Fms80/l/Xae1ukTWFdMOadmcbvZVuon9tm6sDAU3vKavG918gs+10z5j1g
         HmkWZ/ppxEFZF4v/PiJ5CY79q+sdw6PY56m6BZ5R66JWTehE+UdVCiFN9AIBqWPMPvJW
         zKw5qfXSQh4D61xbn3UunRw8JPDGlaWIPonPNNp02bHYjbGnRHP3ASHug88WkNK+3dj1
         eFyHsQm/gaMDNY3dX5M5ldf7B5gqNJXMeTamu5PiF4x+079VAhKg7+a6rfGy4Fvm1Z1f
         ACsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710429856; x=1711034656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEWUsK3WjK6B5cd6Lu/XIj57FaZ2PiCBZt++wpc0fHs=;
        b=rnfZNh/FBGkI0tvhK/1lMo5LfnlLS0io4MQ88g0yapZ2N7tQZC/jpG82BM3nggr/q5
         BRot+UT1FZrqFroLlaEMHPZyguBHAFqtyXVkhrbLOt4DXMLc+b87IMKsUrPCLjRFVnY4
         QybDStZf7K5kMfNeP+SFk8zp7ybxMVY2omhvK2M+x0D2yqlCGkBDMdg+QSg1uulDsVe1
         yOTLMSoXKs8XlqpCY2KY+G4C1FoFhftgp/T/TypgKERkTmXUgl0kc6roFnLLug5CEayv
         kg4iH12iHo0Nfn8fP0tB9BV3xLbsUHRTWwChNnNq2IFhHTZWTagDaJXjqBBMiTiCOlx8
         ASdg==
X-Forwarded-Encrypted: i=1; AJvYcCXJkHgvGlnPr/jq+WXzk/eD02HjZeWPpyPURbfYLyZPiFkc4IChughY+fNL9QGQEUmkBDaJFUaTMl58IjecGZ631Ei3aqlPUWycPXBC
X-Gm-Message-State: AOJu0YzpyK/2zuEdssewEanPJO0rz5XRCGf1be9HqxXCwflrtSgXDs6I
	A2RD/5UTzwGkwEfoe+SLHiUMph4BI/kILIRM8DwCM9xGeXjoc5dbDR4IPf3ttw==
X-Google-Smtp-Source: AGHT+IHP8NMJaf/7kaBlz1m3NjEaEUbyEINYKTdtRwykSNpv+uyLAP+YGybVOzt6HovdxEZEpbwkDA==
X-Received: by 2002:a05:6358:5304:b0:17b:f2ae:e561 with SMTP id n4-20020a056358530400b0017bf2aee561mr1971178rwf.30.1710429855405;
        Thu, 14 Mar 2024 08:24:15 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id m4-20020a63ed44000000b005e438ea2a5asm824021pgk.53.2024.03.14.08.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 08:24:14 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 14 Mar 2024 20:53:41 +0530
Subject: [PATCH 02/11] PCI: endpoint: Decouple EPC and PCIe bus specific
 events
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-pci-epf-rework-v1-2-6134e6c1d491@linaro.org>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
In-Reply-To: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=7165;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=9R/4BRcR5YWjVx8HSWtHp3tea3KFcjiGJn6zOJW2sDQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl8xaOuI/id1EPmdXTpkB5hTosPO+3YkDwNzT9O
 1dki8CaNoSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfMWjgAKCRBVnxHm/pHO
 9fsmB/93d2Eg2EacntW52OJYEoBdX0WLgtZNSEzX1D0kPl5iX16uh0+yADrvlrovh25+G7nAacY
 fqlS6Fv2Dki5ph34J/GVCyP+LrBCAN0mmq7jiGkdWdGN+k0Y6r4rzoA9iol7838nAVqpCT3Sk36
 IuM5OpXw0a6uZT1s7D9AtjlQtiW9+UQwV8jTtfmnTQdXxOOQxZHyYF0BY8oNqocbn9t0x60FYkH
 /7gUOUj4q2xtrLPulTU7VeC/yFoxBtA8jUBj0peqvHrPt+3rNKS37mcA4Pl0w2n0KZYxFznRKOg
 DCEoLrM8hFzLkBiSpuiI/U3nCEDt1slSRYcCmFyl2IbUZf7K
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Currently, 'struct pci_epc_event_ops' has a bunch of events that are sent
from the EPC driver to EPF driver. But those events are a mix of EPC
specific events like core_init and PCIe bus specific events like LINK_UP,
LINK_DOWN, BME etc...

Let's decouple them to respective structs (pci_epc_event_ops,
pci_epc_bus_event_ops) to make the separation clear.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c  |  8 ++++++--
 drivers/pci/endpoint/functions/pci-epf-test.c |  8 ++++++--
 drivers/pci/endpoint/pci-epc-core.c           | 20 ++++++++++----------
 include/linux/pci-epf.h                       | 23 ++++++++++++++++-------
 4 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 1c3e4ea76bd2..e5d67aec7574 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -880,8 +880,11 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
 	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
 }
 
-static const struct pci_epc_event_ops pci_epf_mhi_event_ops = {
+static const struct pci_epc_event_ops pci_epf_mhi_epc_event_ops = {
 	.core_init = pci_epf_mhi_core_init,
+};
+
+static const struct pci_epc_bus_event_ops pci_epf_mhi_bus_event_ops = {
 	.link_up = pci_epf_mhi_link_up,
 	.link_down = pci_epf_mhi_link_down,
 	.bme = pci_epf_mhi_bme,
@@ -903,7 +906,8 @@ static int pci_epf_mhi_probe(struct pci_epf *epf,
 	epf_mhi->info = info;
 	epf_mhi->epf = epf;
 
-	epf->event_ops = &pci_epf_mhi_event_ops;
+	epf->epc_event_ops = &pci_epf_mhi_epc_event_ops;
+	epf->bus_event_ops = &pci_epf_mhi_bus_event_ops;
 
 	mutex_init(&epf_mhi->lock);
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index fc0282b0d626..751dab5799d5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -813,8 +813,11 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
 	return 0;
 }
 
-static const struct pci_epc_event_ops pci_epf_test_event_ops = {
+static const struct pci_epc_event_ops pci_epf_test_epc_event_ops = {
 	.core_init = pci_epf_test_core_init,
+};
+
+static const struct pci_epc_bus_event_ops pci_epf_test_bus_event_ops = {
 	.link_up = pci_epf_test_link_up,
 };
 
@@ -959,7 +962,8 @@ static int pci_epf_test_probe(struct pci_epf *epf,
 
 	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
 
-	epf->event_ops = &pci_epf_test_event_ops;
+	epf->epc_event_ops = &pci_epf_test_epc_event_ops;
+	epf->bus_event_ops = &pci_epf_test_bus_event_ops;
 
 	epf_set_drvdata(epf, epf_test);
 	return 0;
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index ba2ff037dfa6..f602f08a11a2 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -697,8 +697,8 @@ void pci_epc_linkup(struct pci_epc *epc)
 	mutex_lock(&epc->list_lock);
 	list_for_each_entry(epf, &epc->pci_epf, list) {
 		mutex_lock(&epf->lock);
-		if (epf->event_ops && epf->event_ops->link_up)
-			epf->event_ops->link_up(epf);
+		if (epf->bus_event_ops && epf->bus_event_ops->link_up)
+			epf->bus_event_ops->link_up(epf);
 		mutex_unlock(&epf->lock);
 	}
 	mutex_unlock(&epc->list_lock);
@@ -723,8 +723,8 @@ void pci_epc_linkdown(struct pci_epc *epc)
 	mutex_lock(&epc->list_lock);
 	list_for_each_entry(epf, &epc->pci_epf, list) {
 		mutex_lock(&epf->lock);
-		if (epf->event_ops && epf->event_ops->link_down)
-			epf->event_ops->link_down(epf);
+		if (epf->bus_event_ops && epf->bus_event_ops->link_down)
+			epf->bus_event_ops->link_down(epf);
 		mutex_unlock(&epf->lock);
 	}
 	mutex_unlock(&epc->list_lock);
@@ -749,8 +749,8 @@ void pci_epc_init_notify(struct pci_epc *epc)
 	mutex_lock(&epc->list_lock);
 	list_for_each_entry(epf, &epc->pci_epf, list) {
 		mutex_lock(&epf->lock);
-		if (epf->event_ops && epf->event_ops->core_init)
-			epf->event_ops->core_init(epf);
+		if (epf->epc_event_ops && epf->epc_event_ops->core_init)
+			epf->epc_event_ops->core_init(epf);
 		mutex_unlock(&epf->lock);
 	}
 	epc->init_complete = true;
@@ -772,8 +772,8 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
 {
 	if (epc->init_complete) {
 		mutex_lock(&epf->lock);
-		if (epf->event_ops && epf->event_ops->core_init)
-			epf->event_ops->core_init(epf);
+		if (epf->epc_event_ops && epf->epc_event_ops->core_init)
+			epf->epc_event_ops->core_init(epf);
 		mutex_unlock(&epf->lock);
 	}
 }
@@ -797,8 +797,8 @@ void pci_epc_bme_notify(struct pci_epc *epc)
 	mutex_lock(&epc->list_lock);
 	list_for_each_entry(epf, &epc->pci_epf, list) {
 		mutex_lock(&epf->lock);
-		if (epf->event_ops && epf->event_ops->bme)
-			epf->event_ops->bme(epf);
+		if (epf->bus_event_ops && epf->bus_event_ops->bme)
+			epf->bus_event_ops->bme(epf);
 		mutex_unlock(&epf->lock);
 	}
 	mutex_unlock(&epc->list_lock);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 77b146e0f672..1271e1e00bbd 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -68,14 +68,21 @@ struct pci_epf_ops {
 };
 
 /**
- * struct pci_epc_event_ops - Callbacks for capturing the EPC events
- * @core_init: Callback for the EPC initialization complete event
- * @link_up: Callback for the EPC link up event
- * @link_down: Callback for the EPC link down event
- * @bme: Callback for the EPC BME (Bus Master Enable) event
+ * struct pci_epc_event_ops - Callbacks for capturing the EPC specific events
+ * @core_init: Callback for the EPC initialization event
  */
 struct pci_epc_event_ops {
 	int (*core_init)(struct pci_epf *epf);
+};
+
+/**
+ * struct pci_epc_bus_event_ops - Callbacks for capturing the PCIe bus specific
+ *                               events
+ * @link_up: Callback for the PCIe bus link up event
+ * @link_down: Callback for the PCIe bus link down event
+ * @bme: Callback for the PCIe bus BME (Bus Master Enable) event
+ */
+struct pci_epc_bus_event_ops {
 	int (*link_up)(struct pci_epf *epf);
 	int (*link_down)(struct pci_epf *epf);
 	int (*bme)(struct pci_epf *epf);
@@ -149,7 +156,8 @@ struct pci_epf_bar {
  * @is_vf: true - virtual function, false - physical function
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
- * @event_ops: Callbacks for capturing the EPC events
+ * @epc_event_ops: Callbacks for capturing the EPC events
+ * @bus_event_ops: Callbacks for capturing the PCIe bus events
  */
 struct pci_epf {
 	struct device		dev;
@@ -179,7 +187,8 @@ struct pci_epf {
 	unsigned int		is_vf;
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
-	const struct pci_epc_event_ops *event_ops;
+	const struct pci_epc_event_ops *epc_event_ops;
+	const struct pci_epc_bus_event_ops *bus_event_ops;
 };
 
 /**

-- 
2.25.1


