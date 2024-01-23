Return-Path: <linux-kernel+bounces-35777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3595E83965E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74A71F22DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004B37FBD9;
	Tue, 23 Jan 2024 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ofcwva9U"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8B7F7F0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030812; cv=none; b=kPV7emTxPzm/uIjMAWB1fpgnWxCHyGMjWMgaMYI2idj2DTdEXsAMwudwsjeRf/S+u5IWxZixZ1310vJQUN4aR0Uun1FjMZPANARxuLP2SoPIS3NI/toQ/FrLuu7WhxygF9HE0M5GNA1d+IKxtMRRmucJ7LW4jjIYfZoKXlYxa1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030812; c=relaxed/simple;
	bh=HtgaEazjRyizXbtpsY6ycAq04h3P2hVjFbZkBcbdjVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrjacktS1KUrfyILJbIafJhg+G/swABq1oWLAK5qF/oNCD/IXNR94t/sk94WDIxPvCBCZDsIDniyslISIyYRACoga0DW4mfIkHZ+mxaWwxWucnoVtbLsCE8ovMhT/8p97/m6PdihrB6kE/ksp1GZt/EJ2F7978mQyme5thfJKJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ofcwva9U; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2194765a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706030810; x=1706635610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLN6EqySpNHRi+yFbUimnsqhdqYk4vMvEH74xI9UcaY=;
        b=Ofcwva9UwTt2JOsnE4W633FHLO3oGSyPdnhNz+1Wpm6ZPSOwbA0r1yDtKWja0V4jZ3
         WUdmskvp3HgZYVdC8PLzXVQicw/jFaNGuQP0uIXAhd2U1Bw9PTR737mkoDFBna9NBtis
         MobmHqKw0JO3bLHLlW+dKd4Wa2vh7v8QNNZHyCxJF5mnnS/e5jEtOd/q3/uIO6amOdMw
         6QvWamuDk0WEsQfpKBwF2sRlSgxIbqjw9ZEthV3NVmbU1xvGSLumQHXCDqbDJsBgDMuk
         /0neXJSC9kfHEXT7qWJxLl3aArWf0bXCCpTmbHg2fTVSOmmK6XA9lptQgvXq8ZKm9gL4
         EX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706030810; x=1706635610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLN6EqySpNHRi+yFbUimnsqhdqYk4vMvEH74xI9UcaY=;
        b=RddPjDLeA9kwLqyOUd/5sLVXRPkgXEPjysItYK9wK7YsC/kY3DPDn5f8hHP8IrRpM1
         HMZqU9wQ5AHo3j+C6nJ/CBIJV7v2nWO45m+9/dgH4Yf6PB5vzWggZSzwrb/oI9+6z/NI
         IZ8ozpbOhAC/ox8CNe9jjqGenJYAxOFY2L2HrPgdKC/1Zh4/SZCbzyI7/sa/+m64dqEu
         JQlOUyvt8DqRsHv8Ylr1BJNPzceFA3pvQWGRocSttWvc4I97p9zx+mU7gK+hCV7wOIg8
         633Z7ZUj3tRzShxoE5BKEOfdZ8M8FRw9ocgVZVXvOJINUVroUReJSV9qwXmdQ8nDZqUo
         2oFA==
X-Gm-Message-State: AOJu0YxEInzyWxKvzJUqknXyT+fnAdnAkrhY+B2i8ylCWHdZEzBTadX0
	YTAcoS4LZwgIO3xnh37VFbtT5KUFa26W/5SqWQdXc1Hv0BeKsaCf+b5iGaZ9FJtGlBobJhM/p9x
	9zLx7QepkHHJKEZuYKas4hn77cpCzd+XH
