Return-Path: <linux-kernel+bounces-110043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A693885943
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5DE28173D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077BE83CBA;
	Thu, 21 Mar 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWbUGSbE"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973E51C2A;
	Thu, 21 Mar 2024 12:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024829; cv=none; b=XmdQlpWi/xTvpJD/pY/D4qYhToLGmsU2S8s8wPu+JSaeT/QTw6QPfAnVMpXK73rhta5eAAebKWEGmfarJubt9TwIE2kN4/DymoAA488fHFbVsI2VgSg0UFRYcH5RZlxx1SsxZ15HyLLw09j2QDs+XthocLD83L9AgRzbigZlC6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024829; c=relaxed/simple;
	bh=6mx7WIlTdb5LyDF4fXNgPqLo2nyDcbsYbdSQ/5pTVjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvFr/5XGnaIYOuS6eiaZUopdAnVDuQTOGZ8FCJ+3dacV1VLhecrS8jdwQnPpNHpgrXoGFkxjUIJhuxiCZ/OuXgE9w4ZBpoFvOaeTKKXWrHCJHMYWYdHvJNmysM38jQjEp3YOXNyKwv9toLuw7RvngDgrzg7lAOAoxBJONr+Ym+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWbUGSbE; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3685ef364d8so4101205ab.2;
        Thu, 21 Mar 2024 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711024827; x=1711629627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOIhSHjqU/uh+K/PVvVE9nUt07cI81iCG0I2ew6bVhE=;
        b=SWbUGSbEZMaaeSla9ZMEuJfIzi3oPtzsFogxRwry13uplsJFJ1maSv8adQHKXKxjuX
         QadO9wRDfjC9kY1bUK7Sl+XZ5Lg4jN12t46boYbfI+ftMujX2lXPhq85pdZ3kyplCF30
         /b61BPxETBVT4J/tRKoeJv/Zcf1li3D8rrQLykhX53tc00+3H0CxoULTFJIGvYHZgNmD
         RILRJaVzmjLsPhqueU9mLqGND8wlLjTuT3hOHSvbigca0JddQHfJiU6yYpxaq3dccmMO
         1cjYRsZYLHpsqeC55zrt7t/i2/1FJQkzwmVnuc0czLk1ntvauy75l9BnszKxXN5RbQ92
         1fIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711024827; x=1711629627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOIhSHjqU/uh+K/PVvVE9nUt07cI81iCG0I2ew6bVhE=;
        b=MrS4+Kbaqx5flDzgrg586hwUjgps65I63IZl8eehocuGA4/gHHcbTpptBIe7CYueN7
         keLsiyZqb+5clLa4kl0fHm5lQ8V52j8j4665Pdx7uJkckzpzsz+Q/pIHT7xqx2V9OOS6
         8Ynhm3NHt+5cey9LMpFEijth4KwG2cZdIjhh1Ub/J+MbfR/ggajanh8MO3SeEXfuIQ8M
         pxDWBkH/GzgzYvyD1W0VHn5cS4bW8xwiZrzJAkHWeq/gMMckIeHGQkGxSFMp7EQJar5C
         VHXOj5sinnQ6F7ey+DDeoSxjMn6ZI7aqBR5o3xe0mCbrZ/kyn6qIEwWiEVem8p4ycZMf
         NEbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDNxEKzb8yT8A3SRZEhJh54pQTw1WB1yZrq/nbIZJ6TceJNmp3fpxr8dqHqiWRLCM8+BNGR5hpcVGmSnscEYh7CIAgn+1S7/vsKGN3xyqZY/rK1UXwUBIRk2x03C1ntHDP7uEDpwnG
X-Gm-Message-State: AOJu0YxnW2X+rG0NlfVO0ETsbv4xBo+7MGoRlTqMWsJKpiQHQ7x4y9Gz
	jGUvTqNeWuphDgRC/r6rZqc3GiyTquUV/qvmjRuDraIFMnH/3hxFza2jZwSohoQ08T0LwSNu4++
	kqNdn8cICuMNRDR2hIfaQ+ap8j3s=
X-Google-Smtp-Source: AGHT+IEAUV9BwLUDGzC+8FO4q13KOefXX5peVfopsxrV6jsRagFbL4/3zLJ+TRtIIPu27WZ1m0DhtyuqIIa+b1mH5Io=
X-Received: by 2002:a92:da48:0:b0:368:64cc:d3f3 with SMTP id
 p8-20020a92da48000000b0036864ccd3f3mr1893172ilq.17.1711024826729; Thu, 21 Mar
 2024 05:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711010211-6825-1-git-send-email-shengjiu.wang@nxp.com> <20240321-apply-swore-f9c17ad3a8d2-mkl@pengutronix.de>
