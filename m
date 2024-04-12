Return-Path: <linux-kernel+bounces-142327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DAC8A2A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9501F232F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AF754675;
	Fri, 12 Apr 2024 08:55:35 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565D54666
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912135; cv=none; b=HLqD7LIVjjDvEfap13ZWqzn4FFUEg3Jlisu8ql/DpiDSQ57m6ZXzM+YOPrAgIcMXDIyBtDkMyyczf/3kQDu4vMU9O++meQNOW/tb9xN9m5K15fsfLFyfm6LGIzUwksphp1LaiFvN5JhNvUFms6ilWLvxxFM5mQImGamO7NP6e8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912135; c=relaxed/simple;
	bh=jvULkoQb8Telt5bH/bAoGYm9ELyR9FJwhgTLwy6k7uI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cgRN3fNSXmE5CgzMbwLNwN/8BrrkDQMeAfhn0Entd+akEzp+At5oLMmmGgO8YS5AGQIqN9qWBtdRIPQZ8Fnnnb/IqOfUU9l7jDlERnDe2lAMmDqTiGY44tqmgJdrXh+6Ve5S1909IHKLeu6VLLd5qhsBoHxXSs1q27bCtD12ft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz10t1712912023tvoarp
X-QQ-Originating-IP: R97qRij170LrT/MW5RfM1l0Kd9nqITC8rcgjajfH6+Y=
Received: from localhost.localdomain ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Apr 2024 16:53:35 +0800 (CST)
X-QQ-SSF: 0140000000000090B000000A0000000
X-QQ-FEAT: 9vsVjMb6wCzPgN6/N07igtreGEa/QssY7PbvEBadM6fn1CXeUw8H/rg15FcDF
	taLJSvaCkP+RFYBBzlI8DNxq/w66k77sX+bmhjQYzyPjN4HHR8D9E58oftuImU3id06shbv
	YuvK3EmvH7mj9mRz+wCeFo4m6dKl2ckxU10CZysBCypRT5xi6hA8/GOcFRhy1ZMg5tmhG7J
	lQD5xemCmNaqIseWiaHC/+Iw7oFM0dABdBO7h0wwPX+Xf7I+bR+sk86W8MHOdz292A8oRpZ
	/6wVfyrwR8xsHWOL/M7kyc3N3w4v23Mmk8l2t3zI0saDKwP9u8U75AgbkBRLeFefYspKjw4
	MH8sMHa34RdGFCQBP8tlPqD3J4KlyyHtAYtzINCCscJ4n2yz5aa8kxuCp4xml7ecO6V4ZaU
	cANeq1AXA0o=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14227558502110067001
From: JianChunfu <chunfu.jian@shingroup.cn>
To: alex.williamson@redhat.com,
	cohuck@redhat.com
Cc: linux-kernel@vger.kernel.org,
	JianChunfu <chunfu.jian@shingroup.cn>
Subject: [PATCH] vfio: change the description of VFIO_IOMMU_SPAPR_REGISTER_MEMORY
Date: Fri, 12 Apr 2024 16:53:33 +0800
Message-Id: <20240412085333.1286724-1-chunfu.jian@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrsz:qybglogicsvrsz4a-1

The type1 ioctl(VFIO_IOMMU_MAP_DMA/VFIO_IOMMU_UNMAP_DMA) won't be called
in SPAPR machine, which is replaced by VFIO_IOMMU_SPAPR_TCE_CREATE/
VFIO_IOMMU_SPAPR_TCE_REMOVE, so change the description.

Signed-off-by: JianChunfu <chunfu.jian@shingroup.cn>
---
 include/uapi/linux/vfio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 2b68e6cdf..30efc8af4 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1764,7 +1764,7 @@ struct vfio_eeh_pe_op {
  *
  * Registers user space memory where DMA is allowed. It pins
  * user pages and does the locked memory accounting so
- * subsequent VFIO_IOMMU_MAP_DMA/VFIO_IOMMU_UNMAP_DMA calls
+ * subsequent VFIO_IOMMU_SPAPR_TCE_CREATE/VFIO_IOMMU_SPAPR_TCE_REMOVE calls
  * get faster.
  */
 struct vfio_iommu_spapr_register_memory {
-- 
2.27.0


