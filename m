Return-Path: <linux-kernel+bounces-55121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537D984B803
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F5828CB36
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF805132C3A;
	Tue,  6 Feb 2024 14:33:36 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443CD132C03;
	Tue,  6 Feb 2024 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230016; cv=none; b=AvQBtagIgBUfvvmKLwZNeCmUMQHsLRcS0y9R8sb8WUl8eOO/7pb2Zxoqyxq3ErUCUpAN2Q+C/4kBAbaOJlo+BylgRxPBaKT6tQOlx2Yvv2s3zk34QSy9chbTxCBZHOn3+oRJCrxE4wpmRMBFOiAa+Dy5k3D3HuNXWqRB1/0FaRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230016; c=relaxed/simple;
	bh=Ho+zZJ+fFWW2wrgVi5HTon5XJ9hEqQkusUioHHRFjLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHY/KOXGcpihMTaNTIdNMnVPXGWSG8U1EX/Q2wdZ/+0AX9c1S5IhCo1ylujc/NBxtEfZVKA21xmoX8oYu14cVZekCTazR2mFPmULSiCwub62BFtVB6olVsYhOa0cNERQ4YyyO/JUFyUsC2mJNYX3KZdSagiOL+Z/iPDtgf58wec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3bda4bd14e2so4966893b6e.2;
        Tue, 06 Feb 2024 06:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230012; x=1707834812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BundUjCcx7pKYspUOyx7ysCGjqc0ugPb6Aqc2/AHQw8=;
        b=H6GLfPZqooXRK4ekMduIyhCNioOp4xeTxMgCRDBwlemKHsuI6uGuSPsUdrY7f96C63
         Hdvkjud/8syapKl64r9ZjlOW1yoJ0TFdNWJDDlaoi7mptrRQJIh+VgkdA6mY6tErKNjx
         OIQJk6WOYr1cwkM1ZNEjKTV2xtdtJj6dN6LMo+l083PA8vXQDBDi9gHUq5fNZbssMHoL
         sksOL8MywvpIyzu5ikvxDq9GqRLQ2/4wUP/FVJUFFoNnFEcLgDFNZFwtk3G6lGrbpjmz
         7aKSuYpF90fFckFqqBJ2xuZ1atf9koqzxY0h0i1NqXNEB2NkNIn+aCLWnQhlq4N7sjHc
         rycg==
X-Gm-Message-State: AOJu0Yy2NgjjY9ldAGSe9Tr7xZ61sT0JNR3MfP2fWFpk9njGsAUfhBEl
	of6jquWnSGe3QV/0glhNexqppi6XjZzjd32KhY4+3QebdtY2mamWHq3zZynmTtg=
X-Google-Smtp-Source: AGHT+IGjuM/ax3u5AYYXYwidhU8xdDuJv0JAxVtYUcNZO1KF/VL/VrciXu4NW5F2bXG8WrPAJpA1Xw==
X-Received: by 2002:a05:6808:15:b0:3bf:ce2e:c4b2 with SMTP id u21-20020a056808001500b003bfce2ec4b2mr2563462oic.50.1707230012523;
        Tue, 06 Feb 2024 06:33:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWbRps58kUWH8Lfy1bdXNkX9Q9kr0bPHsSJH2G3tBOU62mZGHmsVeOexi5P7/ehujkKjevjfzwvPci0WaxoGyKld/6lYODHdUnGHFqpyhzWFp0kFmvmmgt34kkHaxWIAQvobdDCnHB4
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id u5-20020a056808114500b003bfc9eaca96sm317313oiu.27.2024.02.06.06.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 06:33:32 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e117e0fee8so2971250a34.2;
        Tue, 06 Feb 2024 06:33:32 -0800 (PST)
X-Received: by 2002:a05:6830:4d0:b0:6e1:11be:221e with SMTP id
 s16-20020a05683004d000b006e111be221emr2440070otd.27.1707230012027; Tue, 06
 Feb 2024 06:33:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105114956.30714-1-niko.mauno@vaisala.com> <20240105114956.30714-2-niko.mauno@vaisala.com>
In-Reply-To: <20240105114956.30714-2-niko.mauno@vaisala.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 6 Feb 2024 15:33:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy793gzDVR0jfNnx5TUdJ_2MKH5NPGSgHkytAhArtqmw@mail.gmail.com>
Message-ID: <CAMuHMdUy793gzDVR0jfNnx5TUdJ_2MKH5NPGSgHkytAhArtqmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: core: Make default authorization mode configurable
To: niko.mauno@vaisala.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vesa.jaaskelainen@vaisala.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niko,

On Fri, Jan 5, 2024 at 12:51=E2=80=AFPM <niko.mauno@vaisala.com> wrote:
> From: Niko Mauno <niko.mauno@vaisala.com>
>
> Make the default USB device authorization mode configurable at build
> time. This is useful for systems that require a mode that is stricter
> than the standard setting, as it avoids relying on the kernel command
> line being properly set.
>
> Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>

Thanks for your patch, which is now commit bec7e43b162c5879
("usb: core: Make default authorization mode configurable")
in usb/usb-next.

> --- a/drivers/usb/core/Kconfig
> +++ b/drivers/usb/core/Kconfig
> @@ -116,3 +116,20 @@ config USB_AUTOSUSPEND_DELAY
>           The default value Linux has always had is 2 seconds.  Change
>           this value if you want a different delay and cannot modify
>           the command line or module parameter.
> +
> +config USB_DEFAULT_AUTHORIZATION_MODE
> +       int "Default authorization mode for USB devices"
> +       range 0 2
> +       default 1
> +       depends on USB
> +       help
> +         Select the default USB device authorization mode. Can be overri=
dden
> +         with usbcore.authorized_default command line or module paramete=
r.
> +
> +         The available values have the following meanings:
> +               0 is unauthorized for all devices
> +               1 is authorized for all devices (default)
> +               2 is authorized for internal devices
> +
> +         If the default value is too permissive but you are unsure which=
 mode
> +         to use, say 2.

I'm sorry, but I don't have any clue about what to answer to this question.
Usually, you are (or are not) authorized to do _something_, but the
/something/ is not mentioned at all here.
Can you please make this a bit more clear?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

