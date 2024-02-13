Return-Path: <linux-kernel+bounces-63203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 245B5852C48
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F750B23D32
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7639225A4;
	Tue, 13 Feb 2024 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ydy0EgoC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P/SS7Urd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9801755C;
	Tue, 13 Feb 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816693; cv=none; b=KzuaKBqJGi9PpZxNr7+tAIA2HkjHC4XGN8mf0hpwtMAf/7fJ696Qj+1AEmJ8S2zUl8lCW6ikeRqUVhN7JI/UJ2d2ZMBHzcR3EhLaBTQgizkvOq1wtPvzd0psSZ9uHbJlBpqGEdbK58SiSNsI1xvnUNjHD+9mZWn6YHuI7MVlyCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816693; c=relaxed/simple;
	bh=s2RfzRg7gU4z0m5YqtLCPpWakTha0o03sv66MfunOb8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LHyZY1b9H3/kybTbCQ6g7/Cx3N7bKpcCft/0YuMs/r5KVUl8qxxdE41dbzR7xVlsPPYfrtMWlhdEXNFh2RN2rDLNqKttFtKQpY5zVD1I3wWs9P/b4/JIej7nwFZkubrALLaDnMKCtKsR3vvPkIv9/h1DCFAQ3zgz+g3CAmP0t+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ydy0EgoC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P/SS7Urd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 09:31:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707816689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSw1AsCmUhErrFt6VpEvcbmC0TKHggFh8fbZdrLCHV0=;
	b=Ydy0EgoCqxYqqNM3KY4hxYd42DGyzIkdSS+ZlswAZTjEoZk4XplQyvtrT11DWk9Rr0Luxg
	i+kRxC+euCFxaYkr5Y+J06bZ75wm9mSjExi+WAalga86jihHaxSubQ3Mlp8kp53o5slITk
	YTLwYJeENPS3akTXoYxeJjF+ZGnHgEiC8nf5claEsHfKjAxDzvgTkjeJ4+DmsECr6hMO3D
	WZoN3KxOBf9g0h1RCC1Wf9XknkAC+l2fPmzk4pmpEjcuUNfsoyDTDgFu7i5ugl9pWgRyqL
	ovJ35f+g4mOgU62NKSr4/Qrz71izDeEunT6fXTFl+514GF5PmVkaaDbJ0BMTCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707816689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSw1AsCmUhErrFt6VpEvcbmC0TKHggFh8fbZdrLCHV0=;
	b=P/SS7UrdCA2j0Wl/3HX8qsaek4DTPEziYD3cDgLhq6VHqrsthda75f1dhB0diCMZ+kwE0s
	mdbWXMYwvqCZ0rAw==
From: "tip-bot2 for Bibo Mao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/loongson-eiointc: Use correct struct type
 in eiointc_domain_alloc()
Cc: Bibo Mao <maobibo@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Huacai Chen <chenhuacai@loongson.cn>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240130082722.2912576-2-maobibo@loongson.cn>
References: <20240130082722.2912576-2-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170781668902.398.16211929501605584217.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     f1c2765c6afcd1f71f76ed8c9bf94acedab4cecb
Gitweb:        https://git.kernel.org/tip/f1c2765c6afcd1f71f76ed8c9bf94acedab4cecb
Author:        Bibo Mao <maobibo@loongson.cn>
AuthorDate:    Tue, 30 Jan 2024 16:27:20 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Feb 2024 10:26:15 +01:00

irqchip/loongson-eiointc: Use correct struct type in eiointc_domain_alloc()

eiointc_domain_alloc() uses struct eiointc, which is not defined, for a
pointer. Older compilers treat that as a forward declaration and due to
assignment of a void pointer there is no warning emitted. As the variable
is then handed in as a void pointer argument to irq_domain_set_info() the
code is functional.

Use struct eiointc_priv instead.

[ tglx: Rewrote changelog ]

Fixes: dd281e1a1a93 ("irqchip: Add Loongson Extended I/O interrupt controller support")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Link: https://lore.kernel.org/r/20240130082722.2912576-2-maobibo@loongson.cn
---
 drivers/irqchip/irq-loongson-eiointc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 1623cd7..b3736bd 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -241,7 +241,7 @@ static int eiointc_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	int ret;
 	unsigned int i, type;
 	unsigned long hwirq = 0;
-	struct eiointc *priv = domain->host_data;
+	struct eiointc_priv *priv = domain->host_data;
 
 	ret = irq_domain_translate_onecell(domain, arg, &hwirq, &type);
 	if (ret)

