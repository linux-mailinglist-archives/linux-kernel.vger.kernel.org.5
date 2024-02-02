Return-Path: <linux-kernel+bounces-49028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 892BD8464FB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1520F1F253C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D121396;
	Fri,  2 Feb 2024 00:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpTODJeZ"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071B10E5;
	Fri,  2 Feb 2024 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706833077; cv=none; b=frYWH3K5O9esUMcq8yLuy7ZOTXda64z821pJUb7vujLCXNDroucEFjNN+o2qLR6+9GYLbBWJCdiCb3CrhH3cs1OcnqYqZZwBsLSgk0GXE6ElwTAU+LVsCi0gRpiKpI+vDJA1OC21lVftfqHNC0eANgsYuSX3JpGA2r75HuzIlB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706833077; c=relaxed/simple;
	bh=k2jB5QQ5ayM1QsazOOOPQP4MmZQKKeAb/Ovz7gtJCYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OG2GptuEu36yK32z1uoSvXvwBlwits+hDAIIu9vsW11gB2142kt6d8LQEQKVN5WLc8yCNkxfbmV6Yn0eXleM9JT02CQZUW37BH8CvNwZMi08+7US1cpj0hbA6sNVhjsOg5wn4PtK90KJx5KmoWgDqe26g4lLIKWtS9D1En2MJ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpTODJeZ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so1435488a12.1;
        Thu, 01 Feb 2024 16:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706833075; x=1707437875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=De0VqAzZQlyUqR32McEyDScTzRgzYQCCM/EkMQwWShQ=;
        b=XpTODJeZx2ObDSb5CZl0TZVLOoPxkvX1Zn6nqwBm3NHa9sMlHoKmAE1dZdAMNDbzAI
         bkmtGdPB11V7D+U0LtRNra5fO/Y8MSmXVHAEchb8L15kBOBwshWIH67I/pQ1RFjaNs5G
         pdfdF1SqdxsCQr4OMZmhyqGWCFjxpnIdgfGxY6KzDAa7RMgOR2i5wOOP3lqaSb8iu2Ee
         TvGzRNMjIS4WDMgeE/jzzq4GphfoHhxeRqSFcDf0b9veOu6dqBHPuT3r7Jh6C4LIgkh7
         UrsReup9Jd8cW+vemb0VTMZ5ile8E1VW1dtbuIjzG1532virtS26jgqDLmbBZZIHvA5C
         xUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706833075; x=1707437875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=De0VqAzZQlyUqR32McEyDScTzRgzYQCCM/EkMQwWShQ=;
        b=YaTOXKkM10Itn/p1z/ZgBKrgO7SNFoUIt9gdXXfDn7A352aXUPe8pZoAX3ocT+XS1c
         JIsPd+BwMpWTLMACYwcrX5q4NAuCBYjNIYSxmDtbPi4Zu9T224P9EaGkrvOIsQDHhIY0
         kETa0L8m9DUDUEZM8K6BKj+0aaItf8AuzlntbfCa233jmaNszYUsnrvFEMSB5qBdN04Q
         7Vmh0cNAbzlze1BWSoShHMpaGcBDilxF6s1oR8Aq0depcFbzAu9D8r68V7EDdWkUnIsd
         +RJRFmvleeC8Zt4yP398jEqLe6Zv1KXYkZqVcwrHFvV/MtFF1c49575/N/0QwpbabNh2
         6xIQ==
X-Gm-Message-State: AOJu0Yy/rkKcfT96qFpczOH5U513j1ymG0yIoOR80cObGf8Gi3szEiRC
	EKonn1ToQAlLNZBm94nE/0aqd2Gacr8ZtZm2MtS7Enx4t1eJWkGxIStvsTAM9AVfRL/sC47xJAI
	q/nKpdM10pGZQR1h495WI/Mlu37s=
