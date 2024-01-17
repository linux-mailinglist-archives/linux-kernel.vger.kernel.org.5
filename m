Return-Path: <linux-kernel+bounces-29551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCC283101A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C5E1F27316
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6622563F;
	Wed, 17 Jan 2024 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alQrV5ND"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27F2561F;
	Wed, 17 Jan 2024 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705534371; cv=none; b=KeD5RK3BV13kMuMBlSmZvJvCf6c7RZLRQiLWMbCugTq2Fmhr8yPps6T3NFI9Z5wWmgSNYljJMsUZLf5mrZLjjsaUYIFi6yVRimogC2pg2kzP4fURXoxUVAd7ndAzoh7df/BoJHtu8WWEgj9CVK7f0oocIhNUsndTje2t466qqX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705534371; c=relaxed/simple;
	bh=/SejH5GPjDBEmdN0zOQMUrtZ6fJLviy5zDtIBl23uKY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=GVsFKuCaCwV0H5gba7s09dJ6jfCRUGw6bAxrQs/HSsovxg8LzZbauH9/wuPjTUi4AnppQKPmkeANXbqEOePUulQwBeerZxeG1mphHUndxtgCa57QegWjyV0aLBHfa1Cu8pX/Wo9zoMCXzltjGmFxy6+eYxjTb5YCe7rWeMbXttI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alQrV5ND; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3eb299e2eso71051565ad.2;
        Wed, 17 Jan 2024 15:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705534369; x=1706139169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YfAeTmtk679tAu7dzARGO25mtGdcyY5L1KoEcIoCfE=;
        b=alQrV5ND010icKkELwkMwWR6O3dWQKV9IQ0nmPdVldGqcfZsYT84oyrdW/n2qzU5Ga
         ExTtbotloDHXzDlqEFgrS2uzMFAUWu1l3ihd7EUw91N+HGmC1f7Gt7THi+8M4L6MOtJS
         f7IMj+4sm1iO4e9+A7LIAtKpIpS0pcSr5tdC+Rh4Vl+UPkt5UsZi4ggSHEoFjmA3MO3s
         7ampRZeElITwufNzzei4iH3gUiNxBPXioaoG2uNtlJ5yqQ/GmcNaLe2Frysy/6PFWvT6
         jFtDs1phHIoD8wjiE4Kc2eHb1svXsKq1QwSLf+0mZ3LuTmmKyrrKvay8S2s2pxBEegkM
         t5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705534369; x=1706139169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YfAeTmtk679tAu7dzARGO25mtGdcyY5L1KoEcIoCfE=;
        b=Igpy6bNSeF+ktTJcLgZ2l9O1LyJYiNAsFoShQqh0rjGJlI7Tnzbsc+z4tkIAMORprt
         /wIHwcmVf/1nveGXZBR+wGodB6q+BZRzApuxZADkjIzRyb1mPrYsjjOjpjL8g9JeMVJR
         e0pvvw1ES9qxpbGDnk1hOL9nU03Vn8ldHTgZf+QSA5vRrjaZR278Vriw/naDFmBzexvZ
         FGc7FKLVfa/4Hn+7CzNhVrCHZTFdCNh0StO4UjhzJ6aF4wZCtEWDKRqakjRHgCJjPsGC
         jcg8bHAPFhTFD6ra96ApHurrKKv8eB7jqBLUs2jL+u0bQ5BOqGKDUmELfFHLBD429zZh
         DOvA==
X-Gm-Message-State: AOJu0YwZfa+SYXytq33I8/7k/OgqQkHgO1xe9Wj2MkJ3zjO2/aeJ5M+i
	4IGIsux+P2Y0CaR8caR60kKayc+WR/roAEd8xFxCu5B49a1cQS87PfG7lFsNLgqbvLYzfTVi/gk
	lyT7Qm17SYyMCjYWaVvazSww4EXU=
