Return-Path: <linux-kernel+bounces-61664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB16F85151E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6491C20B88
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319EB3C694;
	Mon, 12 Feb 2024 13:16:02 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62363A29F;
	Mon, 12 Feb 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707743761; cv=none; b=ExDrpuhKr81DzckrDv4+/rwnXu1njbYbVMQnZ4qY1r0+Bp4LiFzKQ/BT/vtShVIU90tX9DPBWG552e4qDR3IQuWNWnLFZ454F2Ap9w4l4A9W6lqQ4REwsQJJNhtpmIr7Lpd5vDhglwlA6KMdaIDHKyygcRFaG7KMcKB+31O3850=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707743761; c=relaxed/simple;
	bh=wNFER30P7HRx3KcFeLKALdmu6PIl8HGTdiww01jnsLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJnS+teShFvr1nl6VR7AZPZ2RGHBcsiWuTMl9pVQjUWwMvOCla3fvuleHqN/S0G5b+jTlkth2D1FCQllhEtxeHTRgHijyENzM80Gb9qYLsc167RSZ3tSL+3O8sGoKy4tkickJYolY/ZcaY9D/NOFs0sQ8bd0Z2Yu987eWL3u3xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-604baa35597so27591767b3.2;
        Mon, 12 Feb 2024 05:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707743758; x=1708348558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJUpTrNy5seEjm0aaNpkRaFyvuGbRn8hnbhOiviF6xs=;
        b=q7CoK4cwWSt7QAXvXyL1mVQFZdS9IKuk44PxaejhiDGFhnOQeYjRe/3ZptdvVZMuyV
         ckMPiW4y/Y6X6hIuKDQzIy83JtUR6Yk1KhctfSDN3lmeCmPkhbUqL9dcKrDC5HxAhRYS
         WHLSjyLUcq9FIcDx0p26+Lji98Cs9whdTzR4xLRgdhq6/gfmE08DWYJJ8u5YDPmyFfUX
         LslAfNgn5Y/Uk+Gm1CuvNqle2vWCUgFY1jv8nGWJ7uwH2dySg2f46atAPd5kEpUOZUf7
         RD/kA2rNYMJsNHaTH5SyXjZHzwD1i9q3ZfG7eAfqdZI/fbckkUIpDiIcMrDR7xoSYO4k
         7u/g==
X-Gm-Message-State: AOJu0YwWR1BiTvjN7P5L7AwEW8oclWivKn+n659T8WTalU+cRiraYJ3M
	7BiahH1XvMmOUaYHJNbcGfIJ7YVKP9Q6Eyoc7spXcm8KbvhrjVxKwPQ5B3E3DVA=
X-Google-Smtp-Source: AGHT+IHWhM9EZDGkGJQUlGLg2RUwO1RGzd4Tl7EzgDLOJrHQ3KhWSSYh0cTlkynzJPwewKnfDMWSeg==
X-Received: by 2002:a81:a0d2:0:b0:604:3f64:48e1 with SMTP id x201-20020a81a0d2000000b006043f6448e1mr5489214ywg.5.1707743757714;
        Mon, 12 Feb 2024 05:15:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVbgF2B+m3xJQuYOiAWdSnJGDyMFneqw4stYRiD8OfT7fQMono0n8WQYv9kB32as8gbrlPbEVKUgvi6mH60Y7uRM2mTTxGmI/HL0uoHrdgHPd6zbEqMVhkaQJH0x/0uu6B1LMOO5AcYYg==
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id n13-20020a819e4d000000b0060076613cbesm1132986ywj.86.2024.02.12.05.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:15:57 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso3158560276.3;
        Mon, 12 Feb 2024 05:15:57 -0800 (PST)
X-Received: by 2002:a05:6902:2083:b0:dc6:c510:df6b with SMTP id
 di3-20020a056902208300b00dc6c510df6bmr6687796ybb.55.1707743757045; Mon, 12
 Feb 2024 05:15:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129135840.28988-1-wsa+renesas@sang-engineering.com> <ZcZhHWn3QrouRigo@shikoro>
In-Reply-To: <ZcZhHWn3QrouRigo@shikoro>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 14:15:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV5bmmZ0A4F-gPJOAhF=u_fxBbUJa8N_uDa+ft+V8XqTg@mail.gmail.com>
Message-ID: <CAMuHMdV5bmmZ0A4F-gPJOAhF=u_fxBbUJa8N_uDa+ft+V8XqTg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: ulcb-kf: add regulators for PCIe ch1
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:30=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> On Mon, Jan 29, 2024 at 02:58:40PM +0100, Wolfram Sang wrote:
> > Without them, no power, so cards do not get recognized.
> >
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Can we have this one in 6.9, please?

Thanks, will queue in renesas-devel for v6.9.

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

