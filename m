Return-Path: <linux-kernel+bounces-121061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AF988E1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA7C2993FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A68015FCED;
	Wed, 27 Mar 2024 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBA3EJtp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411415FCE2;
	Wed, 27 Mar 2024 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541975; cv=none; b=FY8sxFCgWd6bKG2wYoj7xDUN/fhYxHiQhWUYLwpvWcjDFhyIF1p1d9ObLWB8okeZNUKswHfjkAr3cQW+sO3FdlBV3L9WLUzFltl9akgP+4XwQGO3YQYhg7iNa7vQfu+C5xKs2HolA2R1+RtyM0rBxVudKZ9gAtIR8o3kb+3HRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541975; c=relaxed/simple;
	bh=gnZc9s1UWyL6TMyfFV9b2655mj7AGnjPc9ZqXSBrv08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBN3FKeGu0tWhIYgMVuCmq/tR5IXRPzSuz3vO8cRvgSsQsMfaNyGGLxyeNu4G3rWuNLWQMu2rKFlq5Voo0IS2pefIoOF4l52SC4VzxPyvynhwwHsyhFaVfoohP3E0Su5Svob0QxsAQSL9X5TaW9p9RTj3qiz7qIHrdAp34HUkIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBA3EJtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9239C433F1;
	Wed, 27 Mar 2024 12:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541975;
	bh=gnZc9s1UWyL6TMyfFV9b2655mj7AGnjPc9ZqXSBrv08=;
	h=From:To:Cc:Subject:Date:From;
	b=WBA3EJtp9ybpqbIMxqOnAeWfNqv4uyCCrJN0awF0400kNdOPNaFGZL3sSKaI9ryRn
	 XOcYs2Dh9UJs9TGS/Y4HtNP5dFnSHyzzjsCBcBPz1d03avXrZDrQtPwDMUsTldF360
	 fgQpBdqLSKfIVJZbh4j96Qw9n2DHM17HEFR0PXwTs+QRt9a+ZijFWZiFJBRlA4UqVQ
	 DqYsniJCHNoc+3xiyUasGqwDNUJrg3Se7sU1f5W8G5WANqfQ6jtFwwhq5clx1OxFZ/
	 RqM8dpISfjEQhJnrJGvQQuSyQqZmRNDQzjiEe27prgYvvNhfA4ib+nLJDeSpn95rZ1
	 ui8MbqkfEvJIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	alex.williamson@redhat.com
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "vfio/pci: Lock external INTx masking ops" failed to apply to 5.10-stable tree
Date: Wed, 27 Mar 2024 08:19:32 -0400
Message-ID: <20240327121932.2835269-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 810cd4bb53456d0503cc4e7934e063835152c1b7 Mon Sep 17 00:00:00 2001
From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 8 Mar 2024 16:05:23 -0700
Subject: [PATCH] vfio/pci: Lock external INTx masking ops

Mask operations through config space changes to DisINTx may race INTx
configuration changes via ioctl.  Create wrappers that add locking for
paths outside of the core interrupt code.

In particular, irq_type is updated holding igate, therefore testing
is_intx() requires holding igate.  For example clearing DisINTx from
config space can otherwise race changes of the interrupt configuration.

This aligns interfaces which may trigger the INTx eventfd into two
camps, one side serialized by igate and the other only enabled while
INTx is configured.  A subsequent patch introduces synchronization for
the latter flows.

Cc:  <stable@vger.kernel.org>
Fixes: 89e1f7d4c66d ("vfio: Add PCI device driver")
Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Link: https://lore.kernel.org/r/20240308230557.805580-3-alex.williamson@redhat.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 34 +++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 136101179fcbd..75c85eec21b3c 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -99,13 +99,15 @@ static void vfio_send_intx_eventfd(void *opaque, void *unused)
 }
 
 /* Returns true if the INTx vfio_pci_irq_ctx.masked value is changed. */
-bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
+static bool __vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_irq_ctx *ctx;
 	unsigned long flags;
 	bool masked_changed = false;
 
+	lockdep_assert_held(&vdev->igate);
+
 	spin_lock_irqsave(&vdev->irqlock, flags);
 
 	/*
@@ -143,6 +145,17 @@ bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
 	return masked_changed;
 }
 
+bool vfio_pci_intx_mask(struct vfio_pci_core_device *vdev)
+{
+	bool mask_changed;
+
+	mutex_lock(&vdev->igate);
+	mask_changed = __vfio_pci_intx_mask(vdev);
+	mutex_unlock(&vdev->igate);
+
+	return mask_changed;
+}
+
 /*
  * If this is triggered by an eventfd, we can't call eventfd_signal
  * or else we'll deadlock on the eventfd wait queue.  Return >0 when
@@ -194,12 +207,21 @@ static int vfio_pci_intx_unmask_handler(void *opaque, void *unused)
 	return ret;
 }
 
-void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
+static void __vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
 {
+	lockdep_assert_held(&vdev->igate);
+
 	if (vfio_pci_intx_unmask_handler(vdev, NULL) > 0)
 		vfio_send_intx_eventfd(vdev, NULL);
 }
 
+void vfio_pci_intx_unmask(struct vfio_pci_core_device *vdev)
+{
+	mutex_lock(&vdev->igate);
+	__vfio_pci_intx_unmask(vdev);
+	mutex_unlock(&vdev->igate);
+}
+
 static irqreturn_t vfio_intx_handler(int irq, void *dev_id)
 {
 	struct vfio_pci_core_device *vdev = dev_id;
@@ -563,11 +585,11 @@ static int vfio_pci_set_intx_unmask(struct vfio_pci_core_device *vdev,
 		return -EINVAL;
 
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
-		vfio_pci_intx_unmask(vdev);
+		__vfio_pci_intx_unmask(vdev);
 	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
 		uint8_t unmask = *(uint8_t *)data;
 		if (unmask)
-			vfio_pci_intx_unmask(vdev);
+			__vfio_pci_intx_unmask(vdev);
 	} else if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
 		struct vfio_pci_irq_ctx *ctx = vfio_irq_ctx_get(vdev, 0);
 		int32_t fd = *(int32_t *)data;
@@ -594,11 +616,11 @@ static int vfio_pci_set_intx_mask(struct vfio_pci_core_device *vdev,
 		return -EINVAL;
 
 	if (flags & VFIO_IRQ_SET_DATA_NONE) {
-		vfio_pci_intx_mask(vdev);
+		__vfio_pci_intx_mask(vdev);
 	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
 		uint8_t mask = *(uint8_t *)data;
 		if (mask)
-			vfio_pci_intx_mask(vdev);
+			__vfio_pci_intx_mask(vdev);
 	} else if (flags & VFIO_IRQ_SET_DATA_EVENTFD) {
 		return -ENOTTY; /* XXX implement me */
 	}
-- 
2.43.0





