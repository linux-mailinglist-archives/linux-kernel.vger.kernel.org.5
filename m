Return-Path: <linux-kernel+bounces-131060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C44898297
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C510B21A1E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC225D724;
	Thu,  4 Apr 2024 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bhWzuSBS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eCRL3ZaU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8828545970;
	Thu,  4 Apr 2024 07:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217456; cv=none; b=F888lGQnlv5aFkBNYLTKagRIb0rWvXg4S78eUeJnlPyhWM/ZGFt6QtgeJaodWN/gabPbhRAd1qvVQwxM6ggp6gfdo3OR4uoYJC0x+PiX4QQDQkqoC5yW84wWnHrsspl+lZa1j7QrSnwF8fjYpTtxO8mVk4P8Q1Km3Kse03uumwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217456; c=relaxed/simple;
	bh=q9aRhNcDzR7Xs1bDRW2HZNJRvDUfLmRMZ34+tSjSNOY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kiVc/dhJD328rRYrX4pa4PjgiCpPqPBeqG5IfjNgxT8fLv47ko4UbUdR+/8Bikg5yLciMwbM6RhO5bggtc+FGDVUdr8vqjq8RaT0DwOo7aUp0pJaA41fdeR2w6sZBD6IESOaLyM/pZBAG/qurxj32PEnuYO1Qc5Eds7lC3ZQU6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bhWzuSBS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eCRL3ZaU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Apr 2024 07:57:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712217452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNCCZOUGYI/dfTpeabf6PprqLVc9VgSgHRqsATYCMrc=;
	b=bhWzuSBSqX9DIZkA90vmzto/WkuQlbK74ar9r7F57p20lOtDKtxW8B1FuwwBvXl98NW/kY
	2ou/PPlo2StLiv/yTeG5wCRGLv0vsWJ+Lx8p+u2P+GBj7G5/KdPCz2UC+BtOMNXLce9DSI
	s8K5RJIp09tt4RQSV1XGGf1TrteNKwToQ5csyHZAPGaJrDcOL1xyhQsm8EBXCwQGCKH5Cx
	9bRkbYW43q/ybA5NPXwQnHrYTqdzpMJ9n1ky8JLxk5suFPhsCkLvRLpdTTjLmf1fsajFud
	B76CFjDVlQo3obiDAAWxikYfdRl8PZtBgaG/37sZVMvV9+OAV10Cx4KMkTK9IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712217452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNCCZOUGYI/dfTpeabf6PprqLVc9VgSgHRqsATYCMrc=;
	b=eCRL3ZaU+HlcHXXyJU/2yXqXfFQe/QSm64GWIQOaNpAhzS666UCQDKAMVgqcTSOHoKR9Nu
	hCOtf3HnrF6FNjAQ==
From: "tip-bot2 for Li RongQing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fpu] x86/fpu: Update fpu_swap_kvm_fpu() uses in comments as well
Cc: Li RongQing <lirongqing@baidu.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240403091803.818-1-lirongqing@baidu.com>
References: <20240403091803.818-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171221745138.10875.968824238407538547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     af813acf8c06db58c6e21d89d9e45e8cd1512965
Gitweb:        https://git.kernel.org/tip/af813acf8c06db58c6e21d89d9e45e8cd1512965
Author:        Li RongQing <lirongqing@baidu.com>
AuthorDate:    Wed, 03 Apr 2024 17:18:03 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 04 Apr 2024 09:49:42 +02:00

x86/fpu: Update fpu_swap_kvm_fpu() uses in comments as well

The following commit:

  d69c1382e1b7 ("x86/kvm: Convert FPU handling to a single swap buffer")

reworked KVM FPU handling, but forgot to update the comments
in xstate_op_valid(): fpu_swap_kvm_fpu() doesn't exist anymore,
fpu_swap_kvm_fpstate() is used instead.

Update the comments accordingly.

[ mingo: Improved the changelog. ]

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240403091803.818-1-lirongqing@baidu.com
---
 arch/x86/kernel/fpu/xstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 117e74c..d978251 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1433,8 +1433,8 @@ static bool xstate_op_valid(struct fpstate *fpstate, u64 mask, bool rstor)
 		return rstor;
 
 	/*
-	 * XSAVE(S): clone(), fpu_swap_kvm_fpu()
-	 * XRSTORS(S): fpu_swap_kvm_fpu()
+	 * XSAVE(S): clone(), fpu_swap_kvm_fpstate()
+	 * XRSTORS(S): fpu_swap_kvm_fpstate()
 	 */
 
 	/*