In-Reply-To: <20240321-apply-swore-f9c17ad3a8d2-mkl@pengutronix.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 21 Mar 2024 20:40:15 +0800
Message-ID: <CAA+D8AMh4rPuMFsNht9R=+V7BRf4By=r0guJcTSD0AFjz-gxEw@mail.gmail.com>
Subject: Re: [PATCH v3] clk: imx: imx8mp: Add pm_runtime support for power saving
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, peng.fan@nxp.com, 
	mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-imx@nxp.com, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 5:04=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 21.03.2024 16:36:51, Shengjiu Wang wrote:
> > Add pm_runtime support for power saving. In pm runtime suspend
> > state the registers will be reseted, so add registers save
> > in pm runtime suspend and restore them in pm runtime resume.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > changes in v3:
> > - remove REGS_NUM, use the ARRAY_SIZE
> > - merge clk_imx8mp_audiomix_drvdata and clk_hw_onecell_data together.
>
> Look way nicer, but still room for improvement.
>
> > changes in v2:
> > - move pm_runtime_enable before the clk register
> >
> >  drivers/clk/imx/clk-imx8mp-audiomix.c | 157 ++++++++++++++++++++++----
> >  1 file changed, 136 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/cl=
k-imx8mp-audiomix.c
> > index 55ed211a5e0b..5ae33bce8ad8 100644
> > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > @@ -7,10 +7,12 @@
> >
> >  #include <linux/clk-provider.h>
> >  #include <linux/device.h>
> > +#include <linux/io.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> >
> >  #include <dt-bindings/clock/imx8mp-clock.h>
> >
> > @@ -18,6 +20,7 @@
> >
> >  #define CLKEN0                       0x000
> >  #define CLKEN1                       0x004
> > +#define EARC                 0x200
> >  #define SAI1_MCLK_SEL                0x300
> >  #define SAI2_MCLK_SEL                0x304
> >  #define SAI3_MCLK_SEL                0x308
> > @@ -26,6 +29,11 @@
> >  #define SAI7_MCLK_SEL                0x314
> >  #define PDM_SEL                      0x318
> >  #define SAI_PLL_GNRL_CTL     0x400
> > +#define SAI_PLL_FDIVL_CTL0   0x404
> > +#define SAI_PLL_FDIVL_CTL1   0x408
> > +#define SAI_PLL_SSCG_CTL     0x40C
> > +#define SAI_PLL_MNIT_CTL     0x410
> > +#define IPG_LP_CTRL          0x504
> >
> >  #define SAIn_MCLK1_PARENT(n)                                         \
> >  static const struct clk_parent_data                                  \
> > @@ -182,26 +190,82 @@ static struct clk_imx8mp_audiomix_sel sels[] =3D =
{
> >       CLK_SAIn(7)
> >  };
> >
> > +static const u16 audiomix_regs[] =3D {
> > +     CLKEN0,
> > +     CLKEN1,
> > +     EARC,
> > +     SAI1_MCLK_SEL,
> > +     SAI2_MCLK_SEL,
> > +     SAI3_MCLK_SEL,
> > +     SAI5_MCLK_SEL,
> > +     SAI6_MCLK_SEL,
> > +     SAI7_MCLK_SEL,
> > +     PDM_SEL,
> > +     SAI_PLL_GNRL_CTL,
> > +     SAI_PLL_FDIVL_CTL0,
> > +     SAI_PLL_FDIVL_CTL1,
> > +     SAI_PLL_SSCG_CTL,
> > +     SAI_PLL_MNIT_CTL,
> > +     IPG_LP_CTRL,
> > +};
> > +
> > +struct clk_imx8mp_audiomix_priv {
> > +     void __iomem *base;
> > +     struct clk_hw_onecell_data *clk_hw_data;
> > +     u32 regs_save[ARRAY_SIZE(audiomix_regs)];
>
> Put the "struct clk_hw_onecell_data clk_hw_data" at the end of the
> struct. Then allocating should be easier and you don't need the
> additional pointer.

Ok, will do this change in next version.

Best Regards
Shengjiu Wang
>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

