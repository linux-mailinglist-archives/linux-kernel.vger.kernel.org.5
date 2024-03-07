Return-Path: <linux-kernel+bounces-95375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45821874CF6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE3DFB21E62
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7743C126F3E;
	Thu,  7 Mar 2024 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="exujJyjb"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF99125DC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809527; cv=none; b=iNDDn1OrgWyOU7MrkvjdonZekybANJ0RxfboSbf//cAfQy5Es8kt7f4fSHjwknpKJVQKqg/7U4nd6USnKfm7IwsI1uxy+aADFqXlyb4pNluMrx9qe70nvDKvIHp9JphgElxJlntFu6o5AnmtB/O4nTiZhk80a847sKV+CkSYw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809527; c=relaxed/simple;
	bh=6yTSMAfIpYgeW5yNePSWCVfZuNVRRhGsUTb2K2VS/NA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PYABpqC+BXQNwmtS5JhviWD311ItgTL1t/vxu4xiXsNEuh/SwDpdpS0062IZVuTbOGCF+2Y8m34J0MnyOYTKwM6qRFCXCoWC6ny2mGTU0ZkcJzq+ChRfw6hHMzcrh6COnWaRGODoqzLqV+oeBbRydPwXdvBzlbVsGAPF7YaMZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=exujJyjb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dd10a37d68so6720875ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709809524; x=1710414324; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eLMXZlB+CaKPKnEBVj6FeQsKz5anAO2cZpP+/8zZPlo=;
        b=exujJyjbLtA5qkZW9qJScGqzbKT0b71fYzh3+KL8j7NMi4TMtuys6kujd/kKYrZRnR
         fY0pRvMGSMw7A19Gp6U+l5AsWQKxw4ZRndmwAlKYW5JazItLExUvyyi1y4nv3Ssiz03N
         GYdkuhh+/7/7zwfpjXfvT1MD3cAEtXmCKArY0+StJc4HUHee8jImHCeLPuhA1jy+lEsU
         Tf+e6+61se67YyLQiONRNoo81Ec3DH1/dAOJq3xcLvXPe4YJOIZjtx61h6XNZTmxGIC6
         D6Im9RZOAbWOsEYmHWa2Cw21F60JrP3advNDBAX9Tz8Cwkr8j7uiPk2JegRyZLe25WvC
         Mwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809524; x=1710414324;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLMXZlB+CaKPKnEBVj6FeQsKz5anAO2cZpP+/8zZPlo=;
        b=Q7hioRBp5YWekuM0uvnSZ4SbxwmZp4NrmVZQH0VwDP7HyzqYo5jnmmJ9g3gNgWpLnJ
         KuVNl0hBnppvYCbp2cDGnK34c8/PqmqGdKqQl+0/KSOShHmwOv8lAw+W/X4YA3j6oOak
         MWm2VqQQzkWPRqCmniJ0g71gGyxEl5WYHI99NG/q2qs0gO/j3Iyy9pTcnndtqx96XCVB
         7XtsHcOjRKDKmce3AmPdR4gftveqonp49b9cJNTuU9JQU6spd3goQ+Wahv3C7xM3X5LN
         3S1Otw2L2Je9aRMkrcwZrf8ve3P53iBx++73zRQljl71inxWbbXNeC3aetd533Xm9Szh
         3i1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXFTDQHsd0rubHqw9qr5RekkGPOVMpW93n4NQkIDkZU24bD+4bvJT8BJvw9kq7FxDdftDeGDOmQ0IcbbQeT6DS6w6zpa+phcx0CHSC
X-Gm-Message-State: AOJu0Yx8KKw/nyph0/IvB8JhcZNlHk5FZ6kgPaxtb6kc0lqOmRKaQh3w
	U9V9RxF0j/zHg3DC6GIO7skyRNO6ze/izSMN3wwKoeu7yspUYEXhNm3ot3oikQ==
X-Google-Smtp-Source: AGHT+IGU7HJBm48LhGfSPEdeJYWaDuhk3eBYJjxe7bJK2cIqvGwhefT53ZZKZibiE/Fhi1oUoHRhog==
X-Received: by 2002:a17:90a:8544:b0:29b:200a:9b80 with SMTP id a4-20020a17090a854400b0029b200a9b80mr14926811pjw.2.1709809523767;
        Thu, 07 Mar 2024 03:05:23 -0800 (PST)
Received: from [127.0.1.1] ([117.217.178.39])
        by smtp.gmail.com with ESMTPSA id cp20-20020a17090afb9400b00299e946b9cdsm1305785pjb.20.2024.03.07.03.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:05:23 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 07 Mar 2024 16:35:15 +0530
