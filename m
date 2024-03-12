Return-Path: <linux-kernel+bounces-100902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EFB879F0E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE711C21959
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998353B2A4;
	Tue, 12 Mar 2024 22:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIVWnHwx"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475B14293;
	Tue, 12 Mar 2024 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710283375; cv=none; b=U3OwTx5tK3FhJ7FX55og/DhytODestP7hdIo+o9CI08l41BKfQUqj/wvcMxm+lzV2j7gLbJJQQQlWlSQcGByvfJ5r0L3GgzVjdyE4Mdq3rhnhiTHbbuccMM1ChGy/XlR0q2YMldlGkD2ouFImQFXdzjy3REr3MJG23OoKa0gC6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710283375; c=relaxed/simple;
	bh=itk3+aa121hQohCaZWXLyFbk44xpebuGh6lznsJnwBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9XYgKaknHZp7ZvtC5i8IWfUvneyQ4nAXbD8In/SBGVXGAp79so+4cvgq9bZpoX0Qsfz2EqLvjP7BmYcP6eFhFyUYrgSTyTTH4mLYwwLFH9yXmJQiXBQ7Lo/Q1DC3ovrfuXapaNoAzht05YCWjk3P1kR3v2VyAcgGaL2+46qa1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIVWnHwx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29c23f53eabso1549045a91.0;
        Tue, 12 Mar 2024 15:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710283373; x=1710888173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GW5vj3ww6Q8f0lmgbHjuCxUYGiTO32XJbsJws7w3Yo4=;
        b=TIVWnHwx2/uuaE5pqmD2H4Zq4GtrGGAv9o1jEyq+jWiz695Tdfqjb3hNuw+6L5VESc
         h6q5O0Ws3FdBatlX/jJZrYnUUs6g0s5swQbVyEfTmhNV0r7oPyDf76PYJNZMtlpG1jbp
         LszeYIwvCHrdvmgwTeDTG4Tml2/RcV9EH29XoPt1ZM9sk3oCZaBIe47JvW1YbEOLfFOl
         5qx+JDPk7OvptZh/ilhvSHCZXxFxzNvg12bPx0+pgi/8xdFl3AmuNPxpaa8YPFXq6lN0
         D+DraiunRv+7IQFpZRiwf8VtYJYSYhYSgs25BiiUtjb6DzKRANmgv/1jNlPnr1k4h9TM
         Q/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710283373; x=1710888173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GW5vj3ww6Q8f0lmgbHjuCxUYGiTO32XJbsJws7w3Yo4=;
        b=nv/uLKVqUryeMsdpKK/qxNzQ/caZFbHOaZ127BlHHA1Km5WIJS5ANmiwJbKTfL76Qz
         o4ekB8wDEGf5MRX6ouPpzhKUZ8rsQvRGmhrLjlOEd7P51hhVFiH+Y44QtdnDrc+g5Cd8
         TU/Na6NCedPs2M/66xbUiCU5z46/8Iq7bmnP03pyjDWkj0dPk2AVHgvilj/sFI/cyQQo
         mKVOcnSkrHxjwKLh0jqlyuJgRsNCXdf5PlfnpsZIz9NtE+uvcs2Tp9pUSBZwdkEW2O9G
         WjQhleJ9XxCqjmIqjLJ1duxioPr/XK+OqK+Va5yrrvppekvQxBfJJwZu04GNzZ1gTnQ8
         t3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCV4wvqi1iXkoJxZPlfcCjf29srXTWVoWgDjvZyVRCUUuk48s5q+iAn9710d0gQ6kq6fYuOIv7Fyo4aiHHpi87ALLBN4dm7wXVMxYDqB26NlADT47nLZzf/+a1eqfVbvtcPj
X-Gm-Message-State: AOJu0Yw9zujFMc+g9lbeSQLCWICORsGFXZmOHrWZpGhGvWyoxKV3fAhF
	Ycl+enBoE8UMgf9afSblOMBwFiKmQ840trmzHjkb+PtyhASOylsDC+WusrbmpmghzXtuSnlA2SM
	z2CdMHXNus7UwXBgrfNxAJnzWriI=
