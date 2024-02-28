Return-Path: <linux-kernel+bounces-84929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A67986ADCF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA619B24FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7E5159599;
	Wed, 28 Feb 2024 11:35:05 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12FF130AC5;
	Wed, 28 Feb 2024 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120104; cv=none; b=aMqpypWej4ZiMy1xFmmC2+Mti4v4cAZzmJQKFCqSLUR5uNWndYmZAVAu05G39iSU7qHMsRTrfXJBsVxk2JpTm+aUw5JeNvljjVb2b+Wx0WEX2QY9MunTs9L09cyUh2M0S3KgqB8cW+AY874fG1RBWotI1Ma0B9GJfIhKw7g6Mrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120104; c=relaxed/simple;
	bh=8kGd74yI4ICfYsEeUUbHAbB8aAtmedYoTe8onZxEveM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIJneRkvcF3TsSyJMmsCosI/Rp2bgFZ8+nLEzbwBum13W6+okhyQBNv0gf408FEg1Stho3qH75aXNTF1ow70NqILR1Ud4g7WYtqVdCj0+qh+uRXbVOw7elrjsyizYj4uR0igOMke3V1nuscxnQ1S9yKcDfGg9kgIKRbfmKf6YkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-608342633b8so50119567b3.1;
        Wed, 28 Feb 2024 03:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709120101; x=1709724901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cP033zuo0awjRBXqDA4OJxzTwOUOFi5mzCUNQiAWbEw=;
        b=mSPBjL2kXCeMArhEOesAn2vhxveOEdUwKNBXTi3T7iqW9vUHGnK3LyFUBokaLglne8
         6ic5Ahvh3CxSswC8v8zONDwWkKcCwxLSrPQkwicHu/D5G5ji8+UmtodgtB2vieYDgdVj
         P5FXVPng4mL/z1d8wdOfCMAtDmr7/Lx+xXrZ5+/NSXdyydg5/gTJkE4KLQnW9CbjvqCX
         sy17iiJT+8sfte7UPLfZjHkXjBnqx1RiPLbj9maqKgJ/HDhrJPzjzphFRh/ZytLYFC9f
         VvzEj0Guk+/Xy049Fx/7rpzWH08sMtOjfDOj8Xkh5J6fwmqTYsRL0QKcj2jgLpuOy7o3
         BphQ==
X-Forwarded-Encrypted: i=1; AJvYcCViN/BObkjHVOkQNg36cT1BjgfI2RWybND5K9cMhaxxZpOMml0m92ETOBxOOm2qDDydRvP23FB4vpdTU6CCyEgbv9BnoFKt3U+/3ey6BxMkPPvdNDe/QSecf8Asz3ZF1RjdyUpWKWxTrHNvhDSuLB4uS86F4xlHudxWPnakeW0gSca9qeQQL+MgixKV
X-Gm-Message-State: AOJu0Ywe3Ob8xSq96ikAZzvyBGsT6Dp9pG1Dsx5HlnG1YBFCb99jI+AP
	XqgvCf/wo0bh19J7vruISSmF+QlXQoOWjuu5wE5Dmr7DIn41VQNw2P2pwXVjn3NdHw==
X-Google-Smtp-Source: AGHT+IHf3OkVcBzT6WOPl4qCykw2xNg0veODdNVr1evH5gTDmskYzkAFLrIaGC6eAzoOFESn2DqZpg==
X-Received: by 2002:a25:8408:0:b0:dbd:1dfd:8b8 with SMTP id u8-20020a258408000000b00dbd1dfd08b8mr2234670ybk.24.1709120100850;
        Wed, 28 Feb 2024 03:35:00 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id g12-20020a25ef0c000000b00dcd56356c80sm1846518ybd.47.2024.02.28.03.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 03:35:00 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-608841dfcafso50739487b3.2;
        Wed, 28 Feb 2024 03:35:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8lNSU1Z6GCtjjALUMz0gJUAeIM0LqS/Cfw/YNjr1bb/LV59HdrmgAwm58gr34nW5rRzcco0UX9f4hixbLcDZhFzV3MDD0fE5LLC1DM6eVXPa6Jes9W6+5b32EXV4GENcL7bmrCtbNwxaFQYGchlE1/hlunvAknXezVbtMGxvW2SG8zAyT+rmjm/5p
X-Received: by 2002:a05:6902:2191:b0:dc7:465a:2cb2 with SMTP id
 dl17-20020a056902219100b00dc7465a2cb2mr2565771ybb.30.1709120099881; Wed, 28
 Feb 2024 03:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240227232531.218159-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240227232531.218159-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Feb 2024 12:34:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWZxA+VKHjnAk6J+oxe-D74ScqhCVDnhJ-+F1h2aWD37g@mail.gmail.com>
Message-ID: <CAMuHMdWZxA+VKHjnAk6J+oxe-D74ScqhCVDnhJ-+F1h2aWD37g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] soc: renesas: Add identification support for
 RZ/V2H SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:26=E2=80=AFAM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add support to identify the RZ/V2H (R9A09G057) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
> v1 -> v2
> - Replaced RZ/V2H{P} -> RZ/V2H(P)
> - Used small case for hex value

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.10.

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

