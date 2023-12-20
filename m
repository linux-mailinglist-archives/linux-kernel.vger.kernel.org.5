Return-Path: <linux-kernel+bounces-6770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F7D819D46
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4127AB21938
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7651320DE6;
	Wed, 20 Dec 2023 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1gjLa+N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0120DC9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbd4a10735eso2286445276.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703069282; x=1703674082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMnhogAJ5TBsWqLBjRWdOEdn5tLvSkqIXkY34xtolk8=;
        b=C1gjLa+NaNYUuCqGThGARe5wDVLpxmw4fHIYY4HfKUNi6W8hrGhzUsyTM0o17Se6o3
         hPutrm+IpNdHz5oVDTT8TzmFo8VfSSMAUxfG8KakAKVoINqI4LUsdyH5Ff57szZFWEAb
         DmZFw72mDKroyVDYi85dTuN0xt99sLUWNNXvoRLMx/7+Fs6ZXUbwEaknPchbC+7dueQB
         fG8ShOvDKxJfae92jC+Ax5cdWf/CMJ+WSPJn4JRn7PfZsI0fpwLTtbkKj3whaHjm6TJh
         BKp8DyHV8fUlv3UJUKpA60uCA55h6SWoPmA2yqE5lxfWKSMsOJ4gxtgJAF0/DwsQ0mhW
         KoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703069282; x=1703674082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMnhogAJ5TBsWqLBjRWdOEdn5tLvSkqIXkY34xtolk8=;
        b=IRBn5dS4FQtlSZk7bRNCaXmufcquWMEz3CqP8fOwJ52TauM6bHY4TfFHBUQfluqs8K
         HvgCRKlsJ3nNDwTsBSVobDYdzd9XNdqBedVpAzZCwnLEyXYz5azENL4IxSwYvvlJUzd9
         iO+duM7IBhlkv/qKMFwrdsmmgrrMcccEDANVmyBcpYJG5IrsrQyat6Ez8SzzX9RUXpAa
         hL1TGpqhfn1b6UFiGw9bhXWn6eddZ+dlYzr8iBZMpRRfC2Fuk7EyReXakGnwkxGF4AoU
         bJNTnpW+t5hgxo4XcS913A4QEzUXA/hhEeZhNehr9skquWRFNKFd5BfdXiPqJHawws/g
         3GrA==
X-Gm-Message-State: AOJu0Yy7lHRjAuE1OZ7wmCPl1Jqxq5pGIkm+2hpaCetzfk+WkTaakeKz
	K0VMMxLiOgNXv0guogym3dNCZkvpeRLJ2G4AOlFYYQ==
X-Google-Smtp-Source: AGHT+IGYRq8+DNsxwVIrAOVvUPSQcI4YnkGr/ON41SKcXrqS0crfkla2Ki2q/G3D/M1BL/nW1R8hhvgf5T+fUsYD0nM=
X-Received: by 2002:a25:4155:0:b0:dbc:df05:9157 with SMTP id
 o82-20020a254155000000b00dbcdf059157mr6525037yba.69.1703069282394; Wed, 20
 Dec 2023 02:48:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130172834.12653-1-johan+linaro@kernel.org> <ZYG-Fr9FfIQUup_r@hovoldconsulting.com>
In-Reply-To: <ZYG-Fr9FfIQUup_r@hovoldconsulting.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Dec 2023 11:47:50 +0100
Message-ID: <CACRpkdb8ObMaMT+kuvs85QydbeqbChsMEnGTkW27C5iOGLuEww@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,pmic-mpp: clean up example
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 5:00=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:

> Hi Linus,
>
> On Thu, Nov 30, 2023 at 06:28:34PM +0100, Johan Hovold wrote:
> > The Multi-Purpose Pin controller block is part of an SPMI PMIC (which i=
n
> > turns sits on an SPMI bus) and uses a single value for the register
> > property that corresponds to its base address.
> >
> > Clean up the example by adding a parent PMIC node with proper
> > '#address-cells' and '#size-cells' properties, dropping the incorrect
> > second register value, adding some newline separators and increasing th=
e
> > indentation to four spaces.
> >
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>
> Can you pick this one up for 6.8?

OK, patch applied!

Yours,
Linus Walleij

