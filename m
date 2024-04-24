Return-Path: <linux-kernel+bounces-156744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E24628B0798
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F906B21DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3081428F9;
	Wed, 24 Apr 2024 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="SnQOrS0U"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D1142900
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955413; cv=none; b=HhTp3S1E2Aw3wX4gkgiBgtOiHOBKWa5DTFA2EIyxj42XY69na9qJWC5BC3DYNnAtjKJ+iSKse8+p0DBqtZFAys+Ct7tXh5NQPCJH61Cp7Gn1WWlJmLuobeuQRgSBLdTOiuWm6IEYm5MtQoOis1HFBnftwN/xgDou188vWnjdwMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955413; c=relaxed/simple;
	bh=qG7vE0cpdGC+OMPSIq4vT5R2UpbBNARbgw4Nyy956/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohFLbKhPoOZfRk+IJXLMLDT75o1XAZreXcwS7w8g9Z8CUe4TzWV78aJAD3WfA8z5YTB2TacddSA/z+B1T8hdb/grvzHvaC1rSPEOOWRcAdVHjo0ti0BZeKgMNVKksgStMdj/QpRt7iQvvk14Nx6pRrmjQEsuJsGU+epnyNyN9mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=SnQOrS0U; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ecec796323so6747543b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 03:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1713955411; x=1714560211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x7GXKm/F50dpXqSR3wFFpE7hOEZxPmmiur/MNv+jyDU=;
        b=SnQOrS0UZWnFAL9Ifh2cJRT7gUS5IMTxMwqUY4UGpLJfXimSAH8GuseBhuzm+Gmtgx
         ilaB1q1ofvsmAQBl4esy/v/Hx667H0xx+Nn7E5pqSraTsaReWcZiQa+u630jH97+MGNT
         YRKJ9xnu+VzeQR4mdzKWGjI2yhTLUqHZkwlUNlA8zKu5SkWb1+HtJDeSKib459NjoDh7
         AA7mSrK9HoVLAJiiySZIZlopLHZjjqA8qwRaLVaUNtwiCqnXHDMoCHkvZKZtQacjn5H+
         wqGTt9FUuCvmoKOrKYiAlcOZqxmH5zyRQUuWgRF7xeX+lmB+vk4MU15CtLEEtclKwdqy
         3THg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713955411; x=1714560211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7GXKm/F50dpXqSR3wFFpE7hOEZxPmmiur/MNv+jyDU=;
        b=CFroaRI+hWbn6wBkd+/kUShPcFQWanoXHmKemRWcS09FMnT5fcwb9TIJqQub/R7MHT
         BvJ6OyXfwIGHdIL7cWIK/qH5CUpwoc+Y2hi5KIp+31cPNt3yC0hHsFD1GykQ/4S6VWpj
         8xt8KyC4oQDFrhbxn0KCZVUJATfmd4sv41YP/1rj9QXRKgnPZbtY6kv0qOqcXvUH2pTr
         DbQ4KAKoUFYxHdUQGSKW1if4FCw6sAPCtDuIwj+IYNdHE3BCzaJj5COFqNNNl1sAyLFz
         rnXdDhVyDwy2Y0IzMwAD8/ujyXeHWBTHGjK1f+phOesYoMRuEXAOT6uKvFi9tfcUwwb+
         DC7w==
X-Forwarded-Encrypted: i=1; AJvYcCVBRdm+RTyRubz7q/TAXfVON9B0uDZlxjethSZDwa2jNF/0PfRpBRI101PkWltkoVeCY2sxRnB6Y7EvcMG5jOExC2BX2MUhwuWvgHgx
X-Gm-Message-State: AOJu0Yw7o81dSu4ucEVWqH9ajLj84C/JHdS0ul4bLRiIgurpzoVe3o4N
	yUF0VuNeltGFT8GmbK0RTH/ktL1rpfKlAZnBTOK6C1Rkl4VHTemYdnKL+L/CD/8=
X-Google-Smtp-Source: AGHT+IHarCn/CWqIeOgpp9ZyRtpkzC5doRHGLv9Uzwl6OoYw7LUx6GIJqAt12EaQ2K4eE8xlmYUU6w==
X-Received: by 2002:a05:6a21:78a4:b0:1ad:13d:5a44 with SMTP id bf36-20020a056a2178a400b001ad013d5a44mr2344542pzc.18.1713955410612;
        Wed, 24 Apr 2024 03:43:30 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id s13-20020a17090330cd00b001e60ae3da22sm11603002plc.245.2024.04.24.03.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 03:43:30 -0700 (PDT)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH 0/4] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Wed, 24 Apr 2024 18:43:13 +0800
Message-ID: <20240424104313.21011-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Notice the VMD remapped PCIe Root Port and NVMe have PCI PM L1 substates
capability, but they are disabled originally.

Here is a failed example on ASUS B1400CEAE with enabled VMD:

10000:e0:06.0 PCI bridge: Intel Corporation 11th Gen Core Processor PCIe Controller (rev 01) (prog-if 00 [Normal decode])
    ...
    Capabilities: [200 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
        	  PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
        	   T_CommonMode=45us LTR1.2_Threshold=101376ns
        L1SubCtl2: T_PwrOn=50us

10000:e1:00.0 Non-Volatile memory controller: Sandisk Corp WD Blue SN550 NVMe SSD (rev 01) (prog-if 02 [NVM Express])
    ...
    Capabilities: [900 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
                  PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
        L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
                   T_CommonMode=0us LTR1.2_Threshold=0ns
        L1SubCtl2: T_PwrOn=10us

According to "PCIe r6.0, sec 5.5.4", to config the link between the PCIe
Root Port and the child device correctly:
* Ensure both devices are in D0 before enabling PCI-PM L1 PM Substates.
* Ensure L1.2 parameters: Common_Mode_Restore_Times, T_POWER_ON and
  LTR_L1.2_THRESHOLD are programmed properly on both devices before enable
  bits for L1.2.

Prepare this series to fix that.

Jian-Hong Pan (4):
  PCI: vmd: Set PCI devices to D0 before enable PCI PM's L1 substates
  PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
  PCI/ASPM: Introduce aspm_get_l1ss_cap()
  PCI/ASPM: Fix L1.2 parameters when enable link state

 drivers/pci/controller/vmd.c | 13 ++++++++----
 drivers/pci/pcie/aspm.c      | 41 ++++++++++++++++++++++++++++--------
 2 files changed, 41 insertions(+), 13 deletions(-)

-- 
2.44.0


