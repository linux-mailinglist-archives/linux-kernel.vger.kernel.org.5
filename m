Return-Path: <linux-kernel+bounces-15558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D48822E1D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EEB285A00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC8E1947D;
	Wed,  3 Jan 2024 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIXl2bRm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690A19461
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA211C433CC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704287941;
	bh=xrx8tAG25cH7qJUEOXQQhYiGgCOyf/FU0c4VMO580+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FIXl2bRmU40SM+N0uVNqENqGSEmxA/xdX6ld5jxaPqdwLMG3ewGgkhCI7K3Kz12si
	 JDHeCzmvWKwoTjhe4qqD50ml52Ii/8rxWi5AWebrKmKV8A+4bUbBDhSHimmhp9f6mw
	 uFw3qbRvwu+MsbdfP58+U5064T2UtvRx3NKvT7sr7m93ZO44sLHwYmRjHqzjJnbNrw
	 8dhG7aOT39MTLqwMyj74XKJUMuuXOjspLIuDFLcj/gts23o9SjD3NK5fpkN87qOo/e
	 conxzgrsI+dLhyvV1x7vHGkCHAiOxWZ71bwYM2FTXy2W+Au68NwwYdAXCYY0qIbic/
	 E5hBRQK0i+dbQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so7513471e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:19:01 -0800 (PST)
X-Gm-Message-State: AOJu0YxZF+Mv6u3bw7y435Z98PICKH6c0fs49o1z+oOfGd7uqynEo2sz
	ixpJO+4TWWjWUX2xnp/Mt8cjYFVRqDc6dii4Wfo=
X-Google-Smtp-Source: AGHT+IGmvQ3Wj7BI5AO2Pa9ENHSsvuxKCcLc5HjPgo+XtDyiQslqoJ33XOnFCPNX8OysQ8jjM99aFjj58RqJyAuSviY=
X-Received: by 2002:a05:6512:1308:b0:50e:84b1:c14 with SMTP id
 x8-20020a056512130800b0050e84b10c14mr6420923lfu.26.1704287939999; Wed, 03 Jan
 2024 05:18:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703596577.git.u.kleine-koenig@pengutronix.de> <4a97c8e6996c9c95244715310b57ce5af6ccb1ad.1703596577.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <4a97c8e6996c9c95244715310b57ce5af6ccb1ad.1703596577.git.u.kleine-koenig@pengutronix.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 3 Jan 2024 14:18:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXELWT1c1iE8u5yCNBUJBUGsxfFeKsSYXWQHRNMiOum2Ug@mail.gmail.com>
Message-ID: <CAMj1kXELWT1c1iE8u5yCNBUJBUGsxfFeKsSYXWQHRNMiOum2Ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] virt: efi_secret: Convert to platform remove callback
 returning void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Dov Murik <dovmurik@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>, 
	kernel@pengutronix.de, Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Dec 2023 at 14:28, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/virt/coco/efi_secret/efi_secret.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/virt/coco/efi_secret/efi_secret.c b/drivers/virt/coc=
o/efi_secret/efi_secret.c
> index e700a5ef7043..cd29e66b1543 100644
> --- a/drivers/virt/coco/efi_secret/efi_secret.c
> +++ b/drivers/virt/coco/efi_secret/efi_secret.c
> @@ -326,16 +326,15 @@ static int efi_secret_probe(struct platform_device =
*dev)
>         return ret;
>  }
>
> -static int efi_secret_remove(struct platform_device *dev)
> +static void efi_secret_remove(struct platform_device *dev)
>  {
>         efi_secret_securityfs_teardown(dev);
>         efi_secret_unmap_area();
> -       return 0;
>  }
>
>  static struct platform_driver efi_secret_driver =3D {
>         .probe =3D efi_secret_probe,
> -       .remove =3D efi_secret_remove,
> +       .remove_new =3D efi_secret_remove,
>         .driver =3D {
>                 .name =3D "efi_secret",
>         },
> --
> 2.43.0
>

