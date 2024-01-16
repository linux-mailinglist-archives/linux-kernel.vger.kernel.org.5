Return-Path: <linux-kernel+bounces-28349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FB882FD24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AB11F29B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42F4200D4;
	Tue, 16 Jan 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdgiB7LW"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731DB1F61E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443949; cv=none; b=KclSKDi7WdcyTlc456s0mkjQWpVW3xqb1E2HZdr1Xu8DZMhgB0U/VufpImMwE7/EAD3UucxZumnoy8rdTSMctTUPjFjJoGNQp9i5Zn0uw398XOoqoNFnbJsbioa9aLK3K2uWPjhsCofWty29VAqL5ClwqIjXgVQM8js+Pu4cKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443949; c=relaxed/simple;
	bh=DKgA+dlxyEGNnP8cuvIR9NRxXUo7UPd6v8I9pKZVVK8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=PDK3le40DL1Muvv0IrxiljODcCQ3pTAc7IEBqLYcrU5a9vSTe1O5kp9LeO12z6UvSQZYHJJ1GBtfnu8C5apUn5R63SJkMDxpXQMkDJCoG95ORWU9O2rMfqKZrZWn9OArfe4lVoZpA0m9kmFAbbtkfhxugM9p0sfw62GyYSxBsd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdgiB7LW; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso7802684a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705443947; x=1706048747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRh1CurecANVkvRJGBkdwWHI7bM8Gc7Yz61bIrES0H8=;
        b=fdgiB7LWh+XrtSX7ZskW4L3M52Dzf+HuX9YkjeKxnifeec7bLqgHhwAAtfZ4PF6bpF
         C7Cj4Horq240fBGOQw91e3z/meMsM/WJ5LjOK5yBOWuXyiGY9qBK9u9NAeH8FdW2PMBO
         DG+5jhwvNUY6Re1LjdwJE4Rp4NbamhKsH9gkA2ol9lDL3hxt+YzSxz4lpy/dEFFy0T60
         saD6VUx2cGSj5tmcdgSg596UDHJMZEmsYF7hTIJjj3vUpkjoxJVSnacNJIk7c/62YxOs
         t1vkO2tPDAZpNssJa78nL7RuGuGt58FrkeOc3h5525qBB5mcm6abBMhdsTsRcVrzT31h
         KV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705443947; x=1706048747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRh1CurecANVkvRJGBkdwWHI7bM8Gc7Yz61bIrES0H8=;
        b=BlkHUJLkV2VcSQ17ErKUvgskOmOljv37DEDmDVnKBAzY7/zu0NCrslUlwlID4zQ9hK
         j79GYG4eUQmMnnpe5TxAhfz5b0SOlQP7YvPfmA9u1nH9V47WV0YUkLLsN4ATvYSL8tTD
         Z8m0F6/NrINd0rx6hUso+CXLYs9fLc6mXZUj4wsfqjlJDFyWmjaTpqcXnqxcHM7fleag
         dc5qBvdNW34ZyLiQx4Xe8Y9D8JKpWkWwFf9t0E1tQ1DJG6yHIRyzcmWsLA4P5ly661TV
         bqpZhSl/yIN9PeIAiL5zMcwoazkqSKtiIGECVClIKUvVSWUQFtmO9WCCeigMnJPWrZ7L
         WRkA==
X-Gm-Message-State: AOJu0YzBs20N/5jRockCX7s3uXHP5R5KYdFb+5VW0kJqmpjnpoTMfnK8
	tY+jdGzZHWTjVahIme2w30ejOK4wQNSF3HQxcrs=
X-Google-Smtp-Source: AGHT+IFRJrXrsEiSzRZsaY2lvUUDkwVxrHV1KPZaSHGPXLa2aejHsvO36aUDAkpoOrlLhOI7KT4qG6q0aL15hxl5jmY=
X-Received: by 2002:a05:6a20:182a:b0:19a:589d:498d with SMTP id
 bk42-20020a056a20182a00b0019a589d498dmr6840121pzb.48.1705443947638; Tue, 16
 Jan 2024 14:25:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org> <CAJuCfpHXLdQy1a2B6xN2d7quTYwg2OoZseYPZTRpU0eHHKD-sQ@mail.gmail.com>
 <CAHbLzkpEWYhRAabAhrr6zuQqh0rO-mh=NZupDxJJ1BidOt_uiA@mail.gmail.com> <CAJuCfpH5gwQc0mBzQ5LOMY9URCTh=58yUJd8pbzzynqAy8_yXw@mail.gmail.com>
