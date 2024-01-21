Return-Path: <linux-kernel+bounces-32224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9678358C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E64282065
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E1F38FB9;
	Sun, 21 Jan 2024 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx0+58td"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39F1383A7
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 23:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705880123; cv=none; b=Mvpdkkjnf2VHthqEA2sqo1mO62NYxZcDjfIKlkEwFCYWCACk60c87nU9vzgsMVm9beM2R5L+aP0jvPsLHJ63e5yq4FE8GCRAjKobd8N04qI22bBwyI5UdS9g5Wqbv6FBQnJ9FvA5Q/oRBlprZev4/vy668UpSQopvX9v7rWE7iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705880123; c=relaxed/simple;
	bh=3dLjhEo/z/A2uUAr4ILffhI+GkZbtJnTNpzJ+iCXXuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sg/H695seDa8QLDMux3J+uyrb7yegfHgHgAuFs7+Xnkb33TPWAj7Kq142Rdk6zBwuzahYG0cHyov9IPBM6PMtfucnoZVJEmhYvUYsZrhA5PtsNSBo3e9HLHev+sOgETbSTqB6ZeuyRhBRDLx1luTHcwrpT1M/GvlsqIyu4i5+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx0+58td; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ff821b9acfso21384997b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 15:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705880120; x=1706484920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5fPtPFKbTgmW5AT9UnS4RkiacXKIW8kAlJQGVHXu9I=;
        b=mx0+58tdtgyAaPOcJQzXZ/Qm2XjWT0Gw3eXkhiWzMOHMqnZdM1rky6QHEBfdN3uI7O
         LgfoiigmiO+E6FI0wUHONDwT68vEkYbD0VVYWIlg6QFb2+Bw2z+8+ULfO2FRRK3/8JZw
         W8W9v/m9kuySQvyoNGg51SCzBPHiBaU/dGfM9voR80HgHrpxWUvgG8iVo3zgG+Juq9lb
         mQm2Pp+yU42Tjkrln0ze8esXtxn0gc/+uzNIGr6maRki7EtfDV/GHq4it0fAVwbZ446C
         8OX7o4cDzKpVg60HuGfGWxIold3Xh/opY3amdE+8Z4WupXA/5zo1BHAqugCSHc2zcCXS
         5XDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705880120; x=1706484920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5fPtPFKbTgmW5AT9UnS4RkiacXKIW8kAlJQGVHXu9I=;
        b=QUvSoWMKSJ9Uh7XlT/1CWDz+U0Tl/mZGy6VHZZE9fJD3+JXdKs0WQ04tqvzntB1LYt
         k6clXdTcFkRaM9NdDYVM03XTpg/re2WUMALS5YsavZVy21BzeFlyd6xZ6wTYwZ4QHrpq
         VqmVsBhntoK68dreOycmvx1gnmGCwTXg6Q7wbXC+hhtRsWHHAapyX8anuCrHX8x4LADS
         xSY5OFRE8zQBM8z6oBkJh3VwISMct5f3kw2X2e4ry08UGhC1GkxG327RdODC5P9NurrE
         /MiYCdfgHM9VlH+2pLSJbQt9x4EAfNrZ6sm+Ni0/jgs9BX4uJdZNXjW9tO7t58cot5ht
         F2Vg==
X-Gm-Message-State: AOJu0Yy8lh7RWbo3JP5M0sG+X1NRvE5tZ4TtyaBpTkCPNGsUBT25/rVA
	LK5J9GHf5xl3dMvLd3uXF2CSEf7YhGl+eX34Fl5Whi/t/AeSyL7s
X-Google-Smtp-Source: AGHT+IHCKeEJj8Y8v9jcVPmVoW5Y3zqNFHNo4YDxtfct4BOlUJcVCsv2qxhLPqAG6d+0ewHjCcNtbw==
X-Received: by 2002:a05:6902:e10:b0:dc2:2e3d:ca5 with SMTP id df16-20020a0569020e1000b00dc22e3d0ca5mr1921519ybb.24.1705880120233;
        Sun, 21 Jan 2024 15:35:20 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:723b:dc5d:8680:45e5])
        by smtp.gmail.com with ESMTPSA id y17-20020a056902053100b00dc2217892a4sm1233148ybs.56.2024.01.21.15.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 15:35:19 -0800 (PST)
