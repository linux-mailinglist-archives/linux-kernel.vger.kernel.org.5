Return-Path: <linux-kernel+bounces-28996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D09830654
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF979B23E15
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005B71EB2C;
	Wed, 17 Jan 2024 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvwSVVoO"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0229D1EB20
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496291; cv=none; b=E/77LiQln/uQI3IucbTPGRPDUy3fb+h5i9qAkaGrpa86a6J14jip4G6mzEOF6LLaJUf/d9XWHFSmwodigWTI3njKCA0XctdtEB+Sq4Jq8DOeQK4l/W/PM3Gaa0CFech2mfRMHrIptVIHH4vRioJxgAHA1OzWqFgURf7X89ol/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496291; c=relaxed/simple;
	bh=i2xvyRbmK5Vp/na9cD6pB90nPCPpBPuqpwioWwE21Ms=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=JF3+q6Mb9aUzxOgI0hporGLwe3Zuz2U96d8VUBJwsB62/tSf4DNejYI/n6uYGHI6QRfENMrxjndxNNF4DWRSvusgpaxnO6RSFmTP/2h0oM+s3UxlyXbg2N5GIRKRjTblFPP6Ki9lSVt7GAyakCmYUTYcKan0LBovoP9YYj61Uf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvwSVVoO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a29058bb2ceso1165138566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 04:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705496287; x=1706101087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nr6b38K/e8nUhb4OELnPFxstw2rjVez94AhNtOwXaI0=;
        b=NvwSVVoOF/5jPto9izAoB/I4XHVfJmtRwjONmn6w3f+vOvwyzIYPl8RXBnhvOLYsWV
         U+CuHV4t62287BTZvj7Ga0HAGusC417Guor2SmIKQp0IH9CnSdQy8M/m4/hQ34oNKsfo
         8nHpD5BoH1xjVe3pMn6VTaaXnW3sLy6gsUcgNAzdn1VleqPtPenypIwNHeZLHAuHPVtA
         CzPW2AxMAg09X/ERImsJJZfIMg+uqrMDIy8Y77zkuK2Rk8pU12XZ3HzFeQKNpyh9HXXA
         3kO3iC6ARn50D/irGaj6kWHD1/B7bRtA7Ryv2KTAKp27mtl+yWpjHGd+lJy/B50Poefa
         kpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705496287; x=1706101087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nr6b38K/e8nUhb4OELnPFxstw2rjVez94AhNtOwXaI0=;
        b=Y/wYbVvCWduG0Hxh7WZtDZkyjc2a18pTcjYZqJMSoIokI9jAfrPvZxT9YVXCisKI7a
         xQQIzSZrnKKakDOS2a1ZtDj0MtWOZkrEhXipCM6V6RPsy58zYpEgyo+ziiRm1Fwnz6yk
         w/7KZK6txUBZNL+d3O8r4ZNmDVhoKm3tvZC9mp3s7yajggNDNI65NOoC2EGOIoELy2lG
         NEs6fB6Wqx9lLpVKhYHPc5joOzvyc32+TSs8VMLaryHYxfzFelhTqruhvc7aMUfdKOhl
         MSTTFa0wCnMjCmf0WPBhEyS/fHFJXX/cnEP3VZPJ3jll3AfGC15vpNFOwhZLuEDzrRLc
         Ww9A==
X-Gm-Message-State: AOJu0Ywy3XyPvBIBegjjvOf3SAm2KuZEKa/3kKaawyhiIIPi8ha95Q+/
	Ol4KO52Kn2H/y6kXAJvY6CBAr3zcI82nItlzAv0=
