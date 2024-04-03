Return-Path: <linux-kernel+bounces-130428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA15897867
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DDDDB2DBE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F8A153566;
	Wed,  3 Apr 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBHw4ak6"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC226154BEF;
	Wed,  3 Apr 2024 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167943; cv=none; b=O0fi5dIv0qp6/7Hsc5tScWcJtOTJZMC/JV5l4Dbr87F2U9hbNSLKZlSE/piZ0D/34+Nu4JMkKf5V57Ruh2QEJkR3Lclhs+D6WxwOT8gsBxJrHUO3ooKKbyAvwxPeblL3XHcgsD30PN2AQ/6UxgjV0XYDd+BT7CivQFBZxkAE0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167943; c=relaxed/simple;
	bh=8xHv3oyWik1X+pB1D6LHL4+E5z+BFONERpUXyTJcEbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5HScwtkrP0HWyueSh9cNfjTIl6/o2diLCnLpOUKkc+3yzxMeVrHtHg+insSfx9I8ziQYYy/SxkSGeSW0u69raitt4ENSKHvfQZEO69qkePeqO9QfUUIGs4mhLeD7d/Xr0BqzviJdS/NIOXB95zxVCAqRNcCScC5l8RNaKZOp38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBHw4ak6; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4d43b3fc06cso33929e0c.3;
        Wed, 03 Apr 2024 11:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712167940; x=1712772740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LPRUCfO8vLA+VTuxeAjc+lg7ZeBV4TKM1NgQNqaX4o=;
        b=ZBHw4ak6buEMI4ESelBXVSkn4JsJJQZWUvmo/3hVXRnB4yuWcttWw+d2Mzsv6pUzha
         TJImE+8OvNeMUsiD5xpzxNa7sF0ufh3Jq6HLPSiTvh1DVOp1oLRICsIcCpaDHK/2e3yO
         pqcU0WQMXpko5YkRnyuacFO+n7pZTh6JVdckGI4rQIvxIVlDHn1Efqpd9HSoHhiz6v4l
         0TKH8V+ON3ffWjEPIxS5aiPn57LgbrvWUdChOPC48m0JtmGvdesOOiKM/gHeSCkiSmsI
         +JGJYtVO3/yxZodDEYvIyqlyZ0rsg/6rq4BwUG9ixA0880JPp80lI/sKq9cDgkv2ldLn
         i7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712167940; x=1712772740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LPRUCfO8vLA+VTuxeAjc+lg7ZeBV4TKM1NgQNqaX4o=;
        b=N45U6w2I4/S9JmqfmKRvyON+woKhtzEPMdM5+VykaqtJuuzQMjeZfrQFjA3s2cUloJ
         Q9+fhyRaQate7UE8MG4YgNiSEWdsllo96M2AL3WYAz8edfQpJIvCiNGx2HAajtdgnR3J
         5YuvfTNClxdHpCw8NIQiFsm1HSpRbkdW8V4mKG7vF0fXu3l9lYB85oEi3hYx1q5oLRbK
         R3snyMZSTrrAxl8AVF40cM8klMWqW9mDp6nCqDKg1+kGr8N1XMCHBiTXw8o3YAZzsmP/
         NRpm7/dM73XYlRA+SnKc516raFfAv3VG4QcSee7K/MfzVdP7w5z2EGCHmFaJBFkIQVLE
         5n2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPaBbDMt2CbQWBwvB2VcoDdpqr0UiTivWGfYul/2jjwmEaYbpyZuKbibo/3wPSDZhq1vZNrl8jrGvxpBKlQc8W+H7X/+iPY9klHhv+HKQY+1TAF9CpDlEAW1X1htabPg3s3WH1J/UkJw==
X-Gm-Message-State: AOJu0YzZZ44j8eAB69w1AqLEu3j/BW41Udgct3eGDYewck+r32pD4bA1
	OGXuA6FW34/i54t8CLIKHwTNrtsQWHX+gtEEN/QnZtJ7K9gXygT/R3jmPsHelb8JNhVjo6kFX5I
	JusRPxUyN87Gr0NEHvTbxrSML8PY=
