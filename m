Return-Path: <linux-kernel+bounces-492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC0A8141EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96EF71C21EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8F3DDD6;
	Fri, 15 Dec 2023 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dn5xCKEO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9BD2FD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-552d1a24ce7so1357a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702622827; x=1703227627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FKXVOTp/bQOfHcljreFVgKQiFMabDqpotbFQ79Z/fg=;
        b=dn5xCKEO3Ot0n676kQlFOeAvj5YWxGbJfsf2JhDV67wQEfy11gg7YxxvPt2TRUKZBa
         P7PaHCOMiEVDWaNrx8ys2yCZ9ccLF+tdyu8QUv+kbPmQ5uRUTAopld8+V4o/gnEyfPHG
         01u+v2t57b9JD9+g7nbo45nngeLoWFsdP8HPLI0IkTFmbqaZlXe076HKKMCevO0L0G49
         t+vK72zO7Z6Hzw7Tf4sT4SPKwlpKTXiGweNrxZIQ5Hkc3TQWn6K7HcikxQHrjkoiKUa6
         6mccpsjLCHnLgKn9BZ9aaee1taOeWPj3vibO0TH+VjuIkYuCFrgUnpZYVn5DUZW5JLdH
         +7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702622827; x=1703227627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FKXVOTp/bQOfHcljreFVgKQiFMabDqpotbFQ79Z/fg=;
        b=FIOLxyj4t3UDcrM+jA+axIM9ed13aqtluFNVbksqmzRUvM/u9tTsIItKNFB5BQmvix
         gr8pxz8iFELYMbI7eaBIFTeNE1sIjggKNcW9RUJp5Q/xB0HnOM3Y04qm20LUkxa/aZny
         yEMyWpCo9QYJzbZ8/v5YFdVzxNkLj0pBMHbFtx/FdjeAIQRpdZIdsoa6b9/LTVhonHCY
         +r8feMrSbVeBgDgOLfmt0NzIV0GYxE/uKyzxJczF99ypRKX7braDBO7H8W1iMaelH6Il
         +KoVndh1yMDuAFNBRwKVl0/DrMICtcqE27E620Kag+vxlBLYdW9tqpWw3NCFKZEHIQOY
         Zmkw==
X-Gm-Message-State: AOJu0Yw49fNwK6mkKCc6JU88Tz/H1JEZcd40i62a2s0y+YMpyU8Pm9VM
	plWiFkrTtTsdHI6z1bdgstMPWWPhQAlzpqnVJ0RdzQ==
X-Google-Smtp-Source: AGHT+IGh0xKeczdxJkwY9Ms/J+BfztpO8E4fJzl7f+hhS3s4y/glg0dwx7NSN2HXOX1Suf2776Ez02Tepizlhs67gsU=
X-Received: by 2002:a50:c092:0:b0:543:fb17:1a8 with SMTP id
 k18-20020a50c092000000b00543fb1701a8mr748481edf.3.1702622827515; Thu, 14 Dec
 2023 22:47:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOUHufZeADNp_y=Ng+acmMMgnTR=ZGFZ7z-m6O47O=CmJauWjw@mail.gmail.com>
 <20231208071235.17812-1-henry.hj@antgroup.com>
In-Reply-To: <20231208071235.17812-1-henry.hj@antgroup.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 14 Dec 2023 23:46:29 -0700
Message-ID: <CAOUHufaBfziNTwypP=dxZXYZi4nniT6aYQZiZxzyQjSa3Zmaow@mail.gmail.com>
Subject: Re: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
To: Henry Huang <henry.hj@antgroup.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>, 
	=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?= <teawater@antgroup.com>, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 12:12=E2=80=AFAM Henry Huang <henry.hj@antgroup.com>=
 wrote:
>
> Thanks for replying this RFC.
>
> > 1. page_idle/bitmap isn't a capable interface at all -- yes, Google
> > proposed the idea [1], but we don't really use it anymore because of
> > its poor scalability.
>
> In our environment, we use /sys/kernel/mm/page_idle/bitmap to check
> pages whether were accessed during a peroid of time.

Is it a production environment? If so, what's your
1. scan interval
2. memory size

I'm trying to understand why scalability isn't a problem for you. On
an average server, there are hundreds of millions of PFNs, so it'd be
very expensive to use that ABI even for a time interval of minutes.

> We manage all pages
> idle time in userspace. Then use a prediction algorithm to select pages
> to reclaim. These pages would more likely be idled for a long time.

"There is a system in place now that is based on a user-space process
that reads a bitmap stored in sysfs, but it has a high CPU and memory
overhead, so a new approach is being tried."
https://lwn.net/Articles/787611/

Could you elaborate how you solved this problem?

> We only need kernel to tell use whether a page is accessed, a boolean
> value in kernel is enough for our case.

How do you define "accessed"? I.e., through page tables or file
descriptors or both?

> > 2. PG_idle/young, being a boolean value, has poor granularity. If
> > anyone must use page_idle/bitmap for some specific reason, I'd
> > recommend exporting generation numbers instead.
>
> Yes, at first time, we try using multi-gen LRU proactvie scan and
> exporting generation&refs number to do the same thing.
>
> But there are serveral problems:
>
> 1. multi-gen LRU only care about self-memcg pages. In our environment,
> it's likely to see that different memcg's process share pages.

This is related to my question above: are those pages mapped into
different memcgs or not?

> multi-gen LRU only update gen of pages in current memcg. It's hard to
> judge a page whether is accessed depends on gen update.

This depends. I'd be glad to elaborate after you clarify the above.

> We still have no ideas how to solve this problem.
>
> 2. We set swappiness 0, and use proactive scan to select cold pages
> & proactive reclaim to swap anon pages. But we can't control passive
> scan(can_swap =3D false), which would make anon pages cold/hot inversion
> in inc_min_seq.

There is an option to prevent the inversion, IIUC, the force_scan
option is what you are looking for.

