Return-Path: <linux-kernel+bounces-150421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE828A9F00
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF651C21191
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF18A16F843;
	Thu, 18 Apr 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b78jvRea"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17EE16D4C0;
	Thu, 18 Apr 2024 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455375; cv=none; b=MEFf+jCLu9tP6GQm1u5GFY4txcnQgR4gjyfgptlnkbmlcAnEieieHmKTBWG/PVXSn1ChwnNewWOgB/t4y4Jo9NP2PX/RGi4cT7Uqpnm8VqM3s4rMZQCu3DHJQezftMd1E1GRuL09XZ9t3KB89WTJ/H8hTa8L0KtQQvn+O87QmFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455375; c=relaxed/simple;
	bh=/ubX+TrhSwxmnlim1SfQGnjKVnNUrHqxciUKFKIgY8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FCcKp9V1JDXo4FJQL8vVzdCa41wu9mpCl4QFuMG7faF4REA4TReJrP/04uiG/ZUWazOziVkn254A43IgzDuf3KbePktBUSV/lqmiTO29ADvJm89bOfhISTNA752OFBGV00F1v7hZx9zM2IWWhrj4JZrTmwlOfOdlINVC+0h5T5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b78jvRea; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713455373; x=1744991373;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/ubX+TrhSwxmnlim1SfQGnjKVnNUrHqxciUKFKIgY8Q=;
  b=b78jvRea3kiOPj8Z7XLpzshcSNfnWYMIgKcNXz1L8vakLb06kSEbv3Lo
   fumDHoZHINGiKP3p7qlPIhu7PQMU2fRZSwCFiRFJzDwBN3rWGXTXTdfFm
   nrvOWg6NkMv+dad9qGIr2xPd8HEXS/SgaYrSn0aUSGth+3/TcI6OOkmf1
   CBPcR/s53OjbAD/LTkxEBSVIax9B4p1AUT6sSypHgyEvRzSxl+ay31yF+
   ZEcHu49qN4l7hqx/5ob39h9ykawfC6aTa3VqMqMUCs+DhgTrBTJm0uNTZ
   11ZUREAH0SeLW500HLeXxUdhhD/gI5MizaQIXerXPFXZX8zgzq930gD71
   w==;
X-CSE-ConnectionGUID: MZWHeU2ySW29xfZIYlarHw==
X-CSE-MsgGUID: x1S6bDOxTGqiON+OmOhzfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19712736"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="19712736"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 08:49:32 -0700
X-CSE-ConnectionGUID: SKVz+/+ASyuF10+OCyN9Ag==
X-CSE-MsgGUID: A+SzQQOnTTah6ztGAJxfaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="27835070"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 18 Apr 2024 08:49:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7741624D; Thu, 18 Apr 2024 18:49:29 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Niklas Neronin <niklas.neronin@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] xhci: pci: Little PCI IDs refactoring
Date: Thu, 18 Apr 2024 18:48:32 +0300
Message-ID: <20240418154928.3641649-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a couple of updates to the PCI IDs in order of better maintenance.
No functional change intended.

Andy Shevchenko (2):
  xhci: pci: Use full names in PCI IDs for Intel platforms
  xhci: pci: Group out Thunderbolt xHCI IDs

 drivers/usb/host/xhci-pci.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


