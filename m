Return-Path: <linux-kernel+bounces-68710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93E1857ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 069A31C20EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5A112C816;
	Fri, 16 Feb 2024 14:09:58 +0000 (UTC)
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529AE12C532;
	Fri, 16 Feb 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092597; cv=none; b=EvWwJFTxlBGtk6RaVkNXM4omQVqwdFsWtZbXegLXVc4QyDzyAHUOUK70iU8xCvuET04PMEsE9cUraMrPVTSNISNC/txOjdGUKeKLRyei95OYKpBc6QreidilCyrTTdF8D+KMBK+CegD+GH5ciIDLGNg/1XQhxJojglm8N/ZB1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092597; c=relaxed/simple;
	bh=0fRSLn96eDY2/mnsvWdpsJ3KnGOSs7zmmOzDl42SWSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Blvi+UVIjhw1gBJV0IpShWPBFxlrSxZYGcX3rifVfBUWCo78653shOpL7wPDpsDjItOE49uzHemGrETv4V+54ZEb6JJGamL4y7r8j9qyYp2dDaVAJxzwon1kWsILR3JflcpIZY36KAX7jH9Z9W7rdigs1eGoAVvlK8mhCvkw/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-59612e4a21eso1093980eaf.3;
        Fri, 16 Feb 2024 06:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092594; x=1708697394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NDNaKP8xamgaizNNdZPhlOVzBU3MaVOfz2oJHdMsAk=;
        b=w1xgSdnRZcFi6wkZdtiCFl0B5Ex7QjwUuCwVdM+yDf3xiJj0lAE/Mg79WlmN9TNsWu
         iAC3VhRmSV5l0Ywv0VOX/5lUUwNO90G+ZfGvsq4u5VvPp1pXEsU8OABNvtBzyRlfGUDD
         ATWPVq1HrFNoSGn7cZQwE66QsuPKDsHwpJZ4ricvZqp5Tz7AgAl2JqZdqROVq+24Aaw6
         bX8RjPsOGwKMMGCndA880HEzULIGShZpaZN6ZmgQbA3CaD0oTbxtSWhOch+CztQlQNvk
         C/7EcQHmkeURsxUo25E+l1PPZZ8rAu6u9xsZe8Wriyt+TT9PVHOaWkVgyTVTUYbqF5iF
         M+5g==
X-Forwarded-Encrypted: i=1; AJvYcCUCW/e0dW+xYdOFoW1LyOksufhC9B30fkcfWnQByG9K/CH+/mvjUxkVs4NulC4sPc98Qv6LsM/b+Pn3xeDYVQx3qD6jzjO/edEm3a8a7UdAcO2h6Q1RxP1PzZKluznO11qtYNM+gHP2ZkgM7tCzJd0oB+4qwTAU/lm/snTZ02K+41dPDUpkz3tVWKVyFWjWsJIXthHSwH+mAK6Vu+KTc0H5grbgGpS/
X-Gm-Message-State: AOJu0YwsFEA52+plOzNepp7hmlEVo7Vm1l+YJ7puBAMBZ6j43Ya/WEr5
	3KK5rdwD75cWrgd0LDy/ybQDerlVbo4C4mxmxnkJT8M9ofGdJ2zrSniP5V3dVM4=
X-Google-Smtp-Source: AGHT+IFOn2bGzykLWX8J5Bo99gQ0vA9TXjTreCD05J3mY6zvtSR31lrW/83dvlmpgLEq3nveyQ65gQ==
X-Received: by 2002:a4a:3143:0:b0:59d:6f4e:2baf with SMTP id v3-20020a4a3143000000b0059d6f4e2bafmr5285933oog.3.1708092593940;
        Fri, 16 Feb 2024 06:09:53 -0800 (PST)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id b30-20020a4a341e000000b0059a1af7a9absm646068ooa.27.2024.02.16.06.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:09:53 -0800 (PST)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-59883168a83so1074029eaf.2;
        Fri, 16 Feb 2024 06:09:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBOJBNmWV1Kp04/ayj3ewsopJKlGrBE+2JN1r8s0tcefPXmZ9dJp5FXU/L+ZmikOC6osNULiGrHs+kY4Pl4IanLUdDC6N3LsWSti9QlW4ZdJSdi9PVj77whCsVd8xVad/QvxaycfqgKBZ79eePP6d8VrJ4yM4/MWL/H7lBxl5xw/sxfvrAbYaX3OOR2+9oIP6EmnLOClIecjWhekEgWomAf5wJ/3RL
X-Received: by 2002:a05:6358:5927:b0:17a:a774:93a3 with SMTP id
 g39-20020a056358592700b0017aa77493a3mr3591024rwf.15.1708092593037; Fri, 16
 Feb 2024 06:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-10-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-10-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:09:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXCyax=mfuTAnvh6LOXJSSdiy8N-wH8f+zTb+y_Fnxe_A@mail.gmail.com>
Message-ID: <CAMuHMdXCyax=mfuTAnvh6LOXJSSdiy8N-wH8f+zTb+y_Fnxe_A@mail.gmail.com>
Subject: Re: [PATCH 09/17] clk: renesas: r9a07g044: Add initial support for
 power domains
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 8, 2024 at 1:44=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Instantiate always-on power domain for R9A07G044 SoC. At the moment, all
> the IPs are part of this domain.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

As not all IPs are part of the always-on domain, I'd rather defer this
until all domains are handled in the driver.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

