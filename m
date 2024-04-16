Return-Path: <linux-kernel+bounces-147571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8387E8A7649
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A891C22ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E7C13AA37;
	Tue, 16 Apr 2024 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ffcUO3cp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D084E0D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302404; cv=none; b=ROhhZCbm9Hp2CJ4jr+VlMRZCrhFmMQO4YLyMxmfdKmpDjH427rOZeU4kC5Kct49QbdnxI5NIKnqjiBui+/CkAjl1yKSCJ9gpqmYrZh2LIaId/s1Svu6Hr2lA5Y2+Rr+rjHPL3iKWRz/0wCHwNJb4HpLeUOko1910mGJmhh6q8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302404; c=relaxed/simple;
	bh=Cso0970iBLZBpku05aR/BgRRak+5ImAGQIo7igDchxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucKRaBHIgMWJlcn8LecsF31B275Gx5Btpqpvxc4mBB/tXdu7Mfrv5bQkdfa3efXaKu2sLd8tO3lGnQSzW7Szj7A5PNOUW0qemLQGJZt7K4uWG2rXHRm8v/5x8ksmD8umFvh7ZyYbmslNmHjHytpWgXJB7gqlOM0oqar2uBNsJCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ffcUO3cp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302403; x=1744838403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cso0970iBLZBpku05aR/BgRRak+5ImAGQIo7igDchxw=;
  b=ffcUO3cpk/OHWP/Rj9mDVsRpOCZ7zuz7cNffobmsL91eKoSXRCsxWpY1
   MSsxU0tKbqffTrt0Dju1r8h6B3yrFw93PPxxwqQARvXP02oZm9J0XpItp
   zUalc8wjzuZvLF/7JPj/P6cdtEFhxWIUeFSicG2H6bvdV8f6YWOB1gDG6
   CH/2sMROKcGxraAZz/y931g5rEkRAEUT8iK/fVOmPcvCBDDOlPAp8T+dt
   1L9CN1tyXLm5A5EvxNbMVlCrMXULgc+sOwFw8iTE8PHeXIELe7JEKksPO
   MRzxCs5k+6y/IdwKChixN+h/rB2JR3CYSsDP2OQbysfy8OvNDVA0Dr5E3
   g==;
X-CSE-ConnectionGUID: qUNKowGjSy69LPxKEt/TXw==
X-CSE-MsgGUID: 5XC6d9aHRayKfNZpNBkkdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19914709"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="19914709"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:58 -0700
X-CSE-ConnectionGUID: iGO3ELiJSBeiPfPg6qYJNA==
X-CSE-MsgGUID: 4EiRSOpFRq6V5NafteCipQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22871904"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 14:19:58 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 10/74] x86/cpu/vfm: Update arch/x86/events/intel/uncore_nhmex.c
Date: Tue, 16 Apr 2024 14:19:12 -0700
Message-ID: <20240416211941.9369-11-tony.luck@intel.com>
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
 arch/x86/events/intel/uncore_nhmex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_nhmex.c b/arch/x86/events/intel/uncore_nhmex.c
index 92da8aaa5966..466833478e81 100644
--- a/arch/x86/events/intel/uncore_nhmex.c
+++ b/arch/x86/events/intel/uncore_nhmex.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Nehalem-EX/Westmere-EX uncore support */
+#include <asm/cpu_device_id.h>
 #include "uncore.h"
 
 /* NHM-EX event control */
@@ -1217,7 +1218,7 @@ static struct intel_uncore_type *nhmex_msr_uncores[] = {
 
 void nhmex_uncore_cpu_init(void)
 {
-	if (boot_cpu_data.x86_model == 46)
+	if (boot_cpu_data.x86_vfm == INTEL_NEHALEM_EX)
 		uncore_nhmex = true;
 	else
 		nhmex_uncore_mbox.event_descs = wsmex_uncore_mbox_events;
-- 
2.44.0


