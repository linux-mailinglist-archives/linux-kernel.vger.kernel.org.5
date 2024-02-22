Return-Path: <linux-kernel+bounces-76870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC7785FDF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26492287E95
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76A0151CD9;
	Thu, 22 Feb 2024 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qq79rg5Y"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65F1B7E6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619069; cv=none; b=iJfBU8tRraYKcTYivcrPXobHbX2Uhym/8s/eqn40GckviBNOIcB5vkEPch8CIY10FCGYAaIkTY7nE48AE23Xh4GoC+jsFqJk5SqNxw1x0aX6QOUMzdMEBvlT1cJVSlqO0DjjLZyipT2lC27PA2wC54ZgWtV3skFgsxoxURYllsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619069; c=relaxed/simple;
	bh=IHmuDsJUJwnA35p5L2iBJqOeSgi+X871bHyCYDlFE1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V43Do/LF7GjTiMa5RnBphT/M7nwWMJOPJcQBBnBfS6XNJDBz51Xuh4pBENAWMsuDAD/sLL4eMRtKsm3vr0Of2DfIliW8Sg9fOBA/kC9dBu2bXrBxraoj3WOlSKSOipqHOt0b16YQSKK4hEir3FP/++/P8cdLOSo4Me9lXpsvHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qq79rg5Y; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c17ac08a38so466538b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708619067; x=1709223867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EqmFmOYCa3OzZ9OMKnDFgfBUj0DGssnGUEfC4f0Dsk=;
        b=Qq79rg5YcZdywscXswfmPx2IYVpvmuaWlR0mN2RN4ExgAmUK3+r2S8zZFXsBPg5UWs
         mPnLR1L1MubkgQ0kR4cLAj+DN6L+KvyF6WTrCmtQa+/xj37js3Kv97DiCJr2m0vHiUEw
         KTkVhtTjLxQMNmqobRg3E1gu4+jr9J/d8yoROIMEP+08gt4HHpDhIXsK2OkTwHsYZKB1
         5ApEj/eZ2G5sIG0yQK1awrXirqzTDgXO36L8hRaox1znkJhHnM/srSsq4qLWitOYkOG6
         yta++z2EFEVXnTSxpFJ35TVPTYr+QrL2T1xgB9tIv2ynDCezFsOzlLiHabYTFqZWG1Tf
         oFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619067; x=1709223867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EqmFmOYCa3OzZ9OMKnDFgfBUj0DGssnGUEfC4f0Dsk=;
        b=Drj0w3Ih0BC79MxrEzM41OPABsGQFNxFp1YMiWKnKWhRY0Oe0P/n0rHyiv7+IPD7nJ
         dV4y9yW+BcmXXBTev8Vm/exzEHGcErH6X3e6PPqyICJNA0cOelAY9GRIRv+qsXCoakwe
         t4Prd6Y/r03vufF7lE3Qp6OQi/y+5RYmohM218GVrcw18gIjcKj18jSOkSk5lz75bHNg
         N+DvOJq3GQlZg5alBSvdvEW7CB/L2O5Gpg+BpPMBaRNsEQW3VLKm1P53PRMnIiaroepa
         bhWipfiXxZm3+RNginbUNHoAEVjoMJM20JezkCouUjTSQmP6dxfJqfxDTTOFBkybGIoL
         NbGA==
X-Forwarded-Encrypted: i=1; AJvYcCWIAoGmleYalgpVTrvOwsoLWcuFEXukjay7zz6mxUgs+14KeV2GKOUKj7IMW0N5ygVn5ItXlUXUIL3tvBJOBGoB/CWgksa4YqN+ErAV
X-Gm-Message-State: AOJu0YxSPmvUeOhR5SZUsEuW3uYDdenB8NN3A+3DCrb3BTahuxtVx9Dk
	ba3KmpGQjqHzcRcvQ0DJwCV01AfQrImDzL/DmXmvuhK1khAbUCfiydJ8TlpNct1SnS7HNrqOOLI
	GXVjYCsyxRgZKj0O00fg8hdahSfI=
X-Google-Smtp-Source: AGHT+IHwo0OJPxms5ngEpqSEBC8PZ11D7hXFbOD8dnp1ziM2q2D/PE45FsO7gx3uvaqKPdF3wrszwYSjWXzcNrTqORE=
X-Received: by 2002:a05:6808:13c3:b0:3c1:5482:770e with SMTP id
 d3-20020a05680813c300b003c15482770emr14635719oiw.10.1708619067537; Thu, 22
 Feb 2024 08:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221160235.1771-1-mcassell411@gmail.com> <1547a955-cee6-40e1-8231-0bd1229de0f3@redhat.com>
