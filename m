Return-Path: <linux-kernel+bounces-39112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B02B383CAFC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FC71C25FF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7991420A5;
	Thu, 25 Jan 2024 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q6u3EfpQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dHvW25zy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418713E220;
	Thu, 25 Jan 2024 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206902; cv=none; b=BqexTix+eqWXLXNmYElfGyOerf0kijfx0XH1Z35rkw6gMDw+EWWVme8Q3vBIhpD1fe0g8jiMGIV3z12yM3wihcW/INmKO2rNt+LKhMWb2tHyWS+uWQDW8V1ca8zFzwzq5Vml9z99zWutKErKBTNjoiUGd2synU666H5mjmujUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206902; c=relaxed/simple;
	bh=F8GBZPZnyLmawkv6FwgVMm9xPijqDCvkbfbtetdiH0U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F9yGS5KuUIrPco3U5nnDQFwN+9OXMkao2tZE1CyTnNGvccjUiwG1PXxM9S2MPkLjOZbJ2pcOub9mfj9ZVjA7ilwO8eNleRHl6CnuC3UZVL2ErpRFBM9rfIIwI10QEclrUi2S0G3RMeasDcYbcumT9yYrB0LRVYR3qL6md3zT7cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q6u3EfpQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dHvW25zy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6n7GqjJZhSZYQmDjpk6jrTBQeZpRhUgXFIw27gTRtM=;
	b=Q6u3EfpQwSfu46K/Qlg9ZXCCq+S0XDvsqVQb/RsjaRtLrDQ5KkCkJldp53pBdcrWYr5xdQ
	VUd8NNHhE/zK7ueA6Hd28RJkLWA7Mjr9UAI7mj2hq/9yexO2zZgmDe3JaGJzoJYLQ+op9s
	7zvItkvjIP4uVhqab3koBUd65hcBmeomoJA53X9KLSle4YPXfzfgHK0ycKqDHmGLan+l/o
	if7NgNqXa6byI2DvEVj8DzZ38lFa4kHe1ZGq7gj/LL48K614A2e2mE3LZxGUQcn8O7JsbI
	shnMQbOqts7yuNgyQavwQh398IzrAOm7LC+flfq/7cJJKn1WLf3P07b4pJ3UZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S6n7GqjJZhSZYQmDjpk6jrTBQeZpRhUgXFIw27gTRtM=;
	b=dHvW25zyB/yg+NEEOxcskEVFQaZagmbMZ/2Bu46y40RWIR3biA1STqBGotr1yv2DKEyzJ8
	wBgOI5zRr+4sGDBg==
From: "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] Documentation/x86/64: Add documentation for FRED
Cc: Xin Li <xin3.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Bagas Sanjaya <bagasdotme@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-5-xin3.li@intel.com>
References: <20231205105030.8698-5-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620689787.398.15572789260430562050.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     51383e741b41748ee80140233ab98ca6b56918b3
Gitweb:        https://git.kernel.org/tip/51383e741b41748ee80140233ab98ca6b56=
918b3
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:49:53 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:29 +01:00

Documentation/x86/64: Add documentation for FRED

Briefly introduce FRED, and its advantages compared to IDT.

Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Link: https://lore.kernel.org/r/20231205105030.8698-5-xin3.li@intel.com

---
 Documentation/arch/x86/x86_64/fred.rst  | 96 ++++++++++++++++++++++++-
 Documentation/arch/x86/x86_64/index.rst |  1 +-
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/arch/x86/x86_64/fred.rst

