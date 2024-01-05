Return-Path: <linux-kernel+bounces-17607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD1182501C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36577B222EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C20D2136D;
	Fri,  5 Jan 2024 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PWRVAEeG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FD0219FE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3606ebda57cso1663375ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 00:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704444006; x=1705048806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hYTNkHTn/zV3BgYDxe7QnouYI4dlQvnLZozWj8iLVc=;
        b=PWRVAEeGlxA8QXY+YfFjBK53ZxGIpi39YdCIZ2eQO3ZK3yEapdOZSPhSQFytjwNnX6
         GcMTvzbTnbwHE6atKoiZuBBUpP2CVL1OWxpAI3hUjFmu/Z5vUOjW+xcDnvwSV043EfVP
         VLoeReGCrdG+yzn6eESJcXFK5wr2Q+JAOVSLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704444006; x=1705048806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hYTNkHTn/zV3BgYDxe7QnouYI4dlQvnLZozWj8iLVc=;
        b=O0+e3R/7788NOn2ptxgVcjIEN8PGvuRcyAOye9KjAgh224PtRBp0043wZACKFAUNyA
         XQ5GC/99fERK9qBGRMBZnb4SzAOfs6x5mQMHMKWU32+dRr/rj7hZbzExFzexgNFlsizW
         tW13zEIiabJtYlWfdpqBGXrQ0ZomgGnv7mt+Bu1euCuMaAYnMJR9BQ1kPmoqbgS0/Yud
         isrol3Inf6NI/VseVofjVhcRi4Z8evsGum9atzojQ6nxrTSp8jUaOTXyidMEHD48P8wF
         xle/O6b4ezQgn7yJL1c22OUY4ktsyO+cqgXJO9JAKEA0IrIdK5oBFVWaYZqjbTNXr8+S
         lpjQ==
X-Gm-Message-State: AOJu0YyJdOpmajmh23PUYQmS/pjLboHEjJAyAJ1HwkLdazIpKedN5cZL
	k7H2z1pVkOaFdDLqiPaqGxI92kujX122hJLVUQKiWFgncWrB
X-Google-Smtp-Source: AGHT+IG2pc/bVNtoQyA5vLjyh1fbFJLdrI+GkS/9G1KKGXF6RnAflb2KFxD/87ykUzd6ApsxNMt9jeo2n4l5+qagNf8=
X-Received: by 2002:a05:6e02:1aac:b0:35f:ea02:7491 with SMTP id
 l12-20020a056e021aac00b0035fea027491mr2019344ilv.60.1704444005875; Fri, 05
 Jan 2024 00:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102081402.1226795-1-treapking@chromium.org>
 <eed88b36-ae56-40d3-8588-0d5d75da71a6@collabora.com> <5520e8e3-c75b-480f-b831-c40b5cca029f@collabora.com>
 <CAEXTbpeqRsWNgZE3ZgcFKogxv-tjAmQT=D6o6X4ViuG5ZZFCHQ@mail.gmail.com>
In-Reply-To: <CAEXTbpeqRsWNgZE3ZgcFKogxv-tjAmQT=D6o6X4ViuG5ZZFCHQ@mail.gmail.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Fri, 5 Jan 2024 16:39:55 +0800
Message-ID: <CAEXTbpdCHa9M=nMQAOdRiqeQqEB3gHYiwSuVUsPhOD0vCkyY8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: mediatek: Introduce need_pm_runtime to mtk_clk_desc
To: Eugen Hristev <eugen.hristev@collabora.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Weiyi Lu <weiyi.lu@mediatek.com>, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 10:51=E2=80=AFPM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Hi Eugen and Angelo,
>
> Unfortunately, I don't have a way to reliably reproduce this either.
>
> We notice this issue from the automatic crash reports sent from the
> users, but we are still not able to reproduce this locally.  So our
> plan is to ship this patch to the users and see if the crash rate goes
> down after a month or so.
>
> Regards,
> Pin-yen
>
> On Wed, Jan 3, 2024 at 9:20=E2=80=AFPM Eugen Hristev
> <eugen.hristev@collabora.com> wrote:
> >
> > On 1/3/24 14:19, AngeloGioacchino Del Regno wrote:
> > > Il 02/01/24 09:12, Pin-yen Lin ha scritto:
> > >> Introduce a new need_pm_runtime variable to mtk_clk_desc to indicate
> > >> this clock needs a runtime PM get on the clock controller during the
> > >> probing stage.
> > >>
> > >> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > >
> > > Hello Pin-yen,
> > >
> > > We have experienced something similar, but it was really hard to repr=
oduce after
> > > some changes.
> > >
> > > In an effort to try to solve this issue (but again, reproducing is re=
ally hard),
> > > Eugen has sent a commit in the hope that someone else found a way to =
easily
> > > reproduce. Please look at [1].
> > >
> > > I'm also adding Eugen to the Cc's of this email.
> > >
> > > Cheers,
> > > Angelo
> > >
> > > [1]:
> > > https://patchwork.kernel.org/project/linux-pm/patch/20231225133615.78=
993-1-eugen.hristev@collabora.com/
> >
> > Hello Pin-yen,
> >
> > Can you try my patch and let me know if this changes anything for you ?
> >
> > If it does not change anything, can you also try this one as well ? It'=
s another
> > attempt to fix the synchronization with genpd.
> >
> > https://lore.kernel.org/linux-arm-kernel/20231129113120.4907-1-eugen.hr=
istev@collabora.com/
> >
> > Thanks,
> > Eugen

