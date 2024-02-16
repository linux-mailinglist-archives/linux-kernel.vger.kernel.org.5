Return-Path: <linux-kernel+bounces-68082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A56D28575C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C101F26008
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1513B134CC;
	Fri, 16 Feb 2024 05:51:08 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64910A14;
	Fri, 16 Feb 2024 05:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708062667; cv=none; b=ZRap7o57PghSXPgsZBEQCnzYEt1+OwwUy9/HQ03SbpoS7ptcz7mRW56Jj+BkipQa1+lHfwqbIkUHQagSvpG9i7jmZMy7rqCFl981PHdf8xnDWwpALiTMF9/alljLQk3qE1Uw+6OOB4mMEK4wXdi4/A4pWDYlG1PnAulz1von9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708062667; c=relaxed/simple;
	bh=9rZKsyOoCKj6E9THwPpdsGt67sOZ8Q+IWLlb2zcX9IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h72ZitSmG2585uf8P/+D1slWm6Av1U1NilJmQXayW0bkdCvCqOwy1QgQrlGpc05w+AyQpbDLbuKJPcF6b3DBWXguemDBdkXHK+e4uHZf7I2twJ4IXfaJpVGtu1mVfui1LKu1sCQ5mGNb3HAC7cF18X/+TyQUiC7nB8cTORNWnbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3debe0167fso4142966b.3;
        Thu, 15 Feb 2024 21:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708062664; x=1708667464;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IJcqBM4AFMc8rESpz2jSqycnTh4AdiOmWZgKEMQkbs=;
        b=UY6VOhHGXxu9NNALNdgEUZ2wxDaxK4e9itMb3oZfJKkc/rjjGjokMh72jaUR/demJP
         5UxdXr/d/BeCS3qotZK+Cb1R2ZzxieXEgpIGXauR4qxw2HEi7TBTCWYP32nz9yaw7en4
         nj/Q7ssUc99jDu6ywOozLJldMxbvKW6Ga8S3uDK4ZBDA0LE1Gv0weLUiCdqS3EeG6q9K
         Mo3Rq2ICT8vxisDNsaPxxIYhqi5kybJPZYP67gkqPTt/ZFJYDnjhaZoziXSK3IFzqby4
         LYltFAJkkGqUJ/X8SLn5kUb+kj8i0rjyBrKVUcK3F7o3QseK1hRMv33ioPuBzM+zqYKe
         74/g==
X-Forwarded-Encrypted: i=1; AJvYcCVoHCxTd6L021xVtkrBHJ81y6IlCVYM71rcNdSu60A0aFsoLydbxBHrT5tADVSHCjWiIHE5QpG1MjREoh458MJL7CoEfw53ecOjcxgIydM5R8zix1Qd0Kr7g9AuMutfLJ0oKpd7fJ9HmV6xmGqSmQlXKd3erLeoM7eyf4akbM5KUtEdwZ4Nxg==
X-Gm-Message-State: AOJu0YxukU1xm6sEGqlGnlFzCJJberM9shzOFXUxiyjqSvs7wves3Fny
	EPyMYJ8kw15KDl7/t5tNxkXaQtV/8ZrJcBdX8jbGhpiHuwpj855W
X-Google-Smtp-Source: AGHT+IE3zVHWzluAYMQpd8B3AD71HdCd6uSrUDvaD3mABUJnL8gpPhg+c+tdWIOPwId2e7KmF/Aoag==
X-Received: by 2002:a17:906:6c6:b0:a3d:4:8511 with SMTP id v6-20020a17090606c600b00a3d00048511mr2648020ejb.69.1708062663773;
        Thu, 15 Feb 2024 21:51:03 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id ti1-20020a170907c20100b00a3d90d6fca8sm1194944ejc.8.2024.02.15.21.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 21:51:03 -0800 (PST)
Message-ID: <4971bda5-e337-4c40-b7bd-5da4b7dae5d7@kernel.org>
Date: Fri, 16 Feb 2024 06:51:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tty: mips_ejtag_fdc: Fix passing incompatible pointer
 type warning
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Stephen Rothwell <sfr@rothwell.id.au>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mips@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240215171740.14550-1-fancer.lancer@gmail.com>
 <20240215171740.14550-5-fancer.lancer@gmail.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240215171740.14550-5-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15. 02. 24, 18:17, Serge Semin wrote:
> mips_ejtag_fdc_encode() method expects having a first argument passed of
> the "u8 **" type, meanwhile the driver passes the "const char **" type.
> That causes the next build-warning:
> 
> drivers/tty/mips_ejtag_fdc.c: In function ‘mips_ejtag_fdc_console_write’:
> drivers/tty/mips_ejtag_fdc.c:343:32: error: passing argument 1 of ‘mips_ejtag_fdc_encode’ from incompatible pointer type [-Werror=incompatible-pointer-types]
>     word = mips_ejtag_fdc_encode(&buf_ptr, &buf_len, 1);
>                                  ^
> drivers/tty/mips_ejtag_fdc.c:216:24: note: expected ‘const u8 ** {aka const unsigned char **}’ but argument is of type ‘const char **’
>   static struct fdc_word mips_ejtag_fdc_encode(const u8 **ptrs,
>                          ^~~~~~~~~~~~~~~~~~~~~

It's a correct change. But why the compiler complains, given
KBUILD_CFLAGS += -funsigned-char
?

> Fix it by altering the type of the pointer which is passed to the
> mips_ejtag_fdc_encode() method.
> 
> Fixes: ce7cbd9a6c81 ("tty: mips_ejtag_fdc: use u8 for character pointers")
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>   drivers/tty/mips_ejtag_fdc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
> index aac80b69a069..afbf7738c7c4 100644
> --- a/drivers/tty/mips_ejtag_fdc.c
> +++ b/drivers/tty/mips_ejtag_fdc.c
> @@ -309,7 +309,7 @@ static void mips_ejtag_fdc_console_write(struct console *c, const char *s,
>   	unsigned int i, buf_len, cpu;
>   	bool done_cr = false;
>   	char buf[4];
> -	const char *buf_ptr = buf;
> +	const u8 *buf_ptr = buf;
>   	/* Number of bytes of input data encoded up to each byte in buf */
>   	u8 inc[4];
>   

thanks,
-- 
js
suse labs


