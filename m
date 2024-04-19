Return-Path: <linux-kernel+bounces-151134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2031A8AA989
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D09281BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05AC4AECF;
	Fri, 19 Apr 2024 07:52:26 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2FC39FC1;
	Fri, 19 Apr 2024 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513146; cv=none; b=advq88IyFE7ZLDpBBiioN0HdZ3WJYKhRg2IU5RLxKaoOXMwwijwjQICvZr63x63AISfdqUC56o5VnToGVTqPC3mFDi3Nip8kKN+6PXkEHLTmynNQ0yzKcjrqPotBA4Ei4IKZMmA3wxTHPZ+AoiNoePHEdwU+wlJB3lcsw6SvQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513146; c=relaxed/simple;
	bh=C6lmziyxUI1u/f3T9IScmFqFqlDnWuHEZJ/CoqIPKLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/t6PP4Ri+SzqEVjQdG9EQB4DHv3qvmGZngn1TUQ43zB3F07XEcf3/n0mYDehBWkf3OMpRm4l+Dk5ALc1rz59yjInQlE28xgUmUNWVDBFuQVjjRVorZrxbB8vTI3E7HP40tw5Hs7PknZn09v47W2/u/XAK3Ky+kunIUkO2JZLJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso1772155276.1;
        Fri, 19 Apr 2024 00:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713513143; x=1714117943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ls5rSBCoF7f0JNFwNazATV5qYNLhrhhntLXb+o+5pX8=;
        b=Ebz6LyqsS48YOXQuPGytd6WMqwI/dIg0J2XTM1jD4oyw+XnEG7nAy3PcnLLuUpaAV8
         3rpijoN29XMF7zdgbiECrs4MBWWq6P5/A8inVxNgsZPvnI6HWzbxSie9Yhi2Ho5i9myo
         W0+0ENWVFP9N27lBSkBQfrh9m6HyKKoSzNUYEJBpnYM5a//vJaHMAKeYtv9rNhr9ncov
         I1WlZb41egdHpS1PiJ6mFeKpnJF06QKtuUOZ9rM4qVB7W145W22UMrFwxxZS7QEWtrYG
         o638NrqX52g0y7scNQMwS18Zp3dc5wucWFeqOUl9EDIIhuauDwU6Yub98QmFS9LCl+b0
         onTw==
X-Forwarded-Encrypted: i=1; AJvYcCW3dGMhSPvpvTdLr2oERHLRlE4PG4CyQLm8/ajhfz+QYMn9Cawu5gl9SZQUECsgfCf3P5AbrIBAU1tIUtzmuzJfBrNtcc8Feck22GgWkh1bCjJr77Aew3lgyQ7Gfh9rRs1OS1CRX2ZvTj6hzeVZE1IfFxtDmDIff1QZKmxcz2GcGMI6L6ncssY4N+aW
X-Gm-Message-State: AOJu0YxvlMvy2UyZCDEtQYVEh+blcXnp7Etd9Mxxq482GwS37AuwSuB/
	6UkpBQAMAr8vLlJ+0OF+2Izo8LckXjlsyfQX/qSIULp1tb9sBt/u+GIO4WAW
X-Google-Smtp-Source: AGHT+IHtQsA43ifEA07hW7LIUiEb3FKXiqqvkHK/ujPx4JB9bTTzHhjYthgIe0Fny/lnk2WcRLiaxw==
X-Received: by 2002:a25:ad88:0:b0:dc8:5e26:f501 with SMTP id z8-20020a25ad88000000b00dc85e26f501mr1045663ybi.61.1713513143360;
        Fri, 19 Apr 2024 00:52:23 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id u16-20020a05690201d000b00dcc45635f27sm708124ybh.18.2024.04.19.00.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 00:52:23 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso1772144276.1;
        Fri, 19 Apr 2024 00:52:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqhzI4Ijk+F/geUz0IHIMyGOigo8sl+A6tWIQurKllvja8E5Gz4KPuO07RCVh0UU2N06fznZqSh7OMKsM9pX4TYfFUctzUnBUbT4U+4U3OWAV0SFosuCltFQHw/cbV0QgOrSem5SQKtxbrhto5NywjuG0OykjW8hCev9/JsqZtVcr+3vfPWGUnzCWN
X-Received: by 2002:a25:8209:0:b0:ddd:7456:d203 with SMTP id
 q9-20020a258209000000b00ddd7456d203mr1152202ybk.41.1713513142996; Fri, 19 Apr
 2024 00:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419063822.3467424-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240419063822.3467424-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Apr 2024 09:52:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUp3PWJPKDRetyVNW42dGwAes0SY+gJJakAkvbFqab=Dg@mail.gmail.com>
Message-ID: <CAMuHMdUp3PWJPKDRetyVNW42dGwAes0SY+gJJakAkvbFqab=Dg@mail.gmail.com>
Subject: Re: [PATCH v4] pinctrl: renesas: rzg2l: Configure the interrupt type
 on resume
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: linus.walleij@linaro.org, biju.das.jz@bp.renesas.com, tglx@linutronix.de, 
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 8:38=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Commit dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT
> source at the same time") removed the setup of TINT from
> rzg2l_irqc_irq_enable(). To address the spourious interrupt issue the set=
up
> of TINT has been moved in rzg2l_tint_set_edge() though
> rzg2l_disable_tint_and_set_tint_source(). With this, the interrupts are
> not properly re-configured after a suspend-to-RAM cycle. To address
> this issue and avoid spurious interrupts while resumming set the
> interrupt type before enabling it.
>
> Fixes: dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT sou=
rce at the same time")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v4:
> - moved dev_crit() out of critical section

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-fixes for v6.9.

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

