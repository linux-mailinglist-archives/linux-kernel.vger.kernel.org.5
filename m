Return-Path: <linux-kernel+bounces-26126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6769582DBB8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8FF1C21B35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436AA1799C;
	Mon, 15 Jan 2024 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjOmKabw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE091775E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705330041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppwvkSEuixS2SG0TbgxgzQKgr6fgJxktZuxIJo/ERYU=;
	b=DjOmKabwUK1SeXmk+bEQa5KxBBqlQjNouFrXq2LrEoUVDlYnfFfwibnoc0jCPF9GXWWZr6
	v8oTHH0vek/QMrK1m7PWKybiFnM7MJZCZinkIWPKlazBeV91l2f5mAMZ3wAwikLavsKtXB
	Nztyahy3PJQKxhlpxi3uikoPAaK7yCw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640--sBCLrDlMIKeA8PiYoUQbw-1; Mon, 15 Jan 2024 09:47:19 -0500
X-MC-Unique: -sBCLrDlMIKeA8PiYoUQbw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67f4860c970so20144706d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 06:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705330039; x=1705934839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppwvkSEuixS2SG0TbgxgzQKgr6fgJxktZuxIJo/ERYU=;
        b=Fa+dhGQtEhiUcyLA9iJPAZxvweGK2Y8uf769OAqrs+gAfQp51mb/1YOEvv+HP7tImc
         QAXm60WBrxBpQ68nUtCYzj3o07HMA0+/TD7YKznjgYLhe5Gc/nh1FdGMcwfyFG1stAPg
         egPcmfm4ueCbKItxus5oBfxwk6V4fsi3is5rgYavb9JD3CCjG0epn3dN16Rek613ndOq
         E8gGGyOlvCK2niwcjnpYbKjz3u8fDo1Ioc4SRBQZd3J5OnBqQ/lcA269hLcWA89Zg3uo
         5f6sFwrboWbpXqw6VA3DYMKPAaFw3sHNCfJ89el/gg1i165nxyuupsrTVMYuvFGucl43
         Bfow==
X-Gm-Message-State: AOJu0YybO9oDtJhS7COHUeTwmJ5TJotNBAiJG57n0yESetIYLFNq4RcP
	IQm6DPFiPATmJEjps2RoE+4++xUcDNEgiGgMH4ZL7mVP6jlODYkRrtVNYxvFUkXjLMxplCX7wJ7
	Bmvj2NDbm/LtX4eC1T9oEDK2r+g8/BJR5
X-Received: by 2002:a05:6214:4109:b0:681:3016:2ca6 with SMTP id kc9-20020a056214410900b0068130162ca6mr10705068qvb.6.1705330038839;
        Mon, 15 Jan 2024 06:47:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUSOs/arWl9oiDpq0rWblAC6qIoaPYTdyyYZ8nxT4UMvv5M5B4KQKyYzih3gp3DMQa57ou9A==
X-Received: by 2002:a05:6214:4109:b0:681:3016:2ca6 with SMTP id kc9-20020a056214410900b0068130162ca6mr10705033qvb.6.1705330038467;
        Mon, 15 Jan 2024 06:47:18 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ne13-20020a056214424d00b006815cf9a644sm1020720qvb.55.2024.01.15.06.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 06:47:18 -0800 (PST)
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
Subject: [PATCH 03/10] pci: warn users about complicated devres nature
Date: Mon, 15 Jan 2024 15:46:14 +0100
Message-ID: <20240115144655.32046-5-pstanner@redhat.com>
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

The PCI region-request functions become managed functions when
pcim_enable_device() has been called previously instead of
pci_enable_device().

This has already caused bugs by confusing users, who came to believe
that all pci functions, such as pci_iomap(), suddenly are managed that
way.

This is not the case.

Add comments to the relevant functions' docstrings that warn users about
this behavior.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/iomap.c | 18 ++++++++++++++
 drivers/pci/pci.c   | 60 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
