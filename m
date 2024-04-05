Return-Path: <linux-kernel+bounces-133080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DC0899E85
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 806F0B24BF5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E230916D9C6;
	Fri,  5 Apr 2024 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJBnq748"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9828F16D32D;
	Fri,  5 Apr 2024 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324356; cv=none; b=sVQEaRbEgXRPmLhRJNhlfMDRS48oMnI85NniFjenWNJAjhEGLMZr63sNC5Xt1Mcm2NLTlulevu5Nq5gfNp3lV1s/YcoJe6e+fg7YQGKiI0SeJ74rwjx2i46YqpplByqxyydcVO1kerLf+ECrUZJqwCaZcffrm57b9VL3vxjf1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324356; c=relaxed/simple;
	bh=chdvng0K3Hd11kpvNdPEm+bKbLvFuFcKSgGlg1THekk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIOXQ6v2axa0tam9/3jjm2Xgk22MX9bStKlzbB9KHKuEVyP1WGKG5KKBmx82GPJQkDQdwyDJQgNFQrv9UGAf9CI/48Popa0kxoGpoDRxT4srhop2B81341lJNoLl4dQ6HUxPW+QH498KTwn43uIAs7pQPsOnc3Zg7A1wvmGCcC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJBnq748; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712324354; x=1743860354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=chdvng0K3Hd11kpvNdPEm+bKbLvFuFcKSgGlg1THekk=;
  b=GJBnq7480HGQ9YH9VcElzMQTonS5cqdx4r9jUtYMs+30wwqiDlCBDtnM
   bYQ8X/lUroS/HSZMN6BTXbI0s+QsTgvjc8Lh9uTs0tug9VaQKgSvfpvVJ
   0lWwJjwHcLI5Ngcd4nHYShxTALi3etsrzVAgb/5g5JdBpcKxGpF+UCStK
   HH/9UyTdq1LSlOXM7rGscGfRumhiC+mjess4hvBohKttALp9/A52RmdIG
   unz576ej3FhJj0J4YlIqNAgZj/PazK6QBWGp69TiAP944FXpQSmy0vtQx
   7iM+uSOVgPVcx52kCKhrpIyyzbn/qVFpzD792gt5XokJuw0S2dV3Q5Aq2
   w==;
X-CSE-ConnectionGUID: egcmhnkESdq9U+Ox+j30dA==
X-CSE-MsgGUID: 9hb7eYDiSzKtPbUqFVrgmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18219545"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18219545"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 06:39:14 -0700
X-CSE-ConnectionGUID: krKqD6SzRVK/NdCg/p/PsQ==
X-CSE-MsgGUID: fVB5MhOyS+SIumU8yq5Lbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19600090"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa007.jf.intel.com with ESMTP; 05 Apr 2024 06:39:12 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew@lunn.ch>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 1/7] netdev_features: remove unused __UNUSED_NETIF_F_1
Date: Fri,  5 Apr 2024 15:37:25 +0200
Message-ID: <20240405133731.1010128-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NETIF_F_NO_CSUM was removed in 3.2-rc2 by commit 34324dc2bf27
("net: remove NETIF_F_NO_CSUM feature bit") and became
__UNUSED_NETIF_F_1. It's not used anywhere in the code.
Remove this bit waste.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/netdev_features.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 7c2d77d75a88..44c428d62db4 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -14,7 +14,6 @@ typedef u64 netdev_features_t;
 enum {
 	NETIF_F_SG_BIT,			/* Scatter/gather IO. */
 	NETIF_F_IP_CSUM_BIT,		/* Can checksum TCP/UDP over IPv4. */
-	__UNUSED_NETIF_F_1,
 	NETIF_F_HW_CSUM_BIT,		/* Can checksum all the packets. */
 	NETIF_F_IPV6_CSUM_BIT,		/* Can checksum TCP/UDP over IPV6 */
 	NETIF_F_HIGHDMA_BIT,		/* Can DMA to high memory. */
-- 
2.44.0


