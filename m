Return-Path: <linux-kernel+bounces-44400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A5684218F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D5B1F283FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DE966B36;
	Tue, 30 Jan 2024 10:38:20 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC666B37;
	Tue, 30 Jan 2024 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611100; cv=none; b=RSYN8pGB9LrsSi0olYW1mdop17RlOaWHbecRXBxQHcufPImD3hbSqCFvAYVEJeo0joQnmCbLrYn/5w3TqDe90kJFa/6ZAJq8xbdYyn3JWyYRJySYD8/1PaC+oVC1B0PZYWxUKhEnzPiXf/tAS2GykvKYKw2QQkuPlpaXwM1FiPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611100; c=relaxed/simple;
	bh=5GVG/YudD3lGuYjQTHRm380lEHKoO7ZK02daD3tJQ0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBVqxRCRwJwL470p/cEnpOsLpTxSORKhcLljuX9/Vt+uqnnwUf621PK7ZEzv5D2V8NG1D22xY8XsHtQRZiIbJD2QUoacPs1kygliCL8o2Gy5lixKDC2fL9nokL8NLFag0XKcUb1LU/pHhMCNZ5meqPaZHjJtjM3QCIui5iHBRTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-600273605a9so38450647b3.1;
        Tue, 30 Jan 2024 02:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611097; x=1707215897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+UdOqZZwrPnQ0aumW9u93q+aeRPCvN7vS4/TIye6aw=;
        b=XuZwLKKKYpuDXBxlc/puT4RmdBrFR8FU/aiBAAZ38Fp7trYNO7uDw11CGHXb6VV61z
         DYh18DyUqXBOv3GFskKo0GPx1o+EubAKzY9hCoio+YYC63qvSITxr/fsmTeBGtoBJI2i
         ZLlO+QY0knCAINMrixUh7/xG3fnpY4ms4+wkfqI4As4MX17RqglihDsF4YCf1UpC7fgR
         PFrTL91rmmAiuco6vkYLZ0pDCNAgy9rSOOdHWKk/YYtWeEXsAHAmkMiK+naqU+ypm8Lr
         qwjrAr+XA5xuwkkzJOZG4doUTezvmusH7IGfz+iAIlVl+l3ZadtRmIlfglJcJTwvAx0J
         oOgQ==
X-Gm-Message-State: AOJu0Yz7aWOpBiFlQxYLgjG5l0AwZja0LubjkGNL2yJN9aIdnmmmbaR6
	9BxPwy4KHhB0kYRbir+Zyvba8TGtJuXFv9HPQbOETI4duWeL+gJsyqRW9IKVcps=
X-Google-Smtp-Source: AGHT+IFSJ/NTqlDOyp+dJ+Ybz90hN761OecxgpYrZbf6/Ot5fJ/1YdiN5/cIXhGM34ZkhVEb7l3dXg==
X-Received: by 2002:a81:4815:0:b0:5f6:fdb0:ae76 with SMTP id v21-20020a814815000000b005f6fdb0ae76mr6902040ywa.37.1706611097346;
        Tue, 30 Jan 2024 02:38:17 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id p70-20020a0de649000000b005ff913889dbsm3120791ywe.50.2024.01.30.02.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 02:38:17 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-600273605a9so38450507b3.1;
        Tue, 30 Jan 2024 02:38:17 -0800 (PST)
X-Received: by 2002:a81:e244:0:b0:5ff:5e94:277b with SMTP id
 z4-20020a81e244000000b005ff5e94277bmr6676192ywl.45.1706611096838; Tue, 30 Jan
 2024 02:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129135556.63466-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240129135556.63466-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240129135556.63466-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 11:38:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUiiQpw5UH8s748oqaH5BuFqDy=feWxdsEPJ4jaHRzkyA@mail.gmail.com>
Message-ID: <CAMuHMdUiiQpw5UH8s748oqaH5BuFqDy=feWxdsEPJ4jaHRzkyA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] riscv: dts: renesas: r9a07g043f: Update
 gpio-ranges property
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 2:56=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> On RZ/Five we have additional pins compared to the RZ/G2UL SoC so update
> the gpio-ranges property in RZ/Five SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v6.10, as this has a hard
dependency on the pin control patches.

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

