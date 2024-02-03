Return-Path: <linux-kernel+bounces-50791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 795E7847DEC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE2D1C21DA9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB7710F9;
	Sat,  3 Feb 2024 00:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Srn9fory"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C21626;
	Sat,  3 Feb 2024 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920753; cv=none; b=f9qoLdSVEmSM/6wZKAirQZwy913MnaoaSMpfS7mI4D+f993gwlytnVmoZqfiM+Q7Q9kc2BJ5v01rY1+VEv1eWTaTICVxomaLqPXxp4agrJch0pWF3OGSnucyWLiB4p/ai0coZvDgivwcbS/GDcAXWjwmVuzomoNx9P8mw0wjEl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920753; c=relaxed/simple;
	bh=CDhdZtJRM4I5jnsGxAP6SnwAa6RKbZAw/Fvw+maWkNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZsMv/R99ejzo0C5FY3Ae0ct65PuS0zTUmVNfO69njqvum8FZB48090rtiYo+plCuxQbSlJ5dWw+PHRGAUK30e6kNg6ZnnhI72n4nXuIh1zLxgEtEiIB56/P3pyPVd6WYJFAKbnvaBgOsUcsepz+x9RGnn0LY8n/xt4qqvKS3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Srn9fory; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6031BC433C7;
	Sat,  3 Feb 2024 00:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706920753;
	bh=CDhdZtJRM4I5jnsGxAP6SnwAa6RKbZAw/Fvw+maWkNY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Srn9foryvIJS0xs4P8A+nbDK/UMUPIPdIrEvrTmEmvXmJGrCd4aROuFdXJG0C9EWi
	 W7X2HidnRAH5brgcd/78Y7FReHPk2xqwF6bsm8yQ0CW8JEkIjn1K5c3uxgrgPiovmS
	 H+If+q12AMFYoxWPEaC5/pmN3bWRCeGpQn2PAFeuJX8kJyD7fYNqrxlnwWnDHotdbr
	 pS3GlimcfeApUKGAZeSCq7m+sRLk5PzlKBpTmd57B4xi7KKSqpayq4JcQG9FWORJEf
	 qsv4UC4Js35rhLdxVUM6y0GvVHsP/PERKPxyLTL51zMmPCyb5FPxt6aJprlpYzWDAy
	 Uf1XThzoYDL5Q==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d08d9b9667so2258931fa.1;
        Fri, 02 Feb 2024 16:39:13 -0800 (PST)
X-Gm-Message-State: AOJu0Yx4RjFYu4qjnpNBMGyK61WxGJqXhj1YB6chRa6DhIVd+y3utOMa
	hUVT9w5g3dpFjHctG6QMidwAsHaR9X9VY6Gnns1IkzmtrXmg1AE3Hh7s+TRxMx0A5m1KdDyO8lx
	bcIsC1pCUHdQIajDJd5P4ACGkbIs=
X-Google-Smtp-Source: AGHT+IHa4ZO2VYWT1mFTKA5zcN1ID/fl9uj+ci0IbUmuSvFG2RP3o0Caq0GTCM9Bplwg/QtZJRfRCtjULrwGAZocaX8=
X-Received: by 2002:a05:6512:313b:b0:511:4643:d913 with SMTP id
 p27-20020a056512313b00b005114643d913mr20056lfd.6.1706920751563; Fri, 02 Feb
 2024 16:39:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102124747.21644-1-hao.qin@mediatek.com> <20240102124747.21644-2-hao.qin@mediatek.com>
In-Reply-To: <20240102124747.21644-2-hao.qin@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Fri, 2 Feb 2024 18:39:00 -0600
X-Gmail-Original-Message-ID: <CAGp9LzqejefGFLpuntAghHUsA58mN_2EQqKynBC-JCYXAEUSZg@mail.gmail.com>
Message-ID: <CAGp9LzqejefGFLpuntAghHUsA58mN_2EQqKynBC-JCYXAEUSZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: btusb: mediatek: add a recovery method
 for MT7922 and MT7925
