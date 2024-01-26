Return-Path: <linux-kernel+bounces-40104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F7683DA5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163E81C24222
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D081B81D;
	Fri, 26 Jan 2024 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PbpEhRlT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TOC/7o/6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846101B7E5;
	Fri, 26 Jan 2024 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273622; cv=none; b=mrZ8KuiSdqrz4De71fuwRbFBsdYDFFjQIkzcFwpXd8dqk/IVJNsZcgw3pb7LeQo5VzC/ayZjq6Mz2F2iHYnlf15v/BbxtBPQpZWpbWWXHVmxPr1fuBBdSMeO8FuW9Dg9SQMVP7MhSnivOxk4dXuaLfSnoe22TPPcWCKfN/4eODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273622; c=relaxed/simple;
	bh=YpyVDUk6TG8f5X00ffQ+Fj0E3hj3RO1Zni4FxUXPvDw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W8WHw7vvoXbUK3Tv3X7DZjI1wy8Czc52R8cEfU/hQ8r+z5uWsdlKKUFNnHXhV+aadzkm/OelYOKIdrKMLMHrFDObNWW2hcMrxNfN2DuXL6HwGalt/+1vmoEUQ9byL/2COe9yfIlqw+ZNSzk4h1pBfnwT54//WC5wDFcz1ht8gng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PbpEhRlT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TOC/7o/6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Jan 2024 12:53:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706273617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yUx3Xt0Tsc8hn1EcAsr1UK9Kuho3NGCFl1fQmVqggkk=;
	b=PbpEhRlTOh99pPNtLLpUtrmbWCHJbPRE4Kbz1A7qDIddXQrGiSDIX9LwVldbBQx2zTk9G0
	IBSl4lgqFZdzFdPqTsu+erG3r9Vw1VeIcQs1+OR2HUbqaxn1ub7mDUK4zRvYyQ8Qzv9K2v
	TGOhGUGvIpnEXgwsO6jMCPEcmoymlRk9bdFjD0PPioShEXzPhbhSeB831cFGIjD1vfqnU2
	izPQ+Hvv1s0Bttc/aL6xorpdf6J5PrQQYwiAw2zC2LqbXZpWry4mgdL/BF++915I4nj7f0
	CBfarnYEL94mwkv6KigUHIuaiMoH/5unco9+QDw1WxRcq7tQBho4377qrT7whw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706273617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yUx3Xt0Tsc8hn1EcAsr1UK9Kuho3NGCFl1fQmVqggkk=;
	b=TOC/7o/64t3LqQ2xGco8BSyycUfRQZCZFfgv4D72Mw+4F6IVrRgGMPVNawOD4ihA5+LI4J
	dn8Y7U5jSsIYeJDA==
From: "tip-bot2 for Bartosz Golaszewski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irq_sim: Order headers alphabetically
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240122124243.44002-4-brgl@bgdev.pl>
References: <20240122124243.44002-4-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170627361717.398.492997867909957104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8dab7fd47e53865d37fce73c67bac97b41d5d64a
Gitweb:        https://git.kernel.org/tip/8dab7fd47e53865d37fce73c67bac97b41d5d64a
Author:        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
AuthorDate:    Mon, 22 Jan 2024 13:42:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Jan 2024 13:44:48 +01:00

genirq/irq_sim: Order headers alphabetically

For better readability and maintenance keep headers in alphabetical
order.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240122124243.44002-4-brgl@bgdev.pl

---
 kernel/irq/irq_sim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index f5ebb3b..b0d50b4 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -4,10 +4,10 @@
  * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
  */
 
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
 #include <linux/irq_work.h>
-#include <linux/interrupt.h>
 #include <linux/slab.h>
 
 struct irq_sim_work_ctx {

