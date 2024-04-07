Return-Path: <linux-kernel+bounces-134190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCB789AED0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D7C3B22DE0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C0F1096F;
	Sun,  7 Apr 2024 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OqrjbcXm"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213BB101C6
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 06:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712470422; cv=none; b=aUkISFWCdVnoNQgAAt6AM5j7vyEWfm78tHM22UgkN3Qc26rp54HtH64NG5vofsVlpmqjMGIXPfupUDqpYVVjU4KirxGWP9WQMBpKzd3MWZy1y1eukV48UtRKYpX8rBJnl4b3Oz6snlQpTzhHybIQbRrhm7RhfrRIjlvejOFV7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712470422; c=relaxed/simple;
	bh=1fEqYXK1SvqYktRfcwcWHmAjjYrgInIfJ6bJrYfAHSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sPyjRlUqjrU6nyDgSHxu47b2VIOGkk8qrigC1JWQThAmPVD8D1HqkNfu+ytTpf4Yq9wMlkctUJLT7JisXHPJ0lcvJOgiFMZDLsz+SIpfSy9sS3tEIDcEMvcX8UMV/f8FlXqG6XygvUZUYRnFyNKot34lVCebuBIEaCgmg/yMUao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OqrjbcXm; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712470412; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OpSGDUWMbIKM8Bslv9SNkMz8YI1ytup7lt5o1mnR3b0=;
	b=OqrjbcXmFCYU2rE6OsEq+e+JBWq7d45JM+HT7Bg9n/tyw9XmplQIJFLMMKIjQlINJIZT9CuFc2SsFKC5D9/OryphTQFAahKLweI2UpKjOUkZze1ZjGLzNGX3PCIvqIceA7amKv+WdkzA+zkRAUGMqjITr2jLVQDNo/jh5BoFRFU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W4.IlbM_1712470095;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W4.IlbM_1712470095)
          by smtp.aliyun-inc.com;
          Sun, 07 Apr 2024 14:08:16 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] ARM: Add kernel-doc comments to ssp_read_word()
Date: Sun,  7 Apr 2024 14:08:14 +0800
Message-Id: <20240407060814.96307-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds kernel-doc style comments with complete parameter
descriptions for the function ssp_read_word().

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/arm/mach-sa1100/ssp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-sa1100/ssp.c b/arch/arm/mach-sa1100/ssp.c
index 613fd767afcf..3c97e372bdc4 100644
--- a/arch/arm/mach-sa1100/ssp.c
+++ b/arch/arm/mach-sa1100/ssp.c
@@ -73,6 +73,8 @@ int ssp_write_word(u16 data)
 /**
  * ssp_read_word - read a word from the SSP port
  *
+ * @data: Pointer to the 16-bit buffer where the read data should be stored.
+ *
  * Wait for a data word in the SSP receive FIFO, and return the
  * received data.  Data is LSB justified.
  *
-- 
2.20.1.7.g153144c


