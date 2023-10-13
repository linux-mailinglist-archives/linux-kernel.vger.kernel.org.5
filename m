Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362607C7B99
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjJMC2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJMC2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:28:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E501FB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:28:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405459d9a96so39715e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697164107; x=1697768907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9/YuC6y9eUihKpZ8jmF6NlsO7n14+K0koQ+noy1ggQ=;
        b=OmWoC3nd59yaNI16Fbi2/oU1YekFIfue7+44AXYOFFyYyQIQJAKgmDAP/CcYnpixXu
         nIIRlrh59ifFabgPugRGFzKAVLEVZg6MVez/4U4AB+1Bw3qUBeVqdUeLK0rnjud1B7rs
         4Z5EGXReX7CGbEa8dNfxTUy18ypEwuWixrMujAIZzoKM/t6zAEPgIe52yWLqaCZaHFgR
         Dwc3VhtdIH7vptrxSWvmlzXPkpI9KNk5CH4DnHuTVOlRSWX3cVzbj+kLrOxYsNHxHD7M
         Afj8YEOVRFEx/DWp4ExFO/6wumotSu6+7eiB38TLll2+i+iwhH6NmL/vbKjeBAgqXEjY
         VxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697164107; x=1697768907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9/YuC6y9eUihKpZ8jmF6NlsO7n14+K0koQ+noy1ggQ=;
        b=knLXT37wnbadqfow6xu9LKXKC5cXY+ff8LTDJJCXkWY2CcZVgmH+wkqZUuZliZU3w4
         INVRhgVGtkh4lFEUe8Ki17yAkS29F1/e2lyNlS3q7ngRzywmdTxg6DzjrX1YWrBJq6UT
         C6bz94hffUQ2c5EP4Ufk3YEnUhnpfG9GkGwk5AaDa5f0nqmbw/veRlo+9WxIJKZUxZrM
         1KSqT4C68M2CsvFHf4fjolmZAGRQeL1OUxZkc6B3mxceHYX08XqTfLQjNE5Q1C2Lg8AT
         BmXFreop619xsdEEiua9tvNSDTjIYBaqP/ZLjLE6g9LDhrrUOMJIlLP0JKkjywdKOWOC
         AMUw==
X-Gm-Message-State: AOJu0Ywbkh84dWYTts3wFmB70HScwN7GUhRmTHVmjw271Le/I+iAkaCy
        O5+oxJV3z85wPQhJX8BuYXeUuVen8XME+x81OzZd6A==
X-Google-Smtp-Source: AGHT+IEu3bheZn/kvrw6MTnB9tzASaTpUw4xRezBw/4fkpa7r55AH2ohLLQYSj1JU+sur8lRAt/zUYM8E4TeV6/Dtk0=
X-Received: by 2002:a05:600c:2102:b0:405:38d1:e146 with SMTP id
 u2-20020a05600c210200b0040538d1e146mr63274wml.4.1697164107120; Thu, 12 Oct
 2023 19:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231012121004.2127918-1-yangcong5@huaqin.corp-partner.google.com>
 <20231012121004.2127918-3-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=VwUHctAQXGr_6FZfTS3r0-MZaSiB8+YkfJJzrJsnZDLw@mail.gmail.com> <CAHwB_NKSL8vHdN8TnQY2Z04E4rDRLK5BHoryZCi2kNAwQEjisQ@mail.gmail.com>
In-Reply-To: <CAHwB_NKSL8vHdN8TnQY2Z04E4rDRLK5BHoryZCi2kNAwQEjisQ@mail.gmail.com>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 12 Oct 2023 19:28:11 -0700
Message-ID: <CAD=FV=VmiS6G25JyAj4UGjU5Q9f80GcjLq1xwU4gdVyzDdk8LQ@mail.gmail.com>
Subject: Re: [v3 2/3] drm/panel: ili9882t: Avoid blurred screen from fast sleep
To:     cong yang <yangcong5@huaqin.corp-partner.google.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 12, 2023 at 6:12=E2=80=AFPM cong yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> Hi,
>
> On Thu, Oct 12, 2023 at 11:15=E2=80=AFPM Doug Anderson <dianders@google.c=
om> wrote:
> >
> > Hi,
> >
> > On Thu, Oct 12, 2023 at 5:10=E2=80=AFAM Cong Yang
> > <yangcong5@huaqin.corp-partner.google.com> wrote:
> > >
> > > At present, we have found that there may be a problem of blurred
> > > screen during fast sleep/resume. The direct cause of the blurred
> > > screen is that the IC does not receive 0x28/0x10. Because of the
> > > particularity of the IC, before the panel enters sleep hid must
> > > stop scanning, as i2c_hid_core_suspend before ili9882t_disable.
> > > If move the ili9882t_enter_sleep_mode function to ili9882t_unprepare,
> > > touch reset will pull low before panel entersleep, which does not mee=
t
> > > the timing requirements..
> >
> > The above makes me believe that the reset GPIO should be moved out of
> > the input driver and into the panel driver. I could just imagine that
> > the kernel might have some reason it wants to suspend the i2c hid
> > device. If that causes the panel to suddenly start failing then that
> > would be bad... I think we should fix this.
>
> Thanks, I will confirm with ilitek in further analysis and use "move
> the ili9882t_enter_sleep_mode
> function to ili9882t_unprepare".  Is the test failure really because
> the touch reset timing
> does not match? There is also a separate reset GPIO on the panel.
> Shouldn't touch reset not
> affect the panel?
>
> If we find a better solution I will continue upstream,=E3=80=82 So is it
> possible to apply this plan now?

