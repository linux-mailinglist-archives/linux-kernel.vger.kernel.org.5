Return-Path: <linux-kernel+bounces-646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB91814400
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4D41C226AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FF616426;
	Fri, 15 Dec 2023 08:54:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116DADDB8
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4Ss2y23c1MzB2Nhg;
	Fri, 15 Dec 2023 16:51:22 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 15 Dec
 2023 16:54:52 +0800
Date: Fri, 15 Dec 2023 16:54:51 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young
	<dyoung@redhat.com>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH] crash_core: remove duplicated including of kexec.h
Message-ID: <202312151654+0800-wangjinchao@xfusion.com>
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

remove second include of linux/kexec.h

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 kernel/crash_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..d72985222b16 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.40.0


