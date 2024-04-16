Return-Path: <linux-kernel+bounces-147659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A268A76FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01C60281CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC8F136E28;
	Tue, 16 Apr 2024 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k47p6TEH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D26EB65;
	Tue, 16 Apr 2024 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713304021; cv=none; b=r0oVheOWAGjwbUIXFM+s1rC+dVUTHW6PUYkwjfHksEYomVuoOI8FIx1DuuhSswhNqpPv6zGMa1NXMNfolBcWQzWdm7QMPKbWBa2RT1aoSX24EikvxQAu5f6ApiNrsjTSPUHk1654FVvZxc4KvaEp2iXcm5FGOEHw/icFJ4SR6G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713304021; c=relaxed/simple;
	bh=psiSCf8lZOYgQBeohr4J/sdl0OC+/xsZnCHQ3I57Cyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qaxA3piF1QW7HB/kM+2XPKImrNB1CBhdq1NrUr8ltljQBMq787be82FBJAgW8PfNMlXLupXE3+zz+svF13wgDgX7KgfncEHXgU7aYJ7DSvQF6DD4Gqacr3ZYOYFfAeJpSCPLSU3CTf+A5jH6StgfxxFDQlFZNg0Qw9tdSvWRORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k47p6TEH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713304021; x=1744840021;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=psiSCf8lZOYgQBeohr4J/sdl0OC+/xsZnCHQ3I57Cyc=;
  b=k47p6TEHqzWNHO62ye5ZPFga78F/hF3GEZXclYwgMc+fsmMFVzu3Eoe1
   0/LUayTv5agz9CzIy8lAaOin/Ki0o/Lw2SkCSx0yitTIKH5pDtjMHPsCn
   NoTXZi8vq71k3V443+4NvFArK6sztESXpyDNbOeRpmmZgf0T7l6JGUjpE
   OlvynHFpnzU9IzzjkFQcGw+2hskglvuo+pGIOQntTNas83RT2eXj9ckab
   irs9xt+b6kf/jbRC894tVoahbDQHlY1X7wz6+ETYARyc3fvRnCyIsybzm
   rYeJY/3UKC0HK6b9hrEDvmbtfOk7+CQ9GZxK19aBWGIQbXtf7hwpIhTFS
   Q==;
X-CSE-ConnectionGUID: 8G34HNdcR4+IS5eyMlUafw==
X-CSE-MsgGUID: JSsMBVkfRlWJkkn5jHpoyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12553103"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="12553103"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:46:42 -0700
X-CSE-ConnectionGUID: 07RsA2yoRfu9UMmVybWr+A==
X-CSE-MsgGUID: YivqiNc6SxGhJL2ATRp77A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22464263"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.14.216])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:46:42 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Tue, 16 Apr 2024 15:46:19 -0600
Subject: [PATCH v2 4/4] dax/bus.c: Use the right locking mode (read vs
 write) in size_show
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-vv-dax_abi_fixes-v2-4-d5f0c8ec162e@intel.com>
References: <20240416-vv-dax_abi_fixes-v2-0-d5f0c8ec162e@intel.com>
In-Reply-To: <20240416-vv-dax_abi_fixes-v2-0-d5f0c8ec162e@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.14-dev-5ce50
X-Developer-Signature: v=1; a=openpgp-sha256; l=980;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=psiSCf8lZOYgQBeohr4J/sdl0OC+/xsZnCHQ3I57Cyc=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDGlyH/cz7pX0cJ375bC3otT2ot7lH8M3hFf7VJ0Qrb998
 9M9TcEDHaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZiI/DuGP3zLNh9X/5/4Jm55
 1eN3wkqiEVnBof/1RB6m3fG4t2fZKhuG/wlvHFblPBLLiJ75/QdXs/WBmVsZJzb/j1u505jhodO
 NTF4A
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

In size_show(), the dax_dev_rwsem only needs a read lock, but was
acquiring a write lock. Change it to down_read_interruptible() so it
doesn't unnecessarily hold a write lock.

Cc: Dan Williams <dan.j.williams@intel.com>
Fixes: c05ae9d85b47 ("dax/bus.c: replace driver-core lock usage by a local rwsem")
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/dax/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index db183eb5ce3a..66095e60a279 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -939,11 +939,11 @@ static ssize_t size_show(struct device *dev,
 	unsigned long long size;
 	int rc;
 
-	rc = down_write_killable(&dax_dev_rwsem);
+	rc = down_read_interruptible(&dax_dev_rwsem);
 	if (rc)
 		return rc;
 	size = dev_dax_size(dev_dax);
-	up_write(&dax_dev_rwsem);
+	up_read(&dax_dev_rwsem);
 
 	return sysfs_emit(buf, "%llu\n", size);
 }

-- 
2.44.0