Date: Sun, 21 Jan 2024 15:35:18 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Guanjun <guanjun@linux.alibaba.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Oliver Neukum <oneukum@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>, Tony Lu <tonylu@linux.alibaba.com>,
	Vinod Koul <vkoul@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Wei Liu <wei.liu@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [GIT PULL] bitmap patches for v6.8
Message-ID: <Za2qLrnItFxbB859@yury-ThinkPad>
References: <ZZwrbDUe4VQRYv5I@yury-ThinkPad>
 <CAHk-=wh02qG1CtiQ-pPDcpbiZUx6AEdfAYPbp0nJ7wyzdHmEkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh02qG1CtiQ-pPDcpbiZUx6AEdfAYPbp0nJ7wyzdHmEkw@mail.gmail.com>

On Sun, Jan 21, 2024 at 01:47:21PM -0800, Linus Torvalds wrote:
> So I've left this to be my last pull request, because I hate how our
> header files are growing, and this part:
> 
>  include/linux/find.h | 301 ++++++++++++++++++++++++++++++-
>  1 file changed, 297 insertions(+), 4 deletions(-)
> 
> in particular.
> 
> Nobody includes <linux/find.h> directly, but indirectly pretty much
> *every* single kernel C file includes it.
> 
> Looking at some basic stats of my dependency files in my tree, 4426 of
> 4526 object files (~98%) depend on find.h because they get it through
> *some* path that ends up with bitmap.h -> find.h.
> 
> And honestly, the number of files that actually want the new functions
> is basically just a tiny handful. It's also not obvious how useful
> those optimizations are, considering that a lot of the loops are
> *tiny*. I looked at a few cases, and the size of the bitmap it was
> iterating over was often in the 2-4 range, sometimes (like
> RTW89_TXCH_NUM) 13, etc.
> 
> In radio-shark, you replaced a loop like this
> 
>         for (i = 0; i < 2; i++) {
> 
> with that for_each_test_and_clear_bit(), and it *really* isn't clear
> that it was worth it. It sure wasn't performance-critical to begin
> with.
> 
> In general, if an "optimization" doesn't have any performance numbers
> attached to it, is it an optimization at all?

No, this is not a performance optimization, and I don't claim that.
Jan Kara reported some performance improvement, but performance is not
the main goal of the series, and I didn't run performance tests for
this on myself.

The original motivation came from the fact that using non-volatile
find_bit() together with volatile test_and_set_bit() may trigger
KCSAN warning on concurrent memory access.

People wanted to make the whole find API volatile, which is a bad idea
for sure. So I had to give them a reasonable alternative. After some
thinking I decided that we just need a separate set of volatile find API.
Check this for initial discussion:

https://lore.kernel.org/lkml/634f5fdf-e236-42cf-be8d-48a581c21660@alu.unizg.hr/T/#m3e7341eb3571753f3acf8fe166f3fb5b2c12e615

It also makes the code cleaner, at least to my taste, and some
reviewers' too. And to some degree less bug-prone. For example,
ILSEL_LEVELS is just 15, but traversing code in ilsel_enable()
is buggy, as Geert spotted. And switching to atomic find() fixes
it automatically:

https://lore.kernel.org/lkml/CAMuHMdWHxesM-EOOMtrrw3Caz+5Wux35QiKOjvwA=vwQpRe26Q@mail.gmail.com/T/#me53217b32fd5623af6c7eafa5c4ce6d0465f6c58

(His review came just a couple days ago, after I submitted the pull
request, so the tag is not there.)
 
> So I finally ended up pulling this, but after looking at the patch I
> went "this is adding more lines than it removes, has no performance
> numbers, and grows a core header file that is included by absolutely
> everything by a third".
> 
> .. and then I decided to just unpull it again.

Yes, it's true. Bitmap.h historically includes everything related to
bitmaps, and it became too big. I started moving some chunks out of
it already. For example, aae06fc1b5a2e splits out string-related bitmap
code to a separate bitmap-str.h. That patch was more about human
readability, and it keeps the order, so that bitmap.h includes
bitmap-str.h, but we can easily turn that around.

I wanted to do it some day, but actually nobody complained before now,
and I wanted to collect more material to make it a series.

I still think that kernel needs atomic find_bit() API. If you change
your mind and pull the series, I can make patches that split-out
atomic find() declarations to a separate header, not included by
bitmap.h, and submit it for -rc2, together with bitmap-str.h rework.

Thanks,
Yury

