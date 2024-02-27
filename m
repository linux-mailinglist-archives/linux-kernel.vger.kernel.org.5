Return-Path: <linux-kernel+bounces-84014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A919C86A15B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A982285708
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C1914EFE1;
	Tue, 27 Feb 2024 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0dmzrqdT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cAvb9J+M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A114E2CB;
	Tue, 27 Feb 2024 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709068243; cv=none; b=EtvaKEsh2vHLy6l7abWeS5GfmjnIZ/25ckNaUu/g4Iyr/7/2U2mQ/jA9tgV4jDfunaw2t4SKyJtjsM5bQBQD5fLngor71oOhQfhs96vlSp0ZW62IdemRrZxgtGk5OV32EqfnTdg8UU8u7NmI6HhnMI2X3iA3T+6pE79Dmouye0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709068243; c=relaxed/simple;
	bh=S4GdbO49TODBoF2qIft6qhlyqP1y99edZKcPkvMCGcY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VLH70taiSnABjSc4CWze6UdWXbRlSX3sNQ2tcpr8N8vXNLPxA8WzOn9VU2S6jS0h2rtegUyEu5RWER9epDFSbGSCDtyf/9PgXoOXmeibgr9YJ/0D24awK4hCCF/EHOQLeO/KP9B09YdQRD81mg9r/IZrlyRpDMk6G3VccxzQrxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0dmzrqdT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cAvb9J+M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 21:10:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709068239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9XQzuPcg4Z8FBC2oPdLLw3y5A64T8oxe7MO93WVZuQ=;
	b=0dmzrqdTyrcsqCfaIEniw09bfP2BMYv+8VoLAKwGSMYV2XklrBVU94yZBoAClnrVKeXksy
	NQn2NmmtECWxUmC7xmZSu9kUcKr2Eh9pORkcI7zqGjDspVL3gu5ZHUE6xrsaY4s2h9OT3t
	Bx+/AZkbhe0SRLpGSevlZQOL01W3AWFYAY/VZamCAPzTE40jvTh+/90Tn0eLmbmz22GZYJ
	G4JyBiFGwzghJ6qY/RIgwmQy3BRNKwhbGAKp5lx88beUK/JSm+hRdmv3h4EtCntZV0Rkmo
	xt4AWS04hU1iEJAqtUq4dTApuM7WOVS6g32+AAohD2Ho8QvTRYgCXI4SIgssxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709068239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9XQzuPcg4Z8FBC2oPdLLw3y5A64T8oxe7MO93WVZuQ=;
	b=cAvb9J+Msk+982e0k2HzztE3wszc/0OOLj6BypBZVSq6PT2eiNPXyEm1Y8yA3e1WHs8Y/+
	N/D13G6ii5b43kCQ==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/nmi: Remove an unnecessary IS_ENABLED(CONFIG_SMP)
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240201094604.3918141-1-xin@zytor.com>
References: <20240201094604.3918141-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170906823829.398.9069313978857543037.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     47403a4b49767f1d533e4dc5f5cf5cc957f22a5e
Gitweb:        https://git.kernel.org/tip/47403a4b49767f1d533e4dc5f5cf5cc957f22a5e
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Thu, 01 Feb 2024 01:46:04 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 22:00:50 +01:00

x86/nmi: Remove an unnecessary IS_ENABLED(CONFIG_SMP)

IS_ENABLED(CONFIG_SMP) is unnecessary here: smp_processor_id() should
always return zero on UP, and arch_cpu_is_offline() reduces to
!(cpu == 0), so this is a statically false condition on UP.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240201094604.3918141-1-xin@zytor.com

---
 arch/x86/kernel/nmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 17e955a..44fe569 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -502,7 +502,7 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 	if (IS_ENABLED(CONFIG_NMI_CHECK_CPU))
 		raw_atomic_long_inc(&nsp->idt_calls);
 
-	if (IS_ENABLED(CONFIG_SMP) && arch_cpu_is_offline(smp_processor_id())) {
+	if (arch_cpu_is_offline(smp_processor_id())) {
 		if (microcode_nmi_handler_enabled())
 			microcode_offline_nmi_handler();
 		return;

