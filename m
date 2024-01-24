Return-Path: <linux-kernel+bounces-37521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 037BB83B13E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E681F2501D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7255131E4B;
	Wed, 24 Jan 2024 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LXHwFYwF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MKXd64+n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F157131728;
	Wed, 24 Jan 2024 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121325; cv=none; b=qdi5qhwjSilHAjkX2+amJ0OuU9dH6z6NcPi29mmnZhUFZKSpj4IVFNOku0y11uPIGkKj/E6KeLQkwdT9DG1++09ZUVys+cHs/nSSeWyYVt7trNd0WB0Sg/k74PUPEAqhlNhNKoo0gx7sQt73z+nTWf4MYDAx42P8qCwwlK06wpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121325; c=relaxed/simple;
	bh=t/SDAdtQsUVJ2+bCF1Iita5JWi+Ctt7SsR2X2lNgxGI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bIkpBNa4meyzLj6J8liEb079qaBPyr1B526QoWA/1nNsMnwa7iQdWh6F6PptF1bK7PKD3PHN97bcpYX1oqOgtCJuo3iNGdVwMeBM6fRqeQuOjk5VC6GCk1gXAfQr2fs/dzbLrGQNqTMMo8Lcl6boUNSC8uGcg8zc4Rl4oNRnf8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LXHwFYwF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MKXd64+n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Jan 2024 18:35:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706121321;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOprUGS9zKn8QM34ojdM+ZY2ATHviEv2z/2ZMLoiCis=;
	b=LXHwFYwFZkLeCSnN2NGheb5HJhmox8wd4ZH0HqIcClL8cXprfWOOY57wadqUGTZfoZ+TBK
	zZTsKYW8ZlmrEMKw+A3p1B4zCVx9NpedO3V6+lQCPfn6VLrU7pdwhsvds2OelD+Ue/L2Wb
	DbDsTIJdgMnl1x6IYKZqLQT4k2fVodKiS2UI0kjcLEW+DuNdswdk+HV4ko1KVIaRaXq4jM
	BaacsGY5qV3vRTMxUvzLcUcRyONyAZHF3qeVqSiSBdvMJEffOHd2frGevWK7Y0UphJTtmB
	B92bzC64PKi+I8Bdbc53b/a8F/HaalJ6eNp8gRoHfOeBW0a7jG2MhLY5LphqDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706121321;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOprUGS9zKn8QM34ojdM+ZY2ATHviEv2z/2ZMLoiCis=;
	b=MKXd64+nsUK2wnu4UlSRgWWsbneQ1gJH/TuzupfcYXTrRFxEBZYt2OaXgBvXTCBMvYL000
	c0EyzNaoOekNOtDA==
From: "tip-bot2 for Dawei Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Initialize resend_node hlist for all
 interrupt descriptors
Cc: Dawei Li <dawei.li@shingroup.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240122085716.2999875-5-dawei.li@shingroup.cn>
References: <20240122085716.2999875-5-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170612132097.398.7552255144385279476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b184c8c2889ceef0a137c7d0567ef9fe3d92276e
Gitweb:        https://git.kernel.org/tip/b184c8c2889ceef0a137c7d0567ef9fe3d92276e
Author:        Dawei Li <dawei.li@shingroup.cn>
AuthorDate:    Mon, 22 Jan 2024 16:57:15 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Jan 2024 14:15:41 +01:00

genirq: Initialize resend_node hlist for all interrupt descriptors

For a CONFIG_SPARSE_IRQ=n kernel, early_irq_init() is supposed to
initialize all interrupt descriptors.

It does except for irq_desc::resend_node, which ia only initialized for the
first descriptor.

Use the indexed decriptor and not the base pointer to address that.

Fixes: bc06a9e08742 ("genirq: Use hlist for managing resend handlers")
Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240122085716.2999875-5-dawei.li@shingroup.cn


---
 kernel/irq/irqdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 27ca1c8..371eb17 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -600,7 +600,7 @@ int __init early_irq_init(void)
 		mutex_init(&desc[i].request_mutex);
 		init_waitqueue_head(&desc[i].wait_for_threads);
 		desc_set_defaults(i, &desc[i], node, NULL, NULL);
-		irq_resend_init(desc);
+		irq_resend_init(&desc[i]);
 	}
 	return arch_early_irq_init();
 }

