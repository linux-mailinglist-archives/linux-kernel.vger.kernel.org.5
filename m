Return-Path: <linux-kernel+bounces-61097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29004850D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8ACB22B78
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 04:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CA36FC9;
	Mon, 12 Feb 2024 04:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f/k/2sUs"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D326FA7;
	Mon, 12 Feb 2024 04:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707712567; cv=none; b=Dk+5axoIym9yZRF20SqlcbWe9ygiCWssKhuNvlWpYQt6w8KDbHNXb3v4ZYeWnJvGqXBA8WU/R5HZUTZmDLg8iRlMXkiyQ7qHk+8PzMt0ag9CA4/K/CWRl3TW6622tA3TQ77Rl9ew4RbpsySMZL++o6MmR4vy2NywcHycvlEqt7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707712567; c=relaxed/simple;
	bh=K5Z6Gd9GtIN8kQlUzbKNaoqN7pc1r6LIUiX9Dr2PYKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meq8kwxlEow56L0NhIA9qfE5cealSPq5W4h+eW71b2iWSereArC0q+QxXoyAKnRRDG4zp+6XlD5MhQ2wd4zkVf+UjP/rFXDxBuWeaykyOsQTGdMf9NTaCVu3QXDvn4a01PIsGJtFoHsKo9ZuPqtNi2MdNjeyLBUv0PIOJHfAflw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f/k/2sUs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=08O4r7EagOfxJamjR1JKheKTGIaVmmAOoLfXmfVv1kI=; b=f/k/2sUsAIzaH8vGPH09e4pXeX
	MN0WvhHHiGcaCRdCiQecXqWyrKa3SyCLepVsSA5Bp7eRpH4+5YaOTAdqudPSZo7G3iKWOcSA+tIeF
	gzZIRWa8sEJ+OGrWgPki5nhgpZW7CJdwNyRt7047z5eaoQmYFQl7lkVzLgvq9m6Kh9HO1mNgKEbQX
	XLuwoNZ/X0KFUeq7oe7AsSzv88ONG2VjdGkBTIcCnDDF4hlvFILzC3vTp0owL2AprWHj32s8Wrp4X
	FBnhQ+sjqK9X99BU0uvn48aU5ehU61vqBAPx1NWddYSbbaIdogwV1Ij8E6sQHgVqDaysMOm4HM+Pm
	L8FTWaGg==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZO32-00000004Jfb-2zA2;
	Mon, 12 Feb 2024 04:36:04 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	ntb@lists.linux.dev
Subject: [PATCH v2] NTB: ntb_transport: fix all kernel-doc warnings
Date: Sun, 11 Feb 2024 20:36:04 -0800
Message-ID: <20240212043604.12907-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix all kernel-doc warnings in ntb_transport.c.

The function parameters for ntb_transport_create_queue() changed, so
update them in the kernel-doc comments.
Add a Returns: comment for ntb_transport_register_client_dev().

ntb_transport.c:382: warning: No description found for return value of 'ntb_transport_register_client_dev'
ntb_transport.c:1984: warning: Excess function parameter 'rx_handler' description in 'ntb_transport_create_queue'
ntb_transport.c:1984: warning: Excess function parameter 'tx_handler' description in 'ntb_transport_create_queue'
ntb_transport.c:1984: warning: Excess function parameter 'event_handler' description in 'ntb_transport_create_queue'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
v2: ad Dave's Reviewed-by;
    rebase & resend;

 drivers/ntb/ntb_transport.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff -- a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -377,6 +377,8 @@ EXPORT_SYMBOL_GPL(ntb_transport_unregist
  * @device_name: Name of NTB client device
  *
  * Register an NTB client device with the NTB transport layer
+ *
+ * Returns: %0 on success or -errno code on error
  */
 int ntb_transport_register_client_dev(char *device_name)
 {
@@ -1966,9 +1968,9 @@ static bool ntb_dma_filter_fn(struct dma
 
 /**
  * ntb_transport_create_queue - Create a new NTB transport layer queue
- * @rx_handler: receive callback function
- * @tx_handler: transmit callback function
- * @event_handler: event callback function
+ * @data: pointer for callback data
+ * @client_dev: &struct device pointer
+ * @handlers: pointer to various ntb queue (callback) handlers
  *
  * Create a new NTB transport layer queue and provide the queue with a callback
  * routine for both transmit and receive.  The receive callback routine will be

