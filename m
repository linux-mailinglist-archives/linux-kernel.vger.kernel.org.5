Return-Path: <linux-kernel+bounces-81938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C81867C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A431F298EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DD412D765;
	Mon, 26 Feb 2024 16:49:43 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15B12CDB8;
	Mon, 26 Feb 2024 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966183; cv=none; b=HhnoibVq/854MVEe4AjrotlwnJ1p/uFJbNMO3iD4L+gGHrDhsG4dWkofMSqbN/NecMkcXSB/onwuTJYFhMLeh0Ik1pyxWExdSEklLB6pbfm4/i4fnLcbf+xojOhVJlPh0KB8JwYeQW2lM7lHZKbshmqdOV43Gc38Nj6scl7kzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966183; c=relaxed/simple;
	bh=CC8Bq496gBK0CbLLvpBBLkKHW8DXcXn0l6RFjvn84dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZ+HCN38WFQtRGwg54SLIRYSW6CjaJmF+LkcjwhujaJixykbFRnS1W2sHIeJqZCHpV878EoK+7iUKhTHLLXcjaLeetwnHtMZJQ/86qNB3ox/tbcFG/rnrvWF2zlgIKP9DTBifr+gJTICVhxngopan831Mz7bWthJT0b/qan4mwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59fc31c57easo1118768eaf.1;
        Mon, 26 Feb 2024 08:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708966181; x=1709570981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6auEU26+vrivbR5NR8j7v17Mmzz73LvUwHdwC5AeGQI=;
        b=OAvrJH7nrH+LBpnk81rIE6CXBSzWAoLIm2SIwQq4Td8ZaibsTXUZVqmWpacwxDdjCo
         5FJN3t8ifF9ptfm2IKTunY9aKKL8WenmrA3X56GRJ6Uj94672nklD8CrgZX4j59BNdWG
         EPiaYei7SOhfmQXL50IiWqkMJ736gMdD+w4ceWLFkvj0IIcYaAq6HdpsKjmK+XExpKl2
         ILKQJ3xXMKhxXoS2ZzCCe8xfPCH6Ow9ZhJYgJPO4qWSFsz2DAhLX8WgMee2N8eytE+z6
         OGKW/Xfgsltz1ArZ/Ixlox9gFFZg1zXW72nLtKlVHmDKS3hh8E4bNO5UFQWI1w3gZXwT
         IZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgrAtDCHjAib0yfTYpF7QmOpFx/yKbLSzOStPpTxxpCVMjvTO81eS8OcSYhomh4yYeZTugt4epIjRWUnnYqQwmdnwA7O49ULXUnoc3
X-Gm-Message-State: AOJu0YzgORBijK5sMRLtNxjz1/fXx1La/ZczLoTM3k34Ai9MWMUfzifC
	ipuhGupJmM5ZqZStQ5JTmUvqehD4wo3EJRt5hdOus2l+laZJPz5bNVc0f6X5p3nSNDdP3pML1QF
	+7fhrSEG6pzJ8J7otTWLb+k/hFZQ=
X-Google-Smtp-Source: AGHT+IF2JQco6zQ78x+kKOkBl2hjfXBvWl2zy1rri4zCpwQhTQK5Go5bYKfIaVFZrCNjNDYo5dR0t5I1Qcxzy4qw5Ek=
X-Received: by 2002:a4a:d996:0:b0:5a0:4216:c5f0 with SMTP id
 k22-20020a4ad996000000b005a04216c5f0mr6957887oou.0.1708966180928; Mon, 26 Feb
 2024 08:49:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6021126.lOV4Wx5bFT@kreacher> <2175138.irdbgypaU6@kreacher>
In-Reply-To: <2175138.irdbgypaU6@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Feb 2024 17:49:29 +0100
Message-ID: <CAJZ5v0hbSMQVaBry_hye9wrEOjMq2_anhbV0B48eTF8FWYpFXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] ACPI: scan: Relocate acpi_bus_trim_one()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 5:47=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Relocate acpi_bus_trim_one() (without modifications) so as to avoid the
> need to add a forward declaration of it in a subsequent patch.
>
> No functional changes.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v1 -> v2: Add R-by from Jonathan.

I actually forgot to add the R-bys, but let's assume they are here (no
need to look at the first two patches again).

> ---
>  drivers/acpi/scan.c |   52 ++++++++++++++++++++++++++-------------------=
-------
>  1 file changed, 26 insertions(+), 26 deletions(-)
>
> Index: linux-pm/drivers/acpi/scan.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -244,6 +244,32 @@ static int acpi_scan_try_to_offline(stru
>         return 0;
>  }
>
> +static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
> +{
> +       struct acpi_scan_handler *handler =3D adev->handler;
> +
> +       acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
> +
> +       adev->flags.match_driver =3D false;
> +       if (handler) {
> +               if (handler->detach)
> +                       handler->detach(adev);
> +
> +               adev->handler =3D NULL;
> +       } else {
> +               device_release_driver(&adev->dev);
> +       }
> +       /*
> +        * Most likely, the device is going away, so put it into D3cold b=
efore
> +        * that.
> +        */
> +       acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> +       adev->flags.initialized =3D false;
> +       acpi_device_clear_enumerated(adev);
> +
> +       return 0;
> +}
> +
>  static int acpi_scan_hot_remove(struct acpi_device *device)
>  {
>         acpi_handle handle =3D device->handle;
> @@ -2547,32 +2573,6 @@ int acpi_bus_scan(acpi_handle handle)
>  }
>  EXPORT_SYMBOL(acpi_bus_scan);
>
> -static int acpi_bus_trim_one(struct acpi_device *adev, void *not_used)
> -{
> -       struct acpi_scan_handler *handler =3D adev->handler;
> -
> -       acpi_dev_for_each_child_reverse(adev, acpi_bus_trim_one, NULL);
> -
> -       adev->flags.match_driver =3D false;
> -       if (handler) {
> -               if (handler->detach)
> -                       handler->detach(adev);
> -
> -               adev->handler =3D NULL;
> -       } else {
> -               device_release_driver(&adev->dev);
> -       }
> -       /*
> -        * Most likely, the device is going away, so put it into D3cold b=
efore
> -        * that.
> -        */
> -       acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
> -       adev->flags.initialized =3D false;
> -       acpi_device_clear_enumerated(adev);
> -
> -       return 0;
> -}
> -
>  /**
>   * acpi_bus_trim - Detach scan handlers and drivers from ACPI device obj=
ects.
>   * @adev: Root of the ACPI namespace scope to walk.
>
>
>

