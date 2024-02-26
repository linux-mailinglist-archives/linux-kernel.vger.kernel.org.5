Return-Path: <linux-kernel+bounces-81287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7494867365
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D00C2879EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A70F200A0;
	Mon, 26 Feb 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="liVJl3i9"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559D1EB55
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947471; cv=none; b=RiUCZ1yoLdO4JfkEXp2pLufSnSXF61ZFNrTHlyIoXOGq6webK//5dy/y5rA+NB3ufWJf3RcDzq3fuftJ66cqb2a5/+OJCI6UwJLKJLOtYP99nO/cGjSdV5Oo0/ogaSw7Ffic8y9dKZ8WuPnAIfgwHXDnM2rx2YWXbr/qIpukkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947471; c=relaxed/simple;
	bh=zN4H7AL9yEWwBMPFUse2kPeWuj9c3TyK31dCtLQBVwU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VyY/WhcrwCU1Z6wcKeswB1KTKxl9c+nmWfVbuHpQkeSPAV/3lWAQTJoKmMhVO1Nb029wN8H6QPjx+9IBymZrySOEZsUQx2Bcbh30FjyDv1LjCkhxt2aqKK8zYwT6ERy5G0/o7jHNPOU2GGqo+BtWdMvl7qdiTu5VJN1TJcH9F5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=liVJl3i9; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-787bc70dfc7so157057185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708947468; x=1709552268; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yOtDU75r2JA5nMqmgqSfs6LZtJBpRoh0ipLmkGMw850=;
        b=liVJl3i9xCmrH9zhq8o1WhqU3jVj4q6wdYxEpJeW9obDIk2gNHciJWvVAcahATIzkh
         lSSPipVAh/+joi7aK0go8IeuKgqaiy2rrxkLhUPiBXlWz02DBdG973xL+aDTtUQMlTM5
         7m2pbIbvmPK2+YNYm8z/3eme2/0V1L2RhQ0yWSq38JAkQWJLsFRl3jn8x0qSfLPnhnnm
         xV5qQnCEE+LbSm9zwwqZo8lG1Jb2Bte+Mt4Q0CX7rj9Lbk6caPZnDQbt+VTbkP+1N+8z
         DwstsUQkMOhLrl5LYE7VN+83ZonmAwF1/weltCnW4GlfyUSBR1NlulaTNMhVCC3Uf9SB
         tYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947468; x=1709552268;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOtDU75r2JA5nMqmgqSfs6LZtJBpRoh0ipLmkGMw850=;
        b=KZ30aIKAFP7tbTkP5YEDBtyA0ahaKKVLfPWXRYFmVSRiWTe+UhIV5gXiRSCePruRAC
         S0sI1BpFL35GfQS29Wl1HZKmwuO4EIyWjZPjdcbeex8UlenLShY0AlGhABK1HpdNMttO
         0kN6xIqN75T16Ke8gNYw7xHpudzKCWhOOfMw2Sg7QIkeS/XAWt/nnzYYUneE8mN9suYW
         9er6fSYuW6Fq6rfnRUAK6PtBiUFux1BoTm/v9CJjqsL51tOygYtQemwv19OyYJ9tDpRq
         DPjNKvSbq8zZpgwtZrj25TdrIvUfdPVdWtCLzXXW3Xunw3Ir+Oe94s8WMZKHnRDmvA/V
         UY1g==
X-Forwarded-Encrypted: i=1; AJvYcCXv/h1pH99Con4d21Vc1oG4eOp+BYbCBOyMDMhU0MTwUGoGjxc1v5V24r90ZFVPqzcfdKsYJCSTXB4cOQqaCVAn3kmY1dTWmZAJcI/m
X-Gm-Message-State: AOJu0YwoCK8cOQtPsjEsAdGsl9gmbReHsUNULls448BqKQrncRbWphO/
	/o+DclOF+vwfftMiRARK5Qftkk0p+BAeaoebQ5ZULBdM2jSFsDVMdgrMf8HeYw==
X-Google-Smtp-Source: AGHT+IHRlLAac3t/t+Ib99/W27Guf/dv3EWDLEDqeS4bxH0DZ+XkVc/0i/w22EDz3k2nxlw6LuR/Kw==
X-Received: by 2002:a05:620a:7f9:b0:787:1a78:fbe9 with SMTP id k25-20020a05620a07f900b007871a78fbe9mr6385524qkk.56.1708947468464;
        Mon, 26 Feb 2024 03:37:48 -0800 (PST)
