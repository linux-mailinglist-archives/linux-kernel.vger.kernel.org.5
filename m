Return-Path: <linux-kernel+bounces-108861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F5D881109
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CD11C21A06
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061723E49B;
	Wed, 20 Mar 2024 11:33:29 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258493D986;
	Wed, 20 Mar 2024 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934408; cv=none; b=IFpMaOwaNDXgvTQKq/A+95zpmnXQ3xuwnKTnBphSOV83MCNJA5J1+2zukXaXhYbtkp9mXIuncWztESctBL2Kr7w3rGPLVi2YJMR5FH14xx5gELAZ2L9pqcBIPn/1p5celSpLC3+FvOMUfFpLy7pwFhPhKaFsNQDz4oi+i5Nc7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934408; c=relaxed/simple;
	bh=rJMET6qf9TuxPqMoog5+maGYHy5m/5MkJzg8nUH9IA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZPi8hy9wOsfgKFvBaVPGcsKdhDC0FkyRee3i9lpNSIlUq7hkvBY806B4i2aa6tVtBBvIgMKXcujMlTjZ7Nl2TnHDAO8pXDKoHKU/PkbdTUGTumPoEbMrfozPSGoz6K/H6jpAw0r9HoG6q3G0bnkUqQhlMoUqLL+ZSeaq0q0BGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-609f1b77728so71372157b3.3;
        Wed, 20 Mar 2024 04:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710934405; x=1711539205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZH7jIIDBiOD+mK/BbEEI+HYtRGY/Yq/9fLqXNr82KA=;
        b=goXiCBM7Z3/N/yihSjRnzQzJW6UURpOH+iIkneWxGMo5uqtXGNJ4SRLcTxHhU5+mZh
         hThhdHJ3RA73M8DV/ZwRZji2VZv3eih96bAoMbOCIHvCHbwPPpx2RHOXjzt7sdlh4ylg
         Z4TpDlS42oGAZv2XV6WRWaNjJtaRdCleiInkOTAqb3PkcF7JOT34ug5gcdxzk9IWTkKi
         Ro0ztOdHx+C5YuH1ohrRDG8oy9FjI/EWjpfY3AMyVlO9sp2d29jSgr5CFvlhyDZ5LDsS
         BJp0l/C91YtpOOvlb7vj5KT2p3C4Hh8bQ5GyRXLA3umBdQbIA8hrefrACw5jZ3a60q5g
         lvLg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ9KWXynv1lAMjvIsM9FQLZX1JgIPU41EgiET/elcWTzEmDoK/PTp2ClxMOQaAw4jZYDeEkFz3dczV1LudAWaALmVFFdiRhfDSIHxqUwW30qFU+s+NqBj8HqOs7WQ9X/hpYQdhD25ebcceWA8mOxNWt1BOTvL2sh2yS70ilDReu1P9KGUayg5d83E=
X-Gm-Message-State: AOJu0YygzLLZDUYdS92ubyxNr52JUG0yLM3qY5iBBVtxQ2mhadh10y/G
	01YIGEX2YBf6mtgbsZifYcm2tFfS6CWRSPxANN6qaqFpu86CLtskNCOfzqsxjdA=
X-Google-Smtp-Source: AGHT+IH3svJCewtagxYd0TnoV/23qwbZ2L5MNDXFP4ZBj4XcTo5nD9vhgrtkOPs/gi9HraOta8ZoTg==
X-Received: by 2002:a0d:fc45:0:b0:609:fbc6:340 with SMTP id m66-20020a0dfc45000000b00609fbc60340mr5853515ywf.40.1710934404822;
        Wed, 20 Mar 2024 04:33:24 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id p186-20020a0de6c3000000b0060ccac7cae1sm2757835ywe.47.2024.03.20.04.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 04:33:24 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dd045349d42so5745426276.2;
        Wed, 20 Mar 2024 04:33:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXw5W/AvvkBhm5HAy/C503Ybh2OpRs+bdErE0cZ8pUWrRT5cH6HQLk8K2R8hl1LTjQ6KZ//MeeRb7Vj1f6DjRV/Ppp9J2tCufiujwhKR+ynaJm08bhyEmug4lev8x+QZVGvX/8wW170NWwq/bTEgYG18qSOJqYWFo9an/0X1AE7+fnB5goMBxOdq7k=
X-Received: by 2002:a05:6902:1b85:b0:dd1:5194:13e5 with SMTP id
 ei5-20020a0569021b8500b00dd1519413e5mr5147238ybb.22.1710934404494; Wed, 20
 Mar 2024 04:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320082831.9666-1-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240320082831.9666-1-paul.barker.ct@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2024 12:33:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVKe2bLjMRXN-yr0SvGRMcv_93OWAgy9C-yL7UA9-LcDA@mail.gmail.com>
Message-ID: <CAMuHMdVKe2bLjMRXN-yr0SvGRMcv_93OWAgy9C-yL7UA9-LcDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: renesas: r9a07g043: Mark mod_clks and resets
 arrays as const
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 9:28=E2=80=AFAM Paul Barker
<paul.barker.ct@bp.renesas.com> wrote:
> The r9a07g043_mod_clks and r9a07g043_resets arrays describe the module
> clocks and reset signals (respectively) in this SoC and do not change at
> runtime.
>
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

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

