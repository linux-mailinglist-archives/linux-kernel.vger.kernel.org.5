Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070167CB4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjJPUwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPUwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:52:37 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46685B0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:52:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53d82bea507so8689844a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697489554; x=1698094354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HU6cA1bWRfvIfBDvXUL6UUn9mAyVrw+2kF9P2luauc=;
        b=KnnpNBuRS3Z6pzATlCxujnLGRaSu9lV4XhxQfLgAwBghl6D37pQuOmKoh4LTAOyLi5
         tW/hXxzQtS2v9XHXBFdwlokEsBXt2eLnEaPH6w8SKbie3t7oTVGJqOcjSkswlSvYQDPp
         pW6B01HOZo6xhhraZBiBvE1lY1spjlDA3AZELF0cAX9qVXrE45wsJqyJm5ndI2ClPL6X
         E+hQIkq+RL7YGGI8lSDoR3WaDcRg3cGSIYr/cSo/wjMOb2dBK3vRry13dBXPYoXSGQX0
         zcaBNL2dkl3iy8WQi+c3l/Q46e3T0LJeWTZyBV9pPeIyLkuq20CQSQG+2Uaw9r3cgz0t
         rjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697489554; x=1698094354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HU6cA1bWRfvIfBDvXUL6UUn9mAyVrw+2kF9P2luauc=;
        b=qIQwJkUm4OAkRbSd7tgehyo4JjHT6OelLFGfwnGuW/BdRu/DsCU8HPL2dUliQU9/cF
         jO3rHLghS0pkWB7CDNeVzAUa2woiZIF7g6soxgorSER/iKheAtLWvNpTc/XaqX2doRGc
         A9vGn/mvMAUkCs2lHwx32jGjifBlXOFdL5YlC9NEG+eypYuOOH/SrOLU7W/Ge3CRU1Ml
         nSN3bFPzAD9tqqCyIKoSjaGpkqooy2hLtEG7rRVKWovS7YMTzoAo5SGzl/zYJhXbPU8P
         6MGyyGEjdpHmQPdC9rytQZgs8vaAhmDUGlRM8nMs3rI9Ubh95oJiibOBjfM0LeRhbbda
         URRg==
X-Gm-Message-State: AOJu0YyVZL7RSqPF+WkdR+G6yoiWwzvawKXObtPfse1Idtya7D5vC4qJ
        fGeg0xEwyc/7Ry9wQQavVfo1NF5VrRBGgDbf4gvcTA==
X-Google-Smtp-Source: AGHT+IHvX+5Vp4Dd/E0t8YnJrM0ptZlI0kjlD4REJBJcFs5dOkKpETV4nVqhxEFchg0ggpy2mpKxg0DuvklQztNybd0=
X-Received: by 2002:a05:6402:5252:b0:53e:21f6:d784 with SMTP id
 t18-20020a056402525200b0053e21f6d784mr337922edd.8.1697489553657; Mon, 16 Oct
 2023 13:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v1-1-4234807ca07e@google.com>
In-Reply-To: <20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v1-1-4234807ca07e@google.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Mon, 16 Oct 2023 13:52:21 -0700
Message-ID: <CAFhGd8rm=KJyinG-aqFj75JqQnC0=_+6NSbcdr=wG7SqXCsppQ@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: replace deprecated strncpy with strscpy
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 1:48=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> We expect ifp->ndev->name to be NUL-terminated based on its use in
> format strings within core.c:
> via brcmf_ifname() ->
> 67 |       char *brcmf_ifname(struct brcmf_if *ifp)
> 68 |       {
> 69 |            if (!ifp)
> 70 |                    return "<if_null>";
> 71 |
> 72 |            if (ifp->ndev)
> 73 |                    return ifp->ndev->name;
> 74 |
> 75 |            return "<if_none>";
> 76 |       }
> ...
> 288 |       static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *sk=
b,
> 289 |                                              struct net_device *nde=
v) {
> ...
> 330 |       brcmf_dbg(INFO, "%s: insufficient headroom (%d)\n",
> 331 |                 brcmf_ifname(ifp), head_delta);
> ...
> 336 |       bphy_err(drvr, "%s: failed to expand headroom\n",
> 337 |                brcmf_ifname(ifp));
>
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
>
> Found with: $ rg "strncpy\("
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 2a90bb24ba77..7daa418df877 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -866,7 +866,7 @@ struct wireless_dev *brcmf_apsta_add_vif(struct wiphy=
 *wiphy, const char *name,
>                 goto fail;
>         }
>
> -       strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
> +       strscpy(ifp->ndev->name, name, sizeof(ifp->ndev->name));
>         err =3D brcmf_net_attach(ifp, true);
>         if (err) {
>                 bphy_err(drvr, "Registering netdevice failed\n");
>
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmf=
mac-cfg80211-c-a20108421685
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>

Ignore this patch. It will be rolled into a series with others.

Just found some more strncpy uses in broadcom/brcm80211 so I will make a se=
ries
fixing them all at once.


Thanks
Justin
