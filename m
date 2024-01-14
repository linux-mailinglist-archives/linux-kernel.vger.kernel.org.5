Return-Path: <linux-kernel+bounces-25536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A27382D206
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 21:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FC52B21186
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 20:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E37168B1;
	Sun, 14 Jan 2024 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhqkIyud"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053B168A4
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so953341866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 12:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705262418; x=1705867218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKAoT//lfLk6SjlnkLN+BWJ10tifSyl6cjyoqrMbL/c=;
        b=bhqkIyudlMR/O3YDjgsb9aNWAAPSxFNn4aCFAvYDgPSZCbMaRVRn48Xt8tHnVBcLqz
         69NBCGWJWtCmqRh5aZTj2b/vzS5yhq+tj9AHCPW0ucr5FxkqeNsj2PtfSQnZnjZUwDgb
         5Q0TNpP7wmjIaX9AU0lLR3UWX7FvrQWVLNyi5BOL1ch2WHRbABxL4MpeI6OzZ57A6plh
         igrUrJNwfgYFBkvEWfr5UChnyqJIKUN7lkhEdNNK3j36sEKoyP1MpZLX0lrFyKSyHjzZ
         Zi7N0xlorKCNmt2INqPG10bnsS0dmwQL7g1ntH3frC9RmljZtqpQVJsAlUBrk0VWUBT0
         Rc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705262418; x=1705867218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKAoT//lfLk6SjlnkLN+BWJ10tifSyl6cjyoqrMbL/c=;
        b=XnOKhBnjZWXSr325yDW/tVD0Y2vzZqzXXbzUjbIXsTXblMOpXUKWH/LLRmh3KAWoRE
         pex5sVX7y+SiWyx46alOe2jqoZQkxlud6GXlh85vIp+9OkYZpTgMdfnt222yP2VDeNEF
         rCghR27dIbTjXIvZirtDW56d0VLv7Ecth2b9C6Qtr09XLBV80eJ+6y4xnAYST7d1VCad
         NXC+TDTNXPNe6T7FZqSitxkpHkNM+4l9Vkh7oUKRgmxVOLB7bc/6rynEWPDoRtybmpeM
         5lVD07vLWcegW+R6GEt0O6SpLXRSsnn16BRiHKliOsLbRWU2E4atgyiqxw3b/vY/c00D
         EuGQ==
X-Gm-Message-State: AOJu0Yz8W4c4IHMZaCtCgdr7e+N2oCmvHvoFBqeKcG/lrSr69S1KVa/F
	pgxHSyP0G68xG32PTML+s+BsxIQUH3SksPGF9wxjsrkMY2w=
X-Google-Smtp-Source: AGHT+IGUFy51ZiCUav7y8oFEaLpmISNk60Bt7V0vlMlr6NzmGrJ6jtiWFv5aOUvA6iXLpt8BdYhtm5WZ8aG39PxFf8Q=
X-Received: by 2002:a17:906:ee8d:b0:a2a:ef4e:e352 with SMTP id
 wt13-20020a170906ee8d00b00a2aef4ee352mr1740238ejb.108.1705262417480; Sun, 14
 Jan 2024 12:00:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9twKBmO2Svky-zeP+KS8qWHFj9zrgeBqW9y__tUwcAYZhw@mail.gmail.com>
 <CAHk-=wgPJttFz8yrdpPTN-ypMmDXHOKw9yi1nZSEq+7+tGftZA@mail.gmail.com>
In-Reply-To: <CAHk-=wgPJttFz8yrdpPTN-ypMmDXHOKw9yi1nZSEq+7+tGftZA@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 15 Jan 2024 06:00:05 +1000
Message-ID: <CAPM=9tyiH_+jMZT9hYWaQN8=nByZvJd-0bkv6sRxAsWJm_eZGQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jan 2024 at 05:33, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 10 Jan 2024 at 11:49, Dave Airlie <airlied@gmail.com> wrote:
> >
> > Let me know if there are any issues,
>
> Your testing is seriously lacking.
>
> This doesn't even build. The reason seems to be that commit
> b49e894c3fd8 ("drm/i915: Replace custom intel runtime_pm tracker with
> ref_tracker library") changed the 'intel_wakeref_t' type from a
> 'depot_stack_handle_t' to 'unsigned long', and as a result did this:
>
> -       drm_dbg(&i915->drm, "async_put_wakeref %u\n",
> +       drm_dbg(&i915->drm, "async_put_wakeref %lu\n",
>                 power_domains->async_put_wakeref);
>
> meanwhile, the Xe driver has this:
>
>   drivers/gpu/drm/xe/compat-i915-headers/intel_wakeref.h:
>         typedef bool intel_wakeref_t;
>
> which has never been valid, but now the build fails with

This was a bad cross of trees, the fix was in a pull request in my
inbox about an hour after I sent the PR, it just wasn't marked urgent
and it passes all my usual test builds.

It turns out there is a Kconfig bug without EXPERT that was masking
this in my builds, hope to get that fix in soon.


>
>   drivers/gpu/drm/i915/display/intel_display_power.c: In function
> =E2=80=98print_async_put_domains_state=E2=80=99:
>   drivers/gpu/drm/i915/display/intel_display_power.c:408:29: error:
> format =E2=80=98%lu=E2=80=99 expects argument of type =E2=80=98long unsig=
ned int=E2=80=99, but
> argument 5 has type =E2=80=98int=E2=80=99 [-Werror=3Dformat=3D]
>
> because the drm header files have this disgusting thing where a
> *header* file includes a *C* file:
>
>   In file included from ./include/drm/drm_mm.h:51,
>                  from drivers/gpu/drm/xe/xe_bo_types.h:11,
>                  from drivers/gpu/drm/xe/xe_bo.h:11,
>                  from
> ./drivers/gpu/drm/xe/compat-i915-headers/gem/i915_gem_object.h:11,
>                  from ./drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h=
:15,
>                  from drivers/gpu/drm/i915/display/intel_display_power.c:=
8:
>
> nasty.


>
> I made it build by fixing that broken Xe compat header file, but this
> is definitely *NOT* how things should have worked. How did this ever
> get to me without any kind of build testing?
>
> And why the %^!@$% does a header file include a C file? That's wrong
> regardless of this bug.

Huh? display_power.c includes i915_drv.h includes i915_gem_object.h
include xe_bo.h include xe_bo_types.h include drm_mm.h?

I'm not seeing the c in h, you reading that backtrace correctly?

It was built test in a few scenarios by different people and in CI,
but it does appear the Kconfig screwup was masking people from seeing
the actual bug. We had a report a few days ago and a fix was posted,
just not marked as urgent and since I never saw the build fails here I
didn't escalate it.

Dave.

