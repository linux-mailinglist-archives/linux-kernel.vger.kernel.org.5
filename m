Return-Path: <linux-kernel+bounces-153816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA8C8AD3AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76A92827C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C37154432;
	Mon, 22 Apr 2024 18:11:33 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E294153BC6;
	Mon, 22 Apr 2024 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713809493; cv=none; b=mhOgnqdRKz1+B+l9tGRigCFbkwZwmBwRlm77mvWHnf2P3idsk+p2Ot3PZliU16+mDvOogToBQcE2o+9xkPNjONahTAXIOUJkSYLq+bZtBfVRkvh6vO28PwNLMWUADMCdljsI+SAr3FbYo4/wbLbqPRJhiBes6Igi0oNIqPeGGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713809493; c=relaxed/simple;
	bh=RXQBNIZD8UE4HL2t+pBxUCcQnfwkILmQO4gohG+Wb/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJbbZpvRJsTUlnlwsoro7ye3PlvEuvptaDSc6tGrvFjJa41vdQT7kyaVyhfEm0EDe3Z4EzYkgV3BKoaoiJHz+KOOiMEpeqF/6xFYWQV3jpPHi16fovQNbvh/RJ9Q77FgYi2pFeQ669w4NHjHZpRMaWHytiCSjhGWpJ/KuepRoS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61b2218ab6fso32590607b3.1;
        Mon, 22 Apr 2024 11:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713809489; x=1714414289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIYJICZAHp3tuVglFyrlAugeozSb8a+qq+gPa6pnnj4=;
        b=QtQMDDHandWJM1GtyfaZCmEollQ+H0A4dhT/vpLqttGUu1N+v50yBd7tOPTA5Rk7Rb
         LZMcaRk7m+FbkwrbyFS3i7eiKAMiwTAd+krsrTmNerwIaL9Ja+ZAVZiowKflw5wwChr9
         LgeuMox5tuQlmo7zsgEkGMrBD0GHDx5C8F1xb5ysneHF7pZwTPpRAl/Z64AD+W4voTTk
         zc372Zo6kU1HZbPrjMHcVJBveC/3Ez/THeDJeaH/taeO/wmJmgstSYzlUT4p71H9S7Px
         k9YpqLk1GzjLi30aHPB2XfYSW2Rr6cAPCGvwFQpelGUamnFvkCrz39+0dU1DhmawnIFA
         /yBw==
X-Forwarded-Encrypted: i=1; AJvYcCWjDr2IXbY4FJXCzxHRH8D/0W4B4GHdmyWKP8PNsUa0pu5D52jly60vcc5Se95yDTaVXyKNzPdAil5wxGkCgwnr6KxcTIuMYRv+kR/4RNbrNk4sbMZQ8KH1iD7hnhYmJjPfEz4zNexyWB+tF5143NOYWMo97kBzJMHgs08JCzbMHsyfKarVc2bEW6biDT8=
X-Gm-Message-State: AOJu0Yy+GkdwQTeyXyfyA+PWSnoFmp5SUCZKWMRXlTWJylBRdUCBAzPf
	K1I/3pM+vfVTt3c3rGnYOtafyIbcuyKP5yOmGuFhe270A5JIaagOMorf5sQb
X-Google-Smtp-Source: AGHT+IH0OXsyCvpf/sQVdi00yQB229Paq5Wr22BDwJDutgiTXY9/fi5D/dAIBkcVivaGzef2qK+MUg==
X-Received: by 2002:a05:690c:6787:b0:61a:d454:fb3b with SMTP id ib7-20020a05690c678700b0061ad454fb3bmr10912027ywb.6.1713809489446;
        Mon, 22 Apr 2024 11:11:29 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id t21-20020a0dea15000000b0061abc6baadfsm2095913ywe.14.2024.04.22.11.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 11:11:29 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dbed0710c74so4178973276.1;
        Mon, 22 Apr 2024 11:11:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdu9YyeJDuwYGWOqfWRYerpbDDwIymCs3Sgn80DiR0R/1NYgCvq0fLq0yvJgCPeuKcm+hz8hHwlWGohueBUYAl2yLpH90T8JLfg8lc3I6cNM4ppEVu5B1ubd9MeRmGfPET0mBjJAsM5Y79YqQwwMabQ4n1TQK0Ot9T4kYT7sqfPjRV9gPorzq9ZYdyd5A=
