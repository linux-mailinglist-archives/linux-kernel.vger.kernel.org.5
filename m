Return-Path: <linux-kernel+bounces-50776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA4A847DCB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D5B1C22F40
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D358029A5;
	Sat,  3 Feb 2024 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkJShWdw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194F625;
	Sat,  3 Feb 2024 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920150; cv=none; b=GrYTu0r5yTsR3sWnRx1fCRcoNuAGd9GI+Oz/pxhEvBh4jmjCNXylybpw3IHU+w0xLT5TcuQMNF73FBurXQAY5tihUrqZV1yAIjShESH6EJk8eXRPMfI1rIU13LHOtNcXZdREe/iS46VsuJ2nq+WMoTpCodztwALalCl3fVOVuUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920150; c=relaxed/simple;
	bh=9TtDN1r4VnqbVkMbIdvO5V9mK3wtnObkCogkcygbwo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSP13Hbgl36PQlfqk1LTqPDOJ0HHbO6lKbn/dxURimCT32P7G6B1EbNCDpK7ffoM6SVXidqEswqu9+Cnpq0XH3LmmT9MieU/41Sp+3qkL7M0GGzCX4r4CD4XDjO4PBvPYbqLKT51uhwzGdBXuU30RrG5LyszfF/hi9YRHAf8F/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkJShWdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F22C43330;
	Sat,  3 Feb 2024 00:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706920149;
	bh=9TtDN1r4VnqbVkMbIdvO5V9mK3wtnObkCogkcygbwo4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fkJShWdwEJvycdkTp0BR6okr208Rn+CRxEsYXN8dp8LGq20F5iMEMPf/LKG2rRSwU
	 i86MAVC9Lg8lRpv87YNIHKkgSFn/WtbEVpDSLSVunszCH04cXeKk8NmmcTPvxyIUC4
	 SBwOAug5vdJuF1W8jHSw3tCnThvEGK+4N/4r+FYRiYQkooe9ONd8axRsCk1cxmxgyS
	 hg6wJnx7rYERvEeAvVQNHQ4WWTw899IsHWvCJQyJv5sKNmh0efJ/DFNc/vQmoKOCl4
	 kT1uMjkJj1VHspspmatx/LYjW1DoPQn+CHWTbs2PAMgZAPRiAqPBETVlrZlNIerMmQ
	 nM9+l0OcDUf+A==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a352d9c0f9dso77298466b.0;
        Fri, 02 Feb 2024 16:29:09 -0800 (PST)
X-Gm-Message-State: AOJu0YwxFK22Xe5RRetNoLp+RyBph1rVUBUHOIJaSAAwVSrN0vsy9b3b
	j8/MJcYvQnjPGrSI5qF2pdPo3s0FBZBRcKIYt5eDaIl9s/wK2XeKOHnKvOSktyta477aUxiYUaH
	h49QYFrdCnyuxSgwOkv6w7xYV85I=
X-Google-Smtp-Source: AGHT+IFZ3ZGMvuqs3thX1yxw7hTJ2qyHWlAIiaxSWDC0fd6vOK5H12/qSr7bNlL3hDdiX5obbzjZ0yxKiPDlE9ehK0A=
X-Received: by 2002:a17:906:3c02:b0:a36:95cd:5e62 with SMTP id
 h2-20020a1709063c0200b00a3695cd5e62mr4340840ejg.7.1706920147920; Fri, 02 Feb
 2024 16:29:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102124747.21644-1-hao.qin@mediatek.com>
In-Reply-To: <20240102124747.21644-1-hao.qin@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Fri, 2 Feb 2024 18:28:56 -0600
X-Gmail-Original-Message-ID: <CAGp9LzpuLr4vKGSfBoCdES9kKyduADw+2DZp8aZqbR78S_sOuQ@mail.gmail.com>
Message-ID: <CAGp9LzpuLr4vKGSfBoCdES9kKyduADw+2DZp8aZqbR78S_sOuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: btusb: mediatek: refactor
 btusb_mtk_reset function
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
> Extract function btusb_mtk_subsys_reset from btusb_mtk_reset
> for future handling of resetting bluetooth controller without
> USB reset.
>
> Signed-off-by: hao.qin <hao.qin@mediatek.com>
>

The patch doesn't modify any logic; it simply divides the existing
logic into two parts,
each prepared to be called in a specific context. Thus,  Acked-by:
Sean Wang <sean.wang@kernel.org>

> ---
> V1 -> V2: refactor btusb_mtk_reset function
>
> Link:
>   https://lore.kernel.org/all/20231215063714.7684-1-hao.qin@mediatek.com/
> ---
>  drivers/bluetooth/btusb.c | 45 +++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 0926e4451802..abefcd1a089d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2994,28 +2994,13 @@ static u32 btusb_mtk_reset_done(struct hci_dev *h=
dev)
>         return val & MTK_BT_RST_DONE;
>  }
>
> -static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
> +static int btusb_mtk_subsys_reset(struct hci_dev *hdev, u32 dev_id)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
> -       struct btmediatek_data *mediatek;
>         u32 val;
>         int err;
>
> -       /* It's MediaTek specific bluetooth reset mechanism via USB */
> -       if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
> -               bt_dev_err(hdev, "last reset failed? Not resetting again"=
);
> -               return -EBUSY;
> -       }
> -
> -       err =3D usb_autopm_get_interface(data->intf);
> -       if (err < 0)
> -               return err;
> -
> -       btusb_stop_traffic(data);
> -       usb_kill_anchored_urbs(&data->tx_anchor);
> -       mediatek =3D hci_get_priv(hdev);
> -
> -       if (mediatek->dev_id =3D=3D 0x7925) {
> +       if (dev_id =3D=3D 0x7925) {
>                 btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &va=
l);
>                 val |=3D (1 << 5);
>                 btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, va=
l);
> @@ -3059,8 +3044,32 @@ static int btusb_mtk_reset(struct hci_dev *hdev, v=
oid *rst_data)
>         if (!val)
>                 bt_dev_err(hdev, "Can't get device id, subsys reset fail.=
");
>
> -       usb_queue_reset_device(data->intf);
> +       return err;
> +}
>
> +static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
> +{
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       struct btmediatek_data *mediatek;
> +       int err;
> +
> +       /* It's MediaTek specific bluetooth reset mechanism via USB */
> +       if (test_and_set_bit(BTUSB_HW_RESET_ACTIVE, &data->flags)) {
> +               bt_dev_err(hdev, "last reset failed? Not resetting again"=
);
> +               return -EBUSY;
> +       }
> +
> +       err =3D usb_autopm_get_interface(data->intf);
> +       if (err < 0)
> +               return err;
> +
> +       btusb_stop_traffic(data);
> +       usb_kill_anchored_urbs(&data->tx_anchor);
> +       mediatek =3D hci_get_priv(hdev);
> +
> +       err =3D btusb_mtk_subsys_reset(hdev, mediatek->dev_id);
> +
> +       usb_queue_reset_device(data->intf);
>         clear_bit(BTUSB_HW_RESET_ACTIVE, &data->flags);
>
>         return err;
> --
> 2.18.0
>
>

