Return-Path: <linux-kernel+bounces-13155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 841F0820076
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8783F1C217CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28779125CB;
	Fri, 29 Dec 2023 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4Hjy4y2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08F8125BD;
	Fri, 29 Dec 2023 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703866202; x=1735402202;
  h=from:message-id:to:cc:date:subject:mime-version:
   content-transfer-encoding;
  bh=rkI6XD9LtfJOtBZZUjeHkJVai/PGQpknoq3WegoSLtQ=;
  b=I4Hjy4y2WtTFgkkYRTaVRFT9rfPaoGAvZrw14M/c6v/DEWBKBABz9v7H
   gaP64fbGxkoTWxPYxpr3DmwKv/xMfisvv0UszyBWFM0pvbxSHrJ1IdUWT
   An1el5k4uhTIZn7FrW0zliC+mXHzbcwGtuMZFuxYCbh6rQ5V76Q8MXUEw
   xfxDXQrN9Kbx5CiZGttDIQnRBB+fN3gy9W6VAkd+FwS709YDTHNtOA9/k
   9V+TGVzSRzciCYiBLWxqVF8S4uNDu1jFrtxl4tjXn3+vg9pK4iJhol11i
   y5ucIdjAmfeNjG0Ioxiglndgpm0aDPxif+PXeIM/GoOUswaSmQAUhmw9w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="395545717"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="395545717"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 08:10:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="13318112"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.133])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 08:09:59 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Message-ID: <99b3747b381376d301fbddef905ae10a.=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Fri, 29 Dec 2023 18:06:29 +0200
Subject: [GIT PULL] platform-drivers-x86 for v6.7-6
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
- Intel PMC GBE LTR regression
- P2SB / PCI deadlock fix

Regards, i.


The following changes since commit a55bdad5dfd1efd4ed9ffe518897a21ca8e4e193:

  platform/x86/amd/pmc: Disable keyboard wakeup on AMD Framework 13 (2023-12-18 15:08:19 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-6

for you to fetch changes up to 70681aa0746ae61d7668b9f651221fad5e30c71e:

  platform/x86/intel/pmc: Move GBE LTR ignore to suspend callback (2023-12-29 15:31:22 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.7-6

Fixes:
- Intel PMC GBE LTR regression
- P2SB / PCI deadlock fix

The following is an automated shortlog grouped by driver:

intel/pmc:
 -  Add suspend callback
 -  Allow reenabling LTRs
 -  Move GBE LTR ignore to suspend callback

p2sb:
 -  Allow p2sb_bar() calls during PCI device probe

----------------------------------------------------------------
David E. Box (3):
      platform/x86/intel/pmc: Add suspend callback
      platform/x86/intel/pmc: Allow reenabling LTRs
      platform/x86/intel/pmc: Move GBE LTR ignore to suspend callback

Shin'ichiro Kawasaki (1):
      platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe

 drivers/platform/x86/intel/pmc/adl.c  |   9 +-
 drivers/platform/x86/intel/pmc/cnp.c  |  26 +++--
 drivers/platform/x86/intel/pmc/core.c |  12 ++-
 drivers/platform/x86/intel/pmc/core.h |   7 +-
 drivers/platform/x86/intel/pmc/mtl.c  |   9 +-
 drivers/platform/x86/intel/pmc/tgl.c  |   9 +-
 drivers/platform/x86/p2sb.c           | 172 ++++++++++++++++++++++++++--------
 7 files changed, 176 insertions(+), 68 deletions(-)

