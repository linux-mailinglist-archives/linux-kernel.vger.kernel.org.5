Return-Path: <linux-kernel+bounces-163236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EE58B6786
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D620B22243
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758721FBA;
	Tue, 30 Apr 2024 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="YWNZ6eSu"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CA91113;
	Tue, 30 Apr 2024 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441103; cv=none; b=kzGdC5H/j6kHRFZeun7jpY5b0BRqwqe1yYIX7oCPQAooGIie6/zTAh/FtKFNlE7+sMFnuErFLa0tcXodKTh2AbwK9KP4ZNy0ZC6rA0GWBQrvOr98T3GDrqhFV5SB0aKEU4IxoLTRH5RlwaQLca4Cmck583CfE1dZcgdeLurwAXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441103; c=relaxed/simple;
	bh=dMUJOGQZFnBYsgneEfy9fLkTZSvb/W/i64TqOEoqARk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fECEU7Uk4UMkwKPUTlEIjvXmAwQ3aNqDDgBczUCIz2+OE3o10CttMh0+pJfggEnfrnnYOlduwa3qbGzpxxPbX7cma0gBxV+qyWJvsfmouKsA0mWTEyxTRCV8HZQ+giqy//RgkjGhT7telqOUX2YBWSLicmoceIk0wmCmrmI1LjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=YWNZ6eSu; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-127-66.adl-apt-pir-bras32.tpg.internode.on.net [14.2.127.66])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id F402E200EF;
	Tue, 30 Apr 2024 09:38:17 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1714441100;
	bh=iO2Qb5vOGlEJy2p0kRpFmo54k139J+5qqBLF4SdTE8M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YWNZ6eSuJjdbazCq5Tr+/UMFUigvmiomlY34UiNQ8iZ6ukGL8t2ygckWbW1FQPw9r
	 RUeeQGYiZKxASLXC4rgHy1PIE6o8XoALUjlioZrOuwUW5ZjmgYcKmbsc50mIeCVXni
	 oJaGFoo+2fA6LPSY+LMM4E6fTl9NonCyWAwD0qFIwOLUvdmKadqtZK601bTUmdyXrY
	 2EUw64UOzIzHckNCD8Rn/cfiZ0KYODOl5DmnQS3GfkoC5O1+dma7eD9mhKmJ5HRMe5
	 ZAswFxFNqvUPPyphfQ23WKJRJ4REOwCXp1NerfE53XMINCfVWGcC1iO1OhYCemDU2M
	 661FS1yGDsWFA==
Message-ID: <e694ba58197687dce68d568dfcb078ff3a6c6fed.camel@codeconstruct.com.au>
Subject: Re: [PATCH v8 1/1] drivers: watchdog: revise watchdog bootstatus
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>
Cc: patrick@stwcx.xyz, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter
 Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>, 
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Tue, 30 Apr 2024 11:08:17 +0930
In-Reply-To: <CAPSyxFRG8mooBg1QWZk8sw=cWzoUQqk=WnyAtgPfRBmQRKtvaQ@mail.gmail.com>
References: <20240428142937.785925-1-peteryin.openbmc@gmail.com>
	 <20240428142937.785925-2-peteryin.openbmc@gmail.com>
	 <d231737bfa9f3dd3c0a4370ab2e86557a407980d.camel@codeconstruct.com.au>
	 <CAPSyxFRG8mooBg1QWZk8sw=cWzoUQqk=WnyAtgPfRBmQRKtvaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-29 at 22:54 +0800, Peter Yin wrote:
> Hi Andrew,
>     I am not sure how to add the Fixes tag, Is it like this?
>=20
> Fixes: 6a6c7b006e5c (watchdog: aspeed: Add support for
> aspeed,reset-mask DT property).

Approximately, yes, but it must not be wrapped.

Some more info is provided in the submitting-patches documentation:

https://docs.kernel.org/process/submitting-patches.html#describe-your-chang=
es

> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
>=20
> Is it the correct commit ID or should I base on which commit ID?
>=20

The correct commit ID to use is the one that introduces the problem.
Using `git blame drivers/watchdog/aspeed_wdt.c` it appears you're
changing the behaviour that was introduced in 49d4d277ca54 ("aspeed:
watchdog: Set bootstatus during probe"):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D49d4d277ca54e04170d39484c8758a0ea9bca37d

Andrew

