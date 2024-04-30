Return-Path: <linux-kernel+bounces-164446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 291E78B7DD0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D935D287F26
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806C81A38E1;
	Tue, 30 Apr 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6Oc8uUH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B0199E85
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495901; cv=none; b=WMiOkRH9iUnWz2ZA1iWJFUmLvAkpk7UnhJ/UBgqFQyuOyoNWy4MoTOo8pyJOTAX0MIkr0oakEGwYohjaXJJi2ohA96Vl95YckcuEvSI+L0iZ7Mz582YWq3rvnbGRsMcTnPwb0KiFtszrY6WeHja34mueMhQ6jW7BDaqw5uI7ZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495901; c=relaxed/simple;
	bh=o94uwlfooWAFAb9a0zSupQqjH4F0Kx+XTQ+2KGCPpF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sp6lGb1Lmt9tZ7Du/AAlK3b8vcqHPRt+D8v/go1aR2qxNCCXTxbtkFDkAlYpb9ZGdjJhgCoTFp11mgj1hdtxCG2wrUsbStUCasq9GHL7Gx37xso8SVXwwYXaOPZaGft6EUkfFMo1pHUSpO8B5/aNCPk3Lmu97dyy+biLo95lzs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6Oc8uUH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714495900; x=1746031900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o94uwlfooWAFAb9a0zSupQqjH4F0Kx+XTQ+2KGCPpF4=;
  b=H6Oc8uUHX998IyYD616Nxq1msbMwoTxGVH7XMp2ZcritDQtBJTi9z9G9
   j59gYItP10wso8Af9TzgpGbX+0GHGkDsBwri9P/i7nIniae4k7echkq84
   /mTU1hYafaFaFTvObOjpH0vYeeoewjChufW5SMKyikLUV/kPlrDCjirtQ
   kn71Acwws30P6UJR1udKKrKlaxXuIUUlzxvad0k0DOvza+7ZFrm12ZOFT
   j5wEf5ZYygnHhoIO6aWhzpoDTwg/LYfa4slq4o1W2Bnfv+nhh0EORTpmE
   Y7dyeOsjRUeqXS+RHx3GXQgk8NG2zxME9P3rPzMZPoph2fdmd/rFhFEny
   A==;
X-CSE-ConnectionGUID: q9bEP2pUS2eQ7toGfX7h1A==
X-CSE-MsgGUID: TQwnmb16TjeCCuZRdepJ1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10075692"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10075692"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:22 -0700
X-CSE-ConnectionGUID: qfzK5AcFScaZEd2llae08g==
X-CSE-MsgGUID: jjq2A11tQRyQS0Eav/sjmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26515468"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 09:51:18 -0700
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v5 21/47] platform/x86: p2sb: Switch to new Intel CPU model defines
Date: Tue, 30 Apr 2024 09:50:34 -0700
Message-ID: <20240430165100.73491-21-tony.luck@intel.com>
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
 drivers/platform/x86/p2sb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index 3d66e1d4eb1f..8cfbf0bbd346 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -24,7 +24,7 @@
 #define SPI_DEVFN_GOLDMONT	PCI_DEVFN(13, 2)
 
 static const struct x86_cpu_id p2sb_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT, P2SB_DEVFN_GOLDMONT),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT, P2SB_DEVFN_GOLDMONT),
 	{}
 };
 
-- 
2.44.0