X-Google-Smtp-Source: AGHT+IG05AQ8p9LY6kKsQm6GaiTqTBxg+G+H6czkTltA1tGWZzBAoHsJAVkP01GQzO3Mbk3NNcALJkAVyzlg4Vsn3w0=
X-Received: by 2002:a17:90a:bb8a:b0:29b:a793:e3cb with SMTP id
 v10-20020a17090abb8a00b0029ba793e3cbmr8207504pjr.22.1710283373514; Tue, 12
 Mar 2024 15:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310154726.734289-1-andrea.righi@canonical.com>
 <CAEf4BzYrwRQu1eNMACfXtsac+=psnNGr+=WQz3zUPP+2DPA2Rg@mail.gmail.com> <Ze9ou-OrYO8NZsDb@gpd>
In-Reply-To: <Ze9ou-OrYO8NZsDb@gpd>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Mar 2024 15:42:41 -0700
Message-ID: <CAEf4Bzb6eA5Sz3hKCVKPZjGzCE1v5aGhieR4rOD_appnNDmBqw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: ringbuf: allow to partially consume items
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 1:25=E2=80=AFPM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
>
> On Mon, Mar 11, 2024 at 10:55:57AM -0700, Andrii Nakryiko wrote:
> > On Sun, Mar 10, 2024 at 8:47=E2=80=AFAM Andrea Righi <andrea.righi@cano=
nical.com> wrote:
> > >
> > > Instead of always consuming all items from a ring buffer in a greedy
> > > way, allow to stop when the callback returns a value > 0.
> > >
> > > This allows to distinguish between an error condition and an intentio=
nal
> > > stop condition by returning a non-negative non-zero value from the ri=
ng
> > > buffer callback.
> > >
> > > This can be useful, for example, to consume just a single item from t=
he
> > > ring buffer.
> > >
> > > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > > ---
> > >  tools/lib/bpf/ringbuf.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > > index aacb64278a01..dd8908eb3204 100644
> > > --- a/tools/lib/bpf/ringbuf.c
> > > +++ b/tools/lib/bpf/ringbuf.c
> > > @@ -265,6 +265,14 @@ static int64_t ringbuf_process_ring(struct ring =
*r)
> > >                                         return err;
> > >                                 }
> > >                                 cnt++;
> > > +                               if (err > 0) {
> >
> > So libbpf already stops at any err < 0 (and sets correct consumer
> > pos). So you could already get desired behavior by just returning your
> > own error code. If you need count, you'd have to count it yourself
> > through custom context, that's a bit of inconvenience.
>
> Yep, that's exactly what I'm doing right now.
>
> To give more context, here's the code:
> https://github.com/sched-ext/scx/blob/b7c06b9ed9f72cad83c31e39e9c4e2cfd86=
83a55/rust/scx_rustland_core/src/bpf.rs#L217
>

cool, great that you at least have a work-around


> >
> > But on the other hand, currently if user callback returns anything > 0
> > they keep going and that return value is ignored. Your change will
> > break any such user pretty badly. So I'm a bit hesitant to do this.
>
> So, returning a value > 0 should have the same behavior as returning 0?

yes, that's what the contract is right now

> Why any user callback would return > 0 then?

this is not the code I can control and ringbuf API was like that for a
long time, which is why I'm saying I'm hesitant to make these changes

>
> >
> > Is there any reason you can't just return error code (libbpf doesn't
> > do anything with it, just passes it back, so it might as well be
> > `-cnt`, if you need that).
>
> Sure, I can keep using my special error code to stop. It won't be a
> problem for my particular use case.
>
> Actually, one thing that it would be nice to have is a way to consume up
> to a certain amount of items, let's say I need to copy multiple items
> from the ring buffer to a limited user buffer. But that would require a
> new API I guess, in order to pass the max counter... right?

Yes, definitely a new API, but that's not a big problem. Though I'm
wondering if ring_buffer__consume_one() would be a more flexible API,
where user would have more flexible control. Either way libbpf is
doing smp_store_release() after each consumed element, so I don't
think it will have any downsides in terms of performance.

So please consider contributing a patch for this new API.

>
> Thanks,
> -Andrea
>
> >
> > pw-bot: cr
> >
> > > +                                       /* update consumer pos and re=
turn the
> > > +                                        * total amount of items cons=
umed.
> > > +                                        */
> > > +                                       smp_store_release(r->consumer=
_pos,
> > > +                                                         cons_pos);
> > > +                                       goto done;
> > > +                               }
> > >                         }
> > >
> > >                         smp_store_release(r->consumer_pos, cons_pos);
> > > --
> > > 2.43.0
> > >
> > >