X-Google-Smtp-Source: AGHT+IFvy5sBQYDAZfH0OKhQy2T0BzbAlnxNZXufF7U23H3aBth+r13ocssbRNVUZ5uTEVXYN9zlYfPnEQ1yD43Tst0=
X-Received: by 2002:a05:6a20:a128:b0:19c:5cca:e98 with SMTP id
 q40-20020a056a20a12800b0019c5cca0e98mr746651pzk.4.1706030809998; Tue, 23 Jan
 2024 09:26:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com> <Zav3UK7ESNxCMjyP@casper.infradead.org>
 <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com> <CAHbLzkpT6padaDo8GimCcQReSGybQn_ntzj+wsZbTXe3urtK-g@mail.gmail.com>
 <bad7ec4a-1507-4ec4-996a-ea29d07d47a0@arm.com> <CAHbLzkrtcsU=pW13AyAMvF72A03fUV5iFcM0HwQoEemeajtqxg@mail.gmail.com>
In-Reply-To: <CAHbLzkrtcsU=pW13AyAMvF72A03fUV5iFcM0HwQoEemeajtqxg@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 23 Jan 2024 09:26:37 -0800
Message-ID: <CAHbLzkqCdHRv3iJ5bXD0w0wjDLUacux92WoyjLF=wRaOb2JOuA@mail.gmail.com>
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP boundaries
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com, 
	cl@linux.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 9:14=E2=80=AFAM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Tue, Jan 23, 2024 at 1:41=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.co=
m> wrote:
> >
> > On 22/01/2024 19:43, Yang Shi wrote:
> > > On Mon, Jan 22, 2024 at 3:37=E2=80=AFAM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> > >>
> > >> On 20/01/2024 16:39, Matthew Wilcox wrote:
> > >>> On Sat, Jan 20, 2024 at 12:04:27PM +0000, Ryan Roberts wrote:
> > >>>> However, after this patch, each allocation is in its own VMA, and =
there is a 2M
> > >>>> gap between each VMA. This causes 2 problems: 1) mmap becomes MUCH=
 slower
> > >>>> because there are so many VMAs to check to find a new 1G gap. 2) I=
t fails once
> > >>>> it hits the VMA limit (/proc/sys/vm/max_map_count). Hitting this l=
imit then
> > >>>> causes a subsequent calloc() to fail, which causes the test to fai=
l.
> > >>>>
> > >>>> Looking at the code, I think the problem is that arm64 selects
> > >>>> ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT. But __thp_get_unmapped_area=
() allocates
> > >>>> len+2M then always aligns to the bottom of the discovered gap. Tha=
t causes the
> > >>>> 2M hole. As far as I can see, x86 allocates bottom up, so you don'=
t get a hole.
> > >>>
> > >>> As a quick hack, perhaps
> > >>> #ifdef ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> > >>> take-the-top-half
> > >>> #else
> > >>> current-take-bottom-half-code
> > >>> #endif
> > >>>
> > >>> ?
> > >
> > > Thanks for the suggestion. It makes sense to me. Doing the alignment
> > > needs to take into account this.
> > >
> > >>
> > >> There is a general problem though that there is a trade-off between =
abutting
> > >> VMAs, and aligning them to PMD boundaries. This patch has decided th=
at in
> > >> general the latter is preferable. The case I'm hitting is special th=
ough, in
> > >> that both requirements could be achieved but currently are not.
> > >>
> > >> The below fixes it, but I feel like there should be some bitwise mag=
ic that
> > >> would give the correct answer without the conditional - but my head =
is gone and
> > >> I can't see it. Any thoughts?
> > >
> > > Thanks Ryan for the patch. TBH I didn't see a bitwise magic without
> > > the conditional either.
> > >
> > >>
> > >> Beyond this, though, there is also a latent bug where the offset pro=
vided to
> > >> mmap() is carried all the way through to the get_unmapped_area()
> > >> impelementation, even for MAP_ANONYMOUS - I'm pretty sure we should =
be
> > >> force-zeroing it for MAP_ANONYMOUS? Certainly before this change, fo=
r arches
> > >> that use the default get_unmapped_area(), any non-zero offset would =
not have
> > >> been used. But this change starts using it, which is incorrect. That=
 said, there
