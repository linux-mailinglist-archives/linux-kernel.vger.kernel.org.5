Return-Path: <linux-kernel+bounces-163595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 476D18B6D76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A4228814D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570EA12838F;
	Tue, 30 Apr 2024 08:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lCYBpJWB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADC61E48B;
	Tue, 30 Apr 2024 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467156; cv=none; b=JRb4nsvjGS5M+S8uQ+NRH2o/3hsiIyJvC5Fy6iHW99X4jUYSghci0I53cJohpv4U/R3brDtEbgcnGot7JjhOgSTxtxKeIB7cY7hO8ERMI/glpXJUOggvazziDTTIOBxe0MgJnBq07lLTaeg6wfCOm8XGd5Zks+H4AwnPPb2H4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467156; c=relaxed/simple;
	bh=TXs16JUTJJYiNwzKrUs3bjsFv/mqblL5veTLN9Ghv18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t1nUZhIG7SOYMzTW+JZONereLYNgoZgu6KCyd0Ioa1zAINff8gHFG6OePAwG2JCsyeETk9XN28PEL96UXNoU9RyqqJWFZEsa9bdadgRYPKJOhvzBlaflsJeIaJVwhWeIerx74UnQvPcfPNxaomsZujhhzuDmJ+mbSiHBGjraJ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lCYBpJWB; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714467155; x=1746003155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TXs16JUTJJYiNwzKrUs3bjsFv/mqblL5veTLN9Ghv18=;
  b=lCYBpJWB4NG0WVV8tL38TWhr1T/2nqJmqLGIvD9khGJJxHVHtczvjchm
   6mE/AjrCaQRxK//ooeSGKRWt+j/eM1wU7JBQpkoWXgtRyJL1soOkLMHW2
   Jr8EJad9PPPNiQWM49AmJ2xqTACjoX2NJp8i7tZvlXyJOqaWjcGgpP1cq
   VO8l7u4qQ4jPdyjV2ohi2k1SY5bnDlvqIPUNgMKUpEUZjgte6ZVTHdxBJ
   AMwtRuBbiAN9vJE38WySwBX5AYrac0PShZQP6KPVVZ/Mglr8PbCIEj11B
   9DYBllkZfNmQRAZan1BLdA4GZQ+vEFkE3ngQx5jIb/DxTo8VQKK1rcHpN
   g==;
X-CSE-ConnectionGUID: 1DYbti+OQ2e/uqdpDlTilA==
X-CSE-MsgGUID: 3kEckPtkR+2GKYLFY30FrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="21311243"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="21311243"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 01:52:33 -0700
X-CSE-ConnectionGUID: QlDMvrfbR4+RDn7PCv4t9A==
X-CSE-MsgGUID: FPAD6XhCSMienCnGnbUeAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26891476"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orviesa007.jf.intel.com with ESMTP; 30 Apr 2024 01:52:26 -0700
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
Subject: [PATCH v7 00/12] Add support for Intel PPS Generator
Date: Tue, 30 Apr 2024 14:22:13 +0530
Message-Id: <20240430085225.18086-1-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

The goal of the PPS (Pulse Per Second) hardware/software is to generate a
signal from the system on a wire so that some third-party hardware can
observe that signal and judge how close the system's time is to another
system or piece of hardware.

Existing methods (like parallel ports) require software to flip a bit at
just the right time to create a PPS signal. Many things can prevent
software from doing this precisely. This (Timed I/O) method is better
because software only "arms" the hardware in advance and then depends on
the hardware to "fire" and flip the signal at just the right time.

To generate a PPS signal with this new hardware, the kernel wakes up
twice a second, once for 1->0 edge and other for the 0->1 edge. It does
this shortly (~10ms) before the actual change in the signal needs to be
made. It computes the TSC value at which edge will happen, convert to a
value hardware understands and program this value to Timed I/O hardware.
The actual edge transition happens without any further action from the
kernel.

The result here is a signal coming out of the system that is roughly
1,000 times more accurate than the old methods. If the system is heavily
loaded, the difference in accuracy is larger in old methods.

