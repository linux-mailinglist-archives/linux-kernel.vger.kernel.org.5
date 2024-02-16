Return-Path: <linux-kernel+bounces-68070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB574857595
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112DE1F24A25
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA4312E71;
	Fri, 16 Feb 2024 05:20:07 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4717EF;
	Fri, 16 Feb 2024 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708060807; cv=none; b=TNj9qWryY/qK3YyRraC/kxe5aaGyPTIjDvC8IbahojxRIvXJ/vTWtYBj6b7o3DmI7dxW1W0Ob/XrGIHOy1T1YNb1RY6JLlyJkVAxQUnPtdRlF9nC9YjDwjCppvIizjjHt9Ro3T6Axyki49qwSt6EqafWc+5JvzDkHsL6WG8lAWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708060807; c=relaxed/simple;
	bh=U6hXNVQt351J/DhTewX+OZcdXZBZfn4AzdJHD2J2+M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YprOfFLO8KGINdOoGXtVv37RN9Wvb/krB41pPVpXiSdSmI/sF9/Cil8OHttNu5oM8KKy36gr6qY6HQr+sAxAPaZclYGAmQ0y24C9xGdXZePaVFfujsmltAUiOvpZ1eS3pDEAhQ0/uUTKGX7D133RLg/kUuyT9OwWg/2QFkdCsTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d3907ff128so1417861a12.3;
        Thu, 15 Feb 2024 21:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708060804; x=1708665604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOkv4nOPifpi80IkBp1vQTmLYuXm46+d52ga9BzQdQg=;
        b=IRtIWwqT3Mi+0t9u52AaPtR0ZvP+CZN+BXlFQ6l9xXznCjqG7oB77wrFuQDiznTjcI
         TtlCbYXZB8f7wtixWDC4v1m7DZi5z7nOK22QbzFl/JI4YT1ddHt+BmbuUWxZAtsEqTyX
         iWKFMVmU+RU1tkgkJN0sBWj25bKxDB+8pU6FDYmao1V+/WMzF4Wpxo4iZv0TvTTZHCyt
         02S7ymkP+5gqKdoh/TMNN8UzEoKxYJh1E3rrnt7yYu89mDADZUv4Y4idIGZBbsX+ESqa
         rpRxEzKTTygmQunnbDItCCMKjGLuvpDV97LH6z0NHq3V1XFraWzo4Kdc2wZK1LJXT5t+
         Ia9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUf+IF7i2a9p6bFO39tTPltUtSoWtJ/kWDk/qDfVbTKDJ1hNqVP0vTKTXHCtYhYvs4hZlEqoSSs2JW4+dXfCNvC2KZJ4PtsmJVvon3rY/z/2dFQ6W2BJWTP2R2TJxpsLsq9dbp8yNTCexqXYjwweg==
X-Gm-Message-State: AOJu0YybJUrQbvBTw3ekcgzWzV7k+xhzJNdGrZdKtEtcAX6fankWItkt
	sxYrOM+Cfs5JSaardh2UKW2d8vCl+frmmy+V1BFBnaPNFSAX3vGoeGnuWMEDK1eSrMcuk4s4Mti
	A3dy7VKovpDbe9ZcJnTfRS1dOq4Y=
X-Google-Smtp-Source: AGHT+IGIOb0Owwp8yzIIoHboFTczKfxi12EkiHcjbz+ReZOesNDp/0xfvVEPhWZh652ONXf3nALqBKgNhYaEEDwvlls=
X-Received: by 2002:a05:6a20:c792:b0:1a0:6d4e:57bc with SMTP id
 hk18-20020a056a20c79200b001a06d4e57bcmr4771701pzb.58.1708060804393; Thu, 15
 Feb 2024 21:20:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212233322.1855161-1-namhyung@kernel.org> <20240213033954.GB81405@debian-dev>
 <CAM9d7ciTwYAgry-nW9z+_VMj+BJ7ZNZnkKH_t_AHvV5joNuWQQ@mail.gmail.com> <20240214101420.GF81405@debian-dev>