X-Google-Smtp-Source: AGHT+IE1t1Pynz8dhhbawghsygV1PDRYd1YH80PNklfYhmvmA5G26IjcQ3zT0+tHjkGxUVuFhPhYRyu78S8j/DnsfP8=
X-Received: by 2002:a17:907:76eb:b0:a2e:d3c6:b1f1 with SMTP id
 kg11-20020a17090776eb00b00a2ed3c6b1f1mr268098ejc.144.1705496286880; Wed, 17
 Jan 2024 04:58:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116045159.1015510-1-andrealmeid@igalia.com>
 <20240116114522.5b83d8b6@eldfell> <a6099681-1ae9-48ef-99bc-d3c919007413@igalia.com>
 <20240116151414.10b831e6@eldfell> <47c6866a-34d6-48b1-a977-d21c48d991dc@igalia.com>
 <CAFZQkGyOQ5Tfu++-cHqgZ9NOJxqxm8cAF5XT18LmisuPAUbXAg@mail.gmail.com> <20240117105509.1984837f@eldfell>
In-Reply-To: <20240117105509.1984837f@eldfell>
From: Xaver Hugl <xaver.hugl@gmail.com>
Date: Wed, 17 Jan 2024 13:57:55 +0100
Message-ID: <CAFZQkGzite-CZoJcV80kNPe==OWFZa_cR1x3QRKuLd=HdOFw-A@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/atomic: Allow drivers to write their own plane
 check for async
To: Pekka Paalanen <ppaalanen@gmail.com>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, 
	Simon Ser <contact@emersion.fr>, daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>, 
	=?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
	Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, 
	Joshua Ashton <joshua@froggi.es>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mi., 17. Jan. 2024 um 09:55 Uhr schrieb Pekka Paalanen <ppaalanen@gmail.=
com>:
> Is it important enough to be special-cased, e.g. to be always allowed
> with async commits?

I thought so, and sent a patch to dri-devel to make it happen, but
there are some
concerns about untested driver paths.
https://lists.freedesktop.org/archives/dri-devel/2024-January/437511.html

> Now that I think of it, if userspace needs to wait for the in-fence
> itself before kicking KMS async, that would defeat much of the async's
> point, right? And cases where in-fence is not necessary are so rare
> they might not even exist?
>
> So if driver/hardware cannot do IN_FENCE_FD with async, is there any
> use of supporting async to begin with?

KWin never commits a buffer where IN_FENCE_FD would actually delay the
pageflip; it's really only used to disable implicit sync, as there's some e=
dge
cases where it can wrongly delay the pageflip. The waiting for buffers to b=
ecome
readable on the compositor side isn't really significant in terms of latenc=
y.

If hardware doesn't support IN_FENCE_FD with async commits, checking if the
fence is already signaled at commit time would thus still make things work,=
 at
least for KWin.

> > If the compositor prioritizes tearing and would like to do overlay plan=
es
> > if possible,
> > it would have to know that switching to synchronous commits for a singl=
e
> > frame,
> > setting up the overlay planes and then switching back to async commits
> > works, and
> > that can't be figured out with TEST_ONLY commits.
>
> I had to ponder a bit why. So I guess the synchronous commit in between
> is because driver/hardware may not be able to enable/disable extra
> planes in async, so you need a synchronous commit to set them up, but
> afterwards updates can tear.

The hardware could be a factor, yes, but I've been thinking more about the =
API.
With this patchset, the compositor is still only allowed to change a
limited set of
plane properties - but it needs to set at least SRC_X, SRC_Y, CRTC_X etc on
the overlay plane(s) to the correct values before it can only change the al=
lowed
properties again.

> The comment about Intel needing one more synchronous commit when
> switching from sync to async updates comes to mind as well, would that
> be a problem?

With only one synchronous update, the compositor could theoretically mask t=
he
issue by committing it right before vblank; with that one
implicitly-sync "async"
commit though, you'd definitely get one frame without async commits. Having=
 a
flag for a sync-but-then-async-again commit could solve that issue.

In practice I don't think anyone will notice one or two frames without
async commits.
It should be a pretty rare occurance, usually when the game or match
starts or an
overlay gets opened, so I doubt it's worth putting effort in to fix that.

