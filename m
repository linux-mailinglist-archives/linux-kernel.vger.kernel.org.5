Return-Path: <linux-kernel+bounces-155734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 764248AF652
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2500B28B13
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971AC13E051;
	Tue, 23 Apr 2024 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0XYEkSbm"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D079813666F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895835; cv=none; b=bpRuD3WK4ESJeoz6bypl/dTxuveg/lAWyBbGef069OBG2K0GJJ1UZdSA/1wOIkPGZHmPLmBNryqMyYoyF+RiSQVVPmlQKK9TW3r1SJOl4TqmLgjEpGoBqHtzPB0f2N9FyOn/zrlyJXTOZaPOraVxLrES189b3DMltTYu1pEg01I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895835; c=relaxed/simple;
	bh=/edRUH5Q80ijc8jy/8Xr8gxfMJ7nb85SBHRPUab3CGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNI3qCFckdO99wYgaAi3phkfHg4jh59ljLPJ/fmCDKs+0O0WXipQjjWgDxO5ysBFqn1L116zhQ1wbdzxpn+73NtLSBZpaN7nMRPegAoCzzbVvjEQrnL/59a1n549ZAyjLa8KyOaxWoqxMS0QVsw/U/S7XaFf+vBGijpBbDbibvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0XYEkSbm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34665dd7610so2957845f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713895832; x=1714500632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wl2ct4hkdwUhx5/aeg9lOPHNV+QD++rylKxscdt/bF4=;
        b=0XYEkSbm6UNX28P3bIswbPH5licid/1CbtJL4qGSGG5qAyRWEPBAGI3yXGOVu0eB9M
         N8L1ehURDUx+PYVseFb7qtDV1SunlKs9v0xMFS9NKLEr9XdWWNiLwG7+YmgC/veQY+72
         7bgkqo2AEDwItVtK7i2sBeKeiqdHQzYrpld8J1eA65CecnooHKQT2MSOfpeEKUC0Mgz1
         v2jmWLSqY7dbM/rGd0q9LNUSA756Oh4s4V+IY8rIWa7Ay4f8Wjly0B+he3gc/Gr1vm4q
         eHk6hVNwNbcbymFe+AmPhF/MTA5C/UxOHzf2U4W178c7dPQKZhf68wDvv+fBUXyaD0sV
         y33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895832; x=1714500632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wl2ct4hkdwUhx5/aeg9lOPHNV+QD++rylKxscdt/bF4=;
        b=nM/m4YjlP4YfPb9eoKpyi1gF/uZK0Ye/ghUEynYloZh2lCnF1bAl0jms12C9vzKqJl
         MTfDDUHs3hggW/JbuK8pflNsMN39j0rnrHDHVFnkNh8MokAKRWTI9hMj10qL6pzEV8/q
         H0HZrICkxiLSQyePIzjW5Nc576qcSesPAHwG8Nz05Wv7nBO/j5q9rCbWz6k76cHfa49R
         kO92IRiZ6FUuVS7/yxGo0AuOa+5lf8cE12cEriUnlVm5DI/oOFXQWaFp0Pg0gzZvhpS/
         onv8VzgQbxKmED7I4oJSRI/ab77o+PwF5PQle/S3827P6Nd3GOnCAdaSXZZ2qO5yx8EX
         tbaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWh0fzEtYg3g4l9yo8CYcEUvu3vRxQXhKf7OGpUoVE+F7HRnUqEXHZDLdKm8OXXJZ20gI7p9rWDArq5Ke46adw/dMSsUlkUKeVBNQ/
X-Gm-Message-State: AOJu0YzxCHd6qyft2cQje9wecxfMeqnntWads7zy1NQYB3bKmUtww6XJ
	Z8G+q5tJiVEwMmeAgLKtkvBVtrKZtYRz8GBD+YYMOL9tcOuDg2BKuXNbxxAXo4pTEZnWiXrcDqC
	Sx0H8MCDw7C98M2p85H4Wj5OPP7WyHjMpLHU+
X-Google-Smtp-Source: AGHT+IFFYQ6yDh91vFBzxgZW+1q5Z+Ylw9RzRb7kgpgzvmMuVBW1eUvQTyJzbETI8cyjFIL2yqPiZ1EjCyLfp9CT/Nc=
X-Received: by 2002:a5d:590f:0:b0:34b:3374:bc26 with SMTP id
 v15-20020a5d590f000000b0034b3374bc26mr3444655wrd.65.1713895831867; Tue, 23
 Apr 2024 11:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418081548.12160-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240418081548.12160-3-lvzhaoxiong@huaqin.corp-partner.google.com>
 <zanx5y3obqmewnbooovf52hx6vh7tpi4zsbse2dyzcqzddmzhw@kewxoa6n3mja>
 <CACb=7PURWtS8bwT5EcAFHhu7deHd2Y8cNOattfdwyEYpOUcbnQ@mail.gmail.com> <vbt2nxddw2dc7hkreq4iybv5zv5xyp32oajybeqsphgfrhzmn7@tskvckljmxpe>
