Return-Path: <linux-kernel+bounces-46425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AE4843F75
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB9F283CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A7D79DA3;
	Wed, 31 Jan 2024 12:32:28 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7A76C85;
	Wed, 31 Jan 2024 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704348; cv=none; b=D5WnpQCoAv3/sPp5Df7W5dsoNQtnVaEUyDlepSQqaXD0jegJ0Vbze1J/uasDde36Fxux2ap7VYFpHRQZWqkT5VuKJr7zosAeK7Z0dd0QuBShaOcKB+bKDz2RQ+ALzlBSf1Z073c9dwaIVGuoBPQfU+SmNpiw+xpSlqNrg5EBPWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704348; c=relaxed/simple;
	bh=FED9EEmMKE+UuTS+51bHGBf+zW3QlM2itO24OOhtWuk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oNSW1IpgENX0jgw1+sZyEXgq6xm7rDY4WIwNhOX/vRr/MF4IfSfjltzkEkxko/DRvAL7zXp5s0VF3cIHx4DRqS0u0bR3E4sMyr98qwoUl1lo5wg/scVsSZfTcUfZnuOCeSbGYNooUAwaEr6dBizLw7Fc8xbo51o9KGDSQ9m8I7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TQ1bC3Zwsz1Q89B;
	Wed, 31 Jan 2024 20:30:31 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (unknown [7.185.36.186])
	by mail.maildlp.com (Postfix) with ESMTPS id 580C01404F7;
	Wed, 31 Jan 2024 20:32:22 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 20:32:22 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: <corbet@lwn.net>
CC: <mingo@kernel.org>, <chrubis@suse.cz>, <zhangqiao22@huawei.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/Documentation: Add RT_RUNTIME_SHARE documentation
Date: Wed, 31 Jan 2024 20:32:38 +0800
Message-ID: <20240131123238.2332064-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500018.china.huawei.com (7.185.36.186)

RT_RUNTIME_SHARE is an important strategy for rt bandwidth, and
we should document this sched feature.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 Documentation/scheduler/sched-rt-group.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index d685609ed3d7..4d8eceb71f5e 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -12,6 +12,7 @@ Real-Time group scheduling
      2.1 System-wide settings
      2.2 Default behaviour
      2.3 Basis for grouping tasks
+     2.4 RT_RUNTIME_SHARE sched feature
    3. Future plans
 
 
@@ -146,6 +147,16 @@ For now, this can be simplified to just the following (but see Future plans):
 
    \Sum_{i} runtime_{i} <= global_runtime
 
+2.4 RT_RUNTIME_SHARE sched feature
+----------------------------
+
+RT_RUNTIME_SHARE allows a cpu borrows rt-runtime from other cpus if it runs
+out of its own rt-runtime.
+
+With this feature enabled, a rt-task probably hits 100% cpu usage and starves
+per-cpu tasks like kworkers, as a result, it may hang up the whole system.
+Therefore, in order to avoid such exception, recommand to disable this feature
+by default unless you really know what you're up to.
 
 3. Future plans
 ===============
-- 
2.18.0.huawei.25


