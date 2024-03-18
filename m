Return-Path: <linux-kernel+bounces-105954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF1A87E6D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AE428319A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315EA3BBFA;
	Mon, 18 Mar 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rVoXpLjy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZGuuL7O3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6EF381B1;
	Mon, 18 Mar 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756466; cv=none; b=UaCcMydc1YiI3wPd8uoHcbwlaZIGlRnBImEryVSvTTSIovCZZy4BiTDVJ1SFtmikM8h560tl92YmecJdFqnUDaXmj2AvUdGF2HjY+tTVE0Pzwk/0wgyYa3QwqoNmAMmJLSZ1a8Nll4I8GEdy/Cxx/7GfwrOg4mklxA4/hT531Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756466; c=relaxed/simple;
	bh=93jLeJ31pIiR5JW++RIwwHuipMjVOkLdnmS/A4r21TA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uz/b5qIs11K2RrIWln3MPVOr+x544buPzwtXHm7bonyQwACZv91V5lNzinmR0XNSPiShoPbxG8GrAQX16ZvpdP860CKa9Rd2q2kM8mkkQBHXp65Ake5BytyxFvf+lwa4D7Y7wNYMS2zhRlxVXlP8fecCpuG78NBhoPMXkxmDykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rVoXpLjy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZGuuL7O3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756462;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IE+kfs6LZ4pu47SlXqqx3zZVTe7X47K1VqcW7Zkjto8=;
	b=rVoXpLjymXe1/1tjWi8BcS1LNPBJdMjwP7u+pl3degesWRlnPp0zmKCX4GVhSnH5WNkgb0
	98vkmj2rG6zOI5i66Gn8E03mUBn5N0rWhdPDKgUUuNYUiY2cYMahyMWx0QLobehNKAu3WQ
	2iJabFkzZxnNF0GXBTcvpZXJLCeMu6Q1vDAsagjemKeqIomMlvP8X1K1jzG+biOTHoDPJF
	KHI4nldE1AwINim3yDZK7Jl037evuSn65CyrpyCABsb+EeFLy8XpRYKSq6fshQ6/RDI6mR
	h9MLLF06oWkyqHE4wtO3Tgq/pbJGkF6b/Y8bNAemXuZ6XvOuuWxAdajjAF0WLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756462;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IE+kfs6LZ4pu47SlXqqx3zZVTe7X47K1VqcW7Zkjto8=;
	b=ZGuuL7O32vp7WfAUeqzbiT4xdRoXCIFETF+VVOW0Tp7N+oJFeF7dZELPu5D4pBuCMEojnl
	Ws7Z66MEmWT+OPDw==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,tmu: Document input
 capture interrupt
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 niklas.soderlund+renesas@ragnatech.se,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C8cb38b5236213a467c6c0073f97ccc4bfd5a39ff=2E17067?=
 =?utf-8?q?17378=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C8cb38b5236213a467c6c0073f97ccc4bfd5a39ff=2E170671?=
 =?utf-8?q?7378=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075646209.12214.12812854242435321555.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0076a37a426b6c850a0b41b814952760e4a70fcf
Gitweb:        https://git.kernel.org/tip/0076a37a426b6c850a0b41b814952760e4a=
70fcf
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 31 Jan 2024 17:11:45 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 31 Jan 2024 22:12:18 +01:00

dt-bindings: timer: renesas,tmu: Document input capture interrupt

Some Timer Unit (TMU) instances with 3 channels support a fourth
interrupt: an input capture interrupt for the third channel.

While at it, document the meaning of the four interrupts, and add
"interrupt-names" for clarity.

Update the example to match reality.

Inspired by a patch by Yoshinori Sato for SH.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/8cb38b5236213a467c6c0073f97ccc4bfd5a39ff.1706=
717378.git.geert+renesas@glider.be
---
 Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 18 ++++++-
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tmu.yaml
index a67e427..84bbe15 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -46,7 +46,19 @@ properties:
=20
   interrupts:
     minItems: 2
-    maxItems: 3
+    items:
+      - description: Underflow interrupt, channel 0
+      - description: Underflow interrupt, channel 1
+      - description: Underflow interrupt, channel 2
+      - description: Input capture interrupt, channel 2
+
+  interrupt-names:
+    minItems: 2
+    items:
+      - const: tuni0
+      - const: tuni1
+      - const: tuni2
+      - const: ticpi2
=20
   clocks:
     maxItems: 1
@@ -100,7 +112,9 @@ examples:
             reg =3D <0xffd80000 0x30>;
             interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names =3D "tuni0", "tuni1", "tuni2", "ticpi2";
             clocks =3D <&mstp0_clks R8A7779_CLK_TMU0>;
             clock-names =3D "fck";
             power-domains =3D <&sysc R8A7779_PD_ALWAYS_ON>;

