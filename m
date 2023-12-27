Return-Path: <linux-kernel+bounces-11955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355E781EE24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A759B223BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05602D03C;
	Wed, 27 Dec 2023 10:22:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0772D601;
	Wed, 27 Dec 2023 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ccae380df2so32100021fa.1;
        Wed, 27 Dec 2023 02:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703672549; x=1704277349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi4TlIJ12BosdtGbAjBJ8dn6XFy5YIY+Ci6AaYE0l3g=;
        b=ruSbb+950Zsmf1q/Y4WWnNY5RPjYOLPuM2gXrsHwAF4yE5QszGYKIFzgb6tf6zBlj5
         PB8gdga0eIvhN/twRL9ci0010i8qV9iZlte71VdqaXkLSzyYMcxcy5jQ6jVZrsejbjgB
         SADmV60CZBIYh4G/ubkoTBUz5ZejahWSAQ5+qTZ0fbL0EvDIJT7UoT8hnb0XTrTdAbOP
         ujsiL8mH/vFMQHkc9/trCqJjiU/mu+OgTFmWwiA7syQa9M5808EXycPUyEabU1pRT1Xt
         9UTLPD+EEuI2IUrbcWlEuotY11rFmClsOwFg+5MpCdXwbTKrVgAsmE5s9HkJX4AalhJ0
         BVyg==
X-Gm-Message-State: AOJu0Yw9dSaJpkAm9zO1N3ulvXn5OqQSj2WYChSaSbvWasPrtKbeQpAq
	3LgvSk5Pxl2gXA3jitSI6OuhEe0RWH5WGEp5d44=
X-Google-Smtp-Source: AGHT+IHislpaxFun1Ue0Es3e+ckx8G7vlhRslnJrlXb+32NXUdjEzl7AcnccRkpoy+FumkZjRCvKLw==
X-Received: by 2002:a2e:5c42:0:b0:2cc:8e4d:7989 with SMTP id q63-20020a2e5c42000000b002cc8e4d7989mr2936690ljb.8.1703672548361;
        Wed, 27 Dec 2023 02:22:28 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a14-20020a50ff0e000000b0054d360bdfd6sm8383155edu.73.2023.12.27.02.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 02:22:28 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5554f268c6cso529365a12.1;
        Wed, 27 Dec 2023 02:22:28 -0800 (PST)
X-Received: by 2002:a17:906:f744:b0:a26:9534:92f9 with SMTP id
 jp4-20020a170906f74400b00a26953492f9mr2993627ejb.106.1703672547815; Wed, 27
 Dec 2023 02:22:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <77419ffacc5b4875e920e038332575a2a5bff29f.camel@mrman314.tech>
In-Reply-To: <77419ffacc5b4875e920e038332575a2a5bff29f.camel@mrman314.tech>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 27 Dec 2023 05:21:50 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8fjbyQL725oGrqTr1kArBWFi=uMPYeLzse_d7DUn2Eqw@mail.gmail.com>
Message-ID: <CAEg-Je8fjbyQL725oGrqTr1kArBWFi=uMPYeLzse_d7DUn2Eqw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel MacBooks
To: Felix Zhang <mrman@mrman314.tech>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org, marcan@marcan.st, 
	bagasdotme@gmail.com, sven@svenpeter.dev, alyssa@rosenzweig.io, 
	marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com, 
	orlandoch.dev@gmail.com, kekrby@gmail.com, admin@kodeit.net, j@jannau.net, 
	gargaditya08@live.com, asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 3:01=E2=80=AFPM Felix Zhang <mrman@mrman314.tech> w=
rote:
>
> Starting v6.5, Bluetooth does not work at all on my T2 MacBookAir9,1
>
> with the BCM4377 chip.  When I boot up the computer, go into
> bluetoothctl, and then try to run commands like scan on, show, list,
> it returns "No default controller available."  I have tried reloading
> the
> kernel module, in which the log outputs "{Added,Removed} hci0
> (unconfigured)."  With this patch, I am able to use Bluetooth as
> normal
> without any errors regarding hci0 being unconfigured.  However, an
> issue is still present where sometimes hci_bcm4377 will have to be
> reloaded in order to get bluetooth to work.  I believe this was still
> present before the previously mentioned commit.
>
> Due to the bit HCI_QUIRK_USE_BDADDR_PROPERTY being always set in
> drivers/bluetooth/hci_bcm4377.c (line 2371), the chip would be left
> unconfigured on kernels compiled after commit 6945795bc81a
> ("Bluetooth:
> fix use-bdaddr-property quirk") due to a change in its logic.  On the
> M1 Macs, the device would be configured in the devicetree.  However,
> that is not the case on T2 Macs.  Because the bluetooth adapter is
> left
> unconfigured, it is not usable in the operating system.  In order to
> circumvent this issue, a flag is added to prevent the bit from being
> set on the BCM4377, while setting it on the other devices.
>
> Because I do not have an M1 device to test this patch on, I am not sure
> whether the patch breaks anything for said devices.  I would be very
> grateful if anyone is willing to test this patch on their M1 device.
>
> I would also like to thank Kerem Karabay <kekrby@gmail.com> for
> assisting me with this patch.
>
> Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
> Signed-off-by: Felix Zhang <mrman@mrman314.tech>
> ---
> v3:
> * Adjust the format to pass the CI (again).
> ---
>  drivers/bluetooth/hci_bcm4377.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_bcm4377.c
> b/drivers/bluetooth/hci_bcm4377.c
> index a61757835695..5c6fef1aa0f6 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -513,6 +513,7 @@ struct bcm4377_hw {
>         unsigned long broken_ext_scan : 1;
>         unsigned long broken_mws_transport_config : 1;
>         unsigned long broken_le_coded : 1;
> +       unsigned long use_bdaddr_property : 1;
>
>         int (*send_calibration)(struct bcm4377_data *bcm4377);
>         int (*send_ptb)(struct bcm4377_data *bcm4377,
> @@ -2368,7 +2369,8 @@ static int bcm4377_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
>         hdev->set_bdaddr =3D bcm4377_hci_set_bdaddr;
>         hdev->setup =3D bcm4377_hci_setup;
>
> -       set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> +       if (bcm4377->hw->use_bdaddr_property)
> +               set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>         if (bcm4377->hw->broken_mws_transport_config)
>                 set_bit(HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG, &hdev-
> >quirks);
>         if (bcm4377->hw->broken_ext_scan)
> @@ -2465,6 +2467,7 @@ static const struct bcm4377_hw
> bcm4377_hw_variants[] =3D {
>                 .has_bar0_core2_window2 =3D true,
>                 .broken_mws_transport_config =3D true,
>                 .broken_le_coded =3D true,
> +               .use_bdaddr_property =3D true,
>                 .send_calibration =3D bcm4378_send_calibration,
>                 .send_ptb =3D bcm4378_send_ptb,
>         },
> @@ -2479,6 +2482,7 @@ static const struct bcm4377_hw
> bcm4377_hw_variants[] =3D {
>                 .clear_pciecfg_subsystem_ctrl_bit19 =3D true,
>                 .broken_mws_transport_config =3D true,
>                 .broken_le_coded =3D true,
> +               .use_bdaddr_property =3D true,
>                 .send_calibration =3D bcm4387_send_calibration,
>                 .send_ptb =3D bcm4378_send_ptb,
>         },
> --
> 2.43.0
>

This looks reasonable to me, thanks for fixing this!

Reviewed-by: Neal Gompa <neal@gompa.dev>




--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

