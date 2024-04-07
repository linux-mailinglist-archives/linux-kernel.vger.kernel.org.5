Return-Path: <linux-kernel+bounces-134381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0158F89B0DB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3439C1C20A81
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D42228DA7;
	Sun,  7 Apr 2024 12:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rb37xErM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BB21101
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712493915; cv=none; b=oVgkdPgMVvKYuMduP7k6CBflE0G2v+MqcvOC0tFQqyeTFzJbiMBRV40wfwBr3YAlncjdLC/eSsZpsGcxZiltqGp/0bmtmJ77uEpVEWq0iGp3Te0tDRyvMtyA8yWn/7OsCAx/0CXB7wmiGUS9hTciUE0fKwYN8BkqsxSGKg96dMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712493915; c=relaxed/simple;
	bh=kwmQlT11A5urGQ+cHqiD62Nx98PbS9i9hoR3R8TJSjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iNTQQ2XvsIwwUf4ofOsUAzwpHR9rylJJsTkKQvE/WOZ8x7nml9ZnJMKUV0rEUUHSh0oFI8c3xzmj3KcVhpveqWD+Mr6X6XBZnDqOAhXN7VVw4w5YcmCFKgtl/gL5YFHm8+eSE2IRrOSoWnr40Ygib7fwQSBOnOxiBBZum5juR5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rb37xErM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712493914; x=1744029914;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kwmQlT11A5urGQ+cHqiD62Nx98PbS9i9hoR3R8TJSjc=;
  b=Rb37xErMz4diDMofX8WdEOi/OXyZdb/WhwLKbokoYNnyYb2uvjc9MTma
   Qjr32BqW8h9ktKvAYciNZegfT/GYDyh8TQWOpLSUsVwbVvJk3+5dRc0G9
   /9X+FUekz0FAJcEL6FBwQY0m6TiCsaV5xlpmbvRs7KSHbL9Nn+L99Ob/Y
   Mjse/NIKaoMnZ8nUG/7y7BKY21sd46gb1J4wOgYrPxqLL9EiBOWVuG2IB
   ufPrsLmUCMvVNL3podej5JCdiv1MTHCd+1LWNgWZtkYgxe6IBTmcK0t4b
   BYz3DDMw2vIvhxVXRvOhMuyc4jRRpoTBvZPsb3u/YOUJSbzbMtBT3WhEj
   g==;
X-CSE-ConnectionGUID: d4gn28sDQz+AQXN5oSC5mQ==
X-CSE-MsgGUID: H2EzRui5T7mvxf0gUhDfWQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="11564030"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="11564030"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 05:45:13 -0700
X-CSE-ConnectionGUID: vWD+LSSXQsqUjSLnwyIFRA==
X-CSE-MsgGUID: y9UxuBxPSsy2PHVmGKFIXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="20185619"
Received: from mirtanji-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.251.14.88])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 05:45:09 -0700
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
Subject: [PATCH v3 0/5] TDX host: kexec() support
Date: Mon,  8 Apr 2024 00:44:53 +1200
Message-ID: <cover.1712493366.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently kexec() support and TDX host are muturally exclusive in the
Kconfig.  This series adds the TDX host kexec support so that they can
work together and can be enabled at the same time in the Kconfig.

v2 -> v3:
 - Change to only do WBINVD for bare-metal, as Kirill/Tom pointed out
   WBINVD in TDX guests and SEV-ES/SEV-SNP guests triggers #VE.

 v2: https://lore.kernel.org/linux-kernel/cover.1710811610.git.kai.huang@intel.com/

v1 -> v2:
 - Do unconditional WBINVD during kexec() -- Boris
 - Change to cover crash kexec() -- Rick
 - Add a new patch (last one) to add a mechanism to reset all TDX private
   pages due to having to cover crash kexec().
 - Other code improvements  -- Dave
 - Rebase to latest tip/master.

 v1: https://lore.kernel.org/linux-kernel/cover.1706698706.git.kai.huang@intel.com/

Hi Dave, Sean, Paolo,

The last patch provides a new mechanism to handle all other TDX private
pages when they become possible to exist, e.g., when KVM is ready to run
TDX guests.  It's not mandatory at this stage because currently we only
have PAMT as private pages, but if we agree it's the right way to do then
it can be applied together with rest patches too.

Hi Tom, Ashish,

This series touches AMD SME code too, and I don't have AMD machine to
test.  I appreciate if you can help to review and/or test.


Kai Huang (5):
  x86/kexec: do unconditional WBINVD for bare-metal in stop_this_cpu()
  x86/kexec: do unconditional WBINVD for bare-metal in relocate_kernel()
  x86/kexec: Reset TDX private memory on platforms with TDX erratum
  x86/virt/tdx: Remove the !KEXEC_CORE dependency
  x86/virt/tdx: Add TDX memory reset notifier to reset other private
    pages

 arch/x86/Kconfig                     |   1 -
 arch/x86/include/asm/kexec.h         |   2 +-
 arch/x86/include/asm/tdx.h           |  16 +++++
 arch/x86/kernel/machine_kexec_64.c   |  29 ++++++--
 arch/x86/kernel/process.c            |  18 +++--
 arch/x86/kernel/relocate_kernel_64.S |  14 ++--
 arch/x86/virt/vmx/tdx/tdx.c          | 100 +++++++++++++++++++++++++++
 7 files changed, 158 insertions(+), 22 deletions(-)


base-commit: 6569784d306a8d356bb2517c1528c1d611a51922
-- 
2.43.2


