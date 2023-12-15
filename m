Return-Path: <linux-kernel+bounces-1177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02671814B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA5FB23781
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD1435F09;
	Fri, 15 Dec 2023 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePVwHCVA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489223C48F;
	Fri, 15 Dec 2023 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652969; x=1734188969;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ah5mzgotn1mPGg5+aEZRvveESjmnNIS1QhgQDAZlBqY=;
  b=ePVwHCVAywfcZTOQXZdE7ctsjLicO3OXwnleNM8OnqunfghDjylmwycY
   4aHt6FY/DS+fUKAMZaBe6uaEhU07G/a7fdoVbusT8PK0BDOstFkLggHK3
   AxoW9nKps6Z1Nf11Vyf3Y0d9NeTG0gJ4tM9aO8FDJWq9Z0ESIOSLdviub
   6wptZ8G7c17xxlG9xXMYiiENHvhq4ZUj5YzYJtynbosstx2xLRZM79JqM
   UpVBq6TbRwclQlr2oT2p3haZYdcW4BAkkLp7ycIsVarEJygpq70Mnj0VN
   ACPlkt9XJKtwPljFBk3gVSL9vuCOpHXKtMC3VC5914iDYiHc0fWG7EIqg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8645043"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="8645043"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:09:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="840691616"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="840691616"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 15 Dec 2023 07:09:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0CD6A3A3; Fri, 15 Dec 2023 17:03:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] kernel-doc: Aling quick help and the code
Date: Fri, 15 Dec 2023 17:03:41 +0200
Message-ID: <20231215150341.1996720-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The update to the quick help mentions -Wshort-description, but
code never supported for that. Align that with the code by allowing
both: -Wshort-description and -Wshort-desc.

Fixes: 56b0f453db74 ("kernel-doc: don't let V=1 change outcome")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 scripts/kernel-doc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 0a890fe4d22b..7d7ed3e43946 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -23,7 +23,7 @@ kernel-doc - Print formatted kernel documentation to stdout
 
 =head1 SYNOPSIS
 
- kernel-doc [-h] [-v] [-Werror] [-Wall] [-Wreturn] [-Wshort-description] [-Wcontents-before-sections]
+ kernel-doc [-h] [-v] [-Werror] [-Wall] [-Wreturn] [-Wshort-desc[ription]] [-Wcontents-before-sections]
    [ -man |
      -rst [-sphinx-version VERSION] [-enable-lineno] |
      -none
@@ -328,7 +328,7 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
 	$Werror = 1;
     } elsif ($cmd eq "Wreturn") {
 	$Wreturn = 1;
-    } elsif ($cmd eq "Wshort-desc") {
+    } elsif ($cmd eq "Wshort-desc" or $cmd eq "Wshort-description") {
 	$Wshort_desc = 1;
     } elsif ($cmd eq "Wcontents-before-sections") {
 	$Wcontents_before_sections = 1;
-- 
2.43.0.rc1.1.gbec44491f096


