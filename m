Return-Path: <linux-kernel+bounces-150350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EABA8A9DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8062C1C2174A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B5A16C444;
	Thu, 18 Apr 2024 14:57:52 +0000 (UTC)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D716016ABC0;
	Thu, 18 Apr 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452272; cv=none; b=lVoVq8Ol+RGwPirRLPwm6OrVitRr6JACdDWCudwox0++VYXnK/NnaTP2yY1+zGbWKSgC/BS4xKsYs54jgFOqOqzZpcw3gMPFGgv5qZXeNSvb5of9M2DLsjgW31v/RCoIj4953f1O3EqUq5SweN3aIb5gTOEnVzkK8Q4HO6vdlhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452272; c=relaxed/simple;
	bh=Eb/EVSMY879H2500DGFBLbJRSwhWpGh81TIuhr6YDhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDDSyr/A5q1p1XAU+iT/QcsASGoNBxCq2RbghyPWwzH44c+lIp+pMkhN3/19bBEqD2MZVK8Bpg6NP+x4yCz/DsYNqKY1XgfIHFCqbuGP+fP7Nf/GH37y9Eqf+fQV8gmAnu86YI303twzHMuyL6D9fTZpF+SDSnB12O+mzMdJD/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc742543119so1112327276.0;
        Thu, 18 Apr 2024 07:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452269; x=1714057069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBkk7IToPf8pTng3q6RoyHKsGOCoZ6cSUuNVh7MUIdE=;
        b=RPH85LIOwF3MZezkmlgMlGeHuk7ggQtIVMWoozkjNNj/5zwUf6y2lx+eWDILOZMBkM
         IIV3zztkWEJKcIC1oEaowfOZZjBx4WAQVnUjQQOL9YeaS8mxSCFOA/KMK8SnovhIqymC
         YM8RzkcAXzazlr0AmOzJLEi56qlm4cxSBpqnNWonYhsXbpu4cOlGVnu5hUk9nc9sGZ5X
         TC01lg4m3DZaFRk3bI/2TsYD/3HlLho+qIDw4RrmdeLWIFXbNtOvcmKFnzVjeLd36xnn
         7MFx4yaqAZQbHIsDLj81YE1Z7Rug0+S5umok0GQXKuoNfAEI+/9pwKyiMcaJGtIlB6p3
         GnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+QNy9iNZ/mkuoqIlQmNtDGiZEm4if6HeL8Vanh5Nlo3GqyT/m7qOe1mEZkTuaZwZJ8NL/uxLTF4XwDMFGSMQGoLVGkMJOXRuVYy66MJ+P+hMblLZUYU9U0f6EQAGds6+7acFuK34hjHHn71a8yIW3OHGU7zRJ5wHQN+Ep8LsL+BZH+dkCaOu6I7Lx
X-Gm-Message-State: AOJu0Yxw5EzKYBO+4HnXimx75hMgofn7orAgVVrGtugmG860+YHkyuWa
	h6bZizgdrEb8BWcDH/xHjDTHxk/xAjAg0mdj5B6yN/Wp50zCfmjT+DIIwhxE
X-Google-Smtp-Source: AGHT+IGIyMJFVhgtnxFONQA1/XGvMga9mv7jVfqh26rTZKafJEORDSLkz8+VMvLteIzHPdwn0CkxxA==
X-Received: by 2002:a25:d30c:0:b0:dcf:f525:2b81 with SMTP id e12-20020a25d30c000000b00dcff5252b81mr3078678ybf.46.1713452268895;
        Thu, 18 Apr 2024 07:57:48 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id z18-20020a5b0e92000000b00dcdb0f80b69sm385665ybr.48.2024.04.18.07.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 07:57:48 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61ac45807cbso10236837b3.1;
        Thu, 18 Apr 2024 07:57:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+jo2g0pGOU4qUqoLAoHPzXT/8xDJd8Sv7jEcqhCgPKQveMA1Pr94dZfymlvy2c2cywmNYUKyFqvhJhfJ1FBCd3M+THOgajLCoIxbiwSB5wdLzZdCiTLpRU85lrdP8PHNXjQ+XGqYVIEgU3BBi9IztRIW0n8kBx4TYLF5kHOLvKA+vZ7hyPt1or0Tb
X-Received: by 2002:a25:aaaa:0:b0:dcc:2f09:4742 with SMTP id
 t39-20020a25aaaa000000b00dcc2f094742mr2918100ybi.51.1713452268112; Thu, 18
 Apr 2024 07:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240403203503.634465-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240403203503.634465-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 16:57:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVmat=o-+_KX+G275SEcdC-OxAjOw5CS-rag9ZxnQFHfg@mail.gmail.com>
Message-ID: <CAMuHMdVmat=o-+_KX+G275SEcdC-OxAjOw5CS-rag9ZxnQFHfg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] riscv: dts: renesas: r9a07g043f: Add IRQC node to
 RZ/Five SoC DTSI
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Wed, Apr 3, 2024 at 10:36=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add the IRQC node to RZ/Five (R9A07G043F) SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for the update!

> ---
> v1->v2
> - Dropped using SOC_PERIPHERAL_IRQ() macro

and change the bus-err interrupt to from EDGE_RISING to LEVEL_HIGH,
to match the documentation ;-)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.10, with patches 4/5 and 5/5.

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

