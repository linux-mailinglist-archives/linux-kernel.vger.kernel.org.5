Return-Path: <linux-kernel+bounces-97533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA72876B8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1531F21DA1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6A45B5D2;
	Fri,  8 Mar 2024 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="a2Giue5x"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE615B5BF;
	Fri,  8 Mar 2024 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709928482; cv=none; b=XjyHdp3keUBWKqqdWGupKur12LTip9XNShOnhpvnHMSvEssBr0lfmjoANT0a7Jk0pxb3N5cX7ewVB+as2dBYRSArllSegjKY1sQ/tWtMb3+17pdruMSf6wOG2xz5Iqxz9LN3/8VIZxgsRQ8JH/n5lfUWAELQZtFbgcHQpHYSJBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709928482; c=relaxed/simple;
	bh=xAERMgCujrfifEteuSUDjxAfd4XIhWAnKbg9DxQgEOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5qTzd36n76bZVXX2uO84AvnSL+96Tp+nADrVjE53uutRvkwdYkkOpR5GXuslJZp86LIdg3nwHI8koMw84oS7VUmnP1i68EDCX4XCjGE5787e0WUYMP0LUcJmnjstEAKsKIMvbU9FkNkqMQ0zd6IqHz/av83Ht3qEeVpMTcg5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=a2Giue5x; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Trxzy4tCwz6832;
	Fri,  8 Mar 2024 21:07:58 +0100 (CET)
Received: from [10.10.15.2] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Trxzm3bdGz684f;
	Fri,  8 Mar 2024 21:07:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709928478;
	bh=He/UK3oqyjgGWmXjpK0wImcsBcgiNZLdqiQiyB3AFhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a2Giue5xXMen8T06EOdnB+qokmVCZyIE15Bda/dK7fd9KtxVT8E5Km0saQ/YjnVDb
	 NY/oKqS7V5xmmg/Jd6DPs5RbXMtkHTVK7usXg8sP5r/J078V5/aA9OxuaG1sSU8Rdj
	 9BUPXsTr5egvIkOk+OwSD0q/7nXNevTJSj/Ykg6A=
Message-ID: <248d38bd-c116-47fd-af57-3379d1770aee@gaisler.com>
Date: Fri, 8 Mar 2024 21:07:47 +0100
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
 sparclinux@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-7-1f186603c5c4@ravnborg.org>
From: Andreas Larsson <andreas@gaisler.com>
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
> ---
>  arch/sparc/kernel/leon_pci_grpci1.c | 2 +-
>  arch/sparc/kernel/leon_pci_grpci2.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

