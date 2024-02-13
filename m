Return-Path: <linux-kernel+bounces-63281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0DD852D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 425E5B2881A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF3A2F844;
	Tue, 13 Feb 2024 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QeaZpDFb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ikVticnI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052842C696;
	Tue, 13 Feb 2024 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818222; cv=none; b=si6w3S7GohnobJLpZgmSgTqUHnEY+JWWJKrdxOlqytjyrighDQNfCwUsPC53nWXZOaVgCMbPnuP54oSi2kzh4HQ7v3AwdImtG8CqphteiJdi84qYzKt/ZIdsKPkAqSznhzwKhlxTGYFhtYPxZKUGz0pSyRZaSI/z/q9ZzdvuNWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818222; c=relaxed/simple;
	bh=vgkj6KV2Y4r+474+FZqCSyvxmZHXesxk5ZhG4T/ProQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B+EhD20fPMeu3FU1Jod/1rQjl6PBy6rWebioz+MSQaZKoJ57hZ7rhCHzFeANXWpFlvCMNxs24mpaGv89rxlcAwE6lUJDOOsTYpSE2jC+LJycl1mm9S0MZiGlFuyh446RaNBZfgWUdJzt7VNo/Ip2B8pEwL2jeoQfjMKfIzHQ3tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QeaZpDFb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ikVticnI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 09:56:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707818219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+jwA3oXvpSN85iZlJby7bd/JQsFHKO7U5l3GD72xEA=;
	b=QeaZpDFbvD7hY2JNpL0RK/U1jcrVzyj/Cy4wr5+pu6NOG7Zi/guCOEDJQEf60Ql0RNvkXv
	yaor60uAy7pCchjzaAqjfY4KjjPR1adJAkTLn1+OG+NkTYu/lh6oUhql/pZYI7rPeu9ppR
	ZtNxD2DZx3iOwl8F42jyr3NpGs6uE1awMTzfFuLA/UkcS2MPEo/V3I8462i7rozn9sYIeg
	o//LZBWeaD6KAX7dolm/isFjuV9tuxTAbti9Hiko13eD6G+QbxEHzvIL7j6L8Wv9Nz1xhs
	sp4rwRr/cpHraNrsxWNyE/uUr9yDAgvP9DUA/pU7xgHwUibU1EJ2iHnpseuOVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707818219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+jwA3oXvpSN85iZlJby7bd/JQsFHKO7U5l3GD72xEA=;
	b=ikVticnI/9bDKQgHv2Rs8yhZm15HGvkAqwswfR6FVTJStD1onn/gSPAjGnB1b2RwdDzGLD
	vdEbfUMdUo63l+Bw==
From: "tip-bot2 for Erick Archer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/irq-bcm7038-l1: Prefer struct_size over open
 coded arithmetic
Cc: Erick Archer <erick.archer@gmx.com>, Thomas Gleixner <tglx@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240209183128.10273-1-erick.archer@gmx.com>
References: <20240209183128.10273-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170781821801.398.2076672398162570672.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e955a71f83598a347eb45af5576e7eb6cb5bf285
Gitweb:        https://git.kernel.org/tip/e955a71f83598a347eb45af5576e7eb6cb5bf285
Author:        Erick Archer <erick.archer@gmx.com>
AuthorDate:    Fri, 09 Feb 2024 19:31:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Feb 2024 10:53:15 +01:00

irqchip/irq-bcm7038-l1: Prefer struct_size over open coded arithmetic

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows.

The cpu variable is a pointer to "struct bcm7038_l1_cpu" and this structure
ends in a flexible array:

struct bcm7038_l1_cpu {
	void __iomem	*map_base;
	u32		mask_cache[];
};

The preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the argument "size + count * size" in the
kzalloc() function.

This way, the code is more readable and more safer.

Signed-off-by: Erick Archer <erick.archer@gmx.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/20240209183128.10273-1-erick.archer@gmx.com
Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/162 [2]
---
 drivers/irqchip/irq-bcm7038-l1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 24ca1d6..36e71af 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -249,7 +249,7 @@ static int __init bcm7038_l1_init_one(struct device_node *dn,
 		return -EINVAL;
 	}
 
-	cpu = intc->cpus[idx] = kzalloc(sizeof(*cpu) + n_words * sizeof(u32),
+	cpu = intc->cpus[idx] = kzalloc(struct_size(cpu, mask_cache, n_words),
 					GFP_KERNEL);
 	if (!cpu)
 		return -ENOMEM;

