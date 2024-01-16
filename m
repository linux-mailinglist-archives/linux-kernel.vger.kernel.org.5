Return-Path: <linux-kernel+bounces-28277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEC182FC72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD791C24412
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59975A7BB;
	Tue, 16 Jan 2024 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJkwENpE"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D652028DCB
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705438676; cv=none; b=nxBBVxRwLqEDejg4XLMteVeaSYwK7VefLlCzhVrgqcH+1Imh0hKZ5N3fpH0GBXik7aWgIJ3ABi5rcdGYFBe892Qmec7L6v/8VYHh/EFAum2j7c0coUuuDF8AeLUGA2A7li4Zzp1GzTghvvmpYL8yvV++7qKctOY+WFV9EIzMfXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705438676; c=relaxed/simple;
	bh=4frzhpwkExhqQU6jnr/MkqW3RGgnQsX6iNpmppuGu5g=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=QuJvhEKbQ2v7AJvx7dS46A1WN9olHOQ8sAGFBiIwQiHhHz8rPTJ4HO34c1whgTX/k36TA/iFTbvs1Os8U3aeagbI9WPQ7GTDf10L8zxf66dnOxwitmgZuCwghxVZhDgsrepuGMxA9Bbfqy971h+ZdBYy2rzGyQeMFKCottFS7cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJkwENpE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28e7b4546e2so761124a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705438673; x=1706043473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/EZzmK6HfHQLA68MEdpLWPQjpi5m5+fEzjurqyk7MQ=;
        b=dJkwENpEnCQ7PZtnFjTNfSe1qG0N54o6ie91PPWlBZrKTa6wpu+TXqMiCP9GjJY8a6
         vxcntIMiz9gOrnqJxbVlr0vm7g23u6ZhBm9amBO00JVkO8zCEGtNYQaValua8LnO+lF+
         yzancQUfu4xKzTbuWe1wvhjNYYApzeR7JgW+r/pDR3OIlwM+jjQP+k5WV3DBhsnMbyna
         D9vPTZ+v1s0pauXRKfnXb9L4Ax4060/ag6eprHvueBbNYog2DtqRosLs5FXQryWgov4h
         jjxIBjYzWLNoTKcYcN0SRoCxi+48bnt6ojuP6J/RJKgo/KdUdbLTFxZzXePqiTsfShHc
         Liag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705438673; x=1706043473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G/EZzmK6HfHQLA68MEdpLWPQjpi5m5+fEzjurqyk7MQ=;
        b=PEKZyrQq0l6dSEMq66dWcGKGnsj5L1JOGGgElJo0FytP8aRo33KWKLW6lt7pA/eUhK
         I4NqiqfYxjksRcSCLHNjQhxMqf7tb2yDy+dQ8XeojMoewhUCRbn0E/zgz5Zph40IAt7R
         Io13td3IY9/vG0bTG52XdPE1HUHnB1KOt5TdDrS8dBdIwQnbgSwy4bOof92qkLrfKBn8
         poy4bQz0/muUXsb0IVw9Kyx7FuN5/2Su1q+NB4i8BtSJUA6OXqQkDlZpE0CBIT+eMZUv
         BkGJKzQa8EUe5RRoQ/H3E5vNHKCr2Y15YO7edRlTrR7NAUqFUXQ4jWKn21YDELMs3IYQ
         YoPQ==
X-Gm-Message-State: AOJu0YzfAYujwoSecuNnJidjW7awLxwECTjcg/dnlmMQcXtYzNvaXsZU
	qQQEo8ujUdpj2u0pWD5aLKYIc/fDYatQgZf0LiU=
X-Google-Smtp-Source: AGHT+IGciLCO/ufPtmnqCC3a0V4mBdZDL05fQwHfzJlaDGT2mgEqh8UsQIVb9NU946JH1W05lXyphPZYeKh7zUb9O8k=
X-Received: by 2002:a17:90b:690:b0:28d:f01a:1abd with SMTP id
 m16-20020a17090b069000b0028df01a1abdmr10062825pjz.14.1705438673199; Tue, 16
 Jan 2024 12:57:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221065943.2803551-1-shy828301@gmail.com> <20231221065943.2803551-2-shy828301@gmail.com>
 <7433e325-9af7-4b8c-888e-07a0debf8e46@intel.com> <CAAa6QmQjE=7qYBWSsMF=J2dir+1q9-zmAEkj7Jqg52cC7hy-xQ@mail.gmail.com>
