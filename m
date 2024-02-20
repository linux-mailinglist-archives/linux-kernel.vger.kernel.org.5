Return-Path: <linux-kernel+bounces-72799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1251185B8C4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38BE2849FD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0101060244;
	Tue, 20 Feb 2024 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvJAkDom"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489B5FDC5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424165; cv=none; b=SWFlDKbyiRIfvNTpNMRwcfJf+wE4sh2TTgyGcZbhbKZrgW1COpYwJ2LIaVzh1DhkaRwOy0Ct/ZZvt6XWv0to31qjR6+7m2ZJiwHlOWVw82PlsW8kou/eKSDR4Lq24imh48gk6auQ7BR+zE5SbWdi5W2gC+nkkQGzY46li6pceCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424165; c=relaxed/simple;
	bh=uvy9dbKaRp8OwtO8eEkXBs3FsE0K1ieWy2Kp6/Qphx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GK4fFQ5PDx+8pX5HlD5BkiyXj9FZsi3e2t2g9fKwL48P6GkwTu4BpKJQSzBPFUwZ+/p/6QO/9vkX/1+2gA2Y521pQIaummoS1DPaLC77u+Ga8uGRG1bkHDIFs8+kAgFLYByiCm34JyDcvM3RzAjq3Eac2kJqfuumbXdgLPqbF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvJAkDom; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-607bfa4c913so49251577b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708424162; x=1709028962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvy9dbKaRp8OwtO8eEkXBs3FsE0K1ieWy2Kp6/Qphx0=;
        b=kvJAkDom+cXpmnOBaQ+LAWy7K+NpEOuXN2TCzPjTKjaVhkojB06mGH/pA5E7si8NHI
         sDi9scnbG36DJrkLZS8N6LPKZKuM98y1a1yYL3Jv2ZiYTHO0a9TbrbHx6cL0vbPdG5bp
         4LYCqtAM39PQQKHP1dk/3f/p2TKkIewqoLfQmTjgCsmJeo2N9Wibv1meknXRqaiF8J9C
         auRTxz3Zj05eHYhyd3WvhnOuakOBMWX0dRpGleZS3hTVIFHp9Xlkq5EbzkE/Vwi4ASMA
         H5TbBr4eZqgugcOL6DDgEkNMq1gZRQHMU0mKF/oymrub+QRtLoZMNLV3GQFe8k6xxhw5
         DOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708424162; x=1709028962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvy9dbKaRp8OwtO8eEkXBs3FsE0K1ieWy2Kp6/Qphx0=;
        b=M9OLPalI5OnebYBqQ0Q13Af3KVKHtkl8BoddNxquIi5oLO4XH10LC4dFfPbYBYSyqq
         oyNjbDe8Kj3+vyL8Lkv6z1j6NtI/grdXRjoFAe4naOtxDKP8D32CVnUUjDfezySxjU5M
         XPu4Kw4scTjpMZrKRbqIgLTgHMz/fzZZct73Cg14bTwcnO+ggbSEnWcBm51oJi/dd/my
         UWD3Gkm8WFzRm/qJjSG+qMJqxffLkDHVXl3Mp3Oqd2uxDUB0sUgMTHO+FE02XWdtRyxE
         5OjfIBrwa/oQo24q8tC8UoR4/rXaxGpHYbWtvrO6DEWquYHHVgmGzpO0ZP+zV7KtoUV4
         y8/A==
X-Forwarded-Encrypted: i=1; AJvYcCXY+Pgl9yp+SFlbXS6Rj/vWy9V7GnQSEWL0RvySQoRO4dLohyHD9bedhY1Mo+PFjYDtLvuNQo2AEoMdH4rf6Y/vwnQ83i3EJdgiaFcP
X-Gm-Message-State: AOJu0YxUHQtsoashoaxh7Oli7Vc1gk2aOl9xzolq+aCoP6Ba9e0f1FWV
	0ufhr934sgKGj5dGccgri7UoStCqER1lxV/ySkjeWNAn9nb/CMX3Z1CWI/juJwikdMA313vk4F6
	+H4IhF6DxO/3s+DhTkGUhfrZWkE0=
X-Google-Smtp-Source: AGHT+IEERfe6iW/E1dAnOCGoibxXNFpoPD9BgzOgYNqIFNzs9JcewOVVVUhEgwt2Tr9ifjKtiHGjho2ny43YNt4NLOM=
X-Received: by 2002:a05:690c:d17:b0:608:4bab:8b06 with SMTP id
 cn23-20020a05690c0d1700b006084bab8b06mr4145412ywb.45.1708424162444; Tue, 20
 Feb 2024 02:16:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125226.28372-1-ioworker0@gmail.com> <Zby-sHLDlmTRaUcd@tiehlicka>
 <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com>
 <ZbzfxNn4AYnTVFLh@tiehlicka> <CAK1f24mvBkc2c=fHL6UxMhL2mgLHVrSwZfE5516bOR0yVdfZpQ@mail.gmail.com>
 <ZbzmvwyTGeW18nJy@tiehlicka> <CAK1f24kdyOnUjcpnrk6j4cF6bSFXQwwzFk9tM+jD4RsO_Hc4hA@mail.gmail.com>
 <Zbz_ao0uBKabzKB1@tiehlicka> <CAK1f24nHmvqm1XD_UkWUB7DmNdH0NEOKzpLgKDJ=UuPWO=rEHw@mail.gmail.com>
 <CAHbLzkpYM3jGVP19hG6LcD0=C=LHgGXqjVhsMYhO4HQufsfy-g@mail.gmail.com>
 <ZcCuHmCh7a8fU6_3@tiehlicka> <CAHbLzkrkbbm-AqXuk0oFf4DD4CJeVqwtsgXq-RwuSDDUoMc+4A@mail.gmail.com>
 <CAAa6QmRjqob=HQ1K4c+vP5iydM_VA-wd5NcoDLVuX=13NwedSQ@mail.gmail.com>
