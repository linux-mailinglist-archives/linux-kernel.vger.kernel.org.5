Return-Path: <linux-kernel+bounces-154652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC338ADF21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BD12888F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93B0535DC;
	Tue, 23 Apr 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgPtDm2E"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6A4482FA;
	Tue, 23 Apr 2024 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859274; cv=none; b=fg4mIfjkzbi4kY1vlRRUEpXZTqtNyXf9FB/2A0tDQ9iTIb2mVs+8clVqP+M21iUhr8ydrAkRXHnro5QtrNCYbyxiDS6M0naxdELXVhtDmZ2jjTmUc53btvFF6dDa6m++c4ZoaQWSSuKQem8RgJIMmWYN8llNOXX1rsT6hTQ4Dv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859274; c=relaxed/simple;
	bh=ng7XtkcAIPwnIKea44bTa7GURBeQsl+FW+nGtuaX67E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYQ1SArBBi2ipq7MbMJYs8+SFIrf2s0msm450dYuBJrpiaIbSZMADeNXYB8MstSu7f2Az6kXhJMvF13isoq7YWE/CIt8ltk6F94QLjS9xwSp5aCUsaPCa+ofz1n3UHJgZfW7GaSquwGII7mLFS2Ya7gIby9QXedKiR0Y1aMHpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgPtDm2E; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2dae975d0dcso63863191fa.1;
        Tue, 23 Apr 2024 01:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713859268; x=1714464068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+PI63vp8dcetV6uo5/jONMF2OhlOcMYFOX5cPVZ17Q=;
        b=mgPtDm2Ehj4z8QcLNIEPqg5/Y8mrz7e9zhjdUfPsGXN5njuK2aC2J6E0sypEQ8MWFF
         ns1UizAsy84TNndzHtV71QyFPygEw9Rldq9PRtrac+Ek2ZbbpEW5P0agN6fzKR+B/6rY
         9mBBPfbuDko9NbDAyyFzfuRVzY6yQfY2Ha0AqceZdkKQtn2cocWsVxO43gXE2a66/yWP
         /wm2sAssYkZt76foQlrfEaITevnX0u9KmiwRofidc1NduvKu+xlj5L/oMZRUT6xZjAiC
         5yAJkCfP8fhLwrBbyN7kFufTs9bUXpWHnNQHhtTNDJmyDCpe/3EGYwnVn2p1K8f3Gr+t
         0oQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713859268; x=1714464068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+PI63vp8dcetV6uo5/jONMF2OhlOcMYFOX5cPVZ17Q=;
        b=b2Gln+XUY7df6sa77yInTItdMyGGd1rGYUTboGahHu74X+f5fjlP6kO2ZvfJ+iILlo
         w91yFBLsG2fi1VETK8Ib1QauviCeHeDoObh0BnerGjhXHkroUTk1jVWmCD94NriIJKp9
         Rcty+48fMRjKBTLZUOZw1Jwze6sMRJv0YYNMFXA013FcuNJoPPHIMnR0Fb68l8+irJTa
         0OwdnA0Dph9Cm3idLEj3a8BQoPNkpIAOTEO6a8WAtlqf2W8L/Z1qQ3gSjEzyVO/9RCyw
         f1Ar8L8zbUPFMJR2cu6QHnwHma2Szly5YVL5q+kVNBz62+lsXt/5o3jx6uBdkv7C58vp
         WvWg==
X-Forwarded-Encrypted: i=1; AJvYcCVIL/J544EQ2mAcMJ+6XpuzBxT/Gf3kh358HpPzXpLT5EG7pZ18SAJCrdjiKPkU4AwRlXCx5npoxvHqqja80buE6dnJrMMbaFOa779TjkYp9RsqFaHoX7He3U99C9VY/1yXH89oqvecmzoz9bM=
X-Gm-Message-State: AOJu0Yzl6vh9TFISVUQ3xWhbLaAm5kYEbjgZPJWSQunVsR1PwVngX5OA
	KfwCqjFdPTLW5RBuA5HitYTZQtM9iR4bG5dBxuuikNJAeS2pWKWEL0cvIV5i3WNETAL/sbzeX5k
	bzFTPP8mF9Bmjyd4LDy2rdDNEf7w=
