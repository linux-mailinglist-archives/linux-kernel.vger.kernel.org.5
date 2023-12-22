Return-Path: <linux-kernel+bounces-9787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E7981CB75
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D302F1C2211F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537E822F11;
	Fri, 22 Dec 2023 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tm4u4DAC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F122F06;
	Fri, 22 Dec 2023 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703256303; x=1734792303;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KbsD23y807pggSXX2eNvN5KBuQftShreQsQda+N3LfE=;
  b=Tm4u4DACHgv/ikefxV265dvK18R1jgTncRJm12IwXMlqZqe5CyHr4srK
   vbAqzEvplqAFg+t9pVgGVZrsOfecab+HyDKS6POdNNN1vgDVwwO4Z4WwG
   codGsJiNdXKPQZ7UUMT6CGeQntwFLG4Tzw57XCsQUnhYbSlJ7L9EgxVo3
   8QPX1qLLGIfmJLWcYzFLbL6NHnaRB/U4dXIeW2HTGPODP97EoPHoepVSh
   psoU4YxWbZ1jZuRi5HNRJB1M1oIb2xRM0zuuR9G46y75gPc3udoqq2NHH
   cgq08zGYB8l76qf/XqTCcvdNx/+KUikeyBah2GDXSob9mTybDB9kMRbVc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="398906058"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="398906058"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 06:45:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="900436332"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="900436332"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 22 Dec 2023 06:45:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 26754291; Fri, 22 Dec 2023 16:44:59 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Darren Hart <dvhart@infradead.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] platform/x86: Remove "X86 PLATFORM DRIVERS - ARCH" from MAINTAINERS
Date: Fri, 22 Dec 2023 16:44:53 +0200
Message-ID: <20231222144453.2888706-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems traffic there is quite low and changes are often not related
to PDx86 anyhow. Besides that I have a lot of other stuff to do, I'm
rearly pay attention on these emails. Doesn't seem Daren to be active
either. With this in mind, remove (stale) section.

Note, it might be make sense to actually move that folder under PDx86
umbrella (in MAINTAINERS) if people find it suitable. That will reduce
burden on arch/x86 maintenance.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index da022945e184..33d15e089ccb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23820,15 +23820,6 @@ F:	drivers/platform/olpc/
 F:	drivers/platform/x86/
 F:	include/linux/platform_data/x86/
 
-X86 PLATFORM DRIVERS - ARCH
-R:	Darren Hart <dvhart@infradead.org>
-R:	Andy Shevchenko <andy@infradead.org>
-L:	platform-driver-x86@vger.kernel.org
-L:	x86@kernel.org
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
-F:	arch/x86/platform
-
 X86 PLATFORM UV HPE SUPERDOME FLEX
 M:	Steve Wahl <steve.wahl@hpe.com>
 R:	Justin Ernst <justin.ernst@hpe.com>
-- 
2.43.0.rc1.1.gbec44491f096


