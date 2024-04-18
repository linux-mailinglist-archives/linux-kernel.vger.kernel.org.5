Return-Path: <linux-kernel+bounces-150317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25FD8A9D52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA453B2598B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F11168AFC;
	Thu, 18 Apr 2024 14:34:43 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E9168AE6;
	Thu, 18 Apr 2024 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450883; cv=none; b=VTaxoLAT5hivtVC/pso3rTaLlA48szlw1j8TWnieCQKwfNfNSGv5hLxqp1gZQmTlir6wMI0Zab07l/ARZZO3bR1D267EaA71K0Hn2grtGZLbWjP/Sfme1gkUM0xR+O54Vg3+G9E8ZhHTgy7y37atUVRxRLjSQEJzdozgkDcxD1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450883; c=relaxed/simple;
	bh=lFEhPvk18dl4N7zV23MlFHhVbDsGmOEDL6eGyAMEQRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sO/3qoMGAB7Aat2O242Ac8e8Zvt4pl3pHjGyj40NxAbt1W0T2fKcgrlFkPCOj6AMA9MfkEe7CytazMBIPt8NdLOVkXjeLu8qPRepWiumJxWwb23rKzMgU8RsO180zk8guTIEewLU9QfypX9rl5lFS2VAArXCJW5KyVhtoftDsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-de466c641aaso745120276.3;
        Thu, 18 Apr 2024 07:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713450877; x=1714055677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4qMhjuBqY7JwfLnRM9VZooBQ1VsIWFaDYIE/bOR1ec=;
        b=sDjOKojwqlbIe56AGxzofrEOLgR2pVCALmKM77/aXaepNHQMgOss9ayi6h14znWmAT
         V75CevMZlq+TboFzhV6Q7P4Za3aLXqhqtqf+x5l6g+DwP61LjAkFAIziJYojImZLeoSb
         RYfd4hRrjkpRjL03nvE3o2p/0+eSHc8Vyg0aGwKYfBlnHPNic2sA0IIX29/3rTCio6lk
         pqtL9jYlWsEKpsTG/MNL/siCac1eKbe+rvyv38apvFOwIdUIl1rjcPN/6jnB6ORRW+Tf
         aLJJ+yZaro3kmHevV6AwQXm0Y/yh8epW9U3GWaHeu0u3muAAmRKpRW3xBY65vZm+f3Ed
         69jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCjlIKidWJXE7MnXVGsMemAXoysk3UI252eoH9x3kzH0IB6zYnRcAsMKXKP4Cw116breijCyxJjw3S3WYKi8dpiEhhqWNgZRJqfdVBYx9wi3+nfCAThG5OJAXLo3jn28XYZJetVcOZ7plhbSBG5xG648wwavJv4F9R9JTwW9Kn4UvqVX0SsMyTkQmV
X-Gm-Message-State: AOJu0Yxek1vEesbPpg+5/T2nMBpE2wjcbWwK24Eit5VyJpysG13haSNp
	9ZZTZ58CKkR9nWKXkbwum0WVaCGuYjG/J/Otf4no1v+Kt2t38qvUHArtXjvU
X-Google-Smtp-Source: AGHT+IFH+s1XB4/ulKiA43Bo/LRnLJ9TxopCHKWiSVlnWoryyJkwzCeGE+kzyAVPfHHlK99bJAyR6Q==
X-Received: by 2002:a5b:18c:0:b0:dc7:5cb3:256a with SMTP id r12-20020a5b018c000000b00dc75cb3256amr2937512ybl.42.1713450876832;
        Thu, 18 Apr 2024 07:34:36 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id t1-20020a056902124100b00dc254858399sm376653ybu.2.2024.04.18.07.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 07:34:36 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6150670d372so8653337b3.1;
        Thu, 18 Apr 2024 07:34:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6Lzg7yo8mZcB/lkuVxKS4grXI84mw/+vYIgwOqkue5KxmUHrOOvTqDxWJ4G7ieKepjthtMffnlwl9H90QLdzCWliD7bi8T2+kLweBActyzuVCRpj0+w9Fm/2bMe+NIgG5sOV5n9GtgeZvlU0Ta+P7h/Sn3IUjx4C5iH9UO+I45ppXneA5X60U9mgt
X-Received: by 2002:a25:df11:0:b0:de4:16b0:c8f6 with SMTP id
 w17-20020a25df11000000b00de416b0c8f6mr2918064ybg.14.1713450876072; Thu, 18
 Apr 2024 07:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240403203503.634465-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240403203503.634465-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 16:34:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWUooMrm2GjGwoK4xo-BfOmX+mwvT-62KHqPcCg8kBMEw@mail.gmail.com>
Message-ID: <CAMuHMdWUooMrm2GjGwoK4xo-BfOmX+mwvT-62KHqPcCg8kBMEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/Five SoC
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

On Wed, Apr 3, 2024 at 10:36=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document RZ/Five (R9A07G043F) IRQC bindings. The IRQC block on the RZ/Fiv=
e
> SoC is almost identical to the one found on the RZ/G2L SoC, with the only
> difference being that it has additional mask control registers for
> NMI/IRQ/TINT.
>
> Hence new compatible string "renesas,r9a07g043f-irqc" is added for RZ/Fiv=
e
> SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> - Dropped the checks for interrupts as its already handled
> - Added SoC specific compat string

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

