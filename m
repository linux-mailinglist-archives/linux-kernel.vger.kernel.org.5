Return-Path: <linux-kernel+bounces-111166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C20988689F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1276E1F2111E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0381B95F;
	Fri, 22 Mar 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C/aRLcXi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="evjIH0+y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2FB199AD;
	Fri, 22 Mar 2024 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097803; cv=none; b=b0ArEpMhLvYMYAhvwFDvhX0KEqBJVtsZ3KKObC7bZiHKkZZvYhAyW5bfV5izxiaSdQphDhD0mc4MLp68K0rYMFc+41FkIyfswhrleCTSrPxGf0NMgEEtP0h0qh4WDNGvHfnPphF2xlQ0OTdnwRApYgJ+6tRliBHMxpeof4OWWw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097803; c=relaxed/simple;
	bh=l5AWyEgp6PdK/1b0gnmNOdKq68XsF6YlEYMS03ehOOQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qxaPQerKcGCtD9ZPbxWyQbi9hFjPMF0gASjyb0nXX9U9TmsFlvEaTAPhsctqBYSOmYjcQ2Mr3M0KgGBqkxoZPsbh57zuyH6aixhE1bftFaZo506UZHZZEgXzphJxnZp4bFj+Wrovn4/gYSb4Ql6+s8Ls0PJEAw+oj2E67WNz9f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C/aRLcXi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=evjIH0+y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 08:56:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711097800;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUg5m/2/O/iajpong8vZmpJ6FdNqHdlqgbJQFwXJ1Mc=;
	b=C/aRLcXiZ9NBuQhKDZxNC+rhlq276oq+h54pvII31JrAG2IIFi290gFwDCe7FKvYZysF4A
	ihadBsb0EMeY8tXOewpvq7qr2qKm16UeHMBXEEYxpweP5HF3i3IzQAhlQwFPKg+wBGgys/
	pkKYQGX58q6XJ92feMNCqHh8hPvwHhsEiKORZKJMJqDVq3DfNdLrVP8ktFdTUkprFdZXu7
	F/5lNDEKPFSvYjNpcot9U8RaWAdJZMtvarf0BLq68sCiypNFdJ1gCglgJP01h8xH8J0nSO
	aB+J4KVPRGvKLoAgs82P0cVyojzwJaspwpjw8vOlCNKZc3jTw5cKldbEoIwjRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711097800;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUg5m/2/O/iajpong8vZmpJ6FdNqHdlqgbJQFwXJ1Mc=;
	b=evjIH0+yB9OaO0Dq3RNYJIS15/5kOzH5jAhcY/IFYyBdNZSf6Q3R+9LhRWU5iO1b42a/8h
	EVIURWhrTLd+gWCA==
From: "tip-bot2 for Guixiong Wei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Ignore relocations in .notes sections in
 walk_relocs() too
Cc: Guixiong Wei <weiguixiong@bytedance.com>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <keescook@chromium.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240317150547.24910-1-weiguixiong@bytedance.com>
References: <20240317150547.24910-1-weiguixiong@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171109779918.10875.13734920982840278468.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     76e9762d66373354b45c33b60e9a53ef2a3c5ff2
Gitweb:        https://git.kernel.org/tip/76e9762d66373354b45c33b60e9a53ef2a3c5ff2
Author:        Guixiong Wei <weiguixiong@bytedance.com>
AuthorDate:    Sun, 17 Mar 2024 23:05:47 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 09:48:59 +01:00

x86/boot: Ignore relocations in .notes sections in walk_relocs() too

Commit:

  aaa8736370db ("x86, relocs: Ignore relocations in .notes section")

.. only started ignoring the .notes sections in print_absolute_relocs(),
but the same logic should also by applied in walk_relocs() to avoid
such relocations.

[ mingo: Fixed various typos in the changelog, removed extra curly braces from the code. ]

Fixes: aaa8736370db ("x86, relocs: Ignore relocations in .notes section")
Fixes: 5ead97c84fa7 ("xen: Core Xen implementation")
Fixes: da1a679cde9b ("Add /sys/kernel/notes")
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20240317150547.24910-1-weiguixiong@bytedance.com
---
 arch/x86/tools/relocs.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index b029fb8..e7a44a7 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -746,6 +746,15 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC)) {
 			continue;
 		}
+
+		/*
+		 * Do not perform relocations in .notes sections; any
+		 * values there are meant for pre-boot consumption (e.g.
+		 * startup_xen).
+		 */
+		if (sec_applies->shdr.sh_type == SHT_NOTE)
+			continue;
+
 		sh_symtab = sec_symtab->symtab;
 		sym_strtab = sec_symtab->link->strtab;
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {

