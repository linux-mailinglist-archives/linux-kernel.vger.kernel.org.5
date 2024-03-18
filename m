Return-Path: <linux-kernel+bounces-105956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF1C87E6D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6922A2825EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1483D387;
	Mon, 18 Mar 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yh9JHaqN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a48u3dI5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5588376EE;
	Mon, 18 Mar 2024 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756466; cv=none; b=T5Y3RikC3Amh5gqAU2bILA+P9XVSnSuNNac+tk9wPFIYyz3l90ADK+VG3QFgekPgD5MqpmDAC8pVVyloPeQlu0fW6V+51v2p5GcMXicCj7hLc/wJpUANRP7rpQhntTT1Ybkw4fnxbEUHU5I8v6x2/m4hBEOVHI7Gls/QSAVjLF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756466; c=relaxed/simple;
	bh=g6c2HTwr58RvrEkHKS24SYzTozE9rsdRTJSD5j3aFtE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XLh6hSrAwoFViqWRy1p/W8lkE931VAmjsf7cPIY4JI9UISdmfvMwTbipzo9RVN8CmhPckL6L6vAfxx7JKo0nDS8OsyH7Bwov1sNDVG+eC79eSScRpTC/9e+IVbrGLNqNv5keW2JUjkXH7XrHFK46jblVWcOGtG6sG8h/1sbs6M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yh9JHaqN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a48u3dI5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756462;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JZuW2IBwxKy6+oQQUXe4xTgYCTtElgCxk1BH4Y5lp8=;
	b=yh9JHaqN+nKIKaqheTHIUBvCJRX7+U5TXH6UfwCxjvrQb//519K4l0Mi4FqODJSWpz7+57
	soVqMXwMrYnZ571EW45zm5nQk8Y1aGOj1lz+FfvdgGBMEjnD0tQm/c5JCJUK96hV5oxWoH
	1uPdp765ULBQojrkwIlm79xKYau8ZKUC7oWJwL6bjYsy49Q8uxigyPakaPxr1FFHiEPmk/
	BvXm7C6LBuY0qEF9qgl3s+hPQOfLgE3wgbGr0U5Xe3+ThCxK6q+E+wFCTaRRIzA/shoHWc
	tH0EEdwY3bI+Cz0IvCii9FTOKVbAvRT8SKr97NxmhK6xH8qSxZnOvyXj/T3qYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756462;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JZuW2IBwxKy6+oQQUXe4xTgYCTtElgCxk1BH4Y5lp8=;
	b=a48u3dI5IV1rMmrRe5mrMZEIzrgnBqfztN3FhWCxb4OsxaDTu8h4jIKm6iOuA4xpCW0Y3n
	onD8lSexmvzLstDw==
From: "tip-bot2 for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] dt-bindings: timer: renesas: ostm: Document RZ/Five SoC
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231115212908.33131-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231115212908.33131-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075646140.12214.5049583001968212520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     69518264da6298fb1a490ca8adcfcb798c16e15c
Gitweb:        https://git.kernel.org/tip/69518264da6298fb1a490ca8adcfcb798c16e15c
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Wed, 15 Nov 2023 21:29:08 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 13 Feb 2024 14:02:41 +01:00

dt-bindings: timer: renesas: ostm: Document RZ/Five SoC

The OSTM block on the RZ/Five SoC is identical to one found on the RZ/G2UL
SoC. "renesas,r9a07g043-ostm" compatible string will be used on the RZ/Five
SoC so to make this clear and to keep this file consistent, update the
comment to include RZ/Five SoC.

No driver changes are required as generic compatible string "renesas,ostm"
will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20231115212908.33131-1-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
index 7207929..8b06a68 100644
--- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
@@ -23,7 +23,7 @@ properties:
       - enum:
           - renesas,r7s72100-ostm  # RZ/A1H
           - renesas,r7s9210-ostm   # RZ/A2M
-          - renesas,r9a07g043-ostm # RZ/G2UL
+          - renesas,r9a07g043-ostm # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-ostm # RZ/G2{L,LC}
           - renesas,r9a07g054-ostm # RZ/V2L
       - const: renesas,ostm        # Generic