I wouldn't be too upset at applying the current code as long as you're
going to continue to investigate. We can always continue to iterate on
it and having something working reasonably well is better than nothing
at all. However, I probably would wait at least 1 week before applying
any patch from you just simply out of courtesy to give others on the
mailing list time to express their comments. ...presumably we could
get to the bottom of the problem in that 1 week time anyway...

I'm not trying to be an obstinate pain here--I'm merely trying to make
sure that whatever we land will continue to work across kernel uprevs,
even if driver probe order / timing changes in the kernel. If the
panel is really so tied to the touchscreen device's reset GPIO timing
then it worries me. What happens, for instance, if you disable the
touchscreen CONFIG in the kernel? Does the panel still work, or is
that extra reset GPIO totally critical to the functioning of the
panel. If it's totally critical then it probably makes sense to move
to the panel driver given that the touchscreen is a panel follower
anyway...


> > > So in order to solve this problem, the IC
> > > can handle it through the exception mechanism when it cannot receive
> > > 0x28/0x10 command. Handling exceptions requires a reset 50ms delay.
> > > Refer to vendor detailed analysis [1].
> > >
> > > Ilitek vendor also suggested switching the page before entering sleep=
 to
> > > avoid panel IC not receiving 0x28/0x10 command.
> > >
> > > Note: 0x28 is display off, 0x10 is sleep in.
> > >
> > > [1]: https://github.com/ILITEK-LoganLin/Document/tree/main/ILITEK_Pow=
er_Sequence
> > >
> > > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > > ---
> > >  drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 22 +++++++++++++++++=
+-
> > >  1 file changed, 21 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/=
gpu/drm/panel/panel-ilitek-ili9882t.c
> > > index 93a40c2f1483..54ff1efb94aa 100644
> > > --- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> > > +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> > > @@ -463,6 +463,24 @@ static int ili9882t_init_dcs_cmd(struct ili9882t=
 *ili)
> > >         return 0;
> > >  }
> > >
> > > +static int ili9882t_switch_page(struct mipi_dsi_device *dsi, u8 page=
)
> > > +{
> > > +       int ret;
> > > +       const struct panel_init_cmd cmd =3D _INIT_SWITCH_PAGE_CMD(pag=
e);
> > > +
> > > +       ret =3D mipi_dsi_dcs_write(dsi, cmd.data[0],
> > > +                                cmd.len <=3D 1 ? NULL :
> > > +                                &cmd.data[1],
> > > +                                cmd.len - 1);
> > > +       if (ret) {
> > > +               dev_err(&dsi->dev,
> > > +                       "error switching panel controller page (%d)\n=
", ret);
> > > +               return ret;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static int ili9882t_enter_sleep_mode(struct ili9882t *ili)
> > >  {
> > >         struct mipi_dsi_device *dsi =3D ili->dsi;
> > > @@ -484,8 +502,10 @@ static int ili9882t_enter_sleep_mode(struct ili9=
882t *ili)
> > >  static int ili9882t_disable(struct drm_panel *panel)
> > >  {
> > >         struct ili9882t *ili =3D to_ili9882t(panel);
> > > +       struct mipi_dsi_device *dsi =3D ili->dsi;
> > >         int ret;
> > >
> > > +       ili9882t_switch_page(dsi, 0x00);
> > >         ret =3D ili9882t_enter_sleep_mode(ili);
> > >         if (ret < 0) {
> > >                 dev_err(panel->dev, "failed to set panel off: %d\n", =
ret);
> > > @@ -546,7 +566,7 @@ static int ili9882t_prepare(struct drm_panel *pan=
el)
> > >         gpiod_set_value(ili->enable_gpio, 1);
> > >         usleep_range(1000, 2000);
> > >         gpiod_set_value(ili->enable_gpio, 0);
> > > -       usleep_range(1000, 2000);
> > > +       usleep_range(50000, 51000);
> >
> > From my previous response, I think the above is better as msleep(50).
>
> Sorry. Will be corrected in V4.

Thanks! It's not a huge deal, but it's nice to fix.

-Doug