diff --git a/Documentation/arch/x86/x86_64/fred.rst b/Documentation/arch/x86/=
x86_64/fred.rst
new file mode 100644
index 0000000..9f57e7b
--- /dev/null
+++ b/Documentation/arch/x86/x86_64/fred.rst
@@ -0,0 +1,96 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Flexible Return and Event Delivery (FRED)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Overview
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+The FRED architecture defines simple new transitions that change
+privilege level (ring transitions). The FRED architecture was
+designed with the following goals:
+
+1) Improve overall performance and response time by replacing event
+   delivery through the interrupt descriptor table (IDT event
+   delivery) and event return by the IRET instruction with lower
+   latency transitions.
+
+2) Improve software robustness by ensuring that event delivery
+   establishes the full supervisor context and that event return
+   establishes the full user context.
+
+The new transitions defined by the FRED architecture are FRED event
+delivery and, for returning from events, two FRED return instructions.
+FRED event delivery can effect a transition from ring 3 to ring 0, but
+it is used also to deliver events incident to ring 0. One FRED
+instruction (ERETU) effects a return from ring 0 to ring 3, while the
+other (ERETS) returns while remaining in ring 0. Collectively, FRED
+event delivery and the FRED return instructions are FRED transitions.
+
+In addition to these transitions, the FRED architecture defines a new
+instruction (LKGS) for managing the state of the GS segment register.
+The LKGS instruction can be used by 64-bit operating systems that do
+not use the new FRED transitions.
+
+Furthermore, the FRED architecture is easy to extend for future CPU
+architectures.
+
+Software based event dispatching
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+FRED operates differently from IDT in terms of event handling. Instead
+of directly dispatching an event to its handler based on the event
+vector, FRED requires the software to dispatch an event to its handler
+based on both the event's type and vector. Therefore, an event dispatch
+framework must be implemented to facilitate the event-to-handler
+dispatch process. The FRED event dispatch framework takes control
+once an event is delivered, and employs a two-level dispatch.
+
+The first level dispatching is event type based, and the second level
+dispatching is event vector based.
+
+Full supervisor/user context
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
+
+FRED event delivery atomically save and restore full supervisor/user
+context upon event delivery and return. Thus it avoids the problem of
+transient states due to %cr2 and/or %dr6, and it is no longer needed
+to handle all the ugly corner cases caused by half baked entry states.
+
+FRED allows explicit unblock of NMI with new event return instructions
+ERETS/ERETU, avoiding the mess caused by IRET which unconditionally
+unblocks NMI, e.g., when an exception happens during NMI handling.
+
+FRED always restores the full value of %rsp, thus ESPFIX is no longer
+needed when FRED is enabled.
+
+LKGS
+=3D=3D=3D=3D
+
+LKGS behaves like the MOV to GS instruction except that it loads the
+base address into the IA32_KERNEL_GS_BASE MSR instead of the GS
+segment=E2=80=99s descriptor cache. With LKGS, it ends up with avoiding
+mucking with kernel GS, i.e., an operating system can always operate
+with its own GS base address.
+
+Because FRED event delivery from ring 3 and ERETU both swap the value
+of the GS base address and that of the IA32_KERNEL_GS_BASE MSR, plus
+the introduction of LKGS instruction, the SWAPGS instruction is no
+longer needed when FRED is enabled, thus is disallowed (#UD).
+
+Stack levels
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+4 stack levels 0~3 are introduced to replace the nonreentrant IST for
+event handling, and each stack level should be configured to use a
+dedicated stack.
+
+The current stack level could be unchanged or go higher upon FRED
+event delivery. If unchanged, the CPU keeps using the current event
+stack. If higher, the CPU switches to a new event stack specified by
+the MSR of the new stack level, i.e., MSR_IA32_FRED_RSP[123].
+
+Only execution of a FRED return instruction ERET[US], could lower the
+current stack level, causing the CPU to switch back to the stack it was
+on before a previous event delivery that promoted the stack level.
diff --git a/Documentation/arch/x86/x86_64/index.rst b/Documentation/arch/x86=
/x86_64/index.rst
index a56070f..ad15e9b 100644
--- a/Documentation/arch/x86/x86_64/index.rst
+++ b/Documentation/arch/x86/x86_64/index.rst
@@ -15,3 +15,4 @@ x86_64 Support
    cpu-hotplug-spec
    machinecheck
    fsgs
+   fred

