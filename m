Return-Path: <linux-kernel+bounces-80064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AE6862A5D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64865281A99
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EAA10A3C;
	Sun, 25 Feb 2024 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO/brShb"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354BEEC4;
	Sun, 25 Feb 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708865468; cv=none; b=SUa9T2rasdYJBRyRs11XbA2oH4iggbTEf0PcGDnGECJS0omWCggHy4E65DlaEhjsTeFPT4TTxwn2WvxN01aaFBflyGXn8/DoH7k+FZqb9DnbOWRqvv9oqRYUBtCMEzGfDpXgj6Qyp1x8YoWJjkzd1aLWXEOFwYjvMf/v7tF/hdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708865468; c=relaxed/simple;
	bh=LV8NUdW6RjNKw/p7GpcPMqOywDXbzVth2RBSHc3P+N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVyopKR35gorEYVK2oERUqlNqHgGRmjX5UyFAJvu3398gZxbUtKvnC3j5VyAFOMczEhI7WOa27tDjSxdinuc3bM1zu7UuG0+FzSVNTaCNGi/j66PWxoD6tHqoTQQmqeiuNueN/XlFITABwdtCKsg/JMbzm0lN0i+5RPiyjbRnnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO/brShb; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so1699707a12.0;
        Sun, 25 Feb 2024 04:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708865466; x=1709470266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12aX47kHcv5AY9wntuyrJpnc0F5cXex3aE9iWxcZ+78=;
        b=kO/brShb+hESTp8j2xyI6BMoM/PUid6xSAfpU3HMOmmd1TdiPrC1kpbyQbVNlpA1wG
         Y9XMFXwK/42El6sfEFL9fE0KnselwAeNzxwth3xRC0+6XjtTgykNww+2UcnzQnkCOyI0
         MLj/lSiXu51bK5BiKdwiB18JBNXdaYHQJgx6w5nLNs+Luty/KAUj8R2xi3GkJbdcrpFv
         BgStufm2TG4m2mjYxvy6uE3q9PggoeoktZsCprwOaVOQ7iADZXxy9U+d1ixgD+CrCGmk
         xHbeREfDgyvflOs1rZuP1osnXbEmL1ldlKPL7QkdLkAHvRUjMrLaA39PH87vwCaUlhfg
         L2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708865466; x=1709470266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12aX47kHcv5AY9wntuyrJpnc0F5cXex3aE9iWxcZ+78=;
        b=f7jLesVR2TUZ0Xb0HWH6GeqyjRIVN55zpPQ2+H2ubpDHGp3W90bjz0dJyApml6wNuL
         4mKq7T56hr/dEizOvjWMW+nVG/jrnAHzsqYUkGhtAIsRiYR3t4ypjgj4g3+6gJIhClk3
         +TOEUumeCN0xdCEZEtCBRTLZk+TZpPvFE0J/RjYXGnawiEemFPuqfpZwG18SufUjdSTu
         6dRkqvhd6Fr5x8/IDFcbcVxQVGTpV+oV4FEIWcWuAl4Pf7sOKTX/A1bi0pLna6u8K+sJ
         zomuQ2xFycqh9ZE4mLrl8+f68+BKXaJKaxHv1EmQsNYAoSre/7vW+vzqGcxmMjyZcWqT
         tUZg==
X-Forwarded-Encrypted: i=1; AJvYcCVIOWnnG/9EsFF5teupTVVj6a+h3rKZKrv+tejx5pz8gs5Vi+rF7g1znv8SmDSCR/jvS+OTydRt5+r+voPQMUXvomqPn1H0hX4pUexI
X-Gm-Message-State: AOJu0YysVHMAkXjo5DoevNI3s5ELG8vIxrJZ5n2xwZnnu+dyOgqQ8uNh
	VxkcBqlKEqyU9Non0EELhJQjbA3sJNzf9thrOet8kwn9+84C/hxxCWuah7hIoG57PWw4oOeDwsJ
	9G7JJOwDuTkPnBRHBz1ip5jbpSpY=
