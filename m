Return-Path: <linux-kernel+bounces-12384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7591081F3E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ABC31C2193C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB863D2;
	Thu, 28 Dec 2023 01:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="boaX16/u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC45613C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ccc34a9f90so26946141fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703727955; x=1704332755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abPHoTgkKdKqNv7pVii73M9V/jiTguCmzH4R/B50i7k=;
        b=boaX16/uPmjxMEQGH3Oh2SDlkIQyduzJBCnJLuzucXiIMUdlmYFYD+bSsrI0xU3qKG
         PlXXwa+ONVxCHi0+EJFjxeQp/1okTC+/Nz9yR9j5Fs1BUDJVwkDAds9XJMs7rwa3D+oJ
         hbaZV+2ux71SPg/cXYPRmEDXiOHENXcUWwf4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727955; x=1704332755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abPHoTgkKdKqNv7pVii73M9V/jiTguCmzH4R/B50i7k=;
        b=pkoC3OwnCt3ZEjrLjmcuTVZjUs626PYgLZIbpyjFPMOBRKNO+koFU0e2Hap6SrzyMp
         qdtwe1pY+G77JUUWlmvFxOys1rxYNTDl3CZ1Af7pyysm08YhBy1d29OiJDhIRZd8kzgh
         iDzQMFcKhagKFCD3YHkCZJ9K+Ryh55ktZEcuXOuXsrUCJZEDAGRoAHThK2jLm1MrD93w
         xYfaLUPTOo5xRoVuqu60h0TZpTjJSON5Qk6EnVpIdosaVU6kRzfIHRC+HpZCMQSN6wtX
         qjQFmT1gCP/ex4MUQXuRnx+301NVPsSJxGSWGdWzEB3LC9BZ2uEAPW7p5g5pE7coyvcB
         vhLg==
X-Gm-Message-State: AOJu0Yy6RE4opNCxESfl0Pnejx85x6vTOaRMzbxVVHI6vat7GZayetG2
	9tzJkzUIeala0IfCtFY/eDue28WbrRHu5Tt+FKZXYhQ8n0u7
X-Google-Smtp-Source: AGHT+IFyQEVrdKaoeisrsf6Cy6K+2KeyCzfsqubA3HFnZaUvyDBGCdUMwxp3ymD+S4mf0mWRWa1471JPFZh8SGIkSiM=
X-Received: by 2002:a2e:460a:0:b0:2cc:7445:bbc2 with SMTP id
 t10-20020a2e460a000000b002cc7445bbc2mr3496636lja.32.1703727955400; Wed, 27
 Dec 2023 17:45:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227090448.2216295-1-treapking@chromium.org>
In-Reply-To: <20231227090448.2216295-1-treapking@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 28 Dec 2023 10:45:44 +0900
Message-ID: <CAGXv+5E-vn4pCCJr-Qs4tcbMAyGBWk4YQEzm=fkHjE0U9nBpiA@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: mediatek: Introduce need_pm_runtime to mtk_clk_desc
To: Pin-yen Lin <treapking@chromium.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Weiyi Lu <weiyi.lu@mediatek.com>, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 6:05=E2=80=AFPM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Introduce a new need_pm_runtime variable to mtk_clk_desc to indicate this
> clock needs a runtime PM get during the probing stage.

Actually it means (based on our discussions and your code here) that
runtime PM should be enabled for the clock controller. If runtime PM
is not enabled before the clocks are registered, the CCF subsequently
never toggles runtime PM.

The runtime PM get during the probe stage is to avoid triggering runtime
suspend/resume during each clock registration, and hopefully avoid a
deadlock. It should be mentioned separately. A comment should be added
so that folks going over the code in the future don't remove it.

> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
>  drivers/clk/mediatek/clk-mtk.c | 15 +++++++++++++++
>  drivers/clk/mediatek/clk-mtk.h |  2 ++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mt=
k.c
> index 2e55368dc4d8..c31e535909c8 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -13,6 +13,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>
>  #include "clk-mtk.h"
> @@ -494,6 +495,14 @@ static int __mtk_clk_simple_probe(struct platform_de=
vice *pdev,
>                         return IS_ERR(base) ? PTR_ERR(base) : -ENOMEM;
>         }
>
> +
> +       if (mcd->need_runtime_pm) {
> +               devm_pm_runtime_enable(&pdev->dev);
> +               r =3D pm_runtime_resume_and_get(&pdev->dev);

A comment for the resume and get should be added. Otherwise someone looking
at this and the CCF could think that this isn't needed, since the CCF alrea=
dy
has similar calls.

> +               if (r)
> +                       return r;
> +       }
> +
>         /* Calculate how many clk_hw_onecell_data entries to allocate */
>         num_clks =3D mcd->num_clks + mcd->num_composite_clks;
>         num_clks +=3D mcd->num_fixed_clks + mcd->num_factor_clks;
> @@ -574,6 +583,9 @@ static int __mtk_clk_simple_probe(struct platform_dev=
ice *pdev,
>                         goto unregister_clks;
>         }
>
> +       if (mcd->need_runtime_pm)
> +               pm_runtime_put(&pdev->dev);
> +
>         return r;
>
>  unregister_clks:
> @@ -604,6 +616,9 @@ static int __mtk_clk_simple_probe(struct platform_dev=
ice *pdev,
>  free_base:
>         if (mcd->shared_io && base)
>                 iounmap(base);
> +
> +       if (mcd->need_runtime_pm)
> +               pm_runtime_put(&pdev->dev);

Please keep the error path calls strictly in reverse order of the setup
calls. So this should go before iounmap().

ChenYu

>         return r;
>  }

> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mt=
k.h
> index 22096501a60a..c17fe1c2d732 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -237,6 +237,8 @@ struct mtk_clk_desc {
>
>         int (*clk_notifier_func)(struct device *dev, struct clk *clk);
>         unsigned int mfg_clk_idx;
> +
> +       bool need_runtime_pm;
>  };
>
>  int mtk_clk_pdev_probe(struct platform_device *pdev);
> --
> 2.43.0.472.g3155946c3a-goog
>

