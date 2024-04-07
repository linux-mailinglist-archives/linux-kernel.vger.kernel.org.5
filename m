Return-Path: <linux-kernel+bounces-134199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6163689AEE5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237E9283958
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EAF101E2;
	Sun,  7 Apr 2024 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="npZe+EMF"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329D6AB9
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712472008; cv=none; b=slHM5bie5GJQT4KKgSRwlTHmjVK8NczuU8eZG+6CXvff6Jx1cvSLY63dFTtNVpb8FGENT7mAPKlSQlkCnNHmXKI26Wpd7d2gLdkM2UqCDoyKtSdKQxSIbvcL6R9n7NCtsjBpdd+WHtRdW9pWfC9/z/S6832WjjzHF/TH4VfieJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712472008; c=relaxed/simple;
	bh=EDme76Z+ylKLSbG8Dp1ltOqdaUPnG4XfBjCzunJnxyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYBtzrI74bKyMLRrRUU1QEc/KvBGjALW69q8xZdRAwaE0XDeCqs4y6/tk8E9Lnu+PEh56IHiGZubIIiUl/pQ5/wM5C652AGM6+1w2ZJDv0kKTa8F7gxmGnJ3Xobg+1dIyfPdzi75EFEVf9LG0s4osP7EIlDM/v+b50pQ/6jc2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=npZe+EMF; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712471997; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=dvtlUfZMwcpJa+7Ecw8O4/rWENt4hMvDpxuBMY7/pw0=;
	b=npZe+EMFTM36tcEd8JVyd4ebB0p4CL5nHgYPTkJ538Vm1FI1Ssagci5+ymE5MyHYM5Fc5dOgllf6DSZ1ka6y+n2dwKcxqD+btLX7ng2NHYx6bJBd3XeqVaC8mi4pMOZxr/Rl+4nf33GArWssK3n7zPLhUPhvzTB9FVLVI2opR3A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W4.ZytW_1712471996;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W4.ZytW_1712471996)
          by smtp.aliyun-inc.com;
          Sun, 07 Apr 2024 14:39:57 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: arnd@arndb.de,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 2/3] powerpc: Fix kernel-doc comments in fsl_gtm.c
Date: Sun,  7 Apr 2024 14:39:51 +0800
Message-Id: <20240407063952.36270-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20240407063952.36270-1-yang.lee@linux.alibaba.com>
References: <20240407063952.36270-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=n
Content-Transfer-Encoding: 8bit

Fix some function names in kernel-doc comments.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/powerpc/sysdev/fsl_gtm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_gtm.c b/arch/powerpc/sysdev/fsl_gtm.c
index 39186ad6b3c3..71e07883eb48 100644
--- a/arch/powerpc/sysdev/fsl_gtm.c
+++ b/arch/powerpc/sysdev/fsl_gtm.c
@@ -77,7 +77,7 @@ struct gtm {
 static LIST_HEAD(gtms);
 
 /**
- * gtm_get_timer - request GTM timer to use it with the rest of GTM API
+ * gtm_get_timer16 - request GTM timer to use it with the rest of GTM API
  * Context:	non-IRQ
  *
  * This function reserves GTM timer for later use. It returns gtm_timer
@@ -110,7 +110,7 @@ struct gtm_timer *gtm_get_timer16(void)
 EXPORT_SYMBOL(gtm_get_timer16);
 
 /**
- * gtm_get_specific_timer - request specific GTM timer
+ * gtm_get_specific_timer16 - request specific GTM timer
  * @gtm:	specific GTM, pass here GTM's device_node->data
  * @timer:	specific timer number, Timer1 is 0.
  * Context:	non-IRQ
@@ -276,7 +276,7 @@ EXPORT_SYMBOL(gtm_set_timer16);
  * crop precision of the "usec" argument, thus usec is limited to 16 bits
  * (single timer width).
  */
-int gtm_set_exact_timer16(struct gtm_timer *tmr, u16 usec, bool reload)
+int gtm_set_exact_utimer16(struct gtm_timer *tmr, u16 usec, bool reload)
 {
 	/* quite obvious, frequency which is enough for µSec precision */
 	const int freq = 1000000;
-- 
2.20.1.7.g153144c


