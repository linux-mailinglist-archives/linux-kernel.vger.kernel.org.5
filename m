Return-Path: <linux-kernel+bounces-149987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6920D8A98CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6A23B23E34
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F8C1635CF;
	Thu, 18 Apr 2024 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UBBYcrMN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500E11635C3;
	Thu, 18 Apr 2024 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440239; cv=none; b=ld0+2iBPmBhHHYGdZI6g6rBh+kORyauvPakWCC1jetlkGZqQXQjBaz1Ve+GFqyJ6poqxCkZLfFYD7E+njuak79+XZPEcrsd/9KWpMR5JaClq3opY42lCjrAAlX+Ak1kAdZwUBQqpaTGkhMoR+alRL9TRIVsHFiHTRK0mpeAJnsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440239; c=relaxed/simple;
	bh=32K2pvuotD+LXN0arHaoAwsqYB5fmgxg0lL5o2RpF68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+/ZxTe9B+RvJWu2LxogLfZrwByIeIejzrhvIe55Yj7W1IFvitHXkXeP+a+3j4b8H34JbSEFeWXGuZ/TyDYcbtOhGdZsx46yXe8TtGnpNXRH1QYLsOCy9VjXrLvqdhrYZqc3kX2+0tqeveVda/F2nlfKMcxwxD4w/1YHxFwi7h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UBBYcrMN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713440238; x=1744976238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=32K2pvuotD+LXN0arHaoAwsqYB5fmgxg0lL5o2RpF68=;
  b=UBBYcrMNPZn/aiC5/r54OPMDKIQVdUHXvfN+Px2/uH8wU8FR8WZ9WLH4
   OARMmhoxw5b4EJfb6XdlcEi7WlA4AYCnVmGx8gsdgzpNQC4b2HzX3Nbgd
   GFQXQj3dSWjT1DLGz1+UNQBXUn3VegYwMzFLB3WPoBDn1HmUeOE0R24Nk
   cMvkL63BOwcNbqFSQAtzzwatGpF1f5RPy3sRb4FsbH4R8Sb4j26Q5y0pG
   nfQpYw2N8mZ6adxPoKuJtZUfR/Ng3Csr2d78ggScnu0dZgKhebEqzDrY4
   I6dQONTWwlQF6sNDkm0Lu7tfF5XfR2vD+DxNRhfCPfGZn5YMbfnep2c1V
   A==;
X-CSE-ConnectionGUID: JlI6Diy1T0yZB31ymujU+g==
X-CSE-MsgGUID: pI/C95tgTEG019DlfYms4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19587850"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="19587850"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:37:18 -0700
X-CSE-ConnectionGUID: p3PmWh1VSJuoSx/X/w7GmA==
X-CSE-MsgGUID: 1B/oRPmQQIaneUWN6a5oOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27586251"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 18 Apr 2024 04:37:13 -0700
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
Subject: [PATCH net-next v10 10/10] MAINTAINERS: add entry for libeth and libie
Date: Thu, 18 Apr 2024 13:36:16 +0200
Message-ID: <20240418113616.1108566-11-aleksander.lobakin@intel.com>
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

Add myself as a maintainer/supporter for libeth and libie. Let they have
separate entries from the Intel ethernet code as it's a bit different
case and all patches will go through me rather than Tony.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 MAINTAINERS | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f22698a7859f..6c42ce3ab266 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12392,6 +12392,26 @@ F:	drivers/ata/
 F:	include/linux/ata.h
 F:	include/linux/libata.h
 
+LIBETH COMMON ETHERNET LIBRARY
+M:	Alexander Lobakin <aleksander.lobakin@intel.com>
+L:	netdev@vger.kernel.org
+L:	intel-wired-lan@lists.osuosl.org (moderated for non-subscribers)
+S:	Supported
+T:	git https://github.com/alobakin/linux.git
+F:	drivers/net/ethernet/intel/libeth/
+F:	include/net/libeth/
+K:	libeth
+
+LIBIE COMMON INTEL ETHERNET LIBRARY
+M:	Alexander Lobakin <aleksander.lobakin@intel.com>
+L:	intel-wired-lan@lists.osuosl.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Supported
+T:	git https://github.com/alobakin/linux.git
+F:	drivers/net/ethernet/intel/libie/
+F:	include/linux/net/intel/libie/
+K:	libie
+
 LIBNVDIMM BTT: BLOCK TRANSLATION TABLE
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dan Williams <dan.j.williams@intel.com>
-- 
2.44.0


