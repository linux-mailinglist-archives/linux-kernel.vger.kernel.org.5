Return-Path: <linux-kernel+bounces-116939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AD788A554
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FE62A7A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF66126F03;
	Mon, 25 Mar 2024 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sj2cZpng";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZNLb7iH2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAAF13F430;
	Mon, 25 Mar 2024 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366126; cv=none; b=bHbBVK4035oVbXRwhoAuL9sEuIBdv9uDYZquXWeqK/8OWTK7wnDL/wOzQPU5Nng//E0fhv4E5Rjr3ARqH7txE7yWiGITXlKJ5KMKwGcLlSAYo4HjLPtsVrPEylMo77kFJXRaiM7ezqvG6Xx5kZLWX0uGEzROfT1VBjaDeCf0Ek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366126; c=relaxed/simple;
	bh=2rwxddtj3yOG6B2R5ZMOdQPivt7/Ol/n5eGgMzZTDK4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hFMc1JHn/S8EZsOfbol7Jmqmqc5tojYbazsUrlIH/xeWZMZldUbS0CF2uXzq09AR3ydV1DcfHKEn+njLBkbdiS2ZJbE5u78QLz2N0cxE614DFC9FDFBSEoBQKaNfw/ucLrR9ovfyEirc3N4kFDsw01atGwzOVeYTwQ5OFq48LXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sj2cZpng; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZNLb7iH2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 11:28:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711366123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lyE7b6MJootJgH2uz/UZNzWuWFQTuIzWO7AqbPTf290=;
	b=Sj2cZpngym+qCiUZ9rsXCYlaj6z8DfSadh/DniTAjKzT9VisNrpfKEQg/RzXODvMv4/a0C
	2xYWCcFbxJXPmy89TwQ1TjBWUHT0pFe1Z+0C7q/uDHzhIWt/n/yyNCIT46jMFxtgoOwWvJ
	PW3gVs75poKs923r4nTKrf2Jr/qlQ0BFm+0WTQJNYagQ9I0rXCyLbrO/GCdu9wWHPVaoHb
	5kYh+/5ZYy+LEh6+ZBb44fnJ8YfGls87iYC//PluE0meJrKP9eKfJX51vOxWbtjQSVG1HK
	nHkY+FKsi1OFQH+c5CdeoEuXwW4g+7lXBAosPGIXhIwzeOLCphfUIh2/NG7oxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711366123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lyE7b6MJootJgH2uz/UZNzWuWFQTuIzWO7AqbPTf290=;
	b=ZNLb7iH2H+xbL9rGcPYjRzbsBlg4r9y/4HqzSZn5OvsqYkz6pvkNFRLhh27j9ltoJlg5w3
	RgXOxVlw6AHLzPDA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/percpu: Disable named address spaces for KCSAN
Cc: kernel test robot <oliver.sang@intel.com>, Uros Bizjak <ubizjak@gmail.com>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325110128.615933-1-ubizjak@gmail.com>
References: <20240325110128.615933-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171136612274.10875.5644483747839154488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b6540de9b5c867b4c8bc31225db181cc017d8cc7
Gitweb:        https://git.kernel.org/tip/b6540de9b5c867b4c8bc31225db181cc017d8cc7
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 25 Mar 2024 12:01:09 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Mar 2024 12:17:01 +01:00

x86/percpu: Disable named address spaces for KCSAN

-fsanitize=thread (KCSAN) is at the moment incompatible
with named address spaces in a similar way as KASAN -
see GCC PR sanitizer/111736:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=111736

The patch disables named address spaces with KCSAN.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240325110128.615933-1-ubizjak@gmail.com
---
 arch/x86/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 39886ba..4fff6ed 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2439,6 +2439,8 @@ config USE_X86_SEG_SUPPORT
 	# with named address spaces - see GCC PR sanitizer/111736.
 	#
 	depends on !KASAN
+	# -fsanitize=thread (KCSAN) is also incompatible.
+	depends on !KCSAN
 
 config CC_HAS_SLS
 	def_bool $(cc-option,-mharden-sls=all)