Application Interface:
The API to use Timed I/O is very simple. It is enabled and disabled by
writing a '1' or '0' value to the sysfs enable attribute associated with
the Timed I/O PPS device. Each Timed I/O pin is represented by a PPS
device. When enabled, a pulse-per-second (PPS) synchronized with the
system clock is continuously produced on the Timed I/O pin, otherwise it
is pulled low.

The Timed I/O signal on the motherboard is enabled in the BIOS setup.
Intel Advanced Menu -> PCH IO Configuration -> Timed I/O <Enable>

References:
https://en.wikipedia.org/wiki/Pulse-per-second_signal
https://drive.google.com/file/d/1vkBRRDuELmY8I3FlfOZaEBp-DxLW6t_V/view
https://youtu.be/JLUTT-lrDqw

Patch 1 adds base clock properties in clocksource structure
Patch 2 updates tsc, art values in the base clock structure
Patch 3 - 7 removes reference to convert_art_to_tsc function across
drivers
Patch 8 removes the convert art to tsc functions which are no longer
used
Patch 9 adds function to convert realtime to base clock
Patch 10 adds the pps(pulse per second) generator tio driver to the pps
subsystem.
Patch 11 documentation and usage of the pps tio generator module.
Patch 12 includes documentation for sysfs interface.

Please help to review the changes.

Thanks in advance,
Sowjanya

Changes from v2:
 - Split patch 1 to remove the functions in later stages.
 - Include required headers in pps_gen_tio.

Changes from v3:
 - Corrections in Documentation.
 - Introducing non-RFC version of the patch series.

Changes from v4:
 - Setting id in ice_ptp
 - Modified conversion logic in convert_base_to_cs.
 - Included the usage of the APIs in the commit message of 2nd patch.

Changes from v5:
 - Change nsecs variable to use_nsecs.
 - Change order of 1&2 patches and modify the commit message.
 - Add sysfs abi file entry in MAINTAINERS file.
 - Add check to find if any event is missed and disable hardware
   accordingly.

Changes from v6:
 - Split patch 1 into 1&2 patches.
 - Add check for overflow in convert_ns_to_cs().
 - Refine commit messages. 

Lakshmi Sowjanya D (7):
  timekeeping: Add base clock properties in clocksource structure
  x86/tsc: Update tsc/art values in the base clock structure
  x86/tsc: Remove art to tsc conversion functions which are obsolete
  timekeeping: Add function to convert realtime to base clock
  pps: generators: Add PPS Generator TIO Driver
  Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
  ABI: pps: Add ABI documentation for Intel TIO

Thomas Gleixner (5):
  e1000e: remove convert_art_to_tsc()
  igc: remove convert_art_ns_to_tsc()
  stmmac: intel: remove convert_art_to_tsc()
  ALSA: hda: remove convert_art_to_tsc()
  ice/ptp: remove convert_art_to_tsc()

 .../ABI/testing/sysfs-platform-pps-tio        |   7 +
 Documentation/driver-api/pps.rst              |  22 ++
 MAINTAINERS                                   |   1 +
 arch/x86/include/asm/tsc.h                    |   3 -
 arch/x86/kernel/tsc.c                         |  92 ++-----
 drivers/net/ethernet/intel/e1000e/ptp.c       |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   3 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c      |   6 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |   3 +-
 drivers/pps/generators/Kconfig                |  16 ++
 drivers/pps/generators/Makefile               |   1 +
 drivers/pps/generators/pps_gen_tio.c          | 260 ++++++++++++++++++
 include/linux/clocksource.h                   |  27 ++
 include/linux/clocksource_ids.h               |   1 +
 include/linux/timekeeping.h                   |   6 +
 kernel/time/timekeeping.c                     | 125 ++++++++-
 sound/pci/hda/hda_controller.c                |   3 +-
 17 files changed, 496 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio
 create mode 100644 drivers/pps/generators/pps_gen_tio.c

-- 
2.35.3


