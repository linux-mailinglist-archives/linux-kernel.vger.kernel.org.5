Return-Path: <linux-kernel+bounces-157470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6758B11F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B1D1F21C08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DEF1802BA;
	Wed, 24 Apr 2024 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqVwyeMY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BCE17BB15;
	Wed, 24 Apr 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982517; cv=none; b=CB2NYd0nloXtQKln/DRp/YeUYsEVMyFnFT8FOj9qtJuYzpIH0hOMggkU4mwNIorWg25ntHu4Y7F024t7jaLq/6Z2UU+c7BkkIscQGVszpaWO54obb4M6pMVyNeGRN1CGQ2N+ikcmRwPU21OSOPCQltf0WgWiNgzd/BoC1EeHm2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982517; c=relaxed/simple;
	bh=Cso0970iBLZBpku05aR/BgRRak+5ImAGQIo7igDchxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKmXICCm/y6msEwq/YPStP+yLD7EUXx9A/feqOl8xuMtsHkvoSMWQMFuD2dubyUqd/c4WfGUtmL5nzsmCqwgwLd5f+CHUH/+zT+klVlRlQV+hspyxaSN7k1BYsYjcdrDQ+PEIRWJK3aGb97wABx7sLE9zyVjO4kq1SibV5u+S6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UqVwyeMY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713982515; x=1745518515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cso0970iBLZBpku05aR/BgRRak+5ImAGQIo7igDchxw=;
  b=UqVwyeMYdvWQqwY6aLFN+Lj7yRY+RSwBPbCPwynvHQUqoYuJB4+C6cD3
   Xu7khF95YCEVQ1gtk8d60aMd9PtqqMkt6B4MndHf7UvoYDOjF8B5x89I3
   SOmC4suptBxMuO8e60g5NApOKbPiblIHHFMSLrAcDFUJkxByb0IVprjt1
   VT8EpHSIOYUKVOGqKeWHU0upTo5GMJ6oTXRibL2dEYnN7ixayBzclePjw
   if+4I0+CzO7QFZshy4X5jJjr3UsLave0DSjOWgHxXHmOGXP9qaqchwPqo
   UQHRrwqfdEdEPNsvsccM9axQuZ5ggrqwgNP6ROksog6RFGeQGWGL1eHLi
   w==;
X-CSE-ConnectionGUID: Jldg4AnGTtmfXARg68QQtw==
X-CSE-MsgGUID: P7TUpcTbTDqmdEoprQqUmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9481896"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9481896"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:02 -0700
X-CSE-ConnectionGUID: iOx5Qyl8QySbjZH69dcisA==
X-CSE-MsgGUID: ykNmD1OOReqb0Xu6qi2FvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29262662"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:15:02 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v4 22/71] perf/x86/intel/uncore: Switch to new Intel CPU model defines
Date: Wed, 24 Apr 2024 11:15:02 -0700
Message-ID: <20240424181502.41576-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424181245.41141-1-tony.luck@intel.com>
References: <20240424181245.41141-1-tony.luck@intel.com>
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