In-Reply-To: <1547a955-cee6-40e1-8231-0bd1229de0f3@redhat.com>
From: Matthew Cassell <mcassell411@gmail.com>
Date: Thu, 22 Feb 2024 10:24:16 -0600
Message-ID: <CANiscBBhk+g267yYz8DhgU23gt0Ranak4VctxeG1-_tt_KkOag@mail.gmail.com>
Subject: Re: [PATCH] mm/util.c: Added page count to __vm_enough_memory failure warning
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending due to plain-text email issue that caused mailing list to get ski=
pped.

Thank you for the feedback. I agree with you and would prefer to use
bytes/kbytes. Here are the 2 concerns that led to me keeping it as
pages:


1. Reduce the impact of the patch. Here is the call trace to reach the
failure warning:

<=E2=80=A6 usual mmap() stuff =E2=80=A6>
mmap_region() -> security_enough_memory_mm() -> __vm_enough_memory()

Within mmap_region(), the length variable originally passed to mmap()
gets right-shifted to get the page count. My first thought was to add
an additional an additional argument to security_enough_memory_mm() of
type unsigned long to keep that variable, but saw a handful of calls
to it that would have to conform to the change. Not that I do not
think this debug statement does not warrant that, I felt the less
impact, the better.


2. Concerned about losing bits. When converting back to bytes I was
worried about the loss of precision and printing that number back to
users:

unsigned long bytes_failed =3D pages << (PAGE_SHIFT);


On Thu, Feb 22, 2024 at 6:18=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 21.02.24 17:02, Matthew Cassell wrote:
> > Commit 44b414c8715c5dcf53288 ("mm/util.c: add warning if __vm_enough_me=
mory
> > fails") adds debug information which gives the process id and executabl=
e name
> > should __vm_enough_memory() fail. Adding the number of pages to the fai=
lure
> > message would benefit application developers and system administrators =
in
> > debugging overambitious memory requests by providing a point of referen=
ce to
> > the amount of memory causing __vm_enough_memory() to fail.
> >
> > 1. Set appropriate kernel tunable to reach code path for failure
> >     message:
> >
> >       # echo 2 > /proc/sys/vm/overcommit_memory
> >
> > 2. Test program to generate failure - requests 1 gibibyte per iteration=
:
> >
> >       #include <stdlib.h>
> >       #include <stdio.h>
> >
> >       int main(int argc, char **argv) {
> >               for(;;) {
> >                       if(malloc(1<<30) =3D=3D NULL)
> >                               break;
> >
> >                       printf("allocated 1 GiB\n");
> >               }
> >
> >               return 0;
> >       }
> >
> > 3. Output:
> >
> >       Before:
> >
> >       __vm_enough_memory: pid: 1218, comm: a.out, not enough
> > memory for the allocation
> >
> >       After:
> >
> >       __vm_enough_memory: pid: 1141, comm: a.out, pages: 262145, not
> > enough memory for the allocation
> >
> > Signed-off-by: Matthew Cassell <mcassell411@gmail.com>
> > ---
> >   mm/util.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/util.c b/mm/util.c
> > index 5a6a9802583b..c0afb56f16ea 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -976,8 +976,8 @@ int __vm_enough_memory(struct mm_struct *mm, long p=
ages, int cap_sys_admin)
> >       if (percpu_counter_read_positive(&vm_committed_as) < allowed)
> >               return 0;
> >   error:
> > -     pr_warn_ratelimited("%s: pid: %d, comm: %s, not enough memory for=
 the allocation\n",
> > -                         __func__, current->pid, current->comm);
> > +     pr_warn_ratelimited("%s: pid: %d, comm: %s, pages: %ld, not enoug=
h memory for the allocation\n",
> > +                         __func__, current->pid, current->comm, pages)=
;
> >       vm_unacct_memory(pages);
> >
> >       return -ENOMEM;
>
> I wonder if "bytes"/"kbytes" instead of pages would be more appropriate
> here.
>
> Often, this will fail due to mmap() [where we pass a size from user
> space] and also "vm.overcommit_kbytes" is not in pages.
>
> --
> Cheers,
>
> David / dhildenb
>

