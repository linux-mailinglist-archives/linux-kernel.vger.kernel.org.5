Return-Path: <linux-kernel+bounces-63173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB828852BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 383B6B2241C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81EF208CB;
	Tue, 13 Feb 2024 09:05:51 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB411C68E;
	Tue, 13 Feb 2024 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815151; cv=none; b=LJVwzXIS2+khxWPqZHXgfEb0tZ0v7F2FU3LI3ElmAOa+7LLcDVBUxpmSDxHNLtT2sQlPZtVbXWJ2JJWGWAAaAGBZDZKap44Ou9usQMk2EBPqbhAdxACuiM8xEGFNuNNiadYvtw5ONkmyODjwo3dEzB/6XPsNytcTY03Txr3XApA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815151; c=relaxed/simple;
	bh=FfFqrAXQmAjTt+8Bu5s9ZKzqV1A1ADlvxCsN+bbef9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPaye+IBbyXgZ08VhGs5KRtGgiqHq010A0bRJ4RRmcSu9DQNK6sBWgeFCsmye5gkTyzGzt784FrA3oiLTYVOuPVTOq9a5K4MGHeLdQuiYK7YEEjwWRNb9nCWK4sEKnVoqcNAMytnymZ5iaSwIM0xiUOXHZIpt7Jty+8YkeSQIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc74435c428so3905411276.2;
        Tue, 13 Feb 2024 01:05:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707815148; x=1708419948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuURYQOwee17LWBBo2vHscRz5g8g3MQtGwSiu1BG0Hg=;
        b=aV36jC7lcWenoGEhiWNOz25grc69Ln+di+s1utZ2KB7WdcfCut3OHLKOVUdT8tuPVG
         lCWsolTIUivcEI/6lfushb9T5N31R4npI8JF0HhwPqzOK9vAPArgszeWMbYIInEqDC4D
         s1h4ZtgSl25XfvdqtRWEiJOg4PFiw+C67WnCw1enJndf5q6QnnVT8B6rmsf+UBqvn41u
         vWGdBdE3J0JyIKtYe4+mG2qhA7h7W2NNYszEX2P1ZAvc6EDmkxIXxnPh8HwPH4jSG1H/
         kCU9IhQNmctzWwWK0DxaY6vCmJvDl/BxonLnAA6JU7XITFp7fwJKYbHKc250z6Rm4jmZ
         w6sg==
X-Forwarded-Encrypted: i=1; AJvYcCVYS5ytMfjUAROFifhnldBqDKW/oJUK0hmv5lkKFQbtktY3UQZFgIs+0o1iiHLm7EY4o5DLFWDySfxcoQxCTAsBN3kNehREESJqdtKJHRu9z4xGGMsk1HkN62ugvmefEDS5yPZp/F1y3Foqpwn57Te2YmdvESV1SEOeGdui5fufp4jGUm0v1xh7nRAx
X-Gm-Message-State: AOJu0YzPW34QeVR3/NYsMjdbFefaWnRY7QxAkbv1AHevulVa4ohS9glj
	k0/K+DUd7KA/sVLefvV8K3i53AOIhSfIWXZIH3qlkySgfCY1RYmKNqxR42Tsi74=
X-Google-Smtp-Source: AGHT+IF9b6Zs8sgAJySimeeAwc/byYS632OGj672ixlQyji9wDWG2j8TBdEhFg2PVEeJrDoSeLUXyA==
X-Received: by 2002:a25:8745:0:b0:dc7:4776:e31 with SMTP id e5-20020a258745000000b00dc747760e31mr7443428ybn.24.1707815147629;
        Tue, 13 Feb 2024 01:05:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV0pB35EpM+VNkepI8lixDxd0Ub+OZMp6Fspr+AUyV/lR7JwhlRNLgUeivTlFc6DERe+YprL9sSC89+YkIM3imAe+df/zyMcro2qZxTdIQK8oTpKVAGEK+W4e1G4GKZF6kl3TWPwwRNCV2NO4ePolhIdoL+xrYN4pmMTSpM8f9gAwmH1MjXcWeOu/sP
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id a8-20020a256608000000b00dc6f1cdd45csm1557949ybc.22.2024.02.13.01.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 01:05:47 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso1172226276.3;
        Tue, 13 Feb 2024 01:05:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlu7YEPScc5bUPIszVbUd0DICWdLwAW6Fu8qqhYrKycyerrJrM1lb3zgIKbl/ERtyTkfGuSkn0jRESIGxzG8pRCFAYF+juzyB8Efpifl9gx7YKOdHMMghzD8V4h+p5GGibiJyPbLoJJQiOQlvX9U7OYr9P4taN9rSJVcxurTC1Ou6M1bKD1OA+bCVy
X-Received: by 2002:a25:bfcd:0:b0:dc6:c617:7ca with SMTP id
 q13-20020a25bfcd000000b00dc6c61707camr7330323ybm.29.1707815147208; Tue, 13
 Feb 2024 01:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213085912.56600-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240213085912.56600-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 13 Feb 2024 10:05:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVbG4bVNOYkycOOYV1oszzj9WPTbU936PokOE9jmp7iDQ@mail.gmail.com>
Message-ID: <CAMuHMdVbG4bVNOYkycOOYV1oszzj9WPTbU936PokOE9jmp7iDQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: interrupt-controller: renesas,rzg2l-irqc:
 Update interrupts
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 9:59=E2=80=AFAM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> All the RZ/G2L and alike SoC's (listed below) have ECCRAM0/1 interrupts
> supported by the IRQC block, reflect the same in DT binding doc.
>
> - R9A07G043U              - RZ/G2UL
> - R9A07G044L/R9A07G044LC  - RZ/{G2L,G2LC}
> - R9A07G054               - RZ/V2L
> - R9A08G045               - RZ/G3S
>
> For the RZ/G3S SoC ("R9A08G045") ECCRAM0/1 interrupts combined into singl=
e
> interrupt so we just use the below to represent them:
> - ec7tie1-0
> - ec7tie2-0
> - ec7tiovf-0
>
> Previously, it was assumed that BUS-error and ECCRAM0/1 error interrupts
> were only supported by RZ/G2UL ("R9A07G043U") and RZ/G3S ("R9A08G045")
> SoCs. However, in reality, all RZ/G2L and similar SoCs (listed above)
> support these interrupts. Therefore, mark the 'interrupt-names' property
> as required for all the SoCs and update the example node in the binding
> document.
>
> Fixes: 96fed779d3d4 ("dt-bindings: interrupt-controller: Add Renesas RZ/G=
2L Interrupt Controller")
> Fixes: 1cf0697a24ef ("dt-bindings: interrupt-controller: renesas,rzg2l-ir=
qc: Document RZ/G3S")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2 -> v3:
> - Fixed IRQ description as pointed by Geert
> - Sending this individual patch as DTSI patches have been Reviewed by Gee=
rt

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

