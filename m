Return-Path: <linux-kernel+bounces-111339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A39B886ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F101C221C1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC96F405C7;
	Fri, 22 Mar 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jjptXRgI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AVjIEafd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7283DBB7;
	Fri, 22 Mar 2024 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105166; cv=none; b=MoNCojeZRx/Q1WdNRaLAr+ZqTd0d8CMsXEX7s8cnx42pLeFb3N2zcrKwAw9ZxE5LBKtcU0YV5k7lSFwgf4nGGEjEzMN4RzdLDMdHKGN3TTqt/CLlD1KtTzGX91ZKSfUvbTyY/52piMV5xNHTBUjxP47xGWCvYtMuhIz56cKglSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105166; c=relaxed/simple;
	bh=m9qCKMGBiMtnuEfihwNod9pdX53qwLkKUVn07xlLghU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q5XGX9++9d98lmz52kF3mnyoGEjVhmd/yi2nvJOC1LcGfkoy39Yq3BWGZ/4xFztFGP9ZGO11f63k7sj3RqNop6YZMHu6it+JIKpReIlG4MRmmFY2KWfcKjzI9mEP5z+xwGoZS41b+Y+L+N+oPeE+PO5XdXl53CWM5XOTlQmTMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jjptXRgI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AVjIEafd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 10:59:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711105163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYol2EkV0tVYzC1ZA3xiHtzUQnX8od/uoc0kv/+Wv/8=;
	b=jjptXRgIWAACsQyN3fdoXQEA8Y6B2oxcuDpJw5992tAANLi7hPyjPUfRbiA7wEXcGhhxHJ
	TMdy8OKYIXu2LSPd1xEX4Phprj+U5Qp0JOeunTD0Q4vBz46/CQ4ZHCO4wDc3iqgzS6G5Xs
	ZZl+iYgEl6M+uExxRs9mQgv/OJ3lO/jJtQSzE8rHW7Pod1Jb+SLPug6UtdGY2iaEXZ3Gli
	t9ASuujS0QW36vJvb3TeXJ0MPNXq0SxNd/B+gWSWHmA86cOeLhWOQJQwh7DmlIsxYlHT3J
	z0Wy9q7PKEdetXXDSk6LTOYhFq1Epmda1umeYj7meyTXAw608f09EGhkIntMCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711105163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYol2EkV0tVYzC1ZA3xiHtzUQnX8od/uoc0kv/+Wv/8=;
	b=AVjIEafdUdGv1oCqUHWNciBTVuKxmRHri0YfDkhxefg9grD5hBEJ68IdncJR7O6xXPNFfE
	ur22GuyJP6obOkBQ==
From: "tip-bot2 for Wei Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/build] x86/boot: Replace __PHYSICAL_START with LOAD_PHYSICAL_ADDR
Cc: Wei Yang <richard.weiyang@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240313075839.8321-3-richard.weiyang@gmail.com>
References: <20240313075839.8321-3-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171110516229.10875.1698542953227204954.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     29b0aab841da3cade64c7e41e99e9f4645e65fb1
Gitweb:        https://git.kernel.org/tip/29b0aab841da3cade64c7e41e99e9f4645e65fb1
Author:        Wei Yang <richard.weiyang@gmail.com>
AuthorDate:    Wed, 13 Mar 2024 07:58:37 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 11:36:45 +01:00

x86/boot: Replace __PHYSICAL_START with LOAD_PHYSICAL_ADDR

Both __PHYSICAL_START and LOAD_PHYSICAL_ADDR are defined to get aligned
CONFIG_PHYSICAL_START, so we can replace __PHYSICAL_START with
LOAD_PHYSICAL_ADDR. And then remove the definition of __PHYSICAL_START,
which is only used to define __START_KERNEL.

Since <asm/boot.h> includes <asm/pgtable_types.h>, which includes
<asm/page_types.h>, it is fine to move definition from <asm/boot.h> to
<asm/page_types.h>.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240313075839.8321-3-richard.weiyang@gmail.com
---
 arch/x86/include/asm/boot.h       | 5 -----
 arch/x86/include/asm/page_types.h | 8 +++++---
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index a38cc0a..12cbc57 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -6,11 +6,6 @@
 #include <asm/pgtable_types.h>
 #include <uapi/asm/boot.h>
 
-/* Physical address where kernel should be loaded. */
-#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
-				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
-				& ~(CONFIG_PHYSICAL_ALIGN - 1))
-
 /* Minimum kernel alignment, as a power of two */
 #ifdef CONFIG_X86_64
 # define MIN_KERNEL_ALIGN_LG2	PMD_SHIFT
diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
index 86bd431..acc1620 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -31,10 +31,12 @@
 
 #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
 
-#define __PHYSICAL_START	ALIGN(CONFIG_PHYSICAL_START, \
-				      CONFIG_PHYSICAL_ALIGN)
+/* Physical address where kernel should be loaded. */
+#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
+				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
+				& ~(CONFIG_PHYSICAL_ALIGN - 1))
 
-#define __START_KERNEL		(__START_KERNEL_map + __PHYSICAL_START)
+#define __START_KERNEL		(__START_KERNEL_map + LOAD_PHYSICAL_ADDR)
 
 #ifdef CONFIG_X86_64
 #include <asm/page_64_types.h>

