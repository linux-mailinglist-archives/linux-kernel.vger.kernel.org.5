Return-Path: <linux-kernel+bounces-164443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD4C8B7DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0932A1C2387E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37EE1A0AFC;
	Tue, 30 Apr 2024 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4poMy0h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70310190680
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495901; cv=none; b=ndWAYIvkt2gWP63iEHpxwoeLZePwycuZWzOWslCHJ6t8Rom/VzItcXoriuaVhf/acYRdsBEQa3mmC7AE5eF4NfVMRczdH40naUs8FKx8BCCWNKP7fICu9FoM/a/GsLlG9lPQq3++NBSFRfRUvmqgBfqLOP4OPNW5kUxE8Nqulu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495901; c=relaxed/simple;
	bh=Imj0PGiI0NRGeoHG/l7mS2RL08/4BXu/ArMN7o0JhVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdnY6QLX7s8f1Z/kijO2I2Dzfwi+EXW5akzWb1BJU8bG8FUAGOgquh2oh5xX2AU1pZSt1jexMpR1KBgF29/rEUGqjlblw6BCrB47O/jzUXffAHqlI2x7sAc5FJxQhFKRnSQcOKUhXMnt7QxrA4fKPEC5HGapTxPYSv9H04AQDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4poMy0h; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495900; x=1746031900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Imj0PGiI0NRGeoHG/l7mS2RL08/4BXu/ArMN7o0JhVQ=;
  b=c4poMy0hofCIvhgd9WTNipZfVfh6k0wAdIHB8CFS7/tYCZpPGGgoIlVc
   4djuy/2LjyKGmtCBNmHxBveMAB+y2bUUKjvTqnt89Bl9MV+rU1KH7UfwT
   +yf7tSpYH44+15uDRtSm3NS6S13CoK76FO777EvsceH/vL2EXuKLdT13x
   1UJebux8pe0qXLlRphvTalgwUzbSjc/0eGeI+3b27i4aRp+HkWFdysJnc
   TAKncuBIu322KI9aVQW2eL4Yv29b5eZI0ZbtvvZgNbqzc+lU7cPXtPYmu
   5cCeg/4syTRzpmc7NKwNikH+s5M4RW7TKJ/4VKH1yiq2/wwY+iO58a+FU
   g==;
X-CSE-ConnectionGUID: bhC+rmf+SLelSxEoQqZmSw==
X-CSE-MsgGUID: Ia9keJM2Ru+YQ3duuf9ngw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075687"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075687"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:21 -0700
X-CSE-ConnectionGUID: voAVff7TQ8OXebssrs6q/g==
X-CSE-MsgGUID: toSK2bL/TvCVli7jnesOrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515458"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:18 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 20/47] platform/x86: intel_turbo_max_3: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:33 -0700
Message-ID: <20240430165100.73491-20-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430165100.73491-1-tony.luck@intel.com>
References: <20240430164913.73473-1-tony.luck@intel.com>
 <20240430165100.73491-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/turbo_max_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/turbo_max_3.c b/drivers/platform/x86/intel/turbo_max_3.c
index 892140b62898..79a0bcdeffb8 100644
--- a/drivers/platform/x86/intel/turbo_max_3.c
+++ b/drivers/platform/x86/intel/turbo_max_3.c
@@ -114,8 +114,8 @@ static int itmt_legacy_cpu_online(unsigned int cpu)
 }
 
 static const struct x86_cpu_id itmt_legacy_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X,	NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,	NULL),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,	NULL),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,	NULL),
 	{}
 };
 
-- 
2.44.0


