Return-Path: <linux-kernel+bounces-101364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8AC87A602
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7258E1C21C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1843B3D968;
	Wed, 13 Mar 2024 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UUwvxhK7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kIip1oDe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25F1383BD;
	Wed, 13 Mar 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710326402; cv=none; b=TBz8pmqmP6NIGZEbHyWQhjFf9SKhu/qNLNvBTYUtCykWAzPMSUwTJ1ws02HOBoxbLhZZXlmPNM+Nh+BVRZXXqIkmpFzWM8b1h/aCI88/Uv7L57Rx+r5u2UE9Gq7qu5QRBLlAVhKLy25X60lUt29FZgZpq/4CxO5nEad6CsoDhfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710326402; c=relaxed/simple;
	bh=HZiOhfMhqO0GUnjy3uJTIvMEdtVkcr60moORGWAFALE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c/9OKUY5M/QCYLfx0n0RfgmsnyXPJyoF1JXLXzKeHrfWJPcnQKqth2pXmcJlbb7zTBO2xNTYRWv4jLyFAEL4mjj+0FNPtOoVJO9UTaEXqFnts/Dl0TbSUtXOsV43iP9ubOF3xsMs8iWU1fzAy6PyGH2ELo5k9M/lWhSui5XBZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UUwvxhK7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kIip1oDe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Mar 2024 10:39:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710326399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpXT6AlXq2HeFlh8i9FcEvRnrbuloqMO6IwV9+zqjQg=;
	b=UUwvxhK7akKjIwtNQKorSNZw8yPhjGKWtUF990k2FzstyQZgkfv+80XwolQF6oMG5URFp6
	NyS0pcWJYYbNkc0eOTJS+tuh6rdG03nJd00k4JsEz6JfjbJyGWGOfdQyQDD1C7KIAY+JMe
	P9jN6Kmw52fRkb6qntDR31eFRODO/pHpPsEr//JUW4i76mmA49yv5jrfSommITIud/Y+VB
	oIt+zsiSX5PGNm1ebZzqaVoK5y81GqCZbcHBH2hAwpqUCHrOdu3lq65AwZJCFYEIb4dWcv
	6+arSaXa0WDGZz6d25GeOCfyuLWiAVxMArTSfqonsENAmz1YjiRfZ9TevLQX4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710326399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KpXT6AlXq2HeFlh8i9FcEvRnrbuloqMO6IwV9+zqjQg=;
	b=kIip1oDexsc6fKBaPx/68WQb5bcKHQ9ETf+qMkdc4t2yk5voSYrDHSdUiWUtIMN7cTOggo
	ZtnrXp4bacOXQgBw==
From: "tip-bot2 for Wei Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/vmlinux.lds.S: Remove conditional definition of
 LOAD_OFFSET
Cc: Wei Yang <richard.weiyang@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240313075839.8321-4-richard.weiyang@gmail.com>
References: <20240313075839.8321-4-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171032639869.398.16886435468084846590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     a5cffd056ef52280c07a7f6a3b3faacf6b318e8e
Gitweb:        https://git.kernel.org/tip/a5cffd056ef52280c07a7f6a3b3faacf6b318e8e
Author:        Wei Yang <richard.weiyang@gmail.com>
AuthorDate:    Wed, 13 Mar 2024 07:58:38 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Mar 2024 11:29:10 +01:00

x86/vmlinux.lds.S: Remove conditional definition of LOAD_OFFSET

In vmlinux.lds.S, we define LOAD_OFFSET conditionally to __PAGE_OFFSET
or __START_KERNEL_map. While __START_KERNEL_map is already defined to
the same value with the same condition.

So it is fine to define LOAD_OFFSET to __START_KERNEL_map directly.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240313075839.8321-4-richard.weiyang@gmail.com
---
 arch/x86/kernel/vmlinux.lds.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 56451fd..88dcf93 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -15,11 +15,7 @@
  * put it inside the section definition.
  */
 
-#ifdef CONFIG_X86_32
-#define LOAD_OFFSET __PAGE_OFFSET
-#else
 #define LOAD_OFFSET __START_KERNEL_map
-#endif
 
 #define RUNTIME_DISCARD_EXIT
 #define EMITS_PT_NOTE

