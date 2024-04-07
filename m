Return-Path: <linux-kernel+bounces-134197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBB789AEE1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2471C219E9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0BB7460;
	Sun,  7 Apr 2024 06:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QG89tVRI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B387E6AB9;
	Sun,  7 Apr 2024 06:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712471635; cv=none; b=nEwnZkYtexECWr1lZ2GFDbXctnVZGhI0tH8edm4fX5EFTY3YwLnEV1dTubCdfw8k/kUpfppcNsJcjTYD0Ag3lE+QKGCTVr4GHnrGvrQWk8NLrS3Ni5qRm+Orf7lofR2ec2nJAYkO+ZjbqfvktWv2rQRfkL7hrikVOx7V6Zk2J84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712471635; c=relaxed/simple;
	bh=ueiNX1HaLfToIZUTUWgeWXk4WWITjkG0gU8uwB57+vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uuoPhHDBwFPg1hRsFMhhdtJc5vANz2U3vLDv5YoGqRUAsMWcD7A5YEztjaVMTV/W0aJtyeLjCTquAgNuX6n/9AKdb4V3YCdcalW0OAvxcC28P1oa0F7ZEuGjkNrB0nLnKYqwPz5QjXR+iIVE0o39FGjKUhTtgMFj8Jej1tLtj4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QG89tVRI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712471633; x=1744007633;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ueiNX1HaLfToIZUTUWgeWXk4WWITjkG0gU8uwB57+vc=;
  b=QG89tVRI06LWwk9rMNWgfiyapdgfcvA+vLs/rkE48ognm6ekH3Nvjp4c
   Qp1dNg2jCbr7cv1ny2ugkmK4p17JbbQ6DhzOuHfWVwnesz6Wl2tHKMKS3
   /c9CAB2y4G1bag9oTIYal3mZ3fI3QQqw192ksZo84yF7aemuOuEB8t3Wa
   RHxr7mMaM9ELBo0EBhRCFPIvanH7fJpIhIzj8cG6KygVOwCkc+Tzw0/Y0
   yMVgA9i9T1+OlminvK2Ja/XEuWMbRvbWH//WoJnbEcvq+DBRzVqi0P/vP
   Bt3BDtZBagIw24ZNuiHKT0+tNUqgXYcZ+Ho7dHiwUYJhKVfn144uCFOOC
   w==;
X-CSE-ConnectionGUID: Q7aEcHdsQFuYml1xVGm8nw==
X-CSE-MsgGUID: sIAeDWqPQa2PsZZ17vdmPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="18333299"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="18333299"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 23:33:52 -0700
X-CSE-ConnectionGUID: lyYkMamuTCC0iuuE5kEu/A==
X-CSE-MsgGUID: ZaB5BIjbTOemTxDr/pIGew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="19684324"
Received: from emscott-mobl.amr.corp.intel.com (HELO skuppusw-mobl3.amr.corp.intel.com) ([10.209.36.196])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 23:33:52 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] ACPI: Declare acpi_blacklisted() only if CONFIG_X86 is enabled
Date: Sat,  6 Apr 2024 23:33:41 -0700
Message-Id: <20240407063341.3710801-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function acpi_blacklisted() is defined only when CONFIG_X86 is
enabled. So to keep it consistent, protect its declaration with
CONFIG_X86.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 include/linux/acpi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 34829f2c517a..3ad6bed9eb4f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -421,7 +421,9 @@ extern char *wmi_get_acpi_device_uid(const char *guid);
 
 extern char acpi_video_backlight_string[];
 extern long acpi_is_video_device(acpi_handle handle);
+#ifdef CONFIG_X86
 extern int acpi_blacklisted(void);
+#endif
 extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
-- 
2.34.1


