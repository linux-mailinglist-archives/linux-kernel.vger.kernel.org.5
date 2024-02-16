Return-Path: <linux-kernel+bounces-68101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BBA8575FF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F0C1F236F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A5F14A99;
	Fri, 16 Feb 2024 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="KjyM5UKr"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7829914285
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708064756; cv=none; b=rUUf9rECn8w96HGkc1p7jvILEjuY9iWVby48f8uKUKMj5k1iaeE5PA62HWveUJAS6nQzRaaq4lsjPoCl8JEKg9kWmdlyguhPIOr41ou/PiIM+0Pg+0d3fIKo4M//TO18I7ptDgQ4ZkWBmciyxGaBd3fegpB9NLFw6HL90cCKsB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708064756; c=relaxed/simple;
	bh=KivuariFpPolApka+H/P0dLLds23Rk9TayxJQuSEfUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSrk+YLoIuZjw92J8BfE4AxiQlEzm3a4cISqABUSuoTCdNzqi1NeAFzk0tAueqYPPaCuSHfSRbXCKv4hgvCi/ZqqE7LI3BCjryaIUkexvAXgi7hTtJfnRIPIr+CTEcLoScwgWA7VUQCMa2LhNeLsPCffuV0cwzSPmAPUU7b4/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=KjyM5UKr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d73066880eso16131485ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1708064754; x=1708669554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=go9pnzcnTe/ILY9pnIwCtci+zv9qwK5zq4OGjkRdcEg=;
        b=KjyM5UKrCBnBUsAhPJf5Qq1h/eDoGCJdjpJveuH8aW0mNYx0SNyaQHbJoSXLhVNq+0
         Yfa9AWpWtC5n0cs2pJhRYeVMwNHq1X3DRbzYLXc2/oVkVGaPgRAEze0oGxaSAEjblFpA
         1CimS/2Ldj/K6VIBBvL0ynaNYRSrNTVlNJ43bRYnWT5Pjr3mQ8B4IaJTzB85EsnsXr2e
         0aotyhvG/5OZWWmSl3UxpflJpcyuX7G4Ve0CARJsChC188jJRTaIqtXoKeXRUKRRRsxO
         JBz4OQQ7ZlfdtBGPr46YREVjYeqgCJ2vPocNn/9dJCRglxRTtomqSiUJKG9CQnisFHoP
         AX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708064754; x=1708669554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=go9pnzcnTe/ILY9pnIwCtci+zv9qwK5zq4OGjkRdcEg=;
        b=Bv/p1iIEN45tVeXmJIufDURWY3JodQE7OFeWZ2V9LtoJLWvXWewlba7JCdLndHPDbL
         4Re5WylHq8hUTVrFbE8neozc7+ybzEfj0Rf+Rhtm7syLxdXbCGJ00Mdi4vHDjcyUvYS/
         3DTLPDbLUZ2Nt+6fAfX/lsg2MZntFsAFIrlV3nb/5SNrkWMpHS9QnB82Il1xprJNH9HZ
         GZz9dK93xib4QIsZ1fTq+92gmjuZtoxRBX+gqtc5xnpMj5sw3vPm6bMQBV3qMTn6eOJC
         u1XixAxqTj67e0JAFu//fYzBT+MKYR8LPIkkB83shUGjn45zsN/EUXYnvgw5MwYmmLAu
         NcoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvlcFAe/KtJy4f15fSpqOK/m5Qk6jZUCiaWMtTVUQtHPrsWGPiUuiTD2lCwQ+5gyI29hElhQVMi5flnbpZw3tsaKwZOsnr0a0zWK8C
X-Gm-Message-State: AOJu0YzmleIuZ4u04gNYT98/mZ7Mqd78sI/fmsyRv4xaainDb9yR7MP0
	UL6M1rhMqmrIp0YwaybhKuBP3yaIiY/Qs2miM1VHHNNbcIMKv9rViqQ84V5D8O4=
X-Google-Smtp-Source: AGHT+IH7EJcml3M4W23V2oRSWcTU5ivUA9Rpf9CNv3pePb82LUOuAhNto94gZ7SLmoyVt9dN2Th53g==
X-Received: by 2002:a17:90a:fb48:b0:299:3e78:91f6 with SMTP id iq8-20020a17090afb4800b002993e7891f6mr113505pjb.23.1708064753743;
        Thu, 15 Feb 2024 22:25:53 -0800 (PST)
Received: from starnight.endlessm-sf.com ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id sh18-20020a17090b525200b00298d8804ba8sm4398089pjb.46.2024.02.15.22.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 22:25:53 -0800 (PST)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v4 1/3] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Fri, 16 Feb 2024 14:24:14 +0800
Message-ID: <20240216062412.247052-3-jhp@endlessos.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The remapped PCIe Root Port and NVMe have PCI PM L1 substates capability,
but they are disabled originally.

Here is a failed example on ASUS B1400CEAE:

Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=10us

Power on all of the VMD remapped PCI devices before enable PCI-PM L1 PM
Substates by following PCI Express Base Specification Revision 6.0, section
5.5.4.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
v2:
- Power on the VMD remapped devices with pci_set_power_state_locked()
- Prepare the PCIe LTR parameters before enable L1 Substates
- Add note into the comments of both pci_enable_link_state() and
  pci_enable_link_state_locked() for kernel-doc.
- The original patch set can be split as individual patches.

v3:
- Re-send for the missed version information.
- Split drivers/pci/pcie/aspm.c modification into following patches.
- Fix the comment for enasuring the PCI devices in D0.

v4:
- The same

 drivers/pci/controller/vmd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..6aca3f77724c 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -751,11 +751,9 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
 		return 0;
 
-	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
-
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
 	if (!pos)
-		return 0;
+		goto out_enable_link_state;
 
 	/*
 	 * Skip if the max snoop LTR is non-zero, indicating BIOS has set it
@@ -763,7 +761,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	 */
 	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
 	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
-		return 0;
+		goto out_enable_link_state;
 
 	/*
 	 * Set the default values to the maximum required by the platform to
@@ -775,6 +773,13 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
 	pci_info(pdev, "VMD: Default LTR value set by driver\n");
 
+out_enable_link_state:
+	/*
+	 * Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+	 * PCIe r6.0, sec 5.5.4.
+	 */
+	pci_set_power_state_locked(pdev, PCI_D0);
+	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 	return 0;
 }
 
-- 
2.43.2


