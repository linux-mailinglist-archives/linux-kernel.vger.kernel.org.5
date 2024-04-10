Return-Path: <linux-kernel+bounces-138885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4CA89FBA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8403A2818DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313FA16EC11;
	Wed, 10 Apr 2024 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iWCZQnVb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFA216F0DE;
	Wed, 10 Apr 2024 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763155; cv=none; b=MikozRnuxq0TRnHxnl6L9PBwj9bj/7GLW/PWnk7dSuNPaKEiDAuyR2ilgDmhVntjmxmRP+RppONo1D53zgxbj4/PObNJNdgh+w9qGaJuZ/jFu55O6bDZIMBH9W+Jaj5Wk78jaQyFY5UbatRV10MhZ3yGotJxGxYaYkz6je4NClk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763155; c=relaxed/simple;
	bh=dEgjPQZVrrL7vqI7IKViUp1qmoIOfEl5s9dyPS1YBmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cLYmwuBBgUHZp4kmjMRVHHswntlSVxzHqeV4/JYWt0qD2kaxfj/K+5jyuJamf3KlxCpGtS5rzF/EoXCOYsPcqv8uWkvKwsgZq7dvUgyrsYUtkvsj5rHxrmhAPNivBMhXsWlPX8GJ9nVLYHpJj/DgD3oqnlI8NNeHIIGVrYzXPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iWCZQnVb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712763153; x=1744299153;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dEgjPQZVrrL7vqI7IKViUp1qmoIOfEl5s9dyPS1YBmo=;
  b=iWCZQnVbXhhwoJgU9P8mSUi0d7N3zO4INJQTJsrwa6qu12P95EaAG7cG
   38hhQbvgU4EA848mMPQ2aaDIq8Hi2+6/05nwCxkpnrg2++OjsWeKzA6rF
   mddIB+QQq1Txy68tVYKKore5ysVS5A8ADBVkKOKPbIUIkqmgNaP82h4gk
   stQQiU+n/8+ts2sL9AJgy7gQftRQwYZ7lz/wPKmu/5oxICHoZ1daCTF9q
   13RsPQkqhkR1XUa1F4Orf9DrlQt0QS3WiSJpaah7EAIU+nkcsOv4Jt2k5
   nGgi+4d7cgxIKGYIOcXJ26LYRbRXTTNDOwUBAkkQ/A2T0tO5a1Md7+4D+
   g==;
X-CSE-ConnectionGUID: q2C80GErSLWIl5FV1BB36Q==
X-CSE-MsgGUID: RalOf9Y1Sv6SpUSjJoatFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8260339"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8260339"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 08:32:32 -0700
X-CSE-ConnectionGUID: m+bpUFx2Q5yIztOqKC/y2g==
X-CSE-MsgGUID: eZS9QWdnQA+wEYN3JBJnXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="51568789"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.214.234])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 08:32:25 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: [PATCH] bug: Fix no-return-statement warning with !CONFIG_BUG
Date: Wed, 10 Apr 2024 18:32:12 +0300
Message-Id: <20240410153212.127477-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

BUG() does not return, and arch implementations of BUG() use unreachable()
or other non-returning code. However with !CONFIG_BUG, the default
implementation is often used instead, and that does not do that. x86 always
uses its own implementation, but powerpc with !CONFIG_BUG gives a build
error:

  kernel/time/timekeeping.c: In function ‘timekeeping_debug_get_ns’:
  kernel/time/timekeeping.c:286:1: error: no return statement in function
  returning non-void [-Werror=return-type]

Add unreachable() to default !CONFIG_BUG BUG() implementation.

Fixes: e8e9d21a5df6 ("timekeeping: Refactor timekeeping helpers")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Closes: https://lore.kernel.org/all/CA+G9fYvjdZCW=7ZGxS6A_3bysjQ56YF7S-+PNLQ_8a4DKh1Bhg@mail.gmail.com/
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/asm-generic/bug.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 6e794420bd39..b7de3a4eade1 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -156,7 +156,10 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 
 #else /* !CONFIG_BUG */
 #ifndef HAVE_ARCH_BUG
-#define BUG() do {} while (1)
+#define BUG() do {		\
+	do {} while (1);	\
+	unreachable();		\
+} while (0)
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
-- 
2.34.1


