Return-Path: <linux-kernel+bounces-89625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EDB86F32F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 00:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4529D1C21643
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 23:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E31253E39;
	Sat,  2 Mar 2024 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jPcygT/x"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29A1FB2;
	Sat,  2 Mar 2024 23:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709423644; cv=none; b=biW5rrdkK8PhsAdVlTvaNJP/8pIfgKzLclNu1cgq5WZYKuNXx6LUjTMnHTxXsr5ksu9XBB3dp1agS4HdnCehv8iO3tZEEPpUK8SAElZDo6dnotW0Emimp4aAJ9WaiAc91vcJdGU+tnaiqTIG1CcIa1dXRL5eozf5rARLqySbmoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709423644; c=relaxed/simple;
	bh=05dr3QBGjLcG8bLfMQxmFebKi1hG0Y+b2mQbXTJXf/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7InP6CqBakhTVXwdkkBWRYw8j/C06OvfinrvQNA4TBTtB/CoJAffG5rEmOQfeg2dfGtcXYfjV5BrrnystPiiHaiPNdvf5VUoyfqX389wEd3KdosayYPTe1iCKVvi+41ZN+UrCo8WoIk6nYraHzRIRixq9M6J5MGNCXdETg+BF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jPcygT/x; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=rRSxRq4RYizaA5xPGXgzWmpBCTInsuqB/CJzht9r6cQ=; b=jPcygT/xGUKMPQQlsh5xGz7c/z
	opWDep6LuPQwB4+hFtRmqPKmNPbPXYMGUy6Mu8W0ckfxwHa5ph3CKDne2d8NoxzQliAB2mAypp7Xb
	XdI0cCv1Xw0j4DCItw8mSQYyNo0hhiqxbz2lfngDawhtUqJ6cDhbZUlP1jeFr6vcTbQL2ME2mOFGu
	FhRtIrj+ySvPTqN3hDZskCOz0f6MiuGEwzNxJueN8VCNsWB/dxE1Gmj+ODF2NbvbPI80LVUTzQQQ/
	Kjrskk5vjRdzoYsn0L2apiuPYOhNUJltdM5AFLngjsvzGl0FJI24bYYxf5j+XbV3O+4UYPy8FHszU
	CldGkbXA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgZB4-00000004gky-0LOv;
	Sat, 02 Mar 2024 23:54:02 +0000
Message-ID: <0bb239ef-013f-4bdb-9d8e-a288f39438d2@infradead.org>
Date: Sat, 2 Mar 2024 15:54:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] sparc32: Fix section mismatch in leon_pci_grpci
Content-Language: en-US
To: sam@ravnborg.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-7-1f186603c5c4@ravnborg.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240224-sam-fix-sparc32-all-builds-v2-7-1f186603c5c4@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/24 09:42, Sam Ravnborg via B4 Relay wrote:
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

Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

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

-- 
#Randy

