Return-Path: <linux-kernel+bounces-76929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD0685FECE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557B61F291C1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351761552F5;
	Thu, 22 Feb 2024 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ax4Em7tM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ptIvDQnD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDCB14F9FE;
	Thu, 22 Feb 2024 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621872; cv=none; b=MJrnukQAQ/RyOJ+LbcBMvNsJPHMLUU+wb+xt1LR8fRpTgQguSoltT6npz+wXvXFllrX+xwVc/s+/6GhdUFNZX050GmtQCHxg+jdcvZrUonuxDruYeU9Im6KkKCkrvjf+Yl0B7rCbzpd+yy+lCPUQoRQtcPyYSGfy4xO3awvs+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621872; c=relaxed/simple;
	bh=DAzeBEEdLR73MwKO48c6XGeOzopBZZgL8Uss3l1DIUU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QImWllbCtFReqnYiVtrqYrXPOGWP0Vm7Lyd/Cl+BLit+GxMUe3hio8cLHSGLSq3C1lFQL92LTDlWPHfHlMT9dPlq/U93VvOQfFjMhNiDKgSfaao3/l3jA+VA0NDWsmEYVsV/u95ptcvlO6YzoVN7rd6sZ3hpTrl/0PrPPnDNdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ax4Em7tM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ptIvDQnD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:11:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCmJTymzCZ/OO0k5JdKI4CkPlY0ex1wcioQq1JYlB6Y=;
	b=Ax4Em7tMDupStZU8m04Ip9fTdlf6iQCUhR6fxtZRXwD0LRCvQmO+LgXcPHPDMIQeZ6zWAr
	/KFMc1J/wLwwVi9CowVTTonW5UixM7/20az5htwm9KlaJce0EWiIqXP/HbaqOynzoD5YO7
	XwoeU9+oE8EJJ0vrS7McA+YhYqCLm5P0jwlskRuCfuG/Y7CWIuPR45bgUaPsZWNsOUHrlN
	kIv5HXKpEWu+d4hpzcj0L9MkGNomgOuCcLAxjEI+spUExxN/E6ZMX31/oFCw+KpfQ8R+Ar
	ZHx1nG1fv316wLH8sRNo0j81qb4szIPGQPA3shW7kmvJjWlJ8gChSrHsxOY0kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aCmJTymzCZ/OO0k5JdKI4CkPlY0ex1wcioQq1JYlB6Y=;
	b=ptIvDQnD6H1Pil5uZ5qjqLNzgXpiJT9iuy/4hxoDw7TIDAn3E73F1MyrJf0OvRsf0/UkHA
	i3FJNmNZxcccQFAw==
From: "tip-bot2 for Huqiang Qin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/meson-gpio: Add support for Amlogic-T7 SoCs
Cc: Huqiang Qin <huqiang.qin@amlogic.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240222074640.1866284-3-huqiang.qin@amlogic.com>
References: <20240222074640.1866284-3-huqiang.qin@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862186822.398.7810719484570780829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e281bfa6f759b667357454c1d3d283f7a52871da
Gitweb:        https://git.kernel.org/tip/e281bfa6f759b667357454c1d3d283f7a52871da
Author:        Huqiang Qin <huqiang.qin@amlogic.com>
AuthorDate:    Thu, 22 Feb 2024 15:46:38 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 18:04:42 +01:00

irqchip/meson-gpio: Add support for Amlogic-T7 SoCs

The Amlogic-T7 SoCs support 12 GPIO IRQ lines compared with previous
serial chips and have something different, details are as below.

IRQ Number:
- 156      1 pin  on bank TESTN
- 155:148  8 pins on bank H
- 147:129 19 pins on bank Y
- 128:115 14 pins on bank M
- 114:91  24 pins on bank T
- 90:77   14 pins on bank Z
- 76:70    7 pins on bank E
- 69:57   13 pins on bank D
- 56:40   17 pins on bank W
- 39:20   20 pins on bank X
- 19:13    7 pins on bank C
- 12:0    13 pins on bank B

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20240222074640.1866284-3-huqiang.qin@amlogic.com

---
 drivers/irqchip/irq-meson-gpio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index f88df39..9a17919 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -154,6 +154,10 @@ static const struct meson_gpio_irq_params c3_params = {
 	INIT_MESON_S4_COMMON_DATA(55)
 };
 
+static const struct meson_gpio_irq_params t7_params = {
+	INIT_MESON_S4_COMMON_DATA(157)
+};
+
 static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
 	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
 	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
@@ -165,6 +169,7 @@ static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
 	{ .compatible = "amlogic,meson-a1-gpio-intc", .data = &a1_params },
 	{ .compatible = "amlogic,meson-s4-gpio-intc", .data = &s4_params },
 	{ .compatible = "amlogic,c3-gpio-intc", .data = &c3_params },
+	{ .compatible = "amlogic,t7-gpio-intc", .data = &t7_params },
 	{ }
 };
 