X-Google-Smtp-Source: AGHT+IEcmeVrBM5Kau+GUw0k5RW62PM8JNo4ZAkPBQ94srraHAG9DfpyENyuu+H+9fFa+ri6+7aDH5bsPcY89GLvCAs=
X-Received: by 2002:a05:6a21:2c82:b0:19c:9d4d:7d7 with SMTP id
 ua2-20020a056a212c8200b0019c9d4d07d7mr5802356pzb.41.1706833074745; Thu, 01
 Feb 2024 16:17:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106223951.387067-1-aford173@gmail.com> <20240106223951.387067-2-aford173@gmail.com>
 <CAPDyKFpx_Xo6Y5yGfuMiV8w3kR2hL6f8t31pKC=91-wEperqjA@mail.gmail.com>
In-Reply-To: <CAPDyKFpx_Xo6Y5yGfuMiV8w3kR2hL6f8t31pKC=91-wEperqjA@mail.gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 1 Feb 2024 18:17:43 -0600
Message-ID: <CAHCN7xLqKTAcVpsBYXmzdvSefOnXdXzzrGie7mxkzeJLFKu+Rw@mail.gmail.com>
Subject: Re: [PATCH 2/3] pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock
 to hdmimix domain
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Sandor Yu <Sandor.yu@nxp.com>, 
	Jacky Bai <ping.bai@nxp.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 4:33=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Sat, 6 Jan 2024 at 23:40, Adam Ford <aford173@gmail.com> wrote:
> >
> > According to i.MX8MP RM and HDMI ADD, the fdcc clock is part of
> > hdmi rx verification IP that should not enable for HDMI TX.
> > But actually if the clock is disabled before HDMI/LCDIF probe,
> > LCDIF will not get pixel clock from HDMI PHY and print the error
> > logs:
> >
> > [CRTC:39:crtc-2] vblank wait timed out
> > WARNING: CPU: 2 PID: 9 at drivers/gpu/drm/drm_atomic_helper.c:1634 drm_=
atomic_helper_wait_for_vblanks.part.0+0x23c/0x260
> >
> > Add fdcc clock to LCDIF and HDMI TX power domains to fix the issue.
> >
> > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
> Just to let you know, this looks good to me and it seems like the NXP
> people like this too. What I am waiting for is an ack on the DT patch,
> then I am ready to queue this up.

What about the bindings?  I'm assuming that Shawn would take the DT
through his IMX tree, but I am not sure if I need to resubmit the
bindings with a different commit message.

adam
>
> Kind regards
> Uffe
>
> > ---
> > The original work was from Sandor on the NXP Down-stream kernel
> >
> > diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/=
imx/imx8mp-blk-ctrl.c
> > index e3203eb6a022..a56f7f92d091 100644
> > --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> > +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> > @@ -55,7 +55,7 @@ struct imx8mp_blk_ctrl_domain_data {
> >         const char *gpc_name;
> >  };
> >
> > -#define DOMAIN_MAX_CLKS 2
> > +#define DOMAIN_MAX_CLKS 3
> >  #define DOMAIN_MAX_PATHS 3
> >
> >  struct imx8mp_blk_ctrl_domain {
> > @@ -457,8 +457,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx=
8mp_hdmi_domain_data[] =3D {
> >         },
> >         [IMX8MP_HDMIBLK_PD_LCDIF] =3D {
> >                 .name =3D "hdmiblk-lcdif",
> > -               .clk_names =3D (const char *[]){ "axi", "apb" },
> > -               .num_clks =3D 2,
> > +               .clk_names =3D (const char *[]){ "axi", "apb", "fdcc" }=
,
> > +               .num_clks =3D 3,
> >                 .gpc_name =3D "lcdif",
> >                 .path_names =3D (const char *[]){"lcdif-hdmi"},
> >                 .num_paths =3D 1,
> > @@ -483,8 +483,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx=
8mp_hdmi_domain_data[] =3D {
> >         },
> >         [IMX8MP_HDMIBLK_PD_HDMI_TX] =3D {
> >                 .name =3D "hdmiblk-hdmi-tx",
> > -               .clk_names =3D (const char *[]){ "apb", "ref_266m" },
> > -               .num_clks =3D 2,
> > +               .clk_names =3D (const char *[]){ "apb", "ref_266m", "fd=
cc" },
> > +               .num_clks =3D 3,
> >                 .gpc_name =3D "hdmi-tx",
> >         },
> >         [IMX8MP_HDMIBLK_PD_HDMI_TX_PHY] =3D {
> > --
> > 2.43.0
> >

