Return-Path: <linux-kernel+bounces-29580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B7E831065
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DEE32832BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F44631;
	Thu, 18 Jan 2024 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmLGQ7o4"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AA5370;
	Thu, 18 Jan 2024 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536837; cv=none; b=XsDPzKlt98famXxPgt5i1fknpo8+PTJHfR35Z/OceD8P2V6/GJBUSnS9YfessiHavKSM+8GhNC443uQdyO+NGmATuDIZ52Vo0kHLiXm/EoN+oC3Obxqmwr87rZ6XoFq1MkL7mQWcqYkI/HmPYQwmxzCgNb77on0j+azF4yQVq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536837; c=relaxed/simple;
	bh=6OhzFoUt29aqmq0ikYdpYTRuFbfmp+fsgSzBQ0GhQlU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=roOIi0ZntLo0r8NyoLzyAdUIYi3SN0iqXNGPYGvCqD3yFFE7sdB9Wq9avvsArj/c4kElnc/oZL1gA0HVPtCpGguaI6O9yYv1WjKA739KLloz7lq0ngqX+biVFx2GJ8EHehzKA0qZfS1ujSIJZUb3k2EBYykAaVj4hijlaTydWqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmLGQ7o4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d9a79a1ad4so6411829b3a.2;
        Wed, 17 Jan 2024 16:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705536835; x=1706141635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOITPKr6gj8Tz8POR15BR9uZhh9uFiEf+DCyXQVNgyE=;
        b=KmLGQ7o4G2hjafcFgX3f/CWNMT+9hrGki9fGy/TGJuyThrRZb1hynfjGIdUbgJhyLs
         2CJSRh0sSPLKiwj++C8RCxliWGEgi/BygZXVQ5m6iWYF2Ldl7MDp+8GXIBJ9e7YmsaOz
         baNokGADITbomrw4yVV31CWEwyX3Umr4NrGn2r1UE7UUpUjm0Unsj83LIRTsjOphzkho
         07avEaCvDQacD5b93DwjuLDD94nvyoEuIjtYgH5qsPNm0uUXkdSIyTJDnAahZTM+f8cZ
         57KNNUT8IKZPLcfIKxpidDCJiZszP8mY07/nqcdDdQuMi89jAO4ponJgfJL9djMXE6vJ
         zOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705536835; x=1706141635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOITPKr6gj8Tz8POR15BR9uZhh9uFiEf+DCyXQVNgyE=;
        b=dF3mqz9rsVPrceA96PSGRVyK8L/NQzu/uQH4vEVhsF5Yb1j4gwgdXWz/Z6YEn14/c7
         pUKJ6zCpz0aNIXqW9ndd9ulJbkoQpZim47cLtr2ECr9lnWrxBOY4HH8hLz6jyGvraEV+
         akKbIDiOGXFYYSkwUC+rtDoUurUmyE63TNS/akzf5Ry6JMq4Qhs3u51Y24ZC85UCRuCZ
         gQm4sj4pU3yfIdU/x7la6cBKjaDK1DZguewzMy1qQ65Ucv/IgSuNsolbyjapklpr1Uod
         cVMtCOI2UFs1yggLA23237btvR/v7xSHUy67Q3LIQ7ns3wn2GRg+j8qcLkxD9ABXik9D
         nNNQ==
X-Gm-Message-State: AOJu0YzpJgFXchgiU51HMhemUVkh56L4z5JAOhTCqI9ASh7VvSg0uvHA
	q4bDaWIHHtWg2wY2xngM7/BnOxGMtm0rHNOuOM74qY4+uDAp6twk2I+TTL0eDNbRjwmFh8Ek6QI
	ltt6R8GdtqajNEepKutj8WeNqlQo=
X-Google-Smtp-Source: AGHT+IHgfLolLNjIuaIitzPZ8ouXggbxq8Lw5f9f3iTIl4A3dlgnM9Y6qWnZatGpO4aFKg+s6c80owQ2E69sT/GDGk4=
X-Received: by 2002:a05:6a20:1614:b0:19a:999c:665d with SMTP id
 l20-20020a056a20161400b0019a999c665dmr52685pzj.5.1705536835091; Wed, 17 Jan
 2024 16:13:55 -0800 (PST)
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
 <CAJuCfpH3SWTzGNQpYXbE0i2XZwodLc0SCRVYijDz2FPQJ2PpiA@mail.gmail.com>
 <202401170925.015D300A@keescook> <CAHbLzkoHfvLoxbeXUrKAYdEnTigDOC4EO5FU+tQQ9bL5xBrx+g@mail.gmail.com>
 <CAJuCfpGkmN0D9+PFwuOWeGhcVn2+ePdOhXDPGLAM0BTm_XBaYg@mail.gmail.com>
