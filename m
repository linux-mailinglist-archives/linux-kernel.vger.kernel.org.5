Return-Path: <linux-kernel+bounces-125675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918FE892A8F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CAE7282C93
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E978710976;
	Sat, 30 Mar 2024 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KfNX4VsP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BNeHQC+p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A682CB67F;
	Sat, 30 Mar 2024 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711795591; cv=none; b=g0wemVWL1TiATu54CqpQ4QBAS9uU07qJ8gp+0EHDCjzuAlV2mhG593YHJGaFfqOv+9n6fiDXyf93mUUgUYtQBL17E/WMaBaV96Dk7f+e34uyH/0W8fjohIj+7UaJkhFX8aBUdVOb2+8pvRWz29/kP1R7XW6FIxlHYoHXhWOklj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711795591; c=relaxed/simple;
	bh=ZJA04fBQBqXlf25eLmDUaBA6nA6ZjUTtD/VCfrNAki4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JLCKx9k3jFCdDe0PB9ap87Q6D8XNZBF006eTdNMJifEeEEWci1WwDxbCpoNrGhodXj1fN0RS48zWW701Kx+zdIQ8mwMH/QWCbiAUH76P2z1tDhReL9IWnF8FYeVRLIAms/WNNskF4k4+qtxmVt5kw2slOJ8qpaIJuIspOL1Mous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KfNX4VsP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BNeHQC+p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 30 Mar 2024 10:46:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711795587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AdK4KSizSeidbWmYm5GyZPs2kFSbrYtdmEQ++9F/r8=;
	b=KfNX4VsPSkl+rIZMcz1nKGDlRgZmqX7bVeQbiV3HmGap7/Sg57crwKZ5XS9L3nHAIaAyoK
	tlJkxHa6v2iDP6SjXNylRb6BW077+sEH25H1d7+oWAEPQ8vQFeTIUidmzj0BDIk03VXTd3
	kq1tg3WO/mOyUqFb8SmwmjfkPaL20KHc69Ekeka1ayqUF96ENLtO4qh6oXwryREz0zpPjy
	8swhFB0ccLW8Sgqdpd8ivgXcB4uIyyWQjLT4wLh1VDb0qHTyfFYzEsWEwbv/62BH1qlSZ9
	9zHVE597eoTb2FOLSucaglkS0Dl9OxZwZk69uCQ/VNozfl90ovPmgdK72ToTSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711795587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AdK4KSizSeidbWmYm5GyZPs2kFSbrYtdmEQ++9F/r8=;
	b=BNeHQC+pCuZKRmlemuPtWfoHVUwVZ7BymFO0Uns4N6G4sFqfFYMf0UnKBF2N0jxDW+H9fQ
	TZpBqCRw94BcU8BA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mce: Clean up TP_printk() output line of the
 'mce_record' tracepoint
Cc: Ingo Molnar <mingo@kernel.org>, Avadhut Naik <avadhut.naik@amd.com>,
 "Tony Luck" <tony.luck@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <zbCJWYdL5y@gmail.com>
References: <zbCJWYdL5y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171179558664.10875.14209003500081518612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     ac5e80e94f5c67d7053f50fc3faddab931707f0f
Gitweb:        https://git.kernel.org/tip/ac5e80e94f5c67d7053f50fc3faddab931707f0f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 29 Mar 2024 08:11:27 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 30 Mar 2024 11:35:28 +01:00

x86/mce: Clean up TP_printk() output line of the 'mce_record' tracepoint

 - Only capitalize entries where that makes sense
 - Print separate values separately
 - Rename 'PROCESSOR' to vendor & CPUID

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Avadhut Naik <avadhut.naik@amd.com>
Cc: "Tony Luck" <tony.luck@intel.com>
Link: https://lore.kernel.org/r/ZgZpn/zbCJWYdL5y@gmail.com
---
 include/trace/events/mce.h |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 1391ada..9c4e121 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -55,15 +55,18 @@ TRACE_EVENT(mce_record,
 		__entry->cpuvendor	= m->cpuvendor;
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
 		__entry->ipid,
-		__entry->addr, __entry->misc, __entry->synd,
+		__entry->addr,
+		__entry->misc,
+		__entry->synd,
 		__entry->cs, __entry->ip,
 		__entry->tsc,
-		__entry->cpuvendor, __entry->cpuid,
+		__entry->cpuvendor,
+		__entry->cpuid,
 		__entry->walltime,
 		__entry->socketid,
 		__entry->apicid)

