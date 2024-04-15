Return-Path: <linux-kernel+bounces-145846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8F68A5BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA468285899
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170BC1635D4;
	Mon, 15 Apr 2024 19:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izOZuVGC"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDFE1635C7;
	Mon, 15 Apr 2024 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210466; cv=none; b=FA6AKZYJkMLCSW8Wye40aMXWi3TQIwBs0X25M70gvgkM2xIsDJyB/8zioDTW7jt0bkYa+9a8BvFKJAWi1IUHa8GkTQ+oeiu/IWE/ubU8+yrzc8jHEOZBJ13Q6jNYOEVi54Mu+A52ZFl7dkkzYu4usRxN+Kux9KhPQYjFCa/RBEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210466; c=relaxed/simple;
	bh=HZUVP3Vy5ksk+PuXH/fxVRpubxd4AMAntQCujaM/ioI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJyj9aGbdljCg3/2oh0CjMmy4NBWIJz6imDd1nA0zbnakllHsgdVqGUqiNz/lfiWTj0Y6xQWAjzvMCb439f9Bq0mzFiA9/c6mk9VTT98736N1BcDNV6VyBt7472HVOlZy7EbeIJJsdTgZv3mM7zk2WRNXy707Xl3/Qi97pukR1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izOZuVGC; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so42416661fa.0;
        Mon, 15 Apr 2024 12:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713210462; x=1713815262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYvq10jH2xncVeyiDoCWfCHioMkzLdiiH2RWE0esuC0=;
        b=izOZuVGCqTIRH7ZsXmK9TK5ckMRjqgIVlkfkjtevOsuKlXgLgQzKPJT3PFrANAFgHa
         QnoUfeic5+YLqFLEnrKyQTro/lSS5GBlohZe0GLoxfN2G4zpHSjlEI+enJetqzFVlKR+
         IdhNKWymjUK5BB9i9UOm1qAIY14TugBGg+EE8IQZTnt82p4xSSndTs6z3XnNxD3Kyr7I
         PPGUPn8hStsP9PdmYUhFIwEwn+80ZTGePJL7XyJlrqogqi9jur9kDr2+rZ9iQvNuhbZU
         St+XmyOEXLoHmgdU8kbk+XYyYytm9kkCv33SxZ/zlbYq87bRXnnLc8qWgRW9Re0ahhwd
         OyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713210462; x=1713815262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYvq10jH2xncVeyiDoCWfCHioMkzLdiiH2RWE0esuC0=;
        b=BvbQb4GvUC4t3jauWWt3vd6dikzDrxplPF8BByciPqs7UY58nGMKGVqjrbZswHjulV
         i5uni7EL3CAB7Imm1cfxrsqEV9RxzRWFjss3gzzualBSPYZMqtEw2pCIU+/HnMH5zfMJ
         bBmr2vccbL+051RnZyfKY2FUIDEtokEAKlSNKv+odKciIoE1uygSh9D2+5nlHzp9UpOj
         7/R7apNZ0ZeRYKSZOAaQ9+1E8cBwUrhT2VJoTpcteel7IQW8eTWqG8zxBUD2bxTcTUUe
         lfsUN7ay4cvdlR7CYXNpUSEXrkfmxySSJXRQnrZehUcVDetcKK6yXfgy24/xvWzOcQ97
         kOdw==
X-Forwarded-Encrypted: i=1; AJvYcCWmd697q5dChsAOrTbCPPHke9lp7zJlbNVYr6Z6SxSfoPj1+/JunLi3Ptjp9HnsRgDCj7VQDUZpi6VMfr9Zmu5QSY5Lk2+JcqWnaiRBFWb+6SHbAnjaobE4Es1HvD7f4f4BI7oJ3hRT8e4=
X-Gm-Message-State: AOJu0YyeqoyT1kjJoGn4xh3hSvgOSg8VWbtmNS/MpXzFY9IsSYn0dDGH
	mUWvUB2gYehv8613/Ajp6jyLyQuO/ZLayIKJojn5qzCWMdbHIh/E6C7+ASAn6Y13lMW6Wnwwlaa
	54plMGlZXwyplrIsZo6Y6aaIrZN8aaM5W
X-Google-Smtp-Source: AGHT+IEHWSH5dBDDblM5ZgBOcr7eTkb2Kek6TnvPd4akG6Lf9j7INAmo9WPj8gH/BB9m7kb+TNeI8etQc09L9xE4A9U=
X-Received: by 2002:a2e:96d9:0:b0:2da:bbb5:2839 with SMTP id
 d25-20020a2e96d9000000b002dabbb52839mr466429ljj.11.1713210461892; Mon, 15 Apr
 2024 12:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414161223.117654-1-max@enpas.org>
