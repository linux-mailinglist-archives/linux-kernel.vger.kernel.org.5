Return-Path: <linux-kernel+bounces-164008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9326E8B7711
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B381C21FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783B6176FA8;
	Tue, 30 Apr 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y4w92E//";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rNlcGb6m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F53172BA8;
	Tue, 30 Apr 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483728; cv=none; b=DOcJ01BpaUOTTqTzdWt4TneRrOhHogXfbqqsFE+ueSoOc8gI9GLZykcgBLxFMiccy96tvs67KSmOvwgY81z6sz8Cm+dUwgECgEz+59KksLHQDh1cNKJZ2q4i/qy97zABCtsLeAs0gXGUoyulAEoO6oTQxf/TwFp/Q6PTsOB2cSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483728; c=relaxed/simple;
	bh=CyYZ3ZY/IIk1KXmtX/hhlKbKAMxkGWEO+vbM270J5J0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DljVYpU4ZfLy2pq1BX1y2Xz/VDXeuwimVuE6dVC2EQuEgh/fGOdth7Yk0arFKzL7Gje69JKbyYTAbx789Z+qTFMG7Rn2RiLOW7xRrdBIGCMhv+8nusSK3Kfq8NlUJCOHhs+EmaqqcSQs8my2uL+dpIIEatYqY9ap2Oc4/DhKlxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y4w92E//; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rNlcGb6m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 13:28:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714483723;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbZrpFUQ+xGp/ymxdXSJF6hdEB2SrOiJ4Nxfp4CJY4I=;
	b=y4w92E//9haorJvNnZoC9fbTn86JgChziFb8qzQEwB8Yl+IIZGEZoMRPsjt2xe7SGpBwfr
	PSpLLi55T1iTgjn7MXIM69KDC96bu+QAbWxTw4awcNjhew5ATQAQJMndGyLVLQYw6RFGs4
	we/jvvo6hfaQV67gW7dUE4+gKEIpK3Sck1XwVFU6tN+S5HuoCKCeHyoxihxc2CDrUQpbYY
	49/55ddyAxbfzhsLgeE+S7lAXrx2NOJYg9BTBaZ42VRZeqEHYoC4N7V1tJGOZOjK7T3A0m
	VFp/E/59e+BYGyGvVJfMlXDIylOC+UiZjKq1RHACmH9TYbuVbOLfKlJAZu3K+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714483723;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbZrpFUQ+xGp/ymxdXSJF6hdEB2SrOiJ4Nxfp4CJY4I=;
	b=rNlcGb6myQQPiVBfLnP4k75Hj7YbSDB8h/s1JMNcHq3zCEzJbCYbhxKgav5SdPr5Oc5msw
	qVFCwHyVolo3ZDDQ==
From: "tip-bot2 for Jacob Pan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Unionize PID.PIR for 64bit access w/o casting
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240423174114.526704-3-jacob.jun.pan@linux.intel.com>
References: <20240423174114.526704-3-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171448372276.10875.2354227749649106662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     4ec8fd037139a4d8afb2a5c7edb4a17f9449a035
Gitweb:        https://git.kernel.org/tip/4ec8fd037139a4d8afb2a5c7edb4a17f9449a035
Author:        Jacob Pan <jacob.jun.pan@linux.intel.com>
AuthorDate:    Tue, 23 Apr 2024 10:41:04 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Apr 2024 00:54:42 +02:00

x86/irq: Unionize PID.PIR for 64bit access w/o casting

Make the PIR field into u64 such that atomic xchg64 can be used without
ugly casting.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240423174114.526704-3-jacob.jun.pan@linux.intel.com

---
 arch/x86/include/asm/posted_intr.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/posted_intr.h b/arch/x86/include/asm/posted_intr.h
index f0324c5..acf237b 100644
--- a/arch/x86/include/asm/posted_intr.h
+++ b/arch/x86/include/asm/posted_intr.h
@@ -9,7 +9,10 @@
 
 /* Posted-Interrupt Descriptor */
 struct pi_desc {
-	u32 pir[8];     /* Posted interrupt requested */
+	union {
+		u32 pir[8];     /* Posted interrupt requested */
+		u64 pir64[4];
+	};
 	union {
 		struct {
 				/* bit 256 - Outstanding Notification */

