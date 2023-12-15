Return-Path: <linux-kernel+bounces-626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C25E8143C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AFD283AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D25C171CB;
	Fri, 15 Dec 2023 08:37:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8331B171B4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4Ss2Yz6k12zB2kVJ
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:33:59 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 15 Dec
 2023 16:37:29 +0800
Date: Fri, 15 Dec 2023 16:37:29 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: <linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH] bus: bt1-apb: remove duplicated including clk.h
Message-ID: <202312151637+0800-wangjinchao@xfusion.com>
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

remove second #include <linux/clk.h>

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 drivers/bus/bt1-apb.c        | 1 -
 tools/include/uapi/drm/drm.h | 8 +-------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index e97c1d1c7578..595fb22b73e0 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -22,7 +22,6 @@
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/time64.h>
-#include <linux/clk.h>
 #include <linux/sysfs.h>
 
 #define APB_EHB_ISR			0x00
diff --git a/tools/include/uapi/drm/drm.h b/tools/include/uapi/drm/drm.h
index de723566c5ae..c7f5a21e47a2 100644
--- a/tools/include/uapi/drm/drm.h
+++ b/tools/include/uapi/drm/drm.h
@@ -35,13 +35,7 @@
 #ifndef _DRM_H_
 #define _DRM_H_
 
-#if defined(__KERNEL__)
-
-#include <linux/types.h>
-#include <asm/ioctl.h>
-typedef unsigned int drm_handle_t;
-
-#elif defined(__linux__)
+#if defined(__KERNEL__) || defined(__linux__)
 
 #include <linux/types.h>
 #include <asm/ioctl.h>
-- 
2.40.0


