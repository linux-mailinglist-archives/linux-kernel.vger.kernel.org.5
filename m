Return-Path: <linux-kernel+bounces-1536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20786814FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77931F244BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A657D3C486;
	Fri, 15 Dec 2023 18:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITFVGvom"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDFB2D78A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702665744; x=1734201744;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PrtQfR9Lao5TISBb50B9BXzz9ers0PsbS0NnyIhkxSE=;
  b=ITFVGvomgSHojhtWXMdbAv35BA4HghCZC214hie+vwzzc2GAWyFvBH+b
   xYN6mcCo6RzJMaqy4ax3ai67J2wLRAjbJqbcvCEiBDCVzggSmSqMcMzDo
   1H2gTw3numcGMO+7vaomKC+LA/ZIwOSwBH6u+nBJE7o98EQP+lz1YD8N2
   CsVJvJOqTCiuldCqwO+SZTAeDZCK+59uXiR71ahLXFNKXvoZ4Xv1TwXvN
   IdcrUlDtdlNMSkBKeVZaqxiO9Za78545MofNU8plD6zLxm9xu5k75ksrt
   1pu/sZrfqZiPoUiNO2agKAKaLrUDh/XNFYqDD8lxoeh5wE6MCVGyTPw9o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2482760"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2482760"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 10:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="918533557"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="918533557"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2023 10:42:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8234F3A3; Fri, 15 Dec 2023 20:42:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 0/2] bitmap-str: A couple of fixes
Date: Fri, 15 Dec 2023 20:41:07 +0200
Message-ID: <20231215184218.2005611-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Imtended to be folded into original code, hence no proper commit messages.

Andy Shevchenko (2):
  bitmap-str: Get rid of extern
  bitmap-str: Add missing header(s)

 include/linux/bitmap-str.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


