Return-Path: <linux-kernel+bounces-84925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642F686ADC5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953AF1C21A38
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE3F157E94;
	Wed, 28 Feb 2024 11:33:18 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9BF12EBF0;
	Wed, 28 Feb 2024 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119998; cv=none; b=ucp9sWzlAIC2VL8Ir7+xMxj4pnjHKE7Gxx4CEHfifswzn5USBgOb3FEG8BzKjWLY6QTQbvFkY4vo4lY/yOlnSvttGOP7cTkkiye4oHO2K6XEciZCFsmK8CDV7Ud9lAkD/P5d9fEVf56UicT5KJYYuJN2vWYY3mmjkL6XMIid56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119998; c=relaxed/simple;
	bh=6fD+GFn4fgyeY4yNFfboO/qEwSq92pkkTH2DLJ1P8xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ah+9jcNxqPUnRbf6bD4O3mbPrgZP01704lpCnpGwH3FTS+0/yd9eu3S66OZjQ/48JtcIuQXNjl+Cm31D0cZTgTD9wgp6GIWCPRNkkRxkd/XEcBL9V298NUSFbABnQRkMp6i11IUSkmesRHtv4LsbJct+WUzu2X2pQQkZEi9oiXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so5743069276.0;
        Wed, 28 Feb 2024 03:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709119994; x=1709724794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ynby1EA+eiJlMLirUugmY5xEE0QYQASieBRETxqFNk=;
        b=lgDrsjeippzEO5M8eLVGb/X+YAPJa3AUzUtPRSqmuoUI/87k3qot9YsfxPxAFZJh3G
         btov/U9N5vD5ssIx7A0JaB8s7gn4YotwskX0aee0CasCpM5kGFt3HyFuuexNiFT5tOw+
         Bdhroj02wkW3tgyx6E777Ox2Hm8Bu5wYzAUXU5x2oDyw7MmQPg0NKXRdyoqvQrB+NPqc
         f1jA2na2gDv2pqRr0pylEMg/QT29TW1z4ybH0mRmQVjeOgFHKO9TIBvUvX4RT8e1PKHn
         YXT0K7OKVX7JBsMZO8mTml1vx17ZbQ6KirH4+O2JoehmBk7W4AROYSskQf52jyavMU3F
         QtZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMJIjIqs9FOlwokrr6h3kcc1JeeAph3dFUHYkBCnOAzFe+7ZOea+u7mKXwTvP+DRyAu9Q8G+CdXVtL1SnHRV4t5Z39D+fbybpU+a7X9j1U1CB1SInfYUTi1ISZHm95Qy3fF7PiqHJPC9+ybyPMlDqRm7LD4mhNcKtEIca1SXfuEGCcaJWDjps9GYlE
X-Gm-Message-State: AOJu0YzrmKxkFbInRVzYkfJdxYzmVAYZLkFljmZxODuEPr3RtpjNfALx
	whFIqHlGmifrmbPohAq2xIGa8Zr6nDjG3EUfxEziRjLW1IKtzxl9QCdJ+iAm6PeEgA==
X-Google-Smtp-Source: AGHT+IF/PzgXMTXrsWWLleoXKWP7w9iUN/C3qo4p0B1YRXpJcXPw0jE7juJqx/P3dk7imhuIkIwdXA==
X-Received: by 2002:a25:d30d:0:b0:dcf:ba3f:a6e9 with SMTP id e13-20020a25d30d000000b00dcfba3fa6e9mr1992909ybf.42.1709119993863;
        Wed, 28 Feb 2024 03:33:13 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id v35-20020a25fc23000000b00dc6d51c8555sm1970152ybd.17.2024.02.28.03.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 03:33:13 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso5626013276.1;
        Wed, 28 Feb 2024 03:33:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5wy66UPOOo27/ndR0f/SLgBoZeEhOwHnWSz3HiURjKQ9/iodnegPPS+xTAEoVpmGehTLSVWwQ41EcZVL+e5rTlIBBVphBSI3jmDaigClGhofj3AhieMHOBYFuJ4MUWtnLPAjZTMMgzx0CMukq+/MEbNkP1dZvjajvAvM7cBR8kTcL7BAE0ARkyb1I
X-Received: by 2002:a25:9c02:0:b0:dcc:2f94:591a with SMTP id
 c2-20020a259c02000000b00dcc2f94591amr1770095ybo.12.1709119993126; Wed, 28 Feb
 2024 03:33:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240227232531.218159-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240227232531.218159-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Feb 2024 12:33:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX2X55v+BMWbLSam4G14-J_Ngr7jVJwh1kF=q+T7H0q4A@mail.gmail.com>
Message-ID: <CAMuHMdX2X55v+BMWbLSam4G14-J_Ngr7jVJwh1kF=q+T7H0q4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: renesas: Document Renesas
 RZ/V2H(P) SoC variants
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:26=E2=80=AFAM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document Renesas RZ/V2H(P) (R9A09G057) SoC variants.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v1 -> v2
> - Replaced RZ/V2H{P} -> RZ/V2H(P)
> - Included Ack and RB tags

Thanks for the update, will queue in renesas-devel for v6.10.

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