X-Received: by 2002:a25:d655:0:b0:dcc:58ed:6ecc with SMTP id
 n82-20020a25d655000000b00dcc58ed6eccmr10979493ybg.41.1713809488807; Mon, 22
 Apr 2024 11:11:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713780345.git.geert+renesas@glider.be> <87il09ty4u.fsf@intel.com>
 <ff4f9e8f-0825-4421-adf9-e3914b108da7@app.fastmail.com> <875xw9ttl6.fsf@intel.com>
 <af6e26d1-1402-4ed2-a650-b58eae77273e@app.fastmail.com> <87wmops57s.fsf@intel.com>
In-Reply-To: <87wmops57s.fsf@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Apr 2024 20:11:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWU5R-C-sKs1GsF9Jt9giRD_moUs=1jvXastBwhWRYMJg@mail.gmail.com>
Message-ID: <CAMuHMdWU5R-C-sKs1GsF9Jt9giRD_moUs=1jvXastBwhWRYMJg@mail.gmail.com>
Subject: Re: [PATCH 00/11] drm: Restore helper usability
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jani,

CC kbuild

On Mon, Apr 22, 2024 at 7:00=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
> On Mon, 22 Apr 2024, "Arnd Bergmann" <arnd@arndb.de> wrote:
> > I'm not sure where this misunderstanding comes from, as you
> > seem to be repeating the same incorrect assumption about
> > how select works that Maxime wrote in his changelog. To clarify,
> > this works exactly as one would expect:
> >
> > config HELPER_A
> >        tristate
> >
> > config HELPER_B
> >        tristate
> >        select HELPER_A
> >
> > config DRIVER
> >        tristate "Turn on the driver and the helpers it uses"
> >        select HELPER_B # this recursively selects HELPER_A
> >
> > Whereas this one is broken:
> >
> > config FEATURE_A
> >        tristate "user visible if I2C is enabled"
> >        depends on I2C
> >
> > config HELPER_B
> >        tristate # hidden
> >        select FEATURE_A
> >
> > config DRIVER
> >        tristate "This driver is broken if I2C is disabled"
> >        select HELPER_B
>
> This case is really what I was referring to, although I was sloppy with
> words there. I understand that select does work recursively for selects.
>
> >>   There is no end to this, it just goes on and on, as the
> >>   dependencies of the selected symbols change over time. Often the
> >>   selects require unintuitive if patterns that are about the
> >>   implementation details of the symbol being selected.
> >
> > Agreed, that is the problem I frequently face with drivers/gpu/drm,
> > and most of the time it can only be solved by rewriting the whole
> > system to not select user-visible symbol at all.
> >
> > Using 'depends on' by itself is unfortunately not enough to
> > avoid /all/ the problems. See e.g. today's failure
> >
> > config DRM_DISPLAY_HELPER
> >        tristate "DRM Display Helpers"
> >        default y
> >
> > config DRM_DISPLAY_DP_HELPER
> >        bool "DRM DisplayPort Helpers"
> >        depends on DRM_DISPLAY_HELPER
> >
> > config DRM_PANEL_LG_SW43408
> >        tristate "LG SW43408 panel"
> >        depends on DRM_DISPLAY_DP_HELPER
> >
> > This version is still broken for DRM_DISPLAY_HELPER=3Dm,
> > DRM_DISPLAY_DP_HELPER=3Dm, DRM_PANEL_LG_SW43408=3Dy because
> > the dependency on the bool symbol is not enough to
> > ensure that DRM_DISPLAY_HELPER is also built-in, so you
> > still need explicit dependencies on both
> > DRM_DISPLAY_HELPER and DRM_DISPLAY_DP_HELPER in the users.
> >
> > This can be solved by making DRM_DISPLAY_DP_HELPER a
> > tristate symbol and adjusting the #ifdef checks and
> > Makefile logic accordingly, which is exactly what you'd
> > need to do to make it work with 'select' as well.
>
> So bool is kind of problematic for depends on and select even when it's
> not really used for describing builtin vs. no, but rather yes vs. no?

Yes, the underlying issue is that bool is used for two different things:
  A. To enable a driver module that can be only built-in,
  B. To enable an option or feature of a driver or subsystem.

Without this distinction, dependencies cannot be auto-propagated 100%
correctly.  Fixing that would require introducing a third type (and possibl=
y
renaming the existing ones to end up with 3 good names).

Actually two types could work:
  1. driver,
  2. option,
as case A is just a driver that can only be built-in (i.e. "depends on y",
which is similar to the behavior with CONFIG_MODULES=3Dn).

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

