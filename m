Return-Path: <linux-kernel+bounces-16804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED46824422
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9405DB2398A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B642375C;
	Thu,  4 Jan 2024 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BjfY4km8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4623755
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bbe90357d8so26924539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 06:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704379904; x=1704984704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=or1h/yMnjb6tVAyJBd6HlW28SfRdcpAwUGvNMzv3A58=;
        b=BjfY4km8d2TyCCCvkH/MBBhr/62VTu+nN/Jzh4dEHBEp7XZHum2le35+8dbDHwiMB2
         4VxvXDU8apZ0vkHWsEz8TZct98hFG1qKRLH3MHOW9DcJfov99jizBVBhmsoKGoPMbala
         ywvK6cVy+Oz1uiD0qj9PomcT2GXSmhPGXTN4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704379904; x=1704984704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=or1h/yMnjb6tVAyJBd6HlW28SfRdcpAwUGvNMzv3A58=;
        b=fio7++tbtA0mFpuBbSMjQaWtZO/Aq5oho8j0LUvcM0QzVcad+OVvgsCix4YxhS7aNt
         SoZD+IqoQPnIRS+BEkWmjywcx6NM9xTcaAz/BMQ2RyyqPb6kqqSFA+K3kEzopjc/Z7kS
         42eW0om4v5lF8zlxpq973+Kgce7eMfqKSY6Y8XNe1zD0Uk2ISRx70bi2r6RAjt62ur+f
         7X4Cp3isBnv8qsZ1pVImBVijhEsqO+u1q9FYi0ucEjSsKmALOhpp5dNLV1s0A+XYcPvM
         v5KS4qKSNBTaQnNACMSL/6I8KmP7yE3CoHRqafMOBget7XSQwo2Ok5E6LeL+QCp5tEPU
         Hitg==
X-Gm-Message-State: AOJu0YzH2ppYsCvyf9LWtc2Ezsx8mP4u6kusrGCvapRfh2T++Br0yZ3p
	1VtKCrpeJyx8TDqtn4vlQ+g8+D7ERTFu/CXjLgN1SlUpHwR9
X-Google-Smtp-Source: AGHT+IEYU2DLzWSUIVJNOwHaKCi+sergeBd9wsnJzrR/LxrNBZKPhWi9MLRYEkvnXrh64TiDxyY+/OhPCjGRQQYclA8=
X-Received: by 2002:a05:6e02:1689:b0:35d:58ce:2322 with SMTP id
 f9-20020a056e02168900b0035d58ce2322mr876045ila.5.1704379904640; Thu, 04 Jan
 2024 06:51:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102081402.1226795-1-treapking@chromium.org>
 <eed88b36-ae56-40d3-8588-0d5d75da71a6@collabora.com> <5520e8e3-c75b-480f-b831-c40b5cca029f@collabora.com>
In-Reply-To: <5520e8e3-c75b-480f-b831-c40b5cca029f@collabora.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Thu, 4 Jan 2024 22:51:33 +0800
Message-ID: <CAEXTbpeqRsWNgZE3ZgcFKogxv-tjAmQT=D6o6X4ViuG5ZZFCHQ@mail.gmail.com>
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

Hi Eugen and Angelo,

Unfortunately, I don't have a way to reliably reproduce this either.

We notice this issue from the automatic crash reports sent from the
users, but we are still not able to reproduce this locally.  So our
plan is to ship this patch to the users and see if the crash rate goes
down after a month or so.

Regards,
Pin-yen

