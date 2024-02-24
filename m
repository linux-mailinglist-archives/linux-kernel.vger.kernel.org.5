Return-Path: <linux-kernel+bounces-79493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4B1862334
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37091F20FBA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 06:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8C11AAD7;
	Sat, 24 Feb 2024 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkeXl0Jb"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9CF24B33
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708757763; cv=none; b=TYn0xjORc1416VVIn+YP8bUDMD4r+5z26VdLRsJvMz7D9CE4/iuFFTSEgGhHNN8gQxdA2SvD6ykHJF1gYFVwWEfXpVIo+w3Su3xopvjkQmgbSmp1n4+1rFvH6ZxEAaejSZphH2J71j5JeFxZHjVe7o/ZSPIvO8JA45tvQ+Clo98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708757763; c=relaxed/simple;
	bh=lMx8jaitSygvuxgneq9A64SvIefKCHyxvtG/ZW2Dw20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZ6Ctcmj6R3GrhH7FNtH167/qXG7oNgVMxMI03E0ZAMEvtdLZc3+LZlF5h9+HZOqbwxhwZ7+HYOLIdw+JvNO41UGYV9jwr9YW7nKAl3Xsm01DIjfXAmcpn0E234S1eghcAFAt0l3JKns6Z+/z+QUNLL+0WPaeaDk5TFFT8F6iWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZkeXl0Jb; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso1393428a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708757742; x=1709362542; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWp8V5CHI0uxSxSBbNBsR7PWeN0w7yn0quv2v4HN+ko=;
        b=ZkeXl0Jb+MJlnGoDqdBJhCYyv1tqdkC1+tRTOLbAbyd8qUcdNJ4lv6WYw3g0B/n8AD
         gynYStUEBAWy9Lohy22jcD9zi6GqVU0f/nzNsCnIm6Yus280HgPgpDxWTiJxLH0NGSYY
         0nTsj4joRwPCBLOgEtwGjSfNazPfKxNhoCq2fg9IOnYfY8pWQMH6CNUtv0OueyiOw/v1
         pYgB1aJ5QF5c/8wGzkgFSUQYcM9WQHNa/o2k3bvg70F39dQPka8IN+8vhdXudS7VzfOh
         3kNJkQC164PPdLehzff51YzILCa3FmjJLMWXOBPfqPA0DNy39jFdXSkaOmtABqf8SRos
         Jc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708757742; x=1709362542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWp8V5CHI0uxSxSBbNBsR7PWeN0w7yn0quv2v4HN+ko=;
        b=V9q7I7amgjFN5j9SWV+H4k7Vvmp1qZBX31FK8A9y2+9j6z0O6JCEawT5bW2PpZIttn
         3oOTGl1Z3nQ8ymZ2i20kp9cCYQvvtgX+fa+4obgRPN6Iexd4ffRyAfwaEBr6LoeqrwXh
         CBQXrkUvbrJfU4yMgLV2mYDnmNt7+70aK9aP62Uvc0/914vhFqSyDDk9OtJsdOMyEGLv
         rA/6+7+e46kt7R4Mi1Bs9jQinfdktqGuPPrn8kK+HajDE/pdtkl9c010o624z5tGJEww
         s7z2d+uzZ3OjPm29fqujMHHOuhzBDaschCM8PQYDeinNMJ5eWCo90c9uy/RukjptP8kV
         X6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUBvU07AA1xnJkfloLq/EAbmDRVUHhccYk9VL3L+XjmdOYY8oPsqwf6XqBTwTgOLL9oL5dquaGvSt8oaiwgr5XpU1sbud6UZUsieeGW
X-Gm-Message-State: AOJu0YyfklqeZo1thmRVCFT1EndDkavBo55HP5cGvKHw+0XOfZSeGFWF
	mYClTl+qyKGlm5uw7ofrvTIxxOgAvBP9i+3mFdBXTQV8WLc5LHPuDsJC7SnA2g==
X-Google-Smtp-Source: AGHT+IFIskgaUGsMeIsmD3wiZleHjPkQUC5UtWw1p5Y1MMAUTOUlX+m9mazTIw4TXKmo+YHlNBnbOg==
X-Received: by 2002:a05:6a00:929f:b0:6e2:84fd:f1fa with SMTP id jw31-20020a056a00929f00b006e284fdf1famr2371986pfb.27.1708757742305;
        Fri, 23 Feb 2024 22:55:42 -0800 (PST)
Received: from [127.0.1.1] ([120.138.12.46])
        by smtp.gmail.com with ESMTPSA id r5-20020aa78b85000000b006e4cb7f4393sm502932pfd.165.2024.02.23.22.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 22:55:41 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Sat, 24 Feb 2024 12:24:15 +0530
Subject: [PATCH v8 09/10] PCI: qcom-ep: Use the generic
 dw_pcie_ep_linkdown() API to handle LINK_DOWN event
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-pci-dbi-rework-v8-9-64c7fd0cfe64@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=lMx8jaitSygvuxgneq9A64SvIefKCHyxvtG/ZW2Dw20=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl2ZKYYNXTQqfakMhAc2cB0T7CbXovjsrJ1sBzi
 8zlVkSivSSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdmSmAAKCRBVnxHm/pHO
 9cmyB/4qQE8r3RLSi2d/HtaZZLx8MEt1MwfmzXRoVQvk0BpZk52ucQfYu9tPZHtvn0QhqaeguMG
 kHvpOq/OjK6ysW9Mz9sksSLuftRowU+M/XSD5auWFruzs+MttLNgKNQ+42pc+8/zaQWqqrWsIqm
 rTNN6OWSBX2S9AXzHQrGuye7rAP7yNqGKkz49WYveJ7BuIwOumJ1qYjSXZ6ivJotKM30t7m3IuC
 nFvuH4vEiySlwwuD7OyQLZI5Zc5WQC0TdoFhLKX/170qukRMqF5jK9ngyp750FYG7zK71N2lU5A
 cdKGTDKtlqjjQuKRQBcEFzzYW037RMl2AedyC9A5V0SNMvMe
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Now that the API is available, let's make use of it. It also handles the
reinitialization of DWC non-sticky registers in addition to sending the
notification to EPF drivers.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 2fb8c15e7a91..4e45bc4bca45 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -640,7 +640,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
 		dev_dbg(dev, "Received Linkdown event\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_DOWN;
-		pci_epc_linkdown(pci->ep.epc);
+		dw_pcie_ep_linkdown(&pci->ep);
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;

-- 
2.25.1


