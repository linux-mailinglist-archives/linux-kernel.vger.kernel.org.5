Return-Path: <linux-kernel+bounces-92577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FAB87226B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1042528291F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7747E126F37;
	Tue,  5 Mar 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="liXzRDI1"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E49F4683;
	Tue,  5 Mar 2024 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709651231; cv=none; b=jt9dkIvNmgqdmmHD2kh0dhDMDnMRU5GrRUOh4to4AoV15czCZQn4CpWVGoUsfw8qobLcT2d94Q/nK1k+90gB0S2wJ3MtR/jP1sv47UdbQVORhF/dlZSeG+uvHMV6crr4+LjeDIOgKb06XXDlcKSXPC0BpQCTfdYh4mCuGf1CO9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709651231; c=relaxed/simple;
	bh=j45/arG1jTvfPCM3g2slpD39IyQbQuMb0o2+3UhyDDQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lb7nIgkGmrntOTydJu/QngSFYOQw5UyBsID0HyRmFzBqlxCNCs48FXa3Y15SMGNmiSUo/G3B/uqfa5/ISgJ+yDEXEHNSMZkv/Q4RYwraYeWg17QQPve71Lyi5yXp92jlC7cweQyY6QvZEBA6uCcuK/op1kLWsTECfmtGe0B7blk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=liXzRDI1; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TpzS66ZZDz684B;
	Tue,  5 Mar 2024 16:07:02 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4TpzRx4KpNz684Y;
	Tue,  5 Mar 2024 16:06:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709651222;
	bh=VetxK7yjRtnH1XgANvoOGGg9D35KX7NCD1vfFBjm0IU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=liXzRDI1gYzFNvWsoFw06B9/hCOt22Y5AnFAH2sKKKrkRGIME570mJ60DLtRJov4p
	 f9eibKo2lpxkQQE64AWk9msiez/qlQhyY+2W2NIBybI3wX7h709oLKGtq+Z+lGBz06
	 X2m9YBQftWzTXfPiw/C1dM9UVzLjiWV1iO0GbkR4=
Message-ID: <b62d0ae6-c2cb-4f2c-b792-2dba52a44e35@gaisler.com>
Date: Tue, 5 Mar 2024 16:06:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v2 7/7] sparc32: Fix section mismatch in leon_pci_grpci
To: sam@ravnborg.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Arvind Yadav <arvind.yadav.cs@gmail.com>
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-7-1f186603c5c4@ravnborg.org>
Content-Language: en-US
In-Reply-To: <20240224-sam-fix-sparc32-all-builds-v2-7-1f186603c5c4@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-24 18:42, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> Passing a datastructre marked _initconst to platform_driver_register()
> is wrong. Drop the __initconst notation.
> 
> This fixes the following warnings:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: grpci1_of_driver+0x30 (section: .data) -> grpci1_of_match (section: .init.rodata)
> WARNING: modpost: vmlinux: section mismatch in reference: grpci2_of_driver+0x30 (section: .data) -> grpci2_of_match (section: .init.rodata)
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>

Could you also add

Fixes: 4154bb821f0b ("sparc: leon: grpci1: constify of_device_id")
Fixes: 03949b1cb9f1 ("sparc: leon: grpci2: constify of_device_id")

for these fixes in your v3 of the series as well as CCing stable?

> ---
>  arch/sparc/kernel/leon_pci_grpci1.c | 2 +-
>  arch/sparc/kernel/leon_pci_grpci2.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/kernel/leon_pci_grpci1.c b/arch/sparc/kernel/leon_pci_grpci1.c
> index 8700a0e3b0df..b2b639bee068 100644
> --- a/arch/sparc/kernel/leon_pci_grpci1.c
> +++ b/arch/sparc/kernel/leon_pci_grpci1.c
> @@ -697,7 +697,7 @@ static int grpci1_of_probe(struct platform_device *ofdev)
>  	return err;
>  }
>  
> -static const struct of_device_id grpci1_of_match[] __initconst = {
> +static const struct of_device_id grpci1_of_match[] = {
>  	{
>  	 .name = "GAISLER_PCIFBRG",
>  	 },
> diff --git a/arch/sparc/kernel/leon_pci_grpci2.c b/arch/sparc/kernel/leon_pci_grpci2.c
> index 282b49d496ea..9f662340b5b2 100644
> --- a/arch/sparc/kernel/leon_pci_grpci2.c
> +++ b/arch/sparc/kernel/leon_pci_grpci2.c
> @@ -889,7 +889,7 @@ static int grpci2_of_probe(struct platform_device *ofdev)
>  	return err;
>  }
>  
> -static const struct of_device_id grpci2_of_match[] __initconst = {
> +static const struct of_device_id grpci2_of_match[] = {
>  	{
>  	 .name = "GAISLER_GRPCI2",
>  	 },
> 

Thanks,
Andreas