Received: from [127.0.1.1] ([117.202.184.81])
        by smtp.gmail.com with ESMTPSA id q15-20020a05620a0c8f00b007878babb96asm2341842qki.94.2024.02.26.03.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:37:47 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/5] PCI: dwc: Add support for integrating HDMA with DWC
 EP driver
Date: Mon, 26 Feb 2024 17:07:25 +0530
Message-Id: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPV33GUC/2XMQQ7CIBCF4as0sxYzDqRJXXkP0wUUKJMoGDCoa
 bi72K3L/+Xl26C4zK7Aedggu8qFU+whDwMsQcfVCba9gZAU0mkU9iWCvWsxKmsXnLyRaKC/H9l
 5fu/Sde4duDxT/uxwpd/6b1QSKIwiSROi9Epebhx1TseUV5hba1/oduAdnwAAAA==
To: Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2608;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=zN4H7AL9yEWwBMPFUse2kPeWuj9c3TyK31dCtLQBVwU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl3Hf+ugscH906dxKa1q956AiK7dO/M8tdcr6fT
 aiph35AMmeJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdx3/gAKCRBVnxHm/pHO
 9VIPB/90Qib9s9ybHOJjZTFAzC+LuAX4iTj/eAvrr+mXEaxKJgMyz/Zaxr3LoPGnq9TeHvyOSh+
 rk8EqkZ8yGo+jFjQru/9eO3BCZEAaZQgbP4dgHuLgkKBkUOl91uC1af3moCy9egzAqAnXVcZJ2k
 lgcJf7eOuH+Db/euhh8+4bvApFvNG2KBCWI+e3lP8A4MARip6kPe7hc924+LzcG1RAg2CLJXK6w
 qGIQeCoU/d5wx0OiCOz8HGQpUWTXeTSDOes8m4P9WVTwWHQih8n5oYyZ8DV4yoURYsgxiaE43QX
 O+qByCZy8Q9LEQTmuuv+cv8fJuWCq5nxdUXlYbYny/O34vIw
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hello,

This series adds support for integrating HDMA with the DWC EP driver.

Hyper DMA (HDMA) is already supported by the dw-edma dmaengine driver.
Unlike it's predecessor Embedded DMA (eDMA), HDMA supports only unroll
mapping format and doesn't support auto detecting the read/write channels.

Hence, this series modifies the existing eDMA code to work with HDMA by
honoring the platform supplied mapping format and read/write channels
count.

The platform drivers making use of HDMA should pass the EDMA_MF_HDMA_NATIVE
flag and provide channels count. In this series, HDMA support is added for
the Qcom SA8775P SoC and the DMA support in enabled in MHI EPF driver as
well.

Testing
-------

Tested on Qualcomm SA8775P Ride board.

Dependency
----------

Depends on:
https://lore.kernel.org/dmaengine/20240129-b4-feature_hdma_mainline-v7-0-8e8c1acb7a46@bootlin.com/
https://lore.kernel.org/all/1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com/

NOTE: I've taken over this series from Mrinmay who posted v1:
https://lore.kernel.org/linux-pci/1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com/

- Mani

Changes in v3:

- Collected review tags
- Minor code refactoring (Siddharth)
- Link to v2: https://lore.kernel.org/r/20240216-dw-hdma-v2-0-b42329003f43@linaro.org

Changes in v2:

- Dropped dmaengine patches (Sergey)
- Reworked dw_pcie_edma_find_chip() to support both eDMA and HDMA (Sergey)
- Skipped MF and channel detection if glue drivers have provided them (Sergey)
- Addressed review comments in pcie-qcom-ep and pci-epf-mhi drivers (Mani)

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (3):
      PCI: dwc: Refactor dw_pcie_edma_find_chip() API
      PCI: dwc: Skip finding eDMA channels count if glue drivers have passed them
      PCI: dwc: Pass the eDMA mapping format flag directly from glue drivers

Mrinmay Sarkar (2):
      PCI: qcom-ep: Add HDMA support for SA8775P SoC
      PCI: epf-mhi: Enable HDMA for SA8775P SoC

 drivers/pci/controller/dwc/pcie-designware.c | 74 +++++++++++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h |  5 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c    | 23 ++++++++-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c  |  2 +-
 drivers/pci/endpoint/functions/pci-epf-mhi.c |  1 +
 5 files changed, 78 insertions(+), 27 deletions(-)
---
base-commit: fdd10aee7740a53c370a867b8743a8c8945d1db1
change-id: 20240216-dw-hdma-64ddc09fb30b

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


