Return-Path: <linux-kernel+bounces-30054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A886831876
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7F02892BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F54241E9;
	Thu, 18 Jan 2024 11:30:16 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA91E530
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577416; cv=none; b=rchgiHgI+V9gElRJ6jbgd4U9VzGpopB8+F/6A0/NIGEj/E7Ies/Eg9l7ZUoFWCnG/y5EJWD1zPl2FkMQhgz36F3vcq2UHrRKSgTaBWxnZK2+2fwE92pCTe6EAx7cbFqGzYKEwpGwCTKjeeMR2G8MZy9u04LND4FSCcvCRmfMrO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577416; c=relaxed/simple;
	bh=CQEbSv1ygZpxNu29WM/7aTyIQjnAU4JUdrf0Z7hNaJk=;
	h=X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-FEAT:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID; b=JD/B49XYSDP768emGiEnMo9PZo4C/ngCO0uhIpp3R40B+yGN9SCQZNz1gG/Oml82729O+yjBBP9LV3gj0Xc/AblqrUTlK5sSjr3MMf7RfrsS6MoVwUEVe/TDaeVajOZynJBLdf5Gpc+y8LVeQrZumZ0UUjBWq/TvreH/lvXAR2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp72t1705577381tiai0ryj
X-QQ-Originating-IP: TaQ28MjSP3N2N+fKggTDtskVFYbnKkJs6U8Q642YBLY=
Received: from localhost ( [183.209.108.228])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jan 2024 19:29:40 +0800 (CST)
X-QQ-SSF: 01400000000000504000000A0000000
X-QQ-FEAT: 3M0okmaRx3iOREFUUdBFwoewzAHI2Yvwl7ilE395CssjLzFHMoBu2TOyZ0B2h
	a+VDymui4zsvfa0eqS3czqmFOwfp+1ys6kWlUc7nP0lwTPCoArAQ4WcX0br4Yob+d+rZOLS
	zVFrGRpWubl/5dgms51PqjJdWJsDsmxeYri52Jmg3r0PJj6tOm6xyL8l3A9MFepc0OXtGwb
	DDAm0YLDya/Nor91MCyRUscj9Jfav0ZMmeWMB5nO+mvyDUas/AoVkjbRmeQPH+DbF7Z1daV
	M46vEwIxWCM1Njxa410PF5OTN8DF6maySMm8vD0u85kJdMqqYFlZ5TBAe5bAgZrKmCrKpbb
	c1b7Gx3j7ks7UosbTbHC+NgCyE7a2MGro8PZREc46WTC/RQ5XhlfeNVv4ysKAYTEG6Ddqdw
	seBWIvBc07c=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1086565048452587055
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	maz@kernel.org
Cc: sdonthineni@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dawei.li@shingroup.cn,
	set_pte_at@outlook.com
Subject: [PATCH 3/4] genirq: Remove unneeded forward declaration
Date: Thu, 18 Jan 2024 19:27:38 +0800
Message-Id: <20240118112739.2000497-4-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240118112739.2000497-1-dawei.li@shingroup.cn>
References: <20240118112739.2000497-1-dawei.li@shingroup.cn>
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