In-Reply-To: <20240414161223.117654-1-max@enpas.org>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Mon, 15 Apr 2024 12:47:29 -0700
Message-ID: <CAEc3jaBbOfouWJtJWjGvYkqLtd9WnV=8JC94nJuhtPvpp-39AQ@mail.gmail.com>
Subject: Re: [PATCH v1] HID: playstation: DS4: Fix calibration workaround for
 clone devices
To: Max Staudt <max@enpas.org>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Max,

Thanks for your patch. For readability, I would rather not move a lot
of the ABS_X/ABS_RX related initialization code around. It is not my
preference, but I think keeping the lines were they are, but doing
this within the 'fail safe loops' is nicer:

ds4->gyro_calib_data[i].abs_code =3D ABS_RX + i;

Thanks,
Roderick

On Sun, Apr 14, 2024 at 9:12=E2=80=AFAM Max Staudt <max@enpas.org> wrote:
>
> The logic in dualshock4_get_calibration_data() used uninitialised data
> in case of a failed kzalloc() for the transfer buffer.
>
> The solution is to group all business logic and all sanity checks
> together, and jump only to the latter in case of an error.
> While we're at it, factor out the axes' labelling, since it must happen
> either way for input_report_abs() to succeed later on.
>
> Thanks to Dan Carpenter for the Smatch static checker warning.
>
> Fixes: a48a7cd85f55 ("HID: playstation: DS4: Don't fail on calibration da=
ta request")
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
>  drivers/hid/hid-playstation.c | 63 ++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.=
c
> index edc46fc02e9a..998e79be45ac 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
> @@ -1787,7 +1787,7 @@ static int dualshock4_get_calibration_data(struct d=
ualshock4 *ds4)
>                 buf =3D kzalloc(DS4_FEATURE_REPORT_CALIBRATION_SIZE, GFP_=
KERNEL);
>                 if (!buf) {
>                         ret =3D -ENOMEM;
> -                       goto no_buffer_tail_check;
> +                       goto transfer_failed;
>                 }
>
>                 /* We should normally receive the feature report data we =
asked
> @@ -1807,6 +1807,7 @@ static int dualshock4_get_calibration_data(struct d=
ualshock4 *ds4)
>
>                                 hid_warn(hdev, "Failed to retrieve DualSh=
ock4 calibration info: %d\n", ret);
>                                 ret =3D -EILSEQ;
> +                               goto transfer_failed;
>                         } else {
>                                 break;
>                         }
> @@ -1815,17 +1816,19 @@ static int dualshock4_get_calibration_data(struct=
 dualshock4 *ds4)
>                 buf =3D kzalloc(DS4_FEATURE_REPORT_CALIBRATION_BT_SIZE, G=
FP_KERNEL);
>                 if (!buf) {
>                         ret =3D -ENOMEM;
> -                       goto no_buffer_tail_check;
> +                       goto transfer_failed;
>                 }
>
>                 ret =3D ps_get_report(hdev, DS4_FEATURE_REPORT_CALIBRATIO=
N_BT, buf,
>                                 DS4_FEATURE_REPORT_CALIBRATION_BT_SIZE, t=
rue);
>
> -               if (ret)
> +               if (ret) {
>                         hid_warn(hdev, "Failed to retrieve DualShock4 cal=
ibration info: %d\n", ret);
> +                       goto transfer_failed;
> +               }
>         }
>
> -       /* Parse buffer. If the transfer failed, this safely copies zeroe=
s. */
> +       /* Transfer succeeded - parse the calibration data received. */
>         gyro_pitch_bias  =3D get_unaligned_le16(&buf[1]);
>         gyro_yaw_bias    =3D get_unaligned_le16(&buf[3]);
>         gyro_roll_bias   =3D get_unaligned_le16(&buf[5]);
> @@ -1854,71 +1857,71 @@ static int dualshock4_get_calibration_data(struct=
 dualshock4 *ds4)
>         acc_z_plus       =3D get_unaligned_le16(&buf[31]);
>         acc_z_minus      =3D get_unaligned_le16(&buf[33]);
>
> +       /* Done parsing the buffer, so let's free it. */
> +       kfree(buf);
> +
>         /*
>          * Set gyroscope calibration and normalization parameters.
>          * Data values will be normalized to 1/DS4_GYRO_RES_PER_DEG_S deg=
ree/s.
>          */
>         speed_2x =3D (gyro_speed_plus + gyro_speed_minus);
> -       ds4->gyro_calib_data[0].abs_code =3D ABS_RX;
>         ds4->gyro_calib_data[0].bias =3D 0;
>         ds4->gyro_calib_data[0].sens_numer =3D speed_2x*DS4_GYRO_RES_PER_=
DEG_S;
>         ds4->gyro_calib_data[0].sens_denom =3D abs(gyro_pitch_plus - gyro=
_pitch_bias) +
>                         abs(gyro_pitch_minus - gyro_pitch_bias);
>
> -       ds4->gyro_calib_data[1].abs_code =3D ABS_RY;
>         ds4->gyro_calib_data[1].bias =3D 0;
>         ds4->gyro_calib_data[1].sens_numer =3D speed_2x*DS4_GYRO_RES_PER_=
DEG_S;
>         ds4->gyro_calib_data[1].sens_denom =3D abs(gyro_yaw_plus - gyro_y=
aw_bias) +
>                         abs(gyro_yaw_minus - gyro_yaw_bias);
>
> -       ds4->gyro_calib_data[2].abs_code =3D ABS_RZ;
>         ds4->gyro_calib_data[2].bias =3D 0;
>         ds4->gyro_calib_data[2].sens_numer =3D speed_2x*DS4_GYRO_RES_PER_=
DEG_S;
>         ds4->gyro_calib_data[2].sens_denom =3D abs(gyro_roll_plus - gyro_=
roll_bias) +
>                         abs(gyro_roll_minus - gyro_roll_bias);
>
> -       /* Done parsing the buffer, so let's free it. */
> -       kfree(buf);
> -
> -no_buffer_tail_check:
> -
> -       /*
> -        * Sanity check gyro calibration data. This is needed to prevent =
crashes
> -        * during report handling of virtual, clone or broken devices not=
 implementing
> -        * calibration data properly.
> -        */
> -       for (i =3D 0; i < ARRAY_SIZE(ds4->gyro_calib_data); i++) {
> -               if (ds4->gyro_calib_data[i].sens_denom =3D=3D 0) {
> -                       hid_warn(hdev, "Invalid gyro calibration data for=
 axis (%d), disabling calibration.",
> -                                       ds4->gyro_calib_data[i].abs_code)=
;
> -                       ds4->gyro_calib_data[i].bias =3D 0;
> -                       ds4->gyro_calib_data[i].sens_numer =3D DS4_GYRO_R=
ANGE;
> -                       ds4->gyro_calib_data[i].sens_denom =3D S16_MAX;
> -               }
> -       }
> -
>         /*
>          * Set accelerometer calibration and normalization parameters.
>          * Data values will be normalized to 1/DS4_ACC_RES_PER_G g.
>          */
>         range_2g =3D acc_x_plus - acc_x_minus;
> -       ds4->accel_calib_data[0].abs_code =3D ABS_X;
>         ds4->accel_calib_data[0].bias =3D acc_x_plus - range_2g / 2;
>         ds4->accel_calib_data[0].sens_numer =3D 2*DS4_ACC_RES_PER_G;
>         ds4->accel_calib_data[0].sens_denom =3D range_2g;
>
>         range_2g =3D acc_y_plus - acc_y_minus;
> -       ds4->accel_calib_data[1].abs_code =3D ABS_Y;
>         ds4->accel_calib_data[1].bias =3D acc_y_plus - range_2g / 2;
>         ds4->accel_calib_data[1].sens_numer =3D 2*DS4_ACC_RES_PER_G;
>         ds4->accel_calib_data[1].sens_denom =3D range_2g;
>
>         range_2g =3D acc_z_plus - acc_z_minus;
> -       ds4->accel_calib_data[2].abs_code =3D ABS_Z;
>         ds4->accel_calib_data[2].bias =3D acc_z_plus - range_2g / 2;
>         ds4->accel_calib_data[2].sens_numer =3D 2*DS4_ACC_RES_PER_G;
>         ds4->accel_calib_data[2].sens_denom =3D range_2g;
>
> +transfer_failed:
> +       ds4->gyro_calib_data[0].abs_code =3D ABS_RX;
> +       ds4->gyro_calib_data[1].abs_code =3D ABS_RY;
> +       ds4->gyro_calib_data[2].abs_code =3D ABS_RZ;
> +       ds4->accel_calib_data[0].abs_code =3D ABS_X;
> +       ds4->accel_calib_data[1].abs_code =3D ABS_Y;
> +       ds4->accel_calib_data[2].abs_code =3D ABS_Z;
> +
> +       /*
> +        * Sanity check gyro calibration data. This is needed to prevent =
crashes
> +        * during report handling of virtual, clone or broken devices not=
 implementing
> +        * calibration data properly.
> +        */
> +       for (i =3D 0; i < ARRAY_SIZE(ds4->gyro_calib_data); i++) {
> +               if (ds4->gyro_calib_data[i].sens_denom =3D=3D 0) {
> +                       hid_warn(hdev, "Invalid gyro calibration data for=
 axis (%d), disabling calibration.",
> +                                       ds4->gyro_calib_data[i].abs_code)=
;
> +                       ds4->gyro_calib_data[i].bias =3D 0;
> +                       ds4->gyro_calib_data[i].sens_numer =3D DS4_GYRO_R=
ANGE;
> +                       ds4->gyro_calib_data[i].sens_denom =3D S16_MAX;
> +               }
> +       }
> +
>         /*
>          * Sanity check accelerometer calibration data. This is needed to=
 prevent crashes
>          * during report handling of virtual, clone or broken devices not=
 implementing calibration
> --
> 2.39.2
>
>

