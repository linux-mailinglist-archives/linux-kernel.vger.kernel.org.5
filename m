Return-Path: <linux-kernel+bounces-159498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C658B2F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28511F22412
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F80824A6;
	Fri, 26 Apr 2024 04:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZve51dG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942E8473
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714105497; cv=none; b=CT2Sz6eZGWesP3Jjn1xLxdb4UEeXZlkihKPhL7Kv4gCcaC328T35qJ9LIONEO+wJ0Ok8B3UL3gc3Q9SL2Nn19uiZlqSJ6RCgHbnbQMiMDktNg8nIqfZhc8i4Iq1if/+WH9qOzneLfEwhlFIk5CNNZLo291m+9GNBtVk6w7WtWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714105497; c=relaxed/simple;
	bh=5l0mKCDLVS99Sq0Y98eODuHG+rgoENHP4YgrcPrSjws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sFgCnZ5tmZ2VvfcY+9TOt3iQfxPvUHsF3kPsRNjlxpYgOHLI1ZIsDKmkdmjsO14zB5Y5jI9BJJqmeVKeowQshJpfPyvkeIX0SepSzFqdMhI2cC5CXJHHTR+Rnwwavi+T6WRq8YCzw9g1JBh6FR75W3ugiYd+L6sOm3FSwzTAdl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZve51dG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714105496; x=1745641496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5l0mKCDLVS99Sq0Y98eODuHG+rgoENHP4YgrcPrSjws=;
  b=TZve51dGrg99tQHqGUn4ZKcOduu22d/CXrh0jWPNLoVPWfW03MToqD6T
   gZf7IDwERyeqjsdljNp+ETgcWsE5xUgadgQPFvwKOJ8XZ+945teisG4cL
   kRDqrKcJV2oFiu1hI7i3AFUnqWrILHkz3g8H9nZFbuMfstTsdOzUueWCZ
   S7ls/Yn+yZ+B1rQ7cWI1RCgl60kW/iqSYqre5POqbdxMvAhw6MYoZvfsj
   8qfbtoMjNPfPeRM2CvsF5QngbrI5EbzHwX6PTCrqUeXKXvqgLEbOX3bsz
   zD4ZPIbi0PPQSMo4wi0dYDHZNv9umROc4Lc5NafbAlQRqZGleYVuQv6h3
   Q==;
X-CSE-ConnectionGUID: MKOlzwYaTbqZ74jhsTzD0w==
X-CSE-MsgGUID: LwRR7LGYS566m0OO9JQzvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="13613161"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="13613161"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 21:24:55 -0700
X-CSE-ConnectionGUID: Pg0AxfL3SAqXoEQUfLZ9cw==
X-CSE-MsgGUID: wErNLG5lTVSKjzUBeQNOmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="30099318"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.252.128.24])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 21:24:55 -0700
From: alison.schofield@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Remove unneeded MKTME detection
Date: Thu, 25 Apr 2024 21:24:51 -0700
Message-Id: <cover.1713929290.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

MKTME detection was added in anticipation of full kernel support
that never followed. Aside from just good housekeeping, this
cleanup is inspired by users who are confused by the TME/MKTME
messaging during boot.

The first patch cleans up the TME & MKTME detection code and the
second patch removes the unused pconfig code.

Testing was done on a platform supporting MKTME using the BIOS
option to enable/disable MKTME prior to boot.


Alison Schofield (2):
  x86/cpu: Remove useless work in detect_tme_early()
  x86/pconfig: Remove unused MKTME pconfig code

 arch/x86/include/asm/intel_pconfig.h | 65 ---------------------
 arch/x86/kernel/cpu/Makefile         |  2 +-
 arch/x86/kernel/cpu/intel.c          | 71 ++++-------------------
 arch/x86/kernel/cpu/intel_pconfig.c  | 84 ----------------------------
 4 files changed, 13 insertions(+), 209 deletions(-)
 delete mode 100644 arch/x86/include/asm/intel_pconfig.h
 delete mode 100644 arch/x86/kernel/cpu/intel_pconfig.c


base-commit: 5a04007fb7a9a3f101fe551f0e47849f2cd1125b
-- 
2.37.3


