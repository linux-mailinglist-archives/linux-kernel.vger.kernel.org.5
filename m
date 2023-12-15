Return-Path: <linux-kernel+bounces-750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C22814582
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE9E81F23E15
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FEB24A08;
	Fri, 15 Dec 2023 10:24:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48E2421D;
	Fri, 15 Dec 2023 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4Ss4xh4G7CzB1wtN;
	Fri, 15 Dec 2023 18:21:12 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 15 Dec
 2023 18:24:35 +0800
Date: Fri, 15 Dec 2023 18:24:34 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong"
	<djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH] xfs/health: cleanup, remove duplicated including
Message-ID: <202312151823+0800-wangjinchao@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: wuxshcsitd00603.xfusion.com (10.32.134.231) To
 wuxshcsitd00600.xfusion.com (10.32.133.213)

remove the second ones:
\#include "xfs_trans_resv.h"
\#include "xfs_mount.h"

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 fs/xfs/scrub/health.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/xfs/scrub/health.c b/fs/xfs/scrub/health.c
index 5e2b09ed6e29..289f1d4ea6ef 100644
--- a/fs/xfs/scrub/health.c
+++ b/fs/xfs/scrub/health.c
@@ -10,8 +10,6 @@
 #include "xfs_trans_resv.h"
 #include "xfs_mount.h"
 #include "xfs_btree.h"
-#include "xfs_trans_resv.h"
-#include "xfs_mount.h"
 #include "xfs_ag.h"
 #include "xfs_health.h"
 #include "scrub/scrub.h"
-- 
2.40.0


