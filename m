Return-Path: <linux-kernel+bounces-138447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDA389F168
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66A3B2430D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F4D15FA80;
	Wed, 10 Apr 2024 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBmWg1Ej"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3F815B990;
	Wed, 10 Apr 2024 11:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749791; cv=none; b=roAY/f74bVfmQYF7/jxVA5ImkeXrA9XgRZ/UZY8LRuYXu9kvEFXhyLl6rfFr1Dclz3/YBeZQms45w+Mue1mFKSCg/Aoin1NBdil4JP4WagoJCBw6zx3mWCTx8TOxUETsz1UE4ANNMoFNROaWBOB5mTHg0vz81M5bLtIsv0r+b+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749791; c=relaxed/simple;
	bh=hZSWgcp7GnBBKQ/ANmuBJ1lGoqRIvIkLrQj6268hnRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eyhMzbfSTN2rgS6jeN1y5lVBxJXhei8YnI9cfTUPVvplNfM/DzylLw+9HETlXbJL2Aydd6+C93HDmHFio2EJv2U/DLfUc7DZ8jvhfAkUxwNRL6kZkhWiPHpLh4plPppfFM36gRNIPbKpw1ob0axzlOSeqJ3VkhlAELurOiSQqIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBmWg1Ej; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712749791; x=1744285791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hZSWgcp7GnBBKQ/ANmuBJ1lGoqRIvIkLrQj6268hnRY=;
  b=PBmWg1EjZrOXZKwQpe3+9Mz58iby46bu4mwDcdV8V369+0fUfuN2OgVJ
   XrVylhGe54jkNyCHG0bkJhu0SqqFqEgufWZjSo/90hXdOAqigDQfOeMly
   26kFezkNn1SizyPXGBZYPHpOTnFmTl5OGpiZUVH3GFh+ecSH+zUCKnLxC
   ViI04zdtIT6oxxdG3RbVWvl9jaDK5NkpUvNYZAKwePp7NZnWkgHQTUuna
   cRZn5sd+7UPFt2apkPiQVQpiCKkw3y00g1jyqiwztED/m//eg4swhdlUE
   ipjIyRsUBhwgAHyBP3c9BVRumjmS5CV5RL/UXkYzEgZy+lzeO+/gnBhL+
   g==;
X-CSE-ConnectionGUID: b/dqFYzlTp2kw2Cs+oV3ZQ==
X-CSE-MsgGUID: xzslro3WSQmtcgbPx8tUfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11944240"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11944240"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:49:50 -0700
X-CSE-ConnectionGUID: OT+wDgJGSJqHR+RwN/KXfA==
X-CSE-MsgGUID: QtnGadiqSc2BPgOAsMkeig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="43769373"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa002.fm.intel.com with ESMTP; 10 Apr 2024 04:49:43 -0700
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
	peter.hilber@opensynergy.com,
	pandith.n@intel.com,
	subramanian.mohan@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v6 11/11] ABI: pps: Add ABI documentation for Intel TIO
Date: Wed, 10 Apr 2024 17:18:28 +0530
Message-Id: <20240410114828.25581-12-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
References: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

Document sysfs interface for Intel Timed I/O PPS driver.

Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 Documentation/ABI/testing/sysfs-platform-pps-tio | 7 +++++++
 MAINTAINERS                                      | 1 +
 2 files changed, 8 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio

diff --git a/Documentation/ABI/testing/sysfs-platform-pps-tio b/Documentation/ABI/testing/sysfs-platform-pps-tio
new file mode 100644
index 000000000000..b9b8c97a7840
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-pps-tio
@@ -0,0 +1,7 @@
+What:		/sys/devices/platform/INTCxxxx/enable
+Date:		March 2024
+KernelVersion	6.9
+Contact:	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
+Description:
+		(RW) Enable or disable PPS TIO generator output, read to
+		see the status of hardware (Enabled/Disabled).
diff --git a/MAINTAINERS b/MAINTAINERS
index aea47e04c3a5..e63365a2d029 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17684,6 +17684,7 @@ M:	Rodolfo Giometti <giometti@enneenne.com>
 L:	linuxpps@ml.enneenne.com (subscribers-only)
 S:	Maintained
 W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
+F:	Documentation/ABI/testing/sysfs-platform-pps-tio
 F:	Documentation/ABI/testing/sysfs-pps
 F:	Documentation/devicetree/bindings/pps/pps-gpio.yaml
 F:	Documentation/driver-api/pps.rst
-- 
2.35.3


