Return-Path: <linux-kernel+bounces-156769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0138E8B07ED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37811C220CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E4215990F;
	Wed, 24 Apr 2024 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="qOfV8VGR"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B5C13DBB6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956443; cv=none; b=tPaA/pgtxT6g3isX1C/AyPhjun6gAF8s1ItSSluDVPNkEBj2D80OZ8iAYA3mY35ehKjg2Yu2IDomCMoDY47tGA7qvm2oKwGn0fbxYXR7mTsFDc0OsjK/abWiaxBkbMVX4yi+IP+xw/dH663VVdB1jN/szJogO0UdARvySPN08N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956443; c=relaxed/simple;
	bh=xrj+BsF3R/sU6CJ4lWDL94edEEUWp9h51Ook+sFDQOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYmWVcxUNKmrqfi5lgzsfjgQQ39gsNTm6vAsHQr90m/b1bGxA+YwYnu18G0/dH+ugxviINe5q5nTxDCy6TBIqlZ5mTsGkzOLsANmN1Ni3AJ8KIe0uQU52yqgJ5RZK/PnsZ43ay5Awm6gLYlmAD1it6xqts1aOEPYqpj0/qywbVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=qOfV8VGR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2abf9305afcso4087019a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1713956442; x=1714561242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H7v2jzS11FgSVo8HqrZdhIYDLTe97Dot+RPP6pZ20bU=;
        b=qOfV8VGRhnsSRuLqymRxRvSRF9JBRKKai83ZOWi6yBJkpRX9xxKwThL5T40m2+7QS7
         WgSAONpXZYElx8BZaUvYzZgd3A+tPI/BmVbrLSdLrkJf6Mpdh5AJ/Es/glEOK7UH+hWg
         1tD3lNpWJnYZEaI7g7d9xNo4DIudjc9Z60egvxsbmoM9cL5Cn3y29SUKGALzfpsK/G3u
         6aFoS4DjiEYBTht2KUU39JWolqJ3i+YijtfjOLYm0qhNEMCKV9PkboNlZTNq9EhKxvQF
         W5CgWJbitody8xXKT9KEZKNZmGMB/88CEhNHtOlgb6U35/aJNPWEyPXDjzfvTv3zSdTy
         zBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713956442; x=1714561242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7v2jzS11FgSVo8HqrZdhIYDLTe97Dot+RPP6pZ20bU=;
        b=q0WgOidWxjETT+/e4ZS3vFh2n3OfstC9ahbtOs/KFEKiolAluRZYyKlZHg7vdhfXCU
         prmbaP4Ik+SbZqG3AYRGg3A/qPYAyWWfeavSNOsSyh9IAqPN3BTp7h7/EoUv5XtDjVq0
         tVUNAVkQxI5UiTAufYivwVp2oGlghB+7sndPxEnuR8hO/OMi0vrwX7CYFTaKLdYj679g
         BHY6ytHS+pEUUnhPRQPiTAXC5pZCYsH5t+OgyDBfOXwH1itetXxBW0rtTUAT5zaLaUW2
         Xmm7W/1GW3RojNtZckr+D7GXVgbZTVy5OOzM8PKAi4K55Sjv9F46JvLqW6PsftnEYnjz
         yI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeyqRVIi4/oq/EML2NX6W6ZCeUg9K46SbdPdtiAcitQLKH0FJyXU3Fq+ZaAjTL3l6Ou6Sgm5QRVGEBSISSOczWAEsjzeUgwog/A0et
X-Gm-Message-State: AOJu0YxvVRf7BDC65JReTv06vBM9B4nlkj+YpTNf/0kyz39EVx1k+onp
	i+7F2swiCnh7q1tBLp9cWMRyD76uzES6WHEADHXVpymyDwOpWtPsquz+oEGmAug=
X-Google-Smtp-Source: AGHT+IF3QOpQA86HvZTp/W3Psv4CsVXJik+tr2sCT7EyCcIzJbipu2+EoOeiHR34l4PN7lpni/UlSA==
X-Received: by 2002:a17:90b:1e0a:b0:2ae:e1e0:3d8f with SMTP id pg10-20020a17090b1e0a00b002aee1e03d8fmr1746429pjb.2.1713956441679;
        Wed, 24 Apr 2024 04:00:41 -0700 (PDT)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id 65-20020a17090a09c700b002a5d20778ebsm13786899pjo.32.2024.04.24.04.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:00:41 -0700 (PDT)
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
	Jian-Hong Pan <jhp@endlessos.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 2/4] PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
Date: Wed, 24 Apr 2024 18:59:47 +0800
Message-ID: <20240424105946.21735-2-jhp@endlessos.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to "PCIe r6.0, sec 5.5.4", add note about D0 requirement in
pci_enable_link_state() kernel-doc.

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
v3:
- Fix as readable comments

v4:
- The same

v5:
- Tweak and simplify the commit message

 drivers/pci/pcie/aspm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 2428d278e015..91a8b35b1ae2 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1446,6 +1446,9 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
  * touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  */
@@ -1462,6 +1465,9 @@ EXPORT_SYMBOL(pci_enable_link_state);
  * can't touch the LNKCTL register. Also note that this does not enable states
  * disabled by pci_disable_link_state(). Return 0 or a negative errno.
  *
+ * Note: Ensure devices are in D0 before enabling PCI-PM L1 PM Substates, per
+ * PCIe r6.0, sec 5.5.4.
+ *
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
  *
-- 
2.44.0


