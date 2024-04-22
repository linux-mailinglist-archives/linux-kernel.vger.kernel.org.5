Return-Path: <linux-kernel+bounces-153705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BF68AD1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2C31F2168A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F0E153814;
	Mon, 22 Apr 2024 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTK0lZTm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C236810A20;
	Mon, 22 Apr 2024 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803305; cv=none; b=TtdR1LwaZqMMIKsO6hPNRqJBdpHeLtKSYXVb0yTNm20rcpaHih/iWYzFazQa3f4tpDS0iYg+Ho7ghhsGzmxc07cri5cRl5SZtBh8sJcMVD0OTj94d5AqAtiSKqtGhIvFENEd9hvuJK8rhuGsMdgJtgSqJkHVXGiMelPv3w8goHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803305; c=relaxed/simple;
	bh=66/cBFmlCGcwrdzw7ekAtOoVKtVT1ZxKIozsVBVnmyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCrBvzLDwx1w2G25z7HD5/tpuM4ehmEJao0ZPCLR3lJ8M938qM9oXYwzwYIsGRcKd7w8F/8HtgiBZdevejJq8rT1L7KiXS3KKZAXUfjvMFj2SC3Fix7EngP/u6miuxZmYDS9RGS4DmeKiBWpBiRuXblaszlUmvuIzD75Wtu/edY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTK0lZTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6681DC32781;
	Mon, 22 Apr 2024 16:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713803305;
	bh=66/cBFmlCGcwrdzw7ekAtOoVKtVT1ZxKIozsVBVnmyo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eTK0lZTmmwWsyiz1HcXff3mazwSmdP+zt51MNmwzrLvJtZP1HMFTgB9tSryGkgFvx
	 hcOQIdc6JAt0iNKHpOkjiW985Pk6QVUKKkxmGjqaSvieRnjbTnfD8CXdBj9H99mSJg
	 6NZIZ2GK08dhcIPEbLz/Cqym4WnruYwFVgodmn3eXpY8TUTc6ybybB23qxxcD2/qF3
	 Wuqi3D+bkclD6mfnUk8eYLv8r+2LZRhqH/L8EcOUErKUFyf9K6Ql7i8t8gOGHHMH/t
	 18e3kMeEK/ImwJT2ueQt4ok8C636HVR+Hog2D3cX1RGm49UIOm6W4Q2HDGa60ukg6h
	 F6rfwH95BZFHQ==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6eb7a4d64e8so1216439a34.0;
        Mon, 22 Apr 2024 09:28:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXet4YqYxUIoeVYudhZk8/Je7Cdv3tSMP8KjTPwx8mGoRgRHHQMxOm97IR5wvfzk7EsRqvIyXloP8ouplbBPlDHLWYAhWTBMFay5K9QlHJseTEeqby5nHkQPuRkftpZD0yKd/VLQF3Xw==
X-Gm-Message-State: AOJu0YwPZ1jNgpsel+l6LNvoLyU2kTwb3jKuoVRjxa0vKUpRs2lFxZAN
	Jg+yudCqMyYdsbF7XNk3TMpyBU++lsjRu2ZdlfTdIet8hCyUwhqKT7zRqOgrWrJJwSPe41b1Lh+
	rxDN6QRiFZw2VGFkLNfeF9ZRz9RQ=
X-Google-Smtp-Source: AGHT+IFUoTW+hFhGOBAAdye1VAeZc0XqJPoLFx9aRWabwhUzqbp/a/CO2k9v/59odbPNudADRfSC8msB/tESzbwfyMI=
X-Received: by 2002:a05:6820:e07:b0:5aa:14ff:4128 with SMTP id
 el7-20020a0568200e0700b005aa14ff4128mr10664225oob.1.1713803304702; Mon, 22
 Apr 2024 09:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422080437.912886-1-wse@tuxedocomputers.com>
In-Reply-To: <20240422080437.912886-1-wse@tuxedocomputers.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 18:28:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLjEsjzOU+0it9=NVoqzsrErz1Fs_eVQg-sJgXVqf8jQ@mail.gmail.com>
Message-ID: <CAJZ5v0iLjEsjzOU+0it9=NVoqzsrErz1Fs_eVQg-sJgXVqf8jQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: resource: Do IRQ override on TongFang GXxHRXx
 and GMxHGxx
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Christoffer Sandberg <cs@tuxedo.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 10:04=E2=80=AFAM Werner Sembach <wse@tuxedocomputer=
s.com> wrote:
>
> From: Christoffer Sandberg <cs@tuxedo.de>
>
> Listed devices need the override for the keyboard to work.
>
> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/acpi/resource.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 59423fe9d0f29..6cc8572759a3d 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -630,6 +630,18 @@ static const struct dmi_system_id irq1_edge_low_forc=
e_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "X565"),
>                 },
>         },
> +       {
> +               /* TongFang GXxHRXx/TUXEDO InfinityBook Pro Gen9 AMD */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GXxHRXx"),
> +               },
> +       },
> +       {
> +               /* TongFang GMxHGxx/TUXEDO Stellaris Slim Gen1 AMD */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
> +               },
> +       },
>         { }
>  };
>
> --

Applied as 6.10 material, thanks!

