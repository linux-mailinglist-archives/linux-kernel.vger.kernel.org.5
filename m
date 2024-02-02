Return-Path: <linux-kernel+bounces-50102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40EA847442
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609872856CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F55149009;
	Fri,  2 Feb 2024 16:07:58 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A09148FFA;
	Fri,  2 Feb 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890077; cv=none; b=qHr5aU48wO9THBnRkPjmzmWZrzOnh+Dj3mG41pFnjHsBkzyo2m04QG67CZ/M7K3uBQI44yl+XIJVR3VP+4Mb43vEEoELqPSmpkzfnW69HPxCU5Jjwsb8V9Bp0jaiKvclYT88RNyVrbhYVjHhLyxl757bIZKf4EVKjAm8SguBtqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890077; c=relaxed/simple;
	bh=toIr2Gupe62vewAZwbK/fjTgniJjMpgiTSEBbricQCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFv3mKFSSln39vZmRVqtzyoIgYFWVTecIJ9CpbFB0JB8/QPReyU9N1ryQGItz/naxrO2QGxrdBkPDk5jj+2hCWf+wIshJ70Pa6gft0I7lw+zhrwqdcPjdlteYMJRU5gNOVAuAUV3hrulJaZcHIZNQurR+FfAMYk/lB/JXjyomLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-218e7bb0034so295090fac.0;
        Fri, 02 Feb 2024 08:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706890075; x=1707494875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgmWK92TTcJysPwanSYXl5F0rKzCcp+c4VYB7wg/duc=;
        b=CD7VTe1cW+8DWSGCHUzTUFZxdj947TSK5Ug9ntdvhPdxNRIUME49cY1oS8A8tH9+Tx
         U7XSEi/cuoK05mf6UwrQYkDqcFqks6r+TtizIn3DZ43YpID9bNp9GCKGqy8taqYjaj9p
         S84ry3so0aqxvIqFrX40pXCIHaIv78uN7ghB9UkYLHEtdhttRzA+Pqra/KehqYtorTzF
         qzEjU1raaQviee0KHi+ruNaeA7yddvzPw4q7TvPG/4l6Q/x+ujub7Oahnwfo+313qGds
         ZNbdeSenVZLMhtUZe+uE/F7QOQKADx2gOdw5L2R7z7ryEFwD/QxoByLWJ38gpMTe1Rb5
         eyLg==
X-Gm-Message-State: AOJu0Yz/POn+64czrc8trW8iO8bocejjZd1rfpbXK+tQKHV676HdoGA1
	YIyDN6IzHSRITDtBJ7W7FwPUyKPm5RUG4s+eQIO7YmlFdu3GuDvyk30elVpyLY9DhHUiTr4TQcA
	MHFfoYTK0MB7q39/iNuKgUVYgfYg=
X-Google-Smtp-Source: AGHT+IGuc57FvMYh/0xMC6KLl2NrvuWobBAsMype57vT1hgZsxVguNxvcJbjoc6y0gvTg0Vdy/ZmxN3RF7B4mSH4f3s=
X-Received: by 2002:a05:6870:d14d:b0:218:ee9c:11b6 with SMTP id
 f13-20020a056870d14d00b00218ee9c11b6mr5491841oac.3.1706890073813; Fri, 02 Feb
 2024 08:07:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201221119.42564-1-mario.limonciello@amd.com> <20240201221119.42564-2-mario.limonciello@amd.com>
In-Reply-To: <20240201221119.42564-2-mario.limonciello@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Feb 2024 17:07:41 +0100
Message-ID: <CAJZ5v0iw3PLB4W0QNmRCgK2AWxe5A7wxnWSz-Jm--Mb=fnugEw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ACPI: video: Handle fetching EDID that is longer
 than 256 bytes
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, "open list:ACPI" <linux-acpi@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 11:11=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The ACPI specification allows for an EDID to be up to 512 bytes but
> the _DDC EDID fetching code will only try up to 256 bytes.
>
> Modify the code to instead start at 512 bytes and work it's way
> down instead.
>
> As _DDC is now called up to 4 times on a machine debugging messages
> are noisier than necessary.  Decrease from info to debug.
>
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extension=
s/output-device-specific-methods.html#ddc-return-the-edid-for-this-device
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

or I can apply it if that's preferred.

Thanks!

> ---
> v1->v2:
>  * Use for loop for acpi_video_get_edid()
>  * Use one of Rafael's suggestions for acpi_video_device_EDID()
>  * Decrease message level too
> ---
>  drivers/acpi/acpi_video.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 4afdda9db019..3bfd013e09d2 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -625,12 +625,9 @@ acpi_video_device_EDID(struct acpi_video_device *dev=
ice,
>
>         if (!device)
>                 return -ENODEV;
> -       if (length =3D=3D 128)
> -               arg0.integer.value =3D 1;
> -       else if (length =3D=3D 256)
> -               arg0.integer.value =3D 2;
> -       else
> +       if (!length || (length % 128))
>                 return -EINVAL;
> +       arg0.integer.value =3D length / 128;
>
>         status =3D acpi_evaluate_object(device->dev->handle, "_DDC", &arg=
s, &buffer);
>         if (ACPI_FAILURE(status))
> @@ -641,7 +638,8 @@ acpi_video_device_EDID(struct acpi_video_device *devi=
ce,
>         if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER)
>                 *edid =3D obj;
>         else {
> -               acpi_handle_info(device->dev->handle, "Invalid _DDC data\=
n");
> +               acpi_handle_debug(device->dev->handle,
> +                                "Invalid _DDC data for length %ld\n", le=
ngth);
>                 status =3D -EFAULT;
>                 kfree(obj);
>         }
> @@ -1447,7 +1445,6 @@ int acpi_video_get_edid(struct acpi_device *device,=
 int type, int device_id,
>
>         for (i =3D 0; i < video->attached_count; i++) {
>                 video_device =3D video->attached_array[i].bind_info;
> -               length =3D 256;
>
>                 if (!video_device)
>                         continue;
> @@ -1478,18 +1475,14 @@ int acpi_video_get_edid(struct acpi_device *devic=
e, int type, int device_id,
>                         continue;
>                 }
>
> -               status =3D acpi_video_device_EDID(video_device, &buffer, =
length);
> -
> -               if (ACPI_FAILURE(status) || !buffer ||
> -                   buffer->type !=3D ACPI_TYPE_BUFFER) {
> -                       length =3D 128;
> +               for (length =3D 512; length > 0; length -=3D 128) {
>                         status =3D acpi_video_device_EDID(video_device, &=
buffer,
>                                                         length);
> -                       if (ACPI_FAILURE(status) || !buffer ||
> -                           buffer->type !=3D ACPI_TYPE_BUFFER) {
> -                               continue;
> -                       }
> +                       if (ACPI_SUCCESS(status))
> +                               break;
>                 }
> +               if (!length)
> +                       continue;
>
>                 *edid =3D buffer->buffer.pointer;
>                 return length;
> --
> 2.34.1
>

