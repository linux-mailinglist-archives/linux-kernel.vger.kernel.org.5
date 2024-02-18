Return-Path: <linux-kernel+bounces-70500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AA58598B8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC76EB2119B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7566F511;
	Sun, 18 Feb 2024 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qrnb2FPQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TZBO/V1B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B725772
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282673; cv=none; b=o7HLDI/U5H2AhiZmJpMmM6RDRqPoQIjW169gqqxSuXF2nhbU4X5Leh8SB+bYMCKHfjJGIPzRgo7VCb8VGPx3jGEpdTGHOhcZoj9va+cpbhLXRzoOcTMwGOwCnwShL8iq2IuIxol9erraH5sLYGivT9/5WjZElnz42sc+L91duKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282673; c=relaxed/simple;
	bh=szxbYO6I4lhZ0tittilU4W8LlO/EcPP5ZLOScG+pyp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f81GMo2NjMSd90QLGQq86KEuLjh2hfMjI5uVaYyQr+YjEG3OxrKmTlVl3X8LnYBtFgj66OYakSNfRYA2Sq/aaQWBjk6nTIWgGN8V0Yx3/iPZCv2OuAvhM9gMWbW0eWNFkD8dWXhmIZd2yBQm+DSnE18WEsTt1gpaDLC7zdwETxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qrnb2FPQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TZBO/V1B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708282669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Un0rwRwZZ3a2XT9jb+evA7D9ZWLwutkDIt2olFNBSM=;
	b=qrnb2FPQWgUIoPQJwgH3E7DufsQ8IsmtrQQqmcYm22LHa2RlOcWRaeSgLnTFRkhmI+mqtI
	LRtd+VTf3IGtSg31pnViD3VR4oQLjkg/aygbOYwww0ug90EJiO7B0J2tW815u+ZjEbJ2L7
	aXR2jDLA0+TBCYwEQzB2/sxQTpYFEI8RPyW5XDMBYMHWL1pAxkd9SBV82uAdo7iMHesD38
	WRuCisj15Tlbb3l3AEKayPiqVcSXandv/cN4vbqodVlGzOWCbAH+ssr8l8CDm7k3kZuMNt
	CVTx2lQTuI+sOT63pugYF4DZCMWzYNhlyYfNKl9HVk47k8XSDkbqVUxCyXX39w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708282669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Un0rwRwZZ3a2XT9jb+evA7D9ZWLwutkDIt2olFNBSM=;
	b=TZBO/V1Bg1bIdmb66zgE0251XZPPIH3YGi9O+tOmQDQ3pr7l4tHkAdFsCwv7sEQgcEqLRv
	77OR8OHaSoy8eBCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH printk v2 05/26] printk: Add notation to console_srcu locking
Date: Sun, 18 Feb 2024 20:03:05 +0106
Message-Id: <20240218185726.1994771-6-john.ogness@linutronix.de>
In-Reply-To: <20240218185726.1994771-1-john.ogness@linutronix.de>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel/printk/printk.c:284:5: sparse: sparse: context imbalance in
'console_srcu_read_lock' - wrong count at exit
include/linux/srcu.h:301:9: sparse: sparse: context imbalance in
'console_srcu_read_unlock' - unexpected unlock

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 6c4afa79147e ("printk: Prepare for SRCU console list protection")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 696a9d76c09c..b75ca383683d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -282,6 +282,7 @@ EXPORT_SYMBOL(console_list_unlock);
  * Return: A cookie to pass to console_srcu_read_unlock().
  */
 int console_srcu_read_lock(void)
+	__acquires(&console_srcu)
 {
 	return srcu_read_lock_nmisafe(&console_srcu);
 }
@@ -295,6 +296,7 @@ EXPORT_SYMBOL(console_srcu_read_lock);
  * Counterpart to console_srcu_read_lock()
  */
 void console_srcu_read_unlock(int cookie)
+	__releases(&console_srcu)
 {
 	srcu_read_unlock_nmisafe(&console_srcu, cookie);
 }
-- 
2.39.2


