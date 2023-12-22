Return-Path: <linux-kernel+bounces-9363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4784881C49E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710D21C24C13
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D5863C2;
	Fri, 22 Dec 2023 05:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0eo9Cvsx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721E46112
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dsMR+WACwlCN6vo2Aferq2y6mgFg8ofBbNv8oumItv4=; b=0eo9CvsxjzpdF4U8hBbO9yLtRL
	uH7OLXC6gHLsYCYHri2luyui/yGzD1l0Yls0YhM0QWEyjG8Xb64le1VcBc2AFFavd+aJkAhBp8HY+
	kSjMRJEA1S5g2L1TcL6X8Rkz/BM7KnY1e233RDtwoCcmgjNMUurH+a88nkIa4efdl6hmdUZgE5lap
	fij3uPbGitQYLy5E01roa3wQ6mP/ZE0DZRpjs5rO3DVuPBnIsGYAgb/lMg6PKryF9koOFSt0u/glN
	y6VeCt+jD9rAUdJKude4AbmFuthCKyhyMJnVg0Rw3GMJFbGlyHB9iYj6rQHgUfYRpxoB15IPNrU08
	KFhMwalQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGY2D-004y0F-2j;
	Fri, 22 Dec 2023 05:25:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/3] virt: vbox: linux: fix all kernel-doc warnings
Date: Thu, 21 Dec 2023 21:25:20 -0800
Message-ID: <20231222052521.14333-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222052521.14333-1-rdunlap@infradead.org>
References: <20231222052521.14333-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kernel-doc format for functions that are almost complete in their
kernel-doc comments.
For other functions, just change the comment to a common C comment.
This prevents 7 kernel-doc warnings.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/vboxguest/vboxguest_linux.c |   22 +++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff -- a/drivers/virt/vboxguest/vboxguest_linux.c b/drivers/virt/vboxguest/vboxguest_linux.c
--- a/drivers/virt/vboxguest/vboxguest_linux.c
+++ b/drivers/virt/vboxguest/vboxguest_linux.c
@@ -81,10 +81,11 @@ static int vbg_misc_device_user_open(str
 }
 
 /**
- * Close device.
- * Return: 0 on success, negated errno on failure.
+ * vbg_misc_device_close - Close device.
  * @inode:		Pointer to inode info structure.
  * @filp:		Associated file pointer.
+ *
+ * Return: %0 on success, negated errno on failure.
  */
 static int vbg_misc_device_close(struct inode *inode, struct file *filp)
 {
@@ -94,11 +95,12 @@ static int vbg_misc_device_close(struct
 }
 
 /**
- * Device I/O Control entry point.
- * Return: 0 on success, negated errno on failure.
+ * vbg_misc_device_ioctl - Device I/O Control entry point.
  * @filp:		Associated file pointer.
  * @req:		The request specified to ioctl().
  * @arg:		The argument specified to ioctl().
+ *
+ * Return: %0 on success, negated errno on failure.
  */
 static long vbg_misc_device_ioctl(struct file *filp, unsigned int req,
 				  unsigned long arg)
@@ -173,7 +175,7 @@ out:
 	return ret;
 }
 
-/** The file_operations structures. */
+/* The file_operations structures. */
 static const struct file_operations vbg_misc_device_fops = {
 	.owner			= THIS_MODULE,
 	.open			= vbg_misc_device_open,
@@ -193,7 +195,7 @@ static const struct file_operations vbg_
 #endif
 };
 
-/**
+/*
  * Called when the input device is first opened.
  *
  * Sets up absolute mouse reporting.
@@ -206,7 +208,7 @@ static int vbg_input_open(struct input_d
 	return vbg_core_set_mouse_status(gdev, feat);
 }
 
-/**
+/*
  * Called if all open handles to the input device are closed.
  *
  * Disables absolute reporting.
@@ -218,7 +220,7 @@ static void vbg_input_close(struct input
 	vbg_core_set_mouse_status(gdev, 0);
 }
 
-/**
+/*
  * Creates the kernel input device.
  *
  * Return: 0 on success, negated errno on failure.
@@ -277,7 +279,7 @@ static struct attribute *vbg_pci_attrs[]
 };
 ATTRIBUTE_GROUPS(vbg_pci);
 
-/**
+/*
  * Does the PCI detection and init of the device.
  *
  * Return: 0 on success, negated errno on failure.
@@ -453,7 +455,7 @@ void vbg_put_gdev(struct vbg_dev *gdev)
 }
 EXPORT_SYMBOL(vbg_put_gdev);
 
-/**
+/*
  * Callback for mouse events.
  *
  * This is called at the end of the ISR, after leaving the event spinlock, if

