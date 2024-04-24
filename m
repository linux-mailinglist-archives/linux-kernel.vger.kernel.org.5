Return-Path: <linux-kernel+bounces-156764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 446598B07D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F06282135
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE0F15990D;
	Wed, 24 Apr 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="hYjytBgs"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1913DDD9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956323; cv=none; b=fVqotjiMHS3X5HVCP9qLMwgd+NO+LJOBlPhkpDMu0VlirTxCDfSDW2QCq3s5RgFpCHC4ZKbJURXrhgF5EahFKiMMn9I+wr3XpsL969G5CuCR/CzJtTTWJAbD/bSKaDmhdWUChh4opXSHOi3n+aZObgZRoLPgQWf5qeoNcnamqGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956323; c=relaxed/simple;
	bh=kD/apsZpQUjTX7GTpEZPSs6owgYA8C9LjrS5GfwTJcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLrMkSdhi0qPLSgIp105h4zZvuOBt9rDGxTa0+Dzq+MAxFmuz9e+76wn21/9P3kUOjXpoxubYfQ0WME90OjoYxd+5QkOHGXG3IobcirBPYDvOwo60FH00uGv5lQ0zqxrrGk8x/0/Qg/G/7s5N/1XanqvbYaN0wgL+j1Co7XUkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=hYjytBgs; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a58209b159so4495020a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 03:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1713956321; x=1714561121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kRfjSJt5RkWOkpKr1nWCFYWHFIH729SNz+JrUUaI0rQ=;
        b=hYjytBgsUxKlNk/qnPTBZX40M22NkvcFBcmI8ueiotcO2917/SDH7T9FpBcp+zn+e0
         Wxw//VpBsJ5JEO0ETnBF0S55ZkbClQbdW3jTEO2o5bnAXECLS8hiORKvlcU7a6UUGs0R
         CB0PieFb50sA9MEgutret3WmRn9gqxyQr6tZvo3RZRrQ0q437Gmep4Y3I5T9vPBYkvtW
         CuC2TLrpCa8Z1BMdFcAW4dPBMYYbQa8kGLWpVV9NgI2CJrOGQ5fduQl945i9zskUed1i
         0iHwXJsm3aRbBh1Z3U+AAYbtG+HiQq12aX33VrqzSYjCltDTUU+hj/Rx2Be1ILsAoZzA
         a/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713956321; x=1714561121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRfjSJt5RkWOkpKr1nWCFYWHFIH729SNz+JrUUaI0rQ=;
        b=QHpy2roaO7MN8BpY2ZCAFqzOW7/XZYvlwuUJo+5YS07fhysI3+A6t9lJEjncjZrTlt
         foDI4wTawGIBZUwtcEs1r/bfeT5+P/ObTG12/mAgIXPLzByu9iPDwfyYRAFLoFp/PuLi
         ykar6hVCa1d+b2jOZyr6BYhJAFnm6yTPLhTCc9rIdCsErxTegwihljJSSx8XN4hfT//V
         63wZNiWIHTh4s2bzvZBBZi9bT9YMdjJm9eTBqvE9KzX1BThYobvm8+g3CvaAaTGKbIOs
         RDUXni+p3+DHRXCXJojlNy1dBDsnDEJGwl3XNRbqpV0TzUIESOxNNtZdtgJaO56U+Oyp
         Ba4A==
X-Forwarded-Encrypted: i=1; AJvYcCXgOXgbj6FFetR9giIp5m+S/YeZQjDkUgm1EpYNzYj7sfBOpAXDz9JGSDVrk1w9mfx9EgO3x+tfWm6AihUM/lQWIi0EWmZq+05bjudv
X-Gm-Message-State: AOJu0YxzAgkce7TBY0KV4TJSnd1PcY71TTLcvRELOeDOjTXWTPt1HYI/
	vn0yIa0LTeuNm+cJRUL/zjqTZdPD4UkxoGvwX0nqCB7+sXaLTVK4lyLr2Z4V+KU=
X-Google-Smtp-Source: AGHT+IFKwBUnoOK2cd/JCwlF3MM8wqAOfAu2VAcCmWPnhbbCxfrg7Jje/eziYBdrDq8HoubQ0JQnoQ==
X-Received: by 2002:a17:90b:b14:b0:2a8:1fdf:b1b0 with SMTP id bf20-20020a17090b0b1400b002a81fdfb1b0mr1729628pjb.29.1713956321493;
        Wed, 24 Apr 2024 03:58:41 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id cu22-20020a17090afa9600b002ac5335f554sm957852pjb.1.2024.04.24.03.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 03:58:40 -0700 (PDT)
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
Subject: [PATCH v5 0/4] PCI: vmd: Enable PCI PM's L1 substates of remapped PCIe Root Port and NVMe
Date: Wed, 24 Apr 2024 18:58:15 +0800
Message-ID: <20240424105814.21690-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-send for the version information.

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


