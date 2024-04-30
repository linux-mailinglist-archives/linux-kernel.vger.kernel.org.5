Return-Path: <linux-kernel+bounces-163609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A958B6DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CBC1F21496
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502DA1C2331;
	Tue, 30 Apr 2024 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSjuvo0S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C96127B73;
	Tue, 30 Apr 2024 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467238; cv=none; b=JrvG8+hbcO/oIxdQTAYHORGZT5J6VB9wdQF34hsd8qjFJ/jdMsJD2pqhDTgI8pmCSIAGaDCKqblZ4Xypsy1RLOuEtllkcNbmA7BxdTsYzvDFfCALlLjEDQF5vyLkce1usmWXuf/8Th04/Km4ZA5zdhzxEQp3uosDfXR3MNLAkfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467238; c=relaxed/simple;
	bh=BGKIvW+QuSy639MKv7/DBEUGPRf9QzPFu13XKIQ74uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BfshZB/JRmxspU1Oi/eZZCKFyvdHi3ub+xILGNPa57scCCOMr/2gxjrx213zjQaQMvpFZO1C18v+vPDTu3nWi2qHPrU8lVc93Z9R/QfgiDl9utifu3Co43bCMyP9u8J7sa1ATs3ncU+9hK8/s1SkFW5n0OerhSd+a0GEPx2pyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSjuvo0S; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714467238; x=1746003238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BGKIvW+QuSy639MKv7/DBEUGPRf9QzPFu13XKIQ74uc=;
  b=QSjuvo0SW/0cCzvQRwylu7x/124QYbcJm3qZFvcOuR21Hrr3L4MtbLFo
   GbM4QP1a6wb/9Xr4HgOgLqPvA7xxAXQw2iroVycWjETmiQc14+R/Pyh8l
   zb1VC6EwvfoB7aiGb4LqZ6xDmIPY1G8oKwYfM+CkiRrsAtgSg7D02+Axv
   kWYo3d0j2QzRwdx3zeMDPYt/J7sOnQjrByqhC6UUGCqxVbehHJn7c8mTl
   wJ7CAXjOQ+gXBgp9jcjYGz98u2PR8GU7OX34SitpKUY69tNGonw3Jk2mv
   m5zQoc7RSlHvEesILtoINaOivKLs0WZuhV2vcMNwHL8Uu3wHI6Hc1Xn6Z
   A==;
X-CSE-ConnectionGUID: j+xgJiCCRMS4RI5bFAud1g==
X-CSE-MsgGUID: EWTQCX02QIuUa8Ae1rykGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21311552"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21311552"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 01:53:56 -0700
X-CSE-ConnectionGUID: l241ZoNeQIeeof6w+W6Kmw==
X-CSE-MsgGUID: PJqShxRRS+GYXQSyfxCF6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26891701"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orviesa007.jf.intel.com with ESMTP; 30 Apr 2024 01:53:49 -0700
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
Subject: [PATCH v7 12/12] ABI: pps: Add ABI documentation for Intel TIO
Date: Tue, 30 Apr 2024 14:22:25 +0530
Message-Id: <20240430085225.18086-13-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240430085225.18086-1-lakshmi.sowjanya.d@intel.com>
References: <20240430085225.18086-1-lakshmi.sowjanya.d@intel.com>
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
index 000000000000..2d9f7dd3813c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-pps-tio
@@ -0,0 +1,7 @@
+What:		/sys/devices/platform/INTCxxxx/enable
+Date:		May 2024
+KernelVersion:	6.10
+Contact:	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
+Description:
+		(RW) Enable or disable PPS TIO generator output, read to
+		see the status of hardware (Enabled/Disabled).
diff --git a/MAINTAINERS b/MAINTAINERS
index f6dc90559341..381e31343db9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17669,6 +17669,7 @@ M:	Rodolfo Giometti <giometti@enneenne.com>
 L:	linuxpps@ml.enneenne.com (subscribers-only)
 S:	Maintained
 W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
+F:	Documentation/ABI/testing/sysfs-platform-pps-tio
 F:	Documentation/ABI/testing/sysfs-pps
 F:	Documentation/devicetree/bindings/pps/pps-gpio.yaml
 F:	Documentation/driver-api/pps.rst
-- 
2.35.3


