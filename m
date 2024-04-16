Return-Path: <linux-kernel+bounces-146521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4398A6685
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FAC21C2104A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A38FEEB7;
	Tue, 16 Apr 2024 08:56:17 +0000 (UTC)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1736484A41
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257777; cv=none; b=BaHa8ZCmUA1Kl0LQtavqodzfMwD9lYqbi8DYE1tqJqvoJ9+3V4fBwE9dVFgyYkXUZzebfBP5ZkDftQttSgv+0yCJSXC32kQsbMJfXY3u1VymXKKCEEyUyoKofVS4N1lpOLAaJhpVP9IMPqCYauMwdvPdIudrg/qYB2AmqJ1KvK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257777; c=relaxed/simple;
	bh=mJVdhhBUdMA0yYpMEwV9fYT1Nc9uTwmOroHTOpBPLaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l4WTbu4rJm+mGntUMSw6SMWJppL9uG40ww/TZgFn4uylWI5B7aVXRM5/D4wwNT0Phv6/Rpykqxe3BYHHCqOqSW6Y0t7O21NCcNn/eW6T5VYUTUIQVoTqLOncMY+jiYovxKBsEHqEXf4uJD6Uz0mQsbCOAzp5CV9jQEIFORGTqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz9t1713257735tyj1h5z
X-QQ-Originating-IP: J1+XVaKYc4gINHAK8uWrRuN71TwNcJxTaQ1+BDrOPt4=
Received: from localhost ( [112.0.147.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Apr 2024 16:55:33 +0800 (CST)
X-QQ-SSF: 01400000000000903000000A0000000
X-QQ-FEAT: aEYUFldOyMrlL4xvOCm8kicnmgOcnKn7UTC/kO5QwMSgrbXFqqLFILxcKGBQG
	8g8JFInrcgLGSkjUuFRyFK3dpcrhElOztBn0Yz+vxv9dRRFsdQ6w6brmEofjzPEdxoa38L+
	K7ukP9XkdEgYA8GjB5Bp6bS9HCEM0yCDOhvQ9qs6thBvmS6Y9hdZ16N8v/Y6Q1yQ0fFmiAv
	VMDkukGzfOhevlawcgNHLxQry+u9zc6Vs2cmY4UmkngTnZGft9Ilh6+9PaYZI4JkZdkjFf8
	qNnamZRPnUJrKNS/TM2ehxqnIEkRUXAF0vNKeatKpDEAuF1LhtBjK+QnukSd3smmAx+KsyO
	1MIwA6cOAJOIx/1g+o2kz3j7MhVE7Gsy5Ycu3ra5S75uI6OZkh0RNYJwUKhxAANf1xBAyAk
	nnQ+WEYROU5Mje2KMVB1Lya5eb8Lj05W
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6012901568914722649
From: Dawei Li <dawei.li@shingroup.cn>
To: tglx@linutronix.de,
	yury.norov@gmail.com,
	rafael@kernel.org
Cc: akpm@linux-foundation.org,
	maz@kernel.org,
	florian.fainelli@broadcom.com,
	chenhuacai@kernel.org,
	jiaxun.yang@flygoat.com,
	anup@brainfault.org,
	palmer@dabbelt.com,
	samuel.holland@sifive.com,
	linux@rasmusvillemoes.dk,
	daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH v2 3/7] irqchip/gic-v3-its: Avoid explicit cpumask allocation on stack
Date: Tue, 16 Apr 2024 16:54:50 +0800
Message-Id: <20240416085454.3547175-4-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240416085454.3547175-1-dawei.li@shingroup.cn>
References: <20240416085454.3547175-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Remove cpumask var on stack and use cpumask_any_and() to address it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/irqchip/irq-gic-v3-its.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fca888b36680..20f954211c61 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3826,9 +3826,9 @@ static int its_vpe_set_affinity(struct irq_data *d,
 				bool force)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
-	struct cpumask common, *table_mask;
+	unsigned int from, cpu = nr_cpu_ids;
+	struct cpumask *table_mask;
 	unsigned long flags;
-	int from, cpu;
 
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
@@ -3850,10 +3850,15 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * If we are offered another CPU in the same GICv4.1 ITS
 	 * affinity, pick this one. Otherwise, any CPU will do.
 	 */
-	if (table_mask && cpumask_and(&common, mask_val, table_mask))
-		cpu = cpumask_test_cpu(from, &common) ? from : cpumask_first(&common);
-	else
+	if (table_mask)
+		cpu = cpumask_any_and(mask_val, table_mask);
+	if (cpu < nr_cpu_ids) {
+		if (cpumask_test_cpu(from, mask_val) &&
+		    cpumask_test_cpu(from, table_mask))
+			cpu = from;
+	} else {
 		cpu = cpumask_first(mask_val);
+	}
 
 	if (from == cpu)
 		goto out;
-- 
2.27.0



