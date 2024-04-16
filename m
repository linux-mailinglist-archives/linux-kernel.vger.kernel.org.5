Return-Path: <linux-kernel+bounces-146696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 175A88A6979
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469281C20D83
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE494128834;
	Tue, 16 Apr 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDdcfcIP"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73E312838F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713266121; cv=none; b=TeIBnYtbNyykSlPrSHQLX+GyDm24EdCN5+VHXMLXImuI5m2lnuDZ6XgFrfUoy0/ciWQJtfhuaKwA6mAk8CCkDSSHPdvhsaAa6/7h/5ZbKDX0EtU5PX8509FCb6Zmm6YS6a2+oDylK6wtWH399d0Tp219WRNIte575foMBzbdSDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713266121; c=relaxed/simple;
	bh=XiI2sQm+xgSfhKnKvaKF+M2Gq/LxaifLpyx+4yhJKWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kL3eNGKeSGgkqfoctDKFgciSyPwae1pawfsBqWFDHGWoiisPNLhGOS0Hsm6WX6lX6wj3HVVTGUTHLFEmX15HY97GQl9EyphDA9oW1IfRifoE8zA83XFVIboA7BWq+PlS4jgX9qu96biw3EQN0HsYf7l1InxCSXR2V7raIstsZT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oDdcfcIP; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so4019346276.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713266119; x=1713870919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiI2sQm+xgSfhKnKvaKF+M2Gq/LxaifLpyx+4yhJKWw=;
        b=oDdcfcIPoC4WBs+whqfYyBlY0x5ZZ/qXGFvcFbjYvcs3HBloRNyQoQe3dofYBp2I82
         4b4w4WwrsMrUWc4Edabw9Y46DlA8vImh3mOEK4JgT86Mj6DA6b7Y6eDQzh7xeE2F0KlW
         mACutQ4VbkC4MvC9oC74yya/+0hBcYpeYWXEZdyMuiDXOecHeKIApqVKp7mLUADbppjs
         IWWw3H1Z+UtVnNKAQuCRYlZWKHcBySGUOPh5HGpj/7ZsUk1cc0zRoupG87C3z6ai1kAW
         hC81RNN76lxsS9OEJL2YA0q99l/MwWMbuvmLTUsYy7byETK19nGA1KHzka39KtEN1/kn
         GHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713266119; x=1713870919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiI2sQm+xgSfhKnKvaKF+M2Gq/LxaifLpyx+4yhJKWw=;
        b=kgEVPkkSw2DpggoW1pRbc9ysRE2adLv713soydNJ5dnso+9rNiBbtGigBaMF++ds9d
         1XgZhIk6jzIZB2diWgn7P4iVZvaWu4JsWeKbSHZuhGx9Me587il0O9nlt4JyLizwivYz
         Ix0cm5Sotya1KY3JeqxHn7J1qWYwrl7OVWI0qPiyb5c4F2BDcMgXC3ZH69+1ApkvWCjO
         TVB+rQZzeQfQbXe9LrwI9h9ny3DK1mQWi47dd1KIPHENDAKi9YGXwONCZAbLOROsijoz
         nY7zEwB/gSSMe8125aD0aTVOBqESPN5mzt6sYI87DqLti93SZ5L+LqqhHQLXpnNPQ/EB
         LaGw==
X-Forwarded-Encrypted: i=1; AJvYcCWOnp5UlISvNbaGxZ7O3GZwjxoZ3FzhC9kMAALcTWIzVqdehm3d8VuN3q/TjxR9Y6FMrmuZGTDukGqkOrOf0US2w3bvqGlaXRumkyHL
X-Gm-Message-State: AOJu0Yz8O+RcrxaSXJXkC2UtQA6Rob2K6gOQYZhgUEsBzw+ODYoUadai
	qonkHHBDpwEIqMIofsFcvS6SChQAP1oyo9aU6EiT00amRSM50an8bfEL80Tge6suLPTsjWEzyaq
	Dn2vMqaocCah3xwXuZPhIxLew7JAW4bD+yxPaJA==
X-Google-Smtp-Source: AGHT+IFZcV9W2tonTOuCnPPIlMQCywVg80sidWJREy/u9my2wBE3zF9bOxxG9UUMKBTpN9Mc+9RLCpcd7enrpeP10T4=
X-Received: by 2002:a25:ac05:0:b0:de3:ec93:d20a with SMTP id
 w5-20020a25ac05000000b00de3ec93d20amr3808409ybi.37.1713266118876; Tue, 16 Apr
 2024 04:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFr405qt58wrqNdSn8bQPRqPKJ1omUZHS_VpQrX5zxUJug@mail.gmail.com> <CAMuHMdXRwcYMt7p+xT3svo1RmJ2Tvbamrx4++iYQ-mffKb6ZQQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXRwcYMt7p+xT3svo1RmJ2Tvbamrx4++iYQ-mffKb6ZQQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 16 Apr 2024 13:14:43 +0200
Message-ID: <CAPDyKFoMiseXbSEK4ANOeWSuVhREibm0v0zg46Q3kJHX8jYpgQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] clk: renesas: rzg2l: Add support for power domains
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, geert+renesas@glider.be, 
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Apr 2024 at 09:28, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
>
> Hi Ulf,
>
> On Fri, Apr 12, 2024 at 1:31=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> > That said, maybe we should start separating and moving the
> > power-domain parts out from the clk directory into the pmdomain
> > directory instead, that should improve these situations!?
>
> The clk and pmdomain functions are tied rather closely together on
> Renesas SoCs, that's why the clock drivers are also pmdomain providers.
>

I understand, it's your call to make!

Anyway, I just wanted to help with reviews and to make sure genpd
providers get implemented in a nice and proper way.

Kind regards
Uffe

