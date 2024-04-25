Return-Path: <linux-kernel+bounces-158541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 880508B21DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3EFAB21738
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F8B1494D3;
	Thu, 25 Apr 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="teygzRyc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zEe+3NXf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5A71494BC;
	Thu, 25 Apr 2024 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049212; cv=none; b=MI3QcGp8etPHj/Ot+SzrE+HtF3ufoExrXH2tCHmPCuB3lC9yUQrvfC0Rkz1n5KIpkygg69g9A9gxKiP2sJEdSlLeDtxPfbANJ70O3aWzB1o/WqaUFHGOPjnYJCeqVM+OrzwxzPKtC4/o2iu8s5d6Ns/4F9a+cCF5/CFR7bN1d/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049212; c=relaxed/simple;
	bh=J/Z3SHdqPZtbUOyL9ZHiIg5YILYMIAg4ajSMNaH57E0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V5Vjp85AtEL0chTFFJg4E6gscyTGFY76fZRhIkVs5Nw0wwYGj9uFAWo5qKVdxnZOPHd2iYWdTN2bRxzjMqgNrYr6Y+rh/qBnS1QVHv5AYBrLlBJxFh756JpgDwYiZMY7CDNitx183xYxUcQn8pBr3dkovBC5fb5mUHIOsWClw6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=teygzRyc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zEe+3NXf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Apr 2024 12:46:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714049209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ga2NkwqsOM7kwwxlGdzjoHJHg6hep5Mj7xEr6EIAJqQ=;
	b=teygzRycPyoAAZu0zK09LCzrnd6AC0Kc1QhN2PLZVhcH2po/I/Vj0wvbGal9YOAys5yc68
	vGDRa2yPVvbJ826oIjV5HxUrTT6zJuWtf8lUPPEGPKyiP5+Hkvghqbac2pxHYj1HJWO5un
	H0l9TLXkc4sEFgmAZCHUIXwLe3thIY56gGbspHPWydLc0IzO3FNfyhEGYLCZv0O+OnnsWa
	+aEyxEtbKj9wGliZhAS6cDLnbUlYYgLUINE5WPX4EwMR7eYSD+tzZXmmI+B8xKfSwNgXRu
	3U7pgcRcPw70CEplQ9RGYKH/Eh29VP9FE4GTMveLOYLdROfyaB3jL2LR0EObaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714049209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ga2NkwqsOM7kwwxlGdzjoHJHg6hep5Mj7xEr6EIAJqQ=;
	b=zEe+3NXfAdqmfQd6tEEe2lvP1PYkXu9yMntk0wPCgOvmrmfQVqUbg7SMRuh4+dS51X3KGV
	xdWWibmoI3QnTpBw==
From: "tip-bot2 for Guanrui Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3-its: Prevent double free on error
Cc: Guanrui Huang <guanrui.huang@linux.alibaba.com>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240418061053.96803-2-guanrui.huang@linux.alibaba.com>
References: <20240418061053.96803-2-guanrui.huang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171404920906.10875.16509237626955836035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     c26591afd33adce296c022e3480dea4282b7ef91
Gitweb:        https://git.kernel.org/tip/c26591afd33adce296c022e3480dea4282b7ef91
Author:        Guanrui Huang <guanrui.huang@linux.alibaba.com>
AuthorDate:    Thu, 18 Apr 2024 14:10:52 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Apr 2024 14:30:46 +02:00

irqchip/gic-v3-its: Prevent double free on error

The error handling path in its_vpe_irq_domain_alloc() causes a double free
when its_vpe_init() fails after successfully allocating at least one
interrupt. This happens because its_vpe_irq_domain_free() frees the
interrupts along with the area bitmap and the vprop_page and
its_vpe_irq_domain_alloc() subsequently frees the area bitmap and the
vprop_page again.

Fix this by unconditionally invoking its_vpe_irq_domain_free() which
handles all cases correctly and by removing the bitmap/vprop_page freeing
from its_vpe_irq_domain_alloc().

[ tglx: Massaged change log ]

Fixes: 7d75bbb4bc1a ("irqchip/gic-v3-its: Add VPE irq domain allocation/teardown")
Signed-off-by: Guanrui Huang <guanrui.huang@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240418061053.96803-2-guanrui.huang@linux.alibaba.com
---
 drivers/irqchip/irq-gic-v3-its.c |  9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2a537cb..5f7d3db 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4567,13 +4567,8 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 		irqd_set_resend_when_in_progress(irq_get_irq_data(virq + i));
 	}
 
-	if (err) {
-		if (i > 0)
-			its_vpe_irq_domain_free(domain, virq, i);
-
-		its_lpi_free(bitmap, base, nr_ids);
-		its_free_prop_table(vprop_page);
-	}
+	if (err)
+		its_vpe_irq_domain_free(domain, virq, i);
 
 	return err;
 }

