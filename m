Return-Path: <linux-kernel+bounces-41354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A74F883EF77
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8CB1C227D8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463152E412;
	Sat, 27 Jan 2024 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmxeDqHb"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190412D60C;
	Sat, 27 Jan 2024 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706379604; cv=none; b=FvE0SOh8WN2V+H/WzN5bPo1ZiZIsSM/NxmUJE4IuYNLwpsSEWJqcdUii+nY+m11MsseCuvZ1uaezeX0uewdV3U9+9K0WcatsCCrXDqWvGabSiWBrtTzlvjIRIt+DXUJoIHtw2hBNTg0Kns5JmV3HQXtPSbPpB5v9HdvOv7i5Spw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706379604; c=relaxed/simple;
	bh=3qf/Tcsst6PvPX+mtlEE/pY7q7lnHOq8wve0vPMLfeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqT1TXqV7eMcVdVg3l+50maIGzOfFiYKD9OQmeDGnWZmKR6J+c7fJepRvm5xtyBUAHVSwMP5GS0J24sCXUgeceN7ujiuasV7u87i+GV+kvAjFtJsrSOOjbCUeM9vLij5EmNqlfpEWv9i+7ZZqe0uKwVOixIW+Q3l6lz2a3wrK68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmxeDqHb; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bded20a30eso1039593b6e.2;
        Sat, 27 Jan 2024 10:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706379602; x=1706984402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kItuuplq9gKxvPdah7o7cU5Dr7iTWQBKGEy/GZ0EpAA=;
        b=EmxeDqHbdY8L9oCWNvovK+t6VQZEyrydRVk4ZfrvIBldHkwnJgsC128O3jSsJmYF7R
         sCl87tFch/F9yg+QOUe862l6Qn7Or4j1zADzKj54u38zFwMry+kKm46pI9DrnnZB8osA
         3exQ+NUEVcDDxdR30t3dJpDXDhQgM0sTwnf+n8rxATWkHhJghKsEmgek2DYzgchH4CPw
         2/w02xgwI/Ycumnfhl1hOFTxhclfgPxBEoXlTWT97JrklpLmIhNbIFDFAXSNa8u83wB3
         fU3xy79DlE906A8eJb8skCyEgv1BXL8vTyC3wgmcOgdjJ99SiDTsGONAxXJQLmYwxRF3
         /x/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706379602; x=1706984402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kItuuplq9gKxvPdah7o7cU5Dr7iTWQBKGEy/GZ0EpAA=;
        b=jYRQbjW19/aPn0kDHeIskrNPc+L5KtHR2dBb4vwTfmXJRHH0t5h3ABh2zkMjUbr3Um
         fQJcZpA4KPYHyZtEjMaUgij6DnKo7zJwV+k/TK0SzolIw2z9OVcKD/OiNlFAOW93XPBz
         GDZikCy8+WmmRwqA1sssZv7RZImJScGDOkJ7gIiUEC8398a3m6wcg0DbVZnKb0RUgWse
         o3QPK1oR5y33zx+VCT3Ww4Gh3VKxxrs1w/YpjMW3OFX6UN1o9RS01xiOEs9N398mY0J4
         3CU9OeHDV2NIszsYeUISHus2Ud9hdz3VoeFNz0fkL5SKLLBsIJsmx4Hcr6vkuLJFJeyI
         f+vQ==
X-Gm-Message-State: AOJu0Yz6gK/NljxsItH8lxFaILostD3GOF9MY3qEQw4kF4LoyzuYRhye
	vxFo6EnGtlqjDBAzbIEsu+C3NTsfjf5+YKwQnK2b47/6qGChToKxiJ317oqS97z0qciUJIYu1fH
	PtVLO7pZTxMaTNQ1TCVpkCIXHVF1oh6P3
