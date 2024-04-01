Return-Path: <linux-kernel+bounces-126834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0A3893D6E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783691C21A5D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4A555E43;
	Mon,  1 Apr 2024 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rVVQeIBm"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB87655E72
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986694; cv=none; b=GB9TTQM95OTmvaiYxVdYo3mjJTwom81qLjovRj6N658xTuMdFRHPesEpah9Q19q6moRs5u0Tza19/UfqHuXtBKUlRfcEyrwO01oX5DoD4FbhPTvbY9m/Pu5JnfqKoKCgDM/uyBzpwPuH1T0OhYyGAz8Ao9UbECr2q0cpSC9fLjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986694; c=relaxed/simple;
	bh=nMpZPnhw9L+pUj1D059OFEbCKZXS4KgCBMCDJdioW0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QS5iIQ2j3S/NGS80522wZT9iQKATxZg1EdDuLbAGLweB5FjkgDCpqkY0RaoTZSzAJ5XCi5q4TNOLGgEG9jRAl3BspqhKdx/hvbqfiuBEK2l36qXlYHYCXf3XBEr34TR3toGVJTeqZEIqWW2SCxcO4iEKRcO/vEaK3+FEzXXJxCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rVVQeIBm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0f2798cd8so33392365ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711986692; x=1712591492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=makyLP4le5wSVl0G8mOZnW4dGLqrps4D2r71XeJTz5Y=;
        b=rVVQeIBmwd9GDM9kUxHihd/AJGUZIITwGSXvAO3qd7L0ZUzpMCzsRutVF28ChU2TxH
         8mDTpbcn0f9UAjnFErHb294akOiwWvMUx8XzqsMEIk/ZV1+zz1N0Ze7hz7znBVWrU1tL
         7X5g+cftPrgq4gnyWECo7n2lp3Az1h2ZnifTvyasl0RvRdXcXfCrbis8n05sge8Gxs/a
         FIaJHmjDQBaFdjHZn4bGPjbVw2vESrzKBdDaN/6dad+sEhyb5qGyWhvCrGbZ/1NvVPcu
         XYfkhRiVTGzAOiMh1h++7lIs1k6+atOomWWn9x8GkFaTg3uhQgUadwKUoL7I80yT1U+V
         qs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711986692; x=1712591492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=makyLP4le5wSVl0G8mOZnW4dGLqrps4D2r71XeJTz5Y=;
        b=cIBr635GVfqPqayup/1nfw9Us4OWcNNCwOB51rDnYlFFANJ50rcj3Iai2ngLtLz9bV
         3w+E5K8b02l4IjS3Q3PsJQHRUc0m7wv9urJnMhIeQGr/vHWWiXH7DSy89gs3FmiZXZJi
         2zyIEqz/2ZdkdOzxC8cXXE1am1+EKMv3jXb6fsUBfULzdp3/qhLDh3vKvwgN7d8ZBO6d
         gdrigCy1d8aZdGsSgvJO1urP3ACcBvIcDAzgYzVj76L5aKkZ5G5Pm9EJuOnte3tf0OmC
         UWUm0apL+of4U1FH1GRNUu7p/SQODILUwSusKLv26AdC7+71Qn4D4HrZw3Bo8oDtr6Dv
         KENQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVsO60etRjy0lTMy6xvirej5h+E34+McAU/rhLtK2o/3SBoQbfhwA2cSPpRwJcRjJgyWnyE98qst+p7felefvfXBbmB3+VkHJMxeFj
X-Gm-Message-State: AOJu0Yyim0cMKvOpNlWErt6pLGPetIyahJhoyMgGl/nMMcCbOdGQntpl
	B5OprGH6zKiz9+O9Tw1d6UETjJvGlvFMFlVK0fl/icLxXDgN560UL5kwTd2jgg==
X-Google-Smtp-Source: AGHT+IHuYkm5JMXP6REnNNqu79HonjQ2rY+2E62XKXihjL/57m1yCgv6vHhEwaf3qQo9xV4etiD08w==
X-Received: by 2002:a17:902:fc4f:b0:1e2:54ed:5c5f with SMTP id me15-20020a170902fc4f00b001e254ed5c5fmr3370500plb.45.1711986691849;
        Mon, 01 Apr 2024 08:51:31 -0700 (PDT)
Received: from [127.0.1.1] ([103.28.246.102])
        by smtp.gmail.com with ESMTPSA id kh6-20020a170903064600b001e21957fecdsm8949076plb.246.2024.04.01.08.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 08:51:31 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 01 Apr 2024 21:20:36 +0530
Subject: [PATCH v2 10/10] PCI: qcom: Implement shutdown() callback to
 properly reset the endpoint devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-pci-epf-rework-v2-10-970dbe90b99d@linaro.org>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
In-Reply-To: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1844;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=nMpZPnhw9L+pUj1D059OFEbCKZXS4KgCBMCDJdioW0Q=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmCtfWCU/F5EBeT9Xc6kKS8bi0avjvP5/hATJSX
 6Xt16CcsX2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgrX1gAKCRBVnxHm/pHO
 9a9NB/4gACCmhLBAg0hBUkiwLW1J1dbyKzPeiUuI7Dr8bRC9iEpC+3WlfjzUVbSG7/t+r5XK/59
 zpRMd2CHRveu9TpZva8J+kie6ynO6lb1ht+R+V9g0B+kaOEA150N6p6Sx/S7HabwKSa7tCRjudu
 GVuFNvYLQNV2z4tK4whsZNb+GyYPlnU8aqBnPAU2aU1ow/O3Iucn2keYnBe4EnCF9rB10mBokzH
 MzRH4/qxYjmgMxg2Za3Y6kChv05gMwYJWcp6w5F41uYyIkboJO6DbWdVL6/AEnNt7y5P2gvEPVT
 SJ6NBuehBlYYr0IQVGxb74HOUYDIRBOUnH6F7CdWAD3keYRS
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

PCIe host controller drivers are supposed to properly reset the endpoint
devices during host shutdown/reboot. Currently, Qcom driver doesn't do
anything during host shutdown/reboot, resulting in both PERST# and refclk
getting disabled at the same time. This prevents the endpoint device
firmware to properly reset the state machine. Because, if the refclk is
cutoff immediately along with PERST#, access to device specific registers
within the endpoint will result in a firmware crash.

To address this issue, let's call qcom_pcie_host_deinit() inside the
shutdown callback, that asserts PERST# and then cuts off the refclk with a
delay of 1ms, thus allowing the endpoint device firmware to properly
cleanup the state machine.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 14772edcf0d3..b2803978c0ad 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1655,6 +1655,13 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 	return 0;
 }
 
+static void qcom_pcie_shutdown(struct platform_device *pdev)
+{
+	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
+
+	qcom_pcie_host_deinit(&pcie->pci->pp);
+}
+
 static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
 	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
@@ -1708,5 +1715,6 @@ static struct platform_driver qcom_pcie_driver = {
 		.pm = &qcom_pcie_pm_ops,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
+	.shutdown = qcom_pcie_shutdown,
 };
 builtin_platform_driver(qcom_pcie_driver);

-- 
2.25.1