In-Reply-To: <CAJuCfpH5gwQc0mBzQ5LOMY9URCTh=58yUJd8pbzzynqAy8_yXw@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 16 Jan 2024 14:25:35 -0800
Message-ID: <CAHbLzkoOEEKakj_XCTYhAU8fJWu8in_EY-pHnw76B1=CfYMx1w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Suren Baghdasaryan <surenb@google.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 1:58=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Jan 16, 2024 at 12:56=E2=80=AFPM Yang Shi <shy828301@gmail.com> w=
rote:
> >
> > On Tue, Jan 16, 2024 at 11:16=E2=80=AFAM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > >
> > > On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jirislaby@kernel.=
org> wrote:
> > > >
> > > > On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > > > > Hi,
> > > > >
> > > > > On 09. 08. 22, 20:24, Rik van Riel wrote:
> > > > >> Align larger anonymous memory mappings on THP boundaries by
> > > > >> going through thp_get_unmapped_area if THPs are enabled for
> > > > >> the current process.
> > > > >>
> > > > >> With this patch, larger anonymous mappings are now THP aligned.
> > > > >> When a malloc library allocates a 2MB or larger arena, that
> > > > >> arena can now be mapped with THPs right from the start, which
> > > > >> can result in better TLB hit rates and execution time.
> > > > >
> > > > > This appears to break 32bit processes on x86_64 (at least). In
> > > > > particular, 32bit kernel or firefox builds in our build system.
> > > > >
> > > > > Reverting this on top of 6.7 makes it work again.
> > > > >
> > > > > Downstream report:
> > > > >   https://bugzilla.suse.com/show_bug.cgi?id=3D1218841
> > > > >
> > > > > So running:
> > > > > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > > > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized .tmp_v=
mlinux.btf
> > > > >
> > > > > crashes or errors out with some random errors:
> > > > > [182671] STRUCT idr's field 'idr_next' offset=3D128 bit_size=3D0 =
type=3D181346
> > > > > Error emitting field
> > > > >
> > > > > strace shows mmap() fails with ENOMEM right before the errors:
> > > > > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > > > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > > > > ...
> > > > > 1223  <... mmap2 resumed>)              =3D -1 ENOMEM (Cannot all=
ocate
> > > > > memory)
> > > > >
> > > > > Note the .tmp_vmlinux.btf above can be arbitrary, but likely larg=
e
> > > > > enough. For reference, one is available at:
> > > > > https://decibel.fi.muni.cz/~xslaby/n/btf
> > > > >
> > > > > Any ideas?
> > > >
> > > > This works around the problem, of course (but is a band-aid, not a =
fix):
> > > >
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, unsigned=
 long
> > > > addr, unsigned long len,
> > > >                   */
> > > >                  pgoff =3D 0;
> > > >                  get_area =3D shmem_get_unmapped_area;
> > > > -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > > > +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > > > !in_32bit_syscall()) {
> > > >                  /* Ensures that larger anonymous mappings are THP
> > > > aligned. */
> > > >                  get_area =3D thp_get_unmapped_area;
> > > >          }
> > > >
> > > >
> > > > thp_get_unmapped_area() does not take care of the legacy stuff...
> > >
> > > This change also affects the entropy of allocations. With this patch
> > > Android test [1] started failing and it requires only 8 bits of
> > > entropy. The feedback from our security team:
> > >
> > > 8 bits of entropy is already embarrassingly low, but was necessary fo=
r
> > > 32 bit ARM targets with low RAM at the time. It's definitely not
> > > acceptable for 64 bit targets.
> >
> > Thanks for the report. Is it 32 bit only or 64 bit is also impacted?
> > If I understand the code correctly, it expects the address allocated
> > by malloc() is kind of randomized, right?
>
> Yes, correct, the test expects a certain level of address randomization.
> The test failure was reported while running kernel_virt_x86_64 target
> (Android emulator on x86), so it does impact 64bit targets.

IIUC this breaks the "expectation" for randomized addresses returned
by malloc(), but it doesn't break any real Android application, right?
So this is a security concern instead of a real regression.

I think we can make this opt-in with a knob. Anyone who outweighs
security could opt this feature out. However I'm wondering whether
Android should implement a general address randomization mechanism
instead of depending on "luck" if you do care about it.

>
> >
> > >
> > > Could this change be either reverted or made optional (opt-in/opt-out=
)?
> > > Thanks,
> > > Suren.
> > >
> > > [1] https://cs.android.com/android/platform/superproject/main/+/main:=
cts/tests/aslr/src/AslrMallocTest.cpp;l=3D130
> > >
> > > >
> > > > regards,
> > > > --
> > > > js
> > > > suse labs
> > > >
> > > >

