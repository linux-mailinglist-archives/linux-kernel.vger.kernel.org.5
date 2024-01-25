Return-Path: <linux-kernel+bounces-37828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D487783B625
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541561F22C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFD4EA9;
	Thu, 25 Jan 2024 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2k14+mo"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894FB7F8;
	Thu, 25 Jan 2024 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706143212; cv=none; b=eDIo+ESc/d6DO72vZ9gwU+lFGCyrUeW2uvcQtaHWLK2gXDmFYlZiZorJWQVz707QoB4DNnU/k9AFtWIF7ubWr30CChrOs4QLhuiD1dfpkK5Nq0BY9fmnirtIWpwilraPj5XFF1Mn95gS98ELWthXDVuAzn8WtKhYP/OvkT3muNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706143212; c=relaxed/simple;
	bh=eb2GrpgXshNovWGjPivGLwffyuCL9x1cuni9Whxv+Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaJlKzUryGVRRIqnKnVz+odJ4pUFkTT7GOxGRJ3Hs4o2n+xtv2dFwr+s6E4M33UWGHNua6ga4dZtfP4ph9WiR/k1DIDT8ZQMZ3C1n0RtnaYQPkjUvqBvogn0o1PGUCErO0udg8s8Rh2wj6+luiPZ3VDtutOFL6lgkNhvyCxMCu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2k14+mo; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a313b51cf1fso39533766b.0;
        Wed, 24 Jan 2024 16:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706143209; x=1706748009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpHYzcGHhb7fxFeEZ0u8pA/XWhZmXclMeGSYqqibVUM=;
        b=K2k14+moo83Hcu6iULpYzNm7UWRW/i8h8yi3LwyMwtGCg8RUteFarKrI8RoiJdf7qV
         R8P3Z7AWbY3ZFjX4sIpQ1rK+ogfctoGVPLx+s+1DrSqpqxqaBm45ON7fiE3kMw+Ri5wq
         RX3ze45CerS9Lv48iJ8m4yiQx8xBc5LOuwGzqcH81c5Rs/MYDTxaqNp4cmdsom/FbnP7
         DJHDS45/q/GUI4SqmHR+szTFcPEwTi7MpsIXwLNlvlXHEszGP9aDI1ob2vxmuPiXnrQm
         nx6FWjlJL6VB4onj1Qcr/Awo0mec3QHEBoqnfZ5HGw3CBIYA0uUR3IDv0tR404rdngpZ
         OHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706143209; x=1706748009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpHYzcGHhb7fxFeEZ0u8pA/XWhZmXclMeGSYqqibVUM=;
        b=Qc5y0KaFXAj6apFnBo+LH1H+uo+kgjzqlUXyseFym6uiY6BRQvf6ip/vPrs1pw0ZKk
         GSNGc4lrpV7IT5I2Gm7rB71Xd4eSowimpjcxFaIMsUC4MedwBtVGPj0AA3d7SV0xwf49
         6zYzZ36uWymb+z9Vq1BpDtig51jHpc74TgvqNkKj5bMvESAEEHFq1Ktt990H0uoBlM7Z
         RUy1s5ucHaw2tjkI6W0zrqykLrHtH+I3LPPBIalY7xbudamJk4AgwxWF8iNeN1aCuOlM
         +RA5lREyvIvtU0fKjHJN0KFbxqCG1Yco6/nb01xSOpeAt+ShS4vyYyecgKI21cZ4S86e
         pdLw==
X-Gm-Message-State: AOJu0Yz6iatOMjJr7JOZvJv7smr9YjypMdI9cSNRzub2AASYsnKrNqMo
	M5o7EEnwoEKeKlqTKG8mhlQxg8GamiwcJsnBTX+haZgGNYPBIG+H3kSTz0NmUuvE6rTUZ3tL5y3
	LLXH7IF7VDKvGE6kAtP54+HqgFMuJHCPZ
X-Google-Smtp-Source: AGHT+IEQn9+jyke/CAhfHPoFTBBCBLXtpuWbScqfz3WCJC3eNYGXj+WO1wpXjLyFggb3pwUmxuc1FwrW4GNimzemi+w=
X-Received: by 2002:a17:906:b0e:b0:a28:e980:8984 with SMTP id
 u14-20020a1709060b0e00b00a28e9808984mr150591ejg.18.1706143208439; Wed, 24 Jan
 2024 16:40:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115144538.12018-1-max@enpas.org> <20240115144538.12018-3-max@enpas.org>
In-Reply-To: <20240115144538.12018-3-max@enpas.org>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Wed, 24 Jan 2024 16:39:56 -0800
Message-ID: <CAEc3jaD9qXp=F6Xfg8bdeC1Hv5pHiKA16SBd=-ac74ibE1ELyw@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] HID: playstation: DS4: Don't fail on MAC address request
To: Max Staudt <max@enpas.org>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 6:58=E2=80=AFAM Max Staudt <max@enpas.org> wrote:
>
> Some third-party controllers can't report their MAC address.
>
> Since a unique ID is needed for ps_devices_list_add() and
> ps_device_register_battery(), let's use hdev->id for this when we don't
> have a MAC address.
>
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
>  drivers/hid/hid-playstation.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.=
c
> index 7f50e13601f0..0a3c442af305 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
> @@ -1966,7 +1966,10 @@ static int dualshock4_get_mac_address(struct duals=
hock4 *ds4)
>                                 DS4_FEATURE_REPORT_PAIRING_INFO_SIZE, fal=
se);
>                 if (ret) {
>                         hid_err(hdev, "Failed to retrieve DualShock4 pair=
ing info: %d\n", ret);
> -                       goto err_free;
> +                       hid_err(hdev, "Generating fake MAC address for th=
is device.\n");
> +                       buf[1] =3D (hdev->id >>  0) & 0xff;
> +                       buf[2] =3D (hdev->id >>  8) & 0xff;
> +                       buf[3] =3D (hdev->id >> 16) & 0xff;
>                 }
>
>                 memcpy(ds4->base.mac_address, &buf[1], sizeof(ds4->base.m=
ac_address));
> @@ -1986,7 +1989,6 @@ static int dualshock4_get_mac_address(struct dualsh=
ock4 *ds4)
>                 return 0;
>         }
>
> -err_free:
>         kfree(buf);
>         return ret;
>  }
> @@ -2552,7 +2554,7 @@ static struct ps_device *dualshock4_create(struct h=
id_device *hdev)
>         ret =3D dualshock4_get_mac_address(ds4);
>         if (ret) {
>                 hid_err(hdev, "Failed to get MAC address from DualShock4\=
n");
> -               return ERR_PTR(ret);
> +               hid_err(hdev, "Can't detect simultaneous USB/BT connectio=
ns from this device.\n");
>         }
>         snprintf(hdev->uniq, sizeof(hdev->uniq), "%pMR", ds4->base.mac_ad=
dress);
>
> --
> 2.39.2
>
>

Hi Max,

For what type of devices is this not working? This one example of this
request which is very foundational for a controller working on even
the game console. Are this perhaps USB-only devices? If the case maybe
some kind of error is only needed for USB connections.

Thanks,
Roderick

