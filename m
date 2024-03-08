Return-Path: <linux-kernel+bounces-97529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA9D876B83
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 734C5B21EB7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899DB5B5B6;
	Fri,  8 Mar 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="lHZYlkO0"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1CA5A4C0;
	Fri,  8 Mar 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709928243; cv=none; b=Cg7/ECBNDn/K1t+8FNwH/Lfn5aXvfjFF/AHuQsPo37D7e7HKadOGn8LFOcQPhkVnD1Zo772tZZ4BV46lwae9FrvzPxMkMQVO9Tpu1kRvVafD1KS0OvDiQxpMJdRasOhevJKYo2CKmOCeFfsZY9LQ+xhqeQtLOiHqsPAnD7sw2zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709928243; c=relaxed/simple;
	bh=p5EUPOa17omKAB/nlATU9/TlKgbige89y8wgf3HYC00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zi1SObGES3/J3C5avFY6HnJnhlbDMVhQlstTmwYPLioHMhGUHWhSLGkEQkd52p/fKVXYQEj1Le4huukTycIz1oO7EldFbKZY2yRxOgRQDubUNwO0Ug0wI1Ns1XTojiNu0fTXNGTrf8gMonSt7f9mEGxAYE0vbcxcwjktOO7C6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=lHZYlkO0; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TrxvM4FJxz684g;
	Fri,  8 Mar 2024 21:03:59 +0100 (CET)
Received: from [10.10.15.2] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Trxv93Ldjz6846;
	Fri,  8 Mar 2024 21:03:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709928239;
	bh=Fqj2xi9D9keAqm31LQN2HTiJrx4wTlMlUpa8owkaAzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lHZYlkO0tPyMFL6upWWUK7ajZ87m7Ct9K45Y/4G0VuvOer5R2nlkr8zsgjGL82wOQ
	 xV/w5/ZEZBUQbDOwVqnbimER6sR+N03XnLSFz76iZhi7NG6Q7HK/k9uBa/yxvNzSXp
	 ZPADAKOytD7uOOqEr7ko8enJ385yBdPRyPO/9jC4=
Message-ID: <d7134c1f-7c6a-4715-9ffb-e8ef0143d662@gaisler.com>
Date: Fri, 8 Mar 2024 21:03:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] sparc32: Do not select GENERIC_ISA_DMA
Content-Language: en-US
To: sam@ravnborg.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-5-1f186603c5c4@ravnborg.org>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240224-sam-fix-sparc32-all-builds-v2-5-1f186603c5c4@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-24 18:42, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> sparc32 do not support generic isa dma, so do not select the symbol.
> 
> This fixes the following warnings:
> dma.c:70:5: error: no previous prototype for 'request_dma' [-Werror=missing-prototypes]
> dma.c:88:6: error: no previous prototype for 'free_dma' [-Werror=missing-prototypes]
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Fixes: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes globally")
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
>  arch/sparc/Kconfig | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

