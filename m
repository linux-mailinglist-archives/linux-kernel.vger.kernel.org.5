Return-Path: <linux-kernel+bounces-39107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534BD83CAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8ED81F20FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32A413E237;
	Thu, 25 Jan 2024 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CQKQRypc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mmv/DgWE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3DA13B7BB;
	Thu, 25 Jan 2024 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206899; cv=none; b=lnzw9wbwhFQbIvdIPm9qyUf4yGaJ8qkZXKnAbujC5MHWpAwjJoHMWGa6HecYsBOtcfZKKNkBzSmDfAG2OWN963bLI2mqC1x9pNNnItmIZ8zhO9JY6Rxzwu5f4zf8Hvjllmj5yDPHyQcx7WQU9+jwvZ9ped1aR/PC0sIRgrSQ0ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206899; c=relaxed/simple;
	bh=AFyo1Gorwvt4Rx4HYqfT1N7z/BgQjeYi8Axpr3YcdIQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hECwL13ZgyF1PDwi8MhxxBHzOEipU2E2a0k16RylvdA7ZrW//yp3BWG4y6L8mMzTx/1TvI5BThvt4mO5+VAjqM9bc+3BxokfSIzoYYr7IhNr3Cs9nba/Ycw+u2aiArQ466yG1KMXL1jnCUg092p//c95i0p8XuYr2xJnUBl8nZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CQKQRypc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mmv/DgWE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xeYB8FHDN9j5zBNpGak6uTANmomo9rFaegdte5z2Vx4=;
	b=CQKQRypcWFKtiwpwaQ9D89Yj4+yCJJxXAqgMX2jbss5hWcP9PzkIaGyWqvs4fywmYjTCRp
	5dTKpjpMwd11yyweoqy+VStEzpn6iqVqxoaeNautVob4sadTqDr8o8AnekcDI9ir/4OIOM
	cUr7q/h+0etAI0IRDQoIFAO4u8jdfU04T+KMKYqSfbNGwhFJzz8esCe4UeNQzYyPyje3KT
	laM+KN+VUDBj9AwxTakDkm7azFAPEfpX/tNZkLQp23YNpZJHXyrIsY/gz4UN5aHk2ygEZM
	2JvrX0aiXN8YUAbPZUX5P3MlvR1WTWXkL1xq355hq0VQsNAbwdal++X3udwV3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xeYB8FHDN9j5zBNpGak6uTANmomo9rFaegdte5z2Vx4=;
	b=Mmv/DgWEWv+1f5409KlZjZ38gwgCtZ+yfqKQNDRcvdNZNxW/KW9+SKWjw5nZ/igmqiQF9A
	uhHGm59puOyLaLDA==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fred] x86/opcode: Add ERET[US] instructions to the x86 opcode map
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-10-xin3.li@intel.com>
References: <20231205105030.8698-10-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620689481.398.7092495852376627135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     decaf17d456db9546063999c3a38344a56a2e903
Gitweb:        https://git.kernel.org/tip/decaf17d456db9546063999c3a38344a56a2e903
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:49:58 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:30 +01:00

x86/opcode: Add ERET[US] instructions to the x86 opcode map

ERETU returns from an event handler while making a transition to ring 3,
and ERETS returns from an event handler while staying in ring 0.

Add instruction opcodes used by ERET[US] to the x86 opcode map; opcode
numbers are per FRED spec v5.0.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20231205105030.8698-10-xin3.li@intel.com

---
 arch/x86/lib/x86-opcode-map.txt       | 2 +-
 tools/arch/x86/lib/x86-opcode-map.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 1efe1d9..12af572 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -1052,7 +1052,7 @@ EndTable
 
 GrpTable: Grp7
 0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
-1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
+1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B) | ERETU (F3),(010),(11B) | ERETS (F2),(010),(11B)
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
 4: SMSW Mw/Rv
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 1efe1d9..12af572 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -1052,7 +1052,7 @@ EndTable
 
 GrpTable: Grp7
 0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
-1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
+1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B) | ERETU (F3),(010),(11B) | ERETS (F2),(010),(11B)
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
 4: SMSW Mw/Rv

