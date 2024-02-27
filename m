Return-Path: <linux-kernel+bounces-82846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 039DA868A80
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81841F235F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFC656461;
	Tue, 27 Feb 2024 08:09:37 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B9056442;
	Tue, 27 Feb 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021376; cv=none; b=tZscGh+Jlp9cUy5D2Ft/sYsI6SRemBZOgVEoCRETMsDzJGkr7ih9ZpTHepBv+etAiUQZ30Z3qHzQyKouN1xv5gZmUp1gkiQeojeMj4Q+VGDz7QOPWAhpmIRuDcFJycxR0JXMq6S1u1O3S4L7zZGCm5L5ck3nIlJBYb2mUIiIOJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021376; c=relaxed/simple;
	bh=Cd3nKfsn1CmK7TjQsqqae5bIuxcmc17vi4cKxuDwdXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eg0FJ1Gtp9qcVQkR2dZh5R9BpO95XrPVRhunSgMdWAGG1J6O+K3Un3IpIAD8ggx6Dzci42JNp/b8G7wD/lL/ZALeROrJ8WeXkVg1ASb6dtUZ9flawf+lOIo9rYBp8sMSEtUoA8Ovtivg048Miog0LgOOS5Qk8LiqxW+rs8qyttk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6089b64f4eeso39945787b3.2;
        Tue, 27 Feb 2024 00:09:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709021374; x=1709626174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxX6RgMhHn+61tSmT8CWOQW7owJHb+LAZ7EIbG00Oes=;
        b=Lu0g0/ypkUKMmELukkMQMwZckHBUyfixbsOGqU886lmET27WRZ8DOpMpVVT/denF91
         p/RWJY4UAXzuRTKxn9jqjJOoHMTyRANSG0tw9cnN14uMqmiIidfQHQWe5x2zd9mZuHEW
         BDgGOgc1EdqSa/yxwcCtoQ0e9/iQq7vH8OQNdmyxBUYa632tDHgamS0AihmefgkZcT9m
         q3dYv2yJQ/iK2SNPAkq6tbGvC3mOim7a+Q3+oxSkGxZ/5VqEAawyXQmcdXcCOf4LJIlR
         uhCd34fhu2If/5rhYhQ6Om/W7V62ZtXPM6dD3FwiDic7YOSM0M+mdGeNxQhLleQo5SrY
         GoYg==
X-Forwarded-Encrypted: i=1; AJvYcCV5mnlQt4XXjHgYSXiw23GtSFztKfIMjGGsUQUozWwu7iW5IRCb6aIaKbixnyE7fVU3RZB3uM6yUR39lO2IerJ0Kof3PZ7Iof8EVjH77mx/0GhmnHdu2HcKojwaYoxHpBuXFDJeRaMfp+yMwXjDv6ZcrqL18F5Q4mFvv+wgeu8ASmPFf8QQQtqRAupi
X-Gm-Message-State: AOJu0Yx4iZGzchE30v/1Mi9UhmNCpaa6bqaNsz15Fe3Q+8F3Rf/OdNsU
	rI3CRdc7gFhRHbBMunmf7ieatopcRp3KK7gzSg6unKUlWubPDnAL2QhJj0L1gCA=
X-Google-Smtp-Source: AGHT+IG9+pEFYRnV3Vs/Op0zIXiS8hO6DFhbFYz8aV1rH/fibW9jG9k431KodJjx6pL17YG6jLEf2Q==
X-Received: by 2002:a81:a107:0:b0:607:e374:762e with SMTP id y7-20020a81a107000000b00607e374762emr1543247ywg.16.1709021373732;
        Tue, 27 Feb 2024 00:09:33 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id n188-20020a0dcbc5000000b006092073cc7csm444717ywd.107.2024.02.27.00.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:09:32 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60922e16f6fso6683497b3.3;
        Tue, 27 Feb 2024 00:09:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSOYlhcHsgL61YZwjN3D9uUKyUgL3kbpL9Ff34zlmFqxQcSYcIsbmuVkdjfvxE+UusoNEn6yrUORBHmz34p20wUUI7p1jxbR9FdFHqVdOe27c+6onwom+D3FXYEJ9G//wS5h2s952Bu3tZXa02Y8PFfdDk9XQOxZNWJ1Ey7eVuAIKVQi0BhEklRZLz
X-Received: by 2002:a25:8392:0:b0:dcd:1f17:aaea with SMTP id
 t18-20020a258392000000b00dcd1f17aaeamr1417412ybk.26.1709021372474; Tue, 27
 Feb 2024 00:09:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227034539.193573-1-aford173@gmail.com> <20240227034539.193573-2-aford173@gmail.com>
 <CAMuHMdWhtu7nuBpC=TSY6rMaReJNgYok535xXotDyKJDT1_Mzw@mail.gmail.com>
In-Reply-To: <CAMuHMdWhtu7nuBpC=TSY6rMaReJNgYok535xXotDyKJDT1_Mzw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 09:09:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdViTAxWk8uvT-tgD4X2MJW5R3R1aqrv1K=FyQLdAciFcg@mail.gmail.com>
Message-ID: <CAMuHMdViTAxWk8uvT-tgD4X2MJW5R3R1aqrv1K=FyQLdAciFcg@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: gpu: powervr-rogue: Add PowerVR support
 for some Renesas GPUs
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
	aford@beaconembedded.com, Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adam,

On Tue, Feb 27, 2024 at 8:48=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Tue, Feb 27, 2024 at 4:46=E2=80=AFAM Adam Ford <aford173@gmail.com> wr=
ote:
> > Update the binding to add support for various Renesas SoC's with PowerV=
R
> > Rogue GX6250 and GX6650 GPUs.  These devices only need one clock, so up=
date
> > the table to indicate such like what was done for the ti,am62-gpu.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>

> > --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> > +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml

> > +          - renesas,r8a77951-gpu
>
>     ... # PowerVR Series 6XT GX6650 on R-Car H3 ES2.0+

All compatible values for R-Car H3 variants use the r8a7795 "base" value,
so that should be:

     - renesas,r8a7795-gpu # PowerVR Series 6XT GX6650 on R-Car H3

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

