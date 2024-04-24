Return-Path: <linux-kernel+bounces-157698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2298B14BA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD825B27367
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD9E16EBE4;
	Wed, 24 Apr 2024 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XbIm1ALu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F4161913;
	Wed, 24 Apr 2024 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990990; cv=none; b=HeL+dm79SzQP9jiyPSezv3GUg0OCdYVe7Wb4+woHhQqOFdKdaW4AMWyK/lSxocOS5qsTLOHuumoftvWDw+1Yg4M8iLhgZ2kYQDv28/r2zDbUbcBRhBG4X31pVh1m1z7wDsyl5U9VrwcYYLgBigtz7p2pqJ8nvk0s0Sh0NahpLbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990990; c=relaxed/simple;
	bh=8Cigxoho0r+tMjpVglYL9iTtTctbGsJvMJo1lVtXGno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfdj/owx8396Dx+kUZTESWMahzt/UC4JzZqk1ea3X6ri90yL9qCvjtXIIr8VConEjO5+RfiVx/l4fX3vL50yi6Ffg+9Cf11GuYlg/PHFI/RK+qhErrVNZCc0xoumW08rKCXecTat+ZM2uFJEV/nOYobtjcObrs4xD+0zC3e6pOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XbIm1ALu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713990988; x=1745526988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Cigxoho0r+tMjpVglYL9iTtTctbGsJvMJo1lVtXGno=;
  b=XbIm1ALu8iqweshks8Tk+Qk81D3lpxBy4xOtynhk+zclVxMTLzjQ5yNf
   eHFV0TkezuXR3sFBFkv9sgqnNu66Hg9JtDb3KGcyoB6g0SNTOUq1G6ojM
   4R8FsmgpCSq1/VZCjj26ZZwdPpYfOO+0ihptTVK/q4QipL1/y4IpDurR0
   Z+XQA8YBjsS80YXv2+SvGJVz+aN/O3xd74An2ayt3lWkGAZCT3Y8tO/Vl
   S3sk2VLROny3Khr4gy6pQsR6aQARGa9gw2+k4jfdjS7slJo01umT3aXZx
   IuRZgg0Q8jiOfOyMJcmu/lpHpMS34AsGPN89Q+rOzzCOdXTAZZy+7NTI2
   Q==;
X-CSE-ConnectionGUID: z5pdg5MBTVKkPXH6MmrnKA==
X-CSE-MsgGUID: HydkCTTNTm+qxxmvs/bB8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9512006"
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="9512006"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 13:36:22 -0700
X-CSE-ConnectionGUID: 1UfQkPigTkGEuINXErWMyg==
X-CSE-MsgGUID: 50srluUpRxKf2sE4mlqj0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,227,1708416000"; 
   d="scan'208";a="29315005"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 24 Apr 2024 13:36:21 -0700
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
Subject: [PATCH net-next v11 10/10] MAINTAINERS: add entry for libeth and libie
Date: Wed, 24 Apr 2024 13:35:57 -0700
Message-ID: <20240424203559.3420468-11-anthony.l.nguyen@intel.com>
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

Add myself as a maintainer/supporter for libeth and libie. Let they have
separate entries from the Intel ethernet code as it's a bit different
case and all patches will go through me rather than Tony.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 MAINTAINERS | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0bfad334623..4f94e3aabed4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12390,6 +12390,26 @@ F:	drivers/ata/
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
2.41.0


