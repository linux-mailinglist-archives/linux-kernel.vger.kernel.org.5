Return-Path: <linux-kernel+bounces-82101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7BD867F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D25DAB29989
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471B712EBF3;
	Mon, 26 Feb 2024 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Knwrmv/n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZKGuHU/I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E857712D761
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969834; cv=none; b=bUTJnOqlZvnqr1Y3gU3OuAJLlhr88Opjol9h9e2pAtGEQ6ojlExYay6H7Pu8dJKvBRNTfz/QVz0HH5HCHXd87szcAHtU7lIBxDZd8SXXDQt9HM0gp217P/LuBu+HCAk2mDXKdBU+aqGEOSCIHM5Sma86xCetJU6E3GmktQNfFbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969834; c=relaxed/simple;
	bh=EXS+2F0aDDzXNyS557ArWDHbc0pW9PbkkG3BlGZzYDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sB1xsXCXJ0c1HPF3ICElNnVJTcvLUMUS3bjDkn7yKirc804qkiLaZxjojB3z/6kCCuIKCkkFB/4jlYYLhJd/2oo1xciuQS+/IYcNSkOzlSQIHOPqMUMy8TvT+rzkCtQGblJqWMiUmu8jPJkKln8eNESOEOub/upDkqtqvS37W1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Knwrmv/n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZKGuHU/I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708969830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oyT45bJy0NjlcqFeA1O9Jx+i3jRc/06dKDog6PI1l+4=;
	b=Knwrmv/ne0GuLsaIkgP25WJhHcBK3CEuVrDHOY9iW6vUAONksfcKffr/5cZZWJvcgmFw5a
	cc6M2e5t6QlVFSiLjMDH/PcPWw7X35Bhtfg0jQWLg9c8F9jTyC8XD2iWGRdEUuVxWZHjD/
	iP3niE9tt2NHvH5Frwc2t5FZG+Q/pFlVX5AC7+4o+DavWJ1WLCfpXqeuei8I4AEwGXzsMD
	tYHPpb0A/3aazMqgSBzCvYvH6fPq3Qu7itP/j09M8AJEhVmQxFo80lg47A2MedsCz88ywN
	wa1I/RdLwnd1nTyQhmPPP1XoQPpZ5RA4FbHoo36x2IzD6wtr8/74spkoB2cxeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708969830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oyT45bJy0NjlcqFeA1O9Jx+i3jRc/06dKDog6PI1l+4=;
	b=ZKGuHU/IWsEbqGm6dBb+ljqasEBd013J41hORt5AxNf/sfUz032h1Nm8NwzRXeoCGE4d5r
	J7OfhzWWh1vFtPBQ==
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH] vdso/datapage: Quick fix - use asm/page-def.h for ARM64
Date: Mon, 26 Feb 2024 18:50:23 +0100
Message-Id: <20240226175023.56679-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vdso rework for the generic union vdso_data_store broke compat VDSO on
arm64:

In file included from arch/arm64/include/asm/lse.h:5,
		 from arch/arm64/include/asm/cmpxchg.h:14,
		 from arch/arm64/include/asm/atomic.h:16,
		 from include/linux/atomic.h:7,
		 from include/asm-generic/bitops/atomic.h:5,
		 from arch/arm64/include/asm/bitops.h:25,
		 from include/linux/bitops.h:68,
		 from arch/arm64/include/asm/memory.h:209,
		 from arch/arm64/include/asm/page.h:46,
		 from include/vdso/datapage.h:22,
		 from lib/vdso/gettimeofday.c:5,
		 from <command-line>:
arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type name 'u128'
  298 |         u128 full;
      |         ^~~~
arch/arm64/include/asm/atomic_ll_sc.h:305:24: error: unknown type name 'u128'
  305 | static __always_inline u128
	 \
      |

The reason is the include of asm/page.h which in turn includes headers
which are outside the scope of compat VDSO. The only reason for the
asm/page.h include is the required definition of PAGE_SIZE. But as arm64
defines PAGE_SIZE in asm/page-def.h without extra header includes, this
could be used instead.

Caution: this is a quick fix only! The final fix is an upcoming cleanup of
Arnd which consolidates PAGE_SIZE definition. After the cleanup, the
include of asm/page.h to access PAGE_SIZE is no longer required.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Fixes: a0d2fcd62ac2 ("vdso/ARM: Make union vdso_data_store available for all architectures")
Link: https://lore.kernel.org/lkml/CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com/
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---

Patch applies on tip/timers/core and was tested with clang-14

---
 include/vdso/datapage.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 7ba44379a095..5d5c0b8efff2 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,7 +19,11 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
+#ifdef CONFIG_ARM64
+#include <asm/page-def.h>
+#else
 #include <asm/page.h>
+#endif
 
 #ifdef CONFIG_ARCH_HAS_VDSO_DATA
 #include <asm/vdso/data.h>
-- 
2.39.2


