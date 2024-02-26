Return-Path: <linux-kernel+bounces-81860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2DD867B11
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8764E28893E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D5A12C54F;
	Mon, 26 Feb 2024 16:03:27 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972A212BF0A;
	Mon, 26 Feb 2024 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963407; cv=none; b=qKPjX8NOnfqJke18nekd4qorLCr3RHfA019dMyiqLCjc354FWwqhEUhqtCqscOFrhpW+AzP9XD5SFt/RYubYOkb4B/bWnhrYlX3Dbu4TMf82C8Z50z3g+RC5iKfDnmiyD9Ygcl2QgOs5lwDNnYpfS8wWXeq+UMbCq+yAWzNmaUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963407; c=relaxed/simple;
	bh=S1V+ZeDUJ3nych3FpE8Rge25jKuMDzs391dNPPgMD0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oggBJjcJ9MQLXhi6+iyOLW44xZyBDVR0JlZlxc5h9NHGnfMI2W/86QUXk9NaW+2muuIAuWFvtLprVbV3mhjZaOIuvD/l+JX/wOh79W7BrMwGwYJIenEiP+DXrU8HIiLBrUzwY0fUPJRqDRmiV8GUUdDJv/B3WyOT653PZOKKf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-608342633b8so28432877b3.1;
        Mon, 26 Feb 2024 08:03:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708963403; x=1709568203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbbRWue6/X4hUbLyBcoTgh8XvAo+WfPpqZmsBKaAF3M=;
        b=kdOGuNVeyHfrBEUpaJjRsF0VmDgdshP/xhNGQyCMNGhT1+HW4Ehc9vBLQVUylIhns0
         xhkP01LSCvlZGoLcgxtGYnJiMBIegNiOAweQ3JXiE+ZFw1NFWAe9b3JUqbMdA9wy2Tun
         rhvuEozMTgkyq7ndV0XhTKyD6dibOrRLmsM1UqECoChQ8AU9akYH9oYpuQUR40T1WO+7
         OxcA66hBwEC01cZpgCtov/InH/lSAKZI8dKljImEGqigaduvex/BSLqMzWHsneFwzJvc
         7tzwOWCSyIe6gksSWDufUlv4evQ5OWMOe4AEHM1Ek2i68gbU6QzC1zH3vh7mO5md8Y4l
         bCcg==
X-Forwarded-Encrypted: i=1; AJvYcCW1yKPKcDanRHzIKlovBxf8qRrdMniJB0dfWX7ma5jM7mXJv7BFoFginMcrmrqp4sIRmopu2Yq37RER4atUXp702rUenAn+cUmwgFrTYQ/HPcICBn33g/bhSePYgZQrV72cM2M4AmfMjA==
X-Gm-Message-State: AOJu0YwIxpQRptV+E9yWbBC9DrZtmlfVqCc192HZHeYk+3n/d3RZgrw8
	0fOEPY7zADAUiJqZtJj86TOIVxRKxtEmg3g5M7GWsGquiGOURt+X1m4x9DJkrjU=
X-Google-Smtp-Source: AGHT+IFH9xZ7Eg4env3zzwmSsom0cTNcVJyMVBy9gFwiPhlk806Z07fR5VtISeGgQ9kh8cg+CF7FHQ==
X-Received: by 2002:a0d:e2ca:0:b0:607:838b:a0c0 with SMTP id l193-20020a0de2ca000000b00607838ba0c0mr7978212ywe.7.1708963403115;
        Mon, 26 Feb 2024 08:03:23 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id j189-20020a0df9c6000000b00604ae9cb29bsm1243125ywf.127.2024.02.26.08.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 08:03:22 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso3122984276.0;
        Mon, 26 Feb 2024 08:03:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXs3p2v3M1cJTc6I154OHy3jiYEVpfwh67+8fMhjfzpr8UqdSkJEoixOi6YKZXM+z3bMdTKgxOokeqwShyfkasQJph/LHyMv4YxNJ2B+dJa/RB11yqSi1BKE/VZ+cXCvR+wi0Rnx4BaQw==
X-Received: by 2002:a25:dbd1:0:b0:dcc:9e88:b15 with SMTP id
 g200-20020a25dbd1000000b00dcc9e880b15mr5207586ybf.41.1708963402512; Mon, 26
 Feb 2024 08:03:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219170337.2161754-1-andriy.shevchenko@linux.intel.com>
 <20240219170337.2161754-2-andriy.shevchenko@linux.intel.com>
 <CAMuHMdVv==58uen8nukLDB9ADCvJJFYTb2bZSAcFKQ0wUmqL9w@mail.gmail.com> <Zdy1icZvsr_NWt3O@smile.fi.intel.com>
In-Reply-To: <Zdy1icZvsr_NWt3O@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Feb 2024 17:03:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXDzKqTUHXE0JyKiAAqGtEoAE+cYQGboLCUzjpc52HCgg@mail.gmail.com>
Message-ID: <CAMuHMdXDzKqTUHXE0JyKiAAqGtEoAE+cYQGboLCUzjpc52HCgg@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] auxdisplay: linedisp: Group display drivers together
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Feb 26, 2024 at 5:00=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Feb 26, 2024 at 04:28:20PM +0100, Geert Uytterhoeven wrote:
> > On Mon, Feb 19, 2024 at 6:03=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > For better usability group the display drivers together in Kconfig
> > > and Makefile. With this we will have the following sections:
> > >   - Character LCD
> > >   - Samsung KS0108 LCD controller
> > >   - Single character line display
> > >   - Character LCD with non-conforming interface
>
> ...
>
> > > +config HT16K33
> > > +       tristate "Holtek Ht16K33 LED controller with keyscan"
> >
> > HT16K33 also supports dot-matrix displays using fbdev...
> > Yes, categorizing is difficult.
>
> So, what to do here?

Create a new section for multi-function displays?

>
> ...
>
> > I still think these should be sorted alphabetically.
>
> Okay.

Thanks!

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

