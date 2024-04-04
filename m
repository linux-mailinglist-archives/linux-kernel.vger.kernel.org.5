Return-Path: <linux-kernel+bounces-131052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D985B89826E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B2C1C259E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ED85CDC9;
	Thu,  4 Apr 2024 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LvvJRoVv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bB083CUy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0296A5C8FE;
	Thu,  4 Apr 2024 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712216937; cv=none; b=STJOPSrvfhh4tTfyv7/zGQFX8f31oFCgPGI2aWNfdQNZx2lLjC67FQpKtdgcwl/u7V7X6UMZC227AU/hQj6EVPKYVFNPOOa632o+Di/SoqcmFNI30ak9XM74lTyOzSxEZR33VvAYoIk5mjbSYvcNmb4ht0iViAurip41AdWKI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712216937; c=relaxed/simple;
	bh=4EAUPzFG2L2mvsRW5ix6EYbPaLtrMIhNleJQuZKgVtw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ubaU0LspsghrqwND36wCOWmCeu6mVsX+BaiJu8dPFh3m578Eie0G9D+IrXXmhkVJoRKr/KaGRhjobQx+euQAKXl4Ep4wqiZGL01X/U1IJsvCk5VMT8ushGar7TdMKLWyGnb/XWATPOGX7I6jNA92Dl0FvIYh6gDl+ADCrQlqajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LvvJRoVv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bB083CUy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Apr 2024 07:48:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712216933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZPu1FmvjKlKUWPQ6fpj69VcJu6BMsXZsD7aYmWd9w4=;
	b=LvvJRoVvYQxRg2bRTlfDD8piqAJkjVfnfbRdkxNLrQWrNbzFjDcDoFscrSEcfBtI+4bmNw
	qVn7/+hK+RM9dKo19zdEoWzWbhpC2p+iR90MTbsIZ9Z1V4djevRRpIGj2ermxTL5YlP97r
	hT12G7sDGjnVWK3971ei8hxJEe92ZC8PlFT535z7RlwUNSeBGSj9K4c0aR0iMw6DBbGwLH
	RO9vD3pnaL2LPp2FPvmKQ9OZr6A4yj/Bmz/7wySZvgEM9ERIWE+s+poIR/Jp72FS1pCyKf
	i6q6V3dJMWpEA2JdeZlxni78tuxQj/+zBcRPHjsGppCnSqBwZh1Ewrn6O+y6Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712216933;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZPu1FmvjKlKUWPQ6fpj69VcJu6BMsXZsD7aYmWd9w4=;
	b=bB083CUyi9x4a5lLyf+tACBmbqtd5WUvlwQBYb8Jsv5lmxLW2E6LxZds9SiJn/RiLOO5H4
	Lk29CcWW2lqGiPDA==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/numa/32: Include missing <asm/pgtable_areas.h>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240403202344.3463169-1-arnd@kernel.org>
References: <20240403202344.3463169-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171221693236.10875.9400549582446889445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9852b1dc6a140365977d7bfb5fa03d413b3417ad
Gitweb:        https://git.kernel.org/tip/9852b1dc6a140365977d7bfb5fa03d413b3417ad
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 03 Apr 2024 22:23:37 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 04 Apr 2024 09:39:38 +02:00

x86/numa/32: Include missing <asm/pgtable_areas.h>

The __vmalloc_start_set declaration is in a header that is not included
in numa_32.c in current linux-next:

  arch/x86/mm/numa_32.c: In function 'initmem_init':
  arch/x86/mm/numa_32.c:57:9: error: '__vmalloc_start_set' undeclared (first use in this function)
     57 |         __vmalloc_start_set = true;
        |         ^~~~~~~~~~~~~~~~~~~
  arch/x86/mm/numa_32.c:57:9: note: each undeclared identifier is reported only once for each function it appears in

Add an explicit #include.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240403202344.3463169-1-arnd@kernel.org
---
 arch/x86/mm/numa_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/numa_32.c b/arch/x86/mm/numa_32.c
index 1045443..025fd7e 100644
--- a/arch/x86/mm/numa_32.c
+++ b/arch/x86/mm/numa_32.c
@@ -24,6 +24,7 @@
 
 #include <linux/memblock.h>
 #include <linux/init.h>
+#include <asm/pgtable_areas.h>
 
 #include "numa_internal.h"
 

