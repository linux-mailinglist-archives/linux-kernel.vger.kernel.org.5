Return-Path: <linux-kernel+bounces-149981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896EE8A98BC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF691C21DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C09C15FA88;
	Thu, 18 Apr 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyB+EtjK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7295E15FA60;
	Thu, 18 Apr 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440215; cv=none; b=JUu3m/KrmjRtkNJFp4Watdo2Q4j7trRE74585e3drJpO6pyMbWmpmVn2EZ6DsqqjbCKiI4RelKItpPie6BnoAKGJpDKEB+2eMYFZfq6nYLWtbPhL7DJIl9tTXUvqZAhvLFz99zi6gtTeLoqINkidGeD75CP054IkTbrjwNQRqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440215; c=relaxed/simple;
	bh=syWx/uUcwsTOQI6+xcaFeTqHxPcGMGtyCLv4nt7fle0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGVfd5wDhET+Rl3RCbkWOs2kVVKW/uR26GOee3hdAH4XVWrLecrjifq31KooEqM9y96cCV+OXP1BxruXlN8i9Om3t8+T3bg0Ga7MOpX4cD6+/1vtaIuTr5s/jfT1Y3qnFX3wR56VClqBR17NrlXlN4jNP5M3kOpz3HaeUEy6gkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyB+EtjK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713440213; x=1744976213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=syWx/uUcwsTOQI6+xcaFeTqHxPcGMGtyCLv4nt7fle0=;
  b=kyB+EtjK77c0Gp23c7M8QeZrvwxYimlTA4QWmd3CkkUaTDgTxv9Xp7rf
   kEFMWqX3jYrxmZkGl4g0XiwK4YuOHcAYfRMnz+CxTc+8TQAf7BDp1o7jf
   rHYHt32J6y8+mQPCVgfQgFlWckZKgbVtCDqhwwca/8PFkg8LPoTIlxTad
   v+7e692CNjIFzBJSOx0nRgaUjQagw4fnsUvEfHZaXWf1GupLWa3714xhZ
   cULbYNyXa30g+fSQFBIab9muZFkgq4uDY6EAZlz4GDkg/zsBH8q7NOcTk
   zQ0EMxwsn2gCVeejtorT8Sc2J0lTM5y7XIl+cBBwkE0JMEAG7gJ7glob8
   Q==;
X-CSE-ConnectionGUID: UO0yOYawS+ia7I1Z1CYw5w==
X-CSE-MsgGUID: JPFQnlypS+6ffWgidUVtaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19587756"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="19587756"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:36:53 -0700
X-CSE-ConnectionGUID: HXMUFYHRRgibQBfXelcTig==
X-CSE-MsgGUID: vt0ToixcSya53zqx9wF8uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27586111"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 18 Apr 2024 04:36:49 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Christoph Lameter <cl@linux.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v10 04/10] slab: introduce kvmalloc_array_node() and kvcalloc_node()
Date: Thu, 18 Apr 2024 13:36:10 +0200
Message-ID: <20240418113616.1108566-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418113616.1108566-1-aleksander.lobakin@intel.com>
References: <20240418113616.1108566-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NUMA-aware counterparts for kvmalloc_array() and kvcalloc() to be
able to flexibly allocate arrays for a particular node.
Rewrite kvmalloc_array() to kvmalloc_array_node(NUMA_NO_NODE) call.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/slab.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index e53cbfa18325..d1d1fa5e7983 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -774,14 +774,27 @@ static inline __alloc_size(1) void *kvzalloc(size_t size, gfp_t flags)
 	return kvmalloc(size, flags | __GFP_ZERO);
 }
 
-static inline __alloc_size(1, 2) void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
+static inline __alloc_size(1, 2) void *
+kvmalloc_array_node(size_t n, size_t size, gfp_t flags, int node)
 {
 	size_t bytes;
 
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
 		return NULL;
 
-	return kvmalloc(bytes, flags);
+	return kvmalloc_node(bytes, flags, node);
+}
+
+static inline __alloc_size(1, 2) void *
+kvmalloc_array(size_t n, size_t size, gfp_t flags)
+{
+	return kvmalloc_array_node(n, size, flags, NUMA_NO_NODE);
+}
+
+static inline __alloc_size(1, 2) void *
+kvcalloc_node(size_t n, size_t size, gfp_t flags, int node)
+{
+	return kvmalloc_array_node(n, size, flags | __GFP_ZERO, node);
 }
 
 static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gfp_t flags)
-- 
2.44.0


