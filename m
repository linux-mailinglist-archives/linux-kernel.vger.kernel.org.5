Return-Path: <linux-kernel+bounces-105960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9E487E6DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D961F228E4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34480446A5;
	Mon, 18 Mar 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DUfQvHB8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FPzr3KcA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0FF3D0D2;
	Mon, 18 Mar 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756469; cv=none; b=XyBP9txunuaEFiKQMCq1+wu/SBLfm9ur6dNJ1UeIRT3DDWdbJx3N6U3gR1Me8XajtgcHjzw+yojRMl2Guwie/qhc+3vgjXuLDfrwxJzAQCsRMxjJepDZugLKtphZBSAblCqtlN5sez3qHPRyyT5jdD37R8hK700acrU/Yyn17zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756469; c=relaxed/simple;
	bh=9hPTmVrdz9Yf+RJx6mfPzHdKSE+/5+vRi0Q14SAt9Do=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ahncyExMz7dLMGchmJBK0tBR9BI5z+eZa9Ss6GcphcXG5oSTpkzgESB5slzl7VO4VdmVnwvmnLCGr7UA8aIkrOwkOzWX50r8Hu2Zi6GJyoEWJ42N2OVNYVeUxJODbjlOegI5tWt46U1GsVpwCfKjdLURdKdm865evLVN95y61HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DUfQvHB8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FPzr3KcA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Mar 2024 10:07:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710756466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+m8EoRvdBhHDT/V7dH54bDqosIlzd4rZk/Qz7CUjbQ=;
	b=DUfQvHB8fpucekBJ4MNflM/WyfGqvHC3DQ/P22ka9MLHrUvLNUSIvABJxa6vRxmkG0cNt0
	/AbkJnWk6feD84r3micqy5yDJ7Oa+W/k5dk4qlDt9lQuslzU8j8saz9dtfsXtELHddkc3O
	k8t4GXjsTM3OyTcVmrlMre2uG6ujIJYFVJYL1xBEzl41uUCEgB/MWMJj86qAIqD0ko33Pi
	dj2JvH34ScHlkKWnSmL6S0neB4TPcaFgvU5x442a87MuVle94k28WS+TDyj/NAzUhKQ8hE
	AyW0a4z3lXQsTEMeqe34dEdI12qBlL+JBf4qm7sIbsCNvpoTeIpd8qhrLWjYfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710756466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+m8EoRvdBhHDT/V7dH54bDqosIlzd4rZk/Qz7CUjbQ=;
	b=FPzr3KcAVnEZbrBmT0I1F76ZRPFoOWRBiMe4xsAqaKiHNTgmhOgLV5nm9lmqVk3YnuW9hg
	3DAPHXo8ZRwYaSCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v6.9-rc1' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <5552010a-1ce2-46a1-a740-a69f2e9a2cf2@linaro.org>
References: <5552010a-1ce2-46a1-a740-a69f2e9a2cf2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171075646556.12214.8318903210136343258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     86c54c846e126d6f7cbfacefa0cfeaed6f67207b
Gitweb:        https://git.kernel.org/tip/86c54c846e126d6f7cbfacefa0cfeaed6f67207b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 18 Mar 2024 11:01:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 18 Mar 2024 11:01:13 +01:00

Merge tag 'timers-v6.9-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

Pull clocksource/event driver updates from Daniel Lezcano:

  - Fix -Wunused-but-set-variable warning for the iMX GPT timer (Daniel
    Lezcano)

  - Add Pixel6 compatible string for Exynos 4210 MCT timer (Peter Griffin)

  - Fix all kernel-doc warnings and misuse of comment format (Randy
    Dunlap)

  - Document in the DT bindings the interrupt used for input capture
    interrupt and udpate the example to match the reality (Geert
    Uytterhoeven)

  - Document RZ/Five SoC DT bindings (Lad Prabhakar)

  - Add DT bindings support for the i.MX95, reorganize the driver to
    move globale variables to a timer private structure and introduce
    the i.MX95 timer support (Peng Fan)

  - Fix prescalar value to conform to the ARM global timer
    documentation. Fix data types and comparison, guard the divide by
    zero code section and use the available macros for bit manipulation
    (Martin Blumenstingl)

  - Add Ralink SoCs system tick counter (Sergio Paracuellos)

  - Add support for cadence TTC PWM (Mubin Sayyed)

  - Clear timer interrupt on timer initialization to prevent the
    interrupt to fire during setup (Ley Foon Tan)

Link: https://lore.kernel.org/r/5552010a-1ce2-46a1-a740-a69f2e9a2cf2@linaro.org
---

