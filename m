Return-Path: <linux-kernel+bounces-167961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB46E8BB1A8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4461C22862
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2669E158862;
	Fri,  3 May 2024 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGxVYpHv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D27158203;
	Fri,  3 May 2024 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756785; cv=none; b=MqSHgig02R4rqyLarNEehRVokPXW8E0PBw6Wy/GX2EV7yI+WDhACkle9+8o/hBLshZHYCD1gYoutwoh660opkngQyeCd2Z9o062fjz5vQkNJUOhw/3Mc68bFXggeo366WJJu2Az1c/sRmmsPiL0dtzs+U+jkthMoYS5kPS0vNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756785; c=relaxed/simple;
	bh=8c8iP3FfxTPGyNOsn6h/6Zno90lXdQeEM+LI0vu8P7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cry05Noqo4LvcEM0zMEONkVun26Ovavjl/yWndJ7hzftooP29pkmO+gcbuj6E/JYe7kD3GeMh+uG5H9FX/Gdm798L95NwGP0c2yg7WY7GV9oDvGOK0otjIQxLftSIaAXyg4HcnDfMhXsbbQQWYq7H24lpfa/tiIuVldLsYnpSw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGxVYpHv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714756784; x=1746292784;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8c8iP3FfxTPGyNOsn6h/6Zno90lXdQeEM+LI0vu8P7A=;
  b=DGxVYpHvcLNcoZA+Qvy63Vm8AoapoBUbbpHDnWBeesYLakWHdS91G3zt
   2gKISHorLs6sAobJKRBgfxFwDc1XbjjRQGqZ2ZUxGH1YZ/4k2ijfUo3wE
   0aAWXL33KYM+/euUB/+o+yZbH1C5RbUjzOwpm9bkivIa4P5UzhLR0vlqR
   SqKLN3zfx3hECABmSzKmLVAHG3JRxX1YopVHViEr8ef7Ph7c557bhB/fg
   x7xt2kbCezsoIjxGEWJlFfEweiDgDqCdX4IaIeSHSfPtFu5hqWKNuBIOH
   k98a0FYjwEKOoZb5KjOVr4UUrie/3rgVQ2Q11drfbX5zgrpqLi+LmfIpX
   g==;
X-CSE-ConnectionGUID: qZEu6/DjQEqvaNFD3YtDfQ==
X-CSE-MsgGUID: 4J2hlghTQKKxbAwThideCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="11107802"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="11107802"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:19:41 -0700
X-CSE-ConnectionGUID: W58FNlqnR3WRr4kBXcJHZA==
X-CSE-MsgGUID: WT028gfPS5i4u6L8v5aKyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="58415414"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 03 May 2024 10:19:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1D0A719E; Fri,  3 May 2024 20:19:37 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 00/13] serial: 8250_exar: Clean up the driver
Date: Fri,  3 May 2024 20:15:52 +0300
Message-ID: <20240503171917.2921250-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After a rework for CONNTECH was done, the driver may need a bit of
love in order to become less verbose (in terms of indentation and
code duplication) and hence easier to read.

This clean up series fixes a couple of (not so critical) issues and
cleans up the recently added code. No functional change indented by
the cleaning up part.

Parker, please test this and give your formal Tested-by tag
(you may do it by replying to this message if all patches are
 successfully tested; more details about tags are available in
 the Submitting Patches documentation).

In v2:
- fixed the EEPROM reading data loop (Ilpo, Parker)

Andy Shevchenko (13):
  serial: 8250_exar: Don't return positive values as error codes
  serial: 8250_exar: Describe all parameters in kernel doc
  serial: 8250_exar: Kill CTI_PCI_DEVICE()
  serial: 8250_exar: Use PCI_SUBVENDOR_ID_IBM for subvendor ID
  serial: 8250_exar: Trivia typo fixes
  serial: 8250_exar: Extract cti_board_init_osc_freq() helper
  serial: 8250_exar: Kill unneeded ->board_init()
  serial: 8250_exar: Decrease indentation level
  serial: 8250_exar: Return directly from switch-cases
  serial: 8250_exar: Switch to use dev_err_probe()
  serial: 8250_exar: Use BIT() in exar_ee_read()
  serial: 8250_exar: Make type of bit the same in exar_ee_*_bit()
  serial: 8250_exar: Keep the includes sorted

 drivers/tty/serial/8250/8250_exar.c | 459 ++++++++++++----------------
 1 file changed, 203 insertions(+), 256 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


