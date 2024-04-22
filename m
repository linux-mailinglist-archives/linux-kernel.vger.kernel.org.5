Return-Path: <linux-kernel+bounces-154114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88548AD77F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE551C2125A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16DF3FBA0;
	Mon, 22 Apr 2024 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mcl2yEv3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tCqmYhug"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE88C46426;
	Mon, 22 Apr 2024 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825921; cv=none; b=DnA6fL55mXhHF9ZkMb5603ldd8Ht3NrKYp8Jb4iEutzNevb6tZ5NbljQwwhh0WNOmnrRFDpOpbg6qsv4jLfUDtsfGge9xs6J6oRdvrh+tjwsHbML9i7UkbacMfB4AhzchncPr57pZqorE3rvJRHwj/0KCjP8yo9rKzbUckEs/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825921; c=relaxed/simple;
	bh=MGqxo6d8S54Nvvu5L9y9y8JcOVm0Ixw81K2mWytQNbE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=X+dEM7I0xwAgn83cWPKR8LQMDshNkdq3EyEuzCyJJBP2Bkw/UnFDaUdU0G9MyJOdUOE4Sx8A7vzYnlLtiIlS99wpcimihIJ/eQCNEwDOjDkig6JyC79Oqz6bWLfG8HFUZ+Wb75CdkLqKFlfLdZGRqTMzTkdf/Q02xlPGCOVmQ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mcl2yEv3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tCqmYhug; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Apr 2024 22:45:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713825917;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=R7dp22zxi/1YUwMjyG2rKTOlRkEvm4wGYwTJPAlouck=;
	b=mcl2yEv3MGlseSfLZplWW4hib3eFs3NLBlhafERp56mO9ANT8ulWzX5W/lDEJNkuEBCI9q
	Ff9cOEW8pvFID/hhR1bSIMq4qRFXV7h4jJ+KewaXAlz0FyYQx8XFVSOQYLWvHPWBX+UJcu
	pekNnnkgXz+MN48Oe1HVQge6wEqCjv6NT9IZKpgQC9XnzpMkVp5zO7bhKUxLE/fXQBvXUT
	8/Opsu3c6YyBa6550y99EdKDtFFcffnp64Bga7GnwIOytMEzqdNZrY/2KVB7axzWrsodSH
	9tAHfyJiVAC/e48uIzD+9ZfJlNZJmutwE/882dcFj+PcdkaW6NyNCsfXtEeHXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713825917;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=R7dp22zxi/1YUwMjyG2rKTOlRkEvm4wGYwTJPAlouck=;
	b=tCqmYhugmJ+OUNyIy7n+aDDS3eL5fuXLxGOLBMGTlFvsED1ZVzdOwlJc/jUfH93R+8lYpn
	iMlffpeK2R4djvCg==
From: "tip-bot2 for Stefan Wahren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/mxs: Declare icoll_handle_irq() as static
Cc: Stefan Wahren <wahrenst@gmx.net>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171382591676.10875.6030222427579713101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8371696a975a52eb055dcf36ac1e562bfda493cc
Gitweb:        https://git.kernel.org/tip/8371696a975a52eb055dcf36ac1e562bfda493cc
Author:        Stefan Wahren <wahrenst@gmx.net>
AuthorDate:    Fri, 12 Apr 2024 23:53:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 23 Apr 2024 00:28:14 +02:00

irqchip/mxs: Declare icoll_handle_irq() as static

After commit 5bb578a0c1b8 ("ARM: 9298/1: Drop custom mdesc->handle_irq()")
the function icoll_handle_irq() is only used within irq-mxs.c.  So declare
it as static to fix the warning about a missing prototype when building
with W=1.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index be96806..d67b5da 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -130,7 +130,7 @@ static struct irq_chip asm9260_icoll_chip = {
 		 IRQCHIP_SKIP_SET_WAKE,
 };
 
-asmlinkage void __exception_irq_entry icoll_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry icoll_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
 