X-Google-Smtp-Source: AGHT+IEREUneg3qE5Uf8S3wKxX9AgvbladiQ0uzjUAHMa98qvRFFP+b891VWO7loPfAs/te47M1syrnZR2RTyIoJoYg=
X-Received: by 2002:a05:6a20:d394:b0:1a0:f6ea:f41c with SMTP id
 iq20-20020a056a20d39400b001a0f6eaf41cmr1263314pzb.13.1708865466114; Sun, 25
 Feb 2024 04:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225065234.413687-1-mmyangfl@gmail.com> <20240225065234.413687-2-mmyangfl@gmail.com>
 <SEZPR06MB6959206A186224697CD13971965B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
In-Reply-To: <SEZPR06MB6959206A186224697CD13971965B2@SEZPR06MB6959.apcprd06.prod.outlook.com>
From: Yangfl <mmyangfl@gmail.com>
Date: Sun, 25 Feb 2024 20:50:29 +0800
Message-ID: <CAAXyoMM0VHHtQc9GevPqaLNTjyWbvMr88LjvxKAwEK=U_shL6Q@mail.gmail.com>
Subject: Re: [PATCH v7 01/13] clk: hisilicon: Add helper functions for
 platform driver
To: Yang Xiwen <forbidden405@outlook.com>
Cc: linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yang Xiwen <forbidden405@outlook.com> =E4=BA=8E2024=E5=B9=B42=E6=9C=8825=E6=
=97=A5=E5=91=A8=E6=97=A5 19:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2/25/2024 2:52 PM, David Yang wrote:
> > Helper functions extract common operations on platform drivers.
> >
> > During migration to devm APIs, (virtual) fixed clocks were found hard o=
n
> > devm APIs, since they often depended by crucial peripherals, thus requi=
re
> > early initialization before device probing, and cannot use devm APIs.
>
>
> We have core_initcall() in drivers so CRGs are probed very early. This
> shouldn't be a problem.
>

This is also handled within hisi_clk_early_init(), and tested against
real devices.

>
> >
> > One solution to this problem is to add a "fixed-clock" node to device t=
ree,
> > independent to clock device, and make those peripherals depend on that.
> > However, there is also some devices that do use fixed clocks provided b=
y
> > drivers, for example clk-hi3660.c .
> >
> > To simplify codes, we migrate clocks of other types to devm APIs, while
> > keep fixed clocks self-managed, alongside with struct hisi_clock_data, =
and
> > remove devm-managed hisi_clock_data.
>
>
> Do we really want? How about leave old SoCs alone and just introduce a
> new set of APIs for new SoCs?
>
>
> Just like CCF, devm_ functions are simply wrappers of old APIs with the
> help of devres, the old APIs are still available.
>
>
> So for HiSilicon, I think we can take a similar approach, i.e., add a
> new set of wrapper functions with the help of devres rather than
> modifying old code.
>
>
> The implementation of officially provided devm_ APIs can be a good exampl=
e.
>

This is somewhat requested by the maintainer, see replies in v5 of the
previous series
https://lore.kernel.org/all/d3b057408117a71bcd153f4a91bcdfe1.sboyd@kernel.o=
rg/

While this series migrates into devm_, it mainly serves as a cleanup.
Existing drivers share most of registration flows, while lack of
proper maintenance over times. This series improves overall code
quality, and reduce redundancy code by introducing newly-designed
common functions.

We might as well keep old API, but this series has no intention on how
new device will be introduced.

