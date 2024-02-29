Return-Path: <linux-kernel+bounces-86405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632F586C4F4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906561C22375
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF8F5A7B4;
	Thu, 29 Feb 2024 09:24:48 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE5456B9F;
	Thu, 29 Feb 2024 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198688; cv=none; b=fws37/9A14DFDZl01nJV7YXmKrsTH1+6Oi476BeJA/kGOEjhpHUjYZR0MdndKlkAV01EyGUWOlpRGAD68dDOUzACEuW3vGyAUuF85Fh0Fhu7Tee1iQyWGV4Tiwp17zLId/HmJxuC398mGx8/czSsIaPAp4T8hxwSLTg9qhtUBZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198688; c=relaxed/simple;
	bh=0kHQ0GejVWut6mUdfhxw4ufNnN0JQttO2gwB+cW5IhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGtIirLEvZm5xBVm/fUXfRDCyUC3R/YhCVdfoToPgqoIKzDiUYxiHUf6/lD8ukqApY0Q8KzgX14ncYzTC32/COAsXthEmju6Z6U2o1r+jcUNZtPSx01f2V0tOYTkLXWrcy7md6snOFK16eoygxweWe/jj/YSmsoDFAY7ca+mg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-607e54b6cf5so4751727b3.0;
        Thu, 29 Feb 2024 01:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198685; x=1709803485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7icNGafOYUKFBdEjkxyTnGxldpNssuhfMdqNKkUf55w=;
        b=lboMUtyMRJXbJFSYCpxCd6v6JbCluEt8kNP5wHJPNQid/zCkZOY93++1H2KQ5Gz7pQ
         j07kdckBhfF/NwNzFb+5dFtr5zRET+d2PMV8/JSRGwmgKG35cTQ41cEG3LC2tzml/3En
         qFVe6eoWllN9B91+juPB0JMulq2+wo20J55IwqPU4pYtWpOBFhRfHN+RN4X3deSkujqi
         OZXwKinNEUym3x71nok+YD0aqjr+2cZXL6J882gRBopJQ0+xdmRm0EW4kGIOwRk9sSqs
         lKrWu9QCLwe59Esa1+bjdrbpfOC34EOTbGCSvAM71x5FTntzns5F+deKH9MdlUA+iolR
         zFjA==
X-Forwarded-Encrypted: i=1; AJvYcCXZWxk+pUwaDdClE0QI49P2PGFdJ6gWLafs3z39zn3kl5NyVnnEi41lBtu/rWe7BxoWNxjlk8Dlo8J8IhJuwfuvbksBnPW3QvjwPFiq9m4y5vBgUipdfTk/RH8S/dE4G14ETEzVoPyrxBgPZ23fSJWq4eIcQUshqKtaziMQ2J0dXwJbuN4=
X-Gm-Message-State: AOJu0YyYeHc4P5ItyVyoffH9KYYsj/F4uPl8fjT4buSEzK3AMeiE3CcK
	kjq1ZMOgjkp2VOys+MURwz1IsuQ/DBQwxPE6TkoVOS4Am7Pui6CT1fUBemiL+AM=
X-Google-Smtp-Source: AGHT+IGDNzCIR8pnj5In+3RsVgXYCKKILxBuH4FNWYKYDo5z3jcQ72B362S5fYe5TntZMjb80PcsMA==
X-Received: by 2002:a81:7102:0:b0:609:2a04:fa64 with SMTP id m2-20020a817102000000b006092a04fa64mr838504ywc.18.1709198685274;
        Thu, 29 Feb 2024 01:24:45 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id s5-20020a81c445000000b0060755a31c0bsm260899ywj.100.2024.02.29.01.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 01:24:45 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so512043276.1;
        Thu, 29 Feb 2024 01:24:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXiFcVDTBolPlaSWjtpLD6luMY4ZZ4YGnoq2sKhPgZRSNCvZ6sU6gAE0+SWlXXgvLBvFT+6YWAVZCYvwvkz2n1LBmTp3lKlq6rK0OKeQ48l4TPbpGa6UosUsUijh1awt4I30aiuf5RypFVh4gqjXq5hUky+IFOoETQHSuZpyhj66Qtjn28=
X-Received: by 2002:a5b:d08:0:b0:dcd:c909:334d with SMTP id
 y8-20020a5b0d08000000b00dcdc909334dmr851170ybp.12.1709198684812; Thu, 29 Feb
 2024 01:24:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz>
 <20240227212244.262710-3-chris.packham@alliedtelesis.co.nz>
 <20240228140423.GA3307293-robh@kernel.org> <d666668b-f371-47e0-846e-6e8a56b4bb2f@alliedtelesis.co.nz>
In-Reply-To: <d666668b-f371-47e0-846e-6e8a56b4bb2f@alliedtelesis.co.nz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Feb 2024 10:24:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJT5THun7XG8ig746Bh+paAP5uSMg33aa=Csui4Dkb4g@mail.gmail.com>
Message-ID: <CAMuHMdXJT5THun7XG8ig746Bh+paAP5uSMg33aa=Csui4Dkb4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: auxdisplay: Add bindings for generic
 7 segment LED
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Rob Herring <robh@kernel.org>, "andy@kernel.org" <andy@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>, 
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>, "ojeda@kernel.org" <ojeda@kernel.org>, 
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "javierm@redhat.com" <javierm@redhat.com>, 
	"robin@protonic.nl" <robin@protonic.nl>, "lee@kernel.org" <lee@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Wed, Feb 28, 2024 at 9:02=E2=80=AFPM Chris Packham
<Chris.Packham@alliedtelesis.co.nz> wrote:
> On 29/02/24 03:04, Rob Herring wrote:
> > On Wed, Feb 28, 2024 at 10:22:42AM +1300, Chris Packham wrote:
> >> +  segment-gpios:
> >> +    description:
> >> +      An array of GPIOs one per segment.
> >> +    minItems: 7
> > How does one know which GPIO is which segment?
>
> I've expanded the description in v3.
>
> + An array of GPIOs one per segment. The first GPIO corresponds to the A
> + segment the last GPIO corresponds to the G segment.
>
> Do you think that's sufficient or do I need to add more? In the driver
> itself I've put a little ascii art diagram of the segments.

Given users are reading the bindings rather than the driver source,
I would move the diagram to the bindings.

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

