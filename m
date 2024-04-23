Return-Path: <linux-kernel+bounces-155388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063198AE9B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98BF1F25CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD16013B795;
	Tue, 23 Apr 2024 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RgF08P3u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A104E651AB;
	Tue, 23 Apr 2024 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883277; cv=none; b=osuCcYKPmukLSEyS7OOyCI3rGXv1UwE+16MnOZDhTrlkRtad5Z2sYWxY8vy7c5OjKwBYuIsWihL3w7pLfBjcGs5nzebJlsgU+iZR+Pg+iXtMQLjJhjZ8W9LOXqgrWLeMST4DVq46Mw24YYoc0Dj1dDhPnqlvwjE+FCliXSYT+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883277; c=relaxed/simple;
	bh=JmDbnp7jB3iYKQ7kmrwc2e3Fj/aFyXr9ucUALcAe+xo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EyfflGBz2sJdOdYLuXTJtFTckpKOnbiN7FoUtVTtxiSW+ZVUPiUz+R12y7zegJ6y/sCA2TMs31U9pQDTwCJuZd6R7JMMCkuEPkJ7obG46jcVhTWmljn1uo47+J77Zp44nrXSJ9gbZFS3eGCzMoBIXyEfg1N9+7sxUO8MJ3D3k9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RgF08P3u; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713883275; x=1745419275;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JmDbnp7jB3iYKQ7kmrwc2e3Fj/aFyXr9ucUALcAe+xo=;
  b=RgF08P3uVipErfhiQtXZCzHb3bcjMx0GBAqaOF/AQjBKlB9SB6uH4heI
   ngpkEds90JLkNBTvQXPUtjrZxn7Lg17qD4eO+Q/l1Zt6+RIqLcSyh9z96
   L5us0bqSjqnUIs0wCnihjeTE/4K5vzTBuBK4bAN6Ji0gEvQOSAC2JD64l
   MgRqZlNbuwIvfraqtA9JGOT38TnCjBm19pxMKEvsqBVSNREjgJbLMYCka
   sGVUe1zcN9NALd6OjyNC64QA6pUn5j1beOGGVJUWlWJWGyotF8m+Y6Z21
   bP6qZuK9x4o0pPHhXCQejamx35mnGHHcleBEOo+B7TXbMZHH+QJLD2H2K
   Q==;
X-CSE-ConnectionGUID: 6BxdYX0SRjehPg0LDYhfaw==
X-CSE-MsgGUID: UKLdfLL/TJOJucVC5DHaWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="12402889"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="12402889"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:41:14 -0700
X-CSE-ConnectionGUID: 7l8+2zYiQMSa5rnSI9HzpQ==
X-CSE-MsgGUID: e57XYyf+SfOQ1IIN3xF25w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24260682"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.40])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:41:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] net: e1000e & ixgbe: Remove PCI_HEADER_TYPE_MFD duplicates
Date: Tue, 23 Apr 2024 17:40:59 +0300
Message-Id: <20240423144100.76522-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCI_HEADER_TYPE_MULTIFUNC is define by e1000e and ixgbe and both are
unused. There is already PCI_HEADER_TYPE_MFD in pci_regs.h anyway which
should be used instead so remove the duplicated defines of it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/net/ethernet/intel/e1000e/defines.h   | 2 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index 23a58cada43a..5e2cfa73f889 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -679,8 +679,6 @@
 /* PCI/PCI-X/PCI-EX Config space */
 #define PCI_HEADER_TYPE_REGISTER     0x0E
 
-#define PCI_HEADER_TYPE_MULTIFUNC    0x80
-
 #define PHY_REVISION_MASK      0xFFFFFFF0
 #define MAX_PHY_REG_ADDRESS    0x1F  /* 5 bit address bus (0-0x1F) */
 #define MAX_PHY_MULTI_PAGE_REG 0xF
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index ed440dd0c4f9..897fe357b65b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -2179,7 +2179,6 @@ enum {
 #define IXGBE_PCI_LINK_SPEED_5000 0x2
 #define IXGBE_PCI_LINK_SPEED_8000 0x3
 #define IXGBE_PCI_HEADER_TYPE_REGISTER  0x0E
-#define IXGBE_PCI_HEADER_TYPE_MULTIFUNC 0x80
 #define IXGBE_PCI_DEVICE_CONTROL2_16ms  0x0005
 
 #define IXGBE_PCIDEVCTRL2_TIMEO_MASK	0xf
-- 
2.39.2


