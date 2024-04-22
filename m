Return-Path: <linux-kernel+bounces-153814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0168AD3A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E111C20B46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79C8154429;
	Mon, 22 Apr 2024 18:02:32 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BFB1509AB;
	Mon, 22 Apr 2024 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808952; cv=none; b=ZGy6YPcQHzm5ivrhHYTrW9q2v6Hkz1sV5r8EIP0pghnDMUDCIdfNiIip2WWLf7AIclJsbGCAkspnnZlln2MwU2Q5FYc7dbkU31k0+guSzL66dKYXTyXelaUZuG9HHIjPpG0qwmcVCN80xQZ6+ikTqUMj5k0hChbFZgWbNs/PdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808952; c=relaxed/simple;
	bh=2+RQ652HU2UwexwX83Sky53pkNtRZSpJtK+AlPVwoBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8klteKy3J7YFm96j4e28PWgphx38Aozrlo5Uq9xG1ikDTBbiHKhVfSkGACkeyEeuG8s2cNfISHslRKrvVPc9F707sPUZBPu2eki7lSmTD639vLZKMrR/kujwr2EY2HH8D6PUE1DTj6NXZLhu0+Sk0x/uek1xlBAEoUlq0ae3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ad2a15374eso1715435eaf.3;
        Mon, 22 Apr 2024 11:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713808947; x=1714413747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIzcre4L/EBUlEtvCuRrxfW3XnVYCAdmaiVZhZRHwg0=;
        b=fKADZKW2kLnvYQbgM85uJEaragZ4NbSM4qV3TNkO41nKYcdTwXSvpGzsiJHGfpMB/x
         fOGZwQ00QXcNKfrxXxYrWgmywxS/kfKad0Mow1z5h7xGoYL5E8ReRGrHLzn62Hl/rCdq
         lcPytCgVKxlE/wmWQyKC/QCKj1My1fVx4HUsilgdDkDiZZGoCvGEkAJUGqm1E9pPe46x
         BrLQ08IIBsalgn5LJKpXnpOWdNcl6maFyqytSz4OP8vMhrfFym5vzkjASn3Gtxo8r4JK
         GxFm2Q8iDQjPK3977AYld1MdaBRLXJCY+LXg65oDSuv/LnG3vgtUewmJZEGQjbcm6lxQ
         9mDQ==
X-Forwarded-Encrypted: i=1; AJvYcCURMNUc5f/A6UdpEBjYdHKLTYbR72iq26lV8/f4BuxiV9K3aX/9a2hhK2KIhRa8jl9+gmoSZuraJ4A0C8RVYFQNgXXaiRRVsl3I0y8kjP9coBTPg41PR1Skv+xUDXRyP6E7XmEljC/4u6Q7/6k4wBe0/c0Miz8JKhbZHdoQrYkdxggWmJ/l5G5N0u+vhpU=
X-Gm-Message-State: AOJu0YxgG9bcyS5ePMpluLAfGneX2WoML68CuO0yeWP+Ig/TNOjK3g5b
	5aYKo4YZHz49psI3KmGzv7TDuurUqczSq5EIPYYDw9ambv+eaqlN0btZjK7P
X-Google-Smtp-Source: AGHT+IEh1Dlo4g8PiTAuWzYEPyzhmuf6UUUQKXr9MHlggzV1Tifiexe1oRXfjTldlok3TU9YqNM1Jg==
X-Received: by 2002:a05:6358:5d8b:b0:186:b6ac:8ce2 with SMTP id s11-20020a0563585d8b00b00186b6ac8ce2mr16129317rwm.6.1713808947263;
        Mon, 22 Apr 2024 11:02:27 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id z13-20020a81d40d000000b0061b0c844dd9sm2044949ywi.5.2024.04.22.11.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 11:02:26 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc742543119so4662652276.0;
        Mon, 22 Apr 2024 11:02:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXW3itUIMAPruC23ltckGm0sHbQsn9pIIVQsFs8YZIVJP+crPONdveqXWkLEmNUvhcwzi0vwg246gCijEwufC6nBlYzaxlt6KLMZhgmmuJNKWaI3qK7r4e//Qv011z46xmKsHg+p+kjb9RUhChKD6Z32Nr5nvN4x6iB79SXgTLOngWqXP7Jmb8GU2sv4lU=
X-Received: by 2002:a25:fc08:0:b0:de4:6efa:debd with SMTP id
 v8-20020a25fc08000000b00de46efadebdmr9818662ybd.29.1713808946217; Mon, 22 Apr
 2024 11:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713780345.git.geert+renesas@glider.be> <87il09ty4u.fsf@intel.com>
 <ff4f9e8f-0825-4421-adf9-e3914b108da7@app.fastmail.com> <875xw9ttl6.fsf@intel.com>
 <af6e26d1-1402-4ed2-a650-b58eae77273e@app.fastmail.com> <CAMuHMdXCL-gbKr6mUBPWONtRjz=X0vZQgiS=02WXXSFf67yBww@mail.gmail.com>
 <87ttjts4j6.fsf@intel.com>
In-Reply-To: <87ttjts4j6.fsf@intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Apr 2024 20:02:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWb5sqhk1m4kD_72k0OzB5MTEFcP+QHFo+4rs8j8WEzPQ@mail.gmail.com>
Message-ID: <CAMuHMdWb5sqhk1m4kD_72k0OzB5MTEFcP+QHFo+4rs8j8WEzPQ@mail.gmail.com>
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

On Mon, Apr 22, 2024 at 7:15=E2=80=AFPM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
> On Mon, 22 Apr 2024, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, Apr 22, 2024 at 3:55=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> I'm not sure where this misunderstanding comes from, as you
> >> seem to be repeating the same incorrect assumption about
> >> how select works that Maxime wrote in his changelog. To clarify,
> >> this works exactly as one would expect:
> >>
> >> config HELPER_A
> >>        tristate
> >>
> >> config HELPER_B
> >>        tristate
> >>        select HELPER_A
> >>
> >> config DRIVER
> >>        tristate "Turn on the driver and the helpers it uses"
> >>        select HELPER_B # this recursively selects HELPER_A
> >>
> >> Whereas this one is broken:
> >>
> >> config FEATURE_A
> >>        tristate "user visible if I2C is enabled"
> >>        depends on I2C
> >>
> >> config HELPER_B
> >>        tristate # hidden
> >>        select FEATURE_A
> >>
> >> config DRIVER
> >>        tristate "This driver is broken if I2C is disabled"
> >>        select HELPER_B
> >
> > So the DRIVER section should gain a "depends on I2C" statement.
>
> Why should DRIVER have to care that HELPER_B needs either FEATURE_A or
> I2C? It should only have to care about HELPER_B. And if the dependencies
> of FEATURE_A or HELPER_B later change, that's their business, not
> DRIVER's.

That's correct. But currently the dependency on I2C is not handled
automatically.

> > Yamada-san: would it be difficult to modify Kconfig to ignore symbols
> > like DRIVER that select other symbols with unmet dependencies?
> > Currently it already warns about that.
> >
> > Handling this implicitly (instead of the current explict "depends
> > on") would have the disadvantage though: a user who is not aware of
> > the implicit dependency may wonder why DRIVER is invisible in his
> > config interface.

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

