Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5EB7C0424
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbjJJTLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjJJTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:11:06 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19A894
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:11:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40662119cd0so14755e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696965062; x=1697569862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpCceZmbnmWfyUfaN7Neh9lmGF2UPo2D6Q93y/7mO30=;
        b=clPYmi4bfa2GBtpQG+0By9pEIOLD6un0Os2EGQ/RTcumnHXAZKexwRdJa0Y98nV2TZ
         ZkM5zofCAjupda7/yCbxK+KmigzYeRsC/ZPBvBaGNqxD0p+GB3IQNLKU5lOUdx75VtvV
         ENKns2Q/pLLw89Gm5r2KS52PbeLm8zdcGqNbEBKF63eDYpBJ+N3pHNwjxmEg4tofOvSW
         IkFZA0Y+hvHMr9oiwxzeQwhl9NjPlGdZkd5WbWAcBcmzVkQm5WitBg0+JR9FDWvr07I2
         IM/FJtAxo9e8em7cgAbN5Ba746Zb6/Mbqyw4NnN+xqkHOnHLMX/GVVy1ZgszgtrKMGOL
         2BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696965062; x=1697569862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpCceZmbnmWfyUfaN7Neh9lmGF2UPo2D6Q93y/7mO30=;
        b=bsUiqMmTg3fAt5mPBswvADfpuWtitjvzfRwWWZNQ5Kxufn15UYQQFcHqLE2OESREgk
         OXuzPDtbsxNe6RMLsg0xeU7hI1NoSXwkOnRj8bbDrJvMYQ6ex24XXdjMoEvfP0qR2Z18
         Rg6+MMlKKI4tQlix4mIUB6Frzw2RBBq1gHUXKhRC/op+rlJr7gJHwsNK9CO2m7+m+/3Q
         Ob2v8lV2KGK9CfR7ziN9yGkKX/wPm7nfDOw9MMG7IaQI13ZxJmWysbXnqfq+T+m1Uf5c
         bX3uB0AHo0ZxNsVuERGVO/StuDyRbbzJTt7nUoTXqw+6n0UZKMwt81cSp9eb9DdORzhN
         Pcgg==
X-Gm-Message-State: AOJu0YwoMtXlfiQ+JOe8GEUaUz7OgAnlCQVJeOXZ1IYm1M7BMCvGqaF3
        xX1+Fgjou+JDUbVZHPruPUwWmtvsouovCp0sobg5QA==
X-Google-Smtp-Source: AGHT+IGyHcc065zalL/uMb2Rg27kWBnlQyHv0EoUM7psUnegw6ZMk2u3/+9u8kfQGzLaQsojexxvzbM0/ypCwMkEx8M=
X-Received: by 2002:a05:600c:1f8e:b0:400:fffe:edf6 with SMTP id
 je14-20020a05600c1f8e00b00400fffeedf6mr23995wmb.1.1696965061918; Tue, 10 Oct
 2023 12:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231010121402.3687948-1-yangcong5@huaqin.corp-partner.google.com>
 <20231010121402.3687948-2-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20231010121402.3687948-2-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Tue, 10 Oct 2023 12:10:45 -0700
Message-ID: <CAD=FV=VsjB-gsqXyAs+G8DpHJqHNTxeFXwbpgt20-Wgb757z1w@mail.gmail.com>
Subject: Re: [v2 1/3] drm/panel: ili9882t: Break out as separate driver
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        hsinyi@google.com, linus.walleij@linaro.org, swboyd@chromium.org,
        airlied@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 10, 2023 at 5:14=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili9882t.c
> new file mode 100644
> index 000000000000..e095ad91c4bc
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> @@ -0,0 +1,762 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Panels based on the Ilitek ILI9882T display controller.
> + */
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>

nit: remove include of linux/of_device.h since you don't use any of
the functions declared there.


> +#include <linux/regulator/consumer.h>
> +
> +#include <drm/drm_connector.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_panel.h>
> +
> +#include <video/mipi_display.h>
> +
> +/*
> + * Use this descriptor struct to describe different panels using the
> + * Ilitek ILI9882T display controller.
> + */
> +struct panel_desc {
> +       const struct drm_display_mode *modes;
> +       unsigned int bpc;
> +
> +       /**
> +        * @width_mm: width of the panel's active display area
> +        * @height_mm: height of the panel's active display area
> +        */
> +       struct {
> +               unsigned int width_mm;
> +               unsigned int height_mm;
> +       } size;
> +
> +       unsigned long mode_flags;
> +       enum mipi_dsi_pixel_format format;
> +       const struct panel_init_cmd *init_cmds;
> +       unsigned int init_cmd_length;

Remove "init_cmd_length" since it's now unused.


> +static void ili9882t_remove(struct mipi_dsi_device *dsi)
> +{
> +       struct ili9882t *ili =3D mipi_dsi_get_drvdata(dsi);
> +       int ret;
> +
> +
> +       ret =3D mipi_dsi_detach(dsi);

nit: remove extra blank line above.


Other than nits, this looks good to me now.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
