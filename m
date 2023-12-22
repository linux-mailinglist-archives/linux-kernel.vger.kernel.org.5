Return-Path: <linux-kernel+bounces-9991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAD181CE37
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A21B21A15
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEA728E0A;
	Fri, 22 Dec 2023 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWCDRfnG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2AD28DDF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-db99bad7745so2042001276.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703267943; x=1703872743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXO5LLAj4QYxQv9ZV22GFZ8aR0i5IaDWjNJqzoS+Cu0=;
        b=IWCDRfnGHAQI/ws9Sv/cnQ4kxPhM8LA+mYyOMnTw6RPTWt0EJ2fHMub6XvTJwEKZK5
         4QJt3K73GS2qwgu3NshjdY8h5AKpaHy4owVd+TECP33AWQVRyiQQUD9ibtRy8wEW+10y
         ZLxFb0WB0bRuiQReYe/M/yxlTiQMOgTGR+gK0o0/y14uTSTMVOi4hkCqYwRftu0uao2h
         gfDpTWYmDwZgOAcbpj1cTGkjG92lQKlZxWpLkvILBQkSdo7SxA0u5+yfxmC68La9ssud
         F9sYklpvgMoW/6A6AXEaeJ6NxymLvVxEI/hgW245lM5bbt48b/JG6ZGbbcmhcDyhplXo
         Dk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703267943; x=1703872743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXO5LLAj4QYxQv9ZV22GFZ8aR0i5IaDWjNJqzoS+Cu0=;
        b=jWsL4kxoiNleQESaQuoZQJO0JKHyxA2Q1OeKqoK/Pe1PLtzq7REzWscEw5M8wbOrVM
         LHVHfWubCVeKoiX08fi1OOilnPzVtsqQyhRcBLP0Bq39Vq2rJUCNqK9pUlFs8ZtBwRkA
         rmGXN3/ncfVDVPXKX6WDYPIq74bDeLKKI8xhBanIkSxmS0rMjkDR99Tl6UDFKLU7DV1N
         Yo2gzBgNwlUChNF1i3aIc9ifuKTTmZfLikBuctI1NXyd2lfc6XKpardck7pytY3Qon8G
         GaGHPqtdElOis57QpSORxCXT63P9fxNzUyZWYr2Kq2Qx/iia2GJ0M7NIR+NXupEMn9+i
         XRjw==
X-Gm-Message-State: AOJu0YwU1/V9mQMOvdFnXKKeevsHdETUDbNlQRFh0BPar7sHdjNlGyLc
	gzUSwL+gs0AfDopbkMN8QKIIQOYFB32g8q1pCoJ9j57Mxt0LAQ==
X-Google-Smtp-Source: AGHT+IFFvH5JIWmYxJbv9X2zBhzWMzPFLRuyOvj2wSlxJlPI+Sw5EQ6vaJ8v7l8wEiYlQw5zy6yOt1W4FquIjX/y+EY=
X-Received: by 2002:a25:d606:0:b0:dbd:d3a8:74c with SMTP id
 n6-20020a25d606000000b00dbdd3a8074cmr1266996ybg.48.1703267943739; Fri, 22 Dec
 2023 09:59:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
In-Reply-To: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Dec 2023 18:58:53 +0100
Message-ID: <CACRpkdZEu5AcdPtaH7MQSC88+CT-PhgegEVcWk6KAzAipzasPw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Add Pinctrl driver for Starfive JH8100 SoC
To: Alex Soo <yuklin.soo@starfivetech.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Hal Feng <hal.feng@starfivetech.com>, 
	Ley Foon Tan <leyfoon.tan@starfivetech.com>, 
	Jianlong Huang <jianlong.huang@starfivetech.com>, Emil Renner Berthing <kernel@esmil.dk>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Drew Fustini <drew@beagleboard.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

thanks for your patch!

On Thu, Dec 21, 2023 at 9:36=E2=80=AFAM Alex Soo <yuklin.soo@starfivetech.c=
om> wrote:

>   pinctrl: starfive: jh8100: add pinctrl driver for sys_east domain
>   pinctrl: starfive: jh8100: add pinctrl driver for sys_west domain
>   pinctrl: starfive: jh8100: add pinctrl driver for sys_gmac domain
>   pinctrl: starfive: jh8100: add pinctrl driver for AON domain

To my eye it looks like a lot of code is duplicated between the four subdri=
vers.

The pattern from other pin controllers is to create a file with all the com=
mon
code and then subdrivers for each sub-pincontroller that have their own
probe but calls into the library.

C.f.
drivers/pinctrl/qcom/pinctrl-apq8064.c:

static int apq8064_pinctrl_probe(struct platform_device *pdev)
{
        return msm_pinctrl_probe(pdev, &apq8064_pinctrl);
}

And that function is in drivers/pinctrl/qcom/pinctrl-msm.c
and you find great inspiration in the qcom Kconfig and Makefile
and drivers/pinctrl/qcom/pinctrl-msm.h
that you can copypaste to pull this off.

Maybe you should start with a patch that extract the common stuff
from the existing jh7100/jh7110 drivers and then reuse that for
jh8100?

Yours,
Linus Walleij

