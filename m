Return-Path: <linux-kernel+bounces-78343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5A386122D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E37B26E90
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2DA7EEF2;
	Fri, 23 Feb 2024 13:01:49 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AE47E773;
	Fri, 23 Feb 2024 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693309; cv=none; b=eFPRJMobK54U5o51IvHX8k7Il58mWLor4oQI0kpxWfVO0wbNpOarPv+kOYY5GRtzGFH6E6hDRV0lmRnlKtSn5Ac02aWlAGLhj4SDBT8taMrlNhsCYjPHuOfQu5c4MTlU8HxYwKc/1dYl1pPchmpo5FGuBcDImNE+cBH6w/ChCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693309; c=relaxed/simple;
	bh=sTvoAXmMJdiXC9GDbXtcxaiXLut+VjyJMSnX7MgcxnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLN0EwBhRPi07CPF3WG1wSTdmB0WvtkpUOJgMaS2TNLv66JUuu2TY6UtUJZ9Ej2SNV+R8bRY7d+ARgQxE7wYDnw68Se9k1n5L+K0LQfgRwj6k6xPFqjwOtzggUQUbTowL9Fri/WEewShrtjaQhD7iHY7xzYe0pTEUxpiwYWSd+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-608aada6268so3393047b3.0;
        Fri, 23 Feb 2024 05:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708693305; x=1709298105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZMyJrVh4sq2TK8cMQd96IQouFxqqsuFp3MH8PBAJXY=;
        b=cShMqzrTaLJqESnnygjRzKltRTaYkoN4Ao4fHoR+pDWSgI6GVJkvKu2hXJghcmZ68T
         HvlaVeCJWQrTqXm2RKgtMQr8wpu0UkVR4jLj+NmDQq86RwR16sQ8hmw77RUTDZcbOfnS
         a0dChbL3WzdXeDBmU5eWfafZfqHCglvkwzcycvIGd3VllFdP66b/2fTDmcDzlhGcI3rs
         8hVhSTOx+8QDZ7R5gt9htPa72jXbFr21q873taR5lPpVGXgMsdrWinLnSqMTSVhAeEFy
         BJlelY0yYHqqcBiahTFPfn6ulJmCQRrmGzCq93IynOcPwpdT6am/VTon5XsiWY4MHZZw
         KXhA==
X-Forwarded-Encrypted: i=1; AJvYcCVwBuVPiTKhNPCpfqZGbkHBOewHvOvmpanH6FRj9gYZN8mx/3NNEiqT+l1DhFG16vB2rU2pg+PwHGCjIHk6V8B446I1jvlhezj+N3kadzF3Ph6jAlNl+mHKyJB3tN+gDGjpWTc2HbP7gQ==
X-Gm-Message-State: AOJu0YzaylxW7Qo9UtI/eNEU0mzIffsRVTqYwkp3wSr7sl78mwuDxc3b
	Ze9WqsQiuWJ+5SzdkKIQjiA7HbH3vj33BOGmtMDp3XuWMIQG3vVqg1o5cEFwaq0=
X-Google-Smtp-Source: AGHT+IGubM3X8/MtHL24FMVDSgYBW+Q7FKL6e5h7W8tovYW4MVd8DNuSrqY4CG5LzPHAJCrS6rC/Pw==
X-Received: by 2002:a81:e301:0:b0:608:eb0:5efb with SMTP id q1-20020a81e301000000b006080eb05efbmr1792750ywl.46.1708693305608;
        Fri, 23 Feb 2024 05:01:45 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id x11-20020a814a0b000000b006085e262414sm1876778ywa.81.2024.02.23.05.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 05:01:45 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6089ee871ccso3169597b3.1;
        Fri, 23 Feb 2024 05:01:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqdVrTSOPUELHUK2o2r0UOaPGDsozVXeZZDdtkNZZE3cPCNf8wRnH3VJewOuNArd2sKwsaxpKTb9a1jh6+8ELqTG+B2cF15bcT3jo6iZS+yNeO9WIb+yEVt8G3gPSJKzZya4fGF19Vuw==
X-Received: by 2002:a5b:ec5:0:b0:dc7:4859:6f1 with SMTP id a5-20020a5b0ec5000000b00dc7485906f1mr1854312ybs.33.1708693305208;
 Fri, 23 Feb 2024 05:01:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f598a72-dd9f-4c6c-af7f-29751f84bd23@alliedtelesis.co.nz>
 <Zde966nsJ76QOuzm@surfacebook.localdomain> <f5e74774-226a-4678-a6f9-b4f17250ad91@alliedtelesis.co.nz>
 <CAHp75Vfq3Pc+Eo3Z5mhORZwwuKF+Y7_47dTO8qARcfba4nmj2w@mail.gmail.com>
 <9d00e1b1-120b-4c2b-89c5-0ac736bf6441@alliedtelesis.co.nz>
 <CAHp75VdnXtVwrLrcGjnYMfNx7roBvQm9DMr6_ndjZeAbRDbs_Q@mail.gmail.com>
 <2a8d19ee-b18b-4b7c-869f-7d601cea30b6@alliedtelesis.co.nz>
 <CAMuHMdUFW7iTdhQtW4eDnU50zRqsdWsLnTD74UQo8tBU66-dCA@mail.gmail.com> <CAHp75Veyvw75jc4LFpW2EQQ=wSYmn_VdsPBWVG03b+P0QvyGaQ@mail.gmail.com>
In-Reply-To: <CAHp75Veyvw75jc4LFpW2EQQ=wSYmn_VdsPBWVG03b+P0QvyGaQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Feb 2024 14:01:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX0CYWGn8OSQ3sXGyZTSqjTK5n1aj2-BOudfEejp980Tg@mail.gmail.com>
Message-ID: <CAMuHMdX0CYWGn8OSQ3sXGyZTSqjTK5n1aj2-BOudfEejp980Tg@mail.gmail.com>
Subject: Re: Linux support for a 7 segment LED display
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Chris Packham <Chris.Packham@alliedtelesis.co.nz>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Pavel Machek <pavel@ucw.cz>, 
	"lee@kernel.org" <lee@kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Fri, Feb 23, 2024 at 1:36=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Feb 23, 2024 at 9:52=E2=80=AFAM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > Note that most larger displays are not individual LEDs, but matrices
> > of LEDs. Do we want to drive/scan them from software, using a
> > gpio-7seg-matrix driver?
>
> LED matrices are the displays (like tinyDRM is for).

TinyDRM is for rectangular matrices.

Multiple 7-segment displays are usually multiplexed using a matrix,
using 7 (or 8) lines shared by the corresponding segments of all
displays, and one common line per display.
https://embedded-lab.com/blog/wp-content/uploads/2011/03/Lab11_Circuit_Seve=
nSegmentMultiplexing.jpg

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

