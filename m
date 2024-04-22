Return-Path: <linux-kernel+bounces-153534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC178ACF49
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A439B21A63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B70E1514E0;
	Mon, 22 Apr 2024 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z4jnXm2G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ugqN3RXe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255711514C5;
	Mon, 22 Apr 2024 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795815; cv=none; b=TEx+2m+/+Bp43BQCeVlDrhs2Ufpabz0bcFQ2lFz8gMBIdnOkCYdKvtxEJVTiNXFHufuzxixCo7lnffoY8Hufneuh5/WI61WaIusyMG+5Rzj9oA60fZqUi6Xla8bql0qQmVtHAN+EiUGsnqNT8g2hdmNhHd46He0uXHOZQsPpVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795815; c=relaxed/simple;
	bh=+BuURfxGxMz3GbuEuqp9spY3hzzXwXiq1MEUK1mgqFw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=upi96cG8kLELJL6dknZJy80HIXwcCEgAfgFQmex7kgOadmailMLDOlpIS3OqxRO8K3TJhTT9xJiimhHbzMvlXhKY6FpxBekkYjlMcP1cOK/Zteoq3uyzKBJclxbP1EYykZuoi6cEiMyImEreeNnCKyWE5Zf5/NbGHCtojR5Gods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z4jnXm2G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ugqN3RXe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 14:23:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713795812;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGuAe5YFLwRdXqKvx58BMlfhcKVyHBnb55A3Anb3oDo=;
	b=Z4jnXm2GtohbdPSq77m9oR5zRlwr/JqXocsEwaY5l+2K0j5bn5hT0EalNCp7zBJ88sJ9PF
	SOcjvu3gLTpV881mDsmhOB2K6PgcqZWeDFma6qcz9Mzc/wNhPo6zwaF/kg0KfbCMEgBerz
	q1DG4t3PH5/0JcpcIdMyjU8S+m1a8R6TXkZd3EooYkzrRFe0gD6/0ScXHMaP18BhVAHp0Q
	LN/WUUvRFeY43Z7C8Q56m96phXiHwacV5HpB6snNu7/Qf3p9p6w8iawbg5on8FmyIpu/x3
	9KBNHe2IjyLBsDn5Ywp+UmJr7TAOCN5uqAlWMMxeGHzMebnEZl3sEQ+o2Nepyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713795812;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGuAe5YFLwRdXqKvx58BMlfhcKVyHBnb55A3Anb3oDo=;
	b=ugqN3RXeIYTZnVo1/ms4BT9/uumbYuLGrgGKa3A6UNRllFa1T/CLsi6KmUjP1kL9Rqg6+W
	OqkOrIGUZGaLNkAQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timerqueue: Remove never used function
 timerqueue_node_expires()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240417140229.19633-1-anna-maria@linutronix.de>
References: <20240417140229.19633-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171379581122.10875.5495404543407022276.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e84c60032a39e3267f0b46175d5368da33e214a6
Gitweb:        https://git.kernel.org/tip/e84c60032a39e3267f0b46175d5368da33e214a6
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 17 Apr 2024 16:02:29 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 22 Apr 2024 16:13:06 +02:00

timerqueue: Remove never used function timerqueue_node_expires()

This function was introduced with commit 60bda037f1dd ("posix-cpu-timers:
Utilize timerqueue for storage") but never used. Remove it.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240417140229.19633-1-anna-maria@linutronix.de

---
 include/linux/timerqueue.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/timerqueue.h b/include/linux/timerqueue.h
index 62973f7..d306d9d 100644
--- a/include/linux/timerqueue.h
+++ b/include/linux/timerqueue.h
@@ -37,11 +37,6 @@ static inline bool timerqueue_node_queued(struct timerqueue_node *node)
 	return !RB_EMPTY_NODE(&node->node);
 }
 
-static inline bool timerqueue_node_expires(struct timerqueue_node *node)
-{
-	return node->expires;
-}
-
 static inline void timerqueue_init_head(struct timerqueue_head *head)
 {
 	head->rb_root = RB_ROOT_CACHED;

