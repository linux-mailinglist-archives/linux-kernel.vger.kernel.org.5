Return-Path: <linux-kernel+bounces-111150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8F188685F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A171F25651
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD9521A0C;
	Fri, 22 Mar 2024 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kvsBXIUi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sPtEFcDF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCF418659;
	Fri, 22 Mar 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711096781; cv=none; b=riZoDwWVqYF/xBe7q2yqVjKHsVJ5koBALsvYR2Bm0ntxGL+D/LewyNh7vp8oS6wDfVqJMu+FZCSOHDj2LDFUfwyTB1aXidwAaCbNycWOnF+HeKcET41746FuZAK0ZNUOHQgIKsRCUr8vreSiZqyjNsNkvY9cMWQ36faDxlcqnNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711096781; c=relaxed/simple;
	bh=1NjYQoBdeYmTdCS8HBpIVGsO6EqDT4PrSD9dfjj6210=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QIjxfxkurBdYomfXqAunkZ2euVV5PHrKJPcTAB7eGNjPBzl0Y0ZJ4SPowH/+fzZN8WpQGfO696f/JwF5O0KOj6Q63R4MKvUcDCZMFxeSE8kOWQdpL1plLgSLkkag/UOXYtL6gSNneZ1UDeJByWVxz7Tu5vm8YT29Ur5r3vgY4vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kvsBXIUi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sPtEFcDF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 08:39:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711096778;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qI8L/k5dYVThFnpDu80xMKI3aDAeev/ozgJxdjORzVI=;
	b=kvsBXIUiWfWcHkhAoSDrark/n5ZlGb9tFmUEiQJfS0JQmbUqRKq3WyncaDaUpeAWAb+gMZ
	rkamAe/6RYnCcQ6IIp6+XfmB8V3Q7ZrDxRxu+WwVx+CsAMGIlJJPFwyi0X+Q7e+SwydDlN
	+SckP1KJYT0rhMDbLq6nydZRifIFKKxnSykQN9Ij1SQ9/a0BZlx0Obmlfdf9Z3CL3pBw7S
	wSkzGMBg0znAVoKOE70MGw6vR1Qx2FiSHfRBduiVcBJ70UDEsEDF5nnTcJrN3rFPZI+OaQ
	JjW1ywZeQKXXpEfG0IUBilwujmafiROmsByQrJtLAFb/DSFnhdsHpnhcgZqspQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711096778;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qI8L/k5dYVThFnpDu80xMKI3aDAeev/ozgJxdjORzVI=;
	b=sPtEFcDFE/QsnY2rB2qwCX3p7+zIrUqVO6A1lovdyqR+Oyx8P2+N381ZnNQ05hIkMcgbPb
	o9YNbWqwMmZ7QBDQ==
From: "tip-bot2 for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/xen: Remove duplicate #include
Cc: Abaci Robot <abaci@linux.alibaba.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240322063957.94159-1-jiapeng.chong@linux.alibaba.com>
References: <20240322063957.94159-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171109677769.10875.7841656344559570766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     b0daa43204b1b78dce43e26604e47e3e55e1af91
Gitweb:        https://git.kernel.org/tip/b0daa43204b1b78dce43e26604e47e3e55e1af91
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Fri, 22 Mar 2024 14:39:57 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 09:34:15 +01:00

x86/xen: Remove duplicate #include

/arch/x86/xen/enlighten.c: linux/memblock.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20240322063957.94159-1-jiapeng.chong@linux.alibaba.com

Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8610
---
 arch/x86/xen/enlighten.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 3c61bb9..7030a6a 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1,8 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
-#include <linux/memblock.h>
-#endif
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/kexec.h>

