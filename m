Return-Path: <linux-kernel+bounces-133744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3DE89A800
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677511C20E50
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E66FCA;
	Sat,  6 Apr 2024 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLqTyImI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9662C184D;
	Sat,  6 Apr 2024 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712365093; cv=none; b=ViRLBAK+NeFYGaDkAysb1ryhK59TARZYpmz6zQBzwjDhAvVmulYKYvgdma46il2b50uFQV7SJS6Xn2WZx8bPfc0/vY5mi3h63RM5e6dundbx1Kl+OryPtJqqNTnRbJL623azEl8vgwUXapRHpovkBYUQ/2ryMCkomAQ+UEeJP7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712365093; c=relaxed/simple;
	bh=ZtqkT4J8lmuJOsX00w6qGkWnFLTgX0qSZd8aVZFXvu0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Nphy0giAlQZrNJzZngdSv8SlEoqaUH36B1eSfc9J+Dbh0vAlSsMn7fsuWVxQRzyhO3EPM3RpS10jYCpai1HrJjQXko3k34ZgnbgqpNstlkNxLY5mNuKpDXYDzghWO1CP6tRLqhG5M/fCClC1MIE6ryz/odzlKcWA2/Ny8QZaUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLqTyImI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712365092; x=1743901092;
  h=from:to:cc:subject:date:message-id;
  bh=ZtqkT4J8lmuJOsX00w6qGkWnFLTgX0qSZd8aVZFXvu0=;
  b=gLqTyImIULn9EsNn+dsWUcXFNXIUillWDbuN/mPcaS5BvAZT8tuPZkqm
   ze1Vb6EnxPRslG+7F6BXKH2YhD/GRmlMj2DWi8tdhdrGOEoIorWWbaJCo
   jZZWCEcPcIH3+NiXsgPMMXyFG+vqMgN8kyMQKGpjcXfEoJ2IGgA5ILGxC
   PHEFow7pvmMy8TY5jqGFudoz7GWLnt6bA9JOscInnF8joI7Xvcg5BvG9W
   nTQAakUfQh+Yxh5oANmOyllqkmi7PojZLm0VV3cwTbsW+DoVSxzMLOA+3
   Rlvc1ezUmtDic0MunXFS8Ck3d/J/espOAzw3WXIoToU2dB+2dSouU1Gus
   Q==;
X-CSE-ConnectionGUID: ezuBSDfVSnmMELFOrqu8Pg==
X-CSE-MsgGUID: 4wM4owjHRLqSyGlsRIIFfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="25153865"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="25153865"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 17:58:11 -0700
X-CSE-ConnectionGUID: 9Cb6ksdERXKav2uYlHN1tw==
X-CSE-MsgGUID: Cn0cpPy1SEqG+jMqV9c2sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19252360"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP; 05 Apr 2024 17:58:11 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH 0/3] drivers: thermal/hwmon: intel: Use model-specific bitmasks for temperature registers
Date: Fri,  5 Apr 2024 18:04:13 -0700
Message-Id: <20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi,

We have been treating the register MSR_TEMPERATURE_TARGET as a
architectural. It is model-specific.

The registers IA32_[PACKAGE]_THERM_STATUS are architectural. However, they
have become model-specific: in recent processors the temperature readout
occupies bits [23:16] whereas the Intel Software Developer's manual
specifies that it uses [22:16].

Using incorrect bitmasks leads to incorrect temperature readings and
writes to reserved register bits. For instance, temperatures below ~-27C
(depending on the value of TjMax) would be read incorrectly if only the
bits [22:16] of IA32_THERM_[PACKAGE]_STATUS are used.

Update the intel_tcc library to use model-specific bitmasks. Also update
the hwmon/coretemp and intel_tcc_cooling drivers drivers to use the model
checking utilities of intel_tcc.

Updating hwmon/coretemp to use the intel_tcc library required to add a
weak reverse dependency on CONFIG_INTEL_TCC. The less attractive
alternative would be to duplicate the model checking functionality of
intel_tcc in hwmon/coretemp.

I have tested these patches on Alder Lake, Meteor Lake, and Grand Ridge
systems by looking at the temp*_input sysfs files of hwmon.

These patches apply cleanly on top of the `testing` branches of the
linux-pm and hwmon repositories.

Thanks and BR,
Ricardo

Ricardo Neri (3):
  thermal: intel: intel_tcc: Add model checks for temperature registers
  thermal: intel: intel_tcc_cooling: Use a model-specific bitmask for
    TCC offset
  hwmon: (coretemp) Use a model-specific bitmask to read registers

 drivers/hwmon/Kconfig                     |   1 +
 drivers/hwmon/coretemp.c                  |   6 +-
 drivers/thermal/intel/intel_tcc.c         | 177 +++++++++++++++++++++-
 drivers/thermal/intel/intel_tcc_cooling.c |   2 +-
 include/linux/intel_tcc.h                 |   8 +
 5 files changed, 187 insertions(+), 7 deletions(-)

-- 
2.34.1


