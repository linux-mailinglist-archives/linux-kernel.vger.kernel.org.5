Return-Path: <linux-kernel+bounces-63814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C9D8534CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F681C22942
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A33D5F865;
	Tue, 13 Feb 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yOJUExvk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LaO30LZW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720735F847;
	Tue, 13 Feb 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838562; cv=none; b=Oo/UBrQFIRLQQVVd4Z5ykH4EsU1mA9qEgunDPa0t8I3ULatmJ7JtjNbr3iWydAFIGH5yaz+vhdTnvoivKjOXOHY7rtffNBwB6aLOXCB0Hfiv3PNw2Dz0d74XOwt7GeGKFSrcQg593CIFJ7rF22SFAsdsw6vYZdlJ7uiYt6tL+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838562; c=relaxed/simple;
	bh=M0jJHh1BuDjl82V5lMEXCO2eAecuSsYLY3XSQfcrJ70=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gi6q1e6Rtpg8GgaeuRmpv0ADvAzazpIagmwF99LSvT44VVQ9I7ZMqTymhOvIad4sRX9MpOlvQAuQtrtTjq0ARjbOZzlTxrf674fVAagQEDX2/HX89z9T1Ebq+7C0CkqrFrbR6VEo54Iozd+ua1RsA93PNyuhArs15O1tAn863/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yOJUExvk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LaO30LZW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 15:35:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707838559;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GcR9hvL1CX0aruis7esP8PW843z4Ww57swVAevIUlHU=;
	b=yOJUExvkl9XcmSg8WD7FonyI07gs7U4zzLvheYLNp25egHiLHi0clgQlR0o/kxMRsOZTbb
	zch+2uXWmnUg47DMo4SdWQcOCicYMVuCNuaCzgJTPXEdSsJWNTGzTxuJ4tvSfWfJBEHn4q
	Xc11IxxjQ1eOc+jwGiBettYx/G22xFBumDamItahj3g6Sha4TzAn6fQixfZrAK85U0HYVX
	un617e0RvqHd6LaRG1e4d4SiCe14jG/ZDWPtEGcpcmHWUJMW94Xx7ua4jIMxm9LX1GVWc9
	HC/k2gNhzosYTdxIFR5cPGFYM/gukdo+I/BcVP96fubyc/M9qdPIhDhOukxkSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707838559;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GcR9hvL1CX0aruis7esP8PW843z4Ww57swVAevIUlHU=;
	b=LaO30LZW9o7rT4PehZkgKfkhW5may1mhwAKC/W/QAn2/xR8IXDSELPxFVznncWkS8YopKb
	8vk4MiX7zT6Z55Ag==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Optimize optimize_nops()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240130105941.19707-4-bp@alien8.de>
References: <20240130105941.19707-4-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170783855882.398.12172953906300246762.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     f7045230fa2933bf3b38c9c92b5ba46486ef33f9
Gitweb:        https://git.kernel.org/tip/f7045230fa2933bf3b38c9c92b5ba46486ef33f9
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 30 Jan 2024 11:59:40 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 Feb 2024 16:26:56 +01:00

x86/alternatives: Optimize optimize_nops()

Return early if NOPs have already been optimized.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240130105941.19707-4-bp@alien8.de
---
 arch/x86/kernel/alternative.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index cdbece3..1ceaaab 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -233,6 +233,10 @@ static void __init_or_module noinline optimize_nops(const u8 * const instr, u8 *
 		if (insn_is_nop(&insn)) {
 			int nop = i;
 
+			/* Has the NOP already been optimized? */
+			if (i + insn.length == len)
+				return;
+
 			next = skip_nops(buf, next, len);
 
 			add_nop(buf + nop, next - nop);

