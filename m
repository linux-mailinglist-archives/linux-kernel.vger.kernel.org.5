Return-Path: <linux-kernel+bounces-88166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5A186DE16
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2770B288069
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24116A335;
	Fri,  1 Mar 2024 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G0jo7Bmb"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC136A8A4;
	Fri,  1 Mar 2024 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284888; cv=none; b=am6pyB2C3UcbcRJW/xBIJJZg5AuhD0iOu2y8NRwDbS8g/3t82ghYZ5/oiYOIxk7MrNlblbVxLKdj2bcS2eq8mE2BxPLm79PlUM2e1F1vdBvzAWOdUpg1GcqA+UZE227ky2EX4Q9AAUyKRs7dk+bdkYleJuWTM6wNCPCY1+zGPEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284888; c=relaxed/simple;
	bh=HoVdyMBNjH0gfvvW54a8qDSrYAP55l1w9DtckvigMqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fcWxHkXlrI9KAASWJoAwJH4RC53hotOk4WnYK0Ee7ssSZ61p19Pjn7Ien66mjIq5BcnsbK2t5OTh2q8i7bT1NYWABaKier7LWyN8OcD+y8u2pZyuCopAGHVFLpMQRu+LDGe9CQm4n/P476cM8MjnNyf+qIj5F/kPaMy35ygea+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G0jo7Bmb; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709284882; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=k5QB3ze+6oWRr+6yyCjkOCe+0xDxHnLLwE8gCBdLC+k=;
	b=G0jo7BmbCbGv7gXtUBiprSRlzftynj8o+nj7HIa0Yg5+mAdkeprVhJcFAQrWOvl2wJVD0B+OOGpLtWBvYm7D8wYdv99AOFJ0e7Xtkgy48zhm89ZqFuuD7os+vpb+32suxbSlTuQar/8abbN7qeZza3Mjgc5/N/97Fl9HCB47lOg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W1azpUa_1709284881;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W1azpUa_1709284881)
          by smtp.aliyun-inc.com;
          Fri, 01 Mar 2024 17:21:22 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: dmitry.torokhov@gmail.com,
	michal.simek@amd.com
Cc: linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] Input: Fix kernel-doc for xps2_of_probe function
Date: Fri,  1 Mar 2024 17:21:15 +0800
Message-Id: <20240301092115.123092-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing comment block above the xps2_of_probe function
does not conform to the kernel-doc standard. This patch fixes the
documentation to match the expected kernel-doc format, which includes
a structured documentation header with param and return value.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/input/serio/xilinx_ps2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index d8f9faf2b529..bb758346a33d 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -219,8 +219,7 @@ static void sxps2_close(struct serio *pserio)
 
 /**
  * xps2_of_probe - probe method for the PS/2 device.
- * @of_dev:	pointer to OF device structure
- * @match:	pointer to the structure used for matching a device
+ * @ofdev:	pointer to OF device structure
  *
  * This function probes the PS/2 device in the device tree.
  * It initializes the driver data structure and the hardware.
-- 
2.20.1.7.g153144c


