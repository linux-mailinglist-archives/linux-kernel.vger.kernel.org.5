Return-Path: <linux-kernel+bounces-110628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A58B886178
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188E428484A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380E7134721;
	Thu, 21 Mar 2024 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bhJIYjW+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EUWvwVjn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE1A847B;
	Thu, 21 Mar 2024 20:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051821; cv=none; b=DHg7xw8w59cQTroteLPB3DORuJgmGAbUWN/CQtVL14jFUr+wLWYYraXJiSVw5zDOzqNwmsrY17WuCwuXpIn3Bl7ys5Yfp44hsJkvJIpaFdlmeXn4x3nN+0hhcRnGyPvgsPDy/FcxjalY7Ed1tnIk+kkxocuhweadXBxyISvB85M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051821; c=relaxed/simple;
	bh=Lf3HfrYLrzAhvEjepEXMVanxjHeOHhN8pY5Shd4ocfk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N0aMX9TlELRPASryQ4dPS7nRprh73t7sZ1ImyXRu6rbgJR/6MIDSbDPzDX6bta//Cj0lPZp/TTs3wLfH/bZ9EL+YRezjnTz+vJllQq1kLjtyEypIF2bnG96HXnR5DhURhdsJB09sSCZ6fICLw7XNt4CRBKhW0cjiJ56aFRtNeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bhJIYjW+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EUWvwVjn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Mar 2024 20:10:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711051818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eb6K5oovm67eA2MqQVFdKN97AFgRU83d114MwSaVLHQ=;
	b=bhJIYjW+hQuiYq1kNFpPzOh+DGYTbtCHYKtwAR0uK5HLL3izxMsHUZQHiGwLoTNGFm1scN
	FMdGz2Xeo70tL1itbkdBIJxXCq3Dr901gN0gODoRKN2nBSjRQcGUwTLaZa+g4x+j4PkhMA
	S+urejKDdtLqXgGfcDkePcMTxjLsUGyRk8fye+r677ZXm3N3Y6//o4PKa4hpceU9zil/Iy
	Mo81wfNp5LY0Fd94jzvx9LZTcJiA7TdrbbNZKWDqHMZlVMm47u4howY6nDxKwo3tZfW0ZK
	WIUdmh1xm+mNoIaCAsJpPGR76V6Igy2ty4Md6zB6WN/2ZfRi5xzHPVlSej+KNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711051818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eb6K5oovm67eA2MqQVFdKN97AFgRU83d114MwSaVLHQ=;
	b=EUWvwVjntADpkN3/nPwS3YDaHjmkVbw8tqUrvdKtrqsssy0jv4lREyXI9MNBmHKnkZkLZm
	Tu3TF/S3Lv+ZdyBg==
From: "tip-bot2 for Erick Archer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Prefer struct_size() over open coded
 arithmetic
Cc: Erick Archer <erick.archer@gmx.com>, Ingo Molnar <mingo@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240317164442.6729-1-erick.archer@gmx.com>
References: <20240317164442.6729-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171105181695.10875.13663803002214703429.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     dfbc411e0a5ea72fdd563b2c7d627e9d993d865c
Gitweb:        https://git.kernel.org/tip/dfbc411e0a5ea72fdd563b2c7d627e9d993d865c
Author:        Erick Archer <erick.archer@gmx.com>
AuthorDate:    Sun, 17 Mar 2024 17:44:42 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Mar 2024 20:58:43 +01:00

perf/x86/rapl: Prefer struct_size() over open coded arithmetic

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows:

  https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
  https://github.com/KSPP/linux/issues/160

As the "rapl_pmus" variable is a pointer to "struct rapl_pmus" and
this structure ends in a flexible array:

  struct rapl_pmus {
	[...]
	struct rapl_pmu *pmus[] __counted_by(maxdie);
  };

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + count * size" in
the kzalloc() function.

This way, the code is more readable and safer.

Signed-off-by: Erick Archer <erick.archer@gmx.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20240317164442.6729-1-erick.archer@gmx.com
---
 arch/x86/events/rapl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index fb2b196..8ef08b5 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -675,10 +675,8 @@ static const struct attribute_group *rapl_attr_update[] = {
 static int __init init_rapl_pmus(void)
 {
 	int maxdie = topology_max_packages() * topology_max_dies_per_package();
-	size_t size;
 
-	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
-	rapl_pmus = kzalloc(size, GFP_KERNEL);
+	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, maxdie), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 

