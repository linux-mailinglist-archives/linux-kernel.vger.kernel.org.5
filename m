Return-Path: <linux-kernel+bounces-151213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41CF8AAB2E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540D91F21600
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A20757F7;
	Fri, 19 Apr 2024 09:05:42 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28A769DFB;
	Fri, 19 Apr 2024 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713517542; cv=none; b=A2qlxunDI2ewc6AiCuP/ZHeYciyS/qhkJaXdNHEQWHcc5Z4gqAWGkfd5jjEAGxLcN280W+81NExTRef3W9WH+bMSxzcxyTreqV2Z2TZFnOSnBNlIdHAjEbQKnEAZpwGn6dAl3saywew34+D7gQMD+nBdGtnJ1oOffuCb5B4CIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713517542; c=relaxed/simple;
	bh=3F263T9DjJp6sF8LRqG6ccucwjDKAexzal9qHEK3RWE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rr11mlU7BFWbSy6bTOoVTQdVRKvrMPMn6f+lvVGtHyQXy21M2vjGXIMTIJM+V6aIAmltCKbYQT/FkOBJNDgjzcYDUPNvIfmPHajK21aaS4zp6Ae4gM5QZHwr2zIO2JuiDQqLADFg5698B37j0qKWhziFC4AiykzemazSEQ8TJ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VLTDx5GkHz1N8Qd;
	Fri, 19 Apr 2024 17:02:41 +0800 (CST)
Received: from canpemm500001.china.huawei.com (unknown [7.192.104.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B50B18006D;
	Fri, 19 Apr 2024 17:05:31 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 17:05:31 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: <mingo@kernel.org>, <chrubis@suse.cz>, <rostedt@goodmis.org>,
	<bagasdotme@gmail.com>, <corbet@lwn.net>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Zhang Qiao
	<zhangqiao22@huawei.com>
Subject: [PATCH v2] sched/Documentation: Add RT_RUNTIME_SHARE documentation
Date: Fri, 19 Apr 2024 17:04:32 +0800
Message-ID: <20240419090432.1935211-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500001.china.huawei.com (7.192.104.163)

RT_RUNTIME_SHARE is an important strategy for rt bandwidth, and
we should document this sched feature.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
Improvements-suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/scheduler/sched-rt-group.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index d685609ed3d7..eea2fc6f068f 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -12,6 +12,7 @@ Real-Time group scheduling
      2.1 System-wide settings
      2.2 Default behaviour
      2.3 Basis for grouping tasks
+     2.4 RT_RUNTIME_SHARE sched feature
    3. Future plans
 
 
@@ -146,6 +147,17 @@ For now, this can be simplified to just the following (but see Future plans):
 
    \Sum_{i} runtime_{i} <= global_runtime
 
+2.4 RT_RUNTIME_SHARE sched feature
+----------------------------------
+
+RT_RUNTIME_SHARE allows a cpu to borrow rt-runtime from other cpus if it runs
+out of its own rt-runtime.
+
+With this feature enabled, a rt-task may hit 100% cpu usage and can stall other
+per-cpu tasks like kworkers, as a result, which leads into system hang.
+
+Thus, it is advised to disable this feature by default to avoid aforementioned
+issue unless you know what you're doing.
 
 3. Future plans
 ===============
-- 
2.18.0.huawei.25


