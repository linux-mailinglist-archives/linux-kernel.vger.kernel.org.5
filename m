Return-Path: <linux-kernel+bounces-61785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7A185167F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F542834B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B68D3CF51;
	Mon, 12 Feb 2024 14:02:09 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8003CF4C;
	Mon, 12 Feb 2024 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746528; cv=none; b=pFVB0fLy18HEFJrCln/Ep4EO45bkt3HPFG1MKtG1rqQDlPdADaTXQVAseJYXdu2s7YCk09FcF6A4oQmZPTCqgwcoZRTEaLCVc8asX5yC4P+YiudplkvT3KFk/wSrFBV07Tw46SDde0u+11kHB7c5JKS8HCskBSZuLdp2ZDUFNrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746528; c=relaxed/simple;
	bh=4wwcwPsZL4cVShXU9Ke5CIWHvgtWIF1QgZ+nN+4LgXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zg4ZExCqos7ggTeKdohvLbrxYuz4UwRZkJwDdXwa2Z3FhJE+rr6NPrhzu/XmuNkiaEoyTip8yLQ7TOHJqZQV3TBe3S8zRltMVO+x9J4Q0mXEra72ZPk4TWz2cCSJkzr1K6pDtGaBYMDvMLHmce2L3SJzi5PqicFqt9eLgdQYp4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bfdb84c0ebso1377639b6e.1;
        Mon, 12 Feb 2024 06:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746526; x=1708351326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgf4Vh4Rx/WVdwOKJ7KNozN4/wCYNo9fwwAZLST2hO8=;
        b=GeQPOA12cN/MrWIzCzDjGoacPH6hcUBotF89Y8WQr+M9gPYZZXg5MrzZrbfS2BVu8q
         Evk08UD9p2qemcQSEs3JpSitfZjf8g6lrMr35h8Ddas+4Q2f297uIDpYnMZ2rPhSW+VT
         lotDR33w3YYxjCukhF/fJR3x7iVcc/W1W2THeBGQluyumrwkGYGnLC4AhAEH8nSvbORO
         G9ZVIBdFaZTwjJDZr+VTQ6udWG+MKcTJKgtD/wxoyr2j7xONfqyEtFa/a0vXWy8QNsvZ
         dVp3BHey7LOG00HEqIJsxJb0gk+jSh7LPJw54uGfcGR3AAdUzuHlhd9Op4tFxieQ4Rnt
         Q4Dg==
X-Gm-Message-State: AOJu0YzGFNmHjh/KFsB0SaWbt+hoagoN6SRTbfoH2BcEWQ78VIwv6yE1
	26uM6WzWUX2VAk//g3P07TLMq9HjrGhNvC3N0iWyiVFIi2eOpKKE4WAtFOQRB+g=
X-Google-Smtp-Source: AGHT+IHoBGbHKiZdMTM0x9ZkHnMhtvvLAuJg/W6J5RE+sSli+OJZMIZOg+6bnlXP3xZSC515i0XB5w==
X-Received: by 2002:a05:6808:10cc:b0:3c0:35a1:742c with SMTP id s12-20020a05680810cc00b003c035a1742cmr4245083ois.41.1707746525796;
        Mon, 12 Feb 2024 06:02:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWOsI9edp1fEPeiX2EgOYU6bG99gO/Io6YtJresgWXr4ZsarUCRKH0F1bg8kcHvS3Ot0/B4RRE8iy3x5B8JgXX6bujQNaF8A4L8FtifQRlm3nOp9qqrBVajAYoCg+Kg9GBjG2y4HQ1YLYPbOdwU4zt/m8kSaU/9oiPnUhQPpmtddX31BS+b1I6Keho=
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id i21-20020a056808031500b003c039285926sm60294oie.12.2024.02.12.06.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 06:02:05 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bfdb84c0ebso1377615b6e.1;
        Mon, 12 Feb 2024 06:02:04 -0800 (PST)
X-Received: by 2002:a05:6808:3094:b0:3c0:4128:3b85 with SMTP id
 bl20-20020a056808309400b003c041283b85mr69286oib.22.1707746524722; Mon, 12 Feb
 2024 06:02:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131102930.1841901-1-claudiu.beznea.uj@bp.renesas.com> <20240131102930.1841901-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240131102930.1841901-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Feb 2024 15:01:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUFnUyAQj7YQQMcqkCg2xhSqzb7xc+sTzAdf3cu1YT3Rg@mail.gmail.com>
Message-ID: <CAMuHMdUFnUyAQj7YQQMcqkCg2xhSqzb7xc+sTzAdf3cu1YT3Rg@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: renesas: r9a07g04{3,4}: Fix typo for sel_shdi variable
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:02=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Fix typo for sel_shdi variable.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.9.

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

