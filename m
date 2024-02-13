Return-Path: <linux-kernel+bounces-63202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C107852C46
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A42B23A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E93224CF;
	Tue, 13 Feb 2024 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BK5pOFrw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zn02mYTB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E82231A;
	Tue, 13 Feb 2024 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816692; cv=none; b=Iu6VOeNLAZ0ZicbrOzE2qk32cuXGc9Rq/QTwiMgaQT+VoDW0aX3lQO83UCAvreCB5jiJ8d50VsWm1UZoWjf33a2fYlIhMuniBmWWd+k8PuD6EUJRNIMNps44RLhO7jBgXuVSD2/Jy1mxwfm3FHx9Fv6WUXVzGPoXuHnx5YuF9Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816692; c=relaxed/simple;
	bh=CHGCrFJ5PA85vL/JAWsDwgeeH4F9vCPEVgIeTIXnBX8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qgOerQk5FDAwsatrOQuL4F49jUoeS2QliT8RyZajNl0DQ3jtVqP1R9xDbCekmEm5KlYoj5sNFmb9AO4T91fUzxtrpUp5lCVu8Z++ptoj427Q2Ehy8Cw5W5AyQHIMa3vFTO0VPa0COeMCmL2W0JnNE0BbwAtT4fRX+vO0HYn/H9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BK5pOFrw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zn02mYTB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 09:31:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707816689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eir1V6YU7HZRiKSbryLNbiHxrZP6CWzJqukJeVvpg2s=;
	b=BK5pOFrwKTPm4pA52/vECVmC2uOcEea594XF/kCiDusGYlsiGYbgCOBDYS6m0qKT3ehwkz
	skTEeYGn+D+Hfubce4927l+GdOeOUCbkUDMFRNVlxxy+lUeUTwDqbbe4JgrT+pgRAVupve
	xPnS+mjnWYGWEZ1/R1PGyLZcaTZvNDb6X4P7buuC3nf6ZTIrEpH7g8lRiNBD5oRFZBdGan
	AwrkI4bKmZELPQV6Fg1iHE7+p5yTKtaMV+mnL9E3pWiFZrgXvsC1aLZCPwFZLUKJ2sHt47
	qznKhzk2F3Bf3QSJ7vjaNd3wMsYyvmdF5ox0gJ3T/KllsmoCSVPfO1BO1dpWaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707816689;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eir1V6YU7HZRiKSbryLNbiHxrZP6CWzJqukJeVvpg2s=;
	b=zn02mYTB9+FseiixvXJae/XKOtpNSgqugbpkMbgrKLbONmoGnTp4CNR6Sts70imbLqNP3a
	YU0X6DOF5579yIAw==
From: "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/qcom-mpm: Fix IS_ERR() vs NULL check in
 qcom_mpm_init()
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <22e1f4de-edce-4791-bd2d-2b2e98529492@moroto.mountain>
References: <22e1f4de-edce-4791-bd2d-2b2e98529492@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170781668798.398.12651232833115648939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     8ad032cc8c499af6f3289c796f411e8874b50fdb
Gitweb:        https://git.kernel.org/tip/8ad032cc8c499af6f3289c796f411e8874b50fdb
Author:        Dan Carpenter <dan.carpenter@linaro.org>
AuthorDate:    Thu, 01 Feb 2024 15:17:50 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Feb 2024 10:26:15 +01:00

irqchip/qcom-mpm: Fix IS_ERR() vs NULL check in qcom_mpm_init()

devm_ioremap() doesn't return error pointers, it returns NULL on error.
Update the check accordingly.

Fixes: 221b110d87c2 ("irqchip/qcom-mpm: Support passing a slice of SRAM as reg space")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/22e1f4de-edce-4791-bd2d-2b2e98529492@moroto.mountain

---
 drivers/irqchip/irq-qcom-mpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index cda5838..7942d8e 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -389,8 +389,8 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 		/* Don't use devm_ioremap_resource, as we're accessing a shared region. */
 		priv->base = devm_ioremap(dev, res.start, resource_size(&res));
 		of_node_put(msgram_np);
-		if (IS_ERR(priv->base))
-			return PTR_ERR(priv->base);
+		if (!priv->base)
+			return -ENOMEM;
 	} else {
 		/* Otherwise, fall back to simple MMIO. */
 		priv->base = devm_platform_ioremap_resource(pdev, 0);

