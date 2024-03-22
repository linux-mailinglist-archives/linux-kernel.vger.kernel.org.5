Return-Path: <linux-kernel+bounces-111155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAFE886873
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBC82870CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A30199A1;
	Fri, 22 Mar 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ziXFRkQ1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4IoIGj/B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5FC1756B;
	Fri, 22 Mar 2024 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097293; cv=none; b=MeV1upLdSI1OovS2lwwFROdmCqCXrjpuu3DY69cmBYCIYRKeKp1QjNhDBGDvQ9D6ZWYGcw8iMvOFo3zLNE4uDdsD9VlqZZyl8VI8d/x2DCr9xPf7UsVzr70qFrfFvxIyZHNLNHo9DMupDSoVBNiDJiSVN7iYosr7N52zcIGyC0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097293; c=relaxed/simple;
	bh=VxYbXOxGKYmds2XvlNY+eUdRM1QyW7IWbMyWPNkjtbs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Dh5jFN3IBiEEEy6ymhFlwUCdDgbrThvffysliRPZfYM0CEoHE6/AjO9wwhfbXb20m6FCf4OENixhTOBENHBRcqS1MD97ri2YiH1D9JagMznnSVv5xymPimaaxJ7NRY75S14AO6bRac5dNQYEO8v/rOIWhieqXN/I2b8X1WXw4J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ziXFRkQ1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4IoIGj/B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 08:48:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711097290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2K2k+Eq/1gQou0RJn/e/Wthbc3BzYCotztSOZA5S18=;
	b=ziXFRkQ1HTAnZrvF+fIAHs8ZNLk2nVtDyfczW4e1RdEdDYam14dfmV+ALbi15e2F4i/YjZ
	V0prp1hSiOPv13mXyFrPlCK8Nzo7Ul1hzohENGqu4tdc3bI0CWiJqnt4HORypQeIBo4GMD
	xE0Z5k3iz/YOMU434C0AatAMaa5HNylid7faIVCIkb4WlBvtoh+uMtrT0yAnOyDyohzcef
	f1KEWYWJXyenpkGk5imv1mVkBqLlJcLOZ7Ka4WPX6pO3vJz+bvCTH33sM+esyduPnLDKCg
	V5HAd2Djxuv4bpUkMXO1YoUkl9qLsedm/5I07dRHoNyUOMB6ZZfKzZgyZPdzhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711097290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2K2k+Eq/1gQou0RJn/e/Wthbc3BzYCotztSOZA5S18=;
	b=4IoIGj/Bo3w+DYLPpHmJ4lzgTrk7paycHTHqcPlaNZKlO9iuq/ZW+PW6vqhlHb4zegWhKi
	/WAq/gdordbfbSAg==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/syscall/compat: Remove unused macro __SYSCALL_ia32_NR
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240321211847.132473-2-brgerst@gmail.com>
References: <20240321211847.132473-2-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171109728983.10875.7341737547058393028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     9342164635f86eefbe01258fcfb597945e7ab5a4
Gitweb:        https://git.kernel.org/tip/9342164635f86eefbe01258fcfb597945e7ab5a4
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 21 Mar 2024 17:18:46 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 09:37:09 +01:00

x86/syscall/compat: Remove unused macro __SYSCALL_ia32_NR

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240321211847.132473-2-brgerst@gmail.com
---
 arch/x86/include/asm/ia32_unistd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/ia32_unistd.h b/arch/x86/include/asm/ia32_unistd.h
index aa065c9..7bcb829 100644
--- a/arch/x86/include/asm/ia32_unistd.h
+++ b/arch/x86/include/asm/ia32_unistd.h
@@ -6,7 +6,6 @@
  * This file contains the system call numbers of the ia32 compat ABI,
  * this is for the kernel only.
  */
-#define __SYSCALL_ia32_NR(x) (x)
 #include <asm/unistd_32_ia32.h>
 
 #endif /* _ASM_X86_IA32_UNISTD_H */

