Return-Path: <linux-kernel+bounces-11480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2449A81E6F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C5B282F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D7F4E1B6;
	Tue, 26 Dec 2023 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CA+5lbTd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC024E1B2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-466f4be526bso326644137.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 02:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703587735; x=1704192535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Qv4TX+Q3LNkRer/VYBfFYjaPXdCM6iONKvmb/cRKfE=;
        b=CA+5lbTd7gSbWN1HwTL+RUNJf94maqMoLHXJBhe6kxiUfmTqIK8FnXmD1jQa6esGVM
         t41NHo+53hRG8rsF8j6n7FONhNutRA1zh1UchjQVTmRx47q0zsJ8Z9f3XYSgfcctP6pY
         Ff8nKsIilWT3QjiwuIuVF0FKGXs2XKQuufKDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703587735; x=1704192535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Qv4TX+Q3LNkRer/VYBfFYjaPXdCM6iONKvmb/cRKfE=;
        b=raQmghJMKGyVza/Z2NnfRybR3klm9H5TYnGZIwqkpNfnkASh1xUzesxYp5Xh+z3cSC
         oUu1byFQ20mG8heYnqMRbVxIbqWI82T0LLTHalV1/BaXXB7keds9bhHjngNLvqG2VPj+
         9PrP54O4hPXcnadva0Kw+0/n2eiB/gWBecfoLzyIAVvS+ZeXDjITGLh+6sxuvJm/1j7x
         GlUWSGtJnYrufHBl6wgJFc9NglHlluyqAP/UrKlHrlZLb2bNLyUlPpRQfjKXMzK5kz2o
         OjYSt0ACmER3dILgJiHQkOBM53C8YI8YlT6a8SaxfS3/6vza5va+Jcd6wYmDixKznJOp
         CjVw==
X-Gm-Message-State: AOJu0YxzhUeSxVxrAHC92mIb28guyQpKXuFId2eH8rAaiDwXH/I7UsH6
	dhDmu9xo7fG20X28vJlTgRZsmpz+tb1Lc9IUljZJk3gjog==
X-Google-Smtp-Source: AGHT+IFVrsh1lu32Opq9cP2n8VIF4fcOyMdsnfdKILtqoNzDrlie0JR4WTtIRNeS1c50PeytjVdkag==
X-Received: by 2002:a05:6102:2c19:b0:467:2212:a43a with SMTP id ie25-20020a0561022c1900b004672212a43amr28662vsb.7.1703587735235;
        Tue, 26 Dec 2023 02:48:55 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id d30-20020a056102149e00b00466f1e72594sm402814vsv.14.2023.12.26.02.48.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 02:48:54 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-466fa42a2afso290664137.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 02:48:54 -0800 (PST)
X-Received: by 2002:a05:6122:4089:b0:4b6:cdd2:b553 with SMTP id
 cb9-20020a056122408900b004b6cdd2b553mr1074016vkb.13.1703587734078; Tue, 26
 Dec 2023 02:48:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220135722.192080-1-angelogioacchino.delregno@collabora.com> <20231220135722.192080-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231220135722.192080-3-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Tue, 26 Dec 2023 18:48:18 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhNfyEWKaJZjb_G-pXpxSpXvNQd2EMJUzWWwxmC+TzSaA@mail.gmail.com>
Message-ID: <CAC=S1nhNfyEWKaJZjb_G-pXpxSpXvNQd2EMJUzWWwxmC+TzSaA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] drm/mediatek: dsi: Cleanup functions mtk_dsi_ps_control{_vact}()
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	daniel@ffwll.ch, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Angelo,

