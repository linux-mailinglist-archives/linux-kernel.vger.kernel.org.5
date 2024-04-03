Return-Path: <linux-kernel+bounces-129800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A29E897011
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC141C27539
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4EC147C9C;
	Wed,  3 Apr 2024 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EvFPEsjb"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B9E147C89;
	Wed,  3 Apr 2024 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150273; cv=none; b=srVof8D23pRCeXKtwX/zPDJ3bWI0+l1HR0ftTXK8a/OGZzkaCYAecv0xxRNIFjVXMckitv+BUA2rhKNTyI1QyapLfTgRQWbEe0pnQPAEX1KZrtBDZq+lxzx5xnE/1vYl+5W8AJfPIODO2sn2yWSEbx4XPH31TPkbamSECC4EEYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150273; c=relaxed/simple;
	bh=/GQ4nlYWXIxaFwy7GEB/PMFxbW1s4CmxkzraRVC432c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FvaQcpS2SzDBMRhmuOfrgoYTRRUXkWkQXMMbi2TLSE3BRQCFnnLzZYHm0mevQ0LDDDJWeNTdjbzCxG5mIHwwicYgwUnwGvslRXAPDxnqfMQNmKdMZrV7dcNltd0BN6jr/dJ6IVAioohzDn8V2I0H6bbOEO3yEcp4WTNk3UPdL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=EvFPEsjb; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 930E047C42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712150266; bh=vtB2kvFb83ghMvG0XB3eZHkEo5w776S5gMAFRtOloHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EvFPEsjb6+voJdd1pI3kYT1oQzfUUXg693BhE5Xb4wwM6dOUVZDs/yd6M4M/mrxC3
	 QpF84qYNcccFfyJvPURNO1Fmd0nnyaOL6EZXwwsX/Hz1I8qANp/JTFRai4+nrjMOZn
	 CCW6KxlU6AMyeBk2ZYhPxql23DlYxDtbyY4MgL0ffq87On0Rgpe7dSUGPKX5BTXES1
	 pIAUOWM4z+0sFUvr+1llbuz7aiIPnnOX0KSqgEWem9wzP+DiSJdblpK1Ea95phW5P7
	 U+uMFMl80TG1LppJLYslg/j8SCEPEqQNRhxa8ThJ0hFfDs21Ge15fUwLbA9r0EYZKH
	 +Kih6f33AVbxQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 930E047C42;
	Wed,  3 Apr 2024 13:17:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>, Carlos Bilbao
 <carlos.bilbao@amd.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Kaiwan N
 Billimoria <kaiwan.billimoria@gmail.com>
Subject: Re: [PATCH] docs: Add relevant kernel publications to list of
 books; LKP 2E
In-Reply-To: <20240403050824.166787-1-kaiwan.billimoria@gmail.com>
References: <20240403050824.166787-1-kaiwan.billimoria@gmail.com>
Date: Wed, 03 Apr 2024 07:17:45 -0600
Message-ID: <8734s2twjq.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kaiwan N Billimoria <kaiwan.billimoria@gmail.com> writes:

> Hi Carlos, Jon,
> As the 2nd edition of my 'Linux Kernel Programming' book is recently
> published (29 Feb 2024), this patch is to request it's addition to the
> book list.
> I've currently kept the 1st edition as well (in reverse chronological
> order); if this isn't required, pl let me know..
>
> Regards,
> Kaiwan

Happy to add the book but ... surely the author of said book wants to
set a good example by sending a properly written patch?

- A changelog in the kernel style saying simply what is to be done and
  why

- Stick to the 80-character limit (we still really try to do that for
  text)

Thanks,

jon

> Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> ---
>  Documentation/process/kernel-docs.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
> index 8660493b91d0..f73671b65a71 100644
> --- a/Documentation/process/kernel-docs.rst
> +++ b/Documentation/process/kernel-docs.rst
> @@ -75,6 +75,15 @@ On-line docs
>  Published books
>  ---------------
>  
> +    * Title: **Linux Kernel Programming: A Comprehensive and practical guide to Kernel Internals, Writing Modules, and Kernel Synchronization**
> +
> +      :Author: Kaiwan N Billimoria
> +      :Publisher: Packt Publishing Ltd
> +      :Date: February, 2024
> +      :Pages: 826
> +      :ISBN: 978-1803232225
> +      :Notes: 2nd Edition
> +
>      * Title: **Linux Kernel Debugging: Leverage proven tools and advanced techniques to effectively debug Linux kernels and kernel modules**
>  
>        :Author: Kaiwan N Billimoria
> @@ -91,6 +100,7 @@ Published books
>        :Date: March, 2021
>        :Pages: 754
>        :ISBN: 978-1789953435
> +      :Notes: 1st Edition
>  
>      * Title: **Linux Kernel Programming Part 2 - Char Device Drivers and Kernel Synchronization: Create user-kernel interfaces, work with peripheral I/O, and handle hardware interrupts**
>  
> -- 
> 2.40.1

