Return-Path: <linux-kernel+bounces-82454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9258684C0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EECF1C22859
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C83135A54;
	Mon, 26 Feb 2024 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrrY1OhD"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B5130AF8;
	Mon, 26 Feb 2024 23:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991328; cv=none; b=aqJAi4EjiFDSdmRhHujwY6OtYiDbDNyjUC0TYpM4XwyHmEoeGgUYVNUY1kJT6mJYZ3EdPl66akCINHIK56nqwd1YuQOjBYnsURLo+MkP1NllwEQh0YeqYO0//BKoQVfKiyq5EMYI5UzqRgKfpsS6yl5L87b75J1Ko4A1qZc+l5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991328; c=relaxed/simple;
	bh=ixp5JSyncHGTKZG5WBut4A4voY2Dr6Rn4Cc/lEMaCrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lw7K1ghLzqSZ9UScQIYJ3y9Zf2ZfzhphWNX1aG2aoIY2lwkKQ+4WfS+/MnW8FnAzgIiZgDtm1/NOiMh1kRjU3mXjK701VopL7jNwPEbLYkgPhvGZgl99X5wmOc28+M7JQNy0guT6w6DhnhuZPC1O6IHxfXhTic4FIzePGhyCMnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrrY1OhD; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2881144a12.2;
        Mon, 26 Feb 2024 15:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708991326; x=1709596126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SagLQ4XBLMTETOCPFMWWuB4VsNBtkMPNCTNl4Vlg8BI=;
        b=IrrY1OhDWW2BeJMyu9lS+CZDNyo9ILGQEZ5JioBwSBauwUlyTk5vc877YyyhDj1pJY
         11kueo34dywt08T6gblyaW8P6e1z/dzOP1HiHd9bgnt1u3Ql9Cfg+BnRJ1mpBE4I4n9S
         g5KAt5r9+veCX+JD1yu4dsw+3qfa85g9iHSo5fzuYd1k9FhqjKApSeh6PRvZazCD9IFB
         61P4BPfXBOeIV35U4pMatYsfxymo1+P5MfZ3co7VJQCYeXl6OFyblhILdR7ldGcjb8Gz
         iRf1jO/VNFm4TZFhH0LCECjvfO3hAbscP9YXzfedE0lKR6KUfUZnTQe990jyzEKa0OdS
         t9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708991326; x=1709596126;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SagLQ4XBLMTETOCPFMWWuB4VsNBtkMPNCTNl4Vlg8BI=;
        b=NwGSPeyYObvD3jGvF9IIPB9sujq3z7YGXH6ylmSwavBW2p+f0mWokgNqSTuODhNp2/
         srEfmFP3n1uVSz2kt+48TxO94V1Nw8t94zt+gJ52ErPrwQggcAtxTwMOGbesB6hBYOEP
         zYLLdgKqyXYT9+15C/svNzdtZXPt1ZSip9ZzNjc9FZRB2zUA+UluqfFzgtNRRAcw+zt6
         jn6kaKh+cZTOhT4Lfp+5CGj0BcllK9LGPYEWxkJ1RrvuDuMTnTvkXWmlVfn0DJE885Zs
         eBewQSIeEePjlZ4C6PzeXE//vkDdoHAlBHHuwoNZJ/e8orOtInWp3FXBo5D7r6ebqjIi
         Ul7A==
X-Forwarded-Encrypted: i=1; AJvYcCXj2m1hDbc2mzwBsfvpndEJyrHaBf1POopNaB0hQPe3sPwo1shTs8lFfQR75zPbOCuAGDJ4fuJ3tX/Y5CYtwEtfQUbSgsXclWRhI93wjr7oFvaaFj1XmUd33VOuF7XB54UYBKpWEBsNNRJw
X-Gm-Message-State: AOJu0YytTDbG6U0va04kxtu4uRPsxVZrC5u++n9itgBJBzv+AD8NMKY6
	9L/eQnUxWF4q/P4itkpixnKcv6v3+9KVrML+ii+pvIx9mU0ZXIOt8vLheGrn
X-Google-Smtp-Source: AGHT+IEd4JtteGdpz7ZGNlzJpYV8Sd55DLhxeLdzfOyOHpbhNvT8jNk7iGVOOXKUH7CSzEuWaDgQXw==
X-Received: by 2002:a17:902:dac1:b0:1dc:af70:8c44 with SMTP id q1-20020a170902dac100b001dcaf708c44mr2799124plx.17.1708991325974;
        Mon, 26 Feb 2024 15:48:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id lc13-20020a170902fa8d00b001d911dd145esm229448plb.219.2024.02.26.15.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 15:48:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
Date: Mon, 26 Feb 2024 15:48:43 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 David Laight <David.Laight@aculab.com>
Cc: 'Russell King' <linux@armlinux.org.uk>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
 <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk> <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com> <Zd0b8SDT8hrG/0yW@ghost>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Zd0b8SDT8hrG/0yW@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/24 15:17, Charlie Jenkins wrote:
> On Mon, Feb 26, 2024 at 10:33:56PM +0000, David Laight wrote:
>> ...
>>> I think you misunderstand. "NET_IP_ALIGN offset is what the kernel
>>> defines to be supported" is a gross misinterpretation. It is not
>>> "defined to be supported" at all. It is the _preferred_ alignment
>>> nothing more, nothing less.
> 
> This distinction is arbitrary in practice, but I am open to being proven
> wrong if you have data to back up this statement. If the driver chooses
> to not follow this, then the driver might not work. ARM defines the
> NET_IP_ALIGN to be 2 to pad out the header to be on the supported
> alignment. If the driver chooses to pad with one byte instead of 2
> bytes, the driver may fail to work as the CPU may stall after the
> misaligned access.
> 
>>
>> I'm sure I've seen code that would realign IP headers to a 4 byte
>> boundary before processing them - but that might not have been in
>> Linux.
>>
>> I'm also sure there are cpu which will fault double length misaligned
>> memory transfers - which might be used to marginally speed up code.
>> Assuming more than 4 byte alignment for the IP header is likely
>> 'wishful thinking'.
>>
>> There is plenty of ethernet hardware that can only write frames
>> to even boundaries and plenty of cpu that fault misaligned accesses.
>> There are even cases of both on the same silicon die.
>>
>> You also pretty much never want a fault handler to fixup misaligned
>> ethernet frames (or really anything else for that matter).
>> It is always going to be better to check in the code itself.
>>
>> x86 has just made people 'sloppy' :-)
>>
>> 	David
>>
>> -
>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
>> Registration No: 1397386 (Wales)
>>
> 
> If somebody has a solution they deem to be better, I am happy to change
> this test case. Otherwise, I would appreciate a maintainer resolving
> this discussion and apply this fix.
> 
Agreed.

I do have a couple of patches which add explicit unaligned tests as well as
corner case tests (which are intended to trigger as many carry overflows
as possible). Once I get those working reliably, I'll be happy to submit
them as additional tests.

Thanks,
Guenter