> > So I think having a CAP or immutable plane property to signal that asyn=
c
> > commits
> > with overlay and/or cursor planes is supported would be useful.
>
> Async cursor planes a good point, particularly moving them around. I'm
> not too informed about the prior/on-going efforts to allow cursor
> movement more often than refresh rate, I recall something about
> amending atomic commits? How would these interact?
>
> I suppose the kernel still prevents any new async commit while a
> previous commit is not finished, so amending commits would still be
> necessary for cursor plane motion? Or would it, if you time "big
> commits" to finish quickly and then spam async "cursor commits" in the
> mean time?

With async commits for cursor planes I'm really only talking about
getting to use
the cursor plane while doing async commits on the primary plane.

FWIW I personally consider the amend stuff mostly solved - KWin does that
internally since a few months ago now, with a separate thread to amend and
even reorder commits in a queue, and only actually commit immediately
before vblank.

>
> Thanks,
> pq
>
> > Am Di., 16. Jan. 2024 um 14:35 Uhr schrieb Andr=C3=A9 Almeida <
> > andrealmeid@igalia.com>:
> >
> > > + Joshua
> > >
> > > Em 16/01/2024 10:14, Pekka Paalanen escreveu:
> > > > On Tue, 16 Jan 2024 08:50:59 -0300
> > > > Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> > > >
> > > >> Hi Pekka,
> > > >>
> > > >> Em 16/01/2024 06:45, Pekka Paalanen escreveu:
> > > >>> On Tue, 16 Jan 2024 01:51:57 -0300
> > > >>> Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> > > >>>
> > > >>>> Hi,
> > > >>>>
> > > >>>> AMD hardware can do more on the async flip path than just the pr=
imary
> > > plane, so
> > > >>>> to lift up the current restrictions, this patchset allows driver=
s to
> > > write their
> > > >>>> own check for planes for async flips.
> > > >>>
> > > >>> Hi,
> > > >>>
> > > >>> what's the userspace story for this, how could userspace know it =
could
> > > do more?
> > > >>> What kind of userspace would take advantage of this and in what
> > > situations?
> > > >>>
> > > >>> Or is this not meant for generic userspace?
> > > >>
> > > >> Sorry, I forgot to document this. So the idea is that userspace wi=
ll
> > > >> query what they can do here with DRM_MODE_ATOMIC_TEST_ONLY calls,
> > > >> instead of having capabilities for each prop.
> > > >
> > > > That's the theory, but do you have a practical example?
> > > >
> > > > What other planes and props would one want change in some specific =
use
> > > > case?
> > > >
> > > > Is it just "all or nothing", or would there be room to choose and p=
ick
> > > > which props you change and which you don't based on what the driver
> > > > supports? If the latter, then relying on TEST_ONLY might be yet ano=
ther
> > > > combinatorial explosion to iterate through.
> > > >
> > >
> > > That's a good question, maybe Simon, Xaver or Joshua can share how th=
ey
> > > were planning to use this on Gamescope or Kwin.
> > >
> > > >
> > > > Thanks,
> > > > pq
> > > >
> > > >>>> I'm not sure if adding something new to drm_plane_funcs is the r=
ight
> > > way to do,
> > > >>>> because if we want to expand the other object types (crtc, conne=
ctor)
> > > we would
> > > >>>> need to add their own drm_XXX_funcs, so feedbacks are welcome!
> > > >>>>
> > > >>>>    Andr=C3=A9
> > > >>>>
> > > >>>> Andr=C3=A9 Almeida (2):
> > > >>>>     drm/atomic: Allow drivers to write their own plane check for=
 async
> > > >>>>       flips
> > > >>>>     drm/amdgpu: Implement check_async_props for planes
> > > >>>>
> > > >>>>    .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 30 +++++++++
> > > >>>>    drivers/gpu/drm/drm_atomic_uapi.c             | 62
> > > ++++++++++++++-----
> > > >>>>    include/drm/drm_atomic_uapi.h                 | 12 ++++
> > > >>>>    include/drm/drm_plane.h                       |  5 ++
> > > >>>>    4 files changed, 92 insertions(+), 17 deletions(-)
> > > >>>>
> > > >>>
> > > >
> > >
>