In-Reply-To: <CAAa6QmQjE=7qYBWSsMF=J2dir+1q9-zmAEkj7Jqg52cC7hy-xQ@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 16 Jan 2024 12:57:41 -0800
Message-ID: <CAHbLzkq12j+KSLegxbepzjAkOz1SE-7w5OuKwxarp_Lh+d0MOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: mmap: map MAP_STACK to VM_NOHUGEPAGE
To: "Zach O'Keefe" <zokeefe@google.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>, oliver.sang@intel.com, riel@surriel.com, 
	willy@infradead.org, cl@linux.com, ying.huang@intel.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 11:22=E2=80=AFAM Zach O'Keefe <zokeefe@google.com> =
wrote:
>
> Thanks Yang,
>
> Should this be marked for stable? Given how easily it is for pthreads
> to allocate hugepages w/o this change, it can easily cause memory
> bloat on larger systems and/or users with high thread counts. I don't
> think that will be welcomed, and seems odd that just 6.7 should suffer
> this.

Thanks for the suggestion, fine to me.

>
> Thanks,
> Zach
>
> On Tue, Jan 9, 2024 at 5:36=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com=
> wrote:
> >
> >
> >
> > On 2023/12/21 14:59, Yang Shi wrote:
> > > From: Yang Shi <yang@os.amperecomputing.com>
> > >
> > > The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> > > boundaries") incured regression for stress-ng pthread benchmark [1].
> > > It is because THP get allocated to pthread's stack area much more pos=
sible
> > > than before.  Pthread's stack area is allocated by mmap without VM_GR=
OWSDOWN
> > > or VM_GROWSUP flag, so kernel can't tell whether it is a stack area o=
r not.
> > >
> > > The MAP_STACK flag is used to mark the stack area, but it is a no-op =
on
> > > Linux.  Mapping MAP_STACK to VM_NOHUGEPAGE to prevent from allocating
> > > THP for such stack area.
> > >
> > > With this change the stack area looks like:
> > >
> > > fffd18e10000-fffd19610000 rw-p 00000000 00:00 0
> > > Size:               8192 kB
> > > KernelPageSize:        4 kB
> > > MMUPageSize:           4 kB
> > > Rss:                  12 kB
> > > Pss:                  12 kB
> > > Pss_Dirty:            12 kB
> > > Shared_Clean:          0 kB
> > > Shared_Dirty:          0 kB
> > > Private_Clean:         0 kB
> > > Private_Dirty:        12 kB
> > > Referenced:           12 kB
> > > Anonymous:            12 kB
> > > KSM:                   0 kB
> > > LazyFree:              0 kB
> > > AnonHugePages:         0 kB
> > > ShmemPmdMapped:        0 kB
> > > FilePmdMapped:         0 kB
> > > Shared_Hugetlb:        0 kB
> > > Private_Hugetlb:       0 kB
> > > Swap:                  0 kB
> > > SwapPss:               0 kB
> > > Locked:                0 kB
> > > THPeligible:           0
> > > VmFlags: rd wr mr mw me ac nh
> > >
> > > The "nh" flag is set.
> > >
> > > [1] https://lore.kernel.org/linux-mm/202312192310.56367035-oliver.san=
g@intel.com/
> > >
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Tested-by: Oliver Sang <oliver.sang@intel.com>
> > > Cc: Yin Fengwei <fengwei.yin@intel.com>
> > > Cc: Rik van Riel <riel@surriel.com>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Christopher Lameter <cl@linux.com>
> > > Cc: Huang, Ying <ying.huang@intel.com>
> > > Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> >
> > Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> >
> > > ---
> > >   include/linux/mman.h | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/include/linux/mman.h b/include/linux/mman.h
> > > index 40d94411d492..dc7048824be8 100644
> > > --- a/include/linux/mman.h
> > > +++ b/include/linux/mman.h
> > > @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
> > >       return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
> > >              _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
> > >              _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
> > > +            _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE) |
> > >              arch_calc_vm_flag_bits(flags);
> > >   }
> > >
> >

