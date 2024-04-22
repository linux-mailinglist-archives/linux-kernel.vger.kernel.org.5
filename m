Return-Path: <linux-kernel+bounces-153579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870648ACFE1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208FB1F219EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB25152185;
	Mon, 22 Apr 2024 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZzmHV9k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907952AD2D;
	Mon, 22 Apr 2024 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797337; cv=none; b=Z/a4fvIlbEf1msh/IdiBf+Zq6Kh+DgZ0In3eFs0v4CVlImwUUKWxkDnHem9qMOaI/drKdGqrp9kyjohEAXHAwDsFn2jkrTf5LLhFIPrbVzgM4xdjYry8lxqgIRTXz96tXiB/ZxoLDYPEyR7jerrk3q22t2Nv92BKLET1G5bOm6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797337; c=relaxed/simple;
	bh=W0/vq9qtcjPxo0uoUtv2gjN3ISjDFylw8KGlut7SjSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RuhBMSqA/Gk2J69B9LLOmZlQdPnwyWM1EhYK8P6u6tiKhZdcwLLG24jIMWqtV5MfIb9pbVhgGjnQ9tBftxSjwxFpaqIfJWrYp1ZRNCCyp+0pCIq8jQM70MiEx576JBGiFyy6pbZG7f6H3gT4tNHs8oSHIoI8TXZFHhfWwgc+pdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZzmHV9k; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713797335; x=1745333335;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W0/vq9qtcjPxo0uoUtv2gjN3ISjDFylw8KGlut7SjSk=;
  b=aZzmHV9kxLu5vHFHDOyXiNezsghCmKsQX/8EIY5EcAxZdZUMy+Sz/Spg
   J3CpbAe6iBAMRFtyHPD7yMbcqLj36Jc8LVHu33gnh9cJYDXLj1mk5fGPP
   GJPEb9AeDKISmZ7LiKczkigNJ+jj6CJ7gxNENN/yJqYxa+cuSDjM5YaEb
   fHHp26de0Qc9yLyI53472iE8WjXOIRhaWXb+hqNz3BpVd5i0jILmwCNw3
   DPQn74HXY4nUT4I78kMNT54yUpveoVIH6Q77DSKfYHqi2Wu83BPsIbsAU
   MKo3R+gEt7N7oB2rR+SOpDkV30evSXfaPv602mlVybeX7If7xNfI1stYI
   w==;
X-CSE-ConnectionGUID: qS1EeBZJTG2WpJj/eo0Mww==
X-CSE-MsgGUID: QZ8k6x8QSdqqt0CJa+OHzw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="20742235"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="20742235"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 07:48:54 -0700
X-CSE-ConnectionGUID: h3EvbzcyQ06Kp8+pDHllhQ==
X-CSE-MsgGUID: +jk++k7NT+6OdTTXG75tMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="24493084"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 22 Apr 2024 07:48:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BCF33FD; Mon, 22 Apr 2024 17:48:51 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: William Breathitt Gray <william.gray@linaro.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: William Breathitt Gray <wbg@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] counter: Don't use "proxy" headers
Date: Mon, 22 Apr 2024 17:48:50 +0300
Message-ID: <20240422144850.2031076-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/counter.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/counter.h b/include/linux/counter.h
index cd35d8574ee2..426b7d58a438 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -6,14 +6,15 @@
 #ifndef _COUNTER_H_
 #define _COUNTER_H_
 
+#include <linux/array_size.h>
 #include <linux/cdev.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
 #include <linux/kfifo.h>
 #include <linux/mutex.h>
 #include <linux/spinlock_types.h>
 #include <linux/types.h>
 #include <linux/wait.h>
+
 #include <uapi/linux/counter.h>
 
 struct counter_device;
-- 
2.43.0.rc1.1336.g36b5255a03ac


