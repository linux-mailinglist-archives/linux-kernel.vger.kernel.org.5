Return-Path: <linux-kernel+bounces-22261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE0829B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47EF1C25C32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D975948CD8;
	Wed, 10 Jan 2024 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yngvason.is header.i=@yngvason.is header.b="ckg760GL"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B2F48CC1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yngvason.is
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5f2aab1c0c5so39127167b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yngvason.is; s=google; t=1704894180; x=1705498980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQ/U0Sa8v/CRYiVU6kq/by3KQsxjn5M1baHcHHM4a3M=;
        b=ckg760GLn6TVkMpbP+PCzZXevlkjDTa0V03VH026JRlN0tarCp3toLH9rfbGSn7WWt
         e7OSVDjbNgu0UvIx77zQxhn1bTMg1vAkXNbRsnkG+gSIiby3L5lvSy1+BhIzSAYUzU4c
         tj7aCz6wNBdeDADqj9zy+/eKi+Al3ihQFZJl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704894180; x=1705498980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQ/U0Sa8v/CRYiVU6kq/by3KQsxjn5M1baHcHHM4a3M=;
        b=MPtiJeVRH6wEk6+GMm9X9QKB5boe17qU/Yuyber5EqUMZvuVtDkQZIbzAiPbtDNGVR
         q4ZxXKQAn2TR3fngMuQGbP7n6My0ZWfxFT/b9ary+1WDCPXQZzNMnWMeVP2tz8NGm2bE
         o/rT6u2vuqaOu7g28l1M9HE9CpluznzL7U6PCiwu6aQmCVFUEKbVYqNuPAHWmsOIxbb9
         LejDJUjNJmJoXFWWNYi6UjoZTkq9IkXi/vwm/J6CqejdYXzKKK2iApfEC31O+APL+RGt
         oHN9d3sDzPPhgfS1/71PyjtlaO+S9MeqAT3E0P15sMW5NeQUmNkWpy65ot+d7hZo8tW1
         zPpA==
X-Gm-Message-State: AOJu0YwwOrzMlVs3x6BFdYrZgiWQDq0B+jb2r4YoO+rQXDZ5A0VE2vum
	BzT6KOYbsTSDtEtekpJ0Lpv/mADwXBeyvZFO8ugqt2OxqJvX7g==
X-Google-Smtp-Source: AGHT+IGDsuO4mYJVVDxBUOZbdTOdu8bmcbR4SC1ZuMtCkzl9DP9p6Vo22kYDPHUl7Rp57fzCruInRV3SA2OPXVlQoBk=
X-Received: by 2002:a0d:db57:0:b0:5e8:a75f:df63 with SMTP id
 d84-20020a0ddb57000000b005e8a75fdf63mr49273ywe.47.1704894180474; Wed, 10 Jan
 2024 05:43:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109181104.1670304-1-andri@yngvason.is> <20240109181104.1670304-6-andri@yngvason.is>
 <qdwv7sagqs5nmmsy5lko5hypldanfodafyzamrs3loj3n7jzlr@n5bacxkknkj4>
 <CAFNQBQzijyE4wR34AOLM45m+ryx128igVKO9zPJ5-M3afFQMxQ@mail.gmail.com> <92e20f9b-2cbf-4efe-b61b-989da0cc1668@tuxedocomputers.com>
In-Reply-To: <92e20f9b-2cbf-4efe-b61b-989da0cc1668@tuxedocomputers.com>
From: Andri Yngvason <andri@yngvason.is>
Date: Wed, 10 Jan 2024 13:42:24 +0000
Message-ID: <CAFNQBQxnMh4aPfm+U8vEfxoTdQ+FByfqwUUDnMTzgkrW2+ZZqw@mail.gmail.com>
Subject: Re: [PATCH 5/7] drm/uAPI: Add "preferred color format" drm property
 as setting for userspace
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Maxime Ripard <mripard@kernel.org>, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, Simon Ser <contact@emersion.fr>, 
	Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

mi=C3=B0., 10. jan. 2024 kl. 13:09 skrifa=C3=B0i Werner Sembach <wse@tuxedo=
computers.com>:
>
> Hi,
>
> Am 10.01.24 um 11:11 schrieb Andri Yngvason:
> > Hi,
> >
> > mi=C3=B0., 10. jan. 2024 kl. 09:27 skrifa=C3=B0i Maxime Ripard <mripard=
@kernel.org>:
> >> On Tue, Jan 09, 2024 at 06:11:02PM +0000, Andri Yngvason wrote:
> >>> From: Werner Sembach <wse@tuxedocomputers.com>
> >>>
> >>> Add a new general drm property "preferred color format" which can be =
used
> >>> by userspace to tell the graphic drivers to which color format to use=
.
> >>>
> >>> Possible options are:
> >>>      - auto (default/current behaviour)
> >>>      - rgb
> >>>      - ycbcr444
> >>>      - ycbcr422 (not supported by both amdgpu and i915)
> >>>      - ycbcr420
> >>>
> >>> In theory the auto option should choose the best available option for=
 the
> >>> current setup, but because of bad internal conversion some monitors l=
ook
> >>> better with rgb and some with ycbcr444.
> >> I looked at the patch and I couldn't find what is supposed to happen i=
f
> >> you set it to something else than auto, and the driver can't match tha=
t.
> >> Are we supposed to fallback to the "auto" behaviour, or are we suppose
> >> to reject the mode entirely?
> >>
> >> The combination with the active output format property suggests the
> >> former, but we should document it explicitly.
> > It is also my understanding that it should fall back to the "auto"
> > behaviour. I will add this to the documentation.
>
> Yes, that was the intention, and then userspace can check, but it wasn't =
well
> received: https://gitlab.freedesktop.org/drm/amd/-/issues/476#note_964530
>
> Actually a lot of the thoughts that went into the original patch set can =
be
> found in that topic.
>
> There was another iteration of the patch set that I never finished and se=
nt to
> the LKML because I got discouraged by this:
> https://lore.kernel.org/dri-devel/20210623102923.70877c1a@eldfell/

Well, I've implemented this for sway and wlroots now and Simon has
reacted positively, so this does appear likely to end up as a feature
in wlroots based compositors.

>
> I can try to dig it up, but it is completely untested and I don't think I=
 still
> have the respective TODO list anymore, so I don't know if it is a better =
or
> worst starting point than the last iteration I sent to the LKML.
>

You can send the patches to me if you want and I can see if they're
useful. I'm really only interested in the color format part though.
Alternatively, you can continue your work and post it to LKML and I
can focus on the userspace side and testing. By the way, I have an
HDMI analyzer that can tell me the actual color format.

Thanks,
Andri

