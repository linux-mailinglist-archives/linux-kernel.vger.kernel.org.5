Return-Path: <linux-kernel+bounces-35952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32242839934
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E765AB2C25B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE1D1292D4;
	Tue, 23 Jan 2024 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zJWzPdi3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Dz7bE2t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FD7FBB5;
	Tue, 23 Jan 2024 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036473; cv=none; b=Embd1FZmkuHH+6bhLXNnwuDJieFxv0OB0ez59LMPidWcIOPzRYtT2IPZr2a2JInQ4iQZb+lmTIGBOsEiPuPQYLcU20zR6ZI5xs+H3V/9vaHXCWH5xrWtLZAy4g+hhcXlRvSscbm5VsVtCFhCed76d9Su0kD/URXB+O4JIb6mSNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036473; c=relaxed/simple;
	bh=HOc90YBHmrRGvy080ff3wBCG+qxyZsoScBH6Z0w7o/M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=suTjJYnJHRu4yufgFHf9gXEQSjxIK0PpEhpulx+M9fijWXtUVds4ZsEiVbl2+5JU23RMCwBb/nnXunRZiyAVzLIgkcovWf3FskzjkPbnwGdNnQKEVK24lLMeyAsXYJWTg++FsvqmEZfhMxk7P3kg8uxg0qsl2En0jYlywv9fPOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zJWzPdi3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Dz7bE2t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 23 Jan 2024 19:01:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706036469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6eUyX0zjICeqO/1o5Aw5V5Tn9qzErub5OCFL5qwEz5A=;
	b=zJWzPdi3kXjCo11vbCN5md1kubkqkxDjGZ4ORLqDFF7xfxoeL3I05gJVAqJGQ633S20143
	NVreIfoJErgA/6tQpHbz6fv4u2Iq8PcEBgEglmJ8k2l8tYIBLbZThkOioe7N38Ksy2g6vW
	8jyOO6tGdI8ptuv1xwGV0BdeIi5+89C63aicdhfzebykFM26/ekgUZm2fJftdAXdFKyP7F
	FeaziwQUn6LYfej8tH7/6bHJczglzNnPkq1lbpcom8EqhFZmizbvlFT1/Z5nv2UJO6f/2N
	qny2vw0yWIApAsdnIRiDDP4bQJVddhIPc8STCf5+FeLFDkQTIUGxy/smseP7Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706036469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6eUyX0zjICeqO/1o5Aw5V5Tn9qzErub5OCFL5qwEz5A=;
	b=+Dz7bE2tcMPdATsIYPDX+lVWf6s3f2tqMx2dyVFKmP2P3sLTMLvFhDKbye9H9daWr/7aXY
	qbq1tNwQauvv77Cw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] Documentation/kernel-parameters: Add
 spec_rstack_overflow to mitigations=off
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240118163600.17857-1-bp@alien8.de>
References: <20240118163600.17857-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170603646864.398.8199127435495135105.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     49527ca264341f9b6278089e274012a2db367ebf
Gitweb:        https://git.kernel.org/tip/49527ca264341f9b6278089e274012a2db367ebf
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 18 Jan 2024 17:36:00 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 23 Jan 2024 19:52:53 +01:00

Documentation/kernel-parameters: Add spec_rstack_overflow to mitigations=off

mitigations=off disables the SRSO mitigation too. Add it to the list.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240118163600.17857-1-bp@alien8.de
---
 Documentation/admin-guide/kernel-parameters.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25..64960f5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3399,6 +3399,7 @@
 					       nospectre_v1 [X86,PPC]
 					       nospectre_v2 [X86,PPC,S390,ARM64]
 					       retbleed=off [X86]
+					       spec_rstack_overflow=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
 					       spectre_v2_user=off [X86]
 					       srbds=off [X86,INTEL]