In-Reply-To: <CAAa6QmRjqob=HQ1K4c+vP5iydM_VA-wd5NcoDLVuX=13NwedSQ@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 20 Feb 2024 18:15:48 +0800
Message-ID: <CAK1f24nhchLX98so=jmbdm4jF21FfvNbtxNaXxx059e_Da_uOg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
To: "Zach O'Keefe" <zokeefe@google.com>, Yang Shi <shy828301@gmail.com>, 
	Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Zach, Yang, Michal, and David,

Please accept my sincerest apologies for the delayed
response.

Thanks for the replies; it=E2=80=98s been very helpful to me! I also
appreciate the valuable information you=E2=80=99ve shared!

I agree that it=E2=80=99s not a good idea to let khugepaged avoid
any pages marked with MADV_FREE.

Thanks again for your time!

Best,
Lance

On Tue, Feb 6, 2024 at 4:27=E2=80=AFAM Zach O'Keefe <zokeefe@google.com> wr=
ote:
>
> On Mon, Feb 5, 2024 at 11:43=E2=80=AFAM Yang Shi <shy828301@gmail.com> wr=
ote:
> >
> > On Mon, Feb 5, 2024 at 1:45=E2=80=AFAM Michal Hocko <mhocko@suse.com> w=
rote:
> > >
> > > On Fri 02-02-24 09:42:27, Yang Shi wrote:
> > > > But if the partial range is MADV_FREE, khugepaged won't skip them.
> > > > This is what your second test case does.
> > > >
> > > > Secondly, I think it depends on the semantics of MADV_FREE,
> > > > particularly how to treat the redirtied pages. TBH I'm always confu=
sed
> > > > by the semantics. For example, the page contained "abcd", then it w=
as
> > > > MADV_FREE'ed, then it was written again with "1234" after "abcd". S=
o
> > > > the user should expect to see "abcd1234" or "00001234".
> > >
> > > Correct. You cannot assume the content of the first page as it could
> > > have been reclaimed at any time.
> > >
> > > > I'm supposed it should be "abcd1234" since MADV_FREE pages are stil=
l
> > > > valid and available, if I'm wrong please feel free to correct me. I=
f
> > > > so we should always copy MADV_FREE pages in khugepaged regardless o=
f
> > > > whether it is redirtied or not otherwise it may incur data corrupti=
on.
> > > > If we don't copy, then the follow up redirty after collapse to the
> > > > hugepage may return "00001234", right?
> > >
> > > Right. As pointed above this is a valid outcome if the page has been
> > > dropped. User has means to tell that from /proc/vmstat though. Not in=
 a
> > > great precision but I think it would be really surprising to not see =
any
> > > pglazyfreed yet the content is gone. I think it would be legit to cal=
l
> > > it a bug. One could argue the bug would be in the accounting rather t=
han
> > > the khugepaged implementation because madvised pages could be dropped=
 at
> > > any time. But I think it makes more sense to copy the existing conten=
t.
>
> +1. I agree that the content should be dropped iff pglazyfreed is
> incremented. Of course, we could do that here, but I don't think there
> is a good reason to, and we should just copy the contents.
>
> > Yeah, as long as khugepaged sees the MADV_FREE pages, it means they
> > have "NOT" been dropped yet. It may be dropped later if memory
> > pressure occurs, but anyway khugepaged wins the race and khugepaged
> > can't assume the pages will be dropped before they get redirtied. So
> > copying the content does make sense.
>
> Per Lance, I kinda get that this "undermines" MADV_FREE, insofar that,
> from the user's perspective, that memory which was intended as a
> buffer against OOM kill scenarios, is no longer there to reclaim triviall=
y. I
> don't have a real world example where this is an issue, however. Also,
> not copying the contents doesn't change that fact.
>
> The proper alternative, if you want to make the "undermining"
> argument, is for khugepaged to stay away from hugepage regions with
> any MADV_FREE pages. I think it's fair to assume MADV_FREE'd memory is
> likely cold memory, and therefore not a good hugepage target anyways.
> However, it'd be unfortunate if there were a couple MADV_FREE pages in
> the middle of an otherwise hot / highly-utilized hugepage region that
> would prevent it from being pmd-mapped via khugepaged. But.. this is
> exactly-ish what you get when hugepage-ware system/runtime allocators
> split THPs to free up internal caches.
>
> Best,
> Zach
>
>
> > > --
> > > Michal Hocko
> > > SUSE Labs