X-Google-Smtp-Source: AGHT+IEcmF0yT1ETaoCyLgOqrkAYjlhww58t93fSkt375JfUnoJWJ3GcHmsSGYh7sJSBawrbvEwuvXJS97WHGKDcPH0=
X-Received: by 2002:a2e:9683:0:b0:2da:7944:9521 with SMTP id
 q3-20020a2e9683000000b002da79449521mr500848lji.25.1713859267424; Tue, 23 Apr
 2024 01:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417-mac_addr_at_probe-v1-0-67d6c9b3bc2b@bootlin.com> <20240417-mac_addr_at_probe-v1-6-67d6c9b3bc2b@bootlin.com>
In-Reply-To: <20240417-mac_addr_at_probe-v1-6-67d6c9b3bc2b@bootlin.com>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Tue, 23 Apr 2024 10:00:55 +0200
Message-ID: <CAEyMn7aZy+RAo3m=idPi0P152UO+WPm0sfQFdDrUpwmeuUgYBQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] wifi: wilc1000: read MAC address from fuse at probe
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Kalle Valo <kvalo@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexis, All

Am Mi., 17. Apr. 2024 um 11:34 Uhr schrieb Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com>:
>
> From: Ajay Singh <ajay.kathat@microchip.com>
>
> The default netdev interface exposed by WILC1000 is registered at probe,
> but the chip mac address is not known until ndo_open, which will load and
> start chip firmware and then retrieve stored MAC address from it. As a
> consequence, the interface has uninitialized value (00:00:00:00:00) until=
 a
> user brings up the interface.
>
> Fix MAC address at probe by setting the following steps:
> - at probe, read MAC address directly from fuse
> - whenever a new netdevice is created, apply saved mac address (which can
>   be a user-provided address, or the eFuse Mac address if no address has
>   been passed by user)
> - whenever an interface is brought up for the first time (and so the
>   firmware is loaded and started), enforce netdevice mac address to the
>   chip (in case user has changed it)
>
> Reported-by: Heiko Thiery <heiko.thiery@gmail.com>
> Closes: https://lore.kernel.org/netdev/CAEyMn7aV-B4OEhHR4Ad0LM3sKCz1-nDqS=
b9uZNmRWR-hMZ=3Dz+A@mail.gmail.com/T/
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Co-developed-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
> Signed-off-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>

I applied the series on next and tested it on my env. It looks good.

Tested-by: Heiko Thiery <heiko.thiery@gmail.com>

Thank you!
Heiko

