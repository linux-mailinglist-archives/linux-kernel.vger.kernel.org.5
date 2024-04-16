Return-Path: <linux-kernel+bounces-147070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFD18A6F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADA91F21B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0E512F5B1;
	Tue, 16 Apr 2024 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lInl8q1k"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ADB12DD95;
	Tue, 16 Apr 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713279239; cv=none; b=NvcRgTH91YzsA25Vi13/ohUNYcU33BaJwhzTzI4KyzQP11ox0EEFcFpbCrrDqcaemAZgyyUF92Y0OWrwYeBKARntpU8WGVZZqNn8Tg6zRmU+gGDEX5A7dhKyu9BfXJN8N1RJ697dpZ5pdylRiW0XfIVNa3eG0f3Atc24oVM7/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713279239; c=relaxed/simple;
	bh=uwSnk9DYUbzlkmh5IGkSksVbqaXL+rbSs5gAVZ1QsXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+w+Vbkt3anE1TIaySazK8nDo43NYybZ32Ebx0HfaeKdsyj8895IiooWDmG61fh+46LRgVg9aB1vF/scHs9zUg7RniWIN/HRpovS3NDJwxtsa/CIDa9fzuHeDZNsF4GJ66fIh0LXGi+jNKIkgyvLZ9nWINGdjrkocsEJHQssIYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lInl8q1k; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d8863d8a6eso57607321fa.3;
        Tue, 16 Apr 2024 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713279236; x=1713884036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cukYnh7YzrvpsQcy8CflblHBgUiu2QOawbA8hrGiwU=;
        b=lInl8q1kN5a6ftAUwSvoteRk8BpfuSitkyBzQuSlrdVMbYXeTm3CwLmYbEwr/QJtm3
         MKxgVuc1ozYn/EPJ73jOGw40wJ94N0rNHNAONtPHmzvgC9T3oj8i+NggtMOPmYX1Qb5H
         HDZ+dtz6uEXn3cgBp4SvJvnD7CjPfJwvWA/jvtDLGpHKcbwMGU7t6b77AzRE6pIHYK21
         Ltw3wKCrhY39Fb+kewbfvHMtX2OZbc16ihmGuLKYISctq4dd5oZcT0a/O6OYH+T8JrVr
         q2aLpV+2NsrhO/gkD0uLGK2WoiutkxY/xDX8sly5OKfDWlfEuHnoAdgwMuFm+CaxFJzi
         0+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713279236; x=1713884036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cukYnh7YzrvpsQcy8CflblHBgUiu2QOawbA8hrGiwU=;
        b=Q+G2JUfyuDV171zQJU9Wh+O9p0RbsnB4NWCqGm89aVsV7jZfbmA1Qzo3L6rNqNIT3o
         izsYB9I87SdYe6Tc86oadW2LusQdjHcG9BwTj0weeMFexlYYAa3HfqKS6Jdf3W5vg6bH
         GU5Dr3CLBwmtOP91fy7QRm1PcY1SuuW56eSCZnucJAHHvXNguhMC07cBcVvcYMGrB6ip
         +MHNrRDg4MFJbpwXX+NKK4Cox9eJSWPS/+LAsx5gSVhwNzIgYxnKkf8q3rVvM8YpyRgT
         Paoi7DYoQrUnGMXHTHhsweLggTuuI7MshTgwj29MwPNkuG089gh6OF8qonTqF1K9xMgn
         VL4w==
X-Forwarded-Encrypted: i=1; AJvYcCUNfQdf+6sZQ9Cax9mjN7u1Tz6a8EoeAYQhAogfCGVSQEp4jS3+0fJwy2t/aPEiNn8CSMjkZXbnqb5fA6tOVxovu+xLYAnfnaFr6jrXBLkrtniR0DKBibbEKYaHbsODXEiuf/2zfgiMhHOPZmdo
X-Gm-Message-State: AOJu0YxNf04GHSuPsmPs4I7TMnWsmeN8Iz/0+I8XEF5YSvXJXyh8vN2v
	QqT1idj1+0TlTU0b0300UfVe4dARTx9ROrR9eAEkKTuIfYm+bwSsvnC0TPRfWo+VWEPIB6Zktf5
	8ZLb+0n6WT939KeaUoF2mwZNk5DVgNg==
X-Google-Smtp-Source: AGHT+IG5vvSLyFxVVk4DVxlcD5kc+Ye3Ncgbh0mG8jzgwD3uq3A+QxoqnzDmUrKBBFElmhmuw0XcQmFWvPGap+QBNzk=
X-Received: by 2002:a2e:3209:0:b0:2d9:fa96:1620 with SMTP id
 y9-20020a2e3209000000b002d9fa961620mr11726167ljy.29.1713279235879; Tue, 16
 Apr 2024 07:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412084128.24452-1-hao.qin@mediatek.com>
In-Reply-To: <20240412084128.24452-1-hao.qin@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 16 Apr 2024 10:53:43 -0400
Message-ID: <CABBYNZLGocaksAKCTso3zL-bAuSKaBurTtOFZx_rw=HiKMmqtA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: mediatek: Add usb reset for firmware
 setup failure
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

On Fri, Apr 12, 2024 at 4:43=E2=80=AFAM Hao Qin <hao.qin@mediatek.com> wrot=
e:
>
> Add usb reset to recover BT device from a firmware setup failure,
> it will restore the device to its original state and attempt setup
> firmware again.
>
> Signed-off-by: Hao Qin <hao.qin@mediatek.com>
> ---
>  drivers/bluetooth/btusb.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 4c0cc13adb47..c5aab361795e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3160,6 +3160,9 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>                                                 btusb_mtk_hci_wmt_sync);
>                 if (err < 0) {
>                         bt_dev_err(hdev, "Failed to set up firmware (%d)"=
, err);
> +                       btusb_stop_traffic(data);
> +                       usb_kill_anchored_urbs(&data->tx_anchor);
> +                       usb_queue_reset_device(data->intf);

What if this was already caused by a reset? Wouldn't that create a
loop resetting the device over and over again?

>                         return err;
>                 }
>
> --
> 2.18.0
>


--=20
Luiz Augusto von Dentz