X-Google-Smtp-Source: AGHT+IHrrkiSOm6wLnFKQHKdrarP92qhgfwfDo/mPb5qCUU7DxYQE24BY/ERiXN9pre31elgG8R8MxOj8He3tkMs4Vk=
X-Received: by 2002:a05:6122:189c:b0:4ca:80c5:753d with SMTP id
 bi28-20020a056122189c00b004ca80c5753dmr40719vkb.4.1712167940470; Wed, 03 Apr
 2024 11:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-2-apatel@ventanamicro.com> <CA+V-a8tGucbJ87hsMQDEgcor5BzDmB_WnRsEn6c9F_HzucWLXQ@mail.gmail.com>
 <CAK9=C2VgiRcQjBEPmZjdcMf221omKS8ntdcenSE7G__4xYcCUA@mail.gmail.com>
 <CA+V-a8ser=hDmst6+XSeOWaEoOd+iY3Ys6bYBWDa5UYPfT+Pug@mail.gmail.com> <4dbd5daf-d100-4ae2-8bda-c657e23a809e@sifive.com>
In-Reply-To: <4dbd5daf-d100-4ae2-8bda-c657e23a809e@sifive.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 3 Apr 2024 19:10:31 +0100
Message-ID: <CA+V-a8uLjEb==sTXa3WePqTWn4ejVNJfMu+qTXSNZz1Uw+U5oA@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
To: Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>
Cc: Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Marc Zyngier <maz@kernel.org>, Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Frank Rowand <frowand.list@gmail.com>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel and Anup,

On Wed, Apr 3, 2024 at 5:28=E2=80=AFPM Samuel Holland <samuel.holland@sifiv=
e.com> wrote:
>
> Hi Prabhakar,
>
> On 2024-04-03 10:49 AM, Lad, Prabhakar wrote:
> > On Wed, Apr 3, 2024 at 3:17=E2=80=AFPM Anup Patel <apatel@ventanamicro.=
com> wrote:
> >>
> >> On Wed, Apr 3, 2024 at 2:01=E2=80=AFPM Lad, Prabhakar
> >> <prabhakar.csengg@gmail.com> wrote:
> >>>
> >>> Hi Anup,
> >>>
> >>> On Thu, Feb 22, 2024 at 9:41=E2=80=AFAM Anup Patel <apatel@ventanamic=
ro.com> wrote:
> >>>>
> >>>> The PLIC driver does not require very early initialization so conver=
t
> >>>> it into a platform driver.
> >>>>
> >>>> After conversion, the PLIC driver is probed after CPUs are brought-u=
p
> >>>> so setup cpuhp state after context handler of all online CPUs are
> >>>> initialized otherwise PLIC driver crashes for platforms with multipl=
e
> >>>> PLIC instances.
> >>>>
> >>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >>>> ---
> >>>>  drivers/irqchip/irq-sifive-plic.c | 101 ++++++++++++++++++---------=
---
> >>>>  1 file changed, 61 insertions(+), 40 deletions(-)
> >>>>
> >>> This patch seems to have broken things on RZ/Five SoC, after revertin=
g
> >>> this patch I get to boot it back again on v6.9-rc2. Looks like there
> >>> is some probe order issue after switching to platform driver?
> >>
> >> Yes, this is most likely related to probe ordering based on your DT.
> >>
> >> Can you share the failing boot log and DT ?
> >
> > non working case, https://paste.debian.net/1312947/
>
> Looks like you need to add "keep_bootcon" to your kernel command line to =
get a
> full log here.
>
Thanks for the pointer, that helped me to get to the root cause.

> > after reverting, https://paste.debian.net/1312948/
> > (attached is the DTB)
>
> I don't see anything suspicious between the "riscv-intc" lines and the "F=
ixed
> dependency cycle(s)" lines that looks like it would depend on the PLIC IR=
Q
> domain. Maybe there is some driver that does not handle -EPROBE_DEFER? It=
's hard
> to tell without the full log from the failure case.
>
The clock required for the PLIC wasnt available during the probe of
this driver. This bug got hidden when the PLIC driver was probed
earlier  in boot where it used an incorrect clock source. Ive created
a patch which adds a missing clock for the PLIC.

Sorry for the noise!

Cheers,
Prabhakar

