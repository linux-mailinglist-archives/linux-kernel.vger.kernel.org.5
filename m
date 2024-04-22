Return-Path: <linux-kernel+bounces-153324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF468ACC95
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946B1285B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6916F1474D2;
	Mon, 22 Apr 2024 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="l1EPz2U5"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13135146D68;
	Mon, 22 Apr 2024 12:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787910; cv=none; b=W/UutojJxgFaSW/OXfEPdM414KB9GF5krqMSSQLR9Lhy3/5KHJqeEiSXGdJ4q31I6Oc+943ERzEbwEMHf5CD1nKRGZOG40mscfH9BakNe2ZjyTQJVqks4RdK9zq6Bv/TqTjuaFDljYUxhVewuLTJOk9QrcT8n9RO/8IwaD1J23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787910; c=relaxed/simple;
	bh=0RqZ8KagO4Q/Xy/eMr+HE9uqmC9LKNkqCfOaFm6Rg1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bRcA6/P2e5uR46Ag9qduCmTYg1+uYe//zveQ1v6WmT2DoqJ/KZOhdQA8+3xFJ04824lLijjpvIFJxrIGP63EEEaAE1VqCtopKxvBpSHxSSdFBrFv8xd3zGuWu+9JgRrlFUZyG5QtfdusOIM+443lh3pOZtAN2+wi55qMK5oXb7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=l1EPz2U5; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4VNP8x3wp5z682J;
	Mon, 22 Apr 2024 14:05:53 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4VNP8x1jvGz6825;
	Mon, 22 Apr 2024 14:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1713787553;
	bh=u0bxJB2sYnBuzK5oog8Kn+uP3uWEoY8hqnJZITNxRRQ=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=l1EPz2U54XXKmoSbQzYsa6dHV9IKDZ+Bh6zW8A1n6GJsmWWlTMQUT0IXJCItH9vdt
	 Io3j5ZZfwELaTrGdHgkHR8Uwm1s/LeVZ45l3c/fWgEgLxKy3pfQuH6dtAo5cZCJ4rA
	 oKQ5FH4LvOQG6JlRjCjlfdjSfd9Pedr3W/lva9wg=
Message-ID: <13d29637-4208-42b4-b377-1ffe0c1c4ec6@gaisler.com>
Date: Mon, 22 Apr 2024 14:05:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: move struct termio to asm/termios.h
To: Mike Gilbert <floppym@gentoo.org>, "David S. Miller"
 <davem@davemloft.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240306171149.3843481-1-floppym@gentoo.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240306171149.3843481-1-floppym@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-06 18:11, Mike Gilbert wrote:
> Every other arch declares struct termio in asm/termios.h, so make sparc
> match them.
> 
> Resolves a build failure in the PPP software package, which includes
> both bits/ioctl-types.h via sys/ioctl.h (glibc) and asm/termbits.h.
> 
> Closes: https://bugs.gentoo.org/918992
> Signed-off-by: Mike Gilbert <floppym@gentoo.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/sparc/include/uapi/asm/termbits.h | 10 ----------
>  arch/sparc/include/uapi/asm/termios.h  |  9 +++++++++
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/uapi/asm/termbits.h
> index 4321322701fc..0da2b1adc0f5 100644
> --- a/arch/sparc/include/uapi/asm/termbits.h
> +++ b/arch/sparc/include/uapi/asm/termbits.h
> @@ -10,16 +10,6 @@ typedef unsigned int	tcflag_t;
>  typedef unsigned long	tcflag_t;
>  #endif
>  
> -#define NCC 8
> -struct termio {
> -	unsigned short c_iflag;		/* input mode flags */
> -	unsigned short c_oflag;		/* output mode flags */
> -	unsigned short c_cflag;		/* control mode flags */
> -	unsigned short c_lflag;		/* local mode flags */
> -	unsigned char c_line;		/* line discipline */
> -	unsigned char c_cc[NCC];	/* control characters */
> -};
> -
>  #define NCCS 17
>  struct termios {
>  	tcflag_t c_iflag;		/* input mode flags */
> diff --git a/arch/sparc/include/uapi/asm/termios.h b/arch/sparc/include/uapi/asm/termios.h
> index ee86f4093d83..cceb32260881 100644
> --- a/arch/sparc/include/uapi/asm/termios.h
> +++ b/arch/sparc/include/uapi/asm/termios.h
> @@ -40,5 +40,14 @@ struct winsize {
>  	unsigned short ws_ypixel;
>  };
>  
> +#define NCC 8
> +struct termio {
> +	unsigned short c_iflag;		/* input mode flags */
> +	unsigned short c_oflag;		/* output mode flags */
> +	unsigned short c_cflag;		/* control mode flags */
> +	unsigned short c_lflag;		/* local mode flags */
> +	unsigned char c_line;		/* line discipline */
> +	unsigned char c_cc[NCC];	/* control characters */
> +};
>  
>  #endif /* _UAPI_SPARC_TERMIOS_H */

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Sorry for the wait. I did not have time to vet it enough for the last
cycle.

Thanks,
Andreas

