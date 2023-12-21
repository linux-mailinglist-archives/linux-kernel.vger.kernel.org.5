Return-Path: <linux-kernel+bounces-8152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C555681B2B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646681F26088
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCE352F8C;
	Thu, 21 Dec 2023 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2RzLsD9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D352F67;
	Thu, 21 Dec 2023 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703151248; x=1734687248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L+k5CS5sgC8pMM6kY4u78Belg2iE72BS8zZ13TBDiEs=;
  b=k2RzLsD9anFS2xOvYcebFfeKXaDfc9nNThRLICBPlg8yiLXXs0+4m4wD
   TgVO2MZ7XQguFD1ypxgEA6iW0yr0JVsi7nE3NXwAMwmAu7GRvCWFI0Btt
   NB+WHjERNfoXEWGWxnRAAuOBfXLZv8wwyl+YbeZvVvT2QMoNEU+RR+jSq
   gzx6tJbpLp2R8t7PTW17uenPfuE+YdoqukP5NGz4Z3S13n6oqDkJw/RGl
   SIG7lLTbhxHcacvefEGaGZYqESrH6Jr8RA3/5UyTRq+iqG1f8S5Bx7UTm
   UCClW4zjQJJqsoI6vzPk11chSSJ8sh1ojnTN2q6/n28b0RX2Qgn7bQkr0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="3188687"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="3188687"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 01:34:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="810918311"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="810918311"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga001.jf.intel.com with ESMTP; 21 Dec 2023 01:34:00 -0800
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	pandith.n@intel.com,
	mallikarjunappa.sangannavar@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [RFC PATCH v2 10/10] ABI: pps: Add ABI documentation for Intel TIO
Date: Thu, 21 Dec 2023 15:02:54 +0530
Message-Id: <20231221093254.9599-11-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231221093254.9599-1-lakshmi.sowjanya.d@intel.com>
References: <20231221093254.9599-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

Document sysfs interface for Intel Timed I/O PPS driver

Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 Documentation/ABI/testing/sysfs-platform-pps-tio | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio

diff --git a/Documentation/ABI/testing/sysfs-platform-pps-tio b/Documentation/ABI/testing/sysfs-platform-pps-tio
new file mode 100644
index 000000000000..d8be3a6d5795
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-pps-tio
@@ -0,0 +1,7 @@
+What:		/sys/devices/platform/INTCxxxx/enable
+Date:		January 2024
+KernelVersion	6.8
+Contact:	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
+Description:
+		(RW) Enable or disable PPS TIO generator output, read to
+		see the status of hardware(Enabled/Disabled).
-- 
2.35.3


