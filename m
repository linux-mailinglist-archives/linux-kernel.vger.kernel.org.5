Return-Path: <linux-kernel+bounces-490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5322A8141E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0048B221DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67302D2F3;
	Fri, 15 Dec 2023 06:44:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA4CCA7D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4Srzgt2QxZzB2Nhw;
	Fri, 15 Dec 2023 14:23:54 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 15 Dec
 2023 14:27:24 +0800
Date: Fri, 15 Dec 2023 14:27:23 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: Russell King <linux@armlinux.org.uk>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH] arm: remove duplicated include
Message-ID: <202312151426+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: wuxshcsitd00602.xfusion.com (10.32.132.250) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)

remove duplicated include

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 arch/arm/include/asm/pgtable.h    | 4 ++--
 arch/arm/mach-footbridge/common.c | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 16b02f44c7d3..8c0de013f85e 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -19,14 +19,14 @@ extern struct page *empty_zero_page;
 #define ZERO_PAGE(vaddr)	(empty_zero_page)
 #endif
 
+#include <asm-generic/pgtable-nopud.h>
+
 #ifndef CONFIG_MMU
 
-#include <asm-generic/pgtable-nopud.h>
 #include <asm/pgtable-nommu.h>
 
 #else
 
-#include <asm-generic/pgtable-nopud.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 85c598708c10..c8f52d52b91b 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -30,7 +30,6 @@
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <asm/hardware/dec21285.h>
 
 static int dc21285_get_irq(void)
 {
-- 
2.40.0


