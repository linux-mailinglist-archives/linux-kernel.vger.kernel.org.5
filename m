Return-Path: <linux-kernel+bounces-73699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC4285C619
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 022CAB22B69
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDD21509BD;
	Tue, 20 Feb 2024 20:52:13 +0000 (UTC)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33046612D7
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462333; cv=none; b=LF5KK9x+iPCwzaQ6oWKgwuGhh/oWTPaAaBcZMG5rcZ6tRbF9KTocuLMpjK6LwnU18NAHMu28XMm3EfB9paTaEyhQ1GagCEr70OztxY/Jqch7yixn+5wYBvbbTQRpSk1LCwSkKREHLx9+y2qnS/nz5WgIqLb/ocAbyvrj/R0ivVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462333; c=relaxed/simple;
	bh=IHckkbKwxnwokJbcR1jV5d02inkAyYIZkekwfyWAnPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBcro/XGpPf/08xQT0dfiN5EIYk5Fls9X3AxumxmYqwa8uGCBzB+1hAMQWV8lGL74vK4r2s+YUHGIjwi/c0zOmcr8GrJ2tg2tTj1W89lzT/x7gNcOX3OeCq/JIW8D/f0Ky9CoUpSQ19Zs19PeGcp9zPAZKPoJtS/3ZzX/xzDpPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4513788276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708462329; x=1709067129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eibE+ZUH6lgo0yoc9oUeL62jfLpr9z0YSo80iCg4SM=;
        b=oR3Vf49Wt0Gwi7/K+PXEvZg81s+Oc2lz7T0flpiFriZbyjKOjc3pD/VYBJ0SK9DjMR
         6J1yaD5JxAbvd5l79flLFO1iljsN8LpL3EuF3itgibCr+ctSfo6NUWvOv9rx1WpaqX9a
         AlJYYLtlDtpcZJD6VYR7Vk3Wu/7iF79dgEn4AOqEON0J9jKTT0AY7s5AFJaupiCjO4zV
         8R6RapePG7IwiCsTCUZYpgkh9h/pteWVAW/IM/YbcgNEe90LoRHw15cxzPn03bx0JcS/
         7vfPLAtmmbvjXurtFQQ+PH5nz4Vcyc7Qv4IA/Pa0Rjz8rbi6nZMnYyUq0BmOI0pjy7ca
         pfJw==
X-Forwarded-Encrypted: i=1; AJvYcCVyEXNjex+oTIE/sHEMvsg4Zfd8ENoH4KL/DtoI/N42t/FJEWVLclv18ZjFXQeXW/ZdEEXZP0/dN5xDAkPTynbAfGAm1tmGKGUloJie
X-Gm-Message-State: AOJu0YyQWJ9oZInN4puv7d75d2rOMcsP8ZfG7avFwO/zKHSG4FuYAqhP
	88BGSOreUNAexeJz1J6pSBM8caD+1Ara7jqvIYY870cTsVJF6P8qTQ4iBe7JuRc=
X-Google-Smtp-Source: AGHT+IHk3vTFEXdI4fkURxUUUzDbwwXpg10ALk60JmRpIPOWzhu/0Cdd+y9LsObbeNvKRWILF0beFg==
X-Received: by 2002:a25:fe03:0:b0:dc6:ff32:aae2 with SMTP id k3-20020a25fe03000000b00dc6ff32aae2mr10401703ybe.63.1708462328972;
        Tue, 20 Feb 2024 12:52:08 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id p9-20020a257409000000b00dcdb990f93bsm2056261ybc.64.2024.02.20.12.52.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 12:52:08 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60853ad17f9so20354857b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:52:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVP/vYTb8xfJ8GyCiiOngB1yZFZ7LSOAHnUDNXdy5+EjkSNXwImEQ69NdMs1DHhzmV3dFZnlDSAdRC5ZJDkDDySeOaqkAjYkNB+XXGE
X-Received: by 2002:a0d:eb12:0:b0:607:7f6d:e962 with SMTP id
 u18-20020a0deb12000000b006077f6de962mr14002502ywe.22.1708462328111; Tue, 20
 Feb 2024 12:52:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wi8vZD7EXZfob-yhfDERyfzWxzMOzG9FsOuaKU-v6+PHA@mail.gmail.com>
 <538327ff-8d34-41d5-a9ae-1a334744f5ae@roeck-us.net> <CAHk-=wj6xj_cGmsQK7g=hSfRZZNo-njC+u_1v3dE8fPZtjCBOg@mail.gmail.com>
In-Reply-To: <CAHk-=wj6xj_cGmsQK7g=hSfRZZNo-njC+u_1v3dE8fPZtjCBOg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Feb 2024 21:51:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWqXHajFnBq8gaPbZqRSdZ7kvOCBsKzxEN9ncCvwjcBqg@mail.gmail.com>
Message-ID: <CAMuHMdWqXHajFnBq8gaPbZqRSdZ7kvOCBsKzxEN9ncCvwjcBqg@mail.gmail.com>
Subject: Re: Linux 6.8-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Tue, Feb 20, 2024 at 8:58=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, 20 Feb 2024 at 11:09, Guenter Roeck <linux@roeck-us.net> wrote:
> > Build results:
> >         total: 155 pass: 151 fail: 4
> > Failed builds:
> >         csky:allmodconfig
> >         openrisc:allmodconfig
> >         parisc:allmodconfig
> >         xtensa:allmodconfig
> > Qemu test results:
> >         total: 549 pass: 547 fail: 2
>
> Grr, I was hoping things would improve, not go backwards.
>
> > ERROR: modpost: "__umoddi3" [drivers/gpu/drm/tests/drm_buddy_test.ko] u=
ndefined!
> > ERROR: modpost: "__moddi3" [drivers/gpu/drm/tests/drm_buddy_test.ko] un=
defined!
> >
> > Commit a64056bb5a32 ("drm/tests/drm_buddy: add alloc_contiguous test"):

[...]

> Suggested untested patch attached.

Thanks, your patch is already the third fix I am aware of.
That is one of the issues with build problems like this: once it is
upstream, too many people become affected, and write a patch.
And all of that could have been avoided if the buggy commit was not
included in a PR _after_ the breakage was reported...

Now back to bisecting other runtime breakage in next...

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

