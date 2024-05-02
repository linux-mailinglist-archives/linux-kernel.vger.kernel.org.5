Return-Path: <linux-kernel+bounces-166002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E908B9493
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F331F22B5E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB5A219F6;
	Thu,  2 May 2024 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ibq/Lpip"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116619BBA;
	Thu,  2 May 2024 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714630543; cv=none; b=TeHinKu3+6w24VsVF4TdR9SI1/EcUA2b846Aw/gzIaRw4vSMb14xRj/pAS5x3qoodJsUgStJ4/tbnFVHCA1fsRp2WRj5bLmY9H45c/Mo7G/aNhU2lX1HRx67nL7ycXBQUwuvGQMX0T8QKkwVOEL0Ngbco1aGFKYuyMU5jncmzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714630543; c=relaxed/simple;
	bh=4OgiMeMFFqfMsPzrtCht/2JBkbW1O58CRe7NPSDmh+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mb6YGsT1jqV0OifFRRBNtLsTpIfNTHKqlaQn7LWUqjzXFN1bj+6ZSj0lzRnDfZQoJU+0mERccFpupWmN620szJqq+7tD188Rs5pVZM/0Do43sFwuJdZWtBwvGnrRsvZGn0GB7W5Dyd34Z4Px5K6uA5lNSLOVDGc6kjNxjULTy3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ibq/Lpip; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714630542; x=1746166542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4OgiMeMFFqfMsPzrtCht/2JBkbW1O58CRe7NPSDmh+U=;
  b=Ibq/LpipuH9KToD/uFMiUft6VR3fFC5xRFw1fCwJrzn+kj2qwRKskftZ
   kw++U2ltAPSdrk18e6pXbGrCpLl968TsfhYxy85/eL1GjmkL2cxoOQeUe
   ecD6YCG7sML0JHpoEQmOowjx1EcQcRu6DIuJDc8a3IMSOBuxhOCQXatP8
   NznMrBil8x2ORYnXcyAw1pZ7UUrC1t7YOtAjIkcfdcDmw/AmdO3mr+2NP
   WKp6VC+s1Y5uBxWpHbTbyHhGNdKhGBvLiIMCibARlXqk3Kh9zXz6iz4K9
   9krE505xKwzncThnR7N7YBdw/txnTxf3jt8m3qN9oQ4/RKs5P7z/X1xIx
   w==;
X-CSE-ConnectionGUID: tmx7j/DFQWOt/inZjo9rLA==
X-CSE-MsgGUID: xGDy3gdTRdimTW7wJNizMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="13333199"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="13333199"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 23:15:40 -0700
X-CSE-ConnectionGUID: 93d5PMZfTOq6WRvhHrvH6g==
X-CSE-MsgGUID: gQZcZkbQSsKuRt+L5bZjLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="57910016"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 23:15:38 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 1AEE911F832;
	Thu,  2 May 2024 09:15:36 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1s2PjE-004DC2-06;
	Thu, 02 May 2024 09:15:36 +0300
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH 1/1] media: ipu6: Fix vmalloc memory allocation
Date: Thu,  2 May 2024 09:15:25 +0300
Message-Id: <20240502061525.1004018-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501102236.3b2585d1@canb.auug.org.au>
References: <20240501102236.3b2585d1@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver was calling vmalloc() to allocate memory, something which isn't
available except when particular Kconfig settings are enabled.

Use kvmalloc() instead.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 25fedc021985 ("media: intel/ipu6: add Intel IPU6 PCI device driver")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
Hi Stephen,

Thanks for reporting this. I'm a bit surprised this wasn't catched
earlier. But it seems vmalloc() is defined in some configuration.

- Sakari

 drivers/media/pci/intel/ipu6/ipu6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6.c b/drivers/media/pci/intel/ipu6/ipu6.c
index 4b1f69d14d71..082b1d6196be 100644
--- a/drivers/media/pci/intel/ipu6/ipu6.c
+++ b/drivers/media/pci/intel/ipu6/ipu6.c
@@ -526,7 +526,7 @@ static int request_cpd_fw(const struct firmware **firmware_p, const char *name,
 	}
 
 	dst->size = fw->size;
-	dst->data = vmalloc(fw->size);
+	dst->data = kvmalloc(fw->size, GFP_KERNEL);
 	if (!dst->data) {
 		kfree(dst);
 		ret = -ENOMEM;
-- 
2.39.2