X-Google-Smtp-Source: AGHT+IGSjjjI48LFbJbhuzvKiPU5xKL4kK9o6cxskSzYKYXU8MavbZwvXf8XIz11R03yYXPwR9d+H6HuDPPtKX52Qo0=
X-Received: by 2002:a17:90a:a893:b0:28e:44e7:fad6 with SMTP id
 h19-20020a17090aa89300b0028e44e7fad6mr17619pjq.90.1705534369306; Wed, 17 Jan
 2024 15:32:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220809142457.4751229f@imladris.surriel.com> <d0a136a0-4a31-46bc-adf4-2db109a61672@kernel.org>
 <3193bf5b-4e22-412f-8c5b-68574942d9bc@kernel.org> <CAJuCfpHXLdQy1a2B6xN2d7quTYwg2OoZseYPZTRpU0eHHKD-sQ@mail.gmail.com>
 <CAHbLzkpEWYhRAabAhrr6zuQqh0rO-mh=NZupDxJJ1BidOt_uiA@mail.gmail.com>
 <CAJuCfpH5gwQc0mBzQ5LOMY9URCTh=58yUJd8pbzzynqAy8_yXw@mail.gmail.com>
 <CAHbLzkoOEEKakj_XCTYhAU8fJWu8in_EY-pHnw76B1=CfYMx1w@mail.gmail.com>
 <CAJuCfpH3SWTzGNQpYXbE0i2XZwodLc0SCRVYijDz2FPQJ2PpiA@mail.gmail.com> <202401170925.015D300A@keescook>
In-Reply-To: <202401170925.015D300A@keescook>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 17 Jan 2024 15:32:37 -0800
Message-ID: <CAHbLzkoHfvLoxbeXUrKAYdEnTigDOC4EO5FU+tQQ9bL5xBrx+g@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Kees Cook <keescook@chromium.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 9:40=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Jan 16, 2024 at 02:30:36PM -0800, Suren Baghdasaryan wrote:
> > On Tue, Jan 16, 2024 at 2:25=E2=80=AFPM Yang Shi <shy828301@gmail.com> =
wrote:
> > >
> > > On Tue, Jan 16, 2024 at 1:58=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > >
> > > > On Tue, Jan 16, 2024 at 12:56=E2=80=AFPM Yang Shi <shy828301@gmail.=
com> wrote:
> > > > >
> > > > > On Tue, Jan 16, 2024 at 11:16=E2=80=AFAM Suren Baghdasaryan <sure=
nb@google.com> wrote:
> > > > > >
> > > > > > On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jirislaby@k=
ernel.org> wrote:
> > > > > > >
> > > > > > > On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > On 09. 08. 22, 20:24, Rik van Riel wrote:
> > > > > > > >> Align larger anonymous memory mappings on THP boundaries b=
y
> > > > > > > >> going through thp_get_unmapped_area if THPs are enabled fo=
r
> > > > > > > >> the current process.
> > > > > > > >>
> > > > > > > >> With this patch, larger anonymous mappings are now THP ali=
gned.
> > > > > > > >> When a malloc library allocates a 2MB or larger arena, tha=
t
> > > > > > > >> arena can now be mapped with THPs right from the start, wh=
ich
> > > > > > > >> can result in better TLB hit rates and execution time.
> > > > > > > >
> > > > > > > > This appears to break 32bit processes on x86_64 (at least).=
 In
