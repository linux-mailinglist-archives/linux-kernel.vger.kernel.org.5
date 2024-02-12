Return-Path: <linux-kernel+bounces-61782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9AF851678
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15021C22AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302AF3B2BD;
	Mon, 12 Feb 2024 14:01:21 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4E13B19E;
	Mon, 12 Feb 2024 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746480; cv=none; b=DkqTg2AtK8ZmEOpH799tmcJwS9/Ayubcrk7Mf2IQNB2xe3bwDWI6SDZmIOxe0Xo2dYInVphOFgMl1M4MOneY3YHoPNtGhJCDB+DXNrdQGx4SI9DFUSoQz5LJzRPhM+Q3WQBuh/myqe23OkgeFFqWhnSgf4xtMzSCfbksxD1hgWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746480; c=relaxed/simple;
	bh=Nf2LAAJyH/O+1XUTqugKWF/n+9ur/iLtudshdIEbVds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5hvJ2H1CB1eKcLYA0aKc13kiGJeqoWSUjBn0kvA7xajM7dHMnjfij2rN4aC4U0ghSzs517mIxDTK07cBo6VY0LrXmnYzJjoVwFuWM/nJq+3l6Pfu58VRFi43m634KieJyUWoAjljrjXUURAnIfEReHzcfSrIgohLBw6xbGsdT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-60498c31743so28678527b3.3;
        Mon, 12 Feb 2024 06:01:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746477; x=1708351277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxRGG2OetTgyV1iIms7NfSY29g5rngponZF3XBLDVZ8=;
        b=W2gXpn3c9MFKOfCZFhb900Kd7MdlguIti/Qzf1dsBsDS5lB6CCdWRFGKaYI47Pprjq
         068eYuqCM6SY0+VZVgk7oPmPnCoO+x+L+7NGbAvk0unjFvGCmr7NYJPhmLLq/5XzVNRS
         5hpUbOXjyd1D/BWbwS0nLk5mKYMFL0/YzgVKtNuER2sEBofR3N7mYLn6iJPsqnx6ciEd
         dq8bFx+OhcjeEW5GQ31IQ2LpUAuODZp/fmYaAOeG0+f1wFtGWs0qL33XtCfPn5k8c2Fu
         ok3znt/6FRDTkOOzaFekHNCvM5noYWOZAwDfs8ntPuIbr9DnUPqUVBitOP5Ne+hOL/2f
         xb4A==
X-Gm-Message-State: AOJu0Yxp8UtLzD3orvCKMh1JaFUL6UC+m/Z0lbiRAwvTthYUrwrXwE8V
	OCdqAt+0THaXReXyMOvOMoJrf+EOMpB6NctAatbzmke5JETlpXQYNEDEQusjsX0=
X-Google-Smtp-Source: AGHT+IEHI5n5lPTv3LgpXFpeAifn7zROZ5V9+roTkH3x8zdsYLWVhpXchyYrpiWLeD/Ycpka/9w6VA==
X-Received: by 2002:a0d:d7cb:0:b0:604:a1c1:dd5d with SMTP id z194-20020a0dd7cb000000b00604a1c1dd5dmr5520848ywd.17.1707746477464;
        Mon, 12 Feb 2024 06:01:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2TQv7HHsNuax8Y7OJ2xL0cNksmFWB81+up9rdQgcettJ4j6KoMZUIIjK+EzYWrpU27bb+vAvr+jGEzLx3/fxWYxuRIbbjELgedDrBA2j4ByMhkmFPJ/zVoB3Fnb7zd7/mJNAZ4gZwJJvKWZY+jBsLI6kcml5fqKx5hDTQnaGkAqsHhe5+WLdxr6s=
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id o128-20020a817386000000b00604a248f32bsm1193518ywc.52.2024.02.12.06.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 06:01:17 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcbc00f6c04so204815276.3;
        Mon, 12 Feb 2024 06:01:17 -0800 (PST)
X-Received: by 2002:a25:d387:0:b0:dc7:46b7:b7f6 with SMTP id
 e129-20020a25d387000000b00dc746b7b7f6mr5618254ybf.28.1707746477078; Mon, 12
 Feb 2024 06:01:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131102930.1841901-1-claudiu.beznea.uj@bp.renesas.com> <20240131102930.1841901-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240131102930.1841901-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 15:01:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVmS5cPuWuFaRsA+6TEmJc6B8iZZLFkJpRABQvYgC5p6A@mail.gmail.com>
Message-ID: <CAMuHMdVmS5cPuWuFaRsA+6TEmJc6B8iZZLFkJpRABQvYgC5p6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: renesas: r9a08g04{3,4}: Use SEL_SDHI1_STS status
 configuration for SD1 mux
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Hien Huynh <hien.huynh.px@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 9:46=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The status configuration for SD1 mux clock is SEL_SDHI1_STS. Fix it.
>
> Fixes: 16b86e5c03c5 ("clk: renesas: rzg2l: Refactor SD mux driver")
> Reported-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.9, with s/r9a08/r9a07/.

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

