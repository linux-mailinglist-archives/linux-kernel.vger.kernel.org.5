Return-Path: <linux-kernel+bounces-164768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C448B829D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598E91F22AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4E61BF6CD;
	Tue, 30 Apr 2024 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HLeFqVgf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rd+/Ngka"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA81802D8;
	Tue, 30 Apr 2024 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714515015; cv=none; b=kmjKa0umq1q4vAJFmzWhxTBf6fBfRuPODNqWMYrXE+fQu1evlfyrYRgUqI6mwmpBIOQimhB0O1kbzIZ45nnTmz3E4p6DN70KmQFQVqmxfjqPY3Zw0psz/jloKCnjwNj1juzL7mmBDXYHlc0VWhgO6abDnkEDyFgYX1k6uuamTAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714515015; c=relaxed/simple;
	bh=CoUNSM1ssBbA8KkdTjuKSapk44vBgjVCwUqgCuN+X5o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=keyKGYo9g7uy6iSWfQDUtEF0G81aQBPrfm58R4XbsLZNiRcYgahD/rO5PSFJlfcvHky93/oHixRVXEydEx4H5n0xmvorKS3CIyKxBaa0CBo3goaN0K9EVwkyzaEzXWjYemRnXXHTRuFp73z69u52NDJATrmmhwwwQYPihW9AzZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HLeFqVgf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rd+/Ngka; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Apr 2024 22:10:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714515011;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74oFo5VjJAbgDI/FeL5aqG3pkv5T6VHgnYkqqm/kLJ4=;
	b=HLeFqVgfNRHqIgGNv8CNbrywr0uMALN0VTHrIOOloP0NtbcxZtvuD9xnwIa2e6e7CjhUYm
	PsKVtAUXcrnorzyEU/VJbMtojto95/4MRoxcX1XivNYR9nOgd303jUn+cQ9QOsTjM/8FvG
	B8NgXeUjOc+B9F+rNwpJj0/ONnjukFQ/9AUWjshgFMMVrRNWRExrr7MtRxZfIjR4j5mQkD
	kTfNq7ep3tw/bl7AED7BOq/gLG1jIYa8QyI0G++O7my+FMBlm81Db1R841cK1v27I56K14
	lRqi1unxZQk6xBJnWPxO1l30ILUEgtyt17QJ1sFOH/gudZhN4Lg0KV3VbFJYzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714515011;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74oFo5VjJAbgDI/FeL5aqG3pkv5T6VHgnYkqqm/kLJ4=;
	b=Rd+/NgkaPmnUdA7BUZABHtrF6R+nMnblMXbWIMp5MSKS6j/i8pCYFRBW67KEfqw+ylkBLK
	Wn3s07s2jPultyDw==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] rust: time: doc: Add missing C header links
Cc: Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240411230801.1504496-2-boqun.feng@gmail.com>
References: <20240411230801.1504496-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171451501055.10875.16648047643476083892.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ddd9120983c3efbcaa3a4c7777da1440f8ce27d8
Gitweb:        https://git.kernel.org/tip/ddd9120983c3efbcaa3a4c7777da1440f8ce27d8
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Thu, 11 Apr 2024 16:08:00 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 May 2024 00:04:47 +02:00

rust: time: doc: Add missing C header links

The definitions related to jiffies are at linux/jiffies.h, and the
definitions related to ktime_t are at linux/ktime.h, since
`kernel::time` provides the functionality dealing with jiffies and
ktime_t, it makes sense to add links to them from Rust's time module.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://lore.kernel.org/r/20240411230801.1504496-2-boqun.feng@gmail.com

---
 rust/kernel/time.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 6811d5c..e3bb5e8 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -4,6 +4,9 @@
 //!
 //! This module contains the kernel APIs related to time and timers that
 //! have been ported or wrapped for usage by Rust code in the kernel.
+//!
+//! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
+//! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
 /// The number of nanoseconds per millisecond.
 pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;

