Return-Path: <linux-kernel+bounces-31210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57038832A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D8E0B2367D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183C252F8E;
	Fri, 19 Jan 2024 13:38:07 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F43552F6C;
	Fri, 19 Jan 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671486; cv=none; b=QMfjMORuYjH6zoAqobfxL7GweYTuigrZ25qh+AKFJnmuf0T/Yky8EEj8k2mfrdhvg6/wlcu+BB3NDb+ozWLUWwTD/iUr3Yi/VPUm9Q2jcRXiDASuzf6z2ze1ChDsEQahnofWWZPLDoy5dyALdUa1Aa7X2BahJLsrh+ChADuLvcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671486; c=relaxed/simple;
	bh=nlplcnlkZyc6oBK6mIHpII0EMUZJYmvOVZeChLedYa8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=m/p2rObdC72IL+3oTK3hXg72W3xSe/8/ndkDRJEgeIo7JHpvs6UpF5IN+LzedryG2cNhTZvJSXQZE9fOM7Qy2BaPStAD+qS996pjYE965wVaOTClSyuJht+a2SjmwJVO6Qk7zo2+2/N7K9NLZPOI0fgyIvben6mxmLZQ7QXqDaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=fail smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=alpha.franken.de
Received: from hutton.arch.nue2.suse.org (unknown [10.168.144.140])
	by smtp-out1.suse.de (Postfix) with ESMTP id 3297F21D76;
	Fri, 19 Jan 2024 13:37:59 +0000 (UTC)
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: sgi-ip30: Fix missing prototypes
Date: Fri, 19 Jan 2024 14:37:57 +0100
Message-Id: <20240119133757.96563-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [10.00 / 50.00];
	 ARC_NA(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[franken.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+]
X-Spam-Level: **********
X-Spam-Score: 10.00
X-Spam-Flag: NO

Include needed header files.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/sgi-ip30/ip30-console.c | 1 +
 arch/mips/sgi-ip30/ip30-setup.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/sgi-ip30/ip30-console.c b/arch/mips/sgi-ip30/ip30-console.c
index b91f8c4fdc78..7c6dcf6e73f7 100644
--- a/arch/mips/sgi-ip30/ip30-console.c
+++ b/arch/mips/sgi-ip30/ip30-console.c
@@ -3,6 +3,7 @@
 #include <linux/io.h>
 
 #include <asm/sn/ioc3.h>
+#include <asm/setup.h>
 
 static inline struct ioc3_uartregs *console_uart(void)
 {
diff --git a/arch/mips/sgi-ip30/ip30-setup.c b/arch/mips/sgi-ip30/ip30-setup.c
index 75a34684e704..e8547636a748 100644
--- a/arch/mips/sgi-ip30/ip30-setup.c
+++ b/arch/mips/sgi-ip30/ip30-setup.c
@@ -14,6 +14,7 @@
 #include <linux/percpu.h>
 #include <linux/memblock.h>
 
+#include <asm/bootinfo.h>
 #include <asm/smp-ops.h>
 #include <asm/sgialib.h>
 #include <asm/time.h>
-- 
2.35.3


