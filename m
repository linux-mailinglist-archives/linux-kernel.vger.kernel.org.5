Return-Path: <linux-kernel+bounces-75224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC6585E4E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1062B20E7E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C2384A31;
	Wed, 21 Feb 2024 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CSRv2iw0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LnJAvQn3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E183CD2;
	Wed, 21 Feb 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537670; cv=none; b=qGDoSvYC2CErMw/pBNHfbgyx4M1SB/7Q0vKI8jZk+WiIqIEi54VCsMtP/drtiqUWJ/y3oICFsYXzbzaD+H05MOAhZtMpP/ZQGnMShIHHJMzGyP22/QSZFui4BTHS6kJa8nhnTrzq9kCzoVkrGys3LLCizv4/i7A3KVIzOuNrgYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537670; c=relaxed/simple;
	bh=PRauaF92682VwsAMg09wdHVxsDKlTxRn384p1w/3jJk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aOfNb7NxDq1Sj7QY5I6zQjBf0VXi9jy6IwKOTt2U/0SfnlYSkATTPsxFOzrUQac6LpeZzQIMgMvazOtHie8WMGVmAEnneEoMJC7J2Dl5yJT8kqWErec4CYW9QJP7X73LQBvHozoYo4qghou4Qw0DSi8msc6bqpuKEi/+jrF5dRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CSRv2iw0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LnJAvQn3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 Feb 2024 17:47:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708537667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=31NN7dBlQk+cSYn0Xu5M/e75MI8J5Cmp6IemxlCIL0A=;
	b=CSRv2iw0nAmYDmU83rlI0JrOr7g0HAw379vheiLTpZ242XXqcBfxXOIJ50eAk20TQ9D91p
	Pejfquj83aAPOa+tF/VVo2Bel3Ehi/mCwq4XDuXzPz0rd1zIFxTcT/KbUeTZ5/qxR0abaH
	rQarnzPkwOAYGivfT2kvyOw3UGaGtuA0mfYgPXgyU1dl0q6uqINOwYeRKhO6q5Zk+yA8jo
	tFu1RiLTn9HO24DxHADv8vsbgAdpE4TJ86up6pdPw/7eDhRG8/Dx3eoRaO39SwXNOfyXXU
	iJg+SXA/23T3kAkpKStrqOd3fZD26WUMAPyx7AQf/qkbK2gYKqhwnjomIRBvzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708537667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=31NN7dBlQk+cSYn0Xu5M/e75MI8J5Cmp6IemxlCIL0A=;
	b=LnJAvQn3KY+kokh2F9pFI5qUHIXgfkAok5MounSHgdg/Bkb43vTi7doeRDOBSE+tqBjYJ7
	MfucnJzk4JVvi/CA==
From: "tip-bot2 for Chen Jun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/mbigen: Don't use bus_get_dev_root() to
 find the parent
Cc: Chen Jun <chenjun102@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240220111429.110666-1-chenjun102@huawei.com>
References: <20240220111429.110666-1-chenjun102@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170853766628.398.14228390574695320909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     fb33a46cd75e18773dd5a414744507d84ae90870
Gitweb:        https://git.kernel.org/tip/fb33a46cd75e18773dd5a414744507d84ae90870
Author:        Chen Jun <chenjun102@huawei.com>
AuthorDate:    Tue, 20 Feb 2024 19:14:29 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 21 Feb 2024 18:40:00 +01:00

irqchip/mbigen: Don't use bus_get_dev_root() to find the parent

bus_get_dev_root() returns sp->dev_root which is set in subsys_register(),
but subsys_register() is not called by platform_bus_init().

Therefor for the platform_bus_type, bus_get_dev_root() always returns NULL.
This makes mbigen_of_create_domain() always return -ENODEV.

Don't try to retrieve the parent via bus_get_dev_root() and
unconditionally hand a NULL pointer to of_platform_device_create() to
fix this.

Fixes: fea087fc291b ("irqchip/mbigen: move to use bus_get_dev_root()")
Signed-off-by: Chen Jun <chenjun102@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240220111429.110666-1-chenjun102@huawei.com

---
 drivers/irqchip/irq-mbigen.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 5101a3f..58881d3 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -235,22 +235,17 @@ static const struct irq_domain_ops mbigen_domain_ops = {
 static int mbigen_of_create_domain(struct platform_device *pdev,
 				   struct mbigen_device *mgn_chip)
 {
-	struct device *parent;
 	struct platform_device *child;
 	struct irq_domain *domain;
 	struct device_node *np;
 	u32 num_pins;
 	int ret = 0;
 
-	parent = bus_get_dev_root(&platform_bus_type);
-	if (!parent)
-		return -ENODEV;
-
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		if (!of_property_read_bool(np, "interrupt-controller"))
 			continue;
 
-		child = of_platform_device_create(np, NULL, parent);
+		child = of_platform_device_create(np, NULL, NULL);
 		if (!child) {
 			ret = -ENOMEM;
 			break;
@@ -273,7 +268,6 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 		}
 	}
 
-	put_device(parent);
 	if (ret)
 		of_node_put(np);
 

