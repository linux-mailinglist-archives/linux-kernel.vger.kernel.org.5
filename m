Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685CD7D1D84
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjJUOlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjJUOlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:41:00 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF00D65
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:40:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507f1c29f25so140014e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dberlin.org; s=google; t=1697899253; x=1698504053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4RGN71ke5T4dmY5Ao906sQxzaEaT/R/ELscOoI4tYI=;
        b=EdnFsEOQl3gNbC/8mq9MNRTRN0NpZb5IYsyqijXwBTltjr3Ph8mgF+VpuWPNcJY8NJ
         0LiekhZvsBiRCB5jj2tD4HrSKHWnkXC+98iuBaq9UjnXjGHSKygAa6eiPLVPXBZmnAOF
         /0YkTGS1qqSqWlQEHl0f/Kv5VdSwXtTa5pxFHGcGh7JYRujxneWGzQ1W8ZnUJs5UA/GJ
         M0/tyTybTqTqkKxCxQj4BUCRZb9M294Wu1We6d2ad/yqjU7MPoEbAoDBWZDq7kjRcuLF
         B8eM5BS9S9vyoNRfR/1trHKqMEfBwP3wdfVIwWM0ZDmVT5uCONHO7mWMfmTGXP7LbzY1
         im0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697899253; x=1698504053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4RGN71ke5T4dmY5Ao906sQxzaEaT/R/ELscOoI4tYI=;
        b=VIdUvHbI7KvP5B8hgTx42F36t6Y8fQxGPWDGO9tyN9+obfy/9mgWsgoJT+xfmwtjw+
         PV/4Mx8TK5bca9MHgXuYkRevd9o/GNZmfUs6Su4p+GoDtI6Tb16EmzUG1OVwIjyo9N0f
         IMXrrPZl8iH+XtT5Qk+xCByLJWGm+QbuEeTKS6JaMJqqiLyXC44W9XxQ4r/vGVVtR0Iq
         ppmbCQqfNhsawSIE911RkxQwPD96U1layMlbxZIuY+Cv2uik8SAUQyv604GfCY8Ffp6C
         SwGLcEcJhyE/g7zLuCmpQWAhj6FdLI1ai2sJ/4iF8NcCmCGy7BHmsEgm8lMOEWdXvRu9
         L8uA==
X-Gm-Message-State: AOJu0YyHUop9+QTNQH9GYhA1P89OUxCf/XcZQ0tpD8aHUIlybjX9WuAK
        ll8Ol5/nf1IL0LyzMm9ftrHlZfY0ZuUvFddhk7jkrw==
X-Google-Smtp-Source: AGHT+IHT5WDs88HCdoYDl86/v8lWQrzUBw93RC+XK90RUpyZMkEMONLPJFy9OhS2Kg+5PJU6iB3OKyU/92r2TI1Kz54=
X-Received: by 2002:ac2:43ab:0:b0:502:fe11:a68f with SMTP id
 t11-20020ac243ab000000b00502fe11a68fmr3625830lfl.28.1697899252363; Sat, 21
 Oct 2023 07:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697719099.git.dberlin@dberlin.org> <d2ef482bcf01fc515224cd508d730590a5294df2.1697719099.git.dberlin@dberlin.org>
In-Reply-To: <d2ef482bcf01fc515224cd508d730590a5294df2.1697719099.git.dberlin@dberlin.org>
From:   Daniel Berlin <dberlin@dberlin.org>
Date:   Sat, 21 Oct 2023 10:40:41 -0400
Message-ID: <CAF4BwTVQf25uCCVovtce+kjz0pFFMZX=Ln36R4Vd-1LEsxrcMw@mail.gmail.com>
Subject: Re: [PATCH 1/1] [brcmfmac] Fix regulatory domain handling to reset
 bands properly
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As an aside, the alternative would be to simply not ignore any
attempts to set the regulatory domain, regardless of whether it's 00
or the chip is already set to that country.
It doesn't happen that often, so it's not clear it's worth avoiding it at a=
ll.
There are some things i'd have to fix to make it work resiliently well
(for example, i know we set the 2g bw cap where we do because it has
to be done with the interface down), but i can fix those if needed.

