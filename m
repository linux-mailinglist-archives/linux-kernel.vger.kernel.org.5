Return-Path: <linux-kernel+bounces-138200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8675589EDFE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7CE71C20D92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F12154C0A;
	Wed, 10 Apr 2024 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZ3Kc7cz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75C513D274;
	Wed, 10 Apr 2024 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738912; cv=none; b=XsLE082xazRZvzaYJzg3Bi76xQ2f0pRb2P6xmTDP5gTLwbyDOFtGTmXYnAY6sAf8I8j/JmsIB2RyUVEzWILywGCseYIaDCYJdNjX/t6wjpJX4xuUtMG+CUdVD1M310+2OhICTjRZ/MtUuys8NxqQMhyadqpVVaIJDkyiT7gVSWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738912; c=relaxed/simple;
	bh=61jPHnCZ/8pf2B+mY3nN/ZOKCq8JfMnl5uS92Vb8dAA=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=eL8Gx+V2mmWnRozzvefSzncbQZkX9OSmY6GSDUoG6tQ4iNS8FKkHz5TAgz2CXbmeUoQQXEpBo9d+AV6OEzU3nhDOmtz3B2tUsMuQn5Np1Y5jwH4YCpJt8s8JskmjBKAVRLJi7t8EV3FEFlIFh3MoLwWvouP6S2PIDA6gepbx5WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZ3Kc7cz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712738911; x=1744274911;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=61jPHnCZ/8pf2B+mY3nN/ZOKCq8JfMnl5uS92Vb8dAA=;
  b=mZ3Kc7cz1W3LCLHg4AQGkF48tmZDTL6J1cOFOV6YYgl/rGdi27YVZud4
   5Eoz1Wl5JCRRY47N9v9wduM+J8o6LBuPbf3C8j7hrSe9tkixe6q7vQ1ad
   sca34h3JPH+mlENUCKujPV3tMCSW8TkmqytwKDfvNFjM1mbLbv73kadA1
   jvlJfkOzMEhEkLmpM4wOb5xoQd4FLSykacuRIVwWhIhpL1EM/V8yowzPj
   7FmD75kYE82ypApKaUPdNS+XHskCgn9PGh9UnH69wHHaGWJo2vN9j0zcc
   evOp3NAyQjDwGjldR36jdhVDUPrHo+uFjtRwTtbqqDapc14c+CRz8SCs3
   A==;
X-CSE-ConnectionGUID: eslKSWjRR+qU247JBTo/CA==
X-CSE-MsgGUID: OV3N/o0gSVCnsqh2yOND8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7946191"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7946191"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 01:48:30 -0700
X-CSE-ConnectionGUID: EcNDN0JxSceH1mlDremgeQ==
X-CSE-MsgGUID: czqeVPCiQTiKstaCEPtrfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51457052"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 01:48:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Wed, 10 Apr 2024 11:43:57 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.9-2
Message-ID: <pdx86-pr-20240410114357-295477719@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.9.

Fixes:
 - intel/hid: Solve spurious hibernation aborts (power button release)
 - toshiba_acpi: Ignore 2 keys to avoid log noise during suspend/resume
 - intel-vbtn: Fix probe by restoring VBDL and VGBS evalutation order
 - lg-laptop: Fix W=1 %s null argument warning

New HW Support:
 - acer-wmi: PH18-71 mode button and fan speed sensor
 - intel/hid: Lunar Lake and Arrow Lake HID IDs

Regards, i.


The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.9-2

for you to fetch changes up to e71c8481692582c70cdfd0996c20cdcc71e425d3:

  platform/x86: lg-laptop: fix %s null argument warning (2024-04-08 18:32:14 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.9-2

Fixes:
 - intel/hid: Solve spurious hibernation aborts (power button release)
 - toshiba_acpi: Ignore 2 keys to avoid log noise during suspend/resume
 - intel-vbtn: Fix probe by restoring VBDL and VGBS evalutation order
 - lg-laptop: Fix W=1 %s null argument warning

New HW Support:
 - acer-wmi: PH18-71 mode button and fan speed sensor
 - intel/hid: Lunar Lake and Arrow Lake HID IDs

The following is an automated shortlog grouped by driver:

acer-wmi:
 -  Add support for Acer PH18-71

intel/hid:
 -  Add Lunar Lake and Arrow Lake support
 -  Don't wake on 5-button releases

intel-vbtn:
 -  Update tablet mode switch at end of probe
 -  Use acpi_has_method to check for switch

lg-laptop:
 -  fix %s null argument warning

toshiba_acpi:
 -  Silence logging for some events

----------------------------------------------------------------
Bernhard Rosenkränzer (1):
      platform/x86: acer-wmi: Add support for Acer PH18-71

David McFarland (1):
      platform/x86/intel/hid: Don't wake on 5-button releases

Gergo Koteles (1):
      platform/x86: lg-laptop: fix %s null argument warning

Gwendal Grignou (2):
      platform/x86: intel-vbtn: Use acpi_has_method to check for switch
      platform/x86: intel-vbtn: Update tablet mode switch at end of probe

Hans de Goede (1):
      platform/x86: toshiba_acpi: Silence logging for some events

Sumeet Pawnikar (1):
      platform/x86/intel/hid: Add Lunar Lake and Arrow Lake support

 drivers/platform/x86/acer-wmi.c     |  9 +++++++++
 drivers/platform/x86/intel/hid.c    |  9 ++++++++-
 drivers/platform/x86/intel/vbtn.c   | 11 ++++-------
 drivers/platform/x86/lg-laptop.c    |  2 +-
 drivers/platform/x86/toshiba_acpi.c |  4 +++-
 5 files changed, 25 insertions(+), 10 deletions(-)

