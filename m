Return-Path: <linux-kernel+bounces-241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1667D813E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C348E283681
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7875E6C6DC;
	Thu, 14 Dec 2023 23:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dzzJ5ELw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C86C6D7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-77f8dd477fcso6979785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 15:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702596109; x=1703200909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmbndnjcrhmBBoxS6pcuDX2mGwfUQXEv+7vBpDoTDrg=;
        b=dzzJ5ELwc1qH8EKe/Cyt1XCrGAl9DRHAfuYscFetU0GOQK9uAhTXbE3+i4UQoG/+k2
         tQ8sv1oIwK1U4NRkA9dK4AV1IsPEwohaKiEcOe8JYTk8XGMXj5kfCHtXLcMaZ0pS+MwA
         gNeH52PAJcUOh/zl6a9S4cCaE2zaQmeRFHVc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702596109; x=1703200909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmbndnjcrhmBBoxS6pcuDX2mGwfUQXEv+7vBpDoTDrg=;
        b=hoVi8Uq1oJnHPHnTNk3YKZGw4kiFo4fhry9STK68poKxUA3QEeNCjPQ1Soy8TlMG2F
         lKyOQqvG2hSv++GukiFDLyh40LfKFsOTXwV/yuvZQlKwd/aOw0AGv45BO6vEODSCxA08
         qyK377dOF6wMpzC4DNT7hOJcRcIS3oTtFlIX63v+C2VOnwU3iYjAKZpO202l1or2Wogi
         bO0v/ZW4MIWBBhLejaRW11yq8VqNyCZrsgzzS+SeLNhyH0ThqX3zeBOAIib+Qq39SOV0
         5hO+rVWVUHu8y0U51Ao/c2oQZ4gZibdulHFdoEpMPs7XKL78M+Wp+rteo/CB4xPTatEE
         WHjA==
X-Gm-Message-State: AOJu0YyWPIo037VUW+VEAHcOYpKhAsHDpkvUpr23zoJViKjSnI5henfJ
	IcoBq/68DtTeh0+1WWVQkfOK239x2vleBlEVj3rBEmNe23BawJxgDDA=
X-Google-Smtp-Source: AGHT+IFJ3y2PMmXoZvkDVH8ICFf94qmbkoc3S1Oy8RrT8fx8p95Ie2no/+Omtw/FDZnEY3SV+ywQp6V5BnIOf2HtW54=
X-Received: by 2002:a05:6870:41cc:b0:203:4c85:562f with SMTP id
 z12-20020a05687041cc00b002034c85562fmr1695983oac.59.1702594390274; Thu, 14
 Dec 2023 14:53:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
 <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
 <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
 <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com>
 <CAEAAPHZpYXHNPdca+xfj77bwYaL6PY-c_oQ54r+=wtJa6_hmCA@mail.gmail.com> <CAHk-=wiVhHmnXviy1xqStLRozC4ziSugTk=1JOc8ORWd2_0h7g@mail.gmail.com>
In-Reply-To: <CAHk-=wiVhHmnXviy1xqStLRozC4ziSugTk=1JOc8ORWd2_0h7g@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 14 Dec 2023 14:52:58 -0800
Message-ID: <CABi2SkUTdF6PHrudHTZZ0oWK-oU+T-5+7Eqnei4yCj2fsW2jHg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Jeff Xu <jeffxu@google.com>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:14=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 14 Dec 2023 at 10:07, Stephen R=C3=B6ttger <sroettger@google.com>=
 wrote:
> >
> > AIUI, the madvise(DONTNEED) should effectively only change the content =
of
> > anonymous pages, i.e. it's similar to a memset(0) in that case. That's =
why we
> > added this special case: if you want to madvise(DONTNEED) an anonymous =
page,
> > you should have write permissions to the page.
>
> Hmm. I actually would be happier if we just made that change in
> general. Maybe even without sealing, but I agree that it *definitely*
> makes sense in general as a sealing thing.
>
> IOW, just saying
>
>  "madvise(DONTNEED) needs write permissions to an anonymous mapping when =
sealed"
>
> makes 100% sense to me. Having a separate _flag_ to give sensible
> semantics is just odd.
>
> IOW, what I really want is exactly that "sensible semantics, not random f=
lags".
>
> Particularly for new system calls with fairly specialized use, I think
> it's very important that the semantics are sensible on a conceptual
> level, and that we do not add system calls that are based on "random
> implementation issue of the day".
>
> Yes, yes, then as we have to maintain things long-term, and we hit
> some compatibility issue, at *THAT* point we'll end up facing nasty
> "we had an implementation that had these semantics in practice, so now
> we're stuck with it", but when introducing a new system call, let's
> try really hard to start off from those kinds of random things.
>
> Wouldn't it be lovely if we can just come up with a sane set of "this
> is what it means to seal a vma", and enumerate those, and make those
> sane conceptual rules be the initial definition. By all means have a
> "flags" argument for future cases when we figure out there was
> something wrong or the notion needed to be extended, but if we already
> *start* with random extensions, I feel there's something wrong with
> the whole concept.
>
> So I would really wish for the first version of
>
>      mseal(start, len, flags);
>
> to have "flags=3D0" be the one and only case we actually handle
> initially, and only add a single PROT_SEAL flag to mmap() that says
> "create this mapping already pre-sealed".
>
> Strive very hard to make sealing be a single VM_SEALED flag in the
> vma->vm_flags that we already have, just admit that none of this
> matters on 32-bit architectures, so that VM_SEALED can just use one of
> the high flags that we have several free of (and that pkeys already
> depends on), and make this a standard feature with no #ifdef's.
>
> Can chrome live with that? And what would the required semantics be?
> I'll start the list:
>
>  - you can't unmap or remap in any way (including over-mapping)
>
>  - you can't change protections (but with architecture support like
> pkey, you can obviously change the protections indirectly with PKRU
> etc)
>
>  - you can't do VM operations that change data without the area being
> writable (so the DONTNEED case - maybe there are others)
>
>  - anything else?
>
> Wouldn't it be lovely to have just a single notion of sealing that is
> well-documented and makes sense, and doesn't require people to worry
> about odd special cases?
>
> And yes, we'd have the 'flags' argument for future special cases, and
> hope really hard that it's never needed.
>

Yes, those inputs make a lot of sense !
I will start the next version. In the meantime, if there are more
comments, please continue to post, I appreciate those to make the API
better and simple to use.

-Jeff

>            Linus
>