>
> >
> > `hisi_clk_alloc` will be removed in the following patch.
> >
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> >   drivers/clk/hisilicon/clk.c   | 157 +++++++++++++++++++++++++++++++++=
+
> >   drivers/clk/hisilicon/clk.h   |  46 +++++++++-
> >   drivers/clk/hisilicon/crg.h   |   5 ++
> >   drivers/clk/hisilicon/reset.c |  42 +++++++++
> >   4 files changed, 248 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
> > index 09368fd32bef..e50115f8e236 100644
> > --- a/drivers/clk/hisilicon/clk.c
> > +++ b/drivers/clk/hisilicon/clk.c
> > @@ -88,6 +88,25 @@ struct hisi_clock_data *hisi_clk_init(struct device_=
node *np,
> >   }
> >   EXPORT_SYMBOL_GPL(hisi_clk_init);
> >
> > +void hisi_clk_free(struct device_node *np, struct hisi_clock_data *dat=
a)
> > +{
> > +     if (data->clks) {
> > +             if (data->clks->fixed_rate_clks_num)
> > +                     hisi_clk_unregister_fixed_rate(data->clks->fixed_=
rate_clks,
> > +                                                    data->clks->fixed_=
rate_clks_num,
> > +                                                    data);
> > +             if (data->clks->fixed_factor_clks_num)
> > +                     hisi_clk_unregister_fixed_factor(data->clks->fixe=
d_factor_clks,
> > +                                                      data->clks->fixe=
d_factor_clks_num,
> > +                                                      data);
> > +     }
> > +
> > +     of_clk_del_provider(np);
> > +     kfree(data->clk_data.clks);
> > +     kfree(data);
> > +}
> > +EXPORT_SYMBOL_GPL(hisi_clk_free);
> > +
> >   int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *=
clks,
> >                                        int nums, struct hisi_clock_data=
 *data)
