Return-Path: <linux-kernel+bounces-61793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BD585169B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4401F24A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AB83F9D7;
	Mon, 12 Feb 2024 14:04:00 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657473EA8B;
	Mon, 12 Feb 2024 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746640; cv=none; b=UnzThGyqwdpHP8+RsZXb3Ga2Bc2Eqpd0bCgoJwBbDh3iwNMiKCpZ0qqA1czslw034lcXwZLwiThIFs0Mc+1x4tEYSo8oaRLKMVp86C3kwk2lSMtp21rcamlop05n8AsGdr2OoRayeOPkduRnRdW6uvCLr/EKSkx08jWvn77HJKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746640; c=relaxed/simple;
	bh=H/JiaCmNWv0EjZSg6nEGx1vCnFpm+C1tngX5CVtRbpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lmxhc1DzuzXKlBTCSFnGQel3CdgIeH/5RTGMJhyQKdlOFIxrFO5oiYtTQp2akbirTXoo35M6U0jZm6eGA1mnCI1pG/3qHCFzWVcKTyJbc4uSt12xAk5GERNj0k8meIj7019R3jvFetSfWOui/MMKuW6SyqGMDS61ULcZ3x9MU/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59a99ef8c7fso903841eaf.0;
        Mon, 12 Feb 2024 06:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746636; x=1708351436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SH48FpNzIrh1irMaMafbrbeG1GqtnZpMpdefiQFlYzo=;
        b=oWN6pnp4r4czomoKMVaS3ugHELDOqI5N8OX3JNVKLIjztQJCqPEuq3Jook3FbSz+uf
         vcMgNV5RpguC+ObIShLCMoOzSyxlppAENkIC7MUDJyb/zGWj716aJcvglfTE57J/sgpw
         G6sa5I+WiH/GOUR9+bGGIuaqT76jwMLRDDVvQ5UDNbn5ZJmnXB2zSIWZpVDCfEQQOgYz
         mPcCqakn2NRVXKaqesnZMg0dUJueYEeOaQR/i+HvqOP8fpncMZ9LkPNZAPUw0DsJjrcc
         4x7daRXAee2VqnJoKHaLEJTkELNZ1exTE/u62e1Mcgp6VMfJXMcLGJRMUlK0ySC5ZMzb
         oO4w==
X-Forwarded-Encrypted: i=1; AJvYcCWV7WH+Fk9o2Uttn1XECEo7Vil2ZPkfGfbhTyIMe/9WUYNTgi8E2DpA6W+TQgbVgWhpcPh+RVCAtBaa1LI41BtAEb6PmNecQlRqTx77uZHevWtGbZFcAdIBe7djajqXS/Pg9bf9tly90KicmPHO4E2rXl1jmSsBwFp1bEGnbz3adjJ6Tp8AjhOsyYkAuHRNiX9GI75PdowisIvAUZ76VGf/aCaIbBqBEg==
X-Gm-Message-State: AOJu0Yy0KFKVcKeZGT9jNgWEh7aNRdJymVGWRJRD1jA9Rknq1sGFcpjS
	Oi0ne8xVZQA4ITG//LhFFzSgA0Pb0Tqcg67bt/sKXkbk/zd4V6j5YW0arugFBM8=
X-Google-Smtp-Source: AGHT+IFnP9k38r05lhUVn+K41SOG2mMb7rBFSoguX5NIklTY8am5/XpsYjU62F2UIWFQ91VR9G7yuQ==
X-Received: by 2002:a05:6358:7f08:b0:17a:cfb0:828a with SMTP id p8-20020a0563587f0800b0017acfb0828amr7130490rwn.19.1707746635943;
        Mon, 12 Feb 2024 06:03:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZpxbIUv5LN0Ik/lc+aGjQkWt/AchNS838pMBO5RU36u36p/Pa5MW9AcSf9j9I8gPCmo3E7v411L9vytczJxrTI7anXxo6bZtJyfWahWQIwNj2tuPjHQApPc1XoQ1ZU0L6QtK9tarT6DHvQxBTFuk7UZDCJkrOp4OB/tX3lngVKGHoW53m5ko7l97Is/27x3aM1JlxEWdfqHu3N1ogTEla6uha7rAR/g==
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id n12-20020a81af0c000000b006077a4ff35csm18424ywh.93.2024.02.12.06.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 06:03:55 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso2886473276.1;
        Mon, 12 Feb 2024 06:03:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsaT3nOo7ZdUY+uo8rLPdXw2B15YV+GThlfM7/wTxmXvvsPzZqnimR+8JaHLt7GUdFeQfyQVt1S6EH3guDVFMsOeWAnS0hYIDdyyL6NBh9CQHefOY+R06KYiCr1r6chz4SVKjSa1ruJSLTvIYK8Uh5JaEMgF3VkJxN8t1dEtFvaWv35Pgs4eYLf9yO4eOLs2wRHPpzEdaDldBoepVnFAfKKJNS79q4pg==
X-Received: by 2002:a25:2fcc:0:b0:dbd:7491:368f with SMTP id
 v195-20020a252fcc000000b00dbd7491368fmr5193777ybv.7.1707746635632; Mon, 12
 Feb 2024 06:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208135629.2840932-1-claudiu.beznea.uj@bp.renesas.com> <20240208135629.2840932-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208135629.2840932-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 15:03:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWVz8ybzA+WAfc88-8jeQ3oO=VL9QBuQdqLDSQW1SN44Q@mail.gmail.com>
Message-ID: <CAMuHMdWVz8ybzA+WAfc88-8jeQ3oO=VL9QBuQdqLDSQW1SN44Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: r9a08g045: add PSCI support
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: magnus.damm@gmail.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, linus.walleij@linaro.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 1:16=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add PSCI support to enable the suspend/resume with the help of TF-A.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.9.

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

