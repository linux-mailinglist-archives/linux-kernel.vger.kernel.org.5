Return-Path: <linux-kernel+bounces-83695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C58D869D67
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60AA1B260E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D12E13A273;
	Tue, 27 Feb 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TgekRlJa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6OR3LJuY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8644E1D6;
	Tue, 27 Feb 2024 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054513; cv=none; b=A6WgE0k/OAYGAUu35C+voDQKhZab4rJR7hWcMDIZvtTGhco99I1+ohWF2zM4Yc33iey0Z5XABW3Khv3deOqhyXL/DLKt5dELEMV4XQeYNu0G0KsA2XzMQluWQoolwjKzVi/Zrr8jeX68Q4cW3Fy9MtCmSWSArhQNnQ+R0oWue8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054513; c=relaxed/simple;
	bh=CxxghjzhKMU/aBLaHQZTc1NhUcFMMP7dKr/NX9ASjtM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LzbsDQ50VUPL/3SAQYED1qfyq93oIpjsQrH86f5TMXhGGB+v2AlQQ1Zq/wX2HjOnkTSx4EsYGQog9NmkysbPmQEkJZm5GKzEDnKpnuhHMGIcJKIVIt4bw2MQ7e8rZ27ZlXJo81qGi4Fn3GHs+PIAZQ6SzwqzTekx1C3OlJD+GWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TgekRlJa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6OR3LJuY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Feb 2024 17:21:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709054510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fr7mcPdFCNDIQFg411hI8iEk1/OnCDyhOTf5daRsrtY=;
	b=TgekRlJa3K5wfCyEBgeRBoMleaUUabQtXFF5CPSnZjcFHAHddQhXeT0E3COqwfSMXwEY/D
	95Kc8nTQQkWnc0LE26yOV4xqxVExIOtwCJbsxJ7aXs4qYhvKCei+T6IXUZgIl1HYgNki+A
	c/f2ujxZgD7Mu9YE0caKP7ttImapP7gw5Qoo9xJLPnOxSnNxl3+/CxHjSYcaA5BDjRhD0t
	OFvrbdgE0L+m9oWLr1Y+vB9frCo2MdGcJZnem1L9eOGmIqC6lHBcaq1DUXkjdZfzxutbjc
	L2f/qHTFhA6jbQ5mEcp0Mc/E33D0abXn9Ytj2iWG2FKvj4LmrKQMoH+IW0fJCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709054510;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fr7mcPdFCNDIQFg411hI8iEk1/OnCDyhOTf5daRsrtY=;
	b=6OR3LJuYKoJsB3r/S5THCj/7YaBzlVbTx+6/5TSdsIu4CI774tMlEX8SZm8+i3HvK6r0Xv
	nt0NU2z2y6+mVrAg==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/renesas-intc-irqpin: Convert to
 platform_driver::remove_new() callback
Cc: u.kleine-koenig@pengutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C6dc03cf63382d24f954c167aaa988f8e31d6b89d=2E17032?=
 =?utf-8?q?84359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3C6dc03cf63382d24f954c167aaa988f8e31d6b89d=2E170328?=
 =?utf-8?q?4359=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170905450978.398.7222065170643278037.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     be5476f6658ac4cc562b4c4ea4c90acd18ee7a29
Gitweb:        https://git.kernel.org/tip/be5476f6658ac4cc562b4c4ea4c90acd18e=
e7a29
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Fri, 22 Dec 2023 23:50:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Feb 2024 18:12:10 +01:00

irqchip/renesas-intc-irqpin: Convert to platform_driver::remove_new() callback

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/6dc03cf63382d24f954c167aaa988f8e31d6b89d.1703=
284359.git.u.kleine-koenig@pengutronix.de

---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-=
renesas-intc-irqpin.c
index fa19585..9ad3723 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -561,14 +561,13 @@ err0:
 	return ret;
 }
=20
-static int intc_irqpin_remove(struct platform_device *pdev)
+static void intc_irqpin_remove(struct platform_device *pdev)
 {
 	struct intc_irqpin_priv *p =3D platform_get_drvdata(pdev);
=20
 	irq_domain_remove(p->irq_domain);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
=20
 static int __maybe_unused intc_irqpin_suspend(struct device *dev)
@@ -585,11 +584,11 @@ static SIMPLE_DEV_PM_OPS(intc_irqpin_pm_ops, intc_irqpi=
n_suspend, NULL);
=20
 static struct platform_driver intc_irqpin_device_driver =3D {
 	.probe		=3D intc_irqpin_probe,
-	.remove		=3D intc_irqpin_remove,
+	.remove_new	=3D intc_irqpin_remove,
 	.driver		=3D {
-		.name	=3D "renesas_intc_irqpin",
-		.of_match_table =3D intc_irqpin_dt_ids,
-		.pm	=3D &intc_irqpin_pm_ops,
+		.name		=3D "renesas_intc_irqpin",
+		.of_match_table	=3D intc_irqpin_dt_ids,
+		.pm		=3D &intc_irqpin_pm_ops,
 	}
 };
=20