> > > > > > > > particular, 32bit kernel or firefox builds in our build sys=
tem.
> > > > > > > >
> > > > > > > > Reverting this on top of 6.7 makes it work again.
> > > > > > > >
> > > > > > > > Downstream report:
> > > > > > > >   https://bugzilla.suse.com/show_bug.cgi?id=3D1218841
> > > > > > > >
> > > > > > > > So running:
> > > > > > > > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > > > > > > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimized =
tmp_vmlinux.btf
> > > > > > > >
> > > > > > > > crashes or errors out with some random errors:
> > > > > > > > [182671] STRUCT idr's field 'idr_next' offset=3D128 bit_siz=
e=3D0 type=3D181346
> > > > > > > > Error emitting field
> > > > > > > >
> > > > > > > > strace shows mmap() fails with ENOMEM right before the erro=
rs:
> > > > > > > > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > > > > > > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > > > > > > > ...
> > > > > > > > 1223  <... mmap2 resumed>)              =3D -1 ENOMEM (Cann=
ot allocate
> > > > > > > > memory)
> > > > > > > >
> > > > > > > > Note the .tmp_vmlinux.btf above can be arbitrary, but likel=
y large
> > > > > > > > enough. For reference, one is available at:
> > > > > > > > https://decibel.fi.muni.cz/~xslaby/n/btf
> > > > > > > >
> > > > > > > > Any ideas?
> > > > > > >
> > > > > > > This works around the problem, of course (but is a band-aid, =
not a fix):
> > > > > > >
> > > > > > > --- a/mm/mmap.c
> > > > > > > +++ b/mm/mmap.c
> > > > > > > @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file, un=
signed long
> > > > > > > addr, unsigned long len,
> > > > > > >                   */
> > > > > > >                  pgoff =3D 0;
> > > > > > >                  get_area =3D shmem_get_unmapped_area;
> > > > > > > -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > > > > > > +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > > > > > > !in_32bit_syscall()) {
> > > > > > >                  /* Ensures that larger anonymous mappings ar=
e THP
> > > > > > > aligned. */
> > > > > > >                  get_area =3D thp_get_unmapped_area;
> > > > > > >          }
> > > > > > >
> > > > > > >
> > > > > > > thp_get_unmapped_area() does not take care of the legacy stuf=
f...
> > > > > >
> > > > > > This change also affects the entropy of allocations. With this =
patch
> > > > > > Android test [1] started failing and it requires only 8 bits of
> > > > > > entropy. The feedback from our security team:
> > > > > >
> > > > > > 8 bits of entropy is already embarrassingly low, but was necess=
ary for
> > > > > > 32 bit ARM targets with low RAM at the time. It's definitely no=
t
> > > > > > acceptable for 64 bit targets.
> > > > >
> > > > > Thanks for the report. Is it 32 bit only or 64 bit is also impact=
ed?
> > > > > If I understand the code correctly, it expects the address alloca=
ted
> > > > > by malloc() is kind of randomized, right?
> > > >
> > > > Yes, correct, the test expects a certain level of address randomiza=
tion.
> > > > The test failure was reported while running kernel_virt_x86_64 targ=
et
> > > > (Android emulator on x86), so it does impact 64bit targets.
> > >
> > > IIUC this breaks the "expectation" for randomized addresses returned
> > > by malloc(), but it doesn't break any real Android application, right=
?
> > > So this is a security concern instead of a real regression.
> >
> > How is making a system move vulnerabile not a real regression?
> >
> > >
> > > I think we can make this opt-in with a knob. Anyone who outweighs
> > > security could opt this feature out. However I'm wondering whether
> > > Android should implement a general address randomization mechanism
> > > instead of depending on "luck" if you do care about it.
> >
> > This is not depending on luck. This is checking for possible
> > vulnerabilities in the system.
> > I admit I'm not a security expert, so I'm looping in Jeff and Kees to c=
hime in.
>
> Hi!
>
> Just to chime in, but reduction in ASLR entropy is absolutely a
> regression. This is userspace visible (via /proc/sys/kernel/randomize_va_=
space,
> /proc/sys/vm/mmap_rnd*_bits) with expectations that it work as
> advertised. So, while 32-bit might be already ASLR-weak, we don't want
> to make things super bad nor break ASLR in compat mode under 64-bit
> systems.
>
> Having an opt-in sounds reasonable, but we need to wire it to the ASLR
> sysctls in some way so nothing lying about the ASLR entropy.

Thanks for the explanation. IIUC the randomiza_va_space and
mmap_rnd_bits randomize the mmap_base and start_brk for each exec()
call. So the heap allocation is randomized. But it seems the formula
doesn't take into account huge page. ARM64 adjusts the mmap_rnd_bits
based on page size.

I did a simple test, which conceptually does:
1. call mmap to allocate 8M heap
2. print out the allocated address
3. run the program 1000 times (launch/exit/re-launch)
4. check how many unique addresses

With the default config on my arm64 VM (mmap_rnd_bits is 18), I saw
134 unique addresses. Without the patch, I saw 945 unique addresses.
So I think the test could replicate what your test does.

When I increased the mmap_rnd_bits to 24, I saw 988 unique addresses
with the patch. x86_64 should have 28 bits by default, it should
randomize the address quite well. I don't know why you still saw this,
or you have a different setting for mmap_rnd_bits?

I'm wondering whether we should take into account huge page alignment
for mmap_rnd_bits. And I think this is a huge page common problem, we
have file mapping huge page aligned as well.

32 bit is easy, I think I can just make thp_get_unmapped_area() a
no-op on 32 bit system.

>
> -Kees
>
> --
> Kees Cook