> >   {
> > @@ -341,3 +360,141 @@ void __init hi6220_clk_register_divider(const str=
uct hi6220_divider_clock *clks,
> >               data->clk_data.clks[clks[i].id] =3D clk;
> >       }
> >   }
> > +
> > +static size_t hisi_clocks_get_nr(const struct hisi_clocks *clks)
> > +{
> > +     if (clks->nr)
> > +             return clks->nr;
> > +
> > +     return clks->fixed_rate_clks_num + clks->fixed_factor_clks_num +
> > +             clks->mux_clks_num + clks->phase_clks_num +
> > +             clks->divider_clks_num + clks->gate_clks_num +
> > +             clks->gate_sep_clks_num + clks->customized_clks_num;
> > +}
> > +
> > +int hisi_clk_early_init(struct device_node *np, const struct hisi_cloc=
ks *clks)
> > +{
> > +     struct hisi_clock_data *data;
> > +     int ret;
> > +
> > +     data =3D hisi_clk_init(np, hisi_clocks_get_nr(clks));
> > +     if (!data)
> > +             return -ENOMEM;
> > +     data->clks =3D clks;
> > +
> > +     ret =3D hisi_clk_register_fixed_rate(clks->fixed_rate_clks,
> > +                                        clks->fixed_rate_clks_num, dat=
a);
> > +     if (ret)
> > +             goto err;
> > +
> > +     ret =3D hisi_clk_register_fixed_factor(clks->fixed_factor_clks,
> > +                                          clks->fixed_factor_clks_num,=
 data);
> > +     if (ret)
> > +             goto err;
> > +
> > +     np->data =3D data;
> > +     return 0;
> > +
> > +err:
> > +     hisi_clk_free(np, data);
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(hisi_clk_early_init);
> > +
> > +static int hisi_clk_register(struct device *dev, const struct hisi_clo=
cks *clks,
> > +                          struct hisi_clock_data *data)
> > +{
> > +     int ret;
> > +
> > +     if (clks->mux_clks_num) {
> > +             ret =3D hisi_clk_register_mux(clks->mux_clks,
> > +                                         clks->mux_clks_num, data);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     if (clks->phase_clks_num) {
> > +             ret =3D hisi_clk_register_phase(dev, clks->phase_clks,
> > +                                           clks->phase_clks_num, data)=
;
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     if (clks->divider_clks_num) {
> > +             ret =3D hisi_clk_register_divider(clks->divider_clks,
> > +                                             clks->divider_clks_num, d=
ata);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     if (clks->gate_clks_num) {
> > +             ret =3D hisi_clk_register_gate(clks->gate_clks,
> > +                                          clks->gate_clks_num, data);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     if (clks->gate_sep_clks_num) {
> > +             hisi_clk_register_gate_sep(clks->gate_sep_clks,
> > +                                        clks->gate_sep_clks_num, data)=
;
> > +     }
> > +
> > +     if (clks->clk_register_customized && clks->customized_clks_num) {
> > +             ret =3D clks->clk_register_customized(dev, clks->customiz=
ed_clks,
> > +                                                 clks->customized_clks=
_num, data);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +int hisi_clk_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct device_node *np =3D dev->of_node;
> > +     const struct hisi_clocks *clks;
> > +     struct hisi_clock_data *data;
> > +     int ret;
> > +
> > +     clks =3D of_device_get_match_data(dev);
> > +     if (!clks)
> > +             return -ENOENT;
> > +
> > +     if (!np->data) {
> > +             ret =3D hisi_clk_early_init(np, clks);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     data =3D np->data;
> > +     np->data =3D NULL;
> > +
> > +     if (clks->prologue) {
> > +             ret =3D clks->prologue(dev, data);
> > +             if (ret)
> > +                     goto err;
> > +     }
> > +
> > +     ret =3D hisi_clk_register(dev, clks, data);
> > +     if (ret)
> > +             goto err;
> > +
> > +     platform_set_drvdata(pdev, data);
> > +     return 0;
> > +
> > +err:
> > +     hisi_clk_free(np, data);
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(hisi_clk_probe);
> > +
> > +void hisi_clk_remove(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct device_node *np =3D dev->of_node;
> > +     struct hisi_clock_data *data =3D platform_get_drvdata(pdev);
> > +
> > +     hisi_clk_free(np, data);
> > +}
> > +EXPORT_SYMBOL_GPL(hisi_clk_remove);
> > diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
> > index 7a9b42e1b027..87b17e9b79a3 100644
> > --- a/drivers/clk/hisilicon/clk.h
> > +++ b/drivers/clk/hisilicon/clk.h
> > @@ -17,10 +17,12 @@
> >   #include <linux/spinlock.h>
> >
> >   struct platform_device;
> > +struct hisi_clocks;
> >
> >   struct hisi_clock_data {
> > -     struct clk_onecell_data clk_data;
> > -     void __iomem            *base;
> > +     struct clk_onecell_data         clk_data;
> > +     void __iomem                    *base;
> > +     const struct hisi_clocks        *clks;
> >   };
> >
> >   struct hisi_fixed_rate_clock {
> > @@ -103,6 +105,39 @@ struct hisi_gate_clock {
> >       const char              *alias;
> >   };
> >
> > +struct hisi_clocks {
> > +     /* if 0, sum all *_num */
> > +     size_t nr;
> > +
> > +     int (*prologue)(struct device *dev, struct hisi_clock_data *data)=
;
> > +
> > +     const struct hisi_fixed_rate_clock *fixed_rate_clks;
> > +     size_t fixed_rate_clks_num;
> > +
> > +     const struct hisi_fixed_factor_clock *fixed_factor_clks;
> > +     size_t fixed_factor_clks_num;
> > +
> > +     const struct hisi_mux_clock *mux_clks;
> > +     size_t mux_clks_num;
> > +
> > +     const struct hisi_phase_clock *phase_clks;
> > +     size_t phase_clks_num;
> > +
> > +     const struct hisi_divider_clock *divider_clks;
> > +     size_t divider_clks_num;
> > +
> > +     const struct hisi_gate_clock *gate_clks;
> > +     size_t gate_clks_num;
> > +
> > +     const struct hisi_gate_clock *gate_sep_clks;
> > +     size_t gate_sep_clks_num;
> > +
> > +     const void *customized_clks;
> > +     size_t customized_clks_num;
> > +     int (*clk_register_customized)(struct device *dev, const void *cl=
ks,
> > +                                    size_t num, struct hisi_clock_data=
 *data);
> > +};
> > +
> >   struct clk *hisi_register_clkgate_sep(struct device *, const char *,
> >                               const char *, unsigned long,
> >                               void __iomem *, u8,
> > @@ -113,6 +148,7 @@ struct clk *hi6220_register_clkdiv(struct device *d=
ev, const char *name,
> >
> >   struct hisi_clock_data *hisi_clk_alloc(struct platform_device *, int)=
;
> >   struct hisi_clock_data *hisi_clk_init(struct device_node *, int);
> > +void hisi_clk_free(struct device_node *np, struct hisi_clock_data *dat=
a);
> >   int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *=
,
> >                               int, struct hisi_clock_data *);
> >   int hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clo=
ck *,
> > @@ -154,4 +190,10 @@ hisi_clk_unregister(mux)
> >   hisi_clk_unregister(divider)
> >   hisi_clk_unregister(gate)
> >
> > +/* helper functions for platform driver */
> > +
> > +int hisi_clk_early_init(struct device_node *np, const struct hisi_cloc=
ks *clks);
> > +int hisi_clk_probe(struct platform_device *pdev);
> > +void hisi_clk_remove(struct platform_device *pdev);
> > +
> >   #endif      /* __HISI_CLK_H */
> > diff --git a/drivers/clk/hisilicon/crg.h b/drivers/clk/hisilicon/crg.h
> > index 803f6ba6d7a2..bd8e76b1f6d7 100644
> > --- a/drivers/clk/hisilicon/crg.h
> > +++ b/drivers/clk/hisilicon/crg.h
> > @@ -22,4 +22,9 @@ struct hisi_crg_dev {
> >       const struct hisi_crg_funcs *funcs;
> >   };
> >
> > +/* helper functions for platform driver */
> > +
> > +int hisi_crg_probe(struct platform_device *pdev);
> > +void hisi_crg_remove(struct platform_device *pdev);
> > +
> >   #endif      /* __HISI_CRG_H */
> > diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/rese=
t.c
> > index 93cee17db8b1..c7d4c9ea7183 100644
> > --- a/drivers/clk/hisilicon/reset.c
> > +++ b/drivers/clk/hisilicon/reset.c
> > @@ -6,11 +6,15 @@
> >    */
> >
> >   #include <linux/io.h>
> > +#include <linux/kernel.h>
> >   #include <linux/of_address.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/reset-controller.h>
> >   #include <linux/slab.h>
> >   #include <linux/spinlock.h>
> > +
> > +#include "clk.h"
> > +#include "crg.h"
> >   #include "reset.h"
> >
> >   #define     HISI_RESET_BIT_MASK     0x1f
> > @@ -116,3 +120,41 @@ void hisi_reset_exit(struct hisi_reset_controller =
*rstc)
> >       reset_controller_unregister(&rstc->rcdev);
> >   }
> >   EXPORT_SYMBOL_GPL(hisi_reset_exit);
> > +
> > +int hisi_crg_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct hisi_crg_dev *crg;
> > +     int ret;
> > +
> > +     crg =3D devm_kmalloc(dev, sizeof(*crg), GFP_KERNEL);
> > +     if (!crg)
> > +             return -ENOMEM;
> > +
> > +     ret =3D hisi_clk_probe(pdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     crg->rstc =3D hisi_reset_init(pdev);
> > +     if (!crg->rstc) {
> > +             ret =3D -ENOMEM;
> > +             goto err;
> > +     }
> > +
> > +     platform_set_drvdata(pdev, crg);
> > +     return 0;
> > +
> > +err:
> > +     hisi_clk_remove(pdev);
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(hisi_crg_probe);
> > +
> > +void hisi_crg_remove(struct platform_device *pdev)
> > +{
> > +     struct hisi_crg_dev *crg =3D platform_get_drvdata(pdev);
> > +
> > +     hisi_reset_exit(crg->rstc);
> > +     hisi_clk_remove(pdev);
> > +}
> > +EXPORT_SYMBOL_GPL(hisi_crg_remove);
>
>
> --
> Regards,
> Yang Xiwen
>