X-Google-Smtp-Source: AGHT+IFc1oQxSjGZOuzX1x2qeYX1xDk1sFjiGxTFRvEsAOq3/96UKF4ekd05GhqbhBiqz8uTRTYTFg+auxUbUoGxSHc=
X-Received: by 2002:a05:6359:c89:b0:176:707d:4c71 with SMTP id
 go9-20020a0563590c8900b00176707d4c71mr2398126rwb.15.1706379601425; Sat, 27
 Jan 2024 10:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106223951.387067-1-aford173@gmail.com> <20240106223951.387067-2-aford173@gmail.com>
In-Reply-To: <20240106223951.387067-2-aford173@gmail.com>
From: Adam Ford <aford173@gmail.com>
Date: Sat, 27 Jan 2024 12:19:50 -0600
Message-ID: <CAHCN7x+=etco+xEELdf5AyR07sR6c9tTFtsA3K5Dy99qhAZQMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock
 to hdmimix domain
To: linux-pm@vger.kernel.org
Cc: Sandor Yu <Sandor.yu@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Marek Vasut <marex@denx.de>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 4:40=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> According to i.MX8MP RM and HDMI ADD, the fdcc clock is part of
> hdmi rx verification IP that should not enable for HDMI TX.
> But actually if the clock is disabled before HDMI/LCDIF probe,
> LCDIF will not get pixel clock from HDMI PHY and print the error
> logs:
>
> [CRTC:39:crtc-2] vblank wait timed out
> WARNING: CPU: 2 PID: 9 at drivers/gpu/drm/drm_atomic_helper.c:1634 drm_at=
omic_helper_wait_for_vblanks.part.0+0x23c/0x260
>
> Add fdcc clock to LCDIF and HDMI TX power domains to fix the issue.

Peng (or anyone from NXP),

I borrowed this patch from the NXP down-stream kernel for two reasons:
 It's in NXP's branch to address an error & move the fdcc clock out of
the HDMI-tx driver due to questions/feedback that Lucas got on that
driver.

The FDCC clock isn't well documented, and it seems like it's necessary
for the HDMI-TX, but I'd like to make sure this is the proper
solution, and I haven't received any additional feedback.
Can someone from NXP confirm that really is the proper solution?

thank you,

adam

>
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> The original work was from Sandor on the NXP Down-stream kernel
>
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/im=
x/imx8mp-blk-ctrl.c
> index e3203eb6a022..a56f7f92d091 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -55,7 +55,7 @@ struct imx8mp_blk_ctrl_domain_data {
>         const char *gpc_name;
>  };
>
> -#define DOMAIN_MAX_CLKS 2
> +#define DOMAIN_MAX_CLKS 3
>  #define DOMAIN_MAX_PATHS 3
>
>  struct imx8mp_blk_ctrl_domain {
> @@ -457,8 +457,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8m=
p_hdmi_domain_data[] =3D {
>         },
>         [IMX8MP_HDMIBLK_PD_LCDIF] =3D {
>                 .name =3D "hdmiblk-lcdif",
> -               .clk_names =3D (const char *[]){ "axi", "apb" },
> -               .num_clks =3D 2,
> +               .clk_names =3D (const char *[]){ "axi", "apb", "fdcc" },
> +               .num_clks =3D 3,
>                 .gpc_name =3D "lcdif",
>                 .path_names =3D (const char *[]){"lcdif-hdmi"},
>                 .num_paths =3D 1,
> @@ -483,8 +483,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8m=
p_hdmi_domain_data[] =3D {
>         },
>         [IMX8MP_HDMIBLK_PD_HDMI_TX] =3D {
>                 .name =3D "hdmiblk-hdmi-tx",
> -               .clk_names =3D (const char *[]){ "apb", "ref_266m" },
> -               .num_clks =3D 2,
> +               .clk_names =3D (const char *[]){ "apb", "ref_266m", "fdcc=
" },
> +               .num_clks =3D 3,
>                 .gpc_name =3D "hdmi-tx",
>         },
>         [IMX8MP_HDMIBLK_PD_HDMI_TX_PHY] =3D {
> --
> 2.43.0
>

