Return-Path: <linux-kernel+bounces-44343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE614842084
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84E871F2B8D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BA865BC8;
	Tue, 30 Jan 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="Pg8ZQJsu"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C87F65BBF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608901; cv=none; b=uWH/mkiwAR2dOBZfsxVFHXbIzxPrIpekyUd1RSbrjebaPbadvPbNzZYuCylz0lVzXOV3G3DPgxUv5EVuUQi4Uhn4vRidr/rAzaXm5Jc8vSu69VG7dng5Z3CLTeHNsWaCZWGlnXSQyAXshw9vFKQzhA1zbnzSQ/RMIcf5p8NJHAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608901; c=relaxed/simple;
	bh=teXt9OHZdZez3wzxIY3fbH5xLvmsOi4Wj5q2dFRSqx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p0xMCQT1UKtTlf7Iq+lWWqjOHy651ehRZhD+safqo0FCJQZzt/hnAcmJI1zprBUCj74ykXVCuDVGxeoyJHHt2mPn7ELPav0XxyGZ7bZoY5FZXFFQPEwQZDfqnxaJfMBm2G60ak2pMQ+8uyn4bM9ihyHs/c3532/oTzLSl6QTeyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=Pg8ZQJsu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2901f9ea918so1738972a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 02:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1706608900; x=1707213700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QKkQF0FpW08UeteOAoIxviKy11wOo5codk8APJXnHpw=;
        b=Pg8ZQJsuOIKrKWAPtAdwj5JEMcqmwByEUHyPkHoyIeI6rd8cAgKB7dODgs4H37vWof
         UZOFF+qg83yKXNm1ar+ZncH5VL0C3KU6guVI3nVf41V1ZP/Jk+AXXD/rI5uO75TBa3uW
         slx4fV5rysnvznkjxxcVw+4lhidKLB5fVCWSF+yFSw+FX6wEe25t4qnKtte8gSAhuCL2
         7egLUuUH77GBRVIvWT8XnkT3pDanYR/kS1iUTpA7k8wC21NL3UZavlf+0PuD9i/elSvP
         7FKO+zU5JD6DSaHcSVCv3zMMXywKe4Sq9+A9jfjgYkuTNyaoYy8EmHIzYB98d2R6Fvab
         jzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706608900; x=1707213700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QKkQF0FpW08UeteOAoIxviKy11wOo5codk8APJXnHpw=;
        b=UXDpalcLYmRYTtnZp7irnpcD4K6+pKEyhXgsppE9xyYlnUPUhsl9nn3moob2QX8UI6
         mA4ldJwafv297WFTOSnVAeN3m0zocwV0Ms+Ey3c0DSEQ/5ukLDlvE4mdtExMLlSoaN+A
         Tm731tpJWLlIyOsAAAaZWYkS+BYtCr0rmFwWUHJhqxqaXcmkC0AD6KHNyKOGMEHAf47m
         h8n961bHPQCF+z50lzQ8dEsHTQMlP4zy5rWR8GZqJupIvpERB+zJmDcvJW2RAAy1QP2v
         8lNf5kw77Tlknyhw6Pvh4R06/jPdCxfCk3iF0B/1//1AbL26KqPVFcy1oL2NYflfFkCe
         X3LQ==
X-Gm-Message-State: AOJu0Yw0KxtQ55pyGUcihePwPqLfaGNG8K5ZU1HLNiEkkrwUyUlZvMiG
	72kex97DtQTOXS2BDR87189nFBMPIAyYvU1nTAGJzIF/psZ8KtVb4zvLytGWlSE=
X-Google-Smtp-Source: AGHT+IESf0EpjQx4lpB34RFQ6qQXQst1fuUCLWSZ9r/E3tjdjKkRAJqjn7CH4cmrPl4d8ixCz9wsdQ==
X-Received: by 2002:a17:90a:604f:b0:295:b7d0:eadc with SMTP id h15-20020a17090a604f00b00295b7d0eadcmr456213pjm.24.1706608899779;
        Tue, 30 Jan 2024 02:01:39 -0800 (PST)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id sg14-20020a17090b520e00b00295bc312ceasm730672pjb.34.2024.01.30.02.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:01:39 -0800 (PST)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-ide@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH 2/2] PCI: vmd: enable PCI PM's L1 substates of remapped PCIe port and NVMe
Date: Tue, 30 Jan 2024 18:00:51 +0800
Message-ID: <20240130100050.14182-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The remmapped PCIe port and NVMe have PCI PM L1 substates capability on
ASUS B1400CEAE, but they are disabled originally:

Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=10us

Power on all of the VMD remapped PCI devices before enable PCI-PM L1 PM
Substates by following "Section 5.5.4 of PCIe Base Spec Revision 5.0
Version 0.1". Then, PCI PM's L1 substates control are enabled
accordingly.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
 drivers/pci/controller/vmd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..b1bbe8e6075a 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -738,6 +738,12 @@ static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
 	vmd_bridge->native_dpc = root_bridge->native_dpc;
 }
 
+static int vmd_power_on_pci_device(struct pci_dev *pdev, void *userdata)
+{
+	pci_set_power_state(pdev, PCI_D0);
+	return 0;
+}
+
 /*
  * Enable ASPM and LTR settings on devices that aren't configured by BIOS.
  */
@@ -928,6 +934,13 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	vmd_acpi_begin();
 
 	pci_scan_child_bus(vmd->bus);
+
+	/*
+	 * Make PCI devices at D0 when enable PCI-PM L1 PM Substates from
+	 * Section 5.5.4 of PCIe Base Spec Revision 5.0 Version 0.1
+	 */
+	pci_walk_bus(vmd->bus, vmd_power_on_pci_device, NULL);
+
 	vmd_domain_reset(vmd);
 
 	/* When Intel VMD is enabled, the OS does not discover the Root Ports
-- 
2.43.0


