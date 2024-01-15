Return-Path: <linux-kernel+bounces-26130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B619482DBC2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687561F2280A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315BC17C91;
	Mon, 15 Jan 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BD+zOudQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181CE17BC7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705330048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3vu21hkZlZsapFSJtp8nhKKQ/3OZTkpZfYIme9+49k=;
	b=BD+zOudQkPf/CYbLETcnHrpIm1cUoXYFUOO0K4nZiU8n/wHtXXFmiYUQ8e0eJ7CZAwvYhj
	FJt/pq46Q3Ioil40c0MRFS0A6MkGDOxHEHRMeAClUf0d41M/CUbUnmsoc+sacGgLsx2NS1
	059A8ROOW+4lKQJK1eNdwcr2vCbwsHQ=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-DiF4Cu-INhiTmwYDeM7lVw-1; Mon, 15 Jan 2024 09:47:26 -0500
X-MC-Unique: DiF4Cu-INhiTmwYDeM7lVw-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4b7bdc844fcso135153e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 06:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705330046; x=1705934846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3vu21hkZlZsapFSJtp8nhKKQ/3OZTkpZfYIme9+49k=;
        b=WQ11PYcA1fq4S8fu5h10ekqn0bgPbYDl97kPbXHH+ysKq5GnZWAqOSTj2P0a/ZFA4t
         qEro/2jw1sBwqKCWH4wZCVyCAv5wOtapMXYQcdlC4Wlf4FfLMAeXOMoCo5CapvidvX8W
         eIrwJFaBMkvDpgHz22gnnwnm1Li+RvYdOpfmvqX6xgz3gtomthzgRFE8N15Rk2BuinAg
         45ihnR7AS9MXF2Q9Fln6ilwTHi6EPWxmRSwkbxbNW+DvTh+AZgTsUCxmYZMvV6Hkcugc
         Qzdx/yTlrg8UfnNGj1v9q/yPI+U6s6bJRttMfpBueF1Wy7710z1PqBctKQssNzJDUytx
         S/DQ==
X-Gm-Message-State: AOJu0YwOEKEPOv9ocCkP96Hh1C83HPL0t5RAwhtlaWs2qD61Rcfn/U5q
	qA4eMYKQN9IrCAAzO+M7KdF2OjmYwWaNMnzDSiHSa16EafVNgVpxyOhNeywKwu6kjpjUFHc+7Py
	UI5zoYq35BXkms7vXxRwI1n0kfzVIEaG/
X-Received: by 2002:a05:6122:2886:b0:4b7:32ac:f4e5 with SMTP id fl6-20020a056122288600b004b732acf4e5mr4682343vkb.1.1705330046110;
        Mon, 15 Jan 2024 06:47:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEl3g0muu7xD/Tj+Zr9TyY8gOWhOJboojbdmamx1smFfYvzduqw18AZ9+hpq2S3HXA+drCMKA==
X-Received: by 2002:a05:6122:2886:b0:4b7:32ac:f4e5 with SMTP id fl6-20020a056122288600b004b732acf4e5mr4682321vkb.1.1705330045850;
        Mon, 15 Jan 2024 06:47:25 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ne13-20020a056214424d00b006815cf9a644sm1020720qvb.55.2024.01.15.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 06:47:25 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 06/10] pci: move pinned status bit to pci_dev struct
Date: Mon, 15 Jan 2024 15:46:17 +0100
Message-ID: <20240115144655.32046-8-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115144655.32046-2-pstanner@redhat.com>
References: <20240115144655.32046-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bit describing whether the PCI device is currently pinned is stored
in the PCI devres struct. To clean up and simplify the pci-devres API,
it's better if this information is stored in the pci_dev struct, because
it allows for checking that device's pinned-status directly through the
device struct.
This will later permit simplifying  pcim_enable_device().

Move the 'pinned' boolean bit to struct pci_dev.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 14 ++++----------
 drivers/pci/pci.h    |  1 -
 include/linux/pci.h  |  1 +
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index bf957f0bc5ac..de8cf6f87dd7 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -411,7 +411,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (!this->pinned)
+	if (!dev->pinned)
 		pci_disable_device(dev);
 }
 
@@ -469,18 +469,12 @@ EXPORT_SYMBOL(pcim_enable_device);
  * pcim_pin_device - Pin managed PCI device
  * @pdev: PCI device to pin
  *
- * Pin managed PCI device @pdev.  Pinned device won't be disabled on
- * driver detach.  @pdev must have been enabled with
- * pcim_enable_device().
+ * Pin managed PCI device @pdev. Pinned device won't be disabled on driver
+ * detach.  @pdev must have been enabled with pcim_enable_device().
  */
 void pcim_pin_device(struct pci_dev *pdev)
 {
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !pdev->enabled);
-	if (dr)
-		dr->pinned = 1;
+	pdev->pinned = true;
 }
 EXPORT_SYMBOL(pcim_pin_device);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index dbb76a3fb0e4..3d9908a69ebf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -809,7 +809,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * when a device is enabled using managed PCI device enable interface.
  */
 struct pci_devres {
-	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
 	unsigned int mwi:1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a356bdcc14cc..2f6f44991003 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -368,6 +368,7 @@ struct pci_dev {
 					   functional, and D3 being off. */
 	u8		pm_cap;		/* PM capability offset */
 	unsigned int	enabled:1;	/* Whether this dev is enabled */
+	unsigned int	pinned:1;	/* Whether this dev is pinned */
 	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
-- 
2.43.0


