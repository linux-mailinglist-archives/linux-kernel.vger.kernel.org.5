Return-Path: <linux-kernel+bounces-158924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9141C8B26C4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BC21F22DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D1614D6EF;
	Thu, 25 Apr 2024 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XthInoz8"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94DF513
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714063538; cv=none; b=JLlF89ZnydNsaU4qQvyU53v/wZEiTeii6t+AQyUU8sd4fAsl1sD8Rh0IBoC5mYDk6EBE2wlUBJzB2X2gbn8zZJ7fGyXxQPDtre4vYjfdi2KVgANqpVliJaxQr7uM8mJBdWQRHashYDkurLsNxWPlzA9h5OmIsmH3OeNdG7HdTIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714063538; c=relaxed/simple;
	bh=Amc/VhCaPuRfNE4c/UsFD95U+kTr2gWqvp2bPp82p24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inM2mQhBvl0+9hNU/YVjk3WOATujft2/9+GcJ2X48lNuopqfEPC9/xz/ymvwEtfuFlvfA3HtUkUAO0Oa3poSVppXkQidvyn0t1R38+h96QoeK81F77hSrNyJXi0rLFRTAKekGLLoXU5Qn1aBNE48svuoghJT5UQ1Xl83FuHtIj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XthInoz8; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de46b113a5dso1341040276.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714063534; x=1714668334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWQqHUbAAiSySnIsemSx25Y73dqsXlz6lqamDtL75KQ=;
        b=XthInoz889q19LIYnd4dxHxjC10noyEEpacYxXANDNN8IDP5XeQXBOtc65TCU7iY9C
         ZFOdnN9B5DejP/TG0tddktvVu7n9LlH+yFRdVgQBLRcErJF6YaI0HGu5Hyb1hNuQ7Z2W
         zyZHNFFLmYZH+kKRw2NvM6mfnPh4HZF0CRgpoPKlyIc/96vPx/wKcxHdrhxkwVai5X57
         8XAmABXiGn+yK2oLWmsr1cWTlYVngSOKUkZll41jNiQRJFxtd2Nj6FZo5k/NA6Eo3sRa
         LII7x5cyW0/5XOb94tM3OWqlC156LUHRKoUZDUbXRQvkRkYacPFUL4l6hEefmDw4m41V
         eupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714063534; x=1714668334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWQqHUbAAiSySnIsemSx25Y73dqsXlz6lqamDtL75KQ=;
        b=lm6SvF/DljsU044h51sXmhXeYyw+J3iQDtttYwN0p1V9tj3Iw3q9Wv4+e1sGUn7o0E
         M/AGC+ozIt2oArk6BsSiKI9F9WXmeUrv/ltTtdzzbiZYc4Kgg+/7opkw8lG51lBiE0kx
         sK+YS1xzvcxCgpzgRYpauccT7v5mvEWzJs7nGmFie0X4OEMf2A+nXoPONUoJCr23/n2R
         X3FgFBLBTorjDpoD5MZiQfdB95YGd4HN0gPHsmiL6ZY4v1aaNrog6GYPB8OdWFVIXFI7
         zWAXq6e+tSsIqceTDYa2qiHMFKijvk8qzxYgbkTajYhWS2642hSiW/MTd5UxLuv0h3GX
         vGSw==
X-Forwarded-Encrypted: i=1; AJvYcCU9eqGonN2Q9AtpFogWYh9SFSZaaMaQoW9nuSkcNqNCx3Ju7f3qAJd6jwjIW4RwK53cvHC9l8FL0rAccM7AA4Np2NoiH66B5THz8+k8
X-Gm-Message-State: AOJu0YxsZ5G5LaFU8uFoV8ZpJkgmFbFOHsW5clHQ9jjSHFTrffvOSvL6
	94FCIr4oSPoEjWf3lZxWdKnKj6YF3cOeo00JC7ud13grrzn/TRlWti4ALVJb7wfMPy8GUrAzOWj
	tovJta7L3bmIviF12GiLQ4RFutqJTb7OKavpx7A==
X-Google-Smtp-Source: AGHT+IE6E0yGMivLHEIzi4cVQrlqrcgIk/WXjie4Wzsi6F0u2PMmSvmweB2JnuzBk12npMsW/6HfizfFtt+TW3hNbCM=
X-Received: by 2002:a25:fc11:0:b0:de5:5706:b955 with SMTP id
 v17-20020a25fc11000000b00de55706b955mr243062ybd.4.1714063534487; Thu, 25 Apr
 2024 09:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com> <CAMuHMdXHhsdOgTiDdqMwAMvb-m_VBqOcTRPURx_upc2AtmBTfA@mail.gmail.com>
In-Reply-To: <CAMuHMdXHhsdOgTiDdqMwAMvb-m_VBqOcTRPURx_upc2AtmBTfA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Apr 2024 18:44:58 +0200
Message-ID: <CAPDyKFrhPjuOR5iC+zy+SCJv5yoWU0fX8FfDbt9nrM6VRCjmNw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] clk: renesas: rzg2l: Add support for power domains
To: Geert Uytterhoeven <geert@linux-m68k.org>, Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 at 16:34, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Ulf,
>
> On Mon, Apr 22, 2024 at 12:54=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.de=
v> wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Series adds support for power domains on rzg2l driver.
> >
> > RZ/G2L kind of devices support a functionality called MSTOP (module
> > stop/standby). According to hardware manual the module could be switch
> > to standby after its clocks are disabled. The reverse order of operatio=
n
> > should be done when enabling a module (get the module out of standby,
> > enable its clocks etc).
> >
> > In [1] the MSTOP settings were implemented by adding code in driver
> > to attach the MSTOP state to the IP clocks. But it has been proposed
> > to implement it as power domain. The result is this series.
> >
> > The DT bindings were updated with power domain IDs (plain integers
> > that matches the DT with driver data structures). The current DT
> > bindings were updated with module IDs for the modules listed in tables
> > with name "Registers for Module Standby Mode" (see HW manual) exception
> > being RZ/G3S where, due to the power down functionality, the DDR,
> > TZCDDR, OTFDE_DDR were also added.
> >
> > Domain IDs were added to all SoC specific bindings.
> >
> > Thank you,
> > Claudiu Beznea
> >
> > Changes in v4:
> > - dropped the pwrdn functionality until it is better understanded
> > - dropped patch "clk: renesas: rzg2l-cpg: Add suspend/resume
> >   support for power domains" from v3; this will be replaced
> >   by propertly calling device_set_wakup_path() in serial console
> >   driver
> > - instantiated the watchdog domain in r8a08g045 clock driver; this
> >   allow applying r9a08g045 clock patch w/o affecting watchdog and later=
,
> >   after all good with watchdog patches series at [2], only patch
> >   "arm64: dts: renesas: r9a08g045: Update #power-domain-cells =3D <1>"
> >   will need to be applied
>
> Are you happy with this series?  I would like to queue patches 1-7 in
> renesas-clk for v6.10 (i.e. this week).

Yes, the series looks good to me! For the series, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