In-Reply-To: <20240214101420.GF81405@debian-dev>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 15 Feb 2024 21:19:51 -0800
Message-ID: <CAM9d7cgWXyv1Uy=ZWsT6K=KaztgtszZp0BOxPAbgjuKuX6OzdQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Fixup module symbol end address properly
To: Leo Yan <leo.yan@linux.dev>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 2:14=E2=80=AFAM Leo Yan <leo.yan@linux.dev> wrote:
>
> On Tue, Feb 13, 2024 at 10:48:53AM -0800, Namhyung Kim wrote:
> > Hi Leo,
> >
> > Thanks for your review!
> >
> > On Mon, Feb 12, 2024 at 7:40???PM Leo Yan <leo.yan@linux.dev> wrote:
> > >
> > > On Mon, Feb 12, 2024 at 03:33:22PM -0800, Namhyung Kim wrote:
> > > > I got a strange error on ARM to fail on processing FINISHED_ROUND
> > > > record.  It turned out that it was failing in symbol__alloc_hist()
> > > > because the symbol size is too big.
> > > >
> > > > When a sample is captured on a specific BPF program, it failed.  I'=
ve
> > > > added a debug code and found the end address of the symbol is from
> > > > the next module which is placed far way.
> > > >
> > > >   ffff800008795778-ffff80000879d6d8: bpf_prog_1bac53b8aac4bc58_netc=
g_sock    [bpf]
> > > >   ffff80000879d6d8-ffff80000ad656b4: bpf_prog_76867454b5944e15_netc=
g_getsockopt      [bpf]
> > > >   ffff80000ad656b4-ffffd69b7af74048: bpf_prog_1d50286d2eb1be85_hn_e=
gress     [bpf]   <---------- here
> > > >   ffffd69b7af74048-ffffd69b7af74048: $x.5    [sha3_generic]
> > > >   ffffd69b7af74048-ffffd69b7af740b8: crypto_sha3_init        [sha3_=
generic]
> > > >   ffffd69b7af740b8-ffffd69b7af741e0: crypto_sha3_update      [sha3_=
generic]
> > > >
> > > > The logic in symbols__fixup_end() just uses curr->start to update t=
he
> > > > prev->end.  But in this case, it won't work as it's too different.
> > > >
> > > > I think ARM has a different kernel memory layout for modules and BP=
F
> > > > than on x86.  Actually there's a logic to handle kernel and module
> > > > boundary.  Let's do the same for symbols between different modules.
> > >
> > > Even Arm32 and Arm64 kernel have different memory layout for modules
> > > and kernel image.
> > >
> > > eBPF program (JITed) should be allocated from the vmalloc region, for
> > > Arm64, see bpf_jit_alloc_exec() in arch/arm64/net/bpf_jit_comp.c.
> >
> > Ok, so chances are they can fall out far away right?
>
> Yes, this is my understanding.
>
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/perf/util/symbol.c | 21 +++++++++++++++++++--
> > > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > > > index 35975189999b..9ebdb8e13c0b 100644
> > > > --- a/tools/perf/util/symbol.c
> > > > +++ b/tools/perf/util/symbol.c
> > > > @@ -248,14 +248,31 @@ void symbols__fixup_end(struct rb_root_cached=
 *symbols, bool is_kallsyms)
> > > >                * segment is very big.  Therefore do not fill this g=
ap and do
> > > >                * not assign it to the kernel dso map (kallsyms).
> > > >                *
> > > > +              * Also BPF code can be allocated separately from tex=
t segments
> > > > +              * and modules.  So the last entry in a module should=
 not fill
> > > > +              * the gap too.
> > > > +              *
> > > >                * In kallsyms, it determines module symbols using '[=
' character
> > > >                * like in:
> > > >                *   ffffffffc1937000 T hdmi_driver_init  [snd_hda_co=
dec_hdmi]
> > > >                */
> > > >               if (prev->end =3D=3D prev->start) {
> > > > +                     const char *prev_mod;
> > > > +                     const char *curr_mod;
> > > > +
> > > > +                     if (!is_kallsyms) {
> > > > +                             prev->end =3D curr->start;
> > > > +                             continue;
> > > > +                     }
> > > > +
> > > > +                     prev_mod =3D strchr(prev->name, '[');
> > > > +                     curr_mod =3D strchr(curr->name, '[');
> > > > +
> > > >                       /* Last kernel/module symbol mapped to end of=
 page */
> > > > -                     if (is_kallsyms && (!strchr(prev->name, '[') =
!=3D
> > > > -                                         !strchr(curr->name, '['))=
)
> > > > +                     if (!prev_mod !=3D !curr_mod)
> > > > +                             prev->end =3D roundup(prev->end + 409=
6, 4096);
> > > > +                     /* Last symbol in the previous module */
> > > > +                     else if (prev_mod && strcmp(prev_mod, curr_mo=
d))
> > >
> > > Should two consecutive moudles fall into this case? I think we need t=
o assign
> > > 'prev->end =3D curr->start' for two two consecutive moudles.
> >
> > Yeah I thought about that case but I believe they would be on
> > separate pages (hopefully there's a page gap between them).
> > So I think it should not overlap.  But if you really care we can
> > check it explicitly like this:
> >
> >     prev->end =3D min(roundup(...), curr->start);
>
> I am not concerned that to assign a bigger end value for the 'prev'
> symbol. With an exaggerate end region, it will not cause any
> difficulty for parsing symbols.

Right, but my problem was not in parsing.  It failed to allocate
memory for the symbol because it's too big.

> On the other hand, I am a bit concern
> for a big function (e.g. its code size > 4KiB), we might fail to find
> symbols in this case with the change above.

Yes, it's another problem.  But it cannot know the exact size
so it just assumes it fits in a page.

>
> > > If so, we should use a specific checking for eBPF program, e.g.:
> > >
> > >                         else if (prev_mod && strcmp(prev_mod, curr_mo=
d) &&
> > >                                  (!strcmp(prev->name, "bpf") ||
> > >                                   !strcmp(curr->name, "bpf")))
> >
> > I suspect it can happen on any module boundary so better
> > to handle it in a more general way.
>
> I don't want to introduce over complexity at here. We can apply
> current patch as it is.

Good, can I get your Reviewed-by then? :)

>
> A side topic, when I saw the code is hard coded for 4096 as the page
> size, this is not always true on Arm64 (the page size can be 4KiB,
> 16KiB or 64KiB). We need to consider to extend the environment for
> recording the system's page size.

Sounds good.  But until then, 4K would be the reasonable choice.

Thanks,
Namhyung

> >
> > >
> > > >                               prev->end =3D roundup(prev->end + 409=
6, 4096);
> > > >                       else
> > > >                               prev->end =3D curr->start;
> > > > --
> > > > 2.43.0.687.g38aa6559b0-goog
> > > >

