Return-Path: <linux-kernel+bounces-157692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 272FE8B14A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7872287C30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69F9156F3A;
	Wed, 24 Apr 2024 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHiicivi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835DE156977;
	Wed, 24 Apr 2024 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990985; cv=none; b=f7lt0FeY3gXYB49PprWfRp/1JgiLeLXeeis6285CNBBw0h0XMqNHtgyliQQTfvHH4KDWLFYsZ9LrugPO8clAM0S85cIo22OPVYRE7BiO2BT9pzDB01ELUMDdZi0W3fg+I7swASlhUmhqSgFtx5DFbuNdGUvb0R7V7O7/uozrWG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990985; c=relaxed/simple;
	bh=zZmH3xX28SQ2pUWgk2lAvl57x27IJI+kDimKqwXst20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSnuAVWeRRx2uFvZEsaeKHUIldLStMtMUiArpoSj3nMIHc3a945xaEIxT35HfLfNMdkIHzp16W7KwIMvKvu8dqLEYtAR+PcI11je6r7lvKJZxsHpPaMUE/6Vifmg23fBAH+BQOK7Qf1ouJBeQ8kpj1Cv0cwhGsaEU1alJvKMn6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHiicivi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713990983; x=1745526983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zZmH3xX28SQ2pUWgk2lAvl57x27IJI+kDimKqwXst20=;
  b=DHiicivi0tlI49FcVYr66zESWWCDUPFjCz0IKhnrBntu9y0pzwAVyHw6
   ft9s1vRRVvovYlmNp9KCu/totpySstGJuHzGBZbkfIM/vA3GmfXDQXcbw
   ecX6aVHnajyoijywJRpCOwykOq+rBCf31pRvLxW1f5yJN5199c8ae/8lc
   8BeGtKbYvCHWSbAmdAvAJIhqDiaDk9jx0/UWmbQx3/tlhd4OqixLfvKFl
   yeUS0ZEd0Zw8O+j+Tui0Z6LVuGkfew5a3M0mk+NIDwVP5fy1+Rzswxgt1
   USv8pb6Dxr9NhrI5epZeyjCGITWPfh70jVSQG49N9mZD97tHcevEhf08q
   g==;
X-CSE-ConnectionGUID: c5pcFuwfRC6ndKkhseP6KQ==
X-CSE-MsgGUID: DtHAkiOpRCinC/QtV1oidQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9511927"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9511927"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 13:36:19 -0700
X-CSE-ConnectionGUID: EPADQ5bDTwGkPAR5b69dPw==
X-CSE-MsgGUID: XrKnXTjwSQageb3PKaewdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="29314986"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 24 Apr 2024 13:36:19 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	hawk@kernel.org,
	linux-mm@kvack.org,
	przemyslaw.kitszel@intel.com,
	alexanderduyck@fb.com,
	ilias.apalodimas@linaro.org,
	linux-kernel@vger.kernel.org,
	linyunsheng@huawei.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	cl@linux.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz
Subject: [PATCH net-next v11 04/10] slab: introduce kvmalloc_array_node() and kvcalloc_node()
Date: Wed, 24 Apr 2024 13:35:51 -0700
Message-ID: <20240424203559.3420468-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240424203559.3420468-1-anthony.l.nguyen@intel.com>
References: <20240424203559.3420468-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

Add NUMA-aware counterparts for kvmalloc_array() and kvcalloc() to be
able to flexibly allocate arrays for a particular node.
Rewrite kvmalloc_array() to kvmalloc_array_node(NUMA_NO_NODE) call.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.41.0


