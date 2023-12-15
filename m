Return-Path: <linux-kernel+bounces-1538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB91814FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F52B286F93
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195433FE43;
	Fri, 15 Dec 2023 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdbN0sX2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A887374CA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702665746; x=1734201746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=62cgElx93zxdtr1+BKH9yDWLjaRS5xOwAItnSx7AbM8=;
  b=YdbN0sX2grm522xPBE1O0wpyko/VDPGpNdP0ipNSB+eMY3l0Tf5DWAt3
   2aplldl5mj/hTVVizxH6Us5aJrELfiaJ8eWIE3HSimrU4FAi6kZLumKD9
   48zOEVrFoGSdH/xbcGivWoQNLZoZkSnlU/q8GgiSL+7qGgZS4Wgl4ixtx
   mXmMARbOqMpYLD3LmqMd5jYeAWMok92hRD//14MGJyAvDXo2zxid2e8uH
   PYFVo2lbQTNroLDtsJnXY4C9QuhVrhVHy6KQcDfbCL5WsdJ87/Sx3IWTm
   0fldyqztGov9rVTxaqDz2sgxHACTQp9I+DRI2OzzoTovnpE3ssI/gTTWV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2482764"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2482764"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 10:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="918533559"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="918533559"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2023 10:42:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9347020B; Fri, 15 Dec 2023 20:42:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 1/2] bitmap-str: Get rid of extern
Date: Fri, 15 Dec 2023 20:41:08 +0200
Message-ID: <20231215184218.2005611-2-andriy.shevchenko@linux.intel.com>
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
 include/linux/bitmap-str.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bitmap-str.h b/include/linux/bitmap-str.h
index 17caeca94cab..d758b4809a3a 100644
--- a/include/linux/bitmap-str.h
+++ b/include/linux/bitmap-str.h
@@ -4,10 +4,10 @@
 
 int bitmap_parse_user(const char __user *ubuf, unsigned int ulen, unsigned long *dst, int nbits);
 int bitmap_print_to_pagebuf(bool list, char *buf, const unsigned long *maskp, int nmaskbits);
-extern int bitmap_print_bitmask_to_buf(char *buf, const unsigned long *maskp,
-					int nmaskbits, loff_t off, size_t count);
-extern int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
-					int nmaskbits, loff_t off, size_t count);
+int bitmap_print_bitmask_to_buf(char *buf, const unsigned long *maskp, int nmaskbits,
+				loff_t off, size_t count);
+int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp, int nmaskbits,
+			     loff_t off, size_t count);
 int bitmap_parse(const char *buf, unsigned int buflen, unsigned long *dst, int nbits);
 int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits);
 int bitmap_parselist_user(const char __user *ubuf, unsigned int ulen,
-- 
2.43.0.rc1.1.gbec44491f096


