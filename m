Return-Path: <linux-kernel+bounces-68729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D51F857F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B63371F27EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BD712CD81;
	Fri, 16 Feb 2024 14:17:23 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EF812AAD9;
	Fri, 16 Feb 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708093043; cv=none; b=Bte5FLNe0WjHV0sKXnP5AKZmsZffr1oeLNjREMRX1F4NGZZkPIRTfU2abhnuH5eTg0isLlJOw8ii5rniG/pkZOKKgY+CC2kXMB2227ERHQWCaFn8/uFu9/qC1G5UI6pCAqcZJg6/h/b24eNrT3tjSNoWdjGsD0gG/H0yTksAVDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708093043; c=relaxed/simple;
	bh=vnnX13x217W0dtrq5eN5tm48xaIUCso8yaskfIG6//g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W79VJdn/iB8pakyAtprWru0PHG478E+tbQyFgpqwPprOnUt9BNtTwX3EdQLiNt1D25q/k1YNckhphlwfiMxrBKAdQv9HYdvgfzgmPnmJYeFv83sZE+H6bEKYSfuB8/0kP+LV1gf80jr6CW0J+7dobVaFfIc807GWLIdm+3HEXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so1750265276.0;
        Fri, 16 Feb 2024 06:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708093040; x=1708697840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKVA6eT9vMZObsICtCU8wuFH8FzY1FdTCqpK118q1IE=;
        b=jeiZubz0wHT7KtCwHje/dmKYMH4ygfyWQ2hf4Y5ugqJkknctK9roCmReGGcybJHxKf
         nxotCHVm0sUXogIzn4LMQ1TcIDohvGSzIdzavLe5StFUJTAsVD8DDjjW9rG5w//3b5NX
         VsvXPtLFQBop/nk4X1xU1VqPlhvj7MdJFGs71Ygsn2QvuydiHdZqSt5VixuKobEFbyWw
         PHxdS3rGYnFAGvtbVP+cCgaQMxkFLq2kPB0K59JyGVo0RftrIero+68w2ytV0AjtD88n
         Echo95Gqx/UHAmoANz6YSFqOyGYs7jtP0u7VokijH3Rt3cFwTyb49vgEnG+eISC6p84S
         kV4g==
X-Forwarded-Encrypted: i=1; AJvYcCVggaW4V9dOKZs7Ytf/+SOuZzD8TKnLNZZYTPJ3bYCWmEiVNkyqUy6shGYXYKkpsTawIMM6Vmsyw38yFkEroAC+Rw7bTEyqffLiW9DLAds6fEv+VmNSClnNXHkxDd5mO6q0GP+5sm9akSZNqii1Of3UO81qct0OeeEnCpgDh/5JFcUjduL1CzQ1BoR+nXpCx5cfOyc8lMG5e86yQB44tgAWHK+zASVs
X-Gm-Message-State: AOJu0YwUUHFRu7DxLoCUAgJF+AcpXrJjCa9Y6+AYX8SaJoGXFrzX0RvV
	Gc+VF5H22NGnYfYr6HFM0pPsCy0DoaBNOudmiv5E7LtePRdyxWWrwM459RbMo5k=
X-Google-Smtp-Source: AGHT+IG/Oru5dUhXk6y8B8iKzzYWbDCIUS8FnmkleBuV6MuMOU6dv7iExXsIBfeg9P1hSsSVNMwHHQ==
X-Received: by 2002:a25:b048:0:b0:dc7:4859:6f1 with SMTP id e8-20020a25b048000000b00dc7485906f1mr4901047ybj.33.1708093040325;
        Fri, 16 Feb 2024 06:17:20 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 4-20020a250104000000b00dc7496891f1sm330044ybb.54.2024.02.16.06.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:17:20 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so2237243276.1;
        Fri, 16 Feb 2024 06:17:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAZMpm5+ECPyUxMHqTOGgVvRP0Y/+Gj7KVNwTNrSke0AancPmMddxySziL+Km1qNsCVzX/l4loxRRt8mEakFhaBBLvEI/FjpGRwcymEU1rcQrjIROrppsn73VbCdt3dpBfAfNKb/e5QPx3/Sa/9QaobjrSvyIuHJasp3xf/Io69zMXMIPpDP1KtsgJeZ4ZQthQeiYxZaZbF5E0Uqdd5Td+Xq0c7E1F
X-Received: by 2002:a25:b904:0:b0:dc7:8c3a:4e42 with SMTP id
 x4-20020a25b904000000b00dc78c3a4e42mr4580893ybj.30.1708093039976; Fri, 16 Feb
 2024 06:17:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-13-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-13-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:17:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX3=KJ6=qOW__KxWisj7Fguwr=SdP7XGvFD+BKgZbRo9A@mail.gmail.com>
Message-ID: <CAMuHMdX3=KJ6=qOW__KxWisj7Fguwr=SdP7XGvFD+BKgZbRo9A@mail.gmail.com>
Subject: Re: [PATCH 12/17] arm64: dts: renesas: rzg3s-smarc-som: Guard the
 ethernet IRQ GPIOs with proper flags
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 8, 2024 at 1:44=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Ethernet IRQ GPIOs are marked as gpio-hog. Thus, these GPIOs are requeste=
d
> at probe w/o considering if there are other peripherals that needs them.
> The Ethernet IRQ GPIOs are shared w/ SDHI2. Selection b/w Ethernet and
> SDHI2 is done through a hardware switch. To avoid scenarios where one wan=
ts
> to boot with SDHI2 support and some SDHI pins are not propertly configure=
d
> because of gpio-hog guard Ethernet IRQ GPIO with proper build flag.
>
> Fixes: 932ff0c802c6 ("arm64: dts: renesas: rzg3s-smarc-som: Enable the Et=
hernet interfaces")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch! (which was well-hidden between non-fixes ;-)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.9.

As Ethernet is enabled by default, I think there is no need to fast-track
this for v6.8.

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

