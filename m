Return-Path: <linux-kernel+bounces-150343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8268A9DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9024B1F21F52
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2EF16ABC0;
	Thu, 18 Apr 2024 14:54:14 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD85515E5C2;
	Thu, 18 Apr 2024 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713452054; cv=none; b=Ta6glifHER4NuauMKr6uCQY+HfUkPPju+r0+WtEvVEyQuFXrOnaORCydVGsxo6gOPct7ztEgny39UoNCF4oaUyBVHPbdi8gtmGV6YRLOxpMce+QSqtXofxsesk9fKPkiRDQApazy64PYgp4vtbjX4t52s0GGAwBwGwGFw/hkOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713452054; c=relaxed/simple;
	bh=WNJKQU3xUvHfupkdLUkvqSa/rnxSBq6DXuy/CKfjo8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaM0VGaPxIKZ6m7WwiIUoeRdnTP5mq0ZmtEYeNTLZytDmCTxv1KEaIoVo7Ess5AFnv/deEkAGb59rNVltMYfoQZYiWlyJKl2FwT+JIz1zymqXx2zYqrYZrL2msFasfXiRO5Ns1usL/rPQdofJTGvkQwZ/2z2P92bhtldZla5s38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-617f8a59a24so8586267b3.1;
        Thu, 18 Apr 2024 07:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713452051; x=1714056851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/POOUQgPdW9+xNwkTyuL8XDbLKnhNO+65dV00iG9onI=;
        b=EJ7Jh+1B8hH8yq4oIhe+Rf1zvf+t8eDGZYMDz81/8o0p+Lh6u4tgFYJFnllslfWgM6
         +9f/Kc9A9XNaYxcEDIauvPIkOMXW8MOGeyVn/486jf/GhpIvuZolCSyP9a6AJgIHEQK7
         YklXc8fEcTWkdpC5L55VQBd0PPFjN5kP6zpxKhtS+x9N7a61/K0s6JwneJJlpp/3aZtz
         cb5HKCNJtX4ICtGJB8JUx29n1EpVB9nb1r74GbeK9FGPgJy6vqsW4dVXDPyv7ji+ECS5
         yPMPKHCMgZzFEerhmTiOYP6UtH+o76uYftCWQbwDY8CakcS6XlbbzLyafA8JoTiuaxwY
         wSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHxzJaB19AJ7hdpO8n/Ne9+cVkW9ze4USAh90F6rQRg73xgVgnxZail6qTWV2We6BiBOXWdtKIWliET4go27CmuGiTs6vm5JcYb0efaY+G9tlr/QF5kOrGvjr9FxY1ClQvQpJaChsfF0KC7XjY+356u0IYZ168iH4w+7MRCTkcJ/gelum/LcDz0fE=
X-Gm-Message-State: AOJu0YxsL5jsLhmKDMW+6ghMFbbFFOYdtJiEVZye7US7dIY82ly8fr0X
	1ALC5wOwqQQ3Nzi7k4YNlIYOLF+w+AbTkY2R1rylaU07JxIaeeGZq4Bx7CqS
X-Google-Smtp-Source: AGHT+IGIVOwVaCU6/zJ8IKLVXz4bRuiWRq9/FwkqH13jJcEWr3r+IYFjuKWmUejAmiYm7+Vf4dGjQA==
X-Received: by 2002:a05:690c:dc3:b0:61b:69f:4c24 with SMTP id db3-20020a05690c0dc300b0061b069f4c24mr3206182ywb.20.1713452050044;
        Thu, 18 Apr 2024 07:54:10 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id w63-20020a0dd442000000b0061ab76e5f4dsm363859ywd.114.2024.04.18.07.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 07:54:09 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-618769020bcso10506227b3.3;
        Thu, 18 Apr 2024 07:54:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZQTeuVuspQB37u10XgIRS4uQpQLlR9QF2ZexgmQFQAKWr/3F3tGUjFLIU2jn3FFcVDmQ1QGM7EtGJRbwv1nX5TvVDSwKN2DrMQj4HyEP7uM9rSMU9XGq60wluQmwkI2QAvdsWoQzgoTlWZVw7Ax2ye+CnCl8jt6hbuawpYFQu0unWi8U1/mJ+nPI=
X-Received: by 2002:a25:83c2:0:b0:dcf:ba3f:a6e9 with SMTP id
 v2-20020a2583c2000000b00dcfba3fa6e9mr3025106ybm.42.1713452049634; Thu, 18 Apr
 2024 07:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403200952.633084-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240403200952.633084-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Apr 2024 16:53:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVN_B3xhNnq1=NOs=LmWw3P=dJGr0MhQMdqsChQ=VXWLA@mail.gmail.com>
Message-ID: <CAMuHMdVN_B3xhNnq1=NOs=LmWw3P=dJGr0MhQMdqsChQ=VXWLA@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a07g043: Add clock and reset entry for PLIC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 10:11=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add the missing clock and reset entry for PLIC. Also add
> R9A07G043_NCEPLIC_ACLK to critical clocks list.
>
> Fixes: b3e77da00f1b ("riscv: dts: renesas: Add initial devicetree for Ren=
esas RZ/Five SoC")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.10.

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

