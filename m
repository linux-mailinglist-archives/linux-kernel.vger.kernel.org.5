Return-Path: <linux-kernel+bounces-149891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5640E8A9774
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7051F2313D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5182315B98C;
	Thu, 18 Apr 2024 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rFoTg+5O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OkgiFbzK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454438821;
	Thu, 18 Apr 2024 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436524; cv=none; b=CySIrsaz8QsT2PKCIW5ZxW43oMEBWgZMRUhbT/nbkZmOF+82bU0Avby+P7YOYGb0R37mJLHC14n8rkSZUxhLCHqSzRzBJnJZEYy9vDQ0FYCv79g0RHeV1pigAw0Phx/VK3rZONHbJkPnlZYWwbFY0vVgBJDeLTgGEx2CnjTNeSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436524; c=relaxed/simple;
	bh=elx7OKm1udJewvzUfuAa8NkG1AOgelvnmXs8xqzFUUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U2r9tNCAx9Mij5z4BMI5NJZpLhn5Oba6pi9LcrWhVEVbPD3EmBsmn5mio/lcvO5kNK1N16WQ9LyyG/RjFaZuBQxAJ5LI0CoHNzJvCx+fXcerxQSls0U10cRP3MaEzMJdcVEpkw716Kq9srtBNzuQeyN3CGQtnFCx/mL6NyawPBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rFoTg+5O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OkgiFbzK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713436521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9obvaWEEEdGVSr28CMv6Cu4kAaroOIyrSClUKb5FyOY=;
	b=rFoTg+5OscplOaVXCHK/7cHWKm5qOdAWblkqZCJ4vMeOn8y66abd6BreT1dDnFVPIaJNVv
	p/hp4pRcVCOw04EJpMLmY1szbPdhyMQ2HFjpRkmDBJOhtx4HHbYjvFcbpkPietVTHmQrrn
	zxRRoVm4xJ5hzULwg9DSeqh0PYBILFnoFxNaWkgCjR0NXrpWoNDkAmoo2pj9tK/H1s6NAF
	/sQxEmmMmTQyftLxWpmCSNAaJTp5D+XI8olwQ/8vYgbBa8WVWW/7tPDRO0RkCTx35M+wwd
	N41gq0rbAGXQyGPUu+uOvXtM/Wqp9Cbq3A1/UijMAY80/oNXauN5duvfOZdTBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713436521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9obvaWEEEdGVSr28CMv6Cu4kAaroOIyrSClUKb5FyOY=;
	b=OkgiFbzKFvUFsoqftpSJySJo2U0wWkhDCM7WswDQsLc3kI9ofNu49Xa0uBH+A6iGWmTwFN
	xHdX+y73q6HTaOAQ==
To: Mike Rapoport <rppt@kernel.org>,
	Andreas Dilger <adilger@dilger.ca>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	linux-riscv@lists.infradead.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"ndesaulniers @ google . com" <ndesaulniers@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Tejun Heo <tj@kernel.org>,
	Krister Johansen <kjlx@templeofstupid.com>,
	Changbin Du <changbin.du@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH] init: fix allocated page overlapping with PTR_ERR
Date: Thu, 18 Apr 2024 12:29:43 +0200
Message-Id: <20240418102943.180510-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is nothing preventing kernel memory allocators from allocating a
page that overlaps with PTR_ERR(), except for architecture-specific
code that setup memblock.

It was discovered that RISCV architecture doesn't setup memblock
corectly, leading to a page overlapping with PTR_ERR() being allocated,
and subsequently crashing the kernel (link in Close: )

The reported crash has nothing to do with PTR_ERR(): the last page
(at address 0xfffff000) being allocated leads to an unexpected
arithmetic overflow in ext4; but still, this page shouldn't be
allocated in the first place.

Because PTR_ERR() is an architecture-independent thing, we shouldn't
ask every single architecture to set this up. There may be other
architectures beside RISCV that have the same problem.

Fix this one and for all by reserving the physical memory page that
may be mapped to the last virtual memory page as part of low memory.

Unfortunately, this means if there is actual memory at this reserved
location, that memory will become inaccessible. However, if this page
is not reserved, it can only be accessed as high memory, so this
doesn't matter if high memory is not supported. Even if high memory is
supported, it is still only one page.

Closes: https://lore.kernel.org/linux-riscv/878r1ibpdn.fsf@all.your.base.ar=
e.belong.to.us
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: <stable@vger.kernel.org> # all versions
---
 init/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/main.c b/init/main.c
index 881f6230ee59..f8d2793c4641 100644
--- a/init/main.c
+++ b/init/main.c
@@ -900,6 +900,7 @@ void start_kernel(void)
 	page_address_init();
 	pr_notice("%s", linux_banner);
 	early_security_init();
+	memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE); /* reserve last page for E=
RR_PTR */
 	setup_arch(&command_line);
 	setup_boot_config();
 	setup_command_line(command_line);
--=20
2.39.2


