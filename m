Return-Path: <linux-kernel+bounces-157581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF168B132A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EF41F2828C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EEB1D545;
	Wed, 24 Apr 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZBhBEPm"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FCA208B0;
	Wed, 24 Apr 2024 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985515; cv=none; b=YdVfvj2vwPWMyBTQUeHS5hcaPi/oGjjHo4rQxCZJ2WOgr1Oh7vab6cELJkqw/URqTHqoQ9YzBf1z1/qRKWkuDpVM6pbrkYRRbTClmkNgEXLWQ2rBAFz+IEqyqbXl1cOFrk3DW/4cF2DCLrNfG7So4p/fy+k4w4dpl+4xSrISvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985515; c=relaxed/simple;
	bh=rXMYAkcTOmCIaTakogyziSvnbvX0R6wAK4SyomHQRmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvqcfzzQO5KbfchrLxkqWMbnYtU6aZBoAdCeBv2UU5BMkTJ+NCsZ3qLjvFJWZSi+x1gcYtnR+gsvbC7PPQ4VbdtcAU/7fSEVANsO2T4jYKA+Pbpl1iAtpIbk0Z8kAcvGS6lZL3q1J937byyRKqid9PjHaReeLWyqX9d3Z8xxRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZBhBEPm; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51967f75763so161266e87.2;
        Wed, 24 Apr 2024 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713985512; x=1714590312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fY699gCEhynPaWUFEKfZ9aS/PGgH5FiL9RmKn4mJCZw=;
        b=SZBhBEPm3FYD33nrX3NtRLm7WTc5FPt4EZq+0iAtDV3eC7dIVvej5pLtwxYJadx/JC
         h4pB/3t+xPhcCgac+sGiUMAn04M8AqU0drJJCJ8U1gKG5RgBosdNobT2BKH9yeXyQ3QS
         SoPbII7l9tWfQzXHAPsuqtTB6PpFKKEWS/aHRTmrNfFFT5XIdxd+H+sFhhxqIQjPZLN2
         y7ibjL26bORMASzD6ut2fXH5FkzIgw/JYAj5zDa0GmG56k7na5UCR/YsnL5g93dQZaTA
         XDj4sMHybgwYy6jk6SqneST5wNAYRm8hiq4bAwo9EwNRJC1ASFPl8kdS2fCnNOdDyt3V
         tdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713985512; x=1714590312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fY699gCEhynPaWUFEKfZ9aS/PGgH5FiL9RmKn4mJCZw=;
        b=QfawYBEQZDwO+C8ywVolMC8mSpVhQ+/OUkGL7H10RKTMBGvWnT+CsFjFww8LiIYEjB
         EaEVe1S2qjqfirnaTPyM0f1en+fsZC9yTpEOWUvo8Hxs959hmzEsOLxXKvNtFtNY5ZIS
         9wblKzv9GEr39eAXo0Psb0X4D89uC2sjM8qsmpKfYJvCYtOJ+aKzPfmgRHqTMEsydyZR
         KWjbAmK/r9CyEIzOZbFP36LHp7oRpKyhnysUj5PzwMWFstSRg5Befwu7EkjxuaNUDiQq
         OmYGfyuVis5Jid9jUNH5oCkeeaVuHZ31FWmpsfCPQhPUDx94xtpAfzCykIY7Tucu2hnl
         qCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg9W5lKvCNP5TkXLkMEL3d1Q2J6j/Y3Tk1C2Uo51cSU4DIsttSLE++z9sQ7YNfZu7CKX6F8MdcIZLOY8Mpyj17JiBncMCGUQ2jpbds
X-Gm-Message-State: AOJu0Yzvh5AncYnQb/hPqhwbDWQHoFm8z53Yz2tSPNGSKrdPB9R1VX2O
	+Z39urLhPpSAoPOhnwZqG/7VrniuctTXLdgxsWea7UKTHtA7HeuLwYkhsOiqKudgeNR3UWsTWgU
	dJnt6wHoSDk5e7q0ptGAkq1N/m8ZcxuI9
X-Google-Smtp-Source: AGHT+IH54uBm6xB4qd4mIQScBnYR04boUJPUc7CxoR5q704mKXqSD7x1Z5MAIoECKMz4vvzJaXQ7VEVG4R0X2p1MMus=
X-Received: by 2002:a2e:a305:0:b0:2d8:5b46:788c with SMTP id
 l5-20020a2ea305000000b002d85b46788cmr2005902lje.17.1713985511503; Wed, 24 Apr
 2024 12:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422152500.1.I8939e49084a6fef78496eb73edafdf3c2c4afbf4@changeid>
In-Reply-To: <20240422152500.1.I8939e49084a6fef78496eb73edafdf3c2c4afbf4@changeid>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 24 Apr 2024 15:04:58 -0400
Message-ID: <CABBYNZLCjrJUiVzNf53XYM-ZHWL6TZD4yFNtNGOuYi=6s5Q+OA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add debugfs to force toggling remote wakeup
To: Archie Pusaka <apusaka@google.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Archie,

On Mon, Apr 22, 2024 at 3:25=E2=80=AFAM Archie Pusaka <apusaka@google.com> =
wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> Sometimes we want the controller to not wake the host up, e.g. to
> save the battery. Add some debugfs knobs to force the wake by BT
> behavior.
>
> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
>
> ---
>
>  drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8bede0a335668..846b15fc3c04c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -873,6 +873,9 @@ struct btusb_data {
>         unsigned cmd_timeout_cnt;
>
>         struct qca_dump_info qca_dump;
> +
> +       bool force_enable_remote_wake;
> +       bool force_disable_remote_wake;
>  };
>
>  static void btusb_reset(struct hci_dev *hdev)
> @@ -4596,6 +4599,10 @@ static int btusb_probe(struct usb_interface *intf,
>
>         debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, data,
>                             &force_poll_sync_fops);
> +       debugfs_create_bool("force_enable_remote_wake", 0644, hdev->debug=
fs,
> +                           &data->force_enable_remote_wake);
> +       debugfs_create_bool("force_disable_remote_wake", 0644, hdev->debu=
gfs,
> +                           &data->force_disable_remote_wake);
>
>         return 0;
>
> @@ -4702,6 +4709,18 @@ static int btusb_suspend(struct usb_interface *int=
f, pm_message_t message)
>                 }
>         }
>
> +       if (!PMSG_IS_AUTO(message)) {
> +               if (data->force_enable_remote_wake) {
> +                       data->udev->do_remote_wakeup =3D 1;
> +                       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->fla=
gs))
> +                               data->udev->reset_resume =3D 0;
> +               } else if (data->force_disable_remote_wake) {
> +                       data->udev->do_remote_wakeup =3D 0;
> +                       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->fla=
gs))
> +                               data->udev->reset_resume =3D 1;
> +               }
> +       }
> +
>         return 0;
>  }
>
> --
> 2.44.0.769.g3c40516874-goog

There is a D-Bus interface available to overwrite the wakeup setting:

https://github.com/bluez/bluez/blob/master/doc/org.bluez.Device.rst#boolean=
-wakeallowed-readwrite

Or do you want a master switch for it? On the other hand aren't we
getting into the rfkill area if you really want to switch off radio
activity while suspended? That seems like a better idea then just
disable remote wakeup.

--=20
Luiz Augusto von Dentz

