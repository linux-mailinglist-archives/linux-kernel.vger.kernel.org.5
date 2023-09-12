Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDF579C31D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239593AbjILCkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239421AbjILCjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:39:44 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F0B120D79
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:17:48 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76f18e09716so300459485a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694481467; x=1695086267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tnjpp/lycfe/g1+o8xfnP0NivTMeUFx/cpAoWuFE18=;
        b=EwTpPQX3oQ0mVyRHCa2uU/x7V5aozk6OidlBiGybLOAjUsaXKCfpGSsityqkPsPbk4
         Kdc6ZcP9z5K52m2cb9pxKhv48eQBoCo7hgvrQRojSGhUvkxtbJEgxaOPI5c+g7dG59J2
         gJ5gxnR7xQDqv/QuVZ4fdQJ6dFbR12bUVifII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694481467; x=1695086267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tnjpp/lycfe/g1+o8xfnP0NivTMeUFx/cpAoWuFE18=;
        b=k08RKFsxv1xoAjC9YXzZigrtyVwXL+e/q/HMHZx5cEiybDxY0nWL3nPRvpaOs/nD4b
         K0rKfpa/hI/gJXDLKQ/BdPZAZL6aipbedI+IxlRux76kQIgeAKjwUf3A/fjFW7uLjyBo
         ng7DaaITRwr7UonxBpGdinNE0u8e64cqVkAfkZcsYHVkYauGAfnsu+qx+nEzgumuOxGG
         MhBfQigXwcTa3xWchh0EXQbeCivkQmxckEXbqLMwB5dgR1QRtnMXq0/rirnAzc5Fz9VB
         4X1JDKnkSOWUMr4h+lzwtFBmPcu+LJZ+FyPv6lBcmYQ3qL8DVf0LOw1v4Jh2pXNsxiTm
         +xFw==
X-Gm-Message-State: AOJu0YxNqakJjnlgcGtVvM2SDU17ZAd6URfniXxBuBtLpEqdaoJ73Ueo
        sLS0qb9Jz9/F+0p7+VkuYZycsNUBpYvBcFmXX8z2/g==
X-Google-Smtp-Source: AGHT+IFSwRQiPkaYhhZ0TC5wbeP9A0oiMY6H8ikvZvK9LjdFbRTQGnvpAK1r/FmhosNCsVO0GGDYu3rQZ8+RCXJ9MpE=
X-Received: by 2002:a0c:f508:0:b0:641:8e1a:d23b with SMTP id
 j8-20020a0cf508000000b006418e1ad23bmr11266928qvm.31.1694481467597; Mon, 11
 Sep 2023 18:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230912005752.1532888-1-utkarsh.h.patel@intel.com> <20230912005752.1532888-4-utkarsh.h.patel@intel.com>
In-Reply-To: <20230912005752.1532888-4-utkarsh.h.patel@intel.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 11 Sep 2023 18:17:35 -0700
Message-ID: <CACeCKacmH19niA7gWTZCj89ZmFth0LWvkMYasYwUvVHrmFKCZw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, chrome-platform@lists.linux.dev,
        andriy.shevchenko@linux.intel.com, bleung@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Utkarsh,

On Mon, Sep 11, 2023 at 5:58=E2=80=AFPM Utkarsh Patel <utkarsh.h.patel@inte=
l.com> wrote:
>
> Displayport Alternatemode 2.1 requires cable capabilities such as cable
> signalling, cable type, DPAM version which then will be used by mux
> driver for displayport configuration. These capabilities can be derived
> from the Cable VDO.
> Added a helper macro to get the Type C cable speed when provided the
> cable VDO.
>
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

Thank you for addressing the comments. This LGTM; I have one minor suggesti=
on,
but I'll leave it to USB maintainers for the final call on that comment, so=
:

Acked-by: Prashant Malani <pmalani@chromium.org>

