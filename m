Return-Path: <linux-kernel+bounces-144670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9195E8A4905
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB131F2254B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DB523763;
	Mon, 15 Apr 2024 07:28:50 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542C1EB30;
	Mon, 15 Apr 2024 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166130; cv=none; b=KPNw0cctQUUyXYt4yV1wdNm6ENHzfnNciOBGOkvmasgjXgv3IbaZtaXoE831c0HrdGkGw4vxf9r9fMsdZ342MA5zVKpZGTrOZXtqIczEqlgsXQqJDVzqKTwymZyRkPPrIFkCEpf/tSHlx01vfC4Tsmtn4kwAZKimvOgZN5jLoew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166130; c=relaxed/simple;
	bh=m8QpBMJtoPr8JIXclCPZe9LRJ8LRUBvkWOWld3K74dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arDOeXxkO68Htkbu+MJxV+naqtrec94wlg+ZQu3Fi9cSUxke9MxXZtRHzwTAo0MdAY9/cR5JOUs9tCFBJMP6SaCO6sJmZcBOVQBfhn6sB3qzUTjrkBQk6N7n+NamOxI/EvOTxqx7NbcQlHNWgsAPD6S2NjChnjQ8XeroNy1t1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-617ddc988f5so34473337b3.2;
        Mon, 15 Apr 2024 00:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713166126; x=1713770926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6a/Ap2X2HwsKOi3kZt9jVTB+y5dhwn09RXTJ8jidvw=;
        b=esi7LgUIte2foyZSSColAasj4DYIPCq67QHC2RuAP5UP+oO8faaj6MdnKHsB0aVrt1
         93BfAKigyNTEQO4uObOEObSByYJbkQ//ITolBLhcUT52K3IrwacubcV/3+0zTt8bu9s5
         vJHh09Wi/Ypn+BVHmXPWmm58H0SGoq8fQmJyR5xYj5un3+zu075T64kAcUA9AYT3eCTe
         HaWAlqxOgmDB3MBzjQwvxU5luXtab0aWrkj1XSzlOuBCbAAuYwg5limAa+FaO2MOYb+3
         TbKJxtNODIWZoBJGt8+RTsytAWlKyuMfRXumYAEjgIt+LhuHRiOF6Iy78aHJEO9jY6/c
         IFGw==
X-Forwarded-Encrypted: i=1; AJvYcCWz+XM7KNsy/yH/LZslJuhYekeQaf9Kq3YkxLTRmZ1MpsRSSDmF16kN7IzAFGmtZ+DwNn8DqOv/G06h8UT8I8yYzVd03p5HNdhZvuhYY+GYAg5NLj+nKSpOsaqr2iDagrICBvaqC+ya8LiazYvJQfnyX/7L8qnmkIeXUWdi1FBR3/imJYWin9rdW+zrPSS61ZcQY8IBg/L6KTWXaYCbqHMjQbwhz1M9
X-Gm-Message-State: AOJu0YxFB7p/Ta7/teS1bqxey1WdFAb11FWI/FzljN+MvkyTYf8qh8pn
	rRP5YeusffmxY0++SJGYlbf5iRyC+qGV0V05JvtW7hh3mSACBgdYALn5z6Mw
X-Google-Smtp-Source: AGHT+IGfJgTvorSc20twKQN4ueqtChty8uwQlKOzKC67V1KKcTiNE4OPEyD5Y13Ss2ZqstVj8i7Hpg==
X-Received: by 2002:a81:bc4d:0:b0:618:79f5:8d32 with SMTP id b13-20020a81bc4d000000b0061879f58d32mr8177376ywl.48.1713166126549;
        Mon, 15 Apr 2024 00:28:46 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id fq9-20020a05690c350900b0061813dec952sm1977513ywb.1.2024.04.15.00.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 00:28:46 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso2607288276.1;
        Mon, 15 Apr 2024 00:28:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHDqxoVwEm8XzlQVshcc25oq4uN8w8MarDov9o9VEsZ5H2e/v+nbXUN1wlt3E+XS4HvuTz64FqHzYF7qsMMVNssHCHzsuUHU67E2y8ksPMW5Mc42GKYyPKnXOR7mNoigLK8veJbv+H7HHE/LwMg5WoOCvY/LIKtXOOyNBipEnWyjZrht6ZuLAPE4F55nxID1uw9JSN3jVDA/zTTCIAtE6o+M0Xs+Ck
X-Received: by 2002:a25:bcca:0:b0:de0:ea71:9ec9 with SMTP id
 l10-20020a25bcca000000b00de0ea719ec9mr8481223ybm.1.1713166126061; Mon, 15 Apr
 2024 00:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com> <CAPDyKFr405qt58wrqNdSn8bQPRqPKJ1omUZHS_VpQrX5zxUJug@mail.gmail.com>
In-Reply-To: <CAPDyKFr405qt58wrqNdSn8bQPRqPKJ1omUZHS_VpQrX5zxUJug@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Apr 2024 09:28:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRwcYMt7p+xT3svo1RmJ2Tvbamrx4++iYQ-mffKb6ZQQ@mail.gmail.com>
Message-ID: <CAMuHMdXRwcYMt7p+xT3svo1RmJ2Tvbamrx4++iYQ-mffKb6ZQQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] clk: renesas: rzg2l: Add support for power domains
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, geert+renesas@glider.be, 
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Fri, Apr 12, 2024 at 1:31=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> That said, maybe we should start separating and moving the
> power-domain parts out from the clk directory into the pmdomain
> directory instead, that should improve these situations!?

The clk and pmdomain functions are tied rather closely together on
Renesas SoCs, that's why the clock drivers are also pmdomain providers.

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

