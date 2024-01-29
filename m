Return-Path: <linux-kernel+bounces-42838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B5B840789
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355721F21507
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A08E657C2;
	Mon, 29 Jan 2024 13:54:57 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AB1657A7;
	Mon, 29 Jan 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536497; cv=none; b=QCK6cY7DSp1dMqg/HjpeQgO9lk2MNq2GmRiB/eCj8gqICvjZAPd9dGv/meQRn1UX50GnK7/ZHGUcgpdvf/fK3r4m+9rPZzrLGSfphPaIqP2G84Qa2n6JDA9E04JHNKUfxR2aqEllyilPZ640xWhqwf6KY6g4avlm/gwkwJZE3kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536497; c=relaxed/simple;
	bh=xqyH7fWtScx2nNLslYqwOBDLNXoNvQklWykA+ObA5N4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzjBgiGODczpIMsyUGnxuCSgqQwud2NkdhiqePNbqx0MsFCZDC/ID2tg8W6nt2ZLSlk3U4N0z8EtEXRotMrsfruk69saubHfS3LbSE6sio8CZsqN/jRbSiFzNw2hPNUMeLebQ03f24ChiLvFcNRm3QF7ucT5UY4KCnfI5RTS+mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59a47232667so13989eaf.0;
        Mon, 29 Jan 2024 05:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706536494; x=1707141294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYlBZ5W/rq3MF6m5qquOJIF/ojrZUdhYO+OW6wTYHOk=;
        b=fD5voDBR+P4ht59ly23fPuN+Bu+Q8Eo9fVZIoX81GzfQJiMoAsLNOEWjvFeHb5QW/A
         BXFcEEWxCw5OUVlWJ7++jYSrotgkIX3oWcZAbrPwYkyjpZeEAy4U3X60iZGCmpscfsGd
         RDCykIG6fsd/cPQK25de751AXxa3X7tZpCPuCubEzaBRB3ZC7sZGE+QwHN+1tPj9AzK9
         WYBZ/7+m1qrum5jNHNsD1u2q0ks8LMvqcgGhB5u/59YNB6BHgcNgTnUWlIiRidDw+jUF
         R2Pd7DfZd5nux7MaMmqHMmavyap3aSNeHbdXn2cR1f9r0geNCPpmMWB4E0FiH2IQxLpJ
         OlGQ==
X-Forwarded-Encrypted: i=0; AJvYcCVxjzDjJsx90tsTA+MV1SjqYCJbTMuOS79h6X6164zvSAaU/MmJtd+zShbb4IhLTznlLL+w+QHFFWpgaYRjbTMOjXY88lDt2rfxHgRT//Dz0R1TmbgylNODFvi7rMmij6hmINkBaO5Q/w==
X-Gm-Message-State: AOJu0YwuTgQGfjxAL6uStFnm53x3DbIx7oxglTLZOKFDZhhDeBxlaY0z
	Ytk+HiolZ5HOGBuMw0xtTQz91oTbbcoZMLmaCSi36EAPrTU31VgOeRx0f4zCqdEx67Twa9mhonZ
	AQTVyK4icueNv3AbhzpDHPbSPuIU=
X-Google-Smtp-Source: AGHT+IGYDlwxaaseY0LM9XvqXJBdwuD8nvxYIF014j7kc1xHNle26/I11S8aooxI2NqU4SudQWrClPjl81PcCR1+t0A=
X-Received: by 2002:a05:6870:230d:b0:214:fddf:99f7 with SMTP id
 w13-20020a056870230d00b00214fddf99f7mr7112645oao.5.1706536494486; Mon, 29 Jan
 2024 05:54:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126184639.8187-1-mario.limonciello@amd.com> <20240126184639.8187-2-mario.limonciello@amd.com>
In-Reply-To: <20240126184639.8187-2-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jan 2024 14:54:43 +0100
Message-ID: <CAJZ5v0iX5=u5y0JS2OzYMvYNnjZBCM2YfSTsSdg3CtH4rBMyUw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: video: Handle fetching EDID that is longer than
 256 bytes
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, "open list:ACPI" <linux-acpi@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 7:55=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The ACPI specification allows for an EDID to be up to 512 bytes but
> the _DDC EDID fetching code will only try up to 256 bytes.
>
> Modify the code to instead start at 512 bytes and work it's way
> down instead.
>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extension=
s/output-device-specific-methods.html#ddc-return-the-edid-for-this-device
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/acpi_video.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 62f4364e4460..b3b15dd4755d 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -624,6 +624,10 @@ acpi_video_device_EDID(struct acpi_video_device *dev=
ice,
>                 arg0.integer.value =3D 1;
>         else if (length =3D=3D 256)
>                 arg0.integer.value =3D 2;
> +       else if (length =3D=3D 384)
> +               arg0.integer.value =3D 3;
> +       else if (length =3D=3D 512)
> +               arg0.integer.value =3D 4;

It looks like switch () would be somewhat better.

Or maybe even

arg0.integer.value =3D length / 128;

The validation could be added too:

if (arg0.integer.value > 4 || arg0.integer.value * 128 !=3D length)
        return -EINVAL;

but it is pointless, because the caller is never passing an invalid
number to it AFAICS.

>         else
>                 return -EINVAL;
>
> @@ -1443,7 +1447,7 @@ int acpi_video_get_edid(struct acpi_device *device,=
 int type, int device_id,
>
>         for (i =3D 0; i < video->attached_count; i++) {
>                 video_device =3D video->attached_array[i].bind_info;
> -               length =3D 256;
> +               length =3D 512;
>
>                 if (!video_device)
>                         continue;
> @@ -1478,13 +1482,18 @@ int acpi_video_get_edid(struct acpi_device *devic=
e, int type, int device_id,
>
>                 if (ACPI_FAILURE(status) || !buffer ||
>                     buffer->type !=3D ACPI_TYPE_BUFFER) {
> -                       length =3D 128;
> -                       status =3D acpi_video_device_EDID(video_device, &=
buffer,
> -                                                       length);
> -                       if (ACPI_FAILURE(status) || !buffer ||
> -                           buffer->type !=3D ACPI_TYPE_BUFFER) {
> -                               continue;
> +                       while (length) {

I would prefer a do {} while () loop here, which could include the
first invocation of acpi_video_device_EDID() too (and reduce code
duplication a bit).

> +                               length -=3D 128;
> +                               status =3D acpi_video_device_EDID(video_d=
evice, &buffer,
> +                                                               length);

No line break, please.

> +                               if (ACPI_FAILURE(status) || !buffer ||
> +                                   buffer->type !=3D ACPI_TYPE_BUFFER) {
> +                                       continue;
> +                               }
> +                               break;
>                         }
> +                       if (!length)
> +                               continue;
>                 }
>
>                 *edid =3D buffer->buffer.pointer;
> --