> ---
> Changes in v3:
> - Removed use of variable cable_seepd.
> - Added helper macro of pd_vdo.h in this patch as cros_ec_typec is the us=
er.
>
> Changes in v2:
> - Remvoed feature flag specifice to DP2.1.
> - Remvoed seperate function for DP2.1.
> - Removed use of EC host coammnd to get cable details.
> - TBT cable VDO is used to get cable details.
> - Using VDO_CABLE_SPEED macro to get passive cable speed.
>
>  drivers/platform/chrome/cros_ec_typec.c | 28 +++++++++++++++++++++++++
>  include/linux/usb/pd_vdo.h              |  1 +
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index d0b4d3fc40ed..cca913400b39 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -492,6 +492,8 @@ static int cros_typec_enable_dp(struct cros_typec_dat=
a *typec,
>  {
>         struct cros_typec_port *port =3D typec->ports[port_num];
>         struct typec_displayport_data dp_data;
> +       u32 cable_tbt_vdo;
> +       u32 cable_dp_vdo;
>         int ret;
>
>         if (typec->pd_ctrl_ver < 2) {
> @@ -524,6 +526,32 @@ static int cros_typec_enable_dp(struct cros_typec_da=
ta *typec,
>         port->state.data =3D &dp_data;
>         port->state.mode =3D TYPEC_MODAL_STATE(ffs(pd_ctrl->dp_mode));
>
> +       /* Get cable VDO for cables with DPSID to check DPAM2.1 is suppor=
ted */
> +       cable_dp_vdo =3D cros_typec_get_cable_vdo(port, USB_TYPEC_DP_SID)=
;
> +
> +       /**
> +        * Get cable VDO for thunderbolt cables and cables with DPSID but=
 does not
> +        * support DPAM2.1.
> +        */
> +       cable_tbt_vdo =3D cros_typec_get_cable_vdo(port, USB_TYPEC_TBT_SI=
D);
> +
> +       if (cable_dp_vdo & DP_CAP_DPAM_VERSION) {
> +               dp_data.conf |=3D cable_dp_vdo;
> +       } else if (cable_tbt_vdo) {
> +               dp_data.conf |=3D  TBT_CABLE_SPEED(cable_tbt_vdo) << DP_C=
ONF_SIGNALLING_SHIFT;
> +
> +               /* Cable Type */
> +               if (cable_tbt_vdo & TBT_CABLE_OPTICAL)
> +                       dp_data.conf |=3D DP_CONF_CABLE_TYPE_OPTICAL << D=
P_CONF_CABLE_TYPE_SHIFT;
> +               else if (cable_tbt_vdo & TBT_CABLE_RETIMER)
> +                       dp_data.conf |=3D DP_CONF_CABLE_TYPE_RE_TIMER << =
DP_CONF_CABLE_TYPE_SHIFT;
> +               else if (cable_tbt_vdo & TBT_CABLE_ACTIVE_PASSIVE)
> +                       dp_data.conf |=3D DP_CONF_CABLE_TYPE_RE_DRIVER <<=
 DP_CONF_CABLE_TYPE_SHIFT;
> +       } else if (PD_IDH_PTYPE(port->c_identity.id_header) =3D=3D IDH_PT=
YPE_PCABLE) {
> +               dp_data.conf |=3D VDO_TYPEC_CABLE_SPEED(port->c_identity.=
vdo[0]) <<
> +                               DP_CONF_SIGNALLING_SHIFT;
> +       }
> +
>         ret =3D cros_typec_retimer_set(port->retimer, port->state);
>         if (!ret)
>                 ret =3D typec_mux_set(port->mux, &port->state);
> diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
> index b057250704e8..3a747938cdab 100644
> --- a/include/linux/usb/pd_vdo.h
> +++ b/include/linux/usb/pd_vdo.h
> @@ -376,6 +376,7 @@
>          | ((vbm) & 0x3) << 9 | (sbu) << 8 | (sbut) << 7 | ((cur) & 0x3) =
<< 5   \
>          | (vbt) << 4 | (sopp) << 3 | ((spd) & 0x7))
>
> +#define VDO_TYPEC_CABLE_SPEED(vdo)     ((vdo) & 0x7)

I would suggest putting this header modification in a separate patch;
if for some reason we have to revert
the Chrome part of the change, then we won't rip this part out too
(some other driver down the road may use
the macro and would break if it were to be removed). But I'll leave it
to Heikki to determine whether that is preferred.

Thanks,

-Prashant