On Wed, Dec 20, 2023 at 9:57=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Function mtk_dsi_ps_control() is a subset of mtk_dsi_ps_control_vact():
> merge the two in one mtk_dsi_ps_control() function by adding one
> function parameter `config_vact` which, when true, writes the VACT
> related registers.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 76 +++++++++---------------------
>  1 file changed, 23 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 23d2c5be8dbb..b618e2e31022 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -352,40 +352,6 @@ static void mtk_dsi_set_vm_cmd(struct mtk_dsi *dsi)
>         mtk_dsi_mask(dsi, DSI_VM_CMD_CON, TS_VFP_EN, TS_VFP_EN);
>  }
>
> -static void mtk_dsi_ps_control_vact(struct mtk_dsi *dsi)
> -{
> -       struct videomode *vm =3D &dsi->vm;
> -       u32 dsi_buf_bpp, ps_wc;
> -       u32 ps_bpp_mode;
> -
> -       if (dsi->format =3D=3D MIPI_DSI_FMT_RGB565)
> -               dsi_buf_bpp =3D 2;
> -       else
> -               dsi_buf_bpp =3D 3;
> -
> -       ps_wc =3D vm->hactive * dsi_buf_bpp;
> -       ps_bpp_mode =3D ps_wc;
> -
> -       switch (dsi->format) {
> -       case MIPI_DSI_FMT_RGB888:
> -               ps_bpp_mode |=3D PACKED_PS_24BIT_RGB888;
> -               break;
> -       case MIPI_DSI_FMT_RGB666:
> -               ps_bpp_mode |=3D PACKED_PS_18BIT_RGB666;
> -               break;
> -       case MIPI_DSI_FMT_RGB666_PACKED:
> -               ps_bpp_mode |=3D LOOSELY_PS_18BIT_RGB666;
> -               break;
> -       case MIPI_DSI_FMT_RGB565:
> -               ps_bpp_mode |=3D PACKED_PS_16BIT_RGB565;
> -               break;
> -       }
> -
> -       writel(vm->vactive, dsi->regs + DSI_VACT_NL);
> -       writel(ps_bpp_mode, dsi->regs + DSI_PSCTRL);
> -       writel(ps_wc, dsi->regs + DSI_HSTX_CKL_WC);
> -}
> -
>  static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
>  {
>         u32 tmp_reg;
> @@ -417,36 +383,40 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *ds=
i)
>         writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
>  }
>
> -static void mtk_dsi_ps_control(struct mtk_dsi *dsi)
> +static void mtk_dsi_ps_control(struct mtk_dsi *dsi, bool config_vact)
>  {
> -       u32 dsi_tmp_buf_bpp;
> -       u32 tmp_reg;
> +       struct videomode *vm =3D &dsi->vm;
> +       u32 dsi_buf_bpp, ps_wc;
> +       u32 ps_bpp_mode;
> +
> +       if (dsi->format =3D=3D MIPI_DSI_FMT_RGB565)
> +               dsi_buf_bpp =3D 2;
> +       else
> +               dsi_buf_bpp =3D 3;

The same is also in mtk_dsi_config_vdo_timing(). Given this is a
cleanup series, I think it'd be a good chance to add another patch
and integrate those usages. Just a thought.  :)
>
> +
> +       ps_wc =3D vm->hactive * dsi_buf_bpp;

I noticed the "& DSI_PS_WC" part was dropped (but perhaps with awareness?).

While the outcome seems to always fall within the range of
DSI_PS_WC so we should be fine in practice, I think it doesn't hurt to
keep the value masked to save readers some time to check if this would
ever be possible to overflow and write undesired bits down the line.
WDYT?

Regardless of that, I didn't find obvious issue in this patch, so

Reviewed-by: Fei Shao <fshao@chromium.org>

Regards,
Fei




>
> +       ps_bpp_mode =3D ps_wc;
>
>         switch (dsi->format) {
>         case MIPI_DSI_FMT_RGB888:
> -               tmp_reg =3D PACKED_PS_24BIT_RGB888;
> -               dsi_tmp_buf_bpp =3D 3;
> +               ps_bpp_mode |=3D PACKED_PS_24BIT_RGB888;
>                 break;
>         case MIPI_DSI_FMT_RGB666:
> -               tmp_reg =3D LOOSELY_PS_18BIT_RGB666;
> -               dsi_tmp_buf_bpp =3D 3;
> +               ps_bpp_mode |=3D PACKED_PS_18BIT_RGB666;
>                 break;
>         case MIPI_DSI_FMT_RGB666_PACKED:
> -               tmp_reg =3D PACKED_PS_18BIT_RGB666;
> -               dsi_tmp_buf_bpp =3D 3;
> +               ps_bpp_mode |=3D LOOSELY_PS_18BIT_RGB666;
>                 break;
>         case MIPI_DSI_FMT_RGB565:
> -               tmp_reg =3D PACKED_PS_16BIT_RGB565;
> -               dsi_tmp_buf_bpp =3D 2;
> -               break;
> -       default:
>
> -               tmp_reg =3D PACKED_PS_24BIT_RGB888;
> -               dsi_tmp_buf_bpp =3D 3;
> +               ps_bpp_mode |=3D PACKED_PS_16BIT_RGB565;
>                 break;
>         }
>
> -       tmp_reg +=3D dsi->vm.hactive * dsi_tmp_buf_bpp & DSI_PS_WC;
>
> -       writel(tmp_reg, dsi->regs + DSI_PSCTRL);
> +       if (config_vact) {
> +               writel(vm->vactive, dsi->regs + DSI_VACT_NL);
> +               writel(ps_wc, dsi->regs + DSI_HSTX_CKL_WC);
> +       }
> +       writel(ps_bpp_mode, dsi->regs + DSI_PSCTRL);
>  }
>
>  static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
> @@ -522,7 +492,7 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi =
*dsi)
>         writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
>         writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
>
> -       mtk_dsi_ps_control(dsi);
> +       mtk_dsi_ps_control(dsi, false);
>  }
>
>  static void mtk_dsi_start(struct mtk_dsi *dsi)
> @@ -667,7 +637,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
>         mtk_dsi_reset_engine(dsi);
>         mtk_dsi_phy_timconfig(dsi);
>
> -       mtk_dsi_ps_control_vact(dsi);
> +       mtk_dsi_ps_control(dsi, true);
>         mtk_dsi_set_vm_cmd(dsi);
>         mtk_dsi_config_vdo_timing(dsi);
>         mtk_dsi_set_interrupt_enable(dsi);
> --
> 2.43.0
>
>