In-Reply-To: <CAJuCfpGkmN0D9+PFwuOWeGhcVn2+ePdOhXDPGLAM0BTm_XBaYg@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 17 Jan 2024 16:13:42 -0800
Message-ID: <CAHbLzkoJpmtncnBQjot3YN3=gbTtWvPnw-xG-BrOpqoUsVeTwA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: align larger anonymous mappings on THP boundaries
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kees Cook <keescook@chromium.org>, Jeffrey Vander Stoep <jeffv@google.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@fb.com, 
	Matthew Wilcox <willy@infradead.org>, Christoph Lameter <cl@linux.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 4:02=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jan 17, 2024 at 3:32=E2=80=AFPM Yang Shi <shy828301@gmail.com> wr=
ote:
> >
> > On Wed, Jan 17, 2024 at 9:40=E2=80=AFAM Kees Cook <keescook@chromium.or=
g> wrote:
> > >
> > > On Tue, Jan 16, 2024 at 02:30:36PM -0800, Suren Baghdasaryan wrote:
> > > > On Tue, Jan 16, 2024 at 2:25=E2=80=AFPM Yang Shi <shy828301@gmail.c=
om> wrote:
> > > > >
> > > > > On Tue, Jan 16, 2024 at 1:58=E2=80=AFPM Suren Baghdasaryan <suren=
b@google.com> wrote:
> > > > > >
> > > > > > On Tue, Jan 16, 2024 at 12:56=E2=80=AFPM Yang Shi <shy828301@gm=
ail.com> wrote:
> > > > > > >
> > > > > > > On Tue, Jan 16, 2024 at 11:16=E2=80=AFAM Suren Baghdasaryan <=
surenb@google.com> wrote:
> > > > > > > >
> > > > > > > > On Tue, Jan 16, 2024 at 4:09=E2=80=AFAM Jiri Slaby <jirisla=
by@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On 16. 01. 24, 12:53, Jiri Slaby wrote:
> > > > > > > > > > Hi,
> > > > > > > > > >
> > > > > > > > > > On 09. 08. 22, 20:24, Rik van Riel wrote:
> > > > > > > > > >> Align larger anonymous memory mappings on THP boundari=
es by
> > > > > > > > > >> going through thp_get_unmapped_area if THPs are enable=
d for
> > > > > > > > > >> the current process.
> > > > > > > > > >>
> > > > > > > > > >> With this patch, larger anonymous mappings are now THP=
 aligned.
> > > > > > > > > >> When a malloc library allocates a 2MB or larger arena,=
 that
> > > > > > > > > >> arena can now be mapped with THPs right from the start=
, which
> > > > > > > > > >> can result in better TLB hit rates and execution time.
> > > > > > > > > >
> > > > > > > > > > This appears to break 32bit processes on x86_64 (at lea=
st). In
> > > > > > > > > > particular, 32bit kernel or firefox builds in our build=
 system.
