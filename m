Return-Path: <linux-kernel+bounces-1537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA217814FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6021F244ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394D03EA6C;
	Fri, 15 Dec 2023 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjhXGWet"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3372E3011A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702665745; x=1734201745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e/eIxiJp/SkNRx3YodVUfW0HCtfvVRN9U31/u7Kl7Cw=;
  b=JjhXGWetgvCb24vaetMT3YBlk2I9RZlDP3eICAee4usUPJJdI4n4fYho
   91dLbjBCv8Lb0txgqLa9z1o5Yu8ILX9/OfPiVc7ub9TYrCOMpaQN9gIhV
   VJrhB/9vu6JFAC6R31fznJlKnNryiXY5R0nTQaiDSEItjJWGRvpjaMjPP
   v3p6H6RQSN9AKdWcDinlLRlgbvoPxHr/SwInpvAZXElq0L5Zn7u+hSCRK
   ePZqyWKV5qA/EobawbSTzBIwjZe9/6VUJKWKLUMtAZPk1+DzKotdUYxAU
   EWmUK2vn3lFRZkvyxMDpn0KM3UBZc4thgmNe1UVP/AXPmlGWVhOASR9hi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="374815539"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="374815539"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 10:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="751025936"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="751025936"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2023 10:42:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A1ED244A; Fri, 15 Dec 2023 20:42:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 2/2] bitmap-str: Add missing header(s)
Date: Fri, 15 Dec 2023 20:41:09 +0200
Message-ID: <20231215184218.2005611-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231215184218.2005611-1-andriy.shevchenko@linux.intel.com>
References: <20231215184218.2005611-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/bitmap-str.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bitmap-str.h b/include/linux/bitmap-str.h
index d758b4809a3a..53d3e1b32d3d 100644
--- a/include/linux/bitmap-str.h
+++ b/include/linux/bitmap-str.h
@@ -2,6 +2,8 @@
 #ifndef __LINUX_BITMAP_STR_H
 #define __LINUX_BITMAP_STR_H
 
+#include <linux/types.h>
+
 int bitmap_parse_user(const char __user *ubuf, unsigned int ulen, unsigned long *dst, int nbits);
 int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp, int nmaskbits);
 int bitmap_print_bitmask_to_buf(char *buf, const unsigned long *maskp, int nmaskbits,
-- 
2.43.0.rc1.1.gbec44491f096


