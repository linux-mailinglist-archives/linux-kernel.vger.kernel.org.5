Return-Path: <linux-kernel+bounces-5771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EA4818F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6561F285CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDA339AE2;
	Tue, 19 Dec 2023 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGNyDIKy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A5D37D21;
	Tue, 19 Dec 2023 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cb21afa6c1so67644811fa.0;
        Tue, 19 Dec 2023 10:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703009230; x=1703614030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1ZwhJRZ+N/d+fVkkOSiSnflGiueYMOvsJ8Gh3pY+IU=;
        b=AGNyDIKyj8U/cb68cytRNvA6qP8BT2drBNahHGjI4Q1JmXEES1l4js7XoAkMGCfXSs
         BoArn8jLLoLvTFLHoNeqPG/pEc1cqE1UlOPi3HMPi1aCevbCCm2/NiU5XGSzFp6g3yWV
         MAKAV/WUeJRj34BIOkl935xVKP47qDKqZchm/P53y2jrtO9Ld2i2jumCr6ioNKL90qPj
         w1eV3DRh2AWes2/vHDVTywsYnV3/0J2rwVCIbii6+m1mwsjx7tcoOCDCjpqo29Un5mRY
         ttDEV6zJ7uklFZwiRH5/wtAaL/pXp8lxpLg+u8rnBWp1tSpRJfhEZxDexxfyfeT/gxAc
         6+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009230; x=1703614030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1ZwhJRZ+N/d+fVkkOSiSnflGiueYMOvsJ8Gh3pY+IU=;
        b=g5JpnU9cAH9lngE5sGv0e48qhBCdIbEAkOU+WqUG9SbqeLyu/tsByzQtLJg/K81pIn
         Zky10VyZYtzWwiaALUeDtOcQdFd6zxSROO911D2VqeCJERrhDaVttxUzeiXBiU+5kniU
         BMO610fh5+p65BSgwSOCnkyj1wJmBIBfKYCzU9G8LHLJzsmg9xxsbgMOjIPfSkqhYS9l
         X6tp2tuOawzrmWKnfnbELwTyPFjhMCXib3AJb/6G9Dt1mwBT7pZzwiKTGV4gVDnv0Cb1
         K6wRU52Ish6RS5xEqGtMZ1t+eBtNxGijs9R3VQVIHRIqP7egLE1EGrRN4S4ugrVhgmko
         RvLQ==
X-Gm-Message-State: AOJu0Yy8sg9tY0lxi3Qr6+XtVI2A/q85ykQ6zIUz2oSM5wjH0PlAj9Tz
	HX3HDbqq13BeC5VG4ZB44ZS4nJS5oE8O+v0DNbo=
X-Google-Smtp-Source: AGHT+IHgrHf2vtd9/nC2WuK81Zvn8uEeNd7HMPJmvdMP//OocIojGSo3xSvxYEcEm60tX4XNcioe2quihSJ1O8WT8pA=
X-Received: by 2002:a2e:b606:0:b0:2cc:87b4:3f9f with SMTP id
 r6-20020a2eb606000000b002cc87b43f9fmr498039ljn.22.1703009229969; Tue, 19 Dec
 2023 10:07:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208130705.kernel.v1.1.Ic5024b3da99b11e39c247a5b8ba44876c18880a0@changeid>
In-Reply-To: <20231208130705.kernel.v1.1.Ic5024b3da99b11e39c247a5b8ba44876c18880a0@changeid>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 Dec 2023 13:06:57 -0500
Message-ID: <CABBYNZKOKOCzLkggM1PRXuFjsaU9-0=6WmdTxaF-s3v7WSzvhg@mail.gmail.com>
Subject: Re: [kernel PATCH v1] Bluetooth: btmtksdio: clear BTMTKSDIO_BT_WAKE_ENABLED
 after resume
To: Zhengping Jiang <jiangzp@google.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhengping,

On Fri, Dec 8, 2023 at 4:07=E2=80=AFPM Zhengping Jiang <jiangzp@google.com>=
 wrote:
>
> Always clear BTMTKSDIO_BT_WAKE_ENABLED bit after resume. When Bluetooth
> does not generate interrupts, the bit will not be cleared and causes
> premature wakeup.
>
> Fixes: 4ed924fc122f ("Bluetooth: btmtksdio: enable bluetooth wakeup in sy=
stem suspend")
> Signed-off-by: Zhengping Jiang <jiangzp@google.com>
> ---
>
> Changes in v1:
> - Clear BTMTKSDIO_BT_WAKE_ENABLED flag on resume
>
>  drivers/bluetooth/btmtksdio.c    | 10 ++++++++++
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_sync.c         |  2 ++
>  3 files changed, 13 insertions(+)
>
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.=
c
> index ff4868c83cd8..8f00b71573c8 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -1296,6 +1296,15 @@ static bool btmtksdio_sdio_inband_wakeup(struct hc=
i_dev *hdev)
>         return device_may_wakeup(bdev->dev);
>  }
>
> +static void btmtksdio_disable_bt_wakeup(struct hci_dev *hdev)
> +{
> +       struct btmtksdio_dev *bdev =3D hci_get_drvdata(hdev);
> +
> +       if (!bdev)
> +               return;
> +       clear_bit(BTMTKSDIO_BT_WAKE_ENABLED, &bdev->tx_state);
> +}
> +
>  static bool btmtksdio_sdio_wakeup(struct hci_dev *hdev)
>  {
>         struct btmtksdio_dev *bdev =3D hci_get_drvdata(hdev);
> @@ -1363,6 +1372,7 @@ static int btmtksdio_probe(struct sdio_func *func,
>         hdev->shutdown =3D btmtksdio_shutdown;
>         hdev->send     =3D btmtksdio_send_frame;
>         hdev->wakeup   =3D btmtksdio_sdio_wakeup;
> +       hdev->clear_wakeup =3D btmtksdio_disable_bt_wakeup;
>         /*
>          * If SDIO controller supports wake on Bluetooth, sending a wakeo=
n
>          * command is not necessary.
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 0c1754f416bd..4bbd55335269 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -672,6 +672,7 @@ struct hci_dev {
>         int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
>                                      struct bt_codec *codec, __u8 *vnd_le=
n,
>                                      __u8 **vnd_data);
> +       void (*clear_wakeup)(struct hci_dev *hdev);

I wonder if it wouldn't be a better idea to add something like suspend
and resume callbacks to notify the about these hdev states, that way
we can synchronize the states better and avoid having to clear the
wakeup state when it shouldn't be active to begin with since the hdev
is not suspended.

>  };
>
>  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 3563a90ed2ac..6c4d5ce40524 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5947,6 +5947,8 @@ int hci_resume_sync(struct hci_dev *hdev)
>                 return 0;
>
>         hdev->suspended =3D false;
> +       if (hdev->clear_wakeup)
> +               hdev->clear_wakeup(hdev);
>
>         /* Restore event mask */
>         hci_set_event_mask_sync(hdev);
> --
> 2.43.0.472.g3155946c3a-goog
>


--=20
Luiz Augusto von Dentz

