Return-Path: <linux-kernel+bounces-105959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C592887E6DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A34FB225A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C731B40BE5;
	Mon, 18 Mar 2024 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i+YlIicq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WkshTjaD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5EA3C06B;
	Mon, 18 Mar 2024 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756469; cv=none; b=lXu22tT8F3XHoBlbj8/ujU1PqT/kUa1+ySQiqyFGcvJ32siECDQuQWY+DZcCOMahx/06aKKKTl+BRjhi783lAgPln55Y1PoNRwqbFp+/4DID3Q9XrgMoZbYKpOJJsoqLr7/aoNOX+W6rWms6SQlwY/PLwsXmK8gzJelW73z8rlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756469; c=relaxed/simple;
	bh=opO/gYfr7zj2VFIPKDWndG+a04lr2IdZBrJOpvTbyxQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MlcTCZZBWOlNgriM5ebriMb+UbwH1PuQZDwylC4k5MOlkchhA4GWZjFFxTZksvMwJUTy0+0TfOdpB4blnoxd8P1HQdjMwVnuHn36r6x/5E/f95+KZ62etZrbACKsJ6nyRzSpJlLAhAxgvDOc6RQhXyF/v7fWHVTbXzkJIPeQceM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i+YlIicq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WkshTjaD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756465;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeNUXFt88J5Zrnq9qWPqXunvGAoLpF6D3aHs6CO2NCU=;
	b=i+YlIicqt6RVGl3PEV88irDbEvDsBe/UD88eOxZv94/FRCx83vDrv+g7pgiL8GeGOPvQPu
	pPdIOwuYVdsvp2D1e7uHnoyc5Gc2UDX+9FFi7Y2UUl4gBuytg61MhXdsBhG11ECZdfkfVk
	RKaMYtT3UcEy3THM25thzu+GmEHF3S+d5TLToq3iqU4es7rcUPBpTx0bl4NUihcCtwpFXG
	OfScDQ9NPeWtU+C7lhX3G9VjNGiyMdqQdex3+74cF579tBsDTzPFkRRYjabgLN3Wf53W9i
	iTzIY41AjD5GYdYaQ2bJyfB1QaTD4dXCDs1m8aghsC3ndlJ9keaqYzgQFyJ6VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756465;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeNUXFt88J5Zrnq9qWPqXunvGAoLpF6D3aHs6CO2NCU=;
	b=WkshTjaDKy2Bc/g+1iWX5qJqmKK5I6zCA9cIu0Tqal9wghs1TSpMlvaLnvehFdK+1viuDg
	zfyJoy29qml5ZuDQ==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/imx: Fix
 -Wunused-but-set-variable warning
Cc: kernel test robot <lkp@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231227143546.2823683-1-daniel.lezcano@linaro.org>
References: <20231227143546.2823683-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075646475.12214.5546639572917005787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bf3159c0ef1fd2bc999e3a4910b1c610949ae333
Gitweb:        https://git.kernel.org/tip/bf3159c0ef1fd2bc999e3a4910b1c610949ae333
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Wed, 27 Dec 2023 15:35:46 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 22 Jan 2024 13:11:02 +01:00

clocksource/drivers/imx: Fix -Wunused-but-set-variable warning

All warnings (new ones prefixed by >>):

   drivers/clocksource/timer-imx-gpt.c: In function 'mxc_timer_interrupt':
>> drivers/clocksource/timer-imx-gpt.c:279:18: warning: variable 'tstat' set but not used [-Wunused-but-set-variable]
     279 |         uint32_t tstat;
         |                  ^~~~~

vim +/tstat +279 drivers/clocksource/timer-imx-gpt.c

The change remove the tstats assignment but not the reading of the
register, assuming the register may be a ROR (Reset On Read) which
happens in the driver's interrupt registers.

Fixes: df181e382816 ("clocksource/drivers/imx-gpt: Add support for ARM64")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312231803.XzPddRa5-lkp@intel.com/
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20231227143546.2823683-1-daniel.lezcano@linaro.org
---
 drivers/clocksource/timer-imx-gpt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 6a878d2..489e691 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -258,9 +258,8 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *ced = dev_id;
 	struct imx_timer *imxtm = to_imx_timer(ced);
-	uint32_t tstat;
 
-	tstat = readl_relaxed(imxtm->base + imxtm->gpt->reg_tstat);
+	readl_relaxed(imxtm->base + imxtm->gpt->reg_tstat);
 
 	imxtm->gpt->gpt_irq_acknowledge(imxtm);
 

