Return-Path: <linux-kernel+bounces-159394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2098B2E19
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E789DB2297F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADD04404;
	Fri, 26 Apr 2024 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="MRPTWh6i"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2531879;
	Fri, 26 Apr 2024 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714092128; cv=none; b=m95OsYwVMBpk7AI2BS6Vfyz66hKm9b0xaDNyPoHonB/N+dxKqFoa4OjB+oLOZ/vuE7nkWIL1ixReSUZS53C9d3aNaMvi7YXFl16EGLXSzF508PJOZKmgUU2+scNJCn5vi6x3yzqKA7KIEfJOUI+E+WEGLUcev3+VYQZOkbgCzwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714092128; c=relaxed/simple;
	bh=z85p/MYGjXhunDG06htI/+4oYrt1eV3iA6WOipoNt90=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bTupia/nBKHhD/rrm+g7ywI4U6+Nd061NRZdFkLP+EDfPQC40ipA6Q5v10YhbzHTYzBrl2s8YJXJLrAGhJYFHsWAcF785rWWu1mLoTL7VQxuFH4AlqE+cYsrHczaFQ2I1xZQzl3p6PpttuGQYHio5CFW6DXcezwsK+KDf/SNSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=MRPTWh6i; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-127-66.adl-apt-pir-bras32.tpg.internode.on.net [14.2.127.66])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9AF5520075;
	Fri, 26 Apr 2024 08:41:58 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1714092123;
	bh=yLN/Qb+eB/6AyNAKbEB/yMlsv9Gl2BYp81SCa6piTeg=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=MRPTWh6iLUPzVdEoN6OoxnclwEajv4PUZysrLyAeI30AMIhWlPLTwwk4v6ltGNUFN
	 tHGXIKanZihdwzVoroKvOwGJNrc3ARd8koi0aUc9RQLUlBlDMnerfnrYWkLkHei1wV
	 efSkxL9aqLaDWbMFYId3Xskp63kVqccJnm+VHVxOszpG/EVeMlaOyJc4wCrDWqyYan
	 Bv/6v0Z/fBlR3wvFujD4bAScafK87c8QGR5ajjxDsGTjdoVCHNfFhjTALI5tOvAMHS
	 vNK20+8DoBp4QsLP1jAAMsdxeuSwViKa7qRHWsZDVccbZzNEjKPtA+ccqkchMyBnhy
	 B+fOhM5t4K0sg==
Message-ID: <5ed8bfd6ce559a7d00ec89f1bd7ae1aea90e3ae7.camel@codeconstruct.com.au>
Subject: Re: [PATCH v7 1/1] drivers: watchdog: revise watchdog bootstatus
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz, Wim Van
 Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Joel
 Stanley <joel@jms.id.au>, linux-watchdog@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 26 Apr 2024 10:11:57 +0930
In-Reply-To: <20240425090727.3787160-2-peteryin.openbmc@gmail.com>
References: <20240425090727.3787160-1-peteryin.openbmc@gmail.com>
	 <20240425090727.3787160-2-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-25 at 17:07 +0800, Peter Yin wrote:
> Regarding the AST2600 specification, the WDTn Timeout Status Register
> (WDT10) has bit 1 reserved. Bit 1 of the status register indicates
> on ast2500 if the boot was from the second boot source.
> It does not indicate that the most recent reset was triggered by
> the watchdog. The code should just be changed to set WDIOF_CARDRESET
> if bit 0 of the status register is set. However, this bit can be clear wh=
en
> watchdog register 0x0c bit1(Reset System after timeout) is enabled.
> Thereforce include SCU register to veriy WDIOF_EXTERN1 and WDIOF_CARDRESE=
T
> in ast2600 SCU74 or ast2400/ast2500 SCU3C.
>=20
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  drivers/watchdog/aspeed_wdt.c | 109 ++++++++++++++++++++++++++++++++--
>  1 file changed, 103 insertions(+), 6 deletions(-)

After this patch the probe() implementation is ~250loc with a whole
bunch of conditional behaviours based on the SoC version. Maybe it's
time to break it up into version-specific functions that are called
from the probe() implementation?

Andrew

