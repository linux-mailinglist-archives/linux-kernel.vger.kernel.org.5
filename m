Return-Path: <linux-kernel+bounces-147621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEB18A7699
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38601B231B3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC7F13BAE4;
	Tue, 16 Apr 2024 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SxOdgDZP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D9715358B;
	Tue, 16 Apr 2024 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302552; cv=none; b=X/+pnu8ijuGkB6H7i2l9ZPH7lyKupBpChasGRfKJO7h2LrQ0Xrdyc1PLWN3HzbQSKYWal1/Y7VR88l615Ez0P3DRAxLODpiDHFIfxHsAtqLdHI19ZxuGjT4TP6MDhRRIAXDLvdiW7NEmXs5OgeNsTC0WWUgXtgNumSPrgruN6UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302552; c=relaxed/simple;
	bh=WDk3Nytz3rdQKdrZoCkbG+T02Itdm5c/GxoSZ2n45IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dg9kmgSydmxeKBsZWftfvart1mXdVbLHQUb4M9G7rTevLKdyGQ+qi8djXIDAa9F3ojQZbeSutP30wV/A7l1yeqvwkwCNBT/28T/Odv3SQ3q6Z5nOPobn0SnQU7l2mWs9RlFQy0iyh2yA89xyHrkeDU2xO6LUM9XVwpU0M5AvooI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SxOdgDZP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302551; x=1744838551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WDk3Nytz3rdQKdrZoCkbG+T02Itdm5c/GxoSZ2n45IU=;
  b=SxOdgDZPYzSpUzDtnFYBSUeARh8FBnym19GQ8iraM56Y4JrN9qeUnhav
   wNSA7K8SdR3geKu5o2ZuTqR4yUy7CTNUA9FBg1aUd6jCbeoKjcLWk/COr
   boEbZtS0I6SQr1QI0ZIXp3HzHzK5ke5ozU88SoNrJkByKy+T3SZnrjWmj
   VcIp3D+JgM7rciUuDGoqMhbIwfFufTkNG8qO0BNvESGAtSbVgrUrhCDt/
   y9S2r3XwSn1+ygg6iSTQv3L4PNE8GTdJEVzJk9OvgbZxnPa1gfwKD0r0Q
   GvXv/eVyPYXTaw5rpgYYiDcZs5mI6hOgCzzUR5x5Xl1Ihi4E4fsfeR/cM
   w==;
X-CSE-ConnectionGUID: zfJVlixbRk+sdjCxTFhYCg==
X-CSE-MsgGUID: c3t7QMofQ/y0mTvqCnwckw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26234943"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26234943"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:31 -0700
X-CSE-ConnectionGUID: t0OERbynTl+B3T30JVGjfw==
X-CSE-MsgGUID: oOe4Yg3tRbKuWYPGYiZZaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22267139"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:22:30 -0700
From: Tony Luck <tony.luck@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 58/74] x86/cpu/vfm: Update drivers/platform/x86/intel_scu_wdt.c
Date: Tue, 16 Apr 2024 14:22:29 -0700
Message-ID: <20240416212229.9757-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416211941.9369-1-tony.luck@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel_scu_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_wdt.c b/drivers/platform/x86/intel_scu_wdt.c
index a5031a25632e..d0b6637861d3 100644
--- a/drivers/platform/x86/intel_scu_wdt.c
+++ b/drivers/platform/x86/intel_scu_wdt.c
@@ -50,7 +50,7 @@ static struct intel_mid_wdt_pdata tangier_pdata = {
 };
 
 static const struct x86_cpu_id intel_mid_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, &tangier_pdata),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, &tangier_pdata),
 	{}
 };
 
-- 
2.44.0


