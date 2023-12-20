Return-Path: <linux-kernel+bounces-6775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B98E819D5A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7368B25254
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74E420B1E;
	Wed, 20 Dec 2023 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axWRPtUH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB28B20B03;
	Wed, 20 Dec 2023 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703069343; x=1734605343;
  h=message-id:from:to:cc:date:subject:mime-version:
   content-transfer-encoding;
  bh=vnED2NAuDnlh+Kq4YIr79f8O06coyJNI5fBt8N5UoF8=;
  b=axWRPtUHpTL4C5DJYUuxgjuCtB1JpzL/bbLOed0HnbdhBdPqm38ZjP4z
   zLbXg620mLfzcndDPczlA6UIT44njkFyUSYxeoNk00sOmgs77QM4lTf39
   O3IFRYn+C03J0oFjxWgbpgTxf7jgLWMs2Rjr9JUdPwLJ7+/8qy7fBgi+q
   Cmos6SmroSvAdcPwTlNnXpSSs0VMpMxDp6rQCPF65KOIqz1qdV1aZThhX
   oPeX6DHrQYpyu/rQ7ug1uio0tkLRGs5lfI0a5mkZv1PGQ98Uu/7hD7Wdl
   QPl3uWLqrWQTDPtKb7BD3Lj9mSAe5jVUfGpi7kSjdR0W2u/z8tmAzdNRo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="460139633"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="460139633"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 02:49:02 -0800
Message-Id: <8a82d4$p36og3@fmsmga008-auth.fm.intel.com>
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="842228227"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="842228227"
Received: from unknown (HELO localhost) ([10.94.254.181])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 02:48:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Wed, 20 Dec 2023 12:46:41 +0200
Subject: [GIT PULL] platform-drivers-x86 for v6.7-5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a fixes PR for platform-drivers-x86 for v6.7.

Fixes:
- Fan reporting on some ThinkPads
- Laptop 13 spurious keypresses while suspended
- Intel PMC correction to avoid crash

Regards, i.


The following changes since commit 7bcd032370f88fd4022b6926d101403e96a86309:

  platform/x86: intel_ips: fix kernel-doc formatting (2023-12-08 13:21:49 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-5

for you to fetch changes up to a55bdad5dfd1efd4ed9ffe518897a21ca8e4e193:

  platform/x86/amd/pmc: Disable keyboard wakeup on AMD Framework 13 (2023-12-18 15:08:19 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.7-5

Fixes:
- Fan reporting on some ThinkPads
- Laptop 13 spurious keypresses while suspended
- Intel PMC correction to avoid crash

The following is an automated shortlog grouped by driver:

amd/pmc:
 -  Disable keyboard wakeup on AMD Framework 13
 -  Move keyboard wakeup disablement detection to pmc-quirks
 -  Move platform defines to header
 -  Only run IRQ1 firmware version check on Cezanne

intel/pmc:
 -  Fix hang in pmc_core_send_ltr_ignore()

thinkpad_acpi:
 -  fix for incorrect fan reporting on some ThinkPad systems

----------------------------------------------------------------
Mario Limonciello (4):
      platform/x86/amd/pmc: Move platform defines to header
      platform/x86/amd/pmc: Only run IRQ1 firmware version check on Cezanne
      platform/x86/amd/pmc: Move keyboard wakeup disablement detection to pmc-quirks
      platform/x86/amd/pmc: Disable keyboard wakeup on AMD Framework 13

Rajvi Jingar (1):
      platform/x86/intel/pmc: Fix hang in pmc_core_send_ltr_ignore()

Vishnu Sankar (1):
      platform/x86: thinkpad_acpi: fix for incorrect fan reporting on some ThinkPad systems

 drivers/platform/x86/amd/pmc/pmc-quirks.c | 20 +++++++
 drivers/platform/x86/amd/pmc/pmc.c        | 33 ++++-------
 drivers/platform/x86/amd/pmc/pmc.h        | 12 ++++
 drivers/platform/x86/intel/pmc/core.c     |  2 +-
 drivers/platform/x86/thinkpad_acpi.c      | 98 +++++++++++++++++++++++++++----
 5 files changed, 131 insertions(+), 34 deletions(-)