In-Reply-To: <vbt2nxddw2dc7hkreq4iybv5zv5xyp32oajybeqsphgfrhzmn7@tskvckljmxpe>
From: Hsin-Yi Wang <hsinyi@google.com>
Date: Tue, 23 Apr 2024 11:10:03 -0700
Message-ID: <CACb=7PVTvV9nsFu1ZAXu7YTjSOAGZka+c__EJq3J3qgSJGEShw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel: kd101ne3: add new panel driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>, mripard@kernel.org, 
	airlied@gmail.com, daniel@ffwll.ch, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, dianders@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 7:11=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, Apr 18, 2024 at 09:11:37PM +0800, Hsin-Yi Wang wrote:
> > On Thu, Apr 18, 2024 at 7:46=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Thu, Apr 18, 2024 at 04:15:48PM +0800, lvzhaoxiong wrote:
> > > > The kingdisplay panel is based on JD9365DA controller.
> > > > Add a driver for it.
> > > >
> > > > Signed-off-by: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.=
com>
> > > > ---
> > > >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> > > >  drivers/gpu/drm/panel/Makefile                |   1 +
> > > >  .../drm/panel/panel-kingdisplay-kd101ne3.c    | 607 ++++++++++++++=
++++
> > > >  3 files changed, 617 insertions(+)
> > > >  create mode 100644 drivers/gpu/drm/panel/panel-kingdisplay-kd101ne=
3.c
> > > >
> > > > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/=
Kconfig
> > > > index 154f5bf82980..2c73086cf102 100644
> > > > --- a/drivers/gpu/drm/panel/Kconfig
> > > > +++ b/drivers/gpu/drm/panel/Kconfig
> > > > @@ -297,6 +297,15 @@ config DRM_PANEL_KINGDISPLAY_KD097D04
> > > >         24 bit RGB per pixel. It provides a MIPI DSI interface to
> > > >         the host and has a built-in LED backlight.
> > > >
> > > > +config DRM_PANEL_KINGDISPLAY_KD101NE3
> > > > +     tristate "Kingdisplay kd101ne3 panel"
> > > > +     depends on OF
> > > > +     depends on DRM_MIPI_DSI
> > > > +     depends on BACKLIGHT_CLASS_DEVICE
> > > > +     help
> > > > +       Say Y if you want to enable support for panels based on the
> > > > +       Kingdisplay kd101ne3 controller.
> > > > +
> > > >  config DRM_PANEL_LEADTEK_LTK050H3146W
> > > >       tristate "Leadtek LTK050H3146W panel"
> > > >       depends on OF
> > > > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel=
/Makefile
> > > > index 24a02655d726..cbd414b98bb0 100644
> > > > --- a/drivers/gpu/drm/panel/Makefile
> > > > +++ b/drivers/gpu/drm/panel/Makefile
> > > > @@ -30,6 +30,7 @@ obj-$(CONFIG_DRM_PANEL_JDI_LPM102A188A) +=3D pane=
l-jdi-lpm102a188a.o
> > > >  obj-$(CONFIG_DRM_PANEL_JDI_R63452) +=3D panel-jdi-fhd-r63452.o
> > > >  obj-$(CONFIG_DRM_PANEL_KHADAS_TS050) +=3D panel-khadas-ts050.o
> > > >  obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04) +=3D panel-kingdispla=
y-kd097d04.o
> > > > +obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD101NE3) +=3D panel-kingdispla=
y-kd101ne3.o
> > > >  obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W) +=3D panel-leadtek-lt=
k050h3146w.o
> > > >  obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829) +=3D panel-leadtek-lt=
k500hd1829.o
> > > >  obj-$(CONFIG_DRM_PANEL_LG_LB035Q02) +=3D panel-lg-lb035q02.o
> > > > diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c b/d=
rivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c
> > > > new file mode 100644
> > > > index 000000000000..dbf0992f8b81
> > > > --- /dev/null
> > > > +++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c
> > > > @@ -0,0 +1,607 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Panels based on the JD9365DA display controller.
> > > > + * Author: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.co=
m>
> > > > + */
> > > > +
> > > > +#include <linux/delay.h>
> > > > +#include <linux/gpio/consumer.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/of_device.h>
> > > > +#include <linux/regulator/consumer.h>
> > > > +
> > > > +#include <drm/drm_connector.h>
> > > > +#include <drm/drm_crtc.h>
> > > > +#include <drm/drm_mipi_dsi.h>
> > > > +#include <drm/drm_panel.h>
> > > > +
> > > > +#include <video/mipi_display.h>
> > > > +
> > > > +struct panel_desc {
> > > > +     const struct drm_display_mode *modes;
> > > > +     unsigned int bpc;
> > > > +
> > > > +     /**
> > > > +      * @width_mm: width of the panel's active display area
> > > > +      * @height_mm: height of the panel's active display area
> > > > +      */
> > > > +     struct {
> > > > +             unsigned int width_mm;
> > > > +             unsigned int height_mm;
> > >
> > > Please move to the declared mode;
> > >
> > > > +     } size;
> > > > +
> > > > +     unsigned long mode_flags;
> > > > +     enum mipi_dsi_pixel_format format;
> > > > +     const struct panel_init_cmd *init_cmds;
> > > > +     unsigned int lanes;
> > > > +     bool discharge_on_disable;
> > > > +     bool lp11_before_reset;
> > > > +};
> > > > +
> > > > +struct kingdisplay_panel {
> > > > +     struct drm_panel base;
> > > > +     struct mipi_dsi_device *dsi;
> > > > +
> > > > +     const struct panel_desc *desc;
> > > > +
> > > > +     enum drm_panel_orientation orientation;
> > > > +     struct regulator *pp3300;
> > > > +     struct gpio_desc *enable_gpio;
> > > > +};
> > > > +
> > > > +enum dsi_cmd_type {
> > > > +     INIT_DCS_CMD,
> > > > +     DELAY_CMD,
> > > > +};
> > > > +
> > > > +struct panel_init_cmd {
> > > > +     enum dsi_cmd_type type;
> > > > +     size_t len;
> > > > +     const char *data;
> > > > +};
> > > > +
> > > > +#define _INIT_DCS_CMD(...) { \
> > > > +     .type =3D INIT_DCS_CMD, \
> > > > +     .len =3D sizeof((char[]){__VA_ARGS__}), \
> > > > +     .data =3D (char[]){__VA_ARGS__} }
> > > > +
> > > > +#define _INIT_DELAY_CMD(...) { \
> > > > +     .type =3D DELAY_CMD,\
> > > > +     .len =3D sizeof((char[]){__VA_ARGS__}), \
> > > > +     .data =3D (char[]){__VA_ARGS__} }
> > >
> > > This is the third panel driver using the same appoach. Can you use
> > > mipi_dsi_generic_write_seq() instead of the huge table? Or if you pre=
fer
> > > the table, we should extract this framework to a common helper.
> > > (my preference is shifted towards mipi_dsi_generic_write_seq()).
> > >
> > The drawback of mipi_dsi_generic_write_seq() is that it can cause the
> > kernel size grows a lot since every sequence will be expanded.
> >
> > Similar discussion in here:
> > https://lore.kernel.org/dri-devel/CAD=3DFV=3DWju3WS45=3DEpXMUg7FjYDh3-=
=3Dmvm_jS7TF1tsaAzbb4Uw@mail.gmail.com/
> >
> > This patch would increase the module size from 157K to 572K.
> > scripts/bloat-o-meter shows chg +235.95%.
> >
> > So maybe the common helper is better regarding the kernel module size?
>
> Yes, let's get a framework done in a useful way.
> I'd say, drop the _INIT_DELAY_CMD. msleep() and usleep_range() should be
> used instead (and it's up to the developer to select correct delay
> function).
>
> >
> > > > +
> > > > +static const struct panel_init_cmd kingdisplay_kd101ne3_init_cmd[]=
 =3D {
> > > > +     _INIT_DELAY_CMD(50),
> > > > +     _INIT_DCS_CMD(0xE0, 0x00),
>
> [skipped the body of the table]
>
> > > > +     _INIT_DCS_CMD(0x0E, 0x48),
> > > > +
> > > > +     _INIT_DCS_CMD(0xE0, 0x00),
>
> > > > +     _INIT_DCS_CMD(0X11),
>
> Also, at least this is mipi_dsi_dcs_exit_sleep_mode().
>
> > > > +     /* T6: 120ms */
> > > > +     _INIT_DELAY_CMD(120),
> > > > +     _INIT_DCS_CMD(0X29),
>
> And this is mipi_dsi_dcs_set_display_on().
>
> Having a single table enourages people to put known commands into the
> table, the practice that must be frowned upon and forbidden.
>
> We have functions for some of the standard DCS commands. So, maybe
> instead of adding a single-table based approach we can improve
> mipi_dsi_generic_write_seq() to reduce the bloat. E.g. by moving the
> error handling to a common part of enable() / prepare() function.
>

For this panel, I think it can also refer to how
panel-kingdisplay-kd097d04.c does. Create the table for init cmd data,
not what operation to use, and use mipi_dsi_generic_write_seq() when
looping through the table.


> > > > +     _INIT_DELAY_CMD(20),
> > > > +     {},
> > > > +};
>
> --
> With best wishes
> Dmitry

