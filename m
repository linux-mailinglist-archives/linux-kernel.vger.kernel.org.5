Return-Path: <linux-kernel+bounces-150030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66BF8A995A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131E61C21A68
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D372F1635CC;
	Thu, 18 Apr 2024 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="niV/MlKC"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3DC1635B5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441565; cv=none; b=R/ffomDpui/EOzf0JgCEhi4nhuXBWQZFAUT/IAeSTcXhaeRPX2fM4rRVX+FXsrshRNRJAAgGnKBTE4HsBv6VGi1Inx/RHyUaxAoZvmC8/aBGW5+kI1lwcVng2zZfsVvWNCpdYu+2GlArmix2+uVU3Dk4z8uvHnRoop34IzfU4Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441565; c=relaxed/simple;
	bh=atG+1UQfYDhhLUGqdEx8VNjGeYLNZVix4fHyruhkqxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N4F8bjZXRDR0cdf1aWFOl8nxGRs7k2r5qh3yle+isJ2198akP59QpQYnXj1VZyuZCJtf35faPAaZgNMESK7Fb6nkFa15I/RNCPaTjeQWIDMZQkeiQbnirWKKkzNDn8e71FShaf8O5wmWYZowVRtc4XJy90NBNfctphcDrIwU9SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=niV/MlKC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso495824a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713441563; x=1714046363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAcw7E8oN4uVzIUIOF8pEddwwqX+D/yCDKw3KFfwl3A=;
        b=niV/MlKCR+1P9tc/sIrs+Fy5eJOgk+oTXiUN1cwGxK1sn9VxIv8yq/jz0SxfWwSOr3
         o/yc2ps4VcValhNGHj9H2biMtVuCkO+V28ZgyHF/yo6tQwl0jnRRp1lTF1EsIQc37aSl
         34jz9KhsyecYgZSJJKacPRmJ4lzeYDP4n9+EIuwH5C19aNcY6EzYon0mqYKuz0dQk7rm
         1IhF57tbg1+TJeETQcdHnnPnplknMvLvNv/CyU5Sq3W+7fZ3t3YPGcTddMc6uxSO2Trz
         AHuvv143vrBk6ssQD1VLm8xIt+aO+VgPWNFmCmmIMwW/+ubtRQXpr3na8tOd/oFMhX1Z
         Btng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441563; x=1714046363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAcw7E8oN4uVzIUIOF8pEddwwqX+D/yCDKw3KFfwl3A=;
        b=h1VpxZ7jrTLRD/hkWXl0NLrj+EiWpOaTkiK0x7Ll6OMMyeQ8oGFb35KWoSUI/ZZC+q
         MIWhLoNqMTXgnfw78R01zN8+C8vSaAb64cxxW65f2mvFcQ5/iJMYYNBSpCsLihM/keCG
         72R7kAqk7UJtMvIuZ0pWCBCO1aBgFp6Ddku7OArdB++dr1JoTNcKKf/X7W8MQgsPRblh
         8QwSavR6tXaqiKr6dXv2CzoXBNdm/Nm5V8DYTI3tH78CVhoITLQz3OQbFcv738IaC64r
         uw1NbPa3mwLpQANvToW+v4YI0Tug3BHjARK2J5dlMN2O9WvE1xdkL37I1XLLohvp/cHz
         OlcA==
X-Forwarded-Encrypted: i=1; AJvYcCWTTjjYrMa2vT0T+vWZH9RkLGrgMD51JIYG9yrJJf9OpS0o/5H/KN3cmhwD5Zkg4y0nW0Zh3XiW5+ET17AGuD0l7ZXqRPHDubBUwmYl
X-Gm-Message-State: AOJu0YwvOTvVSrokJjPee/F/wwwj3MLXzMVVmdj0y0FQ7Qc11nBwgJ/Z
	gQ5YMPNi8jmazHWeP7vVSfUM+JOqI09RRQX/93JDcppqukV7vxXTxR7Z3yHh0A==
X-Google-Smtp-Source: AGHT+IFSqDRaCBSoo8BoGX0u04qMirP3lQLymca/l6FmNsm3RAtW1htgucW5/5eUyGEsvsCQ6dtGbQ==
X-Received: by 2002:a05:6a20:840b:b0:1a9:c80a:bdcf with SMTP id c11-20020a056a20840b00b001a9c80abdcfmr3613106pzd.2.1713441563006;
        Thu, 18 Apr 2024 04:59:23 -0700 (PDT)
Received: from [127.0.1.1] ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id ei16-20020a056a0080d000b006ed06c4074bsm1305512pfb.85.2024.04.18.04.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:59:22 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 18 Apr 2024 17:28:36 +0530
Subject: [PATCH v3 8/9] PCI: qcom-ep: Use the generic dw_pcie_ep_linkdown()
 API to handle Link Down event
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pci-epf-rework-v3-8-222a5d1ed2e5@linaro.org>
References: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
In-Reply-To: <20240418-pci-epf-rework-v3-0-222a5d1ed2e5@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=atG+1UQfYDhhLUGqdEx8VNjGeYLNZVix4fHyruhkqxw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmIQrzQyeOnNXefT1bfI+O0Ma5JSu9+usv5cm9J
 cAHRmpaedqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZiEK8wAKCRBVnxHm/pHO
 9RfIB/9uJMQCz4cdPaw2Hh9qei43flPkHVNyX2jDTngRHx+E6VSEifEhd5QFCmbUTanNcwV3VTA
 2eUwRNH3tOOSw1HUe6yJ1qM2y39VllyIOYTzopkC2CN+j8I11D5d+YBJ7ydVmtc46YvtZktz8v5
 JcdJVPjyeyIvyoxUaeiS2uoq/VE2v0acmKeM+uL5WncmPIaVq9lACPEN26KT5EOZZA3Jji3im4D
 yWu0AA8sQs+Z5JSxFpZHgVgytKegpBBjBkcd7LCIDHxB+1tvX/OGMyclZw7csNmal2n7HP0OYff
 //jFit6t/Lc+9VuatbccvEgxKt+tRT2hHloWbJbNnLJWCKCI
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Now that the API is available, let's make use of it. It also handles the
reinitialization of DWC non-sticky registers in addition to sending the
notification to EPF drivers.

Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 458145d1f796..96f5acdc9317 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -635,7 +635,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
 		dev_dbg(dev, "Received Linkdown event\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_DOWN;
-		pci_epc_linkdown(pci->ep.epc);
+		dw_pcie_ep_linkdown(&pci->ep);
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received Bus Master Enable event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;

-- 
2.25.1


