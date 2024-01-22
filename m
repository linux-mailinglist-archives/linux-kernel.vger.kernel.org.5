Return-Path: <linux-kernel+bounces-32581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9A0835D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF521F2632E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9EF39AC4;
	Mon, 22 Jan 2024 08:59:57 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA6639AEC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913996; cv=none; b=VBUSKJ2kCXigT6nkZUSLdIRunn6I8w2UHd8BappD0LRKApgXz+V6rGcmj9DzJAvyQFDEfLYWhXNrxlM5+AL9fnp0d5XUz67yEwwjEoc+8sbC9BOz7mvOV7mnhPGaYt0RaV5b0DSmD8c6p4fT11SWcmE/l4e9MKOIebPypGhK8JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913996; c=relaxed/simple;
	bh=CQEbSv1ygZpxNu29WM/7aTyIQjnAU4JUdrf0Z7hNaJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aVrTeyjNsJDUhQ1nvbm01OobNTdC5WwB7KgL2e1SXxmaMO1qVfEPT7FUug4Ry17tMU+Wb9iXYIEUSlBlDGMxAMjPCicupudlfOkSstvvyuegpJ7oc9R93igeL1FKyTmu9gQfSUeA/wX7R/1vo+Fneg6+9hkw4u6/qbLf6nJFyEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp67t1705913961t85cfrv6
X-QQ-Originating-IP: Zbqb4cYRrAfjgdkohOYDHL1acuGqxCL9qIdSGxPWK34=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jan 2024 16:59:20 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: IcCSTr/hHjMffnhAik5vVQWmaGruOwvbYfTo1SfI6PpCNqAHo+YFVhP6/2EVs
	OvyWr6QV8R9qZ4irF4Ej2pLyo52eCxA4oFcYLvNb57Ub1ZUHXR7Os2AcCRq0O8Mx4iOQDhX
	tKBK1G/DetFIa4bmLR4/942oRRCAMw82GYsIs9pxgswpRCrsuvvEOaP40u0pTOVuYdhVZaw
	adJKmSGHazuAlTR0Q4oxmQ0yeOzv8WBW8h+dZHNuByhtxZwkqoXxfIPvDyOqab/E1Sza4xD
	NXcYEzOxyjoqdrM/47njdBzZcugj7EtGPY4ZavaWgr+ggVM7GAJDJGUdmA3NyO8D/lgzin9
	VcCBzAKd+xA/jOknqYgNY2xXInfmtUd8Jd+nZE2IzGN9jBuBWRB5+OI8+ieLQZyvlZ3ep8L
	1bhxTPYF4dUS+0i3GlOsZM/mMBVm0MG1
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2264952194026769334
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	maz@kernel.org
Cc: sdonthineni@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawei.li@shingroup.cn,
	set_pte_at@outlook.com
Subject: [PATCH v2 3/5] genirq: Remove unneeded forward declaration
Date: Mon, 22 Jan 2024 16:57:14 +0800
Message-Id: <20240122085716.2999875-4-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240122085716.2999875-1-dawei.li@shingroup.cn>
References: <20240122085716.2999875-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Protoype of irq_flow_handler_t is independent of irq_data, so
remove unneeded forward declaration.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 include/linux/irqhandler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqhandler.h b/include/linux/irqhandler.h
index c30f454a9518..72dd1eb3a0e7 100644
--- a/include/linux/irqhandler.h
+++ b/include/linux/irqhandler.h
@@ -8,7 +8,7 @@
  */
 
 struct irq_desc;
-struct irq_data;
+
 typedef	void (*irq_flow_handler_t)(struct irq_desc *desc);
 
 #endif
-- 
2.27.0



