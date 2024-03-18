Return-Path: <linux-kernel+bounces-105953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248E887E6CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546481C217E2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DE638F99;
	Mon, 18 Mar 2024 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CL00t6cX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wUwY5Vym"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD43716D;
	Mon, 18 Mar 2024 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756464; cv=none; b=LcQQ0lKp9iTHljHDPiP5SyxHIckbxojlEyePrvazHkL+Lzzaxy+goVCnUUlrK9ON5gUMPS+jt6vPz/0hpRy9sCvW4EHkzpSqeir9F8XVQhUDweNAEcPSQ7HtBhM1LMvDKC2cIFbOPk+yFlUaPgvuJ9tsz9PlcJu6LJ7BEgLZsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756464; c=relaxed/simple;
	bh=xPvz7uURhm9CvEhZdQ5MNmFfrQtP9alBI0iQcIiLjy8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DlSN+Fbs/HmoOitwMAsJfdJZPtiHRRrUBe5e/yO2wOoLNO2/LLRa7a4GPLvWvH+cLSt6umSBMV+mpRTxL9gOGUii6u3RN0XhFQn7zb2qWhEPyd6Q2wwohHtUjyNfdufkbx3dsrP/edBgHtXJ3yv1bJKAF5VmC56b3iWb7nc15eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CL00t6cX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wUwY5Vym; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756461;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tfn23OWrPUAy9JnakOYXzkJFmlqHirLY5OM65ZB2exM=;
	b=CL00t6cXMaZc2hXS/NvISyszt3aj3n9Kep5M4PGAxz5kyAqAvMKljVY2jNNF1/VQtvEhmi
	jJsSCthsnX+xC51DWeWomrWazSBFEoChz0k2x9AYn4mcPD/Od6OWQtICwLGGWzdG7CJxiI
	xWi5360VsOGEeaeTPmsnRUckVsRfaN/445bM1sUuvbNrSscrvfNkE7jVxgH/P77uESXYlr
	vwHXSOYInQB6BmjsfQi0og5+R6nAO889csY9fs5foRkGxJzrs9CfH2vHO7/dJagifT8lyo
	NVoO4KrZnAI8EqpvP2oZtdKv53O3AxRcGZGrNdcF53GqdMo6rT5mfi3IrR4v6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756461;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tfn23OWrPUAy9JnakOYXzkJFmlqHirLY5OM65ZB2exM=;
	b=wUwY5VymvTTPShx85vt7XnaRx7HxDP4GnHYgYfn8CWZYznKeX9hqp2zfMGqVOjnFG1NUVi
	HAdZaTa0iszPGVAQ==
From: "tip-bot2 for Peng Fan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] dt-bindings: timer: nxp,sysctr-timer: support i.MX95
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240205-imx-sysctr-v4-1-ca5a6e1552e7@nxp.com>
References: <20240205-imx-sysctr-v4-1-ca5a6e1552e7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075646071.12214.10573649637094618273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8ec11bd89e15f7858359f2c4c9eed1d7de739c3c
Gitweb:        https://git.kernel.org/tip/8ec11bd89e15f7858359f2c4c9eed1d7de739c3c
Author:        Peng Fan <peng.fan@nxp.com>
AuthorDate:    Mon, 05 Feb 2024 11:17:57 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 18 Feb 2024 10:45:05 +01:00

dt-bindings: timer: nxp,sysctr-timer: support i.MX95

Add i.MX95 System counter module compatible string, the SCMI
firmware blocks access to control register, so should not
add "nxp,sysctr-timer" as fallback.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240205-imx-sysctr-v4-1-ca5a6e1552e7@nxp.com
---
 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
index 2b9653d..891cca0 100644
--- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
@@ -18,7 +18,9 @@ description: |
 
 properties:
   compatible:
-    const: nxp,sysctr-timer
+    enum:
+      - nxp,imx95-sysctr-timer
+      - nxp,sysctr-timer
 
   reg:
     maxItems: 1

