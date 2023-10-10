Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C7C7C0429
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbjJJTLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjJJTL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:11:26 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B5E94
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:11:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40662119cd0so14805e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696965083; x=1697569883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZoGL2Uu638tVmdTCZX+Di3sr5kqYNA/LstDS+q6xb8=;
        b=KW5rV+7jWOyFCYN/V1G5uggK6s8QTz6bxNAPcjJ5cH6tnZOW7DHW04BrrZyFsSevCb
         tOl5qvmF0jjnyE10H5HVSqPIS8AK2/Tto30UpvdGGdJLjZGJ38GnjiG3F5m600wBS1Xo
         XrbW5Cadq8n7LS0fZHbFsJC3v7ho0WZxRwTQXSkWVQS5M/eidk7UROb4aeqgAYpenQCl
         maAuBE3rPrADDbXjdWdTpBF2jAHD3NC8WQaTHq8kAI9lgxbCnkrOERo1hmRodw61v0Wa
         YV8aVCfn6YUtpm1b7DDfEHWWXj95KsiqRdNQiyQ+6XqXnD/8J7jlpCz80VyQqmj7J6M2
         BzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696965083; x=1697569883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZoGL2Uu638tVmdTCZX+Di3sr5kqYNA/LstDS+q6xb8=;
        b=A3HRTreLDJlfr/hv4SIXK7aKH6NtJ5ikgyr1isddbVWf3rCUZYaugbYWqoTLtRtkg8
         wxGvaRQALq4MOjAfDW1QN2oPMfqp0UE+V9RBLbl/2QXVZbLJsEhXc9BO/OGy+VKolSMM
         mU1n7vZ5PTVAqhcT+44Jqw5Q0Rn9xXmzi0iw+0N+ycFB7M2Tg/fDqpEx1oumSdicj6Zr
         zh1tuVAqiVSJ3MgvOsAibqXDSJ+IO7j63NX7dPuNYl1UUfCLqJjGjEpNHBL6mJMCuFWJ
         gygvnquo8ljC+ICXdN4Ku6pJyzAmhgpT/p1bge5aXkovxSHoaoY4uNHPCtv2oyOTXV+S
         6t3Q==
X-Gm-Message-State: AOJu0YxSNVdLyNUb8js1gGD59+y0/ZSvOJ+Ph59y7JkR1tCCyVTXLl4z
        sTpJ/DMNv9VgS9pw2+UjdbzZ7nlJaTTAuW3N4RTYDw==
X-Google-Smtp-Source: AGHT+IEekinj3pkVvXzCInSnjbCb1228aec9HG4yoCfY5EOtyEFUlTMrjRNS5gs3ENf9m3nv9ehAAvyirrVc4ZhO290=
X-Received: by 2002:a05:600c:4fc2:b0:406:5779:181d with SMTP id
 o2-20020a05600c4fc200b004065779181dmr25484wmq.2.1696965082564; Tue, 10 Oct
 2023 12:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231010121402.3687948-1-yangcong5@huaqin.corp-partner.google.com>
 <20231010121402.3687948-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20231010121402.3687948-3-yangcong5@huaqin.corp-partner.google.com>
From:   Doug Anderson <dianders@google.com>
Date:   Tue, 10 Oct 2023 12:11:04 -0700
Message-ID: <CAD=FV=XXGBatMjFCeSuxCy0i1FK=ekU2yq7eXb1a9J3jSYAbhw@mail.gmail.com>
Subject: Re: [v2 2/3] drm/panel: ili9882t: Avoid blurred screen from fast sleep
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
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 10, 2023 at 5:14=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> At present, we have found that there may be a problem of blurred
> screen during fast sleep/resume. The direct cause of the blurred
> screen is that the IC does not receive 0x28/0x10. Because of the
> particularity of the IC, before the panel enters sleep hid must
> stop scanning, i2c_hid_core_suspend before ili9882t_disable.
> This doesn't look very spec-compliant. So in order to solve this
> problem, the IC can handle it through the exception mechanism when
> it cannot receive 0X28/0X10 command. Handling exceptions requires a reset

very nitty, but can you make the "X" lowercase? ...so 0x28 not 0X28.


> 50ms delay. Refer to vendor detailed analysis [1].
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
> index e095ad91c4bc..20ae370ebe2f 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> @@ -465,6 +465,24 @@ static int ili9882t_init_dcs_cmd(struct ili9882t *il=
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
> @@ -486,8 +504,10 @@ static int ili9882t_enter_sleep_mode(struct ili9882t=
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
> @@ -548,7 +568,7 @@ static int ili9882t_prepare(struct drm_panel *panel)
>         gpiod_set_value(ili->enable_gpio, 1);
>         usleep_range(1000, 2000);
>         gpiod_set_value(ili->enable_gpio, 0);
> -       usleep_range(1000, 2000);
> +       usleep_range(40000, 50000);

In response to v1 you said that you actually needed 50 ms here. Oh, I
guess that's also in the patch description. The above allows the
kernel to delay 40 ms. We need to change it to something that will
force the kernel to do 50 ms. That could be: "usleep_range(50000,
51000)", but actually when we're this order of magnitude it should be
just "msleep(50)".
