Return-Path: <linux-kernel+bounces-66724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC28D8560B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACD41F24834
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A7F12B14C;
	Thu, 15 Feb 2024 10:58:10 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B085512AAEA;
	Thu, 15 Feb 2024 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994690; cv=none; b=fgSwty/+16Q4H1W99kUBc4gHpqshPbrd7BAVew9UjpCsioHOcWeGGQobJIDJMVQQ21uF+501ehgVSS6hcvsNE3ibese/WAEeoQjp4jSkrmTytvyxppUEAz4ETzkCdIADQBb7sBsEzIvqoRf6DxSiZ8PRrdygpdU5/rQKXQHWJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994690; c=relaxed/simple;
	bh=vUesT69O7egr26kxPrRgX5ev/5Rrb6u8SstpGni/Rss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+pFcV0VFXn7FdkuEQsBu7uBd7nET47ED3WXR39H+bMPODbzjSHX5hxSd53mELRSjPodhAk3qtZ5/mTSb6VS9xAmQDjz/y0i3F4yQdXaHd5lIlrVrXpiSjmbASuBkByWlGPR143Jdu0xXcwMeq11GazL/y+bYU8xui3vKr+TbLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6078350e130so7048797b3.0;
        Thu, 15 Feb 2024 02:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707994686; x=1708599486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noynfA6+8D/0XF211K1pp3EPN1BH66Mm0ZHWHWfYWy8=;
        b=W1QZQ1Jomsd6f/zfOLZdtkCI7Gfyl1XLzfJhQ5Tx7dZtHPtSaDPslCYziu+CBqQ1p3
         IMpv2WqMOcGxB716BHiD69wWceRA2J3fy7Uum/7HAuqgI81G9Szn6oPWI97a2edjT56g
         w/Da3f4HgQbxm5oGFiiAr7agM8agCETDgVwoOrnR9jsuUXKTCn8918VZAhvze+cIw9Ei
         xVfUzr2W3EdcVnEERF2ExtWSbyoAHr9Kj0hLSzYHrTcH1HeQBieY1qLG4OIhdSK3es+w
         N3BIrhijt6PaybdE35r2NfnxrElPvmPOXW0r6h/07nyf8sH008C/+YO2IINHWRJSXVW4
         JC4A==
X-Forwarded-Encrypted: i=1; AJvYcCUusYzdIbF9TWARKFy1K7A5OopSIqFvkD73E0OlCCUvE+tV5L5LJ0oeXRA7U9ylnR4jukcm7A8wz29CS18iW0FM8eqOb3Eu9VSOgtXJ
X-Gm-Message-State: AOJu0Yx4zEpGgjmxDq2T7/1tzBP6Skhoqd+5RK/Fo/WnuQqnFKnKvCri
	rMe+fmi6lYDB6F15NOE8LXIwYbeAP0JWqjOlQ/g5l3GQkpBqEjE8+3cW716Pnp9lQQ==
X-Google-Smtp-Source: AGHT+IGyQRKvD7MpSfh04UErENSY1UqOWXAS+fj6K3UTjRjIPhIGzzmpM6ZsQ6Qj3+uxnbm5HcxupA==
X-Received: by 2002:a0d:ca12:0:b0:607:84d9:9820 with SMTP id m18-20020a0dca12000000b0060784d99820mr1213084ywd.24.1707994686268;
        Thu, 15 Feb 2024 02:58:06 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id h130-20020a816c88000000b006042cdc8de6sm190142ywc.101.2024.02.15.02.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:58:06 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-607c5679842so7515717b3.2;
        Thu, 15 Feb 2024 02:58:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzy1y1fVNMWvdWk/VJFQS6NUWisVkGkwSzPdO1r1IkITSpjeYrWd8NjlzJB5EgcyisTZ/C7hznxY+K9vK+bsQQXbH8eD8BTRLf/0UI
X-Received: by 2002:a81:994b:0:b0:607:a0ab:c238 with SMTP id
 q72-20020a81994b000000b00607a0abc238mr1320310ywg.8.1707994685833; Thu, 15 Feb
 2024 02:58:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-15-andriy.shevchenko@linux.intel.com>
 <ZcpSDOk-IQVasHud@smile.fi.intel.com> <ZcpSaHW-RQ3dzywP@smile.fi.intel.com>
In-Reply-To: <ZcpSaHW-RQ3dzywP@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Feb 2024 11:57:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV8mTa-qutFgqRKJyES7evEqEYhs=_eHtrKTTs5NkNa9A@mail.gmail.com>
Message-ID: <CAMuHMdV8mTa-qutFgqRKJyES7evEqEYhs=_eHtrKTTs5NkNa9A@mail.gmail.com>
Subject: Re: [PATCH v2 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robin van der Gracht <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Feb 12, 2024 at 6:16=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Feb 12, 2024 at 07:14:53PM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 12, 2024 at 07:01:47PM +0200, Andy Shevchenko wrote:
> > > Add initial device tree documentation for Maxim MAX6958/6959.
> >
> > Oh, this is an old version :-(
>
> Here is a new one:
>
> From d8c826e06cf9237cd5fc6b2bb0b1cac5aff4fd8a Mon Sep 17 00:00:00 2001
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Thu, 8 Feb 2024 17:23:38 +0200
> Subject: [PATCH 1/1] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
>
> Add initial device tree documentation for Maxim MAX6958/6959.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/auxdisplay/maxim,max6959.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/auxdisplay/maxim,max6959.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MAX6958/6959 7-segment LED display controller with keyscan
> +
> +maintainers:
> +  - Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> +
> +description:
> +  The Maxim MAX6958/6959 7-segment LED display controller provides
> +  an I2C interface to up to four 7-segment LED digits. The MAX6959
> +  in comparison to MAX6958 has the debounce and interrupt support.

IUIC, the primary differentiating factor is that the MAX6959 adds input
and GPIO support?  Debounce and interrupt support are merely features
of input support.

> +  Type of the chip can be autodetected via specific register read,
> +  and hence the features may be enabled in the driver at run-time.

I don't think you need to read that register, as the users of the
features (keypad mapping, interrupts property, ...) also need to be
described in DTS (once supported).

> +  Given hardware is simple and does not provide any additional pins,
> +  such as reset or enable.

Does this matter? I.e. is it important to say this in the bindings?

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

