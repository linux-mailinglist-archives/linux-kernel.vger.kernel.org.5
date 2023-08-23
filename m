Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2602A78637D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbjHWWiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238742AbjHWWia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:38:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2472110E4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:38:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-523b066d7ceso7601650a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692830292; x=1693435092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyGN9+zD7zPLZKhTQnParhbWv7+hi6AW4TCo+HHwTrs=;
        b=inISYB0JpQm43URH7Bt2TMvS9i3ee5FdzQPN4XnDKOx2WssyzGb+E04Fj2goJwNVHx
         O+SZDW8YvebN2o14/X4xD+xxkp2859/HmZqtSU1QutDwusHEXU1wLGr9/DDecwKUuxQH
         gDlMKA3nO3mKbeDUSKAwaV+fEIagRPDol78vyrViXIuq8SV6Q+f/06l7szwSacpUT5mh
         J3ivbDJYdfommysTFh87pizqke8fH7BbCHQwKyIxuuioYXfgojHYLUJPcaI2NN9GCwUE
         FuM+Fc2A8qBE80SH9/Z/ECzdkSA1fkJAAeHc380zG3k59rTpGg/Zlixl4xP5K/Yyt/Ho
         D+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692830292; x=1693435092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyGN9+zD7zPLZKhTQnParhbWv7+hi6AW4TCo+HHwTrs=;
        b=af8kZ6su273/nj7X3YLlLxIGJKQolR5pbb3QW73ydIk9+X/Qu1RxoZcy+tE9Q+JDkv
         PBGHjjYtJJtJ1xpL5JatTELbKwnV9/VfZpA0QWbn1hq3YsBcNiEmbd056UTadBY9+p55
         tlsl6vdrCPO7g95EsJru+Wpft6PqZKSYy9SFgWveFnQv003MIpnCcd9Iq1epyGb5uq41
         Cmnmfrl1Uar4KjLfk5FE61lqHsx07HxuGJrSFvR+J9fV7K4lG+HPGsxHvbqIwPSBDp6o
         ZS98VK/eIlatiKpySCOxjy+X0y5q+uOOdS8qmoTGmylSlCPcZRw00uyim0QloYBTTzyT
         ZHWw==
X-Gm-Message-State: AOJu0Yx7DFJ8CnbKNeaLwFoLv56STA3qaZTWtLWEJh2/yaGmklVnQKP4
        ufH8K4C2OhsQZ49Orj9VSfMXPunOlqUsBbhAwuuvCA==
X-Google-Smtp-Source: AGHT+IFP9MxJdmuPviuAlED75YimN3tj0vIoX8ellwQP1gB5h5JlWZzElS+hF2pVuu433hWu6xmGZ3r3IXAXnrmCvRE=
X-Received: by 2002:a05:6402:398:b0:523:2e30:aaee with SMTP id
 o24-20020a056402039800b005232e30aaeemr9860373edv.32.1692830292593; Wed, 23
 Aug 2023 15:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692829410.git.gustavoars@kernel.org> <774ab3c21e1f2ee9c95909e5779216d83d05fd9f.1692829410.git.gustavoars@kernel.org>
In-Reply-To: <774ab3c21e1f2ee9c95909e5779216d83d05fd9f.1692829410.git.gustavoars@kernel.org>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 23 Aug 2023 15:38:01 -0700
Message-ID: <CAFhGd8oFbay4bLH=uou=h5QuM6-WwKwYHDfFDgsiNENVrUEQWQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] wifi: mwifiex: Replace one-element array with
 flexible-array member in struct mwifiex_ie_types_rxba_sync
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Wed, Aug 23, 2023 at 3:32=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct mwifiex_ie_types_rxba_sync with
> flexible-array member, and refactor the rest of the code, accordingly.
>
> This results in no differences in binary output.
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c | 2 +-
>  drivers/net/wireless/marvell/mwifiex/fw.h            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drive=
rs/net/wireless/marvell/mwifiex/11n_rxreorder.c
> index d1d3632a3ed7..735aac52bdc4 100644
> --- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> +++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
> @@ -918,7 +918,7 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_priva=
te *priv,
>
>         mwifiex_dbg_dump(priv->adapter, EVT_D, "RXBA_SYNC event:",
>                          event_buf, len);
> -       while (tlv_buf_left >=3D sizeof(*tlv_rxba)) {
> +       while (tlv_buf_left > sizeof(*tlv_rxba)) {
>                 tlv_type =3D le16_to_cpu(tlv_rxba->header.type);
>                 tlv_len  =3D le16_to_cpu(tlv_rxba->header.len);
>                 if (tlv_type !=3D TLV_TYPE_RXBA_SYNC) {
> diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wire=
less/marvell/mwifiex/fw.h
> index f2168fac95ed..8e6db904e5b2 100644
> --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> @@ -779,7 +779,7 @@ struct mwifiex_ie_types_rxba_sync {
>         u8 reserved;
>         __le16 seq_num;
>         __le16 bitmap_len;
> -       u8 bitmap[1];
> +       u8 bitmap[];
>  } __packed;
>
>  struct chan_band_param_set {
> --
> 2.34.1
>
