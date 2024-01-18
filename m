Return-Path: <linux-kernel+bounces-30513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9223831FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73367287873
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C8D3218C;
	Thu, 18 Jan 2024 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A/ijTayi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E/z0jsuu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313FD2E832;
	Thu, 18 Jan 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605844; cv=none; b=I72QnYFvwmxPPHzu7ju5reqlpKI2M3nm3DiHrjraI7mjCySzTHNN6preicMm69b7E9qsDuUp1L7EF1OL1yjA2DDKSFXqWH2EFrv8nj8tXBjNUd1Omhql+ut15BOc6a5lhx7L6cAI7tDgJhc1w/dtNLgdYb/ZSmOl0jsLzvPMfGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605844; c=relaxed/simple;
	bh=wP5Wrn4a/8wi5EeJ3JeICAz0VKsExEbvVLAHP/rqCMI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sVrrREcX455HInUqvRCqN7MsflW3WODwa7j/bO73iPUEkFHQnkz+4ayXAGXFjgxfVSdE7LZQE4kdpuxqNenCEThBLzc2ygRccupRV6TxyDBjTaSYs1efOl9ymFo/B5iBgExfvdKCLnKW5OcjY2rvqcvx+mdp55p3FNxBRi1WJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A/ijTayi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E/z0jsuu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jan 2024 19:24:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705605840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdl2s+9NwYcKnnAd00gG4XMdcYjPnAG0lfCcq8Er7PA=;
	b=A/ijTayiKu5oQpJFk1UGFjTkz1yRq7dHmGdJVZUBZKW8qIQNzrMGfaMZZJYzWEJZItDTY9
	zxWYcRysrc6Zxt5j5tYTdraOX7NUaqz7VXqyStrDomPHRK4ohryAfcWE/7SzLw/H99QrAH
	dK7ik6fIN5XewZCY9JuOHvTBKwo6bTa6Fc6CU4IcnNrdYGXUFk0PMT3Fn4IhJM4/adsJKY
	s3OAUH0KiZmfg5YkwCGCoxZekZEDHp99pPyjNYQfPhcWZWpqUX3KnUKlNZkOhtGzc4tvSo
	4xvuPwfaN5cniKRqGgWV9X7z68ojiMPeIReZEdvKdrCzAXfgPJMHfBMcoRkfVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705605840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdl2s+9NwYcKnnAd00gG4XMdcYjPnAG0lfCcq8Er7PA=;
	b=E/z0jsuuIFyYPcf/aCIg7WpYaVR75G8fu5swmU9FVJc6wB1VSEFWmGY+OaT43lyYri4Ud1
	tD3ocGYjvL1q2JAA==
From: "tip-bot2 for Inochi Amaoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: thead,c900-aclint-mtimer:
 separate mtime and mtimecmp regs
Cc: Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3CIA1PR20MB49531ED1BCC00D6B265C2D10BB86A=40IA1PR20MB?=
 =?utf-8?q?4953=2Enamprd20=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3CIA1PR20MB49531ED1BCC00D6B265C2D10BB86A=40IA1PR20M?=
 =?utf-8?q?B4953=2Enamprd20=2Eprod=2Eoutlook=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170560584017.398.2135823212972486075.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b91cf01cf3e63a627b3b65f4284dcf9a4deb80f9
Gitweb:        https://git.kernel.org/tip/b91cf01cf3e63a627b3b65f4284dcf9a4deb80f9
Author:        Inochi Amaoto <inochiama@outlook.com>
AuthorDate:    Mon, 04 Dec 2023 17:51:08 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 27 Dec 2023 15:37:11 +01:00

dt-bindings: timer: thead,c900-aclint-mtimer: separate mtime and mtimecmp regs

The timer registers of aclint don't follow the clint layout and can
be mapped on any different offset. As sg2042 uses separated timer
and mswi for its clint, it should follow the aclint spec and have
separated registers.

The previous patch introduced a new type of T-HEAD aclint timer which
has clint timer layout. Although it has the clint timer layout, it
should follow the aclint spec and uses the separated mtime and mtimecmp
regs. So a ABI change is needed to make the timer fit the aclint spec.

To make T-HEAD aclint timer more closer to the aclint spec, use
regs-names to represent the mtimecmp register, which can avoid hack
for unsupport mtime register of T-HEAD aclint timer.

Also, as T-HEAD aclint only supports mtimecmp, it is unnecessary to
implement the whole aclint spec. To make this binding T-HEAD specific,
only add reg-name for existed register. For details, see the discussion
in the last link.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Fixes: 4734449f7311 ("dt-bindings: timer: Add Sophgo sg2042 CLINT timer")
Link: https://lists.infradead.org/pipermail/opensbi/2023-October/005693.html
Link: https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
Link: https://lore.kernel.org/all/IA1PR20MB4953F9D77FFC76A9D236922DBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com/
Acked-by: Guo Ren <guoren@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/IA1PR20MB49531ED1BCC00D6B265C2D10BB86A@IA1PR20MB4953.namprd20.prod.outlook.com
---
 Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
index fbd2356..2e92bcd 100644
--- a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
+++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
@@ -17,7 +17,12 @@ properties:
       - const: thead,c900-aclint-mtimer
 
   reg:
-    maxItems: 1
+    items:
+      - description: MTIMECMP Registers
+
+  reg-names:
+    items:
+      - const: mtimecmp
 
   interrupts-extended:
     minItems: 1
@@ -28,6 +33,7 @@ additionalProperties: false
 required:
   - compatible
   - reg
+  - reg-names
   - interrupts-extended
 
 examples:
@@ -39,5 +45,6 @@ examples:
                             <&cpu3intc 7>,
                             <&cpu4intc 7>;
       reg = <0xac000000 0x00010000>;
+      reg-names = "mtimecmp";
     };
 ...

