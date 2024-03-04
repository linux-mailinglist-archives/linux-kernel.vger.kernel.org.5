Return-Path: <linux-kernel+bounces-90397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CA886FEA3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C171F22F60
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3703CF59;
	Mon,  4 Mar 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NO8lSC7k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="90m2Rl2o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CC53C087;
	Mon,  4 Mar 2024 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547151; cv=none; b=FFcSC3gQpa3js+0yrT9kSpacicZ8nvQ9sVe+waCzdl9PXGc0QL5wht0cjrN69NXsDX6y27zoX8khZxZZ2skuxFEFWman18ePOTxk7m+DJJx3IHYtruCvwYOvwMM0vzGax/fGF5pMX7sHYriDRO7HevHGKbhPpU1Xgs7z5QanjR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547151; c=relaxed/simple;
	bh=0nwFi0bkuZGiGtiI8Nsx6zeMClnjEJolxPelJmGOFdM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=IaRpnAnzaTz4hMHTdrwgmYMf99MVy0xUZ9v+3pb37Ynu+LMIKmq6ZWOyCpffqhJL0HVmSBiiToKkZT3yXkBuAJZR2KbF+jv6GF448zZRyAKDXX4xaPxF7OpsT+UoED7un2adCz5J8pU9PnoFUbhBrblAGTp6Uosa43946PQ2gXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NO8lSC7k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=90m2Rl2o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240304005104.787173239@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709547148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6Jgk9G7c0E4dzMxbvaTsjGPBA2bcPCPscX5bks01Uro=;
	b=NO8lSC7k+xuFTRyI7RDoRaIx57KuVWWkTdO69WoHfx1l4s6SvALgnsdiH23XFiV0Lku7FA
	dFs+/vfPDCaI0i1XKSKbxrncJHkGUG05L4tLpLOp6m+ZmZbTGgPCfhhZBBiF+bFA544pCJ
	Ife3C4CeGfrygHWbseJHDp0S/ETIf5JYa8SsWTqBXc7skRZPoSESnlEuD2kdgubT1R9EVT
	6RYMVtbvOrj7448mWylKQrOXulwXNdxrP4LOE7RMFBBkhpZMVcm1Im0N0ll3765Z99m+h3
	9z3xbVIDoOFuwpd4eNp0ZoYCgCoNyerplkqIAKvbbAcpY1A4F76T8u5cyx9Fvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709547148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=6Jgk9G7c0E4dzMxbvaTsjGPBA2bcPCPscX5bks01Uro=;
	b=90m2Rl2oJgJFtAWub/kQ/ti4ooEu+pBEJZ8iuepWmfQWR/jnE01Sl2VKRtNiOwEbOQEsbP
	MKVHn8eclKAYCPAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org,
 lkp@intel.com,
 oe-kbuild-all@lists.linux.dev
Subject: [patch 8/9] x86/cpu: Provide a declaration for
 itlb_multihit_kvm_mitigation
References: <20240303235029.555787150@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  4 Mar 2024 11:12:28 +0100 (CET)

sparse complains rightfully about the missing declaration which has been
placed sloppily into the usage site:

bugs.c:2223:6: sparse: warning: symbol 'itlb_multihit_kvm_mitigation' was
	       	       		       not declared. Should it be static?

Add it to spec-ctrl.h where it belongs and remove the one in the kvm code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/spec-ctrl.h |    2 ++
 arch/x86/kvm/mmu/mmu.c           |    3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -96,4 +96,6 @@ static inline void speculative_store_byp
 extern void speculation_ctrl_update(unsigned long tif);
 extern void speculation_ctrl_update_current(void);
 
+extern bool itlb_multihit_kvm_mitigation;
+
 #endif
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -53,12 +53,11 @@
 #include <asm/cmpxchg.h>
 #include <asm/io.h>
 #include <asm/set_memory.h>
+#include <asm/spec-ctrl.h>
 #include <asm/vmx.h>
 
 #include "trace.h"
 
-extern bool itlb_multihit_kvm_mitigation;
-
 static bool nx_hugepage_mitigation_hard_disabled;
 
 int __read_mostly nx_huge_pages = -1;


