Return-Path: <linux-kernel+bounces-153692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D578AD1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031111C20A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8AB153810;
	Mon, 22 Apr 2024 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfiPqUqJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A2153594;
	Mon, 22 Apr 2024 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802724; cv=none; b=XO5bLakNkrAxPR/28EWh6OcoZa7yrTgGb1UWZy+TW/oEoUs9BzQbq87mLe4O5mRF9tAMbqrjREEtfwvGaSV0sZyNCHBJ52+rlsbXlQ8ngZljVjJat6skme72WJUOTI4m4JURQ0dFEz2hSZhHZ+Iez2lyD7NOKCeSdSLETqldpa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802724; c=relaxed/simple;
	bh=QR/kzCbyaOuRWiYV19PwDbm3SqBRCcpUe7hr5QMI4Do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naQeZ/cdsMzRBOxPOdARr4XHctN9aD0naKujhT/t93E/E1ky9CG9JZDO4fVna5Js8AHgfR05XvixjYylBeDuK7W/z/RDV/W92P97Rn8XQBG+w4ff7CPSFethuB3UWeWNnnEkvPi9+kR7G/iYdvoFxWUzuZQOid3mKTof/guUa70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfiPqUqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9156EC113CC;
	Mon, 22 Apr 2024 16:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713802723;
	bh=QR/kzCbyaOuRWiYV19PwDbm3SqBRCcpUe7hr5QMI4Do=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kfiPqUqJScrWwgk7lkUiivDNZIGJTNbNCOj/OkwFir1rjWyoXaizxSOzuvpziVcX9
	 SNCPqN8pZseb73IbPoFap1GgpLAFILkdQQOhkyH9g7gK2ZBVyJAkuiVdoQfs8rmMLd
	 nJH787eE6Tn9Ini1RY09TFnwC8vqu4OBzO3j8NldoEAkt1VOThuRLaVL4JZkmnlpk9
	 GhEr1kjf2zEkzQndLJqpUR6REoc5sVjHvlZzMm5m8vc6rk3hMLbxfU6gqeZ/j59/MB
	 cxFgdIN+XnEdR2XjVDlxp2Ab7//BObVI5UGwUFS6DctRnXEXktqid4Bb46CRqc+LqL
	 W0m0KJ7Jak42A==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5acf5723325so1082653eaf.0;
        Mon, 22 Apr 2024 09:18:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+J4Ieke1yBKlEq2Su+Rs9Ao+z5Y6gBWmsrS1BmLDGehrRsM0miaOsgyghJF5QOg5+OouLhjPg6erVck/jVwV0TIh6JBXAa9BK+xIrQFWnEeAutMbIsQfPjOxhLdVbfLNzmIWX/PvkKpj/Ott1gNQSdlSBEA5OCDUfRxOr1toInc4HTS8=
X-Gm-Message-State: AOJu0YzteF0jy9N3gd2GrCOGUzvmWJApV2VHzbRGrjeQbcy3fyR1qHbd
	h0TolJNVMVS/0/xyXOLt+FebeJFLwbsddxG5+IOEJwTsrhoeGT5JNWzQ/o6KXfml7W2YF6QBbva
	jJlByIqbuNb88NHu3p1KlGAfpltw=
X-Google-Smtp-Source: AGHT+IFESPYVINFnF2ss/dRaMfKVcLtz/mjOYNrxgkasSqC/INJSn+XkVq/aXneWpbNTIE2SYgqkZ572ytK+cUbbuJE=
X-Received: by 2002:a4a:de19:0:b0:5a7:db56:915c with SMTP id
 y25-20020a4ade19000000b005a7db56915cmr11836041oot.1.1713802722990; Mon, 22
 Apr 2024 09:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713523251.git.robin.murphy@arm.com> <3ae004dfc581fa12fc9432c5008f1225882d5464.1713523251.git.robin.murphy@arm.com>
In-Reply-To: <3ae004dfc581fa12fc9432c5008f1225882d5464.1713523251.git.robin.murphy@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 18:18:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iMY1eKYgcH20Uxd1nW0yZ2xt980ob0Rcb_4n4OONWSZA@mail.gmail.com>
Message-ID: <CAJZ5v0iMY1eKYgcH20Uxd1nW0yZ2xt980ob0Rcb_4n4OONWSZA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI: Retire acpi_iommu_fwspec_ops()
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 6:56=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> Now that iommu_fwspec_init() can signal for probe deferral directly,
> acpi_iommu_fwspec_ops() is unneeded and can be cleaned up.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/scan.c | 30 ++++++------------------------
>  1 file changed, 6 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 9d36fc3dc5ac..d6b64dcbf9a6 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1588,26 +1588,14 @@ int acpi_iommu_fwspec_init(struct device *dev, u3=
2 id,
>         return ret;
>  }
>
> -static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct devic=
e *dev)
> -{
> -       struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> -
> -       return fwspec ? fwspec->ops : NULL;
> -}
> -
>  static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
>  {
>         int err;
> -       const struct iommu_ops *ops;
>
>         /* Serialise to make dev->iommu stable under our potential fwspec=
 */
>         mutex_lock(&iommu_probe_device_lock);
> -       /*
> -        * If we already translated the fwspec there is nothing left to d=
o,
> -        * return the iommu_ops.
> -        */
> -       ops =3D acpi_iommu_fwspec_ops(dev);
> -       if (ops) {
> +       /* If we already translated the fwspec there is nothing left to d=
o */
> +       if (dev_iommu_fwspec_get(dev)) {
>                 mutex_unlock(&iommu_probe_device_lock);
>                 return 0;
>         }
> @@ -1624,16 +1612,7 @@ static int acpi_iommu_configure_id(struct device *=
dev, const u32 *id_in)
>         if (!err && dev->bus)
>                 err =3D iommu_probe_device(dev);
>
> -       /* Ignore all other errors apart from EPROBE_DEFER */
> -       if (err =3D=3D -EPROBE_DEFER) {
> -               return err;
> -       } else if (err) {
> -               dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
> -               return -ENODEV;
> -       }
> -       if (!acpi_iommu_fwspec_ops(dev))
> -               return -ENODEV;
> -       return 0;
> +       return err;
>  }
>
>  #else /* !CONFIG_IOMMU_API */
> @@ -1672,6 +1651,9 @@ int acpi_dma_configure_id(struct device *dev, enum =
dev_dma_attr attr,
>         ret =3D acpi_iommu_configure_id(dev, input_id);
>         if (ret =3D=3D -EPROBE_DEFER)
>                 return -EPROBE_DEFER;
> +       /* Ignore all other errors apart from EPROBE_DEFER */
> +       if (ret)
> +               dev_dbg(dev, "Adding to IOMMU failed: %d\n", ret);
>
>         arch_setup_dma_ops(dev, attr =3D=3D DEV_DMA_COHERENT);
>
> --
> 2.39.2.101.g768bb238c484.dirty
>

