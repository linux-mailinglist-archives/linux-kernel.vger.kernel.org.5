Return-Path: <linux-kernel+bounces-5898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E1D81913E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6E11F25C95
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7262F39ADE;
	Tue, 19 Dec 2023 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fYBOgBhO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D839AD1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4b6e5c64ea1so220426e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703017069; x=1703621869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av1n9OJZGg5AWOWJRoSVZmbeuDxmI+iTFMe3cfVJAFg=;
        b=fYBOgBhOr7cDUfspYqCPWPvh8Dm0q7L4ziXmLqF0+M+kICIvCROb6rz2Ari6T9ypJf
         htUNxuvJA790w/a40Hr9uJsVmp8H+/oIJTrjElB2Eofa7OauDw6LKVGeA6FwPAKsnnxa
         O2R7+z6HYnXZ9g/2xzbfVZIXZ7WYsi3ELA41QWtF+o2hQa6p3XZwED2mAlV3TM0KgykM
         gsZ91WzUAfYf6jJJ/ft90LJN9r5lCBlxyEhVo4BzhrAkiTnO5TobF7c1DdlZO/StkgV9
         E+h1AhBzf1HkkLSqVW33VRjpLxyWTh74aQBwHXrbDDMzgM65sOCUD5W/Di4JPcwO8Efd
         nQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703017069; x=1703621869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=av1n9OJZGg5AWOWJRoSVZmbeuDxmI+iTFMe3cfVJAFg=;
        b=qQ2Av1t3BqnatPH2bL+3ynj0ung9D4z06S938t66jQzNQYc7B6AQ6GEMGxRN9cekBI
         2E9MDcFIUCWJJlYlceL8LnYWmY8KiK9n5DFBvnyob6pgAIjxeJ2XLCPyT0VU4NImYwTx
         725dYhfm4qnP+przGSP08/sey5JoT/BcmQI7FAQj2P5/Ct/GzQAWEXuQwXxtvjJWDaFD
         HOXU/LJUWANvrsL8w9+25AT3dtSIVKIO21Vhaqb5qEOHVYkq5KvW9YXp+dOBSnKCBJGD
         zUDpskOjTj+l5mV08Y6lX600/b0BPQy9h7/Ki8NlXRV9iTNCBoSP2ak3TFjxC4MX6535
         i4bw==
X-Gm-Message-State: AOJu0YyXCHu/Ns4oYMJxP1iJKiNlXx5fm+PLg/UEvCAqs5WNUZSf3WHq
	OtzfqWqkeutZxqwP2hQ5JoGHUayUNFfseFp0tIRlvg==
X-Google-Smtp-Source: AGHT+IELixplTSZD1hK7e+W9C5kRfBjAbzmG32SkyE5j4fCgRilXWf7SYAXSp3MldVrUxyVV04rV2cbNnVzlDRYbbDk=
X-Received: by 2002:a05:6122:3c42:b0:4b6:c815:bedd with SMTP id
 fv2-20020a0561223c4200b004b6c815beddmr2342192vkb.18.1703017069499; Tue, 19
 Dec 2023 12:17:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115165915.2936349-1-brgl@bgdev.pl> <CAMRc=MfoE93Aum4s-pweeb_idqYgUG-DBpXnhT5UW_WhVkLwHw@mail.gmail.com>
 <CAMRc=Md6fCbXco-VOZeDM=cAy_a6HGjM8N5jse5OM7AXSha4dw@mail.gmail.com> <CAMRc=MeLCUQ1dGT2RsgrWMBMbGmjQ9tGwEWJ7nBCOss9TfvvGw@mail.gmail.com>
In-Reply-To: <CAMRc=MeLCUQ1dGT2RsgrWMBMbGmjQ9tGwEWJ7nBCOss9TfvvGw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 19 Dec 2023 21:17:38 +0100
Message-ID: <CAMRc=MdibLmNYTk6eO7GUu20aaOmsVVX8bHCug8r8yR6EYSefg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/4] genirq/irq_sim: misc updates
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Yury Norov <yury.norov@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Marc Zyngier <marc.zyngier@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 10:14=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> On Mon, Dec 4, 2023 at 9:47=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> >
> > On Wed, Nov 29, 2023 at 10:18=E2=80=AFAM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:
> > >
> > > On Wed, Nov 15, 2023 at 5:59=E2=80=AFPM Bartosz Golaszewski <brgl@bgd=
ev.pl> wrote:
> > > >
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Here are a couple of updates to the interrupt simulator. Two are mi=
nor:
> > > > remove an unused field and reorder includes for readability. The th=
ird
> > > > one simplifies the error paths by using new cleanup macros. To that=
 end
> > > > we also add a cleanup definition for dynamic bitmaps.
> > > >
> > > > Resending rebased on top of v6.7-rc1 and with tags collected.
> > > >
> > > > v1 -> v2:
> > > > - add a NULL-pointer check to the bitmap cleanup macro as advised b=
y
> > > >   Peter Zijlstra
> > > > - initialize managed pointers when declaring them to create a clear=
 pairing
> > > >   between the type and the cleanup action
> > > >
> > > > Bartosz Golaszewski (4):
> > > >   bitmap: define a cleanup function for bitmaps
> > > >   genirq/irq_sim: remove unused field from struct irq_sim_irq_ctx
> > > >   genirq/irq_sim: order headers alphabetically
> > > >   genirq/irq_sim: shrink code by using cleanup helpers
> > > >
> > > >  include/linux/bitmap.h |  3 +++
> > > >  kernel/irq/irq_sim.c   | 30 ++++++++++++------------------
> > > >  2 files changed, 15 insertions(+), 18 deletions(-)
> > > >
> > > > --
> > > > 2.40.1
> > > >
> > >
> > > It's been two weeks since this submission and ~2.5 months since the
> > > first one so I guess, a gentle ping is in order. This is not a very
> > > controversial series - can this be applied?
> > >
> > > Bart
> >
> > Another ping...
> >
> > Bartosz
>
> Thomas,
>
> Is there any formal reason why this cannot be processed?
>
> Bartosz

Ping.

Bartosz