On Wed, Jan 3, 2024 at 9:20=E2=80=AFPM Eugen Hristev
<eugen.hristev@collabora.com> wrote:
>
> On 1/3/24 14:19, AngeloGioacchino Del Regno wrote:
> > Il 02/01/24 09:12, Pin-yen Lin ha scritto:
> >> Introduce a new need_pm_runtime variable to mtk_clk_desc to indicate
> >> this clock needs a runtime PM get on the clock controller during the
> >> probing stage.
> >>
> >> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> >
> > Hello Pin-yen,
> >
> > We have experienced something similar, but it was really hard to reprod=
uce after
> > some changes.
> >
> > In an effort to try to solve this issue (but again, reproducing is real=
ly hard),
> > Eugen has sent a commit in the hope that someone else found a way to ea=
sily
> > reproduce. Please look at [1].
> >
> > I'm also adding Eugen to the Cc's of this email.
> >
> > Cheers,
> > Angelo
> >
> > [1]:
> > https://patchwork.kernel.org/project/linux-pm/patch/20231225133615.7899=
3-1-eugen.hristev@collabora.com/
>
> Hello Pin-yen,
>
> Can you try my patch and let me know if this changes anything for you ?
>
> If it does not change anything, can you also try this one as well ? It's =
another
> attempt to fix the synchronization with genpd.
>
> https://lore.kernel.org/linux-arm-kernel/20231129113120.4907-1-eugen.hris=
tev@collabora.com/
>
> Thanks,
> Eugen
>
> >
> >> ---
> >>
> >> Changes in v2:
> >> - Fix the order of error handling
> >> - Update the commit message and add a comment before the runtime PM ca=
ll
> >>
> >>   drivers/clk/mediatek/clk-mtk.c | 15 +++++++++++++++
> >>   drivers/clk/mediatek/clk-mtk.h |  2 ++
> >>   2 files changed, 17 insertions(+)
> >>
> >> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk=
-mtk.c
> >> index 2e55368dc4d8..c31e535909c8 100644
> >> --- a/drivers/clk/mediatek/clk-mtk.c
> >> +++ b/drivers/clk/mediatek/clk-mtk.c
> >> @@ -13,6 +13,7 @@
> >>   #include <linux/of.h>
> >>   #include <linux/of_address.h>
> >>   #include <linux/platform_device.h>
> >> +#include <linux/pm_runtime.h>
> >>   #include <linux/slab.h>
> >>
> >>   #include "clk-mtk.h"
> >> @@ -494,6 +495,14 @@ static int __mtk_clk_simple_probe(struct platform=
_device *pdev,
> >>                      return IS_ERR(base) ? PTR_ERR(base) : -ENOMEM;
> >>      }
> >>
> >> +
> >> +    if (mcd->need_runtime_pm) {
> >> +            devm_pm_runtime_enable(&pdev->dev);
> >> +            r =3D pm_runtime_resume_and_get(&pdev->dev);
> >> +            if (r)
> >> +                    return r;
> >> +    }
> >> +
> >>      /* Calculate how many clk_hw_onecell_data entries to allocate */
> >>      num_clks =3D mcd->num_clks + mcd->num_composite_clks;
> >>      num_clks +=3D mcd->num_fixed_clks + mcd->num_factor_clks;
> >> @@ -574,6 +583,9 @@ static int __mtk_clk_simple_probe(struct platform_=
device *pdev,
> >>                      goto unregister_clks;
> >>      }
> >>
> >> +    if (mcd->need_runtime_pm)
> >> +            pm_runtime_put(&pdev->dev);
> >> +
> >>      return r;
> >>
> >>   unregister_clks:
> >> @@ -604,6 +616,9 @@ static int __mtk_clk_simple_probe(struct platform_=
device *pdev,
> >>   free_base:
> >>      if (mcd->shared_io && base)
> >>              iounmap(base);
> >> +
> >> +    if (mcd->need_runtime_pm)
> >> +            pm_runtime_put(&pdev->dev);
> >>      return r;
> >>   }
> >>
> >> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk=
-mtk.h
> >> index 22096501a60a..c17fe1c2d732 100644
> >> --- a/drivers/clk/mediatek/clk-mtk.h
> >> +++ b/drivers/clk/mediatek/clk-mtk.h
> >> @@ -237,6 +237,8 @@ struct mtk_clk_desc {
> >>
> >>      int (*clk_notifier_func)(struct device *dev, struct clk *clk);
> >>      unsigned int mfg_clk_idx;
> >> +
> >> +    bool need_runtime_pm;
> >>   };
> >>
> >>   int mtk_clk_pdev_probe(struct platform_device *pdev);
> >
> >
> >
> >
>

