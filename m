Return-Path: <linux-kernel+bounces-136301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3699989D267
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A17286460
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EB074435;
	Tue,  9 Apr 2024 06:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miU+wAIC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6EC6EB72;
	Tue,  9 Apr 2024 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712644027; cv=none; b=JyUGyF4T3eqLtpeAvz9AVyoJ16KFmdf6kAXRCwbd888d6sXM76fUsL9UJk72u1JX2h9ihtSIw6uYXD1NYYL+K6/CcXOO6vr0mdYlmOii7AdT0DTox09UbCRhiTDtiArhxr6aFCvEpAUFGqrr75IY+sQzYuo91WNC8uhhwJwme/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712644027; c=relaxed/simple;
	bh=YBgFeEcKNu6z1EOuKIDtV8ucxUi4txUooaEev8PsP28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EMPJooZMe1g3veisa8CVLAb/Xm0KM4uveW8RgRDirDpQpY7/3cv8ditkXvD+Q2lgDHPBuZtE0xQUX+9UWDwrMesogbpvjnMqpoS13b5BVgTFL3DtI03iRPGv62iaACJsnZtwD55w03dXZgCiUZWwZWRBITC3wXLwbBki3xPbkH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miU+wAIC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712644025; x=1744180025;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YBgFeEcKNu6z1EOuKIDtV8ucxUi4txUooaEev8PsP28=;
  b=miU+wAICFFcFOK7b9Dmg5vu9UP0H4+ZOgiDv2bPK9JVIZyLVxdQOMxwW
   kGCaDFU7vM3MSt1R07nhG62iQo1PDSHvudeWDcKkWA5pn0fNKk6GWsphW
   K71ZnhTACbZXPcWEvPcCvzIUyXICKpDp5v/D/4QRyw9jetqGnyeYFce3W
   f+/G/DVDkgDGyhYHJQn7QTfJ3ZrmtPQrS7G8c29bMewb+7uYFhevupoDq
   WfrGDUxltz1aJy1sTNT9yDerQTFEVtzVBIYiQ7msgHPeq3XLy6st3Hxhx
   9IZK7W8wiH2nf6PQAPuyF8Qf8WeKuTu6GdokMJMheGYa5GS3E80h2/E/m
   Q==;
X-CSE-ConnectionGUID: zlronA/dQIKXGUkaEzQQDg==
X-CSE-MsgGUID: k4KOnJmTSB2UFhSUaOq4fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="30436608"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="30436608"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 23:27:05 -0700
X-CSE-ConnectionGUID: i4DhQ/5wQ5+lYrCrL9n3Kg==
X-CSE-MsgGUID: HlKELBhTQnaCEeG1ZpmSMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="51129094"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.37.26])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 23:26:57 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH] vdso: Fix powerpc build U64_MAX undeclared error
Date: Tue,  9 Apr 2024 09:26:39 +0300
Message-Id: <20240409062639.3393-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

U64_MAX is not in include/vdso/limits.h, although that isn't noticed on x86
because x86 includes include/linux/limits.h indirectly. However powerpc
is more selective, resulting in the following build error:

  In file included from <command-line>:
  lib/vdso/gettimeofday.c: In function 'vdso_calc_ns':
  lib/vdso/gettimeofday.c:11:33: error: 'U64_MAX' undeclared
     11 | # define VDSO_DELTA_MASK(vd)    U64_MAX
        |                                 ^~~~~~~

Use ULLONG_MAX instead which will work just as well and is in
include/vdso/limits.h.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20240409124905.6816db37@canb.auug.org.au/
Fixes: c8e3a8b6f2e6 ("vdso: Consolidate vdso_calc_delta()")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 lib/vdso/gettimeofday.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 9c3a8d2440c9..899850bd6f0b 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -8,7 +8,7 @@
 #ifndef vdso_calc_ns
 
 #ifdef VDSO_DELTA_NOMASK
-# define VDSO_DELTA_MASK(vd)	U64_MAX
+# define VDSO_DELTA_MASK(vd)	ULLONG_MAX
 #else
 # define VDSO_DELTA_MASK(vd)	(vd->mask)
 #endif
-- 
2.34.1


