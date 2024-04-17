Return-Path: <linux-kernel+bounces-148667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6A48A85D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B681C20A39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C851411ED;
	Wed, 17 Apr 2024 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpEsc9fS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E66140397;
	Wed, 17 Apr 2024 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363559; cv=none; b=ILRQShyWo82EiDSAVcrJffF7MfrcG0nIEhv7/kpoAHPZov7q4jukxu5DW4Y/WnjCoFA1IOPRJweer38/530riJuorB06F2uqVKtBmogaPOWOoegqLpDHHXtDGL3RlsJTt/cEmj5EyLziIArXUBHOLBwjdcOPshzbu3rMrJmhkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363559; c=relaxed/simple;
	bh=xR2IotytVan8z9tF1Lsa0SbjGM6BnWbxCxo46sFxDTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y2LPCH96Tnzf2LpnBL60aeXn+e6+T7cfendivahMBJahKRp+8THbnAfjqwqXZkvrS9iI4gJ9M1rJ68e4zUA5fqkb9qfCeg8C3wyz9SjDtNQnUQnmyEntlb8hxRUHmZbEt5LGZaDrD+qOqm+GNMz0d3KXwlKkFcJfY0NqUhLqaHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpEsc9fS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713363559; x=1744899559;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xR2IotytVan8z9tF1Lsa0SbjGM6BnWbxCxo46sFxDTo=;
  b=LpEsc9fS8WS0WFf5Gdo7PuIez9DVYFqjFCoCrsRCA8kyJOcJ7gcb7D1f
   AKIxlzosLgMz9gLJm0Yb46YOfytWEKyA0bNgo6T61DqGgaLnwAJ3OqEkt
   DytUMwPuPeSSagcTzIbs8kI8xt2jOnr684C34XOMlg4zErN4fVULJ0I1K
   cbsJ6rwDLhWKU4S1zTFLiqprf5IY/KBx2F0RIExj0RSz0PhxaLjtflxlE
   /vHQxgdVGPiqYRkTi+TZi+ag/93XjrU2uszgFTXVjrg4VfPslAReIaKtK
   5iS8sX7tYThICHnzRSjfzsXpXZkAZcg0+GKEjZ311ywwjxjRToGw62qef
   A==;
X-CSE-ConnectionGUID: WSdatNZuRjau5S4Lb1fRPQ==
X-CSE-MsgGUID: tudj9praQJ2GWq6Fg8aV2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12637232"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="12637232"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 07:19:18 -0700
X-CSE-ConnectionGUID: ydDNBc6bSOWKYVn/1aWD2A==
X-CSE-MsgGUID: AhufXyhTSYu7rvHwXOZjcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22720787"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 17 Apr 2024 07:19:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 00D94169; Wed, 17 Apr 2024 17:19:14 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v1 1/1] gpiolib: swnode: Remove wrong header inclusion
Date: Wed, 17 Apr 2024 17:19:13 +0300
Message-ID: <20240417141914.2905621-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flags in the software node properties are supposed to be
the GPIO lookup flags, which are provided by gpio/machine.h,
as the software nodes are the kernel internal thing and doesn't
need to rely to any of ABIs.

Fixes: e7f9ff5dc90c ("gpiolib: add support for software nodes")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/gpio/property.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/gpio/property.h b/include/linux/gpio/property.h
index 6c75c8bd44a0..1a14e239221f 100644
--- a/include/linux/gpio/property.h
+++ b/include/linux/gpio/property.h
@@ -2,7 +2,6 @@
 #ifndef __LINUX_GPIO_PROPERTY_H
 #define __LINUX_GPIO_PROPERTY_H
 
-#include <dt-bindings/gpio/gpio.h> /* for GPIO_* flags */
 #include <linux/property.h>
 
 #define PROPERTY_ENTRY_GPIO(_name_, _chip_node_, _idx_, _flags_) \
-- 
2.43.0.rc1.1336.g36b5255a03ac


