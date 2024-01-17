Return-Path: <linux-kernel+bounces-29438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52694830E42
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E5C1C216BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01C22511E;
	Wed, 17 Jan 2024 20:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRoZAeaX"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BF925540;
	Wed, 17 Jan 2024 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524760; cv=none; b=XOB3dbZQFxQnwIXieOtg+tqtcAvmxRjpz4x24OYLsOcDMZWNCSGv/8rRDcb32qHs8kOR4KgtavgbKFZAR0EuGZA4cXdPc2K9KJ2yS55OYG9DA5f2JAE2Vpk0DbbJ5pueujTLLb4FIJFavOJ+1vQtFyX8GgnMqjjV+lkC0UJpW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524760; c=relaxed/simple;
	bh=6bfMGEeSHTd0Kja+faLLkq2SnZ/etT47sRwohLN8FZo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ZHqPC7Xd14zyeSmTkT53rsrZenY1LiMvPzQpD7kOWO/3IdICvdM6eSButj8HhiWhzTbQkHUkoQhM/JSbxOxPR1mPdNjlzhbVB96eKSqm4mXvkA35/q22QEZE3JKFvzD9gzxN+f3d2ibHoeBhQCQz+L5AMPj4PvqkKk/wL82Z1aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRoZAeaX; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e766937ddso13152452e87.3;
        Wed, 17 Jan 2024 12:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705524756; x=1706129556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0+WY0tNWGa27ERQy4ZG2EkS39nDYHw+ks1/5FPGHiM=;
        b=JRoZAeaXucoHvG470rGnH37DLeyoC/TZLX/mw1qeGP7Qk9PljeIUEtj6BBq5r658Mf
         kXzfmL6ex70yu+2qswqJwyxXRl5yFYjynFCvvV+k1rfEzrwDq4LCHZUN2nbj5yZw4P6A
         dGeMT3a0DewW7LmC4LyCfoHBhBG3o2gM1rFEbvPhSPJaDElgg34sj8eVbaiGypCC//4y
         NFRaWzIGrxheiTkXUjHMc5Evqq3DGjkG+0NtDWkgnJs0xKTGjRI1rkoG6nHV0vt9eQ+n
         r/p9VcJwAJ+1bNeH/wQoFKGSYxwsUIIBV9aTt2/MP++PRreBz3zegw8AcOWWT/yXIyLo
         qxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705524756; x=1706129556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0+WY0tNWGa27ERQy4ZG2EkS39nDYHw+ks1/5FPGHiM=;
        b=FQelNuismrK0ow7O78IEeyqdmIiFi0sYWQeuTIrxtcekPI10sSeE8EYPIHogpLNaR9
         l9wdOehYC7Uj9gYO6uXdij6ETYNIgoyBG1r7o0QBg1FrzB4oaaU4EyTDUb/HAX6w9j00
         rI6m3viM6Y1Z0UEiKTvBy7dMubI3vC1rdB6rqUC1zbb3FV2f0TPB1YKVhFqm8ztqy4n6
         QZogPNYJTYwSHBpj8GFgglCowqwixB7HkPdmVcKDsesclv1R542UQId3Nqs8+Xvb0mLB
         k153AjFt/6GcFlo09XzOnS4Gg5CsNygaLdCrp1BA2sZCmjUwNWf3fnr/9/ZIASwQgXt9
         /b5A==
X-Gm-Message-State: AOJu0YydveNj34njDtWPTw/5KSN/JxRhRLJK9hX+m2b5Ac+MIUv8waZZ
	+BJ3Mvnyi9htfl6tNPYIhEHrRBcwEthEn8iJ4IxLJiYvO5g=
X-Google-Smtp-Source: AGHT+IERGCKjG90zqKMcjx5QoH1qXDA27BquNlg87yXazeyy+nk3QMPVJtsKoa8fI01vr4f95N6nyLncVo4M0d+ULIY=
X-Received: by 2002:a05:6512:130c:b0:50e:e557:f1c4 with SMTP id
 x12-20020a056512130c00b0050ee557f1c4mr4760993lfu.0.1705524756375; Wed, 17 Jan
 2024 12:52:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117083251.53868-1-hector.palacios@digi.com> <20240117083251.53868-2-hector.palacios@digi.com>
In-Reply-To: <20240117083251.53868-2-hector.palacios@digi.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 17 Jan 2024 22:51:59 +0200
Message-ID: <CAHp75Vci=1nAvxRcbkK2SxGWGbQVbzQMTycMt8tZ5snPRTYXOg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] gpio: vf610: add support to DT 'ngpios' property
To: Hector Palacios <hector.palacios@digi.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, andy@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 10:35=E2=80=AFAM Hector Palacios
<hector.palacios@digi.com> wrote:
>
> Some SoCs, such as i.MX93, don't have all 32 pins available
> per port. Allow optional generic 'ngpios' property to be
> specified from the device tree and default to
> VF610_GPIO_PER_PORT (32) if the property does not exist.

..

> +       ret =3D device_property_read_u32(dev, "ngpios", &ngpios);
> +       if (ret || ngpios > VF610_GPIO_PER_PORT)
> +               gc->ngpio =3D VF610_GPIO_PER_PORT;
> +       else
> +               gc->ngpio =3D (u16)ngpios;

This property is being read by the GPIOLIB core. Why do you need to repeat =
this?

--=20
With Best Regards,
Andy Shevchenko

