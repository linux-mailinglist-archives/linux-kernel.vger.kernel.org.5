Return-Path: <linux-kernel+bounces-105946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53A387E6BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10AB91C20E24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D5C31A81;
	Mon, 18 Mar 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Icz+2cy+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fW5zvIts"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC672D04C;
	Mon, 18 Mar 2024 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756459; cv=none; b=tdb0hd39SwiijnhUFkMdrPN4uG2VtjkN5W87gUy33OCB36G0edIfer8zBIaGiHElVbVyMFbWbsEkzqztird8INZ5yvOpEJR5pLkFYreIazoT8FE8VoO0VD+tozL/QPd2m43bOE0k2S04/9BCaCDejTd/78X8jxIBMD6tibelGes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756459; c=relaxed/simple;
	bh=0ZGttG7utyKqAMIYqiCNDSUe4iA/afJZxHXHqUK51tM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Sbbdxl6/Sz/g6bJ8NdkSqQ5EVUpMPSwVKzhdp337wnSBhmbm05k0Al5fHky1KVpDYI8lyOunnbOIfw5eL9a0wZ3lXL4hmkqdC/gWOgXKHdkT40ez6qeo9mI2hPCNugParwLv09ZudBbzl+Q0s96ZVRphT8DH3VuPY4YqoEduYlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Icz+2cy+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fW5zvIts; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756454;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0EUlHg/OM7TrMuPUh0m83c/1ZLMqVPxEsJROb4rXt5k=;
	b=Icz+2cy+jUcYhRw87/W/lmye1o9jQki9VYsGP7AztN9Zl9nKRuTMKqTbzk45hF7MF9nW0H
	vXnDT51AasGew8h/dS5xVSBTuqfUybw0uKShUmtGSsrm5JdX2PXtFCnFvfh+8lTNy6gYgq
	T/K7wsHjx2jOd1fBvoJPfDW7R2xBJAKN4kqMMypYWdqWPatVMXuJWKLCMSIcGGnV7z6riy
	dxbHliVzCShdEabIKaqoRBuW/DDY3M4TGy93mCcwWsFfeZvJ7eLyYUQ6+PcIuHIN+Acnv8
	tLgpnH3iipGLmfFbBt/sh9t+M6mGvrJHh1QZsG1BU2UEB6zurSdG777kaOBPmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756454;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0EUlHg/OM7TrMuPUh0m83c/1ZLMqVPxEsJROb4rXt5k=;
	b=fW5zvItsklyjdZdx9xSyzuz91F2JvPaTmxZNpXai+kuXFaX6zQCEB/u7iVgaZwge0WZUfz
	V4UJT88nywSGLyBA==
From: "tip-bot2 for Mubin Sayyed" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] dt-bindings: timer: Add support for cadence TTC PWM
Cc: Mubin Sayyed <mubin.sayyed@amd.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240226093333.2581092-1-mubin.sayyed@amd.com>
References: <20240226093333.2581092-1-mubin.sayyed@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075645389.12214.10587048260565053708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c819dbd078321f948101ef7a19f1e171164bb3cf
Gitweb:        https://git.kernel.org/tip/c819dbd078321f948101ef7a19f1e171164bb3cf
Author:        Mubin Sayyed <mubin.sayyed@amd.com>
AuthorDate:    Mon, 26 Feb 2024 15:03:33 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 26 Feb 2024 15:43:58 +01:00

dt-bindings: timer: Add support for cadence TTC PWM

Cadence TTC can act as PWM device, it will be supported through
separate PWM framework based driver. Decision to configure
specific TTC device as PWM or clocksource/clockevent would
be done based on presence of "#pwm-cells" property.

Also, interrupt property is not required for TTC PWM driver.
Update bindings to support TTC PWM configuration.

Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240226093333.2581092-1-mubin.sayyed@amd.com
---
 Documentation/devicetree/bindings/timer/cdns,ttc.yaml | 22 +++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
index dbba780..da34246 100644
--- a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
+++ b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
@@ -32,12 +32,23 @@ properties:
     description: |
       Bit width of the timer, necessary if not 16.
 
+  "#pwm-cells":
+    const: 3
+
 required:
   - compatible
   - reg
-  - interrupts
   - clocks
 
+allOf:
+  - if:
+      not:
+        required:
+          - "#pwm-cells"
+    then:
+      required:
+        - interrupts
+
 additionalProperties: false
 
 examples:
@@ -50,3 +61,12 @@ examples:
         clocks = <&cpu_clk 3>;
         timer-width = <32>;
     };
+
+  - |
+    pwm: pwm@f8002000 {
+        compatible = "cdns,ttc";
+        reg = <0xf8002000 0x1000>;
+        clocks = <&cpu_clk 3>;
+        timer-width = <32>;
+        #pwm-cells = <3>;
+    };