> ---
>  drivers/net/wireless/microchip/wilc1000/netdev.c | 38 ++++++++++++++----=
------
>  drivers/net/wireless/microchip/wilc1000/sdio.c   | 14 +++++++++
>  drivers/net/wireless/microchip/wilc1000/spi.c    |  6 ++++
>  3 files changed, 42 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/n=
et/wireless/microchip/wilc1000/netdev.c
> index 5ab448d0b643..f1fbc6e8a82a 100644
> --- a/drivers/net/wireless/microchip/wilc1000/netdev.c
> +++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
> @@ -588,7 +588,6 @@ static int wilc_mac_open(struct net_device *ndev)
>         struct wilc *wl =3D vif->wilc;
>         int ret =3D 0;
>         struct mgmt_frame_regs mgmt_regs =3D {};
> -       u8 addr[ETH_ALEN] __aligned(2);
>
>         if (!wl || !wl->dev) {
>                 netdev_err(ndev, "device not ready\n");
> @@ -607,25 +606,19 @@ static int wilc_mac_open(struct net_device *ndev)
>                 return ret;
>         }
>
> -       wilc_set_operation_mode(vif, wilc_get_vif_idx(vif), vif->iftype,
> -                               vif->idx);
> -
> -       if (is_valid_ether_addr(ndev->dev_addr)) {
> -               ether_addr_copy(addr, ndev->dev_addr);
> -               wilc_set_mac_address(vif, addr);
> -       } else {
> -               wilc_get_mac_address(vif, addr);
> -               eth_hw_addr_set(ndev, addr);
> -       }
>         netdev_dbg(ndev, "Mac address: %pM\n", ndev->dev_addr);
> -
> -       if (!is_valid_ether_addr(ndev->dev_addr)) {
> -               netdev_err(ndev, "Wrong MAC address\n");
> +       ret =3D wilc_set_mac_address(vif, ndev->dev_addr);
> +       if (ret) {
> +               netdev_err(ndev, "Failed to enforce MAC address in chip")=
;
>                 wilc_deinit_host_int(ndev);
> -               wilc_wlan_deinitialize(ndev);
> -               return -EINVAL;
> +               if (!wl->open_ifcs)
> +                       wilc_wlan_deinitialize(ndev);
> +               return ret;
>         }
>
> +       wilc_set_operation_mode(vif, wilc_get_vif_idx(vif), vif->iftype,
> +                               vif->idx);
> +
>         mgmt_regs.interface_stypes =3D vif->mgmt_reg_stypes;
>         /* so we detect a change */
>         vif->mgmt_reg_stypes =3D 0;
> @@ -941,6 +934,7 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl=
, const char *name,
>                                       int vif_type, enum nl80211_iftype t=
ype,
>                                       bool rtnl_locked)
>  {
> +       u8 mac_address[ETH_ALEN];
>         struct net_device *ndev;
>         struct wilc_vif *vif;
>         int ret;
> @@ -969,6 +963,18 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *w=
l, const char *name,
>         vif->iftype =3D vif_type;
>         vif->idx =3D wilc_get_available_idx(wl);
>         vif->mac_opened =3D 0;
> +
> +       memcpy(mac_address, wl->nv_mac_address, ETH_ALEN);
> +       /* WILC firmware uses locally administered MAC address for the
> +        * second virtual interface (bit 1 of first byte set), but
> +        * since it is possibly not loaded/running yet, reproduce this be=
havior
> +        * in the driver during interface creation.
> +        */
> +       if (vif->idx)
> +               mac_address[0] |=3D 0x2;
> +
> +       eth_hw_addr_set(vif->ndev, mac_address);
> +
>         mutex_lock(&wl->vif_mutex);
>         list_add_tail_rcu(&vif->list, &wl->vif_list);
>         wl->vif_num +=3D 1;
> diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net=
/wireless/microchip/wilc1000/sdio.c
> index 04d6565df2cb..e6e20c86b791 100644
> --- a/drivers/net/wireless/microchip/wilc1000/sdio.c
> +++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
> @@ -24,6 +24,9 @@ MODULE_DEVICE_TABLE(sdio, wilc_sdio_ids);
>
>  #define WILC_SDIO_BLOCK_SIZE 512
>
> +static int wilc_sdio_init(struct wilc *wilc, bool resume);
> +static int wilc_sdio_deinit(struct wilc *wilc);
> +
>  struct wilc_sdio {
>         bool irq_gpio;
>         u32 block_size;
> @@ -178,6 +181,16 @@ static int wilc_sdio_probe(struct sdio_func *func,
>         }
>         clk_prepare_enable(wilc->rtc_clk);
>
> +       wilc_sdio_init(wilc, false);
> +
> +       ret =3D wilc_load_mac_from_nv(wilc);
> +       if (ret) {
> +               pr_err("Can not retrieve MAC address from chip\n");
> +               goto clk_disable_unprepare;
> +       }
> +
> +       wilc_sdio_deinit(wilc);
> +
>         vif =3D wilc_netdev_ifc_init(wilc, "wlan%d", WILC_STATION_MODE,
>                                    NL80211_IFTYPE_STATION, false);
>         if (IS_ERR(vif)) {
> @@ -187,6 +200,7 @@ static int wilc_sdio_probe(struct sdio_func *func,
>
>         dev_info(&func->dev, "Driver Initializing success\n");
>         return 0;
> +
>  clk_disable_unprepare:
>         clk_disable_unprepare(wilc->rtc_clk);
>  dispose_irq:
> diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/=
wireless/microchip/wilc1000/spi.c
> index add0e70a09ea..5ff940c53ad9 100644
> --- a/drivers/net/wireless/microchip/wilc1000/spi.c
> +++ b/drivers/net/wireless/microchip/wilc1000/spi.c
> @@ -250,6 +250,12 @@ static int wilc_bus_probe(struct spi_device *spi)
>         if (ret)
>                 goto power_down;
>
> +       ret =3D wilc_load_mac_from_nv(wilc);
> +       if (ret) {
> +               pr_err("Can not retrieve MAC address from chip\n");
> +               goto power_down;
> +       }
> +
>         wilc_wlan_power(wilc, false);
>         vif =3D wilc_netdev_ifc_init(wilc, "wlan%d", WILC_STATION_MODE,
>                                    NL80211_IFTYPE_STATION, false);
>
> --
> 2.44.0
>

