Return-Path: <linux-kernel+bounces-129135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12A4896584
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483C7284910
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F6D57303;
	Wed,  3 Apr 2024 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BiRrgJAg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iLxU5a6m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7955E48;
	Wed,  3 Apr 2024 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128106; cv=none; b=KMxNA4YYRcPoIKR+EA1J66/HfeqJh4AAyRCE5S1fLp3xS0vRCBG7Z7Zv+D2Ecbcun4fuIvuJ9uez3hVZNjyjUgJYm7/xxu6G32UfpEv4uMp/Wo5wKM1GEdhMw7iJijQHo+KtuCUWDA+x49V3UpqJTE8zpCeBhRfmWZ4P7f7JjVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128106; c=relaxed/simple;
	bh=HO2R6Zgte5OrIwNwoWeYCFWOQC+vJ+7i485NdOcSlBQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WO1MkHgJtL06m01iboK6xtNrq2wifhzUydB6TXcIjimwETb679kbJ2edv/EmEulxkJDsz3+71cRxrKMbUWxn/sF41bqCtYrmRymv5hqJEMM7yc1QrRedS+P29yXnslmCp3W89hmtgof0Unr1V2M1TRXd3C37q1sFQNO9GMzb5Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BiRrgJAg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iLxU5a6m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 07:08:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712128103;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzPybjSUz59sHeJ0O7htp4SHQ7IKXGpZlw7VNSaBqFY=;
	b=BiRrgJAgnkHUrUwAAIZDEwcr/4rcri19fVz/Oz02y/CDyfYiGYpz7XElZ1o6vBMG0fW2+e
	gFoh/j88F825wL02+pfiLGNvs6XFaZIeTfOHrMCfFqvjyNxWgBbaDckngABVLLxBgCNjrh
	/WPfiV368m13xovWTb2QTZNxHlqTQ0gZORoU0f0rIS6PYCy5nyLt0oyTNpzssZt/pQqenG
	DouAli02cWtYyYNCBKxbYPjqu4uYmmcLgPgmxnaVru8/pEPeUNyMp2EjSSLBt+ztbUWXC8
	W4VQNQBsfnEbh1XB+PX5qsiipMMiFL0X2Vciki0zH9p0gqnZKV1Kl/E+Y+XNaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712128103;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzPybjSUz59sHeJ0O7htp4SHQ7IKXGpZlw7VNSaBqFY=;
	b=iLxU5a6m0+TBkk98fHXQ1UCJc26Mm9JDa5gz7tW7c+xOwXrvGm2ZC0FTk7O51B8NIMQphH
	wJwPEyM78lhCm+Cw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Re-enable named address spaces with
 sanitizers for GCC 13.3+
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240402121926.78477-1-ubizjak@gmail.com>
References: <20240402121926.78477-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171212810241.10875.12705075476736178415.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     9ebe5500d4b25ee4cde04eec59a6764361a60709
Gitweb:        https://git.kernel.org/tip/9ebe5500d4b25ee4cde04eec59a6764361a60709
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 02 Apr 2024 14:19:08 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Apr 2024 08:59:15 +02:00

x86/percpu: Re-enable named address spaces with sanitizers for GCC 13.3+

Commit:

  b6540de9b5c8 ("x86/percpu: Disable named address spaces for KASAN")

.. disabled support for named address spaces with KCSAN due to
the incompatibility issue between named AS and KCSAN.

GCC 13.3 has fixed this issue (GCC PR sanitizer/111736) so the
support for named address spaces can be re-enabled with sanitizers
for GCC compiler version >= 13.3.

[ Note that the patch considers GCC 14 to be fixed - if somebody is
  using snapshots of the GCC 14 before the fix, they should upgrade. ]

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240402121926.78477-1-ubizjak@gmail.com
---
 arch/x86/Kconfig | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f1c020d..9332bad 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2431,19 +2431,18 @@ endmenu
 config CC_HAS_NAMED_AS
 	def_bool CC_IS_GCC && GCC_VERSION >= 90100
 
-config CC_HAS_NAMED_AS_FIXED_ASAN
+config CC_HAS_NAMED_AS_FIXED_SANITIZERS
 	def_bool CC_IS_GCC && GCC_VERSION >= 130300
 
 config USE_X86_SEG_SUPPORT
 	def_bool y
 	depends on CC_HAS_NAMED_AS
 	#
-	# -fsanitize=kernel-address (KASAN) is incompatible with named
-	# address spaces with GCC < 13.3 - see GCC PR sanitizer/111736.
+	# -fsanitize=kernel-address (KASAN) and -fsanitize=thread
+	# (KCSAN) are incompatible with named address spaces with
+	# GCC < 13.3 - see GCC PR sanitizer/111736.
 	#
-	depends on !KASAN || CC_HAS_NAMED_AS_FIXED_ASAN
-	# -fsanitize=thread (KCSAN) is also incompatible.
-	depends on !KCSAN
+	depends on !(KASAN || KCSAN) || CC_HAS_NAMED_AS_FIXED_SANITIZERS
 
 config CC_HAS_SLS
 	def_bool $(cc-option,-mharden-sls=all)

