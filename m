Return-Path: <linux-kernel+bounces-77896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E1C860BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C23B23F82
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B529171AF;
	Fri, 23 Feb 2024 08:08:37 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC013AED;
	Fri, 23 Feb 2024 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675716; cv=none; b=fiUItgz1Y1CdTBwWAVBQXVuFU44HIJH8yuxvrh/mnpRA4jxbD3rb8IQmkNEQNvTI/fma/JryGQ7eg2wsF6dnFYZ9vt6L13xrXrAae/XKqiUUdKM4rPGLg4mcV4Rxk1XukqAzxWneHQ4Yw2AQ/2Aa4fKNSk0o4tUM8KqqXy93PP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675716; c=relaxed/simple;
	bh=Rz28wYgoSpsKAyFBcJDZyQc1gFag+mvoupllta/Jr40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOFJq0jwvCS25x6nPjASpUtbrVOzeRnnAdd3EUDjgM1nd/q2IKrDFb4iF5mqToLOP/GAekJgXyqnVfe5OUxQ8IjR4FSYGKHZjsj0f0cG4lA96750RjiUr8qMTUstP1IVs7FlQEhWUyr+KnHgYkjINtn+ZpkerybQ2C8bET7g3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-607dec82853so5972737b3.3;
        Fri, 23 Feb 2024 00:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708675713; x=1709280513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INIyfDHyOicWkDztRW/3AycS6eR5SQWflf4b/ECXErk=;
        b=b0cBBaAnWGuOtIZZHgABwc/Mj2VQQFJORv/Xq7zjWwQURH5b1vixKUEOH01FeEDjVu
         c7Qg+HsQ85BX1HJs+qKVLbBrgaXLfiQbs12N1pVFfOhMGRhqIn5uWceu4JCJnj9xrCGH
         QivXtYVc0DXG4FNMAWFUXX4lx1ktofyYGPKDz3kignnUam5JyQlQaLfeH66izRyvFHfd
         c18gBLJQrB5JSkqEEr2NSulBKDNjhLJY3CXjE2HQFdl3mUfNct6fF/5cEtFLfDQ3LpOS
         HFB74u3GYkRw1Elak4WLJH7L8bt+OvgX+hzQc3YwW8GPEakds2XO2y63YKaBHWqiXJDu
         8UBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbr5vCz+knaLbtLKC2LJNTQwLLDjBDaS3ZTW3dwAEe5RWKZuoIpICNaA04ZT4iZuol3EPPZ1PFDrkQqZwbQPS9sQ11l/yp57YGqP0k8GrQuvILq3rBE4O7NSjm00mi0CuskK6TjA43Bg==
X-Gm-Message-State: AOJu0Ywjf3r79r/R/TnAxHb8P4WsvHbsep2GddXmPVVzXWR0oUNRw6Xp
	UtzyKW4Uru4MlaYvGWhznGcObzdyRN1iW/vqd8gZb2fIag4fOVQw2zfnljOOJK8=
X-Google-Smtp-Source: AGHT+IEWxzDCPUa35ZssHAaEPGxf/Vrz7pOx799c55iSCuo38kBPeXlHyoSAeyjz3UCDXHgHt3h2hQ==
X-Received: by 2002:a81:6c56:0:b0:608:aecb:1a66 with SMTP id h83-20020a816c56000000b00608aecb1a66mr1391855ywc.20.1708675713433;
        Fri, 23 Feb 2024 00:08:33 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id t4-20020a815f04000000b00607b37e2c74sm3495910ywb.118.2024.02.23.00.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 00:08:32 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-607dec82853so5972427b3.3;
        Fri, 23 Feb 2024 00:08:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9/A+3rgiwIfrR5mSIEVVSaw1+yjZoOKq4zFm7h3lh2mE+FBkaoA7B6H5K3kxm9bRDWwvT9KVAh4CJoJ1OSnAnv76fDlucdNgmOzxPb1Y1kMXJpjSuvtb7i/4sKVSB8ExjaGmDVCVeBw==
X-Received: by 2002:a25:ac46:0:b0:dc6:8534:bb06 with SMTP id
 r6-20020a25ac46000000b00dc68534bb06mr1490602ybd.17.1708675712685; Fri, 23 Feb
 2024 00:08:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-b4-bus-v1-0-2803c3ac4673@outlook.com> <20240223-b4-bus-v1-2-2803c3ac4673@outlook.com>
In-Reply-To: <20240223-b4-bus-v1-2-2803c3ac4673@outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Feb 2024 09:08:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVX6s9At21wGVO0Z6fY=gYkw9dooo0WsCorbrkoqBkehQ@mail.gmail.com>
Message-ID: <CAMuHMdVX6s9At21wGVO0Z6fY=gYkw9dooo0WsCorbrkoqBkehQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: bus: simple-pm-bus: Get and deassert resets exclusively
To: forbidden405@outlook.com
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Fri, Feb 23, 2024 at 4:49=E2=80=AFAM Yang Xiwen via B4 Relay
<devnull+forbidden405.outlook.com@kernel.org> wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
>
> Simple Power-Managed bus controller may need functional reset(s)
> to be deasserted before child devices connected to the bus can be
> accessed.  Get the reset(s) as an array and assert/deassert the
> reset(s) when the bus is being power managed.
>
> One example is that HiSilicon USB2 INNO PHY test bus needs to deassert
> the reset to the bus before accessing its registers.
>
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Thanks for your patch!

> --- a/drivers/bus/simple-pm-bus.c
> +++ b/drivers/bus/simple-pm-bus.c
> @@ -62,6 +64,10 @@ static int simple_pm_bus_probe(struct platform_device =
*pdev)
>         if (bus->num_clks < 0)
>                 return dev_err_probe(&pdev->dev, bus->num_clks, "failed t=
o get clocks\n");
>
> +       bus->rsts =3D devm_reset_control_array_get(dev, false, true);

Please use the devm_reset_control_array_get_optional_exclusive()
wrapper.

> +       if (IS_ERR(bus->rsts))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(bus->rsts), "fai=
led to get resets\n");
> +
>         dev_set_drvdata(&pdev->dev, bus);
>
>         dev_dbg(&pdev->dev, "%s\n", __func__);

The rest LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

