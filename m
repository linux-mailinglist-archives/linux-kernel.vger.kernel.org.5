Return-Path: <linux-kernel+bounces-120859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6975788DF85
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B9C29C6FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6D113E413;
	Wed, 27 Mar 2024 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrDH+U6N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B562312DDB9;
	Wed, 27 Mar 2024 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541410; cv=none; b=jgTmg5tT2oaWatOfxv+U+tYXDY/ZVe8YPK5fMHISiUFWjoQSLfm7MjAy143VfsJnap2nsF5WFY81JaCW9OoORkian5AtTgOzXP8wIeOR6M86kADnt5ZLxsECgsu9aQFocRFltfZ84Sd7JYhJYh3SVnY7ajt0zG7gT8CA3VzHck8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541410; c=relaxed/simple;
	bh=CT9lboX6DGNHp4gMzO6XDm6vSdLnNJfbC/23vBoP+d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdLvk6It7NCSAAGtXVtPoBpnDhRoPXQcoaINPYrAbJ049kvxcliErRUIVvRjHSLOjrZgD1kF71BfmWDFX1F8VvfDh72hDCUmVlnRVz2ydVU81VRCKMgyKnkO/eYYG/2CjjBvLmd1+lm4PYH7YzHOl5nfa8+LlATHnJD2L6rhV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrDH+U6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B159FC43390;
	Wed, 27 Mar 2024 12:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541410;
	bh=CT9lboX6DGNHp4gMzO6XDm6vSdLnNJfbC/23vBoP+d8=;
	h=From:To:Cc:Subject:Date:From;
	b=qrDH+U6NpFvPXBwfEy0lyJQZJMlZCVEThnAP2wz1kh/nsprLQ7CLCOOUqVYmI3rMj
	 RT4aMts5H1t+cmZUfqQE2lPvcMHwYewderAA5LLcuXkUHqJifMterLaFQWJfe4jPFl
	 cPSyWjucgtAZoe60A3wEXBx9IzGjJYo1HniBESawCOA5Y/wgcZWomUJPaIWXgAIN7m
	 v9nxoVXMret1FhlOhqtYUnHdCsB8bWQZmgfoGyzh57xABh5QzZm18cApr4fA7o+8sf
	 Oa7ejQrPa4qb2XWdhJGDbnnqQSdWPEU95YvEIaoldjJk6cdjcUcZD/FGTTgaBjJLfh
	 Zp2g5zogepU1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	leyfoon.tan@starfivetech.com
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Atish Patra <atishp@rivosinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: FAILED: Patch "clocksource/drivers/timer-riscv: Clear timer interrupt on timer initialization" failed to apply to 6.6-stable tree
Date: Wed, 27 Mar 2024 08:10:08 -0400
Message-ID: <20240327121008.2827616-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8248ca30ef89f9cc74ace62ae1b9a22b5f16736c Mon Sep 17 00:00:00 2001
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Date: Thu, 7 Mar 2024 01:23:30 +0800
Subject: [PATCH] clocksource/drivers/timer-riscv: Clear timer interrupt on
 timer initialization

In the RISC-V specification, the stimecmp register doesn't have a default
value. To prevent the timer interrupt from being triggered during timer
initialization, clear the timer interrupt by writing stimecmp with a
maximum value.

Fixes: 9f7a8ff6391f ("RISC-V: Prefer sstc extension if available")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240306172330.255844-1-leyfoon.tan@starfivetech.com
---
 drivers/clocksource/timer-riscv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index e66dcbd665665..79bb9a98baa7b 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -108,6 +108,9 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 {
 	struct clock_event_device *ce = per_cpu_ptr(&riscv_clock_event, cpu);
 
+	/* Clear timer interrupt */
+	riscv_clock_event_stop();
+
 	ce->cpumask = cpumask_of(cpu);
 	ce->irq = riscv_clock_event_irq;
 	if (riscv_timer_cannot_wake_cpu)
-- 
2.43.0





