Return-Path: <linux-kernel+bounces-120914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A8C88E072
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58201C2970E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486201494C5;
	Wed, 27 Mar 2024 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMVxno96"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5461494B0;
	Wed, 27 Mar 2024 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541571; cv=none; b=SappTcJ/Q7HRAOlllWnabnDSxpA1rfrAwgVPP9SAzweUNfuxp6sctyyWJC0QPV7YIA6k6rL+gncMY/BRXPYVj9JDnMP1fanptDhZQZ1iDWipYOwyITwHn3tBm64q3YsAizAdWmqeAmqIDAGvU2iZ0BPVs+SD+ck1XlHY0gVznOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541571; c=relaxed/simple;
	bh=ZEFqX0rr/4NcbZWJElKR8QdLOMJVEZGDtxdEioXmuoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X1B72+d1uX4+yV32B70hVQ/Qn81d78E+7JuxMwTmxqzKXb2v0elJ24vrqveD/WM1SWHuFvIRG8YWk7qo1Tfa0qBBbD4OHNIr9x2Bqe0ETWkA9c8+QwBRkqdrHuPX7kmQ+ETPAGgbXLoMwnVDUTl30rDxzR90DxeKiNuDLUPX6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMVxno96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF53C433C7;
	Wed, 27 Mar 2024 12:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541571;
	bh=ZEFqX0rr/4NcbZWJElKR8QdLOMJVEZGDtxdEioXmuoc=;
	h=From:To:Cc:Subject:Date:From;
	b=fMVxno96urFy74N6zvKlmIXHr9BiXx6Hrle2R/FtsaQgMpujdDj1itJhtvjQZv2dh
	 voKJdJXPGQvtbmmJ7/SP3OWCkWONmbQtBPv6XN+z4usm/Q+JEFGgMpCLGpHsmY4LIM
	 G+IggYGZI6eUfNfj4OzGeBA5clcN85fKy0lnUPPEmvKadn3uxQmjoq2TvoTmV1W8I8
	 Szd5aQQRkE1tXv+AIAx2hhFgK2f9SmdGcpqOaSTIb5b7Lqhhek4rx4rd3GZRxYschh
	 QLD5QJL2F2QbKqxCqmCbnHPdUBGK2wdy0pREOKDJuR1QjOCn08MVZT4/4LN2pjENB3
	 7sKZFxkASNatw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	leyfoon.tan@starfivetech.com
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Atish Patra <atishp@rivosinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: FAILED: Patch "clocksource/drivers/timer-riscv: Clear timer interrupt on timer initialization" failed to apply to 6.1-stable tree
Date: Wed, 27 Mar 2024 08:12:49 -0400
Message-ID: <20240327121249.2829814-1-sashal@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
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





