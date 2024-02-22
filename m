Return-Path: <linux-kernel+bounces-77257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799218602A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBE21F27C45
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137D3548FA;
	Thu, 22 Feb 2024 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="unkZ1JQE"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1FA14B82B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630035; cv=none; b=V6Mctby2ke25U/QBlQ1pA6n+UwiN/0/I4qT6DOYZUxaJphopODdKAxoLn1uzaGSud78v0DiSQPWZ8uJ/ROaMXRDQq0ERBVjYd5jvvH6Z7ebx9oWj9gY6RV9PXluLmIdVxAjFANtH8yYlk+LZ5kfLZB3lFQmuCWqHT0R8nQhM7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630035; c=relaxed/simple;
	bh=1LSpzVFxEkje/D2DXJOE0ThAUSQ8omcZg6hxBaUHBOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8MNv7PEEjtPTbDnO9+IAYAKTS77iJOLQ/98/GQJUA7dmVAVUv6TRxD63wHuXMK0ZGsMPBtinc5eMAhlhkM62NJ29en67rcyeHc+hVdCVjCDLClGdPi8ZAFCeCQJQq9le8v0Br/jL6n53gGJ9i0g9zIYc5F3PNNpYBlyi8nwxFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=unkZ1JQE; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d13e46ac0dso19708e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708630031; x=1709234831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnZQ2Np0LMvJsVvmVZVBPdaruP0xPu3oyHszd2uFf4s=;
        b=unkZ1JQE2si7bOryfcGEUbIz+gsvQVn3MmGS0KuVOXvA1UgWOUoXJ+hVCKeJNQ0Peo
         //N4knhW4Hy3eMUqbbxvEajhewAKKIk00utZxv3JX4SeFm3c5tWzXDwrbkx8JqUXw0qm
         OOsGEN5HgxTT8jjew4pFKXLClEOp4knc0fCG/oBOOHPSE655RPoaRSYqI376qJvGYCpd
         8w03DhoYHMqNkHIDOSy5Yol+lkHxzUGj9pQ5YSonjeWuFtT++Kql/rlQedkVsUOtJ5Rk
         MKZMB6sXcyrVTaosoMC/DkFiuD1vmvi4/9BQ0iOabUnzhJLWgexeLf6uAYSdIknyMGJO
         QmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708630031; x=1709234831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnZQ2Np0LMvJsVvmVZVBPdaruP0xPu3oyHszd2uFf4s=;
        b=vyY2nQtoWWYWcFvAtGD1vfWXfn2XX4cDUcR+oOCon9JbejAtGGI31EyC7TvKzRTifp
         vRm6IYKtqEnyYmH943gnpyERHx/SA2WfyGFtns1Cz10w/EhdjzYLKVcZOTyeUPG7piTz
         YfLnj1cfOud/sFnLOUhPv36laadTuftzuJwBfU1DDOpcpsR1G4bZsrfNtot3cRMYTJkp
         8Yj6ZDqhQ7Cmy0bLYizFeSqFZoK+cI+2KyhrYwEAR4U8CJuzZdLENQ95npPMPvIRqAjd
         VYmu8tzSr72lYg+CoCEm4Mwgq4C947Zhdn8HPcs9i+huHz4srPDfIZFfxjyPbDI+qIz3
         /C8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJHw4sS6l6wtrmh7shqgdjgkfwkByFS++eNX4DkgZ17dnpWn4PmPtgSp79xZoEu8YiIkEMmmNkJjDgRcxcfPbJ64Cjlak++U5ySOwC
X-Gm-Message-State: AOJu0YxgErCO1YSX9+IFGJQM6qpd8QOxQaQZgctpn6lOKo2yLxLCxGJt
	ZIWtWxDEkiBqa/YcDTWxKp/O3j/rlj3gFHorkXyz9+PtIbfnDvpnRl05gzb/yV3YlTOvA5A7TMV
	XSi73VVbDnyBQ89tkyi+tgXIT6AhPPnIw82QGtZ65//kwZq3o
X-Google-Smtp-Source: AGHT+IGCfLmnerJ2kbWWTwiyuUUE+iAaJee9A08f/LkoUSya+GJWWO4i5dtXri24iTfUKAaN2TuLG1Lg1Pk/5ZGe6uY=
X-Received: by 2002:a1f:e681:0:b0:4cb:2662:3656 with SMTP id
 d123-20020a1fe681000000b004cb26623656mr10217vkh.0.1708630031526; Thu, 22 Feb
 2024 11:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208164017.26699-1-brgl@bgdev.pl>
In-Reply-To: <20240208164017.26699-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 20:27:00 +0100
Message-ID: <CAMRc=Mcme2PZ7K4K2ZXdgDvzauFvzaRrQQ+-=ua7CykxrwjHCQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Miaoqian Lin <linmq006@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 5:40=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The optional variants for the gpiod_get() family of functions return NULL
> if the GPIO in question is not associated with this device. They return
> ERR_PTR() on any other error. NULL descriptors are graciously handled by
> GPIOLIB and can be safely passed to any of the GPIO consumer interfaces
> as they will return 0 and act as if the function succeeded. If one is
> using the optional variant, then there's no point in checking for NULL.
>
> Fixes: 6845667146a2 ("Bluetooth: hci_qca: Fix NULL vs IS_ERR_OR_NULL chec=
k in qca_serdev_probe")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/bluetooth/hci_qca.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index edd2a81b4d5e..8a60ad7acd70 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2326,7 +2326,7 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
>
>                 qcadev->bt_en =3D devm_gpiod_get_optional(&serdev->dev, "=
enable",
>                                                GPIOD_OUT_LOW);
> -               if (IS_ERR_OR_NULL(qcadev->bt_en) &&
> +               if (IS_ERR(qcadev->bt_en) &&
>                     (data->soc_type =3D=3D QCA_WCN6750 ||
>                      data->soc_type =3D=3D QCA_WCN6855)) {
>                         dev_err(&serdev->dev, "failed to acquire BT_EN gp=
io\n");
> @@ -2335,7 +2335,7 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
>
>                 qcadev->sw_ctrl =3D devm_gpiod_get_optional(&serdev->dev,=
 "swctrl",
>                                                GPIOD_IN);
> -               if (IS_ERR_OR_NULL(qcadev->sw_ctrl) &&
> +               if (IS_ERR(qcadev->sw_ctrl) &&
>                     (data->soc_type =3D=3D QCA_WCN6750 ||
>                      data->soc_type =3D=3D QCA_WCN6855 ||
>                      data->soc_type =3D=3D QCA_WCN7850))
> @@ -2357,7 +2357,7 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
>         default:
>                 qcadev->bt_en =3D devm_gpiod_get_optional(&serdev->dev, "=
enable",
>                                                GPIOD_OUT_LOW);
> -               if (IS_ERR_OR_NULL(qcadev->bt_en)) {
> +               if (IS_ERR(qcadev->bt_en)) {
>                         dev_warn(&serdev->dev, "failed to acquire enable =
gpio\n");
>                         power_ctrl_enabled =3D false;
>                 }
> --
> 2.40.1
>

Gentle ping.

Bartosz

