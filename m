Return-Path: <linux-kernel+bounces-127995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08AF895433
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555351F24172
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4957F7E2;
	Tue,  2 Apr 2024 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah3OVEvh"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373BA7D07A;
	Tue,  2 Apr 2024 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063206; cv=none; b=JwKcETz8a4ZNU59f6XR03VlgN8QF8osMcxkn4LlbHL9oal/lVJTivRMcaKrTl+PBOB9B8HgJbtOJkeyN9ZgcgfBJFnuqBzWN9vBtujQDScu8ehKZe2ipY8W/SvYMbDI1wvQuiHGRNJYL+LomTzBjc3hov1b64ZTPSiV3LItMsKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063206; c=relaxed/simple;
	bh=iB2gSDbR2dkyx4edtpLxbP9l7fU0ngFgBmwg4Y7zQVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aU8tGqBUWAiOQDL65fq955bzmIrn8CS4t2Ce6s6hHS/HoUyUa7CA+sNTrNu3MC25NZBfd2S4PH4rGARdCjMx9L4VLstJvG1L1k7EcWtxYBOYfPujiSjs6105nBOZqKeA2Ra9HiILfPaXAgfev6ufZqbbFCf/dMOnst+6lX4lFB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah3OVEvh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4a387ff7acso616868266b.2;
        Tue, 02 Apr 2024 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712063203; x=1712668003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f65VZK2taIgLTzjNB/2fmY7WG5Qnc3EYR1bvxekrFWY=;
        b=ah3OVEvhNQxVFJ0es031qCw//Xh8+YF/V7+tlVK6k9Dpda+5j7tKMzQl8zUIBrOMpY
         aYzMTTrPKqLzkRrSg27XKyC8WXugXbS22igHW6GjfsfOCqbp73VQ+ctqEqbdFW1puMAO
         Cnfy9brY1WyMzeVkZQPDEKBkZ4K5x35Ju+36k2u7thzkgeDuf4t8O+qMR890YArpYKIW
         x60BnfHbGtuP0k8FYFGi4zRc03xaZ6fPOiN0paAWPUrDfBzRpdifHq5yKHuWvMz59UHL
         zRypvKjvPAV5vOSIkMBCZTIH8uO0vRLTKM4kAFYzsw0pMxBLOspzy2KPyFynGa7bAn37
         NBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063203; x=1712668003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f65VZK2taIgLTzjNB/2fmY7WG5Qnc3EYR1bvxekrFWY=;
        b=CRG3LbQDkcw5oQpsDrbt3BIFvgWTKb7sGjzu/z/VQUBtWBrp9lXubwnTvRBt14yE+4
         BoC3kLfgFPFXjfS9asCY0IRPNF6brJHby5Pi8TXKF4Bfd9c+jHQPIKdHeOyqo4a8Gf2E
         xWrP0TgMkeTokzm08hFRIGkMuF1B5hw2nWBUUT6d53AOnuKtq4hEhl5zSrqHf0bluhdU
         ed+kDkkVGtQuSWU7oO0yA5knTrJNRB5RJXNU0JoE1sG3vqIDQyJvw0VRQR+QKi+eKTBF
         DkWH+fkql4wIWy8adBqU5qJy7SpizkStOXjCtmAbHlXj0adx99LYDG+tUJQQNoNrA6A/
         2Elg==
X-Forwarded-Encrypted: i=1; AJvYcCXvT/OTE83N6VlSnbhYVX5m4oIMuSSUKfI3kQEkXFoZ5fx9llGcgp63Ut01X166bUIP/kewPdIWT2jXMAhnptDHTGPJTSZHV/9jz8gNIVdn8HDOj3+uiEMCENx6J63N4axDm9+10/G558+OLCXcwNrJrn7lNjyjHv/yMfVhkH9X7OsQi4c=
X-Gm-Message-State: AOJu0YxkaMfqCRaqgNaYTGGvrW5U6G9w75qhEk4CezSohcP9E1IIeKNW
	0dTh5vaXlWllbKViIfsVPKbKzEwIJKrgbVJkjNVG5s+pNg1c0aNz1rDI4FKulGYOSoj6nhtGpH0
	Ufxv+vXHmVGR6PeC3GOLNuZDyI/U=
X-Google-Smtp-Source: AGHT+IGFhidDICd1DuDLTMF6/GRfDHMz7a0kUh4LJPUOf9njSYivo6aIkq7WkYN426AVp/ihVUC3mr9bilSLextXDJg=
X-Received: by 2002:a17:907:7da0:b0:a4e:6957:de24 with SMTP id
 oz32-20020a1709077da000b00a4e6957de24mr4995499ejc.37.1712063203115; Tue, 02
 Apr 2024 06:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com> <ZgcP4IkTQGks9ehH@surfacebook.localdomain>
 <DU0PR04MB9417E797F4E0F7BB6154B3BE88382@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zgu4Tok43W5t8KM0@pluto>
In-Reply-To: <Zgu4Tok43W5t8KM0@pluto>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Apr 2024 16:06:06 +0300
Message-ID: <CAHp75VdAaTeQ_Ag3gd0s9UfT=kAT2hwibeJ9-YFXJx4z=R3e+g@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 10:48=E2=80=AFAM Cristian Marussi
<cristian.marussi@arm.com> wrote:
> On Sun, Mar 31, 2024 at 01:44:28PM +0000, Peng Fan wrote:
> > > Sat, Mar 23, 2024 at 08:15:16PM +0800, Peng Fan (OSS) kirjoitti:

..

> > > > +#include <linux/module.h>
> > > > +#include <linux/scmi_protocol.h>
> > > > +#include <linux/slab.h>
> > >
> > > This is semi-random list of headers. Please, follow IWYU principle (i=
nclude
> > > what you use). There are a lot of inclusions I see missing (just in t=
he context of
> > > this page I see bits.h, types.h, and  asm/byteorder.h).
> >
> > Is there any documentation about this requirement?
> > Some headers are already included by others.

The documentation here is called "a common sense".
The C language is built like this and we expect that nobody will
invest into the dependency hell that we have already, that's why IWYU
principle, please follow it.

> Andy made (mostly) the same remarks on this same patch ~1-year ago on
> this same patch while it was posted by Oleksii.
>
> And I told that time that most of the remarks around devm_ usage were
> wrong due to how the SCMI core handles protocol initialization (using a
> devres group transparently).
>
> This is what I answered that time.
>
> https://lore.kernel.org/linux-arm-kernel/ZJ78hBcjAhiU+ZBO@e120937-lin/#t
>
> I wont repeat myself, but, in a nutshell the memory allocation like it
> is now is fine: a bit happens via devm_ at protocol initialization, the
> other is doe via explicit kmalloc at runtime and freed via kfree at
> remove time (if needed...i.e. checking the present flag of some structs)

This sounds like a mess. devm_ is expected to be used only for the
->probe() stage, otherwise you may consider cleanup.h (__free() macro)
to have automatic free at the paths where memory is not needed.

And the function naming doesn't suggest that you have a probe-remove
pair. Moreover, if the init-deinit part is called in the probe-remove,
the devm_ must not be mixed with non-devm ones, as it breaks the order
and leads to subtle mistakes.

> I'll made further remarks on v7 that you just posted.

--=20
With Best Regards,
Andy Shevchenko

