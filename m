Return-Path: <linux-kernel+bounces-149998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643BF8A98EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9562F1C21524
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E010F15E81F;
	Thu, 18 Apr 2024 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Di1XNw1a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E74156894
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440900; cv=none; b=mu81OmFfMdU1vzxKKLIHsHckfHMGiYHgD86JklopKh2kxtOojotIDPAnhLdAg3ddw/YbvipKuZ849fh8N8keEHd+n9E+eOmwXpOp3eEQ2QdddH6uP3ExpUMRJiQ3eYVBicpwJhk3qRFFr0pUsQha9YIWbJXZrpH6a9MZa0gwrdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440900; c=relaxed/simple;
	bh=HChUD81XkH4OIDkL50CmKXBIS5cLx76BQDjoBOKxnvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fw6xg/PxP0T9uhPbCoOfHKgFWJOvnaD9Gh4pAugcoDy/rzcrX+4Wa9L4NZf9dzQkxFNK33IWW7uYQ/Bpw0Eo2UyM7U4BmotSD5Pyx8eFsjB5kDkQQbrEr68o7aXc/nC0RAH9Gj3tFeQWN/Z+pt8aZ6WrZ3YgA6IxYNLnjW/Rd+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Di1XNw1a; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713440899; x=1744976899;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HChUD81XkH4OIDkL50CmKXBIS5cLx76BQDjoBOKxnvs=;
  b=Di1XNw1auhNQ89InT+vhnb992tfBK32xoRWo0Y/ABj20tmiq2xP3GFgH
   qvmMJ45ksH1JV8gdaQLApWM0DbrxcfC40W3b5sD9Vfgct5yba3OnXo7wi
   quZomjcngNpjUJcRROURbc/a2tMt+/+afCwTGDih4xb5vfvxsbbyRHc8Y
   tInKIAd7Ql2PtBdCFYE8T1ASsh/DcDKTSR2NezEfjJVAdHg7It6xxRimw
   Kq56Yauz7gITY1r1lr5ybbx9yJcAS3PCmhxEVXj65m3yc/o5z0nWe+Y27
   bnysHsXzxa+Z4FasgfXnCgyVM/fKmnJw7lMlJcGSRnM3LHk6GDf8vjUVN
   A==;
X-CSE-ConnectionGUID: PgCqcbFtSUe3jY9ONVVOeA==
X-CSE-MsgGUID: ONiB7FujRsOnQLguKqL2zQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12769349"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12769349"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:48:19 -0700
X-CSE-ConnectionGUID: z0yeUZ/JRaiBFAt6TeB9jg==
X-CSE-MsgGUID: zpqqdo+AShq9ksV5iVp68Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23019871"
Received: from vgannu-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.134.136])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:48:13 -0700
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
Subject: [PATCH v4 0/5] TDX host: kexec() support
Date: Thu, 18 Apr 2024 23:48:00 +1200
Message-ID: <cover.1713439632.git.kai.huang@intel.com>
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

v3 -> v4:
 - Updated changelog and comments of patch 1/2 per comments from
   Kirill and Tom (see specific patch for details).

 v3: https://lore.kernel.org/linux-kernel/cover.1712493366.git.kai.huang@intel.com/

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

Hi Dave, Kirill, Sean, Paolo,

The last patch provides a new mechanism to handle all other TDX private
pages when they become possible to exist, e.g., when KVM is ready to run
TDX guests.  It covers both normal kexec and crash kexec.  Strictly
speaking, it is not mandatory to be in this series though.  I appreciate
if you can help to review.

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
 arch/x86/kernel/process.c            |  19 +++--
 arch/x86/kernel/relocate_kernel_64.S |  19 +++--
 arch/x86/virt/vmx/tdx/tdx.c          | 100 +++++++++++++++++++++++++++
 7 files changed, 165 insertions(+), 21 deletions(-)


base-commit: 1e0fd81e4f32a8a383c05d27a672d742b45c1088
-- 
2.43.2


