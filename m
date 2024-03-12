Return-Path: <linux-kernel+bounces-99969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558A6879001
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2DE281E24
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F28D77F0B;
	Tue, 12 Mar 2024 08:51:19 +0000 (UTC)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F53D77F00
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.245.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233478; cv=none; b=ArZmae9ITXGVV9v/Fh9BT5O9XidYXLMP1tYs0TVkOt0yjnYLSuVE479gC6GRtPDLnB5vx4wuFsSo2JVXq5D4uqNsZiZ+H0niw1O7/y0wkYN19Q0+pJywhzMYL854DKRR8so3sU9y7L3r1ky1J5RPYMLKkZVC84vFLkwbYkEHYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233478; c=relaxed/simple;
	bh=S5iomFnUrrtxFysadkN8mlX0Nqg7EAozy82EtgXSONQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QDtiyUEgRWjRSMQUgd/s2rnXDFBQZidCVu6jdo8DyjodvpNQVxzxO7pmt/Pw4flA614UGPSNrIwSqHZin2bW+IYYnjkMAIWFVVU9TRbRZy18DXYhV2P9CSzJnukfQed6EKDpe/QSkjoaScPXz1wVZa33MyAlvEJQQ6zGnAi7RcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=13.245.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp89t1710233410tehccpoz
X-QQ-Originating-IP: DOnoOFufDcb5RVEBYIup+Q+tSpdOgyJSAuxSeC6ZaQ0=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Mar 2024 16:50:09 +0800 (CST)
X-QQ-SSF: 01400000000000604000000A0000000
X-QQ-FEAT: ILHsT53NKPh80CFepxCx03JaEQRBUglHFn44X8fnE52yuofa7n7EYoqKg2fuy
	DlUJCK3NH1xgApGc9BEjGRLcMrzFyXQllUB18p275gGJSVUjXLh6jTopJxgkvxCqjxJgXns
	9Wcy/EoC28IAI25R/9npkWxUXOjFEWcebgfBMFfPFd933Uyb1ihDdx+AZFB8xCnqqbg7pBk
	6vP2rhQ+10gX896ql/utj1VIH6FUuE/wbzlDoM/Qpq4mLLmLAtQgD7+FNoCVLgbtpkdmxcy
	toGEM5Vga9af1qLZO6COKvLeSsjrtaOnaN/YB497nqGkOFvpiJ/FxpCHHm5grJB9aeP9td5
	u00cPLhETXfCgQ2rZcJXD5dnnnd/3aIIpzmOlXqlwoeAnz56wp6sEHzt63tXQ+/oa0WtYEU
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 10473114766742924544
From: Dawei Li <dawei.li@shingroup.cn>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	set_pte_at@outlook.com,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH] riscv: Remove redundant CONFIG_64BIT from pgtable_l{4,5}_enabled
Date: Tue, 12 Mar 2024 16:50:05 +0800
Message-Id: <20240312085005.298657-1-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

IS_ENABLED(CONFIG_64BIT) in assignment of pgtable_l{4,5}_enabled is
redundant, remove it.

While at it, annotate pgtable_l{4,5}_enabled with __ro_after_init.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 arch/riscv/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index fa34cf55037b..204cdf5b829d 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -50,8 +50,8 @@ u64 satp_mode __ro_after_init = SATP_MODE_32;
 EXPORT_SYMBOL(satp_mode);
 
 #ifdef CONFIG_64BIT
-bool pgtable_l4_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
-bool pgtable_l5_enabled = IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_XIP_KERNEL);
+bool pgtable_l4_enabled __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL);
+bool pgtable_l5_enabled __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL);
 EXPORT_SYMBOL(pgtable_l4_enabled);
 EXPORT_SYMBOL(pgtable_l5_enabled);
 #endif
-- 
2.27.0


