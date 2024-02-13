Return-Path: <linux-kernel+bounces-63282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B595852D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58288282C6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35365364BD;
	Tue, 13 Feb 2024 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C0FgHTg+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YW9SSPF1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C647A2C689;
	Tue, 13 Feb 2024 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818223; cv=none; b=Y/Vs7T59cjPaN4+YmAFM43iivsRMcCVnQFm0mz54WupRjoZyAsQEcXJcGoBstEvi4rRuk2/WvuTL6C97STMH56QWdW1ntd7hAabWoBZNE8kfnHEXUfwnNj1vPk8lvT0rf5X0nT3nYPfmbVHpNBHky7JrZpsO+G/4yni4LUNNppg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818223; c=relaxed/simple;
	bh=mTaDyVMtRZwxa9j2lHhhogsZ7zwCVB9IpyeNRMzoUr0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=txnrAmDG3nbA4bWPvrq6nuLxgWcRUTQdgBOLgkJOSNX1028nNZ0oZkHJApsJ0JldEbikBmL4S1qhRXyFp9W3/mgMTVxgxhnJ3TtUWbpc0SnYsNl5r/T/Lm9sEdvhDfZgRD7mLKmjxjCnO6L14lM4LNaQHC1FoAGP1VFRLSZWrwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C0FgHTg+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YW9SSPF1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 09:56:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707818219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTerp5HT+idSBqJrLaS8vYAD0Y7JjuxhMyXb9HEVw28=;
	b=C0FgHTg+ZP+8PYYc4GGQUku5NsLqQHER8qUANLJn3IyRFSf1RjqkGLy33sg+wcwQ8FO75M
	7FjF7al0g2vOJe/sv3UqZ1pts8LoAyPsViNt6zq17QiJfZ2uRkbOwwRlj+upivY3INgxVw
	d7UTrBM0LmSchEMn9w41na9rQaeP7CP6ovPP4OFD1Ur7E6GjWPAOJdjn2qzkCyn0ftL05h
	7MGy9bCWEg6JOHHlN2hSPUgntvFhdKg056VY+Goqesf3T+hS0Iv1J7WUdhzQtBlUmGuRnp
	sXpc5VIVB67GKkQMNFPJHeb7yEIqmvupPas+3LHKb035+UIzkl46VyR0kvgdRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707818219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTerp5HT+idSBqJrLaS8vYAD0Y7JjuxhMyXb9HEVw28=;
	b=YW9SSPF1RC56iIkZdLFgFAU7OqFgqqLXyiu7QElYyh+J3mx3l04Q1CNS+RqGG8A7de3t79
	IxrelQzehv4QpuDw==
From: "tip-bot2 for Erick Archer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/bcm-6345-l1: Prefer struct_size)_ over open
 coded arithmetic
Cc: Erick Archer <erick.archer@gmx.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240209181600.9472-1-erick.archer@gmx.com>
References: <20240209181600.9472-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170781821908.398.371290728146239013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     004c7a6bf43edbd4b092fb6ebba8991d56bc3428
Gitweb:        https://git.kernel.org/tip/004c7a6bf43edbd4b092fb6ebba8991d56bc3428
Author:        Erick Archer <erick.archer@gmx.com>
AuthorDate:    Fri, 09 Feb 2024 19:16:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Feb 2024 10:53:15 +01:00

irqchip/bcm-6345-l1: Prefer struct_size)_ over open coded arithmetic

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows.

The cpu variable is a pointer to "struct bcm6345_l1_cpu" and this structure
ends in a flexible array:

struct bcm6345_l1_cpu {
	[...]
	u32	enable_cache[];
};

The preferred way in the kernel is to use the struct_size() helper to do
the arithmetic instead of the argument "size + count * size" in the
kzalloc() function.

This way, the code is more readable and safer.

Signed-off-by: Erick Archer <erick.archer@gmx.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/20240209181600.9472-1-erick.archer@gmx.com
Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/162 [2]

---
 drivers/irqchip/irq-bcm6345-l1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index 9745a11..eb02d20 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -242,7 +242,7 @@ static int __init bcm6345_l1_init_one(struct device_node *dn,
 	else if (intc->n_words != n_words)
 		return -EINVAL;
 
-	cpu = intc->cpus[idx] = kzalloc(sizeof(*cpu) + n_words * sizeof(u32),
+	cpu = intc->cpus[idx] = kzalloc(struct_size(cpu, enable_cache, n_words),
 					GFP_KERNEL);
 	if (!cpu)
 		return -ENOMEM;

