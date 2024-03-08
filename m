Return-Path: <linux-kernel+bounces-97530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23222876B85
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CA228345A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813FF5B5C8;
	Fri,  8 Mar 2024 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="OkWhs91G"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A045A7B6;
	Fri,  8 Mar 2024 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709928305; cv=none; b=OFJYLW3j+03Z2li+Tq5PbpOwYHs/9kiqrJ9w6AOmgznbCYa1v3doMYQVeXBybPqmy5nuAYxmAsAmCdlG0t68SwJWyktmFnTluQe6MD1aUBKZT0KxhTu1omGCUoSSqurDZ6VKl5hkGq0o9P3dJ4Ztuabb60erOnzBcP/mGqChNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709928305; c=relaxed/simple;
	bh=hTdDW/QPVrtJ0hv0pJwoncMwRgnDZcmT72YWj8/pWaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCr6k/WfEpmXnDeA2exc2vGcCLWZQ7tm8h0DulS6cWnSFZHlJTVtffDy+PeuOCnmAVkIiO/v0dUfpzD6nhmzF+vDe6MZc5nJDg9xmHa7dcRoBRa47vSpWJ37a4faBLVrk3iu3ID8KOJKB+8TfwU5avmiGa5sxKX6p3UtMf25+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=OkWhs91G; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TrxwY64p8z684f;
	Fri,  8 Mar 2024 21:05:01 +0100 (CET)
Received: from [10.10.15.2] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4TrxwL2MFcz6849;
	Fri,  8 Mar 2024 21:04:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709928301;
	bh=Bz7WFKATpeRUEMd+kK/nmA2pOOoQq0OLYoXU7B2XQAk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OkWhs91GDEt0Zv4LTotdE8GdTAx1QI86pbrgCwpaJuXQg9qbBz93m1RFHzbV6axOE
	 dlJ5xZnAQawP4Sk1UQ/76QeEb0SOu9rgpxABL92ergvCGK5PF2aE0qyJQjQ9sWZaVT
	 k3redQSwjdQb4WVOyDOkwKEcydyFsLaoQlWeycSA=
Message-ID: <8123d73f-1e65-4e3b-870d-044df0d38c76@gaisler.com>
Date: Fri, 8 Mar 2024 21:04:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] sparc32: Fix parport build with sparc32
Content-Language: en-US
To: sam@ravnborg.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-6-1f186603c5c4@ravnborg.org>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240224-sam-fix-sparc32-all-builds-v2-6-1f186603c5c4@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-24 18:42, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> include/asm/parport.h is sparc64 specific.
> Rename it to parport_64.h and use the generic version for sparc32.
> 
> This fixed all{mod,yes}config build errors like:
> 
> parport_pc.c:(.text):undefined-reference-to-ebus_dma_enable
> parport_pc.c:(.text):undefined-reference-to-ebus_dma_irq_enable
> parport_pc.c:(.text):undefined-reference-to-ebus_dma_register
> 
> The errors occur as the sparc32 build references sparc64 symbols.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Maciej W. Rozycki <macro@orcam.me.uk>
> Closes: https://lore.kernel.org/r/20230406160548.25721-1-rdunlap@infradead.org/
> Fixes: 66bcd06099bb ("parport_pc: Also enable driver for PCI systems")
> Cc: stable@vger.kernel.org # v5.18+
> ---
>  arch/sparc/include/asm/parport.h    | 259 +-----------------------------------
>  arch/sparc/include/asm/parport_64.h | 256 +++++++++++++++++++++++++++++++++++
>  2 files changed, 263 insertions(+), 252 deletions(-)

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next

Thanks,
Andreas

