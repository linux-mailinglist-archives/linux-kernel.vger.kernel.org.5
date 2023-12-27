Return-Path: <linux-kernel+bounces-11957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4437981EE28
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A481F217EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C738D2D043;
	Wed, 27 Dec 2023 10:24:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1EC2D787;
	Wed, 27 Dec 2023 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ccd4b743e2so10862481fa.0;
        Wed, 27 Dec 2023 02:24:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703672655; x=1704277455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVwxJBV9dNfPBB0zTv6L5ZFrZ/KLxWM50ofClNNSEY8=;
        b=SWwEXEIfJz2hPlh+p6pmlC/QJmNK+bMM98MXoS2ZY0PQRV3VsGJX7/fb1vp1CRqvqw
         sf4YJw+vTAeeHNzflebhSz++wjWLX5AoUSuoMFr6g/ND0SXSb3oPQpGoTGs1VroJRB/H
         oAv8u1+LYAd6I3K7+1xdtO8/Glf5STuRNmgcYpQV99uK4B7fLL6Wrw/GW9xOBO+HHNcf
         wSDdYsN0daJBk+tz+EHghTbgYicehJhiEgbSvtrHpYoxryZF7iaTjVnSb7Nb/P1SWD8Z
         O0rpIyqmFhxffsekx8swi4rQodYKgYF2WEq9rYGSfXzJ57IU+y3e4CntyL8404UGHJ9b
         /QYw==
X-Gm-Message-State: AOJu0YyU68RypMm/X96lVIPBxAE5tYvJuTosrHRbmy9/krlcphggXtnD
	y5xe19nDf+NljpramZDY2N4H+ybJPojURddz55g=
X-Google-Smtp-Source: AGHT+IEFaZTQvgM3gcK5vb7cXkhYZOSARQdmcgitsKcfUSqssAF5YZS+LHPlMReIf04IuAhk2x5p4g==
X-Received: by 2002:a05:6512:3c8a:b0:50e:75ec:26ed with SMTP id h10-20020a0565123c8a00b0050e75ec26edmr1721277lfv.47.1703672655103;
        Wed, 27 Dec 2023 02:24:15 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id cs13-20020a0564020c4d00b00554a3c80d73sm4667380edb.96.2023.12.27.02.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 02:24:14 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55361b7f38eso5874812a12.0;
        Wed, 27 Dec 2023 02:24:14 -0800 (PST)
X-Received: by 2002:a17:906:46d8:b0:a23:5eb9:367d with SMTP id
 k24-20020a17090646d800b00a235eb9367dmr2329262ejs.227.1703672654628; Wed, 27
 Dec 2023 02:24:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aaa107865f4cbd61f8f9006fd3e7ac43b5d1bdad.camel@mrman314.tech>
In-Reply-To: <aaa107865f4cbd61f8f9006fd3e7ac43b5d1bdad.camel@mrman314.tech>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 27 Dec 2023 05:23:37 -0500
X-Gmail-Original-Message-ID: <CAEg-Je83qHR=5v6YbAguVH8QNmnaPV6GKb6U6aDcV-_+cE291Q@mail.gmail.com>
Message-ID: <CAEg-Je83qHR=5v6YbAguVH8QNmnaPV6GKb6U6aDcV-_+cE291Q@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel MacBooks
To: Felix Zhang <mrman@mrman314.tech>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org, marcan@marcan.st, 
	bagasdotme@gmail.com, sven@svenpeter.dev, alyssa@rosenzweig.io, 
	marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com, 
	orlandoch.dev@gmail.com, kekrby@gmail.com, admin@kodeit.net, j@jannau.net, 
	gargaditya08@live.com, asahi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 3:21=E2=80=AFPM Felix Zhang <mrman@mrman314.tech> w=
rote:
>
> Starting v6.5, Bluetooth does not work at all on my T2
> MacBookAir9,1 with the BCM4377 chip.  When I boot up the computer,
> go into bluetoothctl, and then try to run commands like scan on,
> show, list, it returns "No default controller available."  I have
> tried reloading the kernel module, in which the log outputs
> "{Added,Removed} hci0 (unconfigured)."  With this patch, I
> am able to use Bluetooth as normal without any errors regarding
> hci0 being unconfigured.  However, an issue is still present
> where sometimes hci_bcm4377 will have to be reloaded in order to
> get bluetooth to work.  I believe this was still present before
> the previously mentioned commit.
>
> I would also like to thank Kerem Karabay <kekrby@gmail.com> for
> assisting me with this patch.
>
> Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Felix Zhang <mrman@mrman314.tech>
> ---
> v4:
> * Adjust the format to pass the CI (again).
> * Shorten description
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
> @@ -2368,5 +2369,6 @@ static int bcm4377_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
>         hdev->set_bdaddr =3D bcm4377_hci_set_bdaddr;
>         hdev->setup =3D bcm4377_hci_setup;
>
> -       set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> +       if (bcm4377->hw->use_bdaddr_property)
> +               set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>         if (bcm4377->hw->broken_mws_transport_config)
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
>

Sorry, excuse me for replying to the wrong message, I got confused by
Gmail on what to reply to.

This is fine and thanks for the fix!

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