> > >> are some arches that override the default get_unmapped_area() and do=
 use the
> > >> offset. So I'm not sure if this is a bug or a feature that user spac=
e can pass
> > >> an arbitrary value to the implementation for anon memory??
> > >
> > > Thanks for noticing this. If I read the code correctly, the pgoff use=
d
> > > by some arches to workaround VIPT caches, and it looks like it is for
> > > shared mapping only (just checked arm and mips). And I believe
> > > everybody assumes 0 should be used when doing anonymous mapping. The
> > > offset should have nothing to do with seeking proper unmapped virtual
> > > area. But the pgoff does make sense for file THP due to the alignment
> > > requirements. I think it should be zero'ed for anonymous mappings,
> > > like:
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 2ff79b1d1564..a9ed353ce627 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1830,6 +1830,7 @@ get_unmapped_area(struct file *file, unsigned
> > > long addr, unsigned long len,
> > >                 pgoff =3D 0;
> > >                 get_area =3D shmem_get_unmapped_area;
> > >         } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > > +               pgoff =3D 0;
> > >                 /* Ensures that larger anonymous mappings are THP ali=
gned. */
> > >                 get_area =3D thp_get_unmapped_area;
> > >         }
> >
> > I think it would be cleaner to just zero pgoff if file=3D=3DNULL, then =
it covers the
> > shared case, the THP case, and the non-THP case properly. I'll prepare =
a
> > separate patch for this.
>
> IIUC I don't think this is ok for those arches which have to
> workaround VIPT cache since MAP_ANONYMOUS | MAP_SHARED with NULL file
> pointer is a common case for creating tmpfs mapping. For example,
> arm's arch_get_unmapped_area() has:
>
> if (aliasing)
>         do_align =3D filp || (flags & MAP_SHARED);
>
> The pgoff is needed if do_align is true. So we should just zero pgoff
> iff !file && !MAP_SHARED like what my patch does, we can move the
> zeroing to a better place.

Rethinking this... zeroing pgoff when file is NULL should be ok since
MAP_ANOYMOUS | MAP_SHARED mapping should typically have zero offset.
I'm not aware of any usecase with non-zero offset, or sane usecase...

>
> >
> >
> > >
> > >>
> > >> Finally, the second test failure I reported (ksm_tests) is actually =
caused by a
> > >> bug in the test code, but provoked by this change. So I'll send out =
a fix for
> > >> the test code separately.
> > >>
> > >>
> > >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > >> index 4f542444a91f..68ac54117c77 100644
> > >> --- a/mm/huge_memory.c
> > >> +++ b/mm/huge_memory.c
> > >> @@ -632,7 +632,7 @@ static unsigned long __thp_get_unmapped_area(str=
uct file *filp,
> > >>  {
> > >>         loff_t off_end =3D off + len;
> > >>         loff_t off_align =3D round_up(off, size);
> > >> -       unsigned long len_pad, ret;
> > >> +       unsigned long len_pad, ret, off_sub;
> > >>
> > >>         if (off_end <=3D off_align || (off_end - off_align) < size)
> > >>                 return 0;
> > >> @@ -658,7 +658,13 @@ static unsigned long __thp_get_unmapped_area(st=
ruct file *filp,
> > >>         if (ret =3D=3D addr)
> > >>                 return addr;
> > >>
> > >> -       ret +=3D (off - ret) & (size - 1);
> > >> +       off_sub =3D (off - ret) & (size - 1);
> > >> +
> > >> +       if (current->mm->get_unmapped_area =3D=3D arch_get_unmapped_=
area_topdown &&
> > >> +           !off_sub)
> > >> +               return ret + size;
> > >> +
> > >> +       ret +=3D off_sub;
> > >>         return ret;
> > >>  }
> > >
> > > I didn't spot any problem, would you please come up with a formal pat=
ch?
> >
> > Yeah, I'll aim to post today.
>
> Thanks!
>
> >
> >

