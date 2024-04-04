Return-Path: <linux-kernel+bounces-131270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA5F89858A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38371F22E41
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B3280C03;
	Thu,  4 Apr 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9DHWV28"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3DF7580B;
	Thu,  4 Apr 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712228322; cv=none; b=HZCTI4OD4cXCUool0lTAxNavUjZATDHrRFmLgTeeYnHuIjKnIxhxuvtmZxirWJR731E2yVk9K0AfwEO32ZZKpbuSPqpYE5dbPASeqv3jmamvQN6Qq6W4/ndCEt4Qh48ob48rf4l3C+Zk1vvix5lYG8PtSB8D5pxNBZpatzX+RFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712228322; c=relaxed/simple;
	bh=j0/b5icC4/y9iKwybRqd4qGBAgnSIe+hulZQpmzIqSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rb1txrDx8WRkylVol0Z0RdW7DhtZ7M901yav2zDhEVr17A1mKEAa5LR+d4IvSYaIPI7T0cBNlwCP6q2S3Dx/NvzWKE/vp24KDtYziebnlUhsiRBUgsIjUbKhNC1TSjGV3rZXzG5uIKkMBfIgj0uDhbWubkFX44I/uFqAJ/G/FWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9DHWV28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9FAC43390;
	Thu,  4 Apr 2024 10:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712228321;
	bh=j0/b5icC4/y9iKwybRqd4qGBAgnSIe+hulZQpmzIqSI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d9DHWV28feoOxh3KI8vKWHtsPF1BHWx7EsxHL4bHWQkk8Yh9MGbsvn0UTdDi+ZfCu
	 hsflcQeJk3lGvM1hMLTfoU8vxHrvsSCtncL8KL2np6IHpix0meyo1lYp3ikaGwJAqC
	 1NLTIVf3XDbcoNdl6li9B9XQdFWsB8PCwtyuPR8QgeZ7YW7mfsYVA/2Yt/ocP/oKbj
	 2GvDmfmyqGj8A9Zl2VTBJhLIOmg49SqRSn2+tUgd7e3hL8vzP3+AlX6rk+VehkZSBy
	 rATLwFUEsOzp63EivWavqOx6Ok5TVePxVXhBxANE2XSZ+eA9fsSIUHoxp/wBulNbEs
	 Me2MShD2/8mQg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a46b30857bso153283eaf.1;
        Thu, 04 Apr 2024 03:58:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWPzuZfj1F8oSzX78u5WJvup+NygC0NJtBZ5pqLE041bIaGDojyNLBvgcC0TJc1ffIbN7HImCCpQ3xAymkwllGS5FmnNplUQKuTF0NJifNIcnfhxP09hchWJ0Yfixp2SUVwJgMp9OOJdA==
X-Gm-Message-State: AOJu0YwF+a13j8T3V4iTI2w5WSiawmB2RdlzWlQUhfDpoeERV2vIb2wk
	+oJq+K68jtwD22P7M0XY3+gLX8GsUW4l7kyCWpSj4I1mQFEBEr3hczO2xbztGPr/CnudVRHGXC9
	AbafGOZn6Bpf9lBFeZVy9z05eGgY=
X-Google-Smtp-Source: AGHT+IEPyD/Py8AcpOLdageN0KMaqKGHz52ZV2Ws3RRCwPXwIQmpNyzG1+SqfqHWLDkzTS6BEMbw94MHGezgoOVrIVM=
X-Received: by 2002:a4a:ea0f:0:b0:5a2:26c7:397b with SMTP id
 x15-20020a4aea0f000000b005a226c7397bmr1985048ood.0.1712228320933; Thu, 04 Apr
 2024 03:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402152952.3578659-1-andriy.shevchenko@linux.intel.com> <20240402152952.3578659-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240402152952.3578659-3-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Apr 2024 12:58:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iQZXbFQFsZ+gL3==LV7UsqfOr-FZuWdoPSv0veUkuCrQ@mail.gmail.com>
Message-ID: <CAJZ5v0iQZXbFQFsZ+gL3==LV7UsqfOr-FZuWdoPSv0veUkuCrQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ACPI: LPSS: Advertise number of chip selects via property
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 5:30=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Advertise number of chip selects via property for Intel Braswell.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

A Fixes: tag, please?

Also, IIUC this should be applied before
https://lore.kernel.org/linux-acpi/20240403170302.1073841-1-andriy.shevchen=
ko@linux.intel.com/
?

> ---
>  drivers/acpi/acpi_lpss.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 5b56f198d005..a3d2d94be5c0 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -325,6 +325,7 @@ static const struct lpss_device_desc bsw_i2c_dev_desc=
 =3D {
>
>  static const struct property_entry bsw_spi_properties[] =3D {
>         PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_BSW_SSP),
> +       PROPERTY_ENTRY_U32("num-cs", 2),
>         { }
>  };
>
> --
> 2.43.0.rc1.1.gbec44491f096
>

