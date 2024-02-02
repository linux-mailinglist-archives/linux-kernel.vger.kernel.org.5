Return-Path: <linux-kernel+bounces-49810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A245846FBA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD3E1C246F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530A313E22C;
	Fri,  2 Feb 2024 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="musgV2uy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ukYA/idh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734522067;
	Fri,  2 Feb 2024 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875371; cv=none; b=raFratD7yH8qxtL+12FBuQpnxcwP+ZleGMcNZF1gLF5bVaUnt/6VHdNQigZQwHaOh3dzfKOIW6zNn2a21hQ19pRU4gx1+RKe4RusFrbd7DkRoWJwzI3RtgEfPJjLQjGb5aArrfm7iKq82DLmupz4AWWg/5BBTtkUZRPZLuHVjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875371; c=relaxed/simple;
	bh=AFJjzxjeD4YjFSmCagvIUL1FjUi9wFa39yKy9kiKACY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FkR5DB7w37NNWSj7Ok0T1KpHtAHxLt90CNIZQsNPb8bt8QCL9HcP9qF36wO8CEU6+eRfD301AGayQPYkJyCGmFBc15JWuhhLcKNz62X2QtHNn9nsAgx9bUvLy3KXkGAmeQvJr7SUMxxIUvcl4POcvm9sW/ZRnA+QjlgQlcPu4nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=musgV2uy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ukYA/idh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Feb 2024 12:02:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706875362;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29beOaEY1SpMrYGpuoski+9MNzDnpiGyLXh1hJnTLNs=;
	b=musgV2uytAdgAcWjSTmYgRQgYh9i1x2/2tI4XcTIiQENBxUqJy0AwF8LKryyWrm9sAdH1k
	1vTzOdcJdTsy6jqes+wATfTtAZ5AfXQ9CZhVGrvXiad/IRfdCvhG6Cd0qSK/dYjMi4cTno
	kTxcHwTtj/sDyrfNbVAQhb9JRO2D4NOIDusJ/iejzEDNUZGZ7dIOp1yxr19k+uEiLCyVQo
	eP3CxJQK+p6XF4XyDNqE76UBhCWo7Rf0QkkdLloCEzEDtE1nNimh0+L+orVrz7xpi3IFSh
	aOBpoHiK2kXgAizJ1gTWnh5HCP9VPoch1OG1BVye+GdzlSwhc+FmjJac18C+bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706875362;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29beOaEY1SpMrYGpuoski+9MNzDnpiGyLXh1hJnTLNs=;
	b=ukYA/idh+1IZ7s92FLkzCk6ZfD/buAKVXKUjjDqPuOih9pUZnO6ChP6Md0InKEVNO6Ud5m
	CE5RqHSV18wYXKCQ==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] MAINTAINERS: Add a maintainer entry for FRED
Cc: "Xin Li (Intel)" <xin@zytor.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240131080143.3259642-1-xin@zytor.com>
References: <20240131080143.3259642-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170687536134.398.1075604734352076495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     e13841907b8fda0ae0ce1ec03684665f578416a8
Gitweb:        https://git.kernel.org/tip/e13841907b8fda0ae0ce1ec03684665f578416a8
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Wed, 31 Jan 2024 00:01:43 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 02 Feb 2024 12:51:08 +01:00

MAINTAINERS: Add a maintainer entry for FRED

Add H. Peter Anvin and myself as FRED maintainers.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://lore.kernel.org/r/20240131080143.3259642-1-xin@zytor.com
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052f..29574c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11151,6 +11151,16 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/wwan/iosm/
 
+INTEL(R) FLEXIBLE RETURN AND EVENT DELIVERY
+M:	Xin Li <xin@zytor.com>
+M:	"H. Peter Anvin" <hpa@zytor.com>
+S:	Supported
+F:	Documentation/arch/x86/x86_64/fred.rst
+F:	arch/x86/entry/entry_64_fred.S
+F:	arch/x86/entry/entry_fred.c
+F:	arch/x86/include/asm/fred.h
+F:	arch/x86/kernel/fred.c
+
 INTEL(R) TRACE HUB
 M:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
 S:	Supported

