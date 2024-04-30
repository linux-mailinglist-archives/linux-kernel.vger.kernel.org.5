Return-Path: <linux-kernel+bounces-164005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72238B770F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7878C1F22393
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1049175546;
	Tue, 30 Apr 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hi+lY2XO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gwOGcOi2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DA917276D;
	Tue, 30 Apr 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483728; cv=none; b=iUFSWDZ0OoawWjPLi5RJQ1cLx9mL2TzK6OTtyvIrrBcN1Zi/0Y/nPbTDmQtR/imKy6HFk4srT5Uh2ipNQbEpyxw0Xhsj/gQI7FQAr96mgn9o47OTGc6nX3vKWKnsfYY9LAC9Z33ddXtOilnPeoijWt6KiWaPCf3hJwLu7jXAz+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483728; c=relaxed/simple;
	bh=b3LD68pnusTR+IzDDXMGyEQF51+08PBaN7+gsQYMNX8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=npjnnMH0ysv8ZeN7MzvApInVgRIVTjee64NX6I0GdQaCG7/a2UcHBtHHPkshw9V0xV17csFn3XLyjCHlWmBXMufKBCYIPwe16T5a1vRmekokfLR4oj3yFlAQ+zRIiDz2JtUBaIXBgIueQZ0xOWCLkB5g0Ud3n8Gqqw4YzsgGLN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hi+lY2XO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gwOGcOi2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 13:28:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714483722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/izHAdnkHtcCflI1PqL7hrWCQygcXEomUr1Jx5Z1ff8=;
	b=Hi+lY2XOEvWcSN5C9GfwDIemxVe+U5ESRyleqSTcImNYTsIKCGQBY+a0kS7lfbN1dNRmN0
	ZYutdU+uJBgCyZ9O1dXXfC11okihMjnOQDi1dbYLpi82HrYIlxjsl8paCMplzDXeIlE6jE
	ooVF3v18C6RTloyHfk49FdIB59qlqWnBVdOTH7PR8AYG2oye6cvxQGOB6cwOYexpqas2LB
	irSlRVG4bXABzl+zwEjHxmdGDp4IejFbI52lgWpcASCt1QCtfLS0MpZ7IYGt2VXLgK+gmL
	bn7NanRkirnvrDVc33SjOAZs8KIc1U6gICZVbj9wYlhvGhKzE75NHYUgcpML+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714483722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/izHAdnkHtcCflI1PqL7hrWCQygcXEomUr1Jx5Z1ff8=;
	b=gwOGcOi2PTF1WP3PtbhtTMOHud2BJun1U3wTiF8Wmjn7QaOWP38gdhNLoHAtWZ5oSgwLqe
	76SgX6sIDmyuSFBw==
From: "tip-bot2 for Jacob Pan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Add a Kconfig option for posted MSI
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240423174114.526704-5-jacob.jun.pan@linux.intel.com>
References: <20240423174114.526704-5-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171448372234.10875.12009280366852353008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     7fec07fd217800c5174f51d8869518807e9aa144
Gitweb:        https://git.kernel.org/tip/7fec07fd217800c5174f51d8869518807e9aa144
Author:        Jacob Pan <jacob.jun.pan@linux.intel.com>
AuthorDate:    Tue, 23 Apr 2024 10:41:06 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Apr 2024 00:54:42 +02:00

x86/irq: Add a Kconfig option for posted MSI

This option will be used to support delivering MSIs as posted
interrupts. Interrupt remapping is required.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240423174114.526704-5-jacob.jun.pan@linux.intel.com


---
 arch/x86/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4474bf3..fed22fc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -464,6 +464,17 @@ config X86_X2APIC
 
 	  If you don't know what to do here, say N.
 
+config X86_POSTED_MSI
+	bool "Enable MSI and MSI-x delivery by posted interrupts"
+	depends on X86_64 && IRQ_REMAP
+	help
+	  This enables MSIs that are under interrupt remapping to be delivered as
+	  posted interrupts to the host kernel. Interrupt throughput can
+	  potentially be improved by coalescing CPU notifications during high
+	  frequency bursts.
+
+	  If you don't know what to do here, say N.
+
 config X86_MPPARSE
 	bool "Enable MPS table" if ACPI
 	default y

