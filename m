Return-Path: <linux-kernel+bounces-13132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7E2820023
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE2A28476F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD534125B3;
	Fri, 29 Dec 2023 15:12:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD711CBA;
	Fri, 29 Dec 2023 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so12002277a12.0;
        Fri, 29 Dec 2023 07:12:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703862730; x=1704467530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WiNU1LEWoMOUqNGo6cu6jntHEa+IYTRycCPjYF8UZI=;
        b=Jv6Li27PF1AU14fHJjTUxVKSeBLS4HS6zxMP7TnBZ3RnM9qmuFaJJqhcmwbUCGXDOh
         O0CQ8p8pf5luO62Tb4qMLJageGavzxtj+wYx7ZNNlEzsDwlRJLrrW1b4ByIM/7VzgNDx
         8kd/1aqUmzWXSjj5QTY+xrcE2rzhr6RKh7+u5EVYpc6yG7aPxO8x8hAFbCgdfZM1VcI5
         FfAABnxz4ljzZKNXXXIBG4vAIkG1oVaw5ZjjkYGQpH8dB88ddD7wXTr4iRWV3OjOGezN
         11/RiRnFoGj9cxUmfkAEHxHbtqpP+hCunCElAslp4J4BZaxOTUZl7T/nj4ATdI5D65Km
         PH9A==
X-Gm-Message-State: AOJu0YwKXs53UUKHeumq5mmsm9oE6tbQzD7Ck/AfMB07UAsPDAYsXeOr
	iHf6ekA6P2XIcLcVUvyD5ghe5XE7nzwjLnRI2uE=
X-Google-Smtp-Source: AGHT+IERHitNghjW7vaITdOuqsjWF+Un7GLEQ3PnUm7/+6GJ83XVMlklZMI4Hy76IqAUDtHCU29Mmg==
X-Received: by 2002:a50:d55c:0:b0:554:1100:99e9 with SMTP id f28-20020a50d55c000000b00554110099e9mr12967538edj.9.1703862730080;
        Fri, 29 Dec 2023 07:12:10 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id p20-20020aa7cc94000000b00553b746e17esm11264425edt.83.2023.12.29.07.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 07:12:09 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2768b78a9eso252671366b.0;
        Fri, 29 Dec 2023 07:12:09 -0800 (PST)
X-Received: by 2002:a17:906:5c:b0:a1e:842d:ccd5 with SMTP id
 28-20020a170906005c00b00a1e842dccd5mr10324550ejg.48.1703862729636; Fri, 29
 Dec 2023 07:12:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227101003.10534-1-johan+linaro@kernel.org>
In-Reply-To: <20231227101003.10534-1-johan+linaro@kernel.org>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 29 Dec 2023 10:11:32 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-WJZGMgurcQY3p9wQffEJmN3OsiK_9ictsFV3uTGdS9g@mail.gmail.com>
Message-ID: <CAEg-Je-WJZGMgurcQY3p9wQffEJmN3OsiK_9ictsFV3uTGdS9g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm4377: do not mark valid bd_addr as invalid
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Felix Zhang <mrman@mrman314.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 5:10=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> A recent commit restored the original (and still documented) semantics
> for the HCI_QUIRK_USE_BDADDR_PROPERTY quirk so that the device address
> is considered invalid unless an address is provided by firmware.
>
> This specifically means that this flag must only be set for devices with
> invalid addresses, but the Broadcom BCM4377 driver has so far been
> setting this flag unconditionally.
>
> Fortunately the driver already checks for invalid addresses during setup
> and sets the HCI_QUIRK_INVALID_BDADDR flag, which can simply be replaced
> with HCI_QUIRK_USE_BDADDR_PROPERTY to indicate that the default address
> is invalid but can be overridden by firmware (long term, this should
> probably just always be allowed).
>
> Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
> Cc: stable@vger.kernel.org      # 6.5
> Reported-by: Felix Zhang <mrman@mrman314.tech>
> Link: https://lore.kernel.org/r/77419ffacc5b4875e920e038332575a2a5bff29f.=
camel@mrman314.tech/
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/hci_bcm4377.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4=
377.c
> index a61757835695..9a7243d5db71 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -1417,7 +1417,7 @@ static int bcm4377_check_bdaddr(struct bcm4377_data=
 *bcm4377)
>
>         bda =3D (struct hci_rp_read_bd_addr *)skb->data;
>         if (!bcm4377_is_valid_bdaddr(bcm4377, &bda->bdaddr))
> -               set_bit(HCI_QUIRK_INVALID_BDADDR, &bcm4377->hdev->quirks)=
;
> +               set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &bcm4377->hdev->qu=
irks);
>
>         kfree_skb(skb);
>         return 0;
> @@ -2368,7 +2368,6 @@ static int bcm4377_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>         hdev->set_bdaddr =3D bcm4377_hci_set_bdaddr;
>         hdev->setup =3D bcm4377_hci_setup;
>
> -       set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>         if (bcm4377->hw->broken_mws_transport_config)
>                 set_bit(HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG, &hdev->qui=
rks);
>         if (bcm4377->hw->broken_ext_scan)
> --
> 2.41.0
>
>

Looks good to me. This replaces the other patch[1], I take it?

Reviewed-by: Neal Gompa <neal@gompa.dev>

[1]: https://lore.kernel.org/asahi/aaa107865f4cbd61f8f9006fd3e7ac43b5d1bdad=
.camel@mrman314.tech/

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

