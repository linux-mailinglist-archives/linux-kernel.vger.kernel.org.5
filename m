Return-Path: <linux-kernel+bounces-147345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AD18A72C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CC21C2150C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55773134431;
	Tue, 16 Apr 2024 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aaKd75up"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF5B134405;
	Tue, 16 Apr 2024 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713290574; cv=none; b=Y3p5+Y2vvADz3ocC1TxJYOhcIF1yKBStYU6A0TPUB5gnvsPTw0tH1i++jVbONn/wCO1CwuFnyb5gP5p5CIqYjXvgTrpYIoz/U8EWqoiyDse5SKmutRVORpkKAYL0F8IZBeB6KxNeE1/WmrpPwwI2f5E7CfujO36MGwQwqZLGi9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713290574; c=relaxed/simple;
	bh=RGobAnthjkgsb/QzuzeMGs8pm1LeGhwCVTyS3CsT0Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YtLOfg7SlvZiw7SLTnUrVOWtf0eWWLHVGXM/8nmDP76Bo2FkLZNZADoELtNIH6vHL2isIMaq2XJFEICQPyAg9s97jWcU9Q88fX6+WTqtdNh6ilEKmUT6kHavQ1RweGFtwRG0KTCZgtkrNycSn6IcV6RF2KzpLbhi/VLoKx+kOHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aaKd75up; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713290573; x=1744826573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RGobAnthjkgsb/QzuzeMGs8pm1LeGhwCVTyS3CsT0Qo=;
  b=aaKd75upi/K+6pDjCRzh7nt+arqPqhJDkENHlWeRrQo+61ivaSNUg7yk
   5V2bHavWGyPT/+haOKHjn87FMQkS8a5hCFaichSVCy/s5NPEvtenaSdMQ
   jdlcgRJiSK9gAr+VAi1HG7CBv0AFjk9WN4yajTrHBUilIfDXVLnOg31el
   oVyPLwOYiALA/TMA+v0UuLIQn+3hQApJIFA8jlNb9Uz8uQC/wGajFAQUp
   0yZc7ZgdRGebSWKXffid8xyXuwZr39KsPvneeOtr82cb8ekzH/4bs0GiV
   jvWVN0Z/u8g2U4IqePK8fSgSevLg6fnPPEkaxD+gb5x5mf183W9ufW/+j
   A==;
X-CSE-ConnectionGUID: s+hj1Wd5Q9+WrHXDP73pWg==
X-CSE-MsgGUID: CMVVbtEqSRy96DFBsokpEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8919455"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8919455"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:02:51 -0700
X-CSE-ConnectionGUID: CzZ0kg0PQoSYEmRkCRwOgw==
X-CSE-MsgGUID: eBu4AKCaTcm/ARo6DiMKeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22821944"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 16 Apr 2024 11:02:52 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: irogers@google.com,
	mpetlan@redhat.com,
	eranian@google.com,
	ak@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [RESEND PATCH] perf/x86/intel/uncore: Fix the bits of the CHA extended umask for SPR
Date: Tue, 16 Apr 2024 11:01:45 -0700
Message-Id: <20240416180145.2309913-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The perf stat errors out with UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL
event.

 $perf stat -e uncore_cha_55/event=0x35,umask=0x10c0008101/ -a -- ls
    event syntax error: '..0x35,umask=0x10c0008101/'
                                      \___ Bad event or PMU

The definition of the CHA umask is config:8-15,32-55, which is 32bit.
However, the umask of the event is bigger than 32bit.
This is an error in the original uncore spec.

Add a new umask_ext5 for the new CHA umask range.

Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
Closes: https://lore.kernel.org/linux-perf-users/alpine.LRH.2.20.2401300733310.11354@Diego/
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/uncore_snbep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index a96496bef678..7924f315269a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -461,6 +461,7 @@
 #define SPR_UBOX_DID				0x3250
 
 /* SPR CHA */
+#define SPR_CHA_EVENT_MASK_EXT			0xffffffff
 #define SPR_CHA_PMON_CTL_TID_EN			(1 << 16)
 #define SPR_CHA_PMON_EVENT_MASK			(SNBEP_PMON_RAW_EVENT_MASK | \
 						 SPR_CHA_PMON_CTL_TID_EN)
@@ -477,6 +478,7 @@ DEFINE_UNCORE_FORMAT_ATTR(umask_ext, umask, "config:8-15,32-43,45-55");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext2, umask, "config:8-15,32-57");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext3, umask, "config:8-15,32-39");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
+DEFINE_UNCORE_FORMAT_ATTR(umask_ext5, umask, "config:8-15,32-63");
 DEFINE_UNCORE_FORMAT_ATTR(qor, qor, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
@@ -5957,7 +5959,7 @@ static struct intel_uncore_ops spr_uncore_chabox_ops = {
 
 static struct attribute *spr_uncore_cha_formats_attr[] = {
 	&format_attr_event.attr,
-	&format_attr_umask_ext4.attr,
+	&format_attr_umask_ext5.attr,
 	&format_attr_tid_en2.attr,
 	&format_attr_edge.attr,
 	&format_attr_inv.attr,
@@ -5993,7 +5995,7 @@ ATTRIBUTE_GROUPS(uncore_alias);
 static struct intel_uncore_type spr_uncore_chabox = {
 	.name			= "cha",
 	.event_mask		= SPR_CHA_PMON_EVENT_MASK,
-	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,
+	.event_mask_ext		= SPR_CHA_EVENT_MASK_EXT,
 	.num_shared_regs	= 1,
 	.constraints		= skx_uncore_chabox_constraints,
 	.ops			= &spr_uncore_chabox_ops,
-- 
2.35.1


