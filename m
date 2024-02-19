Return-Path: <linux-kernel+bounces-71987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6C85AD7A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6566DB21D89
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BF1537E3;
	Mon, 19 Feb 2024 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nSfhB46D"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BA0482C3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375871; cv=none; b=kwcuRzc7uo2g1QJ9iQJw4JvuhT/5XdZuPNBdNUO7Ypi+rNXL8fZtqGykiv1LgN0DnujmbW4SKCVDpPRVa9xr+pTVytDhgjrz5ZMXNktgZofXrsft1JoTE2plxcLfvKIRYiBg4V3BYwgkSdGina462pXe02S1zQDqF+shNkJTri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375871; c=relaxed/simple;
	bh=Q8thPJRfpgc9+wT7IvwXgRA+nbwQjXmEwTEG9AzjJBU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BudwQ9Fqk1MU+QLiHyNL3zIaZhAJLSRDN04JHuuUtLjuQ2uScYvolhx5NcfEOBxsP7MVmF6UZchJNMB9NU+iHLo0isZ8snnCXNBZ6GnyCwifJAF8AWiDuM6vGOKpc+NV8E8tn73oQA9rAaJZ5iSA8kCmE0MP5DRfVQzs5zB+dEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nSfhB46D; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708375866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pWEO3ujEnp3IBbqfF6yum0hAVIJP6wYM9GAwk4wwij4=;
	b=nSfhB46DbXXbhi5BXP7LdZxeNZmCa8Exn7KWD7VLiyU2FaocvWZthoWQdlPGlDUVwf2qEe
	Wv+VJvCnL6E/QYazSu6nk7IyYSKsr565y6CV7twE3XlMApQMUeivX1bG2SazOilP2h1JEG
	99z1hpSs6uZI7B/sfLXs+rZs0KFuJ7Q=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: mailmap: update the email address
Date: Mon, 19 Feb 2024 12:50:50 -0800
Message-Id: <20240219205050.887810-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Moving to linux.dev based email for kernel work.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 1eb607efcc6e..6ac0d469c7fa 100644
--- a/.mailmap
+++ b/.mailmap
@@ -553,6 +553,7 @@ Senthilkumar N L <quic_snlakshm@quicinc.com> <snlakshm@codeaurora.org>
 Serge Hallyn <sergeh@kernel.org> <serge.hallyn@canonical.com>
 Serge Hallyn <sergeh@kernel.org> <serue@us.ibm.com>
 Seth Forshee <sforshee@kernel.org> <seth.forshee@canonical.com>
+Shakeel Butt <shakeel.butt@linux.dev> <shakeelb@google.com>
 Shannon Nelson <shannon.nelson@amd.com> <snelson@pensando.io>
 Shannon Nelson <shannon.nelson@amd.com> <shannon.nelson@intel.com>
 Shannon Nelson <shannon.nelson@amd.com> <shannon.nelson@oracle.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index ca48f2d37892..4dc0ad25e4ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5412,7 +5412,7 @@ CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)
 M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Michal Hocko <mhocko@kernel.org>
 M:	Roman Gushchin <roman.gushchin@linux.dev>
-M:	Shakeel Butt <shakeelb@google.com>
+M:	Shakeel Butt <shakeel.butt@linux.dev>
 R:	Muchun Song <muchun.song@linux.dev>
 L:	cgroups@vger.kernel.org
 L:	linux-mm@kvack.org
-- 
2.34.1


