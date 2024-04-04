Return-Path: <linux-kernel+bounces-131758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DDC898B80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48ABB29228
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760BC13246F;
	Thu,  4 Apr 2024 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyZNI5d0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB5130AC7;
	Thu,  4 Apr 2024 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245565; cv=none; b=skiLKbb8iEIe6W5ny1ktbbvidixp2Z3dinVGp4h9s18IssYlrL+I2L7F92MzG0kVYXVTiK84EBep+jGCsBO7ZwDIFtq9/002pfA5522N4in5cwrhyOb+zvy/hfbCmusMjBUiu/CimsrgXPz3mp8069M/tEeUAtiH5GWsktLTzrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245565; c=relaxed/simple;
	bh=0zdNtgo/Mi03+32brAD9ZsQQUigrMfXyFWjV5uvo34w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4xgL/b4F4ZkAhpB77AreDNsz4defcFZrJRbThHGILquYhFDWbx+xTbbjsdygFR6lWystzN2ieJhxPFiM/TFZ224hegFmTyoZ9rZV7lJhZnafh29AzPMUvv17ksIxZcQkFRHDC9j99tj39m8woOyoGRYq9ZiYG+VnQPw98zq9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyZNI5d0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712245564; x=1743781564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0zdNtgo/Mi03+32brAD9ZsQQUigrMfXyFWjV5uvo34w=;
  b=HyZNI5d069LO6orr0Ksgq0Gnk3qwF2vGqbFbprMUWVYfuIlSBQsYFxfE
   xjaxmYIgBGshNl4odULEdBJrKq1GjhNKUNC/NrN7lVCGsumOdogry3oUB
   NPjuQfF3wBSq5VOtumOybsptI8gp8lTBraj4jIlUMy/xAbjk1VxUrYdRj
   EnyyOQ/Fq9s8xh+eSluVX6EU1QgfvyW5mXlwx89ltGeH10wBgwjtY0Ubn
   OFuT7RJcOQDNRlNSOoqb9CokPrzSTVNYdqmgKFLUaQMSNPpO8Cs42Sqqo
   EvlYtVSyYyY7X9XHaonFXJK+VrusmTuANhf20r5Al6Q09H5oR/ebJDtqW
   Q==;
X-CSE-ConnectionGUID: ljT0vCrdRw2UmxkRist3tw==
X-CSE-MsgGUID: 8B99gFPISdehL2zKkrpR4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11312184"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11312184"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:46:04 -0700
X-CSE-ConnectionGUID: FHLVSIiOR0mFs333aBuJww==
X-CSE-MsgGUID: 3qwMB2+XR9Kfr0a3faOH4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23288071"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 08:46:00 -0700
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
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v9 4/9] slab: introduce kvmalloc_array_node() and kvcalloc_node()
Date: Thu,  4 Apr 2024 17:43:57 +0200
Message-ID: <20240404154402.3581254-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404154402.3581254-1-aleksander.lobakin@intel.com>
References: <20240404154402.3581254-1-aleksander.lobakin@intel.com>
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


