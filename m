Return-Path: <linux-kernel+bounces-30838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5233F8324F1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCDA5B2159B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEDFC2D6;
	Fri, 19 Jan 2024 07:14:21 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95296FAF;
	Fri, 19 Jan 2024 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705648460; cv=none; b=t1Zd0oW4Yt6xcVmeMTFe/kXv2rM0UWYZRlMqMMVv1W+Y/SimBfmvAdLvNx34ErIEzo2jf+VYZGPLvc9PaHDV7RH9alshZHdh32ntAQeDyI428N31fEbeX5YQxW70EUjAKXp9Q8JOyRMifR6AJfCbPMIitKB2lyivzqm+ozmKsZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705648460; c=relaxed/simple;
	bh=/gxn/jFgHsQXiBInw7pnc+b9451HlXJVs4xIbsm4tJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmdQmPEK51p3rfLmdRAAaoSUDdttVo42WTtcmQJ6Un/zqfAOOM+6ucgFb0BNKazTIKqhTvps6Wqd+kBI3y2g15EBdbqXthCuchHxpFsvLE2ONmz1ZQliTPB9573FkPe3jpkOeep9IjgoIgbX1owWq8eTeD82l7WQMmR/rvM6gTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e9ed20ffcso1646495e9.2;
        Thu, 18 Jan 2024 23:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705648457; x=1706253257;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+LizfPHsG6bAopC0j/zp9dPrP6kGMGuwGSFDeP/7og=;
        b=RV/y/c47mpvnbgewabw1nZHdIIVJc1beF9i06zmdHlVQZXCIOV6i01wwX/610K93Wm
         ULU7RynznsH1ksWvHrKjJEoWm7FJsBRd/a7AZXVVdyLupXOdJzgDMcEnkAT+lXJrmkUW
         /xhBSu/53vkPdWRBxGheZBrWnEHDseY1jteQNGlHxZNom+SyI2ANoPsYFGNFhOv4y6B9
         YSHKRhss8jHCNZ9XH8BSGJguRVMf9wsJEFFu85Lq19iPwOj950iNuAIJ5TS/wgif+WDH
         DtG9inBj0DXm+FfXeijh4sIt8AK6zL5scdgCryiiKb5DQXtkJ2PmjjB085P4ss3b0DNM
         23LQ==
X-Gm-Message-State: AOJu0YyVQlWn2unFYBsjVZv9gGtY0ZshqPjgMSdb5P3Bg1gnvV+W6XaY
	yvVxl9PtDrvxNwpfQty5RmJ+5Xhv7Gj4Al3GGIp+N8yPjqsii4mY
X-Google-Smtp-Source: AGHT+IES8Kj3wvqTHYHlen8zHCbUM9Zer9QbNEQo0wjeHqrdaNh08XXHRq1MtMu1cULMya4AMiSDJA==
X-Received: by 2002:a05:600c:5d5:b0:40e:6b7f:5ca9 with SMTP id p21-20020a05600c05d500b0040e6b7f5ca9mr1439501wmd.80.1705648456979;
        Thu, 18 Jan 2024 23:14:16 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c3b9200b0040e4ca7fcb4sm28048633wms.37.2024.01.18.23.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 23:14:15 -0800 (PST)
Message-ID: <650bdb23-0875-4e19-9e3e-82337da6da00@kernel.org>
Date: Fri, 19 Jan 2024 08:14:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>, linux-media <linux-media@vger.kernel.org>,
 Hans Verkuil <hverkuil@xs4all.nl>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com>
 <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08. 01. 24, 19:19, Linus Torvalds wrote:
> On Mon, 8 Jan 2024 at 03:46, Jiri Slaby <jirislaby@gmail.com> wrote:
>>
>>     CPP [M] drivers/media/pci/solo6x10/solo6x10-p2m.i
>> real    0m45,002s
>>
>> $ git revert 867046cc7027703f60a46339ffde91a1970f2901
>>     CPP [M] drivers/media/pci/solo6x10/solo6x10-p2m.i
>> real    0m11,132s
>>
>> $ git revert 4ead534fba42fc4fd41163297528d2aa731cd121
>>     CPP [M] drivers/media/pci/solo6x10/solo6x10-p2m.i
>> real    0m3,711s
> 
> Ouch. Yeah, that's unfortunate. There's a lot of nested nasty macro
> expansion there, but that timing is excessive.
> 
> Sparse actually complains about that file:
> 
>    drivers/media/pci/solo6x10/solo6x10-p2m.c:309:13: error: too long
> token expansion
>    drivers/media/pci/solo6x10/solo6x10-p2m.c:310:17: error: too long
> token expansion
> 
> and while that is a sparse limitation, it's still interesting. Having
> that file expand to 122M is not ok.
> 
> In this case, I suspect the right thing to do is to simply not use
> min()/max() in that header at all, but do something like
> 
>    --- a/drivers/media/pci/solo6x10/solo6x10-offsets.h
>    +++ b/drivers/media/pci/solo6x10/solo6x10-offsets.h
>    @@ -56,2 +56,5 @@
> 
>    +#define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
>    +#define MAX(X, Y) ((X) > (Y) ? (X) : (Y))
>    +
>     #define SOLO_MP4E_EXT_ADDR(__solo) \
>    @@ -59,4 +62,4 @@
>     #define SOLO_MP4E_EXT_SIZE(__solo) \
>    -     max((..),                               \
>    -         min(((..) - \
>    +     MAX((..),                               \
>    +         MIN(((..) - \
>                   ..), 0x00ff0000))
>    @@ -67,4 +70,4 @@
>     #define SOLO_JPEG_EXT_SIZE(__solo) \
>    -     max(..,                         \
>    -         min(..)
>    +     MAX(..,                         \
>    +         MIN(..)
> 
> and avoid this issue.

So can someone pick up 20240113183334.1690740-1-aurelien@aurel32.net so 
that we are done with this? I see neither Hans, nor Linus got to take it 
yet.

> That said, I'm sure this thing exists to a smaller degree elsewhere. I
> wonder if we could simplify our min/max type tests.
I assume we don't care with solo fixed? Hans pointed out ath11k too. 
Even if there is size increase in the preproc file, I don't see much of 
compile time increase there.

thanks,
-- 
js
suse labs