Hi Eugen and Angelo,

After the offline discussion with Chen-yu, we think this series is
solving a different issue from the patches you mentioned. This one is
trying to resolve a deadlock in the probe stage, and more details can
be found in the commit message of the next patch. The referenced
patches seem to be fixing other race conditions on powering on/off the
power domain. Sorry for adding the wrong commit message and maybe
leading to incorrect understanding on this series.

By the way, sorry for the top posting in the previous mail.

Regards,
Pin-yen
> >
> > >
> > >> ---
> > >>
> > >> Changes in v2:
> > >> - Fix the order of error handling
> > >> - Update the commit message and add a comment before the runtime PM =
call
> > >>
> > >>   drivers/clk/mediatek/clk-mtk.c | 15 +++++++++++++++
> > >>   drivers/clk/mediatek/clk-mtk.h |  2 ++
> > >>   2 files changed, 17 insertions(+)
> > >>
> > >> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/c=
lk-mtk.c
> > >> index 2e55368dc4d8..c31e535909c8 100644
> > >> --- a/drivers/clk/mediatek/clk-mtk.c
> > >> +++ b/drivers/clk/mediatek/clk-mtk.c
> > >> @@ -13,6 +13,7 @@
> > >>   #include <linux/of.h>
> > >>   #include <linux/of_address.h>
> > >>   #include <linux/platform_device.h>
> > >> +#include <linux/pm_runtime.h>
> > >>   #include <linux/slab.h>
> > >>
> > >>   #include "clk-mtk.h"
> > >> @@ -494,6 +495,14 @@ static int __mtk_clk_simple_probe(struct platfo=
rm_device *pdev,
> > >>                      return IS_ERR(base) ? PTR_ERR(base) : -ENOMEM;
> > >>      }
> > >>
> > >> +
> > >> +    if (mcd->need_runtime_pm) {
> > >> +            devm_pm_runtime_enable(&pdev->dev);
> > >> +            r =3D pm_runtime_resume_and_get(&pdev->dev);
> > >> +            if (r)
> > >> +                    return r;
> > >> +    }
> > >> +
> > >>      /* Calculate how many clk_hw_onecell_data entries to allocate *=
/
> > >>      num_clks =3D mcd->num_clks + mcd->num_composite_clks;
> > >>      num_clks +=3D mcd->num_fixed_clks + mcd->num_factor_clks;
> > >> @@ -574,6 +583,9 @@ static int __mtk_clk_simple_probe(struct platfor=
m_device *pdev,
> > >>                      goto unregister_clks;
> > >>      }
> > >>
> > >> +    if (mcd->need_runtime_pm)
> > >> +            pm_runtime_put(&pdev->dev);
> > >> +
> > >>      return r;
> > >>
> > >>   unregister_clks:
> > >> @@ -604,6 +616,9 @@ static int __mtk_clk_simple_probe(struct platfor=
m_device *pdev,
> > >>   free_base:
> > >>      if (mcd->shared_io && base)
> > >>              iounmap(base);
> > >> +
> > >> +    if (mcd->need_runtime_pm)
> > >> +            pm_runtime_put(&pdev->dev);
> > >>      return r;
> > >>   }
> > >>
> > >> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/c=
lk-mtk.h
> > >> index 22096501a60a..c17fe1c2d732 100644
> > >> --- a/drivers/clk/mediatek/clk-mtk.h
> > >> +++ b/drivers/clk/mediatek/clk-mtk.h
> > >> @@ -237,6 +237,8 @@ struct mtk_clk_desc {
> > >>
> > >>      int (*clk_notifier_func)(struct device *dev, struct clk *clk);
> > >>      unsigned int mfg_clk_idx;
> > >> +
> > >> +    bool need_runtime_pm;
> > >>   };
> > >>
> > >>   int mtk_clk_pdev_probe(struct platform_device *pdev);
> > >
> > >
> > >
> > >
> >

