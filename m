Return-Path: <linux-kernel+bounces-9365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9784C81C4A0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA92C1C24E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0DB944B;
	Fri, 22 Dec 2023 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ib0tjcY5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722216120
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NcgjXN95RsDAjlsvl0lPtlflx+Yff9K/qAsTAqvV9q4=; b=Ib0tjcY5MpF4PWKRkRejF/bvZv
	i08sfXeqCuXE22jRpC3ZJw+Izi3HZdADzRbVrtQj8vo3rgbTLCGtCPRzl8p16l6n9lf85xCJZhJEL
	x8Ll8zdf6jY79f19MAtSyRst12Urun4k8BNu2u2rj5f8CeHP1GLLkdlkBoPPJKK3O2RAWL3gbdfl7
	nrSe5aoAJBt7wTUxyIGMX5vWyabfK0iALpCUJa1RI43EEWR7kpMHvRezXD1gP5NZApK5HborMixFF
	fvFHSYuGKCkM2UAoHzsJwk0j/rC5A6NcVHHIctMIPsWiHT3U6INVUHQBaun64aNdl7DBUxo6sph5h
	RH5NAezg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGY2E-004y0F-0B;
	Fri, 22 Dec 2023 05:25:22 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] virt: vbox: utils: fix all kernel-doc warnings
Date: Thu, 21 Dec 2023 21:25:21 -0800
Message-ID: <20231222052521.14333-3-rdunlap@infradead.org>
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

Use kernel-doc format for functions that have comments that begin
with "/**".
This prevents 6 kernel-doc warnings.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virt/vboxguest/vboxguest_utils.c |   33 +++++++++++++--------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff -- a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vboxguest/vboxguest_utils.c
--- a/drivers/virt/vboxguest/vboxguest_utils.c
+++ b/drivers/virt/vboxguest/vboxguest_utils.c
@@ -237,14 +237,16 @@ static int hgcm_call_preprocess_linaddr(
 }
 
 /**
- * Preprocesses the HGCM call, validate parameters, alloc bounce buffers and
- * figure out how much extra storage we need for page lists.
- * Return: 0 or negative errno value.
+ * hgcm_call_preprocess - Preprocesses the HGCM call, validate parameters,
+ *	alloc bounce buffers and figure out how much extra storage we need for
+ *	page lists.
  * @src_parm:         Pointer to source function call parameters
  * @parm_count:       Number of function call parameters.
  * @bounce_bufs_ret:  Where to return the allocated bouncebuffer array
  * @extra:            Where to return the extra request space needed for
  *                    physical page lists.
+ *
+ * Return: %0 or negative errno value.
  */
 static int hgcm_call_preprocess(
 	const struct vmmdev_hgcm_function_parameter *src_parm,
@@ -301,10 +303,11 @@ static int hgcm_call_preprocess(
 }
 
 /**
- * Translates linear address types to page list direction flags.
+ * hgcm_call_linear_addr_type_to_pagelist_flags - Translates linear address
+ *	types to page list direction flags.
+ * @type:  The type.
  *
  * Return: page list flags.
- * @type:  The type.
  */
 static u32 hgcm_call_linear_addr_type_to_pagelist_flags(
 	enum vmmdev_hgcm_function_parameter_type type)
@@ -369,7 +372,8 @@ static void hgcm_call_init_linaddr(struc
 }
 
 /**
- * Initializes the call request that we're sending to the host.
+ * hgcm_call_init_call - Initializes the call request that we're sending
+ *	to the host.
  * @call:            The call to initialize.
  * @client_id:       The client ID of the caller.
  * @function:        The function number of the function to call.
@@ -425,7 +429,9 @@ static void hgcm_call_init_call(
 }
 
 /**
- * Tries to cancel a pending HGCM call.
+ * hgcm_cancel_call - Tries to cancel a pending HGCM call.
+ * @gdev:        The VBoxGuest device extension.
+ * @call:        The call to cancel.
  *
  * Return: VBox status code
  */
@@ -459,13 +465,15 @@ static int hgcm_cancel_call(struct vbg_d
 }
 
 /**
- * Performs the call and completion wait.
- * Return: 0 or negative errno value.
+ * vbg_hgcm_do_call - Performs the call and completion wait.
  * @gdev:        The VBoxGuest device extension.
  * @call:        The call to execute.
  * @timeout_ms:  Timeout in ms.
+ * @interruptible: whether this call is interruptible
  * @leak_it:     Where to return the leak it / free it, indicator.
  *               Cancellation fun.
+ *
+ * Return: %0 or negative errno value.
  */
 static int vbg_hgcm_do_call(struct vbg_dev *gdev, struct vmmdev_hgcm_call *call,
 			    u32 timeout_ms, bool interruptible, bool *leak_it)
@@ -545,13 +553,14 @@ static int vbg_hgcm_do_call(struct vbg_d
 }
 
 /**
- * Copies the result of the call back to the caller info structure and user
- * buffers.
- * Return: 0 or negative errno value.
+ * hgcm_call_copy_back_result - Copies the result of the call back to
+ *	the caller info structure and user buffers.
  * @call:            HGCM call request.
  * @dst_parm:        Pointer to function call parameters destination.
  * @parm_count:      Number of function call parameters.
  * @bounce_bufs:     The bouncebuffer array.
+ *
+ * Return: %0 or negative errno value.
  */
 static int hgcm_call_copy_back_result(
 	const struct vmmdev_hgcm_call *call,

