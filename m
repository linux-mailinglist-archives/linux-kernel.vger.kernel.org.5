Return-Path: <linux-kernel+bounces-132027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E57898EED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500411F263E0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5DE134413;
	Thu,  4 Apr 2024 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWSU8WaK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8051339A5;
	Thu,  4 Apr 2024 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258561; cv=none; b=FpczNlN3nEOXdI8rlunEs8T8woUUytXDqlm9xDNsQRf4bZcYBXmGEZI2BzmpXHTUCXfr/XpoKVQvC2i9ShKBBsPaLEjmd2DnlUnAcGnjC5tXHVVh7CdL/R/zDJF3QxL4EzOaH6nYBKnbZ3FwsTUAdGE0/9P+tU0yH9zuWyWwUOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258561; c=relaxed/simple;
	bh=8WNCQA2Qp3GjdSD3VAeio8P6hRuSDdefSKR77rNOC8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APf9owpaQZSHK8wtg1QdyWSCN7DA6qFiBSkx8gD9ysUYGwTvZTTLJPthSSjxY//vwOnWjgqO2g5E8gJeQICDaQuxMGpMXn2fZcHiWTtFeykn4efK5lU265Pag+ynL4m6p0k55L3uEwQZovikMhOZRrvHHWEmJ/gx1rkK6a0xY2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWSU8WaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0C0C433F1;
	Thu,  4 Apr 2024 19:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712258561;
	bh=8WNCQA2Qp3GjdSD3VAeio8P6hRuSDdefSKR77rNOC8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YWSU8WaKnRmHkmA2Fjd6sSysAxBu61BERgRSyepJ2uX9gM1FJnOc2ztLs8Jd9oehi
	 51ZAdLoF3podq9eEO4PUthDZT0l3RKyIpDQPiTKmZ02sR1V/628i80rJklU1RhV3Lx
	 21rWip2WpBgD+7O4wCU5TEL/ouRz3w+LSv8WGR0eHXCf9rHOtaQhfuRcbW9MqclSge
	 mNeDaoN+5PV/MrzhOoN4beQ6AO1/4nODrSHmQjnUQ3EYONZEwlyfoj2MAzgSsLj1cI
	 Mdua8xzVD6/bHvRuxEC0jypCFNNFignItzWnl9FSLxQ+qiWANeYibFkjWPt/cfEys7
	 vpj1JzOtDnPBQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a46b30857bso253327eaf.1;
        Thu, 04 Apr 2024 12:22:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2Esl+5uM5Jomqbcc3RuFjU2w75qLlmzA7T4Xv/9RlT0pJfdHlt1SufOGvJ6zR7SnaMlDuo5hza4yrPzINU2gUvdHZRZlPZBKKYT8Zke0k2tpzj1bP0dZWVb8BHEZGQb+g6TyRLQF8OQ==
X-Gm-Message-State: AOJu0YxkCy3tx9sWgHEqCjBhppfaaAhcdVlwg8IJeYMu0Jg0be5ksdjO
	VXyhbJN0en9NQ60fSkc83KdqJGFrUhnRG7eo62UL/boTK0pX/Fx80v06o1rQXGlIVgNqmtko49a
	D+bn01XmllvSlopPld51i6XZDdZc=
X-Google-Smtp-Source: AGHT+IE3plFIEkphAB8CO7rhbTEJi1S27LAagOoIbFfRCZLahWFxIuVODF8WMjZsqD45ENMVl1mkyHsol77H+i0uEE4=
X-Received: by 2002:a05:6820:f45:b0:5a5:2d09:4fdc with SMTP id
 ep5-20020a0568200f4500b005a52d094fdcmr3357764oob.1.1712258560736; Thu, 04 Apr
 2024 12:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com> <20240325123444.3031851-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240325123444.3031851-4-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Apr 2024 21:22:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g6bn4k2Sv+SRC1fiDoXU+hZ2iUR6GuL5O1Eny=Pxmh0w@mail.gmail.com>
Message-ID: <CAJZ5v0g6bn4k2Sv+SRC1fiDoXU+hZ2iUR6GuL5O1Eny=Pxmh0w@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] ACPI: scan: Replace infinite for-loop with finite while-loop
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 1:34=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The infinite loops is harder to understand (as one has to go
> over the body in order to find main exit conditional) and it's
> more verbose than usual approach with a while-loop.
>
> Note, we may not use list_for_each_entry_safe() as there is locking
> involved and the saved pointer may become invalid behind our back.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/scan.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 7c157bf92695..5e4118970285 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -530,15 +530,10 @@ static DEFINE_MUTEX(acpi_device_del_lock);
>
>  static void acpi_device_del_work_fn(struct work_struct *work_not_used)
>  {
> -       for (;;) {
> -               struct acpi_device *adev;
> +       struct acpi_device *adev;
>
> -               mutex_lock(&acpi_device_del_lock);
> -
> -               if (list_empty(&acpi_device_del_list)) {
> -                       mutex_unlock(&acpi_device_del_lock);
> -                       break;
> -               }
> +       mutex_lock(&acpi_device_del_lock);
> +       while (!list_empty(&acpi_device_del_list)) {
>                 adev =3D list_first_entry(&acpi_device_del_list,
>                                         struct acpi_device, del_list);
>                 list_del(&adev->del_list);
> @@ -555,7 +550,10 @@ static void acpi_device_del_work_fn(struct work_stru=
ct *work_not_used)
>                  */
>                 acpi_power_transition(adev, ACPI_STATE_D3_COLD);
>                 acpi_dev_put(adev);
> +
> +               mutex_lock(&acpi_device_del_lock);
>         }
> +       mutex_unlock(&acpi_device_del_lock);
>  }
>
>  /**
> --

I don't quite agree with this one, sorry.

The rest of the series has been applied as 6.10 material.

Thanks!