Subject: [PATCH] PCI: qcom: Enable BDF to SID translation properly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-pci-bdf-sid-fix-v1-1-9423a7e2d63c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGqf6WUC/x2MSQqAMAwAv1JyNhCr4PIV8aBJqrmotCCC9O8Wj
 zMw80LSaJpgdC9EvS3ZeRSoKwe8L8emaFIYPPmWGurwYsNVAiYTDPYgDyw9E/lGCEp1RS36P05
 zzh9RTEGUYQAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3426;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=6yTSMAfIpYgeW5yNePSWCVfZuNVRRhGsUTb2K2VS/NA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl6Z9v1EDKrV69oCW0WMoRHu6XexGldpVsbiJEq
 qbdTaELRCaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZemfbwAKCRBVnxHm/pHO
 9VE/B/9bynRoqgU8SObMiNt5QbGoGwvceANwJK4eCRIdeBn5Sabs+ywHmOxTlf7DeStkMH/kigp
 y8ZBgUiuwMJY0JtEZJ8hCJk+Ydh23io5iAjwvzO2gGxPVqAQt32ffS/SeTL33+WuFY0koBCuaQA
 Y6BRT/aSyKb6s40VnplnEzT4Qd8LZnfUmUhg+FKsUoRreN+ASeKIe65pRZtMbGwGaiojO6q4u6Z
 aduet1+/PPtCmIHKH+Xjw4DK3AedUPohGzwM3md94v5zfiHlKJpebzclJJZug7aHEPKeEm7gRP5
 /Bom9ygj87U2rDjrzSBAXIUbYcHwj3HXt3vfywdpwDoUbaKO
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Qcom SoCs making use of ARM SMMU require BDF to SID translation table in
the driver to properly map the SID for the PCIe devices based on their BDF
identifier. This is currently achieved with the help of
qcom_pcie_config_sid_1_9_0() function for SoCs supporting the 1_9_0 config.

But With newer Qcom SoCs starting from SM8450, BDF to SID translation is
set to bypass mode by default in hardware. Due to this, the translation
table that is set in the qcom_pcie_config_sid_1_9_0() is essentially
unused and the default SID is used for all endpoints in SoCs starting from
SM8450.

This is a security concern and also warrants swapping the DeviceID in DT
while using the GIC ITS to handle MSIs from endpoints. The swapping is
currently done like below in DT when using GIC ITS:

			/*
			 * MSIs for BDF (1:0.0) only works with Device ID 0x5980.
			 * Hence, the IDs are swapped.
			 */
			msi-map = <0x0 &gic_its 0x5981 0x1>,
				  <0x100 &gic_its 0x5980 0x1>;

Here, swapping of the DeviceIDs ensure that the endpoint with BDF (1:0.0)
gets the DeviceID 0x5980 which is associated with the default SID as per
the iommu mapping in DT. So MSIs were delivered with IDs swapped so far.
But this also means the Root Port (0:0.0) won't receive any MSIs (for PME,
AER etc...)

So let's fix these issues by clearing the BDF to SID bypass mode for all
SoCs making use of the 1_9_0 config. This allows the PCIe devices to use
the correct SID, thus avoiding the DeviceID swapping hack in DT and also
achieving the isolation between devices.

Cc:  <stable@vger.kernel.org> # 5.11
Fixes: 4c9398822106 ("PCI: qcom: Add support for configuring BDF to SID mapping for SM8250")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
I will send the DT patches to fix the msi-map entries once this patch gets
merged.
---
 drivers/pci/controller/dwc/pcie-qcom.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 10f2d0bb86be..84e47c6f95fe 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -53,6 +53,7 @@
 #define PARF_SLV_ADDR_SPACE_SIZE		0x358
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
+#define PARF_BDF_TO_SID_CFG			0x2c00
 
 /* ELBI registers */
 #define ELBI_SYS_CTRL				0x04
@@ -120,6 +121,9 @@
 /* PARF_DEVICE_TYPE register fields */
 #define DEVICE_TYPE_RC				0x4
 
+/* PARF_BDF_TO_SID_CFG fields */
+#define BDF_TO_SID_BYPASS			BIT(0)
+
 /* ELBI_SYS_CTRL register fields */
 #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
 
@@ -1008,11 +1012,17 @@ static int qcom_pcie_config_sid_1_9_0(struct qcom_pcie *pcie)
 	u8 qcom_pcie_crc8_table[CRC8_TABLE_SIZE];
 	int i, nr_map, size = 0;
 	u32 smmu_sid_base;
+	u32 val;
 
 	of_get_property(dev->of_node, "iommu-map", &size);
 	if (!size)
 		return 0;
 
+	/* Enable BDF to SID translation by disabling bypass mode (default) */
+	val = readl(pcie->parf + PARF_BDF_TO_SID_CFG);
+	val &= ~BDF_TO_SID_BYPASS;
+	writel(val, pcie->parf + PARF_BDF_TO_SID_CFG);
+
 	map = kzalloc(size, GFP_KERNEL);
 	if (!map)
 		return -ENOMEM;

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240307-pci-bdf-sid-fix-c9cd8c0023d0

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


