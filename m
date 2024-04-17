Return-Path: <linux-kernel+bounces-149243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18CE8A8DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A782F1F21139
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF51E4CB36;
	Wed, 17 Apr 2024 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8S6ewoQ"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA68F4A;
	Wed, 17 Apr 2024 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388687; cv=none; b=LnuZegQlxbWfbhpIi2WJ3de4ejQsGt4SP2hVWSpvaeyXgS74RxKI459EVrxZh8omFckhgPfP2fHVC0NEznRD7ldEQR8LtixNGUa5tnsuMQ2tKzs3hLZMAFMSm07YpEFdKmT2JGrpKW5XI+yCnD5ESylPJ9nGPqKIe5dKEGVgzcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388687; c=relaxed/simple;
	bh=fV/GBBG8Y1zKgQp11Kn4djvNyTsBgHc++2ZKipKlH/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4rmhq+ywRXcyOY1YTCirhTKaOK0hb8++V4lK3Sm3h5sTxa8uZcsHIpGku0/FBdnHCXgj+nVArPBVXIlrex84YOYVG5VcDFRcRbokwnTzKZr8bNjKbSvQqCkEJl+K+N7xK5UtHZ0h68RQwIbm49SZ/uetkG4brbeZ6SmAuMh+Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8S6ewoQ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2da01cb187cso3485431fa.0;
        Wed, 17 Apr 2024 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713388684; x=1713993484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBkaCbNjydmVkpZXUhiI4uQ6IPkbRea+BjBhJXBTlwg=;
        b=j8S6ewoQGak6o5Rk1OGQgZ6JGPd00pUJSgF4CvNwiuJwPJ7NsVzKV3OrqiXbq0E2t7
         mIe33LIy4zA50Eyan2NvMyeKRg/MvGBQ+ZjSUn7zWP4dR5TFvWOtDNcT4YGjHxciGQOW
         SKCqVC8w4rhyq73wBUmhuaz5MHVURZj5mn4DXkwJFM80bNWEs/7X2x41GepVPitj4QzY
         cvMRFWZcPUvZzfx+k96ux944E3CiGNcnXTD3kyrtpJVqa3ANmYlKrIILTEamIWDQGiOm
         Oy5LQitTI7cDZNRzAYkfFpS1RHoeYvovyM1ocnjxrEIuYpWFK1cHY//SRDmEg9kyxjFC
         pXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713388684; x=1713993484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBkaCbNjydmVkpZXUhiI4uQ6IPkbRea+BjBhJXBTlwg=;
        b=ZH6/qC9HzzTffDrcPnL6pKadCoD9K9nGE6dpXrPQhVnUZ7R1dVeLwhvdbVg5CHAJ29
         sAk9JFEExrUgMvaogwaKfGjaB6dbyG6ANnwnNU5RfY9zuf/DDZ3EAQmkixZ5pTzvQyAQ
         4HDJUP1/lvDIDSupRk+1AYWdrQALlG21Kimo72I/7jMVBG1RPwd6iQjZI67dbqZUYMc0
         IE5/mJDXBYrVsaM1W7tHt7qKv8InczaopsWJzJFzWukG85nTyloj53wDp+rVmk+LS+S6
         tIjMAK+ahW1h3LXMOu9Zl4b9F0LEqU/YkCof55zINE4PsTV7MQeFfdo3oDz4mjIg1w4f
         Cy8g==
X-Forwarded-Encrypted: i=1; AJvYcCXRohGprz6CWHLkyAoXCBcX2a2QbbSrlL+7d4Se6lxvpCaf5+Vu/iC4YOiz9BoDRHjAkUZ6AAztHXPhvXlDnthHODilPGCH06d6U3ZlaKhhPnpAqKblTB7WRZQb90mSRaM8X7JY5GIN2UWrndmm
X-Gm-Message-State: AOJu0Yza1WeLB8fN2pKfO9D2ZYjqwMTGNK89GfIoB+yyFFKcgMXMSH60
	JWsTfCV5/oWKOpu3Vyu9aJK4b2mxSyz0AHRn0oFExImqnqQgWUjMehk4q/DVbiiPfJzbzQrOA/C
	alOJ8z4jxz7Dmq9tdC61m41nZtEw=
X-Google-Smtp-Source: AGHT+IFtlAXpGYCpv+bg5gy1IxslsA0lmrPId3jvSe88OrBfqoz0X5D3GoSobh3u3Kz2TE2SrAf/xB9p3nkmG0nVIiw=
X-Received: by 2002:a2e:92d7:0:b0:2d8:6a04:3bcd with SMTP id
 k23-20020a2e92d7000000b002d86a043bcdmr312813ljh.3.1713388683280; Wed, 17 Apr
 2024 14:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412095713.25641-1-hao.qin@mediatek.com>
In-Reply-To: <20240412095713.25641-1-hao.qin@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 17 Apr 2024 17:17:50 -0400
Message-ID: <CABBYNZJ-rvMuqHjFmQuxhmWv_K5fGFktAk-CeZfx8rw36L-Etg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: mediatek: Support auto revert for MT7922
To: Hao Qin <hao.qin@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>, 
	Aaron Hou <aaron.hou@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, 
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 12, 2024 at 5:57=E2=80=AFAM Hao Qin <hao.qin@mediatek.com> wrot=
e:
>
> Add support for auto reverting MT7922 during reset process.

Need some more information of what auto reverting means in this
context and what problem does it solves?

>
> Signed-off-by: Hao Qin <hao.qin@mediatek.com>
> ---
>  drivers/bluetooth/btusb.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 4c0cc13adb47..0ad96ec8d31d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3032,7 +3032,16 @@ static int btusb_mtk_reset(struct hci_dev *hdev, v=
oid *rst_data)
>         usb_kill_anchored_urbs(&data->tx_anchor);
>         mediatek =3D hci_get_priv(hdev);
>
> -       if (mediatek->dev_id =3D=3D 0x7925) {
> +       if (mediatek->dev_id =3D=3D 0x7922) {
> +               btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
> +               val |=3D 0x00002020;
> +               btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
> +               btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, 0x00010001)=
;
> +               btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
> +               val |=3D BIT(0);
> +               btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, val);
> +               msleep(100);
> +       } else if (mediatek->dev_id =3D=3D 0x7925) {
>                 btusb_mtk_uhw_reg_read(data, MTK_BT_RESET_REG_CONNV3, &va=
l);
>                 val |=3D (1 << 5);
>                 btusb_mtk_uhw_reg_write(data, MTK_BT_RESET_REG_CONNV3, va=
l);
> @@ -3072,6 +3081,9 @@ static int btusb_mtk_reset(struct hci_dev *hdev, vo=
id *rst_data)
>         if (err < 0)
>                 bt_dev_err(hdev, "Reset timeout");
>
> +       if (mediatek->dev_id =3D=3D 0x7922)
> +               btusb_mtk_uhw_reg_write(data, MTK_UDMA_INT_STA_BT, 0x0000=
00FF);
> +
>         btusb_mtk_id_get(data, 0x70010200, &val);
>         if (!val)
>                 bt_dev_err(hdev, "Can't get device id, subsys reset fail.=
");
> --
> 2.18.0
>


--=20
Luiz Augusto von Dentz

