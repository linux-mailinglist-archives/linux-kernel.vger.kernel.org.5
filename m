Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864077C7139
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379031AbjJLPP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347298AbjJLPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:15:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA94C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:15:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5032a508e74so4010e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697123747; x=1697728547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDm03tbPxIT0QGcdFVM1esLuIKdKzQrObVrEEj/6HeY=;
        b=wCsYpb+1WEEWnbhfMzlQL2Da5bi8igAJYbzwI9nzHI5gFerlw2B7obhmraZlCv5H4K
         uutAUOIxLuURMmje2p1xKla8bzcrkeZZpXqqy35tmCkjAbj5aT2+IepoBgIUuEFfu5O/
         7eLvWGeXbT21T0YXDZabKv4d3dl+u0tTS742n0Avkrtzo+QwXlnnw6GRFa3R2favlkvm
         EXmOOmLKMtMGsMILSCWL3VWIoHPHKRoBsW3ZT9WTqIupFMGCjF131h0jgE/UnFJYeb2m
         f+EXLrvOS8ANkDAEvfGFH/t5lUAzMcNSQz/ekHmRBn0jG/cpUoK3zgnv4sTjh1a6gtei
         mKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697123747; x=1697728547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDm03tbPxIT0QGcdFVM1esLuIKdKzQrObVrEEj/6HeY=;
        b=u5TVMsrg7mq+29f7Z2neYBE4yAl7BeDnVLhnx+9x+ChcAbskzLKEyGgd+x1Afb2iCn
         6aHi3HIr5WI/86bIJCx9Ni4yD5gsjyyqi+Q0vEXTScuqD//loGSsHqscEG8MZ/cGcp0b
         5HltCx8ZefAaRkjjBDvUDoz1WYr7eFRMM9K1+WRXV2EYXYXO9MOSxLPglAPcrhXYO/1t
         2vEGYerpfEGELvuUuM/fhYXoxyexnSAQAsbSfKVZjd1mumF73XXoyQg00YWn8UYdeSgM
         Fg6kAtYlTmimoe36o9+YwPHTIWDtIjgg8ToNgHl2BdvaQ8fB9k7Bld6VFGvqrn0QB9ZD
         r1wg==
X-Gm-Message-State: AOJu0YxAW2NM8ms8d2zBMchobAKhmDYXJlFUjlsOZg8ZP1oW1KYIm0Ui
        xKkq274motGHbQQ6PU6fsaO9kk7OEjQJQB0NeTnXaw==
X-Google-Smtp-Source: AGHT+IHHqpNk40g2RjFLWXJqCM+SrOl6/nUGrqlwoOct5RnINpCVGcxlf2fuOuGr7mEG7vCf8J+GfWVR7r/yc7HI5eQ=
X-Received: by 2002:a19:ad41:0:b0:501:ba53:a4f7 with SMTP id
 s1-20020a19ad41000000b00501ba53a4f7mr199955lfd.0.1697123747342; Thu, 12 Oct
 2023 08:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231012121004.2127918-1-yangcong5@huaqin.corp-partner.google.com>
 <20231012121004.2127918-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20231012121004.2127918-3-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 12 Oct 2023 08:15:32 -0700
Message-ID: <CAD=FV=VwUHctAQXGr_6FZfTS3r0-MZaSiB8+YkfJJzrJsnZDLw@mail.gmail.com>
Subject: Re: [v3 2/3] drm/panel: ili9882t: Avoid blurred screen from fast sleep
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 12, 2023 at 5:10=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> At present, we have found that there may be a problem of blurred
> screen during fast sleep/resume. The direct cause of the blurred
> screen is that the IC does not receive 0x28/0x10. Because of the
> particularity of the IC, before the panel enters sleep hid must
> stop scanning, as i2c_hid_core_suspend before ili9882t_disable.
> If move the ili9882t_enter_sleep_mode function to ili9882t_unprepare,
> touch reset will pull low before panel entersleep, which does not meet
> the timing requirements..

The above makes me believe that the reset GPIO should be moved out of
the input driver and into the panel driver. I could just imagine that
the kernel might have some reason it wants to suspend the i2c hid
device. If that causes the panel to suddenly start failing then that
would be bad... I think we should fix this.


> So in order to solve this problem, the IC
> can handle it through the exception mechanism when it cannot receive
> 0x28/0x10 command. Handling exceptions requires a reset 50ms delay.
> Refer to vendor detailed analysis [1].
>
> Ilitek vendor also suggested switching the page before entering sleep to
> avoid panel IC not receiving 0x28/0x10 command.
>
> Note: 0x28 is display off, 0x10 is sleep in.
>
> [1]: https://github.com/ILITEK-LoganLin/Document/tree/main/ILITEK_Power_S=
equence
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili9882t.c
> index 93a40c2f1483..54ff1efb94aa 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> @@ -463,6 +463,24 @@ static int ili9882t_init_dcs_cmd(struct ili9882t *il=
i)
>         return 0;
>  }
>
> +static int ili9882t_switch_page(struct mipi_dsi_device *dsi, u8 page)
> +{
> +       int ret;
> +       const struct panel_init_cmd cmd =3D _INIT_SWITCH_PAGE_CMD(page);
> +
> +       ret =3D mipi_dsi_dcs_write(dsi, cmd.data[0],
> +                                cmd.len <=3D 1 ? NULL :
> +                                &cmd.data[1],
> +                                cmd.len - 1);
> +       if (ret) {
> +               dev_err(&dsi->dev,
> +                       "error switching panel controller page (%d)\n", r=
et);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static int ili9882t_enter_sleep_mode(struct ili9882t *ili)
>  {
>         struct mipi_dsi_device *dsi =3D ili->dsi;
> @@ -484,8 +502,10 @@ static int ili9882t_enter_sleep_mode(struct ili9882t=
 *ili)
>  static int ili9882t_disable(struct drm_panel *panel)
>  {
>         struct ili9882t *ili =3D to_ili9882t(panel);
> +       struct mipi_dsi_device *dsi =3D ili->dsi;
>         int ret;
>
> +       ili9882t_switch_page(dsi, 0x00);
>         ret =3D ili9882t_enter_sleep_mode(ili);
>         if (ret < 0) {
>                 dev_err(panel->dev, "failed to set panel off: %d\n", ret)=
;
> @@ -546,7 +566,7 @@ static int ili9882t_prepare(struct drm_panel *panel)
>         gpiod_set_value(ili->enable_gpio, 1);
>         usleep_range(1000, 2000);
>         gpiod_set_value(ili->enable_gpio, 0);
> -       usleep_range(1000, 2000);
> +       usleep_range(50000, 51000);

From my previous response, I think the above is better as msleep(50).
