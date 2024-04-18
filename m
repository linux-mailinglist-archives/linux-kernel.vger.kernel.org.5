Return-Path: <linux-kernel+bounces-150004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD83E8A98F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7D61C21646
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DD115F320;
	Thu, 18 Apr 2024 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrbsXyY+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D039C15F30D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440917; cv=none; b=VmqPrEii3WfbUmNv/29WGCOVZy0iRDX+LpC+oZlJSO6V33fxr6KAe79f18M0M+pJN7PPLR7MIv1snngGmMl0i++tF4O/J3/vQ90E23e0k3Tt2zDwomssxQEZpIkLUVC7NQHNRdXONIIFK1zlPei7GdS36Vv0wNIuOPJVPssD4tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440917; c=relaxed/simple;
	bh=fZ0TVXeO1x1cEVD9o4dos0k+DXgqUt8822Ue7ktezDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEMuabCv3CeZkBKyqxr6Lfjx0Fm+tF++ad5N3gzSsu1B0c3EfBPikLOZFWolev7lvWEyHhlsyVN5pGOVHHGy4mfYBOtmNjH2Rp78+TKpxBQmFQk4fLDPyQ9LIzyRXftu1auDc16U/1i2ueNWDvUUh6Eg/nlwTEEDBCNw7cgzy60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrbsXyY+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713440916; x=1744976916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fZ0TVXeO1x1cEVD9o4dos0k+DXgqUt8822Ue7ktezDk=;
  b=jrbsXyY+8G3WlxQJDD9zCweTVZIWhekLqm1JZ1xy/pAoY2X3hWNCmTGs
   qZMXv+ZdmaL5MRSfAj1PmqkYWHvkkeEUJtJ+PX2iLbhUHmEr+yqg0tXD0
   Nt/ZOtleZ4Tg42KxtqNwIHKaE6Vi+rOjpQzQ7LD2cUAwIR+OeEeRAdTTu
   kTCUmb7lAFcv2wTHm1EsWFEcwtTDJSLy8hgU/D+70vAG4qMVt5C+KNWWk
   nKAgGIGcUZQdnEFICX+7oeHRIfSUkV93Rf57oqPGVtTdKE0lrypYQGc99
   a3bJgWwDEzm/nIaYLg8983Q2bIWhOnDGTir3jH3/AgG11DMAuV1/8Qkpj
   Q==;
X-CSE-ConnectionGUID: iIc+a6eETqW5y+zgh9So5Q==
X-CSE-MsgGUID: AHTFm5HPRsutKLNrsow7/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12769413"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12769413"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:48:36 -0700
X-CSE-ConnectionGUID: EaP64czsQjqS5lHNnMlLGQ==
X-CSE-MsgGUID: JR8gkd7jRYySu0ea9ShDfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23019913"
Received: from vgannu-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.134.136])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:48:31 -0700
From: Kai Huang <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	bp@alien8.de,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	rick.p.edgecombe@intel.com,
	thomas.lendacky@amd.com,
	ashish.kalra@amd.com,
	chao.gao@intel.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com
Subject: [PATCH v4 4/5] x86/virt/tdx: Remove the !KEXEC_CORE dependency
Date: Thu, 18 Apr 2024 23:48:04 +1200
Message-ID: <9f96c89171ba0bc04209d33b4f812720a529c858.1713439632.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713439632.git.kai.huang@intel.com>
References: <cover.1713439632.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now TDX host can work with kexec().  Remove the !KEXEC_CORE dependency.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2dac256b6e8d..3761f55c41ab 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1968,7 +1968,6 @@ config INTEL_TDX_HOST
 	depends on X86_X2APIC
 	select ARCH_KEEP_MEMBLOCK
 	depends on CONTIG_ALLOC
-	depends on !KEXEC_CORE
 	depends on X86_MCE
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious
-- 
2.43.2