To: Hao Qin <hao.qin@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Von Dentz <luiz.dentz@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <deren.Wu@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, 
	Chris Lu <chris.lu@mediatek.com>, Steve Lee <steve.lee@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 6:49=E2=80=AFAM Hao Qin <hao.qin@mediatek.com> wrote=
:
>
> From: "hao.qin" <hao.qin@mediatek.com>
>
> For MT7922 and MT7925, add USB reset retry to recover from patch
> download failure, and perform a reset before patch download to
> avoid unexpected problems caused by unkonwn status of dongle.
>
> Signed-off-by: hao.qin <hao.qin@mediatek.com>
> ---
>  drivers/bluetooth/btusb.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index abefcd1a089d..26ad4864d06c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3000,17 +3000,26 @@ static int btusb_mtk_subsys_reset(struct hci_dev =
*hdev, u32 dev_id)
>         u32 val;
>         int err;
>
> -       if (dev_id =3D=3D 0x7925) {
> +       if (dev_id =3D=3D 0x7922) {
> +               btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
> +               val |=3D 0x00002020;
> +               btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
> +               btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001)=
;
> +               btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
> +               val |=3D BIT(0);
> +               btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
> +               msleep(100);
> +       } else if (dev_id =3D=3D 0x7925) {
>                 btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &va=
l);
> -               val |=3D (1 << 5);
> +               val |=3D BIT(5);
>                 btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, va=
l);
>                 btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &va=
l);
>                 val &=3D 0xFFFF00FF;
> -               val |=3D (1 << 13);
> +               val |=3D BIT(13);
>                 btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, va=
l);
>                 btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001)=
;
>                 btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &va=
l);
> -               val |=3D (1 << 0);
> +               val |=3D BIT(0);
>                 btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, va=
l);
>                 btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x0000=
00FF);
>                 btusb_mtk_uhw_reg_read(data, MTK_UDMA_INT_STA_BT, &val);
> @@ -3040,6 +3049,9 @@ static int btusb_mtk_subsys_reset(struct hci_dev *h=
dev, u32 dev_id)
>         if (err < 0)
>                 bt_dev_err(hdev, "Reset timeout");
>
> +       if (dev_id =3D=3D 0x7922)
> +               btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x0000=
00FF);
> +
>         btusb_mtk_id_get(data, 0x70010200, &val);
>         if (!val)
>                 bt_dev_err(hdev, "Can't get device id, subsys reset fail.=
");
> @@ -3128,8 +3140,10 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>                 fwname =3D FIRMWARE_MT7668;
>                 break;
>         case 0x7922:
> -       case 0x7961:
>         case 0x7925:
> +               btusb_mtk_subsys_reset(hdev, dev_id);

Is there any reason we cannot perform a subsystem reset for 0x7961?
I believe it would enhance robustness under any circumstance, such as
cold reboot, warm reboot, or suspension,
ensuring that the controller can be reset to its initial state

> +               fallthrough;
> +       case 0x7961:
>                 if (dev_id =3D=3D 0x7925)
>                         snprintf(fw_bin_name, sizeof(fw_bin_name),
>                                  "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x=
_hdr.bin",
> @@ -3143,6 +3157,11 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>                                                 btusb_mtk_hci_wmt_sync);
>                 if (err < 0) {
>                         bt_dev_err(hdev, "Failed to set up firmware (%d)"=
, err);
> +                       if (dev_id =3D=3D 0x7922 || dev_id =3D=3D 0x7925)=
 {

Similarly, is there any reason we cannot apply the same approach for
mt7961? Using a less specific condition would reduce maintenance
effort in the future.

> +                               btusb_stop_traffic(data);
> +                               usb_kill_anchored_urbs(&data->tx_anchor);
> +                               usb_queue_reset_device(data->intf);

If an error occurs during firmware download, I guess we can
subsequently attempt to download the firmware again through several
retries.
This helps the controller to autonomously recover from any potential
errors and ensure we can complete the initialization process.

> +                       }
>                         return err;
>                 }
>
> --
> 2.18.0
>
>

