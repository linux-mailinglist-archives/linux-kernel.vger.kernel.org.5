Return-Path: <linux-kernel+bounces-73643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9471C85C568
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 363B4B20D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DA714C588;
	Tue, 20 Feb 2024 20:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NLFcq9UY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MGKzX5rC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7628A14A0B5;
	Tue, 20 Feb 2024 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459470; cv=none; b=TAVcfL5HrM+xnB+hVhXxVZWKTdz6UZo8In3I5Ni1/C47ZQ+dxhlFW4dO0c+lCflYn43lu3bNHz4265vG0XcS1QySLRs3Nh5EZqDih/iscTLHKY5BAXCf4wj/uAWB6x6VrRLyz3tH+C3qaabQoxplrsbg82sNtB7chQH35DOpoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459470; c=relaxed/simple;
	bh=eGMWMOsbIiQk+1KzXbKkYShwvHFffjU2CoI4QKsgl44=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HK1S5Y4FkQdPvL2cY4V5AW9F+JDkPzqmW2uiwjtZ4ewnHiLLJxFAN3q94U8JsD4Bl7eQk2UrGddoEOIh36PBaNE9D7H4fFLJtknkHS6HN/akjgYuIsaJMqtAlj68D2t4E4wCzjiGVSKlcIylRX6TwFtty+FEvHB3gHIrT7VY4WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NLFcq9UY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MGKzX5rC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 20:04:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708459467;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ab00n/hJfDVM2zZBWZ3OQmrpMb9AWqR6Kl/il76L52I=;
	b=NLFcq9UYmybYAzxggbeNN7VcRK16eu/QFDwQ9doCt7fH9kUV2/URQkGPhIU2cZ6Td2gWwU
	N4NbwAwZCxEhdMsbPhH6tht4is+X+EflFswEOA4GsO7RmqCAwg8FtrPV2jV5t/a65HzY/0
	d5DQ94qAnbV8Y4Eb+yxNRrj5JHVfQuAIDTzph14TEcs9RpyOWcdcuGYjHgTD3ceYdMz1Ns
	1Z76ScWAtyN4a6B4UMiA5DcTC5LEWm9xPcKvRFfU1bf4Sf5ksORW/CZo7fmOYl+AwQRPRw
	ce9jiN0g01ycQBoMGZdcbAnTVQFX/FHrJJJPo6gQFknAA5MsOQH3dZse7ckY/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708459467;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ab00n/hJfDVM2zZBWZ3OQmrpMb9AWqR6Kl/il76L52I=;
	b=MGKzX5rC1pFnSIo4KsvzL8GrEkbftgliTedMCCDG0SKbQDJ7WJtUK9PF2Fmrv9PqYyBuNr
	p3hqCcAE+6/27oCQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] LoongArch: vdso: Use generic union vdso_data_store
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Kees Cook <keescook@chromium.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240219153939.75719-9-anna-maria@linutronix.de>
References: <20240219153939.75719-9-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170845946697.398.15736945127304000905.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8d87d2cd1d0136452d2afcd143e511ccad49018f
Gitweb:        https://git.kernel.org/tip/8d87d2cd1d0136452d2afcd143e511ccad49018f
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 19 Feb 2024 16:39:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Feb 2024 20:56:00 +01:00

LoongArch: vdso: Use generic union vdso_data_store

There is already a generic union definition for vdso_data_store in vdso
datapage header.

Use this definition to prevent code duplication.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20240219153939.75719-9-anna-maria@linutronix.de

---
 arch/loongarch/kernel/vdso.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 14941e4..90dfccb 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -21,15 +21,13 @@
 #include <asm/vdso.h>
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
+#include <vdso/datapage.h>
 #include <generated/vdso-offsets.h>
 
 extern char vdso_start[], vdso_end[];
 
 /* Kernel-provided data used by the VDSO. */
-static union {
-	u8 page[PAGE_SIZE];
-	struct vdso_data data[CS_BASES];
-} generic_vdso_data __page_aligned_data;
+static union vdso_data_store generic_vdso_data __page_aligned_data;
 
 static union {
 	u8 page[LOONGARCH_VDSO_DATA_SIZE];

