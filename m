Return-Path: <linux-kernel+bounces-97528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052DC876B80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C698B21EB7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF1A5B5BF;
	Fri,  8 Mar 2024 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="UmXVH8j7"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496245A4C0;
	Fri,  8 Mar 2024 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709928179; cv=none; b=QIWnSbdNy6kcjGQmUrV8QHbVNTLyAJtNdREco+sxc7Xk3Jkca0A3SAbA8FM7S9XWgsUCQz9l/mtxUiekTbyyUFJhAtXK2EhYJoiB2VH5UOHYjEU9I31ZRcFbJBhsvcChoFVai+NOina4q/T78hihTaL9d/pnw2kLuJ9w48gMbvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709928179; c=relaxed/simple;
	bh=d98GKJgmh5Nx+V6KEeGFBKiNVY6AJ4EQOHTAtJvi6VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NW0Lwd5iMKHfE6VQCUc3LLvePKEAEbEnId8t0S39WJ4g7/ik1fgg5GsXIwAFk3JpVhm9NHgS7BxFOtBfpZag7qRaPc01B9GF9t94KLIKCb4O2k+OMEfcj4DYCLqnFNIu2i5E/K9Gaejxh/cLTW7tB05B0/LjhTMoWET4Z/LyRNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=UmXVH8j7; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Trxt64dsmz6846;
	Fri,  8 Mar 2024 21:02:54 +0100 (CET)
Received: from [10.10.15.2] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Trxsw2115z684F;
	Fri,  8 Mar 2024 21:02:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709928174;
	bh=WKA9lhOVmAskHzFLoRsXxMRAsa7r5WVUoGYW7jspdQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UmXVH8j7d7XKSCkXm+1gOc2ifuJVQbAOhrBn3g5wzc+5U1LVSYC2pIVknjnCw43DJ
	 IvtQpNAzN8tKr18JOBhxP+LIpJf7u414MOJdqLIr68llbUBaoSY+z49KYkOvKgbTNF
	 28WmerxA3JQCre9+uWDAnpy8445W7mnMk7udtrlw=
Message-ID: <19d0affc-ebe4-44d8-b4d3-f5bf4312b75a@gaisler.com>
Date: Fri, 8 Mar 2024 21:02:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] mtd: maps: sun_uflash: Declare uflash_devinit
 static
Content-Language: en-US
To: sam@ravnborg.org, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 sparclinux@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-parport@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20240224-sam-fix-sparc32-all-builds-v2-0-1f186603c5c4@ravnborg.org>
 <20240224-sam-fix-sparc32-all-builds-v2-3-1f186603c5c4@ravnborg.org>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240224-sam-fix-sparc32-all-builds-v2-3-1f186603c5c4@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-24 18:42, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> This fixes the following warning:
> sun_uflash.c:50:5: error: no previous prototype for 'uflash_devinit'
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Fixes: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes globally")
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> ---
>  drivers/mtd/maps/sun_uflash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