On Thu, Oct 19, 2023 at 10:18=E2=80=AFAM Daniel Berlin <dberlin@dberlin.org=
> wrote:
>
> Currently, we ignore the default country in the reg notifier.
> We also register a custom regulatory domain, which is set
> as the default.
> As a result, the chip is likely to be set to the correct country,
> but the regulatory domain will not match it.
>
> When the regulatory notifier is then called, we see the countries
> are the same and do not change anything, even though the domain
> is wrong.
>
> This patch forces us to reset the bands on the first country change
> even if the chip is already set to that country.
>
> We also restore the original band info before reconstructing channel
> info, as the new regdom power limits may be higher than what is
> currently set.
>
> Signed-off-by: Daniel Berlin <dberlin@dberlin.org>
> ---
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 38 +++++++++++++++----
>  .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  2 +
>  2 files changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 3656790ec4c9..7bc479ccc24b 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -7199,11 +7199,23 @@ static int brcmf_construct_chaninfo(struct brcmf_=
cfg80211_info *cfg,
>                 goto fail_pbuf;
>         }
>
> +       /* Changing regulatory domain may change channels and limits
> +        * To ensure that we correctly set the new band info, copy the or=
iginal
> +        * info first.
> +        */
>         band =3D wiphy->bands[NL80211_BAND_2GHZ];
> -       if (band)
> +       if (band) {
> +               memcpy(band->channels, &__wl_2ghz_channels,
> +                      sizeof(__wl_2ghz_channels));
> +               band->n_channels =3D ARRAY_SIZE(__wl_2ghz_channels);
>                 for (i =3D 0; i < band->n_channels; i++)
>                         band->channels[i].flags =3D IEEE80211_CHAN_DISABL=
ED;
> +       }
>         band =3D wiphy->bands[NL80211_BAND_5GHZ];
> -       if (band)
> +       if (band) {
> +               memcpy(band->channels, &__wl_5ghz_channels,
> +                      sizeof(__wl_5ghz_channels));
> +               band->n_channels =3D ARRAY_SIZE(__wl_5ghz_channels);
>                 for (i =3D 0; i < band->n_channels; i++)
>                         band->channels[i].flags =3D IEEE80211_CHAN_DISABL=
ED;
> +       }
> @@ -7210,8 +7222,11 @@
>         band =3D wiphy->bands[NL80211_BAND_6GHZ];
> -       if (band)
> +       if (band) {
> +               memcpy(band->channels, &__wl_6ghz_channels,
> +                      sizeof(__wl_6ghz_channels));
> +               band->n_channels =3D ARRAY_SIZE(__wl_6ghz_channels);
>                 for (i =3D 0; i < band->n_channels; i++)
>                         band->channels[i].flags =3D IEEE80211_CHAN_DISABL=
ED;
> -
> +       }
>         total =3D le32_to_cpu(list->count);
>         if (total > BRCMF_MAX_CHANSPEC_LIST) {
>                 bphy_err(drvr, "Invalid count of channel Spec. (%u)\n",
> @@ -8601,9 +8616,17 @@ static void brcmf_cfg80211_reg_notifier(struct wip=
hy *wiphy,
>         }
>
>         err =3D brcmf_translate_country_code(ifp->drvr, req->alpha2, &ccr=
eq);
> -       if (err)
> -               return;
> -
> +       if (err) {
> +               /* Because we ignore the default country code above,
> +                * we will start out in our custom reg domain, but the ch=
ip
> +                * may already be set to the right country.
> +                * As such, we force the bands to be re-set the first
> +                * time we try to set a country for real.
> +                */
> +               if (err !=3D -EAGAIN || !cfg->force_band_setup)
> +                       return;
> +       }
> +       cfg->force_band_setup =3D false;
>         err =3D brcmf_fil_iovar_data_set(ifp, "country", &ccreq, sizeof(c=
creq));
>         if (err) {
>                 bphy_err(drvr, "Firmware rejected country setting\n");
> @@ -8670,6 +8693,7 @@ struct brcmf_cfg80211_info *brcmf_cfg80211_attach(s=
truct brcmf_pub *drvr,
>         cfg->pub =3D drvr;
>         init_vif_event(&cfg->vif_event);
>         INIT_LIST_HEAD(&cfg->vif_list);
> +       cfg->force_band_setup =3D true;
>
>         vif =3D brcmf_alloc_vif(cfg, NL80211_IFTYPE_STATION);
>         if (IS_ERR(vif))
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
> index 0e1fa3f0dea2..7e60ceeeeb3a 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
> @@ -327,6 +327,7 @@ struct brcmf_cfg80211_wowl {
>   * @dongle_up: indicate whether dongle up or not.
>   * @roam_on: on/off switch for dongle self-roaming.
>   * @scan_tried: indicates if first scan attempted.
> + * @force_band_setup: indicates if we should force band setup
>   * @dcmd_buf: dcmd buffer.
>   * @extra_buf: mainly to grab assoc information.
>   * @debugfsdir: debugfs folder for this device.
> @@ -357,6 +358,7 @@ struct brcmf_cfg80211_info {
>         bool pwr_save;
>         bool dongle_up;
>         bool scan_tried;
> +       bool force_band_setup;
>         u8 *dcmd_buf;
>         u8 *extra_buf;
>         struct dentry *debugfsdir;
> --
> 2.41.0
>
