Return-Path: <linux-kernel+bounces-123846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E642C890EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157921C26312
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8C5139D05;
	Thu, 28 Mar 2024 23:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klA1S4eY"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960971384A9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711670083; cv=none; b=Suozyq5byiWSH9R6K8iIL3FTRnwlM34/KXCM69W2kjMeZGiVCK+f7AiAmtiT/eP08gZz7yeZMJfpBkGCdafwxFqcBbl8bOxykeSNLoupnVch93ygnIa8Tg4BmfIOxu7ChnpqGatGOK5hlVwV+ftBLx91qIGO2/Fk6L0HenfcgFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711670083; c=relaxed/simple;
	bh=VMIqVas0Em/imAWCnPcOydqNRpReR++7rNsuANuP8EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDYObhIJGlGwemzpJOntL2NZMoAsOv5z1bZ7WSI80mJLuoRZ+blMR4MRMzMT9wTRi8XywkwFla9EnQPAUGEIPvIBdBg00R2p4Dig/EXxfSg6CcdcSB1e422d08RdwIls3G3rIyf5k+JReEAS+SIHDxLjD9NJ4NA3oJ3Houzyy3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=klA1S4eY; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d096c4d664so18937339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711670080; x=1712274880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RkGBBWFZ5WmGfshIYIQnqs6EqUiIZQQAR9cvwthSaAM=;
        b=klA1S4eYNn2KPKt9XQ9kU4m2+2arITRhvsCdtr0BX54fg6snGAbp88pWQ8DEvRXZGu
         sJqBFLLw+y+y97D+4gpYEmwRtEdqHDCYM0wm1H5Yhvsj2nUYz9KC5OxvHHjwbziuSDvo
         X0ebckuTb1iJTQpsmSALi93+fCpQsz+TUmCCtI/oX6N7hsnp7VZRxnv+Hu6DF8x8nGeu
         TgJ4QfjsloX0KsI2nw9x9QC/vjcue4GzeadnwPCLh8J0+LRsiEcxePEJn7Cw2pFJWsx1
         ETIi9H5OE75+/JiMoGF9rvcIJYLzZP62hySBUcbfnE6+Nt2n4gjwM+kBJ8m0UTgbmZxc
         f38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711670080; x=1712274880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkGBBWFZ5WmGfshIYIQnqs6EqUiIZQQAR9cvwthSaAM=;
        b=bvsBQ+L/p2gJw/Jx0w2MgMKhm7OsaugHsR/jNn1YpoP20W6CzgcxHDgS9U8nWYXOdy
         q37HOQLldv61lmYKwiVVVO2Mmf2qA0R9nTRag6TrUnVYHuony0SE12AJ2vhsN0bMS9/t
         lo6i8I6n/qhxk0ZF7V7x2HQ5t4pIJ6chaAzb0ONYJMqlVO0+/heOn0zt2rJCt8lg40PP
         c2FGzdvAb7jhyXVSGwvJ/Z/7pOvgGY60mnvGl0d496aYNXrWivobSbIObpQ2VUZHx1Px
         Xf/dowA6+c7zr3re75z0xsSfC1WzdnT7JGhD7EBHRsdbjdt43AN/t70GXpir3xs7h4Rp
         xwKw==
X-Gm-Message-State: AOJu0YynSGTR0HA3lMQbfuQ1b0TbP9eKLGqrojxB26RGw121mQvEmNge
	HCSoQUnxik/fvG0YV+kqFpsFXqvjatQZx2vnbisl4N/fVwtfDi8tkizJhD61wKnq1ZPFjdl3mDN
	ZvV2k
X-Google-Smtp-Source: AGHT+IEcd23Nn8+sPhaAXjd3sj0eS7Rw4tBE7ODvZAi/fNQtXUpuznjJetCtWzPcP7a08DaHabIdXw==
X-Received: by 2002:a6b:cdc7:0:b0:7cc:9dc:70a6 with SMTP id d190-20020a6bcdc7000000b007cc09dc70a6mr654482iog.21.1711670080625;
        Thu, 28 Mar 2024 16:54:40 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id b19-20020a05663801b300b00476d7a99f34sm633308jaq.99.2024.03.28.16.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:54:39 -0700 (PDT)
Date: Thu, 28 Mar 2024 23:54:37 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 05/11] test_hexdump: avoid string truncation warning
Message-ID: <u7hc4tkkwr5eua2p4bdetox2lqtawzb6dwimuipejhoiitbzhh@yu3e4sljhgxg>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-6-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140512.4148825-6-arnd@kernel.org>

Hi,

On Thu, Mar 28, 2024 at 03:04:49PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc can warn when a string is too long to fit into the strncpy()
> destination buffer, as it is here depending on the function
> arguments:
> 
>     inlined from 'test_hexdump_prepare_test.constprop' at /home/arnd/arm-soc/lib/test_hexdump.c:116:3:
> include/linux/fortify-string.h:108:33: error: '__builtin_strncpy' output truncated copying between 0 and 32 bytes from a string of length 32 [-Werror=stringop-truncation]
>   108 | #define __underlying_strncpy    __builtin_strncpy
>       |                                 ^
> include/linux/fortify-string.h:187:16: note: in expansion of macro '__underlying_strncpy'
>   187 |         return __underlying_strncpy(p, q, size);
>       |                ^~~~~~~~~~~~~~~~~~~~
> 
> As far as I can tell, this is harmless here because the truncation is
> intentional, but using strscpy_pad() will avoid the warning since gcc
> does not (yet) know about it.
>

We need to be careful. strscpy() or strscpy_pad() are not drop-in
replacements for strncpy().

if @l is less than the length of @data_a we might have a problem because
strscpy_pad() will eagerly assign a NUL-byte to dest[l-1].

It looks like @l could be less than the length of @data_a judging from:
        size_t len = get_random_u32_inclusive(1, d);


Let me model the potential behavior before and after, understanding that
data_a is defined as:

static const unsigned char data_a[] = ".2.{....p..$}.4...1.....L...C...";

Before (using strncpy):
p = ['j', 'u', 'n', 'k'] // example destination buffer
assume @l = 3
then we are trying to copy ".2." from @data_a, resulting in
p = ['.', '2', '.', 'k']

After (using strscpy_pad()):
p = ['j', 'u', 'n', 'k'] // example destination buffer
assume @l = 3
then we are trying to copy ".2." from @data_a, resulting in
p = ['.', '2', '\0', 'k']

because strscpy got to the end of its allowed size and didn't find a
NUL-term from its source string, so it eagerly assigns a NUL-byte to the
end, essentially truncating our string.


Here's the responsible code from strscpy's implementation:
	if (res)
		dest[res-1] = '\0';

https://elixir.bootlin.com/linux/latest/source/lib/string.c#L107

It is possible I haven't fully considered the context of this change but
I think using strscpy_pad() will cause these tests to fail, if they
aren't failing I think we're getting lucky.


Also, maybe this godbolt example can help demonstrate:
https://godbolt.org/z/nWGKraTvT

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/test_hexdump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
> index b916801f23a8..c9820122af56 100644
> --- a/lib/test_hexdump.c
> +++ b/lib/test_hexdump.c
> @@ -113,7 +113,7 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
>  			*p++ = ' ';
>  		} while (p < test + rs * 2 + rs / gs + 1);
>  
> -		strncpy(p, data_a, l);
> +		strscpy_pad(p, data_a, l);
>  		p += l;
>  	}
>  
> -- 
> 2.39.2
> 

Thanks
Justin

