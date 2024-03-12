Return-Path: <linux-kernel+bounces-99961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9349878FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0A51F220B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDFF77F08;
	Tue, 12 Mar 2024 08:44:09 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9095E76EEA;
	Tue, 12 Mar 2024 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233049; cv=none; b=Uz//WUfu1/w3P24X/kLjo9FfhvdsXtKCyVQzjWF4hap6DTwLYreCaL5FqbM5wdFpCmktR7Zpcf4V1UYiZbZWt3akF4R85A0f9gnyBfF8PSd78UtvermEjH4KqYQ/X4lusYqQfbqtFpnSkhw0FNsYjRDlzgu9xZI0rKKVWxQ829o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233049; c=relaxed/simple;
	bh=Ko17xREfnVJ9Q5io/toRscNTgq+ljN4IWA6tUQbIDlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSAROLV4FDjQgXp8WLY7jvLc43Oc0pQItJhFJL5/xUy4ax3epcBWW4MMLHFrk0B01ad/9gCo3PavLUfBD443JrjWoOU4qkhoiKxG8IJI5IMUXOkjTHc5aCoGaCPMAh/cVzaDHdEcnBmPot0+Oh6dR1QLvqdSxot9Ux9IL2k9AeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60a0a54869bso28092797b3.1;
        Tue, 12 Mar 2024 01:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710233044; x=1710837844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpBVGXK2hwvv9G4vuoIjIOAjMy0hLwpCGg7dYfSa+5Q=;
        b=XjQeJ5g3t+Qt/u9cXSTcVrF041/9R0lWmbOyoHOwGCtq7WUOV/3pOvdaSp55ExR0bL
         h/bSmWLpVpnCu0Vbt001JzD9wOMs6FUP43pVQOkV4mwNVkKT/tKNChuoPuP/E3kFKiOy
         xp28GfMc22i14SJAztVQhBSD0QNn50nKIxNfs0aT4SEIBj+FG/QHQ6zOCbkTe/6tvVNk
         WwySZpJLYuRcNuZgYauXQaxfaemRWJUfkYCU7CoCeVp9Ff6f22AZiodOBAA2Uipp5LvX
         LGdhwrNpiDlnju9cwELsFCVRAUBW24oAajfU5ImXKZLskWZuk8RGQ/I8Yqx9ZW21Toc2
         uNXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX85gB5xUttrxgB90hC4Al/wzqws0BUTehcJvzJH60hubONvBBVeuuT6rG3uFIzFHCUSoCkBaOvcVO0eY99WNyHOHWvKw7VCmn4Yeu+6GQtszCRSpstvd0ACDLl6BIPOHTOy4e3MvpFHiAwUwmluGu+kPxfxUTE628o2vtQWljzvk12fVs+KWjg1MYeSsXYHAi3NYJ9PSwg3M1s5F8O2otFT7HL
X-Gm-Message-State: AOJu0YyRcCYeVjiDPgTQIKFxWWfVTHhSu3a5trrwlX4lobM+JXx3dj/s
	W9qWmH/ckLbNOjvfgZ73U63mNl6vWCj8hBIfGDLt8vvZUIRPWVnnfE7UvWttEZ0=
X-Google-Smtp-Source: AGHT+IHUx+pbNmqsxtbHSGk4Vf8bAiZn6JFHiMHA3b9jK4MV2hR2LblXne40u3jAzeSNSZr+o+Ammw==
X-Received: by 2002:a0d:db0c:0:b0:60a:57fa:2e45 with SMTP id d12-20020a0ddb0c000000b0060a57fa2e45mr646745ywe.1.1710233043674;
        Tue, 12 Mar 2024 01:44:03 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id fq7-20020a05690c350700b006049315b542sm1746900ywb.136.2024.03.12.01.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 01:44:02 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-609f4d8551eso40205287b3.1;
        Tue, 12 Mar 2024 01:44:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5gZtJ3hwJDAXCDinypTkfzRFSXMpW1qOXDej4x6jVyUMRpwXbzW9J7oIqmo/SnVEzXAPEtOzcCTvg+ZuPE9yYiIcVCUJFTvQKy0U6bG0sMycMdp+SgTUDKwhVDZPwsak7X17SK2naX8g0oANO74WAFVpjH4OvGKtUZUZ9jXyK/BgOe3i5CmXUMOnhAqXhsRWSSul30llORJU+TWoH+8EDZvqw
X-Received: by 2002:a81:4806:0:b0:609:a1ed:5558 with SMTP id
 v6-20020a814806000000b00609a1ed5558mr5385429ywa.11.1710233042268; Tue, 12 Mar
 2024 01:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229204039.2861519-1-sashal@kernel.org> <20240229204039.2861519-12-sashal@kernel.org>
 <Ze9x6qqGYdRiWy3h@duo.ucw.cz> <CAMuHMdX-ht_Vetq7+Xh0TqWOcnCdi=3d0VvfgXBF4ExtzGcRDg@mail.gmail.com>
 <ZfAUgYj0ksDmGuhN@amd.ucw.cz>
In-Reply-To: <ZfAUgYj0ksDmGuhN@amd.ucw.cz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Mar 2024 09:43:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXdTG=r8CJOGg2+xqMbrJ_uA3_EkoU9F2gq+zok2cGJpQ@mail.gmail.com>
Message-ID: <CAMuHMdXdTG=r8CJOGg2+xqMbrJ_uA3_EkoU9F2gq+zok2cGJpQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.1 12/12] arm64: dts: Fix dtc interrupt_provider warnings
To: Pavel Machek <pavel@ucw.cz>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Chanho Min <chanho.min@lge.com>, 
	Arnd Bergmann <arnd@arndb.de>, tsahee@annapurnalabs.com, atenart@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	rjui@broadcom.com, sbranden@broadcom.com, andrew@lunn.ch, 
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, 
	matthias.bgg@gmail.com, magnus.damm@gmail.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Tue, Mar 12, 2024 at 9:38=E2=80=AFAM Pavel Machek <pavel@ucw.cz> wrote:
> > > > From: Rob Herring <robh@kernel.org>
> > > >
> > > > [ Upstream commit 91adecf911e5df78ea3e8f866e69db2c33416a5c ]
> > > >
> > > > The dtc interrupt_provider warning is off by default. Fix all the w=
arnings
> > > > so it can be enabled.
> > >
> > > We don't have that warning in 6.1 and likely won't enable it, so we
> > > should not need this.
> >
> > Still, this fixes issues in DTS that were not noticed before because
> > the checks were disabled.
>
> Is this patch known to fix user-visible behaviour?

None that I am aware of.

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

