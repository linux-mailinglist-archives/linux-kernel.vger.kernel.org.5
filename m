Return-Path: <linux-kernel+bounces-105945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D087287E6BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0391C2175C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EE22EAE6;
	Mon, 18 Mar 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1fzu7ZN0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LBxNJ6wu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B90D2D051;
	Mon, 18 Mar 2024 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756459; cv=none; b=Q0drehQlQczs5lG+EAtTw2tidZx0SjPGE4ROtPrJNxLDc6igjnNr50M56OyizCkJ93ASRjtfZ7C/CQzS7rhF0ZX+DB66dUcnm14fumcDH2408qaWKTzvrNzYj6oiliLimsBi/hAIVXJ41kJrSeJdhSfZDJTcRdU31fYkyuMzt5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756459; c=relaxed/simple;
	bh=g3zP11HMNFRCFfyMRZ337vxWpIMoyBokhQ3Onmh78J8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UuvLXFm4kJWRz35sMmqnt6qOckdZFO/s/8plpc5XbnEXlbtJY6USk6ClOwaiy03xXHVI/IW7AssjT9vLYfflMPsh4BPfL2eDNw4un/H8ARKWbRgFngXZDyuGZFLCPtDv8xqPX8Npa9uiG+O9XW2K7xjgXe9m3afQ3IYJ9pywWkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1fzu7ZN0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LBxNJ6wu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q69fmyqDy+6siSbaAAi+nmr3gqTcldmd72nfKzVsKV4=;
	b=1fzu7ZN0XK7dI1342W5fG9GNbnFPVfWeu407esBaWZHy+pHAhg6t9r1fuKBP9i6iEj9KtE
	zxK4OLYdPm92NHzSUosR8aRrqU2xtCcymOANCK1AbAUBIbYTkKZ6RM/EoNb3q7m4d/EEKo
	4FoaPVQkk5z5guBdLhbTljLD9mifbpp/dg5P4U60N6qkmexDW63YlGygejRjq8hfmOa36k
	HtfTo2dNcN1UsWVhwE4chNkNudByl8XeHbR1rhQWB4AcUSkDtNeB1cjrepLaZKKz+cvQpK
	WFtj7sO7umbL0uwX8DOnrXOh86GScxwpEUaXbkdwuFswfdf51VLJTaoHdTOmfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q69fmyqDy+6siSbaAAi+nmr3gqTcldmd72nfKzVsKV4=;
	b=LBxNJ6wu9HkuCxWF33lwNgRWnjalCCkjQsDLSNY9iWEl0gJ+q/+Pa0GJUFB8v1hK7aO+Ho
	KutEmYxyHEXWyvAQ==
From: "tip-bot2 for Martin Blumenstingl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_global_timer: Make
 gt_target_rate unsigned long
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225151336.2728533-2-martin.blumenstingl@googlemail.com>
References: <20240225151336.2728533-2-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075645589.12214.8632484343108151719.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f31c204850f9d93906b5ac8c203b2066524ff245
Gitweb:        https://git.kernel.org/tip/f31c204850f9d93906b5ac8c203b2066524ff245
Author:        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
AuthorDate:    Sun, 25 Feb 2024 16:13:34 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 26 Feb 2024 10:07:25 +01:00

clocksource/drivers/arm_global_timer: Make gt_target_rate unsigned long

Change the data type of gt_target_rate to unsigned long as this is what
we get back from clk_get_rate().

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20240225151336.2728533-2-martin.blumenstingl@googlemail.com
---
 drivers/clocksource/arm_global_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index d749dee..fd39cfa 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -52,7 +52,8 @@
  */
 static void __iomem *gt_base;
 static struct notifier_block gt_clk_rate_change_nb;
-static u32 gt_psv_new, gt_psv_bck, gt_target_rate;
+static u32 gt_psv_new, gt_psv_bck;
+static unsigned long gt_target_rate;
 static int gt_ppi;
 static struct clock_event_device __percpu *gt_evt;
 

