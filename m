Return-Path: <linux-kernel+bounces-20227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BA0827C35
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E717D1C232DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38546186C;
	Tue,  9 Jan 2024 00:47:36 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEA71844;
	Tue,  9 Jan 2024 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-GKshY_1704761249;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W-GKshY_1704761249)
          by smtp.aliyun-inc.com;
          Tue, 09 Jan 2024 08:47:30 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: jonathan.cameron@huawei.com,
	dave@stgolabs.net
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] cxl: Remove duplicated include in cdat.c
Date: Tue,  9 Jan 2024 08:47:28 +0800
Message-Id: <20240109004728.54703-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files core.h is included twice in cdat.c,
so one inclusion can be removed.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/cxl/core/cdat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index f5e649407b8b..6fe11546889f 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -9,7 +9,6 @@
 #include "cxlmem.h"
 #include "core.h"
 #include "cxl.h"
-#include "core.h"
 
 struct dsmas_entry {
 	struct range dpa_range;
-- 
2.20.1.7.g153144c


