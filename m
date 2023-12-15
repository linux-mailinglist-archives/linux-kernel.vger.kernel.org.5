Return-Path: <linux-kernel+bounces-730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5102D814544
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB5F2853CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476B249EF;
	Fri, 15 Dec 2023 10:17:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04582200AD;
	Fri, 15 Dec 2023 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxshcsitd00600.xfusion.com (unknown [10.32.133.213])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4Ss4nP2LMzzB2NhJ;
	Fri, 15 Dec 2023 18:14:01 +0800 (CST)
Received: from localhost (10.82.147.3) by wuxshcsitd00600.xfusion.com
 (10.32.133.213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 15 Dec
 2023 18:17:31 +0800
Date: Fri, 15 Dec 2023 18:17:30 +0800
From: Wang Jinchao <wangjinchao@xfusion.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	<linux-unionfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <stone.xulei@xfusion.com>, <wangjinchao@xfusion.com>
Subject: [PATCH] fs: remove duplicated including of posix_acl.h
Message-ID: <202312151817+0800-wangjinchao@xfusion.com>
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

remove the second including of linux/posix_acl.h

Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
---
 fs/overlayfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index c63b31a460be..2003425875d9 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -14,7 +14,6 @@
 #include <linux/fileattr.h>
 #include <linux/security.h>
 #include <linux/namei.h>
-#include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
 #include "overlayfs.h"
 
-- 
2.40.0