> > > > > > > > > >
> > > > > > > > > > Reverting this on top of 6.7 makes it work again.
> > > > > > > > > >
> > > > > > > > > > Downstream report:
> > > > > > > > > >   https://bugzilla.suse.com/show_bug.cgi?id=3D1218841
> > > > > > > > > >
> > > > > > > > > > So running:
> > > > > > > > > > pahole -J --btf_gen_floats -j --lang_exclude=3Drust
> > > > > > > > > > --skip_encoding_btf_inconsistent_proto --btf_gen_optimi=
zed .tmp_vmlinux.btf
> > > > > > > > > >
> > > > > > > > > > crashes or errors out with some random errors:
> > > > > > > > > > [182671] STRUCT idr's field 'idr_next' offset=3D128 bit=
_size=3D0 type=3D181346
> > > > > > > > > > Error emitting field
> > > > > > > > > >
> > > > > > > > > > strace shows mmap() fails with ENOMEM right before the =
errors:
> > > > > > > > > > 1223  mmap2(NULL, 5783552, PROT_READ|PROT_WRITE,
> > > > > > > > > > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0 <unfinished ...>
> > > > > > > > > > ...
> > > > > > > > > > 1223  <... mmap2 resumed>)              =3D -1 ENOMEM (=
Cannot allocate
> > > > > > > > > > memory)
> > > > > > > > > >
> > > > > > > > > > Note the .tmp_vmlinux.btf above can be arbitrary, but l=
ikely large
> > > > > > > > > > enough. For reference, one is available at:
> > > > > > > > > > https://decibel.fi.muni.cz/~xslaby/n/btf
> > > > > > > > > >
> > > > > > > > > > Any ideas?
> > > > > > > > >
> > > > > > > > > This works around the problem, of course (but is a band-a=
id, not a fix):
> > > > > > > > >
> > > > > > > > > --- a/mm/mmap.c
> > > > > > > > > +++ b/mm/mmap.c
> > > > > > > > > @@ -1829,7 +1829,7 @@ get_unmapped_area(struct file *file=
, unsigned long
> > > > > > > > > addr, unsigned long len,
> > > > > > > > >                   */
> > > > > > > > >                  pgoff =3D 0;
> > > > > > > > >                  get_area =3D shmem_get_unmapped_area;
> > > > > > > > > -       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE=
)) {
> > > > > > > > > +       } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE=
) &&
> > > > > > > > > !in_32bit_syscall()) {
> > > > > > > > >                  /* Ensures that larger anonymous mapping=
s are THP
> > > > > > > > > aligned. */
> > > > > > > > >                  get_area =3D thp_get_unmapped_area;
> > > > > > > > >          }
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > thp_get_unmapped_area() does not take care of the legacy =
stuff...
> > > > > > > >
> > > > > > > > This change also affects the entropy of allocations. With t=
his patch
> > > > > > > > Android test [1] started failing and it requires only 8 bit=
s of
> > > > > > > > entropy. The feedback from our security team:
> > > > > > > >
> > > > > > > > 8 bits of entropy is already embarrassingly low, but was ne=
cessary for
> > > > > > > > 32 bit ARM targets with low RAM at the time. It's definitel=
y not
> > > > > > > > acceptable for 64 bit targets.
> > > > > > >
> > > > > > > Thanks for the report. Is it 32 bit only or 64 bit is also im=
pacted?
> > > > > > > If I understand the code correctly, it expects the address al=
located
> > > > > > > by malloc() is kind of randomized, right?
> > > > > >
> > > > > > Yes, correct, the test expects a certain level of address rando=
mization.
> > > > > > The test failure was reported while running kernel_virt_x86_64 =
target
> > > > > > (Android emulator on x86), so it does impact 64bit targets.
> > > > >
> > > > > IIUC this breaks the "expectation" for randomized addresses retur=
ned
> > > > > by malloc(), but it doesn't break any real Android application, r=
ight?
> > > > > So this is a security concern instead of a real regression.
> > > >
> > > > How is making a system move vulnerabile not a real regression?
> > > >
> > > > >
> > > > > I think we can make this opt-in with a knob. Anyone who outweighs
> > > > > security could opt this feature out. However I'm wondering whethe=
r
> > > > > Android should implement a general address randomization mechanis=
m
> > > > > instead of depending on "luck" if you do care about it.
> > > >
> > > > This is not depending on luck. This is checking for possible
> > > > vulnerabilities in the system.
> > > > I admit I'm not a security expert, so I'm looping in Jeff and Kees =
to chime in.
> > >
> > > Hi!
> > >
> > > Just to chime in, but reduction in ASLR entropy is absolutely a
> > > regression. This is userspace visible (via /proc/sys/kernel/randomize=
_va_space,
> > > /proc/sys/vm/mmap_rnd*_bits) with expectations that it work as
> > > advertised. So, while 32-bit might be already ASLR-weak, we don't wan=
t
> > > to make things super bad nor break ASLR in compat mode under 64-bit
> > > systems.
> > >
> > > Having an opt-in sounds reasonable, but we need to wire it to the ASL=
R
> > > sysctls in some way so nothing lying about the ASLR entropy.
> >
> > Thanks for the explanation. IIUC the randomiza_va_space and
> > mmap_rnd_bits randomize the mmap_base and start_brk for each exec()
> > call. So the heap allocation is randomized. But it seems the formula
> > doesn't take into account huge page. ARM64 adjusts the mmap_rnd_bits
> > based on page size.
> >
> > I did a simple test, which conceptually does:
> > 1. call mmap to allocate 8M heap
> > 2. print out the allocated address
> > 3. run the program 1000 times (launch/exit/re-launch)
> > 4. check how many unique addresses
> >
> > With the default config on my arm64 VM (mmap_rnd_bits is 18), I saw
> > 134 unique addresses. Without the patch, I saw 945 unique addresses.
> > So I think the test could replicate what your test does.
> >
> > When I increased the mmap_rnd_bits to 24, I saw 988 unique addresses
> > with the patch. x86_64 should have 28 bits by default, it should
> > randomize the address quite well. I don't know why you still saw this,
> > or you have a different setting for mmap_rnd_bits?
>
> I checked the configuration on our test harness where the test failed:

Thanks, Suren.

>
> /proc/sys/vm/mmap_rnd_bits =3D 32

It is surprising 32 bits still fail. 24 bits on arm64 works for me. Or
the compat bits is used?

> /proc/sys/vm/mmap_rnd_compat_bits =3D 16
>
> The failure logs are:
>
> 10-20 14:37:52.123  7029  7029 V AslrMallocTest: 7 bits of entropy for
> allocation size 8388608 (minimum 8)
> 10-20 14:37:52.123  7029  7029 E AslrMallocTest: insufficient entropy
> for malloc(8388608)
>
> which come from here:
> https://cs.android.com/android/platform/superproject/main/+/main:cts/test=
s/aslr/src/AslrMallocTest.cpp;l=3D127
> So, the allocation size for which this test failed was 2^23.

The patch just tries to align >=3D 2M allocations. It looks like your
test allocates 256 bytes, 64K and 8M. So just 8M is impacted.


>
>
> > I'm wondering whether we should take into account huge page alignment
> > for mmap_rnd_bits. And I think this is a huge page common problem, we
> > have file mapping huge page aligned as well.
> >
> > 32 bit is easy, I think I can just make thp_get_unmapped_area() a
> > no-op on 32 bit system.
> >
> > >
> > > -Kees
> > >
> > > --
> > > Kees Cook