index b7faf22ec8f5..0b7fcc2f7a49 100644
--- a/drivers/pci/iomap.c
+++ b/drivers/pci/iomap.c
@@ -23,6 +23,11 @@
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR from offset to the end, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
+ * If you need automatic cleanup, use pcim_iomap_range().
  * */
 void __iomem *pci_iomap_range(struct pci_dev *dev,
 			      int bar,
@@ -63,6 +68,10 @@ EXPORT_SYMBOL(pci_iomap_range);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR from offset to the end, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
  * */
 void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
 				 int bar,
@@ -106,6 +115,11 @@ EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR without checking for its length first, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
+ * If you need automatic cleanup, use pcim_iomap().
  * */
 void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
 {
@@ -127,6 +141,10 @@ EXPORT_SYMBOL(pci_iomap);
  *
  * @maxlen specifies the maximum length to map. If you want to get access to
  * the complete BAR without checking for its length first, pass %0 here.
+ *
+ * NOTE:
+ * This function is never managed, even if you initialized with
+ * pcim_enable_device().
  * */
 void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
 {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2899df77a285..7ca860acf351 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3907,6 +3907,8 @@ EXPORT_SYMBOL(pci_release_region);
  * @res_name: Name to be associated with resource.
  * @exclusive: whether the region access is exclusive or not
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark the PCI region associated with PCI device @pdev BAR @bar as
  * being reserved by owner @res_name.  Do not access any
  * address inside the PCI regions unless this call returns
@@ -3918,6 +3920,13 @@ EXPORT_SYMBOL(pci_release_region);
  *
  * Returns 0 on success, or %EBUSY on error.  A warning
  * message is also printed on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you need to implement a new pci
+ * function that does automatic cleanup, write a new pcim_* function that uses
+ * devres directly.
  */
 static int __pci_request_region(struct pci_dev *pdev, int bar,
 				const char *res_name, int exclusive)
@@ -3966,6 +3975,8 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
  * @bar: BAR to be reserved
  * @res_name: Name to be associated with resource
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark the PCI region associated with PCI device @pdev BAR @bar as
  * being reserved by owner @res_name.  Do not access any
  * address inside the PCI regions unless this call returns
@@ -3973,6 +3984,12 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
  *
  * Returns 0 on success, or %EBUSY on error.  A warning
  * message is also printed on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
  */
 int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
 {
@@ -3998,6 +4015,13 @@ void pci_release_selected_regions(struct pci_dev *pdev, int bars)
 }
 EXPORT_SYMBOL(pci_release_selected_regions);
 
+/*
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
+ */
 static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
 					  const char *res_name, int excl)
 {
@@ -4023,6 +4047,14 @@ static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
  * @pdev: PCI device whose resources are to be reserved
  * @bars: Bitmask of BARs to be requested
  * @res_name: Name to be associated with resource
+ *
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
  */
 int pci_request_selected_regions(struct pci_dev *pdev, int bars,
 				 const char *res_name)
@@ -4031,6 +4063,20 @@ int pci_request_selected_regions(struct pci_dev *pdev, int bars,
 }
 EXPORT_SYMBOL(pci_request_selected_regions);
 
+/**
+ * pci_request_selected_regions_exclusive - Request regions exclusively
+ * @pdev: PCI device to request regions from
+ * @bars: bit mask of bars to request
+ * @res_name: name to be associated with the requests
+ *
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
+ */
 int pci_request_selected_regions_exclusive(struct pci_dev *pdev, int bars,
 					   const char *res_name)
 {
@@ -4048,7 +4094,6 @@ EXPORT_SYMBOL(pci_request_selected_regions_exclusive);
  * successful call to pci_request_regions().  Call this function only
  * after all use of the PCI regions has ceased.
  */
-
 void pci_release_regions(struct pci_dev *pdev)
 {
 	pci_release_selected_regions(pdev, (1 << PCI_STD_NUM_BARS) - 1);
@@ -4080,6 +4125,8 @@ EXPORT_SYMBOL(pci_request_regions);
  * @pdev: PCI device whose resources are to be reserved
  * @res_name: Name to be associated with resource.
  *
+ * Returns: 0 on success, negative error code on failure.
+ *
  * Mark all PCI regions associated with PCI device @pdev as being reserved
  * by owner @res_name.  Do not access any address inside the PCI regions
  * unless this call returns successfully.
@@ -4089,6 +4136,12 @@ EXPORT_SYMBOL(pci_request_regions);
  *
  * Returns 0 on success, or %EBUSY on error.  A warning message is also
  * printed on failure.
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED! If you want managed cleanup, use the
+ * pcim_* functions instead.
  */
 int pci_request_regions_exclusive(struct pci_dev *pdev, const char *res_name)
 {
@@ -4420,6 +4473,11 @@ void pci_disable_parity(struct pci_dev *dev)
  * @enable: boolean: whether to enable or disable PCI INTx
  *
  * Enables/disables PCI INTx for device @pdev
+ *
+ * NOTE:
+ * This is a "hybrid" function: Its normally unmanaged, but becomes managed
+ * when pcim_enable_device() has been called in advance.
+ * This hybrid feature is DEPRECATED!
  */
 void pci_intx(struct pci_dev *pdev, int enable)
 {
-- 
2.43.0


