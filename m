Return-Path: <linux-kernel+bounces-30512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FC4831FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BAB28814D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5535631A94;
	Thu, 18 Jan 2024 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fhrlr3C2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ihf0goR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1D2E836;
	Thu, 18 Jan 2024 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605844; cv=none; b=CvD3anJZcu9pkWSuTfw2UuRo3tTHSeisrcMHRxWpqzl4LBUfQSoLKRQ71dcliqPSeQkFPHprW5qJTCNX00poPzFCVfTS9WzI8aRwcavwfylQQ841zP2461Iegp+OYklWMladCjrANFsyCT0aVeX/KyqXaFtaq0rHff55qQCz1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605844; c=relaxed/simple;
	bh=lRFzJbHDnDsiVD3nGqsRzkKK8C4uIoWW4N75QqsHf7s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TnXbDm8w4sHntsC+WG5H9CsEC/XIK4wUQr0FwLOlGD3TZCcfpzwHNm2Ffbmwxyx4PF09LpGscCffSzfK8FiHcDJNniYDR4IHVhChdR+lGweJZ4ZJpZapTiw7hSN3syvhq3lE32D9M36ZU433gn89LaqFj7TwaZ84QZ26uMzoA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fhrlr3C2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ihf0goR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jan 2024 19:24:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705605841;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pv5/mTP5r6Nfvc4J2xmQodz2DUvNlivHqu0FYiYlpgs=;
	b=fhrlr3C2q85TPa9QjYLMP7xu8orRsiu531IiPwAqpvHSB8+sF/aUhG8o7ids9WOckeZRFX
	Y27Z/163V+s6J/uwX96nxraJ0pronYb3r+2dok6J4kKvD31T3w53RZz6pZoWpSbYLTFEiL
	jyYWMBYX3X3C5aM5lMY4No1YMh7ESsNLqp/pQ8AefNH0BGv/Bitj2pIlh3qD3ZSKtPOU55
	+nGp2ber5KK2tB0krIkWvGleJoN506dgajOzwQHfY5E+LKFbWgCahkKHRyWKBPGCpGYVAv
	0ymObZuXaLtv1zypeWyAKIb08ranZZhYIJPp78kIqM1ENLmTJs0/YGLf03vD5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705605841;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pv5/mTP5r6Nfvc4J2xmQodz2DUvNlivHqu0FYiYlpgs=;
	b=3ihf0goR/dN4iD+UlHOBk/sPtaPpfMzQmJPpbU16Sp0tRiXuAyVroFxukLrXTBpwSrHgFk
	x2dKLe5CYitSDkCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v6.8-rc1' of
 http://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <0f07af92-e4b2-48de-88a6-dd9aa9e49743@linaro.org>
References: <0f07af92-e4b2-48de-88a6-dd9aa9e49743@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170560584078.398.9063165494963006226.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     80fe58cc176fefceb7afd6dd937f97f37313b9b3
Gitweb:        https://git.kernel.org/tip/80fe58cc176fefceb7afd6dd937f97f37313b9b3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 18 Jan 2024 20:11:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jan 2024 20:11:46 +01:00

Merge tag 'timers-v6.8-rc1' of http://git.linaro.org/people/daniel.lezcano/linux into timers/core

Pull clockevent/clocksource updates from Daniel Lezcano:

   - Fixed error handling at probe time and uninitialized return code on
     ep93xx (Arnd Bergman)

   - Fixed some kerneldoc warning on Cadence TTC (Randy Dunlap)

   - Fixed kerneldoc warning on Timer TI DM (Tony Lindgren)

   - Handle interrupt disabling when shutting down the timer on RISC-V
     timer (Joshua Yeong)

   - Add compatible string for the StarFive JH8100 clint (Sia Jee Heng)

   - Separate mtime and mtimecmp registers in DT bindings (Inochi Amaoto)

Link: https://lore.kernel.org/lkml/0f07af92-e4b2-48de-88a6-dd9aa9e49743@linaro.org
---

