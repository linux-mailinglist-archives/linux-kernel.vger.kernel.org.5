Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFDF7DA09D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjJ0Sg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbjJ0Sgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:36:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8A62D59;
        Fri, 27 Oct 2023 11:23:48 -0700 (PDT)
Date:   Fri, 27 Oct 2023 18:23:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698430994;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDpOKTGssvtlgulzL3UG8va0ENAs6cD4R4PLxN1EhHg=;
        b=1nNdkb34AYxs9/HSYiW2eq+VTgZ/4XWgML8FqVi7iUI155g7GK4uFBvgSYB6+oQ58WsGso
        tUG0wNS+Qdd7B3hu9N0Qdm2ngdEKCwdCoYVqGo3cQRuNIhGzPGcQtF/ZZDqF5nhBXyRl+W
        X9u0OXGVYdmjpQ6zRXKPtUadk+v/LZ0+niSI/NOXYo73MYxOiQybKu0ctMqEFPYPH1D3dG
        w24IWeX92zlkE4CZ4pBYO3mWKXx58nM2q6tk/q2PcQrl/Sy+2hWhyFg7L3UchzRmL9Sp2R
        jLqJ9yj11h+C1AG7nuEbN8Jof+/ztnjbD+ZuynbApmtZGuO3liW/MSFFhzEokw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698430994;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDpOKTGssvtlgulzL3UG8va0ENAs6cD4R4PLxN1EhHg=;
        b=1q3Wd+qS3kFXWSC1eIbfjv4zWx7I5T5cmxBx4iMpkwwtqMHx2ZaAG5533ZzqGoTukVMnAY
        cTZ7BN3gVJhzF4CQ==
From:   "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,rz-mtu3: Improve documentation
Cc:     Pavel Machek <pavel@denx.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230727081848.100834-3-biju.das.jz@bp.renesas.com>
References: <20230727081848.100834-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <169843099400.3135.4989763347351372533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b121e7881b8975cf8dc24d9bd71a5af81ed8a6b1
Gitweb:        https://git.kernel.org/tip/b121e7881b8975cf8dc24d9bd71a5af81ed8a6b1
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Thu, 27 Jul 2023 09:18:45 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 11 Oct 2023 09:03:54 +02:00

dt-bindings: timer: renesas,rz-mtu3: Improve documentation

Fix the documentation issues pointed by Pavel while backporting
it to 6.1.y-cip.
 - Replace '32- bit'->'32-bit'
 - Consistently remove '.' at the end of line for the specifications
 - Replace '          (excluding MTU8)'-> '(excluding MTU8)'

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/all/ZH79%2FUjgYg+0Ruiu@duo.ucw.cz
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230727081848.100834-3-biju.das.jz@bp.renesas.com
---
 Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml | 28 +++----
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
index fbac40b..670a2eb 100644
--- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
@@ -11,8 +11,8 @@ maintainers:
 
 description: |
   This hardware block consists of eight 16-bit timer channels and one
-  32- bit timer channel. It supports the following specifications:
-    - Pulse input/output: 28 lines max.
+  32-bit timer channel. It supports the following specifications:
+    - Pulse input/output: 28 lines max
     - Pulse input 3 lines
     - Count clock 11 clocks for each channel (14 clocks for MTU0, 12 clocks
       for MTU2, and 10 clocks for MTU5, four clocks for MTU1-MTU2 combination
@@ -23,11 +23,11 @@ description: |
         - Input capture function (noise filter setting available)
         - Counter-clearing operation
         - Simultaneous writing to multiple timer counters (TCNT)
-          (excluding MTU8).
+          (excluding MTU8)
         - Simultaneous clearing on compare match or input capture
-          (excluding MTU8).
+          (excluding MTU8)
         - Simultaneous input and output to registers in synchronization with
-          counter operations           (excluding MTU8).
+          counter operations (excluding MTU8)
         - Up to 12-phase PWM output in combination with synchronous operation
           (excluding MTU8)
     - [MTU0 MTU3, MTU4, MTU6, MTU7, and MTU8]
@@ -40,26 +40,26 @@ description: |
     - [MTU3, MTU4, MTU6, and MTU7]
         - Through interlocked operation of MTU3/4 and MTU6/7, the positive and
           negative signals in six phases (12 phases in total) can be output in
-          complementary PWM and reset-synchronized PWM operation.
+          complementary PWM and reset-synchronized PWM operation
         - In complementary PWM mode, values can be transferred from buffer
           registers to temporary registers at crests and troughs of the timer-
           counter values or when the buffer registers (TGRD registers in MTU4
-          and MTU7) are written to.
-        - Double-buffering selectable in complementary PWM mode.
+          and MTU7) are written to
+        - Double-buffering selectable in complementary PWM mode
     - [MTU3 and MTU4]
         - Through interlocking with MTU0, a mode for driving AC synchronous
           motors (brushless DC motors) by using complementary PWM output and
           reset-synchronized PWM output is settable and allows the selection
-          of two types of waveform output (chopping or level).
+          of two types of waveform output (chopping or level)
     - [MTU5]
-        - Capable of operation as a dead-time compensation counter.
+        - Capable of operation as a dead-time compensation counter
     - [MTU0/MTU5, MTU1, MTU2, and MTU8]
         - 32-bit phase counting mode specifiable by combining MTU1 and MTU2 and
-          through interlocked operation with MTU0/MTU5 and MTU8.
+          through interlocked operation with MTU0/MTU5 and MTU8
     - Interrupt-skipping function
         - In complementary PWM mode, interrupts on crests and troughs of counter
           values and triggers to start conversion by the A/D converter can be
-          skipped.
+          skipped
     - Interrupt sources: 43 sources.
     - Buffer operation:
         - Automatic transfer of register data (transfer from the buffer
@@ -68,9 +68,9 @@ description: |
         - A/D converter start triggers can be generated
         - A/D converter start request delaying function enables A/D converter
           to be started with any desired timing and to be synchronized with
-          PWM output.
+          PWM output
     - Low power consumption function
-        - The MTU3a can be placed in the module-stop state.
+        - The MTU3a can be placed in the module-stop state
 
     There are two phase counting modes. 16-bit phase counting mode in which
     MTU1 and MTU2 operate independently, and cascade connection 32-bit phase
