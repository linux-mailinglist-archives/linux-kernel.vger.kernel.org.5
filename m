Return-Path: <linux-kernel+bounces-131715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C90898B01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEEA91F239D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19D812AAEF;
	Thu,  4 Apr 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1/8yhpIY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA612AACA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244178; cv=none; b=Hc6HizHzkI84Inv5sHIIx1xGQCHhKkK+cV6V/NzxwTVuAjXxcDo29whdR9G+HYwkfeVMItnb7X6orDeLGvTDDeZtDBrKcvR0AwQIwCi5VrLnHqpDaNU8F3caaM0w9K6AizI3eXzat/9j2AtyBA56jEBxdLjQ/KFGLX3MD30HACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244178; c=relaxed/simple;
	bh=EMwT4Y2inuVPzK35wOcuimN88Lo0Bzf/ESD4NioLRnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gnwtiup4HrrFNwqp0ZgiJrk8w6whgoUXz2gIOo5uPUrpcG5umPA4acLZcAO6netqMOO8NtQzYScCZJIxuUoRHg5IF8VNznxHflh4HI2onxLbF55Tfi18lgBWFFYSzxP/7YFHyd2fxw4xhB5GWgRQaTqG7IGzmFgn+4YJUtci62k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1/8yhpIY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712244175;
	bh=EMwT4Y2inuVPzK35wOcuimN88Lo0Bzf/ESD4NioLRnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1/8yhpIYITyxW7arJHLQ6SLLqAevKgCLaeVHIKWnfYBV4KqGyJNm5GaojBpK5JyhZ
	 qaLRWouh4TedmwYUw9tmlog5zvKnvG6zVpfi/XzBAtroqBLmTCUQWQ675y6owE1Eyo
	 pFXkuLTRRmlkI/HVpiNJoJtGTdlIkmUiojGvvIXPQUDvjAmwg0EUCQPI/F18jDWMs6
	 JD7sVdq4pLRwsHbseacSTp85MkPNuFZxQO0EI+6znI+iGSkaICzqD81HVlaDQ3mjzi
	 uqu/HbFQdD910eBoMfEotInmsl559jso9jtD6mTQcUSljBwSaJo6iemgK1dtlcrMaU
	 XrEnGyzRGwlDA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2529E37813A4;
	Thu,  4 Apr 2024 15:22:55 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: tglx@linutronix.de
Cc: kernel@collabora.com,
	laura.nao@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	x86@kernel.org
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge Chromebooks
Date: Thu,  4 Apr 2024 17:23:17 +0200
Message-Id: <20240404152317.464796-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <874jchb7na.ffs@tglx>
References: <874jchb7na.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas,

On 4/4/24 15:05, Thomas Gleixner wrote:
> Laura!
> 
> On Thu, Apr 04 2024 at 15:01, Thomas Gleixner wrote:
>> On Thu, Apr 04 2024 at 10:24, Linux regression tracking wrote:
>>> On 28.03.24 12:50, Laura Nao wrote:
>>>>>
>>>>> I ran a manual bisection to track down the root cause for this
>>>>> regression and landed on the c749ce
>>>>> commit from this series:
>>>>> https://lore.kernel.org/all/20240212153625.145745053@linutronix.de/
>>>
>>> FWIW, that commit is c749ce393b8fe9 ("x86/cpu: Use common topology code
>>> for AMD") from tglx that was part of the "x86/cpu: Rework topology
>>> evaluation" series.
> 
> Can you please provide a boot dmesg from a 6.8 kernel and the output of
> 'cpuid' ?

Sure, here's the output from an Acer Chromebook Spin 311 R721T device:
- kernel log: https://pastebin.com/raw/NNbeJupE
- cpuid output: https://pastebin.com/raw/ThmGqnqG

This is with kernel v6.8 (e8f897f4afef0031fe618a8e94127a0934896aba), let
me know if you need the output from a different revision.

Thank you!

Laura

